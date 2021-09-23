﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;
using System.Web.Security;
using Telerik.Reporting.Processing;
using System.IO;
using System.Threading;
using ReportLibrary;
using Telerik.Reporting;
using System.Web.Configuration;

namespace elecion.catalogos.oferta
{
    public partial class catcursos : System.Web.UI.Page
    {
        private int idsucursal;
        private int idusuario;
        int idtipousuario;
        string roles;

        

        protected void bimprimir_Click(object sender, EventArgs e)
        {
            SolicitudAutorizacionCurso reporte = new SolicitudAutorizacionCurso();
            reporte.ReportParameters["idsucursal"].Value = this.idS.Value;
            reporte.ReportParameters["idcurso"].Value = this.idP.Value;
            this.ExportToPDF(reporte, string.Concat("SOLICITUD AUTORIZACION ", this.cve.Value));
        }

        protected void borraFechas(object sender, EventArgs e)
        {
        }

        protected void cancelaCurso(object sender, EventArgs e)
        {
            using (MySqlConnection con = new MySqlConnection(WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {
                MySqlTransaction transaction = null;
                try
                {
                    try
                    {
                        con.Open();
                        MySqlCommand mySqlCommand = con.CreateCommand();
                        transaction = con.BeginTransaction();
                        mySqlCommand.Connection = con;
                        mySqlCommand.Transaction = transaction;
                        mySqlCommand.Parameters.Clear();
                        mySqlCommand.CommandText = "update curso set estatus='CANCELADO' where idcurso=@idcurso;";
                        mySqlCommand.Parameters.AddWithValue("@idcurso", this.idP.Value);
                        mySqlCommand.ExecuteNonQuery();
                        mySqlCommand.Parameters.Clear();
                        mySqlCommand.CommandText = "insert into historialcurso(idcurso, idusuario, fecha, hora, observacion) values(@idcurso, @idusuario, curdate(), curtime(), @observacion); ";
                        mySqlCommand.Parameters.AddWithValue("@idcurso", this.idP.Value);
                        mySqlCommand.Parameters.AddWithValue("@idusuario", this.idusuario);
                        mySqlCommand.Parameters.AddWithValue("@observacion", string.Concat("CANCELACIÓN POR MOTIVO: ", this.motcancelacion.Text.ToUpper()));
                        ///
                        mySqlCommand.ExecuteNonQuery();
                        transaction.Commit();
                        this.listadoClientes(sender, e);
                        ScriptManager.RegisterStartupScript(this, base.GetType(), "myScriptName", "cerrarLoading(); toastExito(); $('#wcancelar').modal('hide');", true);
                    }
                    catch (Exception exception)
                    {
                        Exception ex = exception;
                        transaction.Rollback();
                        Console.WriteLine(string.Concat("error:", ex.ToString()));
                    }
                }
                finally
                {
                    con.Close();
                }
            }
        }

        protected void conteoRegistros(object sender, EventArgs e)
        {
            using (MySqlConnection con2 = new MySqlConnection(WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {
                try
                {
                    try
                    {
                        con2.Open();
                        string query = "SELECT COUNT(c.idcurso) as total FROM curso c where c.tipo='C' and c.estatus not in('CANCELADO') ";
                        if (this.bname.Text.Trim() != "")
                        {
                            query = string.Concat(new string[] { query, " and (c.nombre LIKE '%", this.bname.Text.Trim().ToUpper(), "%' or c.clave LIKE '%", this.bname.Text.Trim().ToUpper(), "%') " });
                        }
                        if (this.roles.IndexOf('1', 0) < 0)
                        {
                            query = string.Concat(new object[] { query, " and c.idsucursal = ", this.idsucursal, " " });
                        }
                        else if (!this.bplantel.SelectedValue.Equals("0"))
                        {
                            query = string.Concat(query, " and c.idsucursal = ", this.bplantel.SelectedValue, " ");
                        }
                        MySqlDataReader rdr = (new MySqlCommand(query, con2)).ExecuteReader();
                        if (rdr.HasRows)
                        {
                            rdr.Read();
                            this.labelConteo.Text = rdr["total"].ToString();
                        }
                    }
                    catch (Exception exception)
                    {
                    }
                }
                finally
                {
                    con2.Close();
                }
            }
        }

        protected void editaRegistro(object sender, EventArgs e)
        {
            this.Session["idP"] = this.idP.Value;
            this.Session["idS"] = this.idS.Value;
            base.Response.Redirect("~/catalogos/directorio/frminstructor.aspx");
        }

        protected void eliminaObjetivo(object sender, EventArgs e)
        {
            using (MySqlConnection con = new MySqlConnection(WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {
                MySqlTransaction transaction = null;
                try
                {
                    try
                    {
                        con.Open();
                        MySqlCommand mySqlCommand = con.CreateCommand();
                        transaction = con.BeginTransaction();
                        mySqlCommand.Connection = con;
                        mySqlCommand.Transaction = transaction;
                        mySqlCommand.Parameters.Clear();
                        mySqlCommand.CommandText = "delete from cursoobjetivo where idobjetivo=@idobjetivo;";
                        mySqlCommand.Parameters.AddWithValue("@idobjetivo", this.idobj.Value);
                        mySqlCommand.ExecuteNonQuery();
                        transaction.Commit();
                        this.listadoObjetivos(sender, e);
                        ScriptManager.RegisterStartupScript(this, base.GetType(), "myScriptName", "cerrarLoading(); toastExito();", true);
                    }
                    catch (Exception exception)
                    {
                        Exception ex = exception;
                        transaction.Rollback();
                        Console.WriteLine(string.Concat("error:", ex.ToString()));
                    }
                }
                finally
                {
                    con.Close();
                }
            }
        }

        private void ExportToPDF(Telerik.Reporting.Report reportToExport, string nombre)
        {
            ReportProcessor reportProcessor = new ReportProcessor();
            InstanceReportSource instanceReportSource = new InstanceReportSource()
            {
                ReportDocument = reportToExport
            };
            RenderingResult result = reportProcessor.RenderReport("PDF", instanceReportSource, null);
            string fileName = string.Concat(nombre, ".", result.Extension);
            base.Response.Clear();
            base.Response.ContentType = result.MimeType;
            base.Response.Cache.SetCacheability(HttpCacheability.Private);
            base.Response.Expires = -1;
            base.Response.Buffer = true;
            base.Response.AddHeader("Content-Disposition", string.Format("{0};FileName=\"{1}\"", "attachment", fileName));
            base.Response.BinaryWrite(result.DocumentBytes);
            base.Response.End();
        }

      

      

        protected void guardaEdita(object sender, EventArgs e)
        {
            int esmovilidad;
            int esenlinea;
            
            using (MySqlConnection con = new MySqlConnection(WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {
                MySqlTransaction transaction = null;
                int idcurso = 0;
                try
                {
                    try
                    {
                        con.Open();
                        MySqlCommand cmd = con.CreateCommand();
                        transaction = con.BeginTransaction();
                        cmd.Connection = con;
                        cmd.Transaction = transaction;
                        if (Convert.ToInt32(this.idP.Value) != 0)
                        {
                            cmd.Parameters.Clear();
                            cmd.CommandText = string.Concat("update curso set clave=@clave, nombre=@nombre, idcicloescolar=(select idcicloescolar from cicloescolar where @fechaini between fechaini and fechafin), idtipocurso=@idtipocurso, idarea=@idarea, idespecialidad=@idespecialidad, idinstructor=@idinstructor, idinstalacion=@idinstalacion, fechaini=@fechaini, fechafin=@fechafin, dias=@dias, horaini=@horaini, horafin=@horafin, horas=@horas,  costomodulo=@costomodulo, costo=@costo, pagohora=@pagohora, observaciones=@observaciones, diascurso=@diascurso, idtipooferta=@idtipooferta, instalacionext=@instalacionext, alumnosminimo=@alumnosminimo, alumnosmaximo=@alumnosmaximo, fechalimite=@fechalimite, instalaciondomext=@instalaciondomext, idcursoregular= @idcursoregular, movilidad=@movilidad, enlinea=@enlinea ", "where idcurso=@idcurso;");
                            cmd.Parameters.AddWithValue("@idcurso", this.idP.Value);
                            //cmd.Parameters.AddWithValue("@idcicloescolar", 1);
                            cmd.Parameters.AddWithValue("@clave", this.clave.Text.ToUpper().Trim());
                            cmd.Parameters.AddWithValue("@nombre", this.nombre.Text.ToUpper().Trim());
                            //cmd.Parameters.AddWithValue("@idtipocurso", this.tipocurso.SelectedValue);
                            //cmd.Parameters.AddWithValue("@idarea", this.area.SelectedValue);
                            //cmd.Parameters.AddWithValue("@idespecialidad", this.especialidad.SelectedValue);
                           // cmd.Parameters.AddWithValue("@idinstructor", this.instructor.SelectedValue);
                            //cmd.Parameters.AddWithValue("@idinstalacion", this.instalacion.SelectedValue);
                            cmd.Parameters.AddWithValue("@fechaini", this.fechaini.Text);
                            cmd.Parameters.AddWithValue("@fechafin", this.fechafin.Text);
                            cmd.Parameters.AddWithValue("@dias", this.dias.Text);
                            cmd.Parameters.AddWithValue("@horaini", this.horaini.Text);
                            cmd.Parameters.AddWithValue("@horafin", this.horafin.Text);
                            cmd.Parameters.AddWithValue("@horas", this.horas.Text);
                            if (this.costomodulo.Text.Equals(""))
                            {
                                cmd.Parameters.AddWithValue("@costomodulo", "0");
                            }
                            else
                            {
                                cmd.Parameters.AddWithValue("@costomodulo", this.costomodulo.Text);
                            }
                            if (this.costoalumno.Text.Equals(""))
                            {
                                cmd.Parameters.AddWithValue("@costo", "0");
                            }
                            else
                            {
                                cmd.Parameters.AddWithValue("@costo", this.costoalumno.Text);
                            }
                            if (this.pagohora.Text.Equals(""))
                            {
                                cmd.Parameters.AddWithValue("@pagohora", "0");
                            }
                            else
                            {
                                cmd.Parameters.AddWithValue("@pagohora", this.pagohora.Text);
                            }
                            cmd.Parameters.AddWithValue("@observaciones", this.observaciones.Text.Trim());
                            cmd.Parameters.AddWithValue("@diascurso", this.hdias.Value);
                            //cmd.Parameters.AddWithValue("@idtipooferta", this.tipooferta.SelectedValue);
                           // cmd.Parameters.AddWithValue("@instalacionext", this.instalacionext.Text.ToUpper().Trim());
                            //cmd.Parameters.AddWithValue("@instalaciondomext", this.instalaciondomext.Text.ToUpper().Trim());
                            cmd.Parameters.AddWithValue("@alumnosminimo", this.alumnosminimo.Text);
                            cmd.Parameters.AddWithValue("@alumnosmaximo", this.alumnosmaximo.Text);
                            cmd.Parameters.AddWithValue("@fechalimite", this.fechalimite.Text);
                           /* if (!this.tipocurso.SelectedValue.Equals("3"))
                            {
                                cmd.Parameters.AddWithValue("@idcursoregular", null);
                            }
                            else
                            {
                                cmd.Parameters.AddWithValue("@idcursoregular", this.regular.SelectedValue);
                            }*/
                           // esmovilidad = (!this.movilidad.Checked ? 0 : 1);
                            //cmd.Parameters.AddWithValue("@movilidad", esmovilidad);
                            esenlinea = (!this.enlinea.Checked ? 0 : 1);
                            cmd.Parameters.AddWithValue("@enlinea", esenlinea);
                            cmd.ExecuteNonQuery();
                        }
                        else
                        {
                            cmd.Parameters.Clear();
                            cmd.CommandText = "insert into curso(idsucursal, idcicloescolar, clave, nombre, idtipocurso, idarea, idespecialidad, idinstructor, idinstalacion, fechaini, fechafin, dias, horaini, horafin, horas, costomodulo, costo, pagohora, observaciones, estatus, pagado, diascurso, idtipooferta, instalacionext, alumnosminimo, alumnosmaximo, fechalimite, instalaciondomext, solicita, autoriza, idcursoregular, tipo, movilidad, enlinea, idoferta) values(@idsucursal, (select idcicloescolar from cicloescolar where @fechaini between fechaini and fechafin), @clave, @nombre, @idtipocurso, @idarea, @idespecialidad, @idinstructor, @idinstalacion, @fechaini, @fechafin, @dias, @horaini, @horafin, @horas, @costomodulo, @costo, @pagohora, @observaciones, 'EN CAPTURA', 0, @diascurso, @idtipooferta, @instalacionext, @alumnosminimo, @alumnosmaximo, @fechalimite, @instalaciondomext, (select encargado from sucursal where idsucursal=@idsucursal), 'PROF. GERSOM PÉREZ RAMÍREZ', @idcursoregular, 'C', @movilidad, @enlinea, (select idofertaeducativa from ofertaeducativa where vigente=1)); ";
                            //cmd.Parameters.AddWithValue("@idcicloescolar", 1);
                            cmd.Parameters.AddWithValue("@idsucursal", this.idsucursal);
                            cmd.Parameters.AddWithValue("@nombre", this.nombre.Text.ToUpper().Trim());
                            cmd.Parameters.AddWithValue("@clave", this.clave.Text.ToUpper().Trim());
                            //cmd.Parameters.AddWithValue("@idtipocurso", this.tipocurso.SelectedValue);
                           // cmd.Parameters.AddWithValue("@idarea", this.area.SelectedValue);
                           // cmd.Parameters.AddWithValue("@idespecialidad", this.especialidad.SelectedValue);
                           // cmd.Parameters.AddWithValue("@idinstructor", this.instructor.SelectedValue);
                           // cmd.Parameters.AddWithValue("@idinstalacion", this.instalacion.SelectedValue);
                            cmd.Parameters.AddWithValue("@fechaini", this.fechaini.Text);
                            cmd.Parameters.AddWithValue("@fechafin", this.fechafin.Text);
                            cmd.Parameters.AddWithValue("@dias", this.dias.Text);
                            cmd.Parameters.AddWithValue("@horaini", this.horaini.Text);
                            cmd.Parameters.AddWithValue("@horafin", this.horafin.Text);
                            cmd.Parameters.AddWithValue("@horas", this.horas.Text);
                            if (this.costomodulo.Text.Equals(""))
                            {
                                cmd.Parameters.AddWithValue("@costomodulo", "0");
                            }
                            else
                            {
                                cmd.Parameters.AddWithValue("@costomodulo", this.costomodulo.Text);
                            }
                            if (this.costoalumno.Text.Equals(""))
                            {
                                cmd.Parameters.AddWithValue("@costo", "0");
                            }
                            else
                            {
                                cmd.Parameters.AddWithValue("@costo", this.costoalumno.Text);
                            }
                            if (this.pagohora.Text.Equals(""))
                            {
                                cmd.Parameters.AddWithValue("@pagohora", "0");
                            }
                            else
                            {
                                cmd.Parameters.AddWithValue("@pagohora", this.pagohora.Text);
                            }
                            cmd.Parameters.AddWithValue("@observaciones", this.observaciones.Text.Trim());
                            cmd.Parameters.AddWithValue("@diascurso", this.hdias.Value);
                           // cmd.Parameters.AddWithValue("@idtipooferta", this.tipooferta.SelectedValue);
                            //cmd.Parameters.AddWithValue("@instalacionext", this.instalacionext.Text.ToUpper().Trim());
                            //cmd.Parameters.AddWithValue("@instalaciondomext", this.instalaciondomext.Text.ToUpper().Trim());
                            cmd.Parameters.AddWithValue("@alumnosminimo", this.alumnosminimo.Text);
                            cmd.Parameters.AddWithValue("@alumnosmaximo", this.alumnosmaximo.Text);
                            cmd.Parameters.AddWithValue("@fechalimite", this.fechalimite.Text);
                            /*if (!this.tipocurso.SelectedValue.Equals("3"))
                            {
                                cmd.Parameters.AddWithValue("@idcursoregular", null);
                            }
                            else
                            {
                                cmd.Parameters.AddWithValue("@idcursoregular", this.regular.SelectedValue);
                            }*/
                           // esmovilidad = (!this.movilidad.Checked ? 0 : 1);
                           // cmd.Parameters.AddWithValue("@movilidad", esmovilidad);
                            esenlinea = (!this.enlinea.Checked ? 0 : 1);
                            cmd.Parameters.AddWithValue("@enlinea", esenlinea);
                            cmd.ExecuteNonQuery();
                            idcurso = (int)cmd.LastInsertedId;
                            this.idP.Value = idcurso.ToString();
                            cmd.Parameters.Clear();
                            cmd.CommandText = "insert into historialcurso(idcurso, idusuario, fecha, hora, observacion) values(@idcurso, @idusuario, curdate(), curtime(), @observacion); ";
                            cmd.Parameters.AddWithValue("@idcurso", this.idP.Value);
                            cmd.Parameters.AddWithValue("@idusuario", this.idusuario);
                            cmd.Parameters.AddWithValue("@observacion", "DADO DE ALTA");
                            cmd.ExecuteNonQuery();
                            this.listadoHistorial(sender, e);
                        }
                        transaction.Commit();
                        this.listadoClientes(sender, e);
                        ScriptManager.RegisterStartupScript(this, base.GetType(), "myScriptName", "cerrarLoading(); toastExito(); $('#bootstrap').modal('hide');", true);
                    }
                    catch (Exception exception)
                    {
                        Exception ex = exception;
                        transaction.Rollback();
                        Console.WriteLine(string.Concat("error:", ex.ToString()));
                    }
                }
                finally
                {
                    con.Close();
                }
            }
        }

      

        protected void guardaObjetivo(object sender, EventArgs e)
        {
            using (MySqlConnection con = new MySqlConnection(WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {
                MySqlTransaction transaction = null;
                try
                {
                    try
                    {
                        con.Open();
                        MySqlCommand cmd = con.CreateCommand();
                        transaction = con.BeginTransaction();
                        cmd.Connection = con;
                        cmd.Transaction = transaction;
                        if (!this.idobj.Value.Equals("0"))
                        {
                            cmd.Parameters.Clear();
                            cmd.CommandText = "update cursoobjetivo set objetivo= @objetivo, clave=@clave where idobjetivo=@idobjetivo;";
                            cmd.Parameters.AddWithValue("@idobjetivo", this.idobj.Value);
                            cmd.Parameters.AddWithValue("@objetivo", this.objetivo.Text.ToUpper());
                            cmd.Parameters.AddWithValue("@clave", this.objetcl.Text.ToUpper());
                        }
                        else
                        {
                            cmd.Parameters.Clear();
                            cmd.CommandText = "insert into cursoobjetivo(idcurso, objetivo, clave) values(@idcurso, @objetivo, @clave);";
                            cmd.Parameters.AddWithValue("@idcurso", this.idP.Value);
                            cmd.Parameters.AddWithValue("@objetivo", this.objetivo.Text.ToUpper());
                            cmd.Parameters.AddWithValue("@clave", this.objetcl.Text.ToUpper());
                        }
                        cmd.ExecuteNonQuery();
                        transaction.Commit();
                        this.listadoObjetivos(sender, e);
                        ScriptManager.RegisterStartupScript(this, base.GetType(), "myScriptName", "cerrarLoading(); toastExito(); $('#wobjetivo').modal('hide');", true);
                    }
                    catch (Exception exception)
                    {
                        Exception ex = exception;
                        transaction.Rollback();
                        Console.WriteLine(string.Concat("error:", ex.ToString()));
                    }
                }
                finally
                {
                    con.Close();
                }
            }
        }

        protected void gUsuarios_RowCreated(object sender, GridViewRowEventArgs e)
        {
        }

        protected void gUsuarios_SelectedIndexChanged(object sender, EventArgs e)
        {
        }

        protected void imprimirListaAsistencia(object sender, EventArgs e)
        {
           /* int mesint = 0;
            int anio = 0;
            string[] strArrays = this.mes.SelectedValue.Split(new char[] { '|' });
            mesint = Convert.ToInt32(strArrays[0]);
            anio = Convert.ToInt32(strArrays[1]);
            Asistencia reporte = new Asistencia();
            reporte.ReportParameters["idsucursal"].Value = this.idS.Value;
            reporte.ReportParameters["idcurso"].Value = this.idP.Value;
            reporte.ReportParameters["mes"].Value = mesint;
            //reporte.ReportParameters["mesText"].Value = this.mes.SelectedItem.Text;
            reporte.ReportParameters["anio"].Value = anio;
            this.ExportToPDF(reporte, string.Concat("LISTA ASISTENCIA ", this.cve.Value, " ", this.mes.SelectedItem.Text));*/
        }

        protected void imprimirRIADC(object sender, EventArgs e)
        {
            RIACD reporte = new RIACD();
            reporte.ReportParameters["idsucursal"].Value = this.idS.Value;
            reporte.ReportParameters["idcurso"].Value = this.idP.Value;
            this.ExportToPDF(reporte, string.Concat("RIADC-02 Inscripción ", this.cve.Value));
        }

        protected void imprimirRIADCAcred(object sender, EventArgs e)
        {
            RIACDAcreditacion reporte = new RIACDAcreditacion();
            reporte.ReportParameters["idsucursal"].Value = this.idS.Value;
            reporte.ReportParameters["idcurso"].Value = this.idP.Value;
            this.ExportToPDF(reporte, string.Concat("RIADC-02 Acreditación ", this.cve.Value));
        }


        protected void imprimirSubObjetivos(object sender, EventArgs e)
        {
            SubObjetivos reporte = new SubObjetivos();
            reporte.ReportParameters["idsucursal"].Value = this.idS.Value;
            reporte.ReportParameters["idcurso"].Value = this.idP.Value;
            this.ExportToPDF(reporte, string.Concat("RESD-05 SubObjetivos ", this.cve.Value));
        }

        protected void insertaFechas(object sender, EventArgs e)
        {
        }

        protected void instalacion_SelectedIndexChanged(object sender, EventArgs e)
        {
            
        }

        protected void limpiarCampos(object sender, EventArgs e)
        {
            string json = "";
            string bloqueo = "";
            try
            {
                using (MySqlConnection con = new MySqlConnection(WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
                {
                    con.Open();
                    MySqlDataReader rdr = null;
                    rdr = (new MySqlCommand("select idofertaeducativa from ofertaeducativa where vigente=1;", con)).ExecuteReader();
                    if (rdr.HasRows)
                    {
                        while (rdr.Read())
                        {
                            this.idOE.Value = rdr["idofertaeducativa"].ToString();
                        }
                    }
                    rdr.Close();
                }
                this.idP.Value = "0";
                this.clave.Text = "";
                this.nombre.Text = "";
                
               
                this.fechalimite.Text = "";
                this.fechaini.Text = "";
                this.fechafin.Text = "";
                this.dias.Text = "";
                this.horaini.Text = "";
                this.horafin.Text = "";
                this.horas.Text = "";
                this.costomodulo.Text = "";
                this.costoalumno.Text = "";
                this.pagohora.Text = "";
                this.observaciones.Text = "";
                this.hdias.Value = "";
                alumnosmaximo.Text = "";
                alumnosminimo.Text = "";
               

                json = "[]";
                this.alumnosminimo.Text = "";
                //this.divreg.Visible = false;
                bloqueo = "$('#tbgenerales').removeAttr('disabled');";
                bloqueo = string.Concat(bloqueo, "$('#tbcostoss *').removeAttr('disabled');");
                bloqueo = string.Concat(bloqueo, "$('#tbhorario *').removeAttr('disabled');");
                bloqueo = string.Concat(bloqueo, "$('#bproponer *').show();");
                bloqueo = string.Concat(bloqueo, "$('#bguardar *').show();");
                bloqueo = string.Concat(bloqueo, "$('#accesoenlinea *').hide();");
                
                this.listadoAlumnos(sender, e);
                this.listadoHistorial(sender, e);
                this.listadoObjetivos(sender, e);
            }
            catch (Exception exception)
            {
            }
            ScriptManager.RegisterStartupScript(this, base.GetType(), "myScriptName", string.Concat("cerrarLoading(); $('#tabgenerales').click(); $('#bootstrap').modal('show');  $('#fc-basic-views').fullCalendar('render'); dar(); ", bloqueo) ?? "", true);
            ScriptManager.RegisterStartupScript(this, base.GetType(), "inicilizarMun", string.Concat("dataEvent =", json), true);
        }

        protected void listadoAlumnos(object sender, EventArgs e)
        {
            try
            {
                this.GValumnos.DataSourceID = this.DSalumnos.ID;
                string query = string.Concat("select concat(al.apaterno,' ', al.amaterno,' ', al.nombre)as nombrealumno, case si.becado when 1 then round(c.costo -c.costo * (si.porcentaje / 100),2) else c.costo end as costoalumno, si.folio,  cast(si.fecha as char)as fecha, si.observaciones as observacionesalumno  from alumno al  left join solicitudinscripcion si on si.idalumno = al.idalumno  left join curso c on si.idcurso = c.idcurso  where si.idcurso = ", this.idP.Value, " and si.estatus not in('CANCELADO')  order by nombrealumno");
                this.DSalumnos.SelectCommand = query;
            }
            catch (Exception exception)
            {
            }
        }

        

        protected void listadoClientes(object sender, EventArgs e)
        {
            Convert.ToInt32(this.limite.Value);
            int pag = 1;
            try
            {
               
                

                this.lGeneral.DataSourceID = this.DsUsuarios.ID;
                string query = "select b.*, e.estado, c.centro, cast(b.fechaalta as char)as fechaaltatext from bien b left join estado e on b.idestado = e.idestado left join centro c on c.idcentro = b.idcentro ";
                if (this.bname.Text.Trim() != "")
                {
                    query = string.Concat(new string[] { query, " and (c.nombre LIKE '%", this.bname.Text.Trim().ToUpper(), "%' or c.clave LIKE '%", this.bname.Text.Trim().ToUpper(), "%') " });
                }
               
               

                query = string.Concat(query, " order by b.noinventario ");
                this.DsUsuarios.SelectCommand = query;

                DataView dvAccess = (DataView)DsUsuarios.Select(DataSourceSelectArguments.Empty);

                if (dvAccess!=null && dvAccess.Count > 0)
                {
                    labelConteo.Text = dvAccess.Count.ToString();
                    divNoRegistros.Visible = false;
                }

                else
                {
                    labelConteo.Text = "0";
                    divNoRegistros.Visible = true;
                }


            }
            catch (Exception exception)
            {
            }
        }

        

        protected void listadoFechas(object sender, EventArgs e)
        {
            string json = "";
            string bloqueo = "";
            try
            {
                using (MySqlConnection con = new MySqlConnection(WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
                {
                    con.Open();
                    MySqlDataReader rdr = (new MySqlCommand(string.Concat("select c.idcurso, c.idsucursal, c.clave, c.nombre, c.estatus, a.area,  e.especialidad,  i.nombre as instructor, t.tipocurso, c.estatus,  cast(c.fechaini as char)as fechaini, cast(c.fechafin as char)as fechafin, cast(TIME_FORMAT(c.horaini, '%h:%i %p') as char)as horaini, cast(TIME_FORMAT(c.horafin, '%h:%i %p') as char)as horafin,  cast(TIME_FORMAT(horaini, '%H:%i ')as char)as horainif, cast(TIME_FORMAT(horafin, '%H:%i ')as char)as horafinf, c.horas, c.dias, c.idtipocurso, c.idarea, c.idespecialidad, c.idinstructor, c.idinstalacion, c.observaciones, c.costo, c.costomodulo, c.pagohora, c.diascurso, c.idtipooferta, c.instalacionext, c.alumnosminimo,  c.alumnosmaximo, cast(c.fechalimite as char)as fechalimite, c.instalaciondomext, c.idcursoregular, c.idofertaeducativa, c.movilidad, c.enlinea from curso c left join area a on a.idarea = c.idarea left join especialidad e on e.idespecialidad = c.idespecialidad left join tipocurso t on t.idtipocurso = c.idtipocurso left join instructor i on i.idinstructor = c.idinstructor where c.idcurso = ", this.idP.Value, " "), con)).ExecuteReader();
                    if (rdr.HasRows)
                    {
                        rdr.Read();
                        string ad = rdr["idarea"].ToString();
                        string es = rdr["idespecialidad"].ToString();
                        this.idOE.Value = rdr["idofertaeducativa"].ToString();
                        this.clave.Text = rdr["clave"].ToString();
                        this.cve.Value = this.clave.Text;
                        this.nombre.Text = rdr["nombre"].ToString();
                       
                        
                        this.fechaini.Text = rdr["fechaini"].ToString();
                        this.fechafin.Text = rdr["fechafin"].ToString();
                        this.dias.Text = rdr["dias"].ToString();
                        this.horaini.Text = rdr["horainif"].ToString();
                        this.horafin.Text = rdr["horafinf"].ToString();
                        this.horas.Text = rdr["horas"].ToString();
                        this.costomodulo.Text = rdr["costomodulo"].ToString();
                        this.costoalumno.Text = rdr["costo"].ToString();
                        this.pagohora.Text = rdr["pagohora"].ToString();
                        this.observaciones.Text = rdr["observaciones"].ToString();
                        this.hdias.Value = rdr["diascurso"].ToString();
                        this.alumnosminimo.Text = rdr["alumnosminimo"].ToString();
                        this.alumnosmaximo.Text = rdr["alumnosmaximo"].ToString();
                        this.fechalimite.Text = rdr["fechalimite"].ToString();
                        
                       /* if (rdr["movilidad"].ToString() != "1")
                        {
                            this.movilidad.Checked = false;
                        }
                        else
                        {
                            this.movilidad.Checked = true;
                        }*/

                       // llinks.Text = string.Concat(new string[] { "https://enlinea.icaten.gob.mx/registro.aspx?crs=", this.idP.Value, "&enl=", rdr["enlinea"].ToString(), "&cve=", this.clave.Text, "&of=", this.idOE.Value });
                        if (rdr["enlinea"].ToString() != "1")
                        {
                            this.enlinea.Checked = false;
                            bloqueo = "$('#accesoenlinea').hide();";
                        }
                        else
                        {
                            this.enlinea.Checked = true;
                            bloqueo = "$('#accesoenlinea').show();";
                        }
                        
                        
                    }
                    rdr.Close();
                    rdr = (new MySqlCommand(string.Concat("select * from  (  (  select idfecha, cast(fecha as char) as fecha, cast(TIME_FORMAT(horaini, '%H:%i') as char) as horaini, cast(TIME_FORMAT(horafin, '%H:%i') as char) as horafin, concat(cast(TIME_FORMAT(horaini, '%H:%i') as char), ' - ', cast(TIME_FORMAT(horafin, '%H:%i') as char)) as horario, 'SI' as dia  from fechascurso  where idcurso =", this.idP.Value, "  )  union  (  SELECT -1 as idfecha, cast(fecha as char) as fecha, '' as horaini, '' as horafin, '' as horario, (select case  when dayofweek(fecha) in(select distinct(dayofweek(f.fecha)) from fechascurso f where f.idcurso = ", this.idP.Value, ") then' SI'  ELSE 'NO'  end )AS dia   from fechaslibres where fecha not in(select fecha from fechascurso where idcurso=", this.idP.Value, " ) ) )as v  order by v.fecha "), con)).ExecuteReader();
                    json = string.Concat(json, "[");
                    if (rdr.HasRows)
                    {
                        while (rdr.Read())
                        {
                            json = string.Concat(json, "{");
                            json = string.Concat(json, "id:'", rdr["idfecha"].ToString(), "',");
                            if (rdr["idfecha"].ToString().Equals("-1"))
                            {
                                json = string.Concat(json, "color:'#967ADC',");
                                json = string.Concat(json, "title:'INHÁBIL',");
                                json = string.Concat(json, "description:'NO SE LABORA',");
                            }
                            else
                            {
                                json = string.Concat(json, "title:'", rdr["horario"].ToString(), "',");
                                json = string.Concat(new string[] { json, "description:'", rdr["horaini"].ToString(), " - ", rdr["horafin"].ToString(), "'," });
                            }
                            json = string.Concat(json, "fecha:'", rdr["fecha"].ToString(), "',");
                            json = string.Concat(json, "dia:'", rdr["dia"].ToString(), "',");
                            json = string.Concat(json, "horaini:'", rdr["horaini"].ToString(), "',");
                            json = string.Concat(json, "horafin:'", rdr["horafin"].ToString(), "',");
                            json = string.Concat(json, "start:'", rdr["fecha"].ToString(), "',");
                            json = string.Concat(json, "end:'", rdr["fecha"].ToString(), "'");
                            json = string.Concat(json, "},");
                        }
                    }
                    json = string.Concat(json, "]");
                    rdr.Close();
                    this.listadoAlumnos(sender, e);
                    this.listadoHistorial(sender, e);
                    this.listadoObjetivos(sender, e);
                    //ScriptManager.RegisterStartupScript(this, base.GetType(), "myScriptName", "cerrarLoading();  $('#bootstrap').modal('show'); $('#tabgenerales').click(); $('#fc-basic-views').fullCalendar('render'); dar(); "+bloqueo, true);
                    //ScriptManager.RegisterStartupScript(this, base.GetType(), "inicilizarMun", string.Concat("dataEvent =", json), true);

                    ScriptManager.RegisterStartupScript(this, GetType(), "myScriptName", "cerrarLoading();  $('#bootstrap').modal('show'); $('#tabgenerales').click(); $('#fc-basic-views').fullCalendar('render'); dar(); " + bloqueo + "", true);
                    ScriptManager.RegisterStartupScript(this, GetType(), "inicilizarMun", "dataEvent =" + json, true);
                }
            }
            catch (Exception exception)
            {
            }
        }

        protected void listadoHistorial(object sender, EventArgs e)
        {
            try
            {
                this.GVhistorial.DataSourceID = this.DShistorial.ID;
                string query = string.Concat("SELECT cast(h.fecha as char)as fecha, cast(h.hora as char) as hora, h.observacion, u.login as usuario from historialcurso h left join usuario u on u.idusuario = h.idusuario where h.idcurso = ", this.idP.Value, " order by h.fecha, h.hora");
                this.DShistorial.SelectCommand = query;
            }
            catch (Exception exception)
            {
            }
        }

        protected void listadoObjetivos(object sender, EventArgs e)
        {
            try
            {
                this.GVobjetivos.DataSourceID = this.DSobjetivos.ID;
                string query = string.Concat("SELECT idobjetivo, objetivo, clave from cursoobjetivo where idcurso = ", this.idP.Value, " order by clave desc");
                this.DSobjetivos.SelectCommand = query;
            }
            catch (Exception exception)
            {
            }
        }

        protected void lGeneral_Sorting(object sender, GridViewSortEventArgs e)
        {
            e.SortDirection.ToString().Equals("Ascending");
        }

        protected void nuevoRegistro(object sender, EventArgs e)
        {
            this.Session["idP"] = 0;
            this.Session["idS"] = this.idS.Value;
            base.Response.Redirect("~/catalogos/directorio/frminstructor.aspx");
        }

        protected void ocultaCursos(object sender, EventArgs e)
        {
           
        }

        protected void ofertaCurso(object sender, EventArgs e)
        {
            using (MySqlConnection con = new MySqlConnection(WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {
                MySqlTransaction transaction = null;
                try
                {
                    try
                    {
                        con.Open();
                        MySqlCommand mySqlCommand = con.CreateCommand();
                        transaction = con.BeginTransaction();
                        mySqlCommand.Connection = con;
                        mySqlCommand.Transaction = transaction;
                        mySqlCommand.Parameters.Clear();
                        mySqlCommand.CommandText = "update curso set estatus='OFERTADO' where idcurso=@idcurso;";
                        mySqlCommand.Parameters.AddWithValue("@idcurso", this.idP.Value);
                        mySqlCommand.ExecuteNonQuery();
                        mySqlCommand.Parameters.Clear();
                        mySqlCommand.CommandText = "insert into historialcurso(idcurso, idusuario, fecha, hora, observacion) values(@idcurso, @idusuario, curdate(), curtime(), @observacion); ";
                        mySqlCommand.Parameters.AddWithValue("@idcurso", this.idP.Value);
                        mySqlCommand.Parameters.AddWithValue("@idusuario", this.idusuario);
                        mySqlCommand.Parameters.AddWithValue("@observacion", "OFERTADO");
                        mySqlCommand.ExecuteNonQuery();
                        transaction.Commit();
                        this.listadoClientes(sender, e);
                        ScriptManager.RegisterStartupScript(this, base.GetType(), "myScriptName", "cerrarLoading(); toastExito(); $('#bootstrap').modal('hide');", true);
                    }
                    catch (Exception exception)
                    {
                        Exception ex = exception;
                        transaction.Rollback();
                        Console.WriteLine(string.Concat("error:", ex.ToString()));
                    }
                }
                finally
                {
                    con.Close();
                }
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            string[] datos = ((FormsIdentity)this.Page.User.Identity).Ticket.UserData.Split(new char[] { ',' });
            string[] datos2 = datos[1].Split(new char[] { ';' });
            this.idusuario = Convert.ToInt32(datos[0]);
            
            //this.roles = datos2[3].ToString();
           

           

            /*if (this.roles.IndexOf('1', 0) < 0)
            {
                this.busplantel.Visible = false;
            }
            else
            {
                this.busplantel.Visible = true;
            }*/

           // this.idSU.Value = this.idsucursal.ToString();
           // if (!IsPostBack)
           // {
               // if (this.roles.IndexOf('1', 0) < 0)
                    this.listadoClientes(sender, e);
           // }
            ScriptManager.RegisterStartupScript(this, base.GetType(), "actu", "dar(); ", true);
        }

        protected void refrescaGrid(object sender, EventArgs e)
        {
            this.DsUsuarios.DataBind();
            this.lGeneral.DataBind();
        }

       

        private void SaveReport(Telerik.Reporting.Report report, string fileName)
        {
            ReportProcessor reportProcessor = new ReportProcessor();
            InstanceReportSource instanceReportSource = new InstanceReportSource()
            {
                ReportDocument = report
            };
            RenderingResult result = reportProcessor.RenderReport("PDF", instanceReportSource, null);
            using (FileStream fs = new FileStream(fileName, FileMode.Create))
            {
                fs.Write(result.DocumentBytes, 0, (int)result.DocumentBytes.Length);
            }
        }

        protected void solicitaAutorizacion(object sender, EventArgs e)
        {
            using (MySqlConnection con = new MySqlConnection(WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {
                MySqlTransaction transaction = null;
                int idcurso = 0;
                try
                {
                    try
                    {
                        con.Open();
                        MySqlCommand cmd = con.CreateCommand();
                        transaction = con.BeginTransaction();
                        cmd.Connection = con;
                        cmd.Transaction = transaction;
                        if (Convert.ToInt32(this.idP.Value) != 0)
                        {
                            cmd.Parameters.Clear();
                            cmd.CommandText = string.Concat("update curso set clave=@clave, nombre=@nombre, idcicloescolar=(select idcicloescolar from cicloescolar where @fechaini between fechaini and fechafin), idtipocurso=@idtipocurso, idarea=@idarea, idespecialidad=@idespecialidad, idinstructor=@idinstructor, idinstalacion=@idinstalacion, fechaini=@fechaini, fechafin=@fechafin, dias=@dias, horaini=@horaini, horafin=@horafin, horas=@horas,  costomodulo=@costomodulo, costo=@costo, pagohora=@pagohora, observaciones=@observaciones, diascurso=@diascurso, idtipooferta=@idtipooferta, instalacionext=@instalacionext, alumnosminimo=@alumnosminimo, alumnosmaximo=@alumnosmaximo, fechalimite=@fechalimite, instalaciondomext=@instalaciondomext ", "where idcurso=@idcurso;");
                            cmd.Parameters.AddWithValue("@idcurso", this.idP.Value);
                            
                            cmd.Parameters.AddWithValue("@clave", this.clave.Text.ToUpper().Trim());
                            cmd.Parameters.AddWithValue("@nombre", this.nombre.Text.ToUpper().Trim());
                           
                            cmd.Parameters.AddWithValue("@fechaini", this.fechaini.Text);
                            cmd.Parameters.AddWithValue("@fechafin", this.fechafin.Text);
                            cmd.Parameters.AddWithValue("@dias", this.dias.Text);
                            cmd.Parameters.AddWithValue("@horaini", this.horaini.Text);
                            cmd.Parameters.AddWithValue("@horafin", this.horafin.Text);
                            cmd.Parameters.AddWithValue("@horas", this.horas.Text);
                            if (this.costomodulo.Text.Equals(""))
                            {
                                cmd.Parameters.AddWithValue("@costomodulo", "0");
                            }
                            else
                            {
                                cmd.Parameters.AddWithValue("@costomodulo", this.costomodulo.Text);
                            }
                            if (this.costoalumno.Text.Equals(""))
                            {
                                cmd.Parameters.AddWithValue("@costo", "0");
                            }
                            else
                            {
                                cmd.Parameters.AddWithValue("@costo", this.costoalumno.Text);
                            }
                            if (this.pagohora.Text.Equals(""))
                            {
                                cmd.Parameters.AddWithValue("@pagohora", "0");
                            }
                            else
                            {
                                cmd.Parameters.AddWithValue("@pagohora", this.pagohora.Text);
                            }
                            cmd.Parameters.AddWithValue("@observaciones", this.observaciones.Text.Trim());
                            cmd.Parameters.AddWithValue("@diascurso", this.hdias.Value);
                            //cmd.Parameters.AddWithValue("@idtipooferta", this.tipooferta.SelectedValue);
                            //cmd.Parameters.AddWithValue("@instalacionext", this.instalacionext.Text.ToUpper().Trim());
                            //cmd.Parameters.AddWithValue("@instalaciondomext", this.instalaciondomext.Text.ToUpper().Trim());
                            cmd.Parameters.AddWithValue("@alumnosminimo", this.alumnosminimo.Text);
                            cmd.Parameters.AddWithValue("@alumnosmaximo", this.alumnosmaximo.Text);
                            cmd.Parameters.AddWithValue("@fechalimite", this.fechalimite.Text);
                            cmd.ExecuteNonQuery();
                        }
                        else
                        {
                            cmd.Parameters.Clear();
                            cmd.CommandText = "insert into curso(idsucursal, idcicloescolar, clave, nombre, idtipocurso, idarea, idespecialidad, idinstructor, idinstalacion, fechaini, fechafin, dias, horaini, horafin, horas, costomodulo, costo, pagohora, observaciones, estatus, pagado, diascurso, idtipooferta, instalacionext, alumnosminimo, alumnosmaximo, fechalimite, instalaciondomext, solicita, autoriza) values(@idsucursal, (select idcicloescolar from cicloescolar where @fechaini between fechaini and fechafin), @clave, @nombre, @idtipocurso, @idarea, @idespecialidad, @idinstructor, @idinstalacion, @fechaini, @fechafin, @dias, @horaini, @horafin, @horas, @costomodulo, @costo, @pagohora, @observaciones, 'EN CAPTURA', 0, @diascurso, @idtipooferta, @instalacionext, @alumnosminimo, @alumnosmaximo, @fechalimite, @instalaciondomext, (select encargado from sucursal where idsucursal=@idsucursal), 'PROF. GERSOM PÉREZ RAMÍREZ'); ";
                            //cmd.Parameters.AddWithValue("@idcicloescolar", 1);
                            cmd.Parameters.AddWithValue("@idsucursal", this.idsucursal);
                            cmd.Parameters.AddWithValue("@nombre", this.nombre.Text.ToUpper().Trim());
                            cmd.Parameters.AddWithValue("@clave", this.clave.Text.ToUpper().Trim());
                            
                            cmd.Parameters.AddWithValue("@fechaini", this.fechaini.Text);
                            cmd.Parameters.AddWithValue("@fechafin", this.fechafin.Text);
                            cmd.Parameters.AddWithValue("@dias", this.dias.Text);
                            cmd.Parameters.AddWithValue("@horaini", this.horaini.Text);
                            cmd.Parameters.AddWithValue("@horafin", this.horafin.Text);
                            cmd.Parameters.AddWithValue("@horas", this.horas.Text);
                            if (this.costomodulo.Text.Equals(""))
                            {
                                cmd.Parameters.AddWithValue("@costomodulo", "0");
                            }
                            else
                            {
                                cmd.Parameters.AddWithValue("@costomodulo", this.costomodulo.Text);
                            }
                            if (this.costoalumno.Text.Equals(""))
                            {
                                cmd.Parameters.AddWithValue("@costo", "0");
                            }
                            else
                            {
                                cmd.Parameters.AddWithValue("@costo", this.costoalumno.Text);
                            }
                            if (this.pagohora.Text.Equals(""))
                            {
                                cmd.Parameters.AddWithValue("@pagohora", "0");
                            }
                            else
                            {
                                cmd.Parameters.AddWithValue("@pagohora", this.pagohora.Text);
                            }
                            cmd.Parameters.AddWithValue("@observaciones", this.observaciones.Text.Trim());
                            cmd.Parameters.AddWithValue("@diascurso", this.hdias.Value);
                           
                            //cmd.Parameters.AddWithValue("@instalacionext", this.instalacionext.Text.ToUpper().Trim());
                            //cmd.Parameters.AddWithValue("@instalaciondomext", this.instalaciondomext.Text.ToUpper().Trim());
                            cmd.Parameters.AddWithValue("@alumnosminimo", this.alumnosminimo.Text);
                            cmd.Parameters.AddWithValue("@alumnosmaximo", this.alumnosmaximo.Text);
                            cmd.Parameters.AddWithValue("@fechalimite", this.fechalimite.Text);
                            cmd.ExecuteNonQuery();
                            idcurso = (int)cmd.LastInsertedId;
                            this.idP.Value = idcurso.ToString();
                            cmd.Parameters.Clear();
                            cmd.CommandText = "insert into historialcurso(idcurso, idusuario, fecha, hora, observacion) values(@idcurso, @idusuario, curdate(), curtime(), @observacion); ";
                            cmd.Parameters.AddWithValue("@idcurso", this.idP.Value);
                            cmd.Parameters.AddWithValue("@idusuario", this.idusuario);
                            cmd.Parameters.AddWithValue("@observacion", "DADO DE ALTA");
                            cmd.ExecuteNonQuery();
                        }
                        cmd.Parameters.Clear();
                        cmd.CommandText = "update curso set estatus='EN REVISION' where idcurso=@idcurso;";
                        cmd.Parameters.AddWithValue("@idcurso", this.idP.Value);
                        cmd.ExecuteNonQuery();
                        cmd.Parameters.Clear();
                        cmd.CommandText = "insert into historialcurso(idcurso, idusuario, fecha, hora, observacion) values(@idcurso, @idusuario, curdate(), curtime(), @observacion); ";
                        cmd.Parameters.AddWithValue("@idcurso", this.idP.Value);
                        cmd.Parameters.AddWithValue("@idusuario", this.idusuario);
                        cmd.Parameters.AddWithValue("@observacion", "ENVIADO A AUTORIZACIÓN DE CURSO");
                        cmd.ExecuteNonQuery();
                        transaction.Commit();
                        this.listadoClientes(sender, e);
                        ScriptManager.RegisterStartupScript(this, base.GetType(), "myScriptName", "cerrarLoading(); toastExito(); $('#bootstrap').modal('hide');", true);
                    }
                    catch (Exception exception)
                    {
                        Exception ex = exception;
                        transaction.Rollback();
                        Console.WriteLine(string.Concat("error:", ex.ToString()));
                    }
                }
                finally
                {
                    con.Close();
                }
            }
        }


        protected void aperturaCurso(object sender, EventArgs e)
        {
            using (MySqlConnection con = new MySqlConnection(WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {
                MySqlTransaction transaction = null;
                int idcurso = 0;
                try
                {
                    try
                    {
                        con.Open();
                        MySqlCommand cmd = con.CreateCommand();
                        transaction = con.BeginTransaction();
                        cmd.Connection = con;
                        cmd.Transaction = transaction;
                        
                        cmd.Parameters.Clear();
                        cmd.CommandText = "update curso set estatus='EN CAPTURA' where idcurso=@idcurso;";
                        cmd.Parameters.AddWithValue("@idcurso", this.idP.Value);
                        cmd.ExecuteNonQuery();
                        cmd.Parameters.Clear();


                        cmd.Parameters.Clear();
                        string query = "insert into historialcurso(idcurso, idusuario, fecha, hora, observacion) " +
                                           "values(@idcurso, @idusuario, curdate(), curtime(), @observacion); ";

                        cmd.CommandText = query;
                        cmd.Parameters.AddWithValue("@idcurso", idP.Value);
                        cmd.Parameters.AddWithValue("@idusuario", idusuario);
                        cmd.Parameters.AddWithValue("@observacion", "REAPERTURA DE CAPTURA DE CURSO");

                        cmd.ExecuteNonQuery();



                        transaction.Commit();
                        this.listadoClientes(sender, e);
                        ScriptManager.RegisterStartupScript(this, base.GetType(), "myScriptName", "cerrarLoading(); toastExito(); $('#bootstrap').modal('hide');", true);
                    }
                    catch (Exception exception)
                    {
                        Exception ex = exception;
                        transaction.Rollback();
                        Console.WriteLine(string.Concat("error:", ex.ToString()));
                    }
                }
                finally
                {
                    con.Close();
                }
            }
        }

        protected void habilitaFecha(object sender, EventArgs e)
        {
            using (MySqlConnection con = new MySqlConnection(WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {
                MySqlTransaction transaction = null;
                MySqlDataReader reader = null;
                int nohoras = 0;
                int dias = 0;

                try
                {
                    try
                    {
                        con.Open();
                        MySqlCommand cmd = con.CreateCommand();
                        transaction = con.BeginTransaction();
                        cmd.Connection = con;
                        cmd.Transaction = transaction;

                        cmd.CommandText = string.Concat("SELECT COALESCE(MAX(idfecha),0)as idfecha FROM fechascurso where idcurso=", this.idP.Value, ";");
                        int idfecha = Convert.ToInt32(cmd.ExecuteScalar());

                        cmd.Parameters.Clear();
                        cmd.CommandText = "insert into fechascurso (idcurso, idfecha, fecha, horaini, horafin) values (@idcurso, @idfecha, @fecha, @horaini, @horafin); ";
                        cmd.Parameters.AddWithValue("@idcurso", this.idP.Value);
                        cmd.Parameters.AddWithValue("@idfecha", idfecha+1);
                        cmd.Parameters.AddWithValue("@fecha", finhabil.Value);
                        cmd.Parameters.AddWithValue("@horaini", this.horaini.Text);
                        cmd.Parameters.AddWithValue("@horafin", this.horafin.Text);                            
                        cmd.ExecuteNonQuery();


                        cmd.Parameters.Clear();
                        cmd.CommandText = string.Concat("select sum(TIMESTAMPDIFF(HOUR, horaini, horafin))as horas, count(fecha)as dias from fechascurso where idcurso =", this.idP.Value, ";");
                        reader = cmd.ExecuteReader();
                        while (reader.Read())
                        {
                            nohoras = reader.GetInt32(0);
                            dias = reader.GetInt32(1);
                        }
                        reader.Close();

                        cmd.Parameters.Clear();
                        cmd.CommandText = "update curso set horas=@horas, dias=@dias where idcurso=@idcurso; ";
                        cmd.Parameters.AddWithValue("@idcurso", this.idP.Value);
                        cmd.Parameters.AddWithValue("@horas", nohoras);
                        cmd.Parameters.AddWithValue("@dias", dias);
                        cmd.ExecuteNonQuery();
                        this.horas.Text = nohoras.ToString();
                        this.dias.Text = dias.ToString();

                        transaction.Commit();

                        //this.getCalendario(sender, e);
                        ScriptManager.RegisterStartupScript(this, base.GetType(), "myScriptName", "cerrarLoading(); $('#winhabiles').modal('hide');", true);
                    }
                    catch (Exception exception)
                    {
                        Exception ex = exception;
                        transaction.Rollback();
                        Console.WriteLine(string.Concat("error:", ex.ToString()));
                    }
                }
                finally
                {
                    con.Close();
                }
            }
        }


        protected void eliminaFecha(object sender, EventArgs e)
        {
            using (MySqlConnection con = new MySqlConnection(WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {
                MySqlTransaction transaction = null;
                MySqlDataReader reader = null;
                int nohoras = 0;
                int dias = 0;

                try
                {
                    try
                    {
                        con.Open();
                        MySqlCommand cmd = con.CreateCommand();
                        transaction = con.BeginTransaction();
                        cmd.Connection = con;
                        cmd.Transaction = transaction;


                        cmd.Parameters.Clear();
                        cmd.CommandText = "delete from fechascurso where idcurso=@idcurso and idfecha=@idfecha; ";
                        cmd.Parameters.AddWithValue("@idcurso", this.idP.Value);
                        cmd.Parameters.AddWithValue("@idfecha", idF.Value);                        
                        cmd.ExecuteNonQuery();

                        cmd.ExecuteNonQuery();
                        cmd.Parameters.Clear();
                        cmd.CommandText = string.Concat("select sum(TIMESTAMPDIFF(HOUR, horaini, horafin))as horas, count(fecha)as dias from fechascurso where idcurso =", this.idP.Value, ";");
                        reader = cmd.ExecuteReader();
                        while (reader.Read())
                        {
                            nohoras = reader.GetInt32(0);
                            dias = reader.GetInt32(1);
                        }
                        reader.Close();

                        cmd.Parameters.Clear();
                        cmd.CommandText = "update curso set horas=@horas, dias=@dias where idcurso=@idcurso; ";
                        cmd.Parameters.AddWithValue("@idcurso", this.idP.Value);
                        cmd.Parameters.AddWithValue("@horas", nohoras);
                        cmd.Parameters.AddWithValue("@dias", dias);
                        cmd.ExecuteNonQuery();
                        this.horas.Text = nohoras.ToString();
                        this.dias.Text = dias.ToString();

                        transaction.Commit();

                        //this.getCalendario(sender, e);
                        ScriptManager.RegisterStartupScript(this, base.GetType(), "myScriptName", "cerrarLoading(); $('#wfechas').modal('hide');", true);

                    }
                    catch (Exception exception)
                    {
                        Exception ex = exception;
                        transaction.Rollback();
                        Console.WriteLine(string.Concat("error:", ex.ToString()));
                    }
                }
                finally
                {
                    con.Close();
                }
            }
        }

    }
}