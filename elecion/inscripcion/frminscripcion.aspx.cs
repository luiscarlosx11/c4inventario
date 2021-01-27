using System;
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
using System.Net;
using System.Web.Configuration;
using Telerik.Reporting;
using ReportLibrary;

namespace elecion.inscripcion
{
    public partial class frminscripcion : System.Web.UI.Page
    {
        private int idsucursal;
        private int idusuario;
        private int idtipousuario;
        protected void area_DataBound(object sender, EventArgs e)
        {
            this.Dsespecialidades.DataBind();
            this.especialidad.DataBind();
        }

        protected void becado_CheckedChanged(object sender, EventArgs e)
        {
            if (this.apoyo.SelectedValue == "1")
            {
                this.divConv.Visible = true;
                return;
            }
            this.divConv.Visible = false;
        }

        protected void borraFechas(object sender, EventArgs e)
        {
        }

        protected void cancelaAlumno(object sender, EventArgs e)
        {
            using (MySqlConnection mySqlConnection = new MySqlConnection(WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {
                MySqlTransaction mySqlTransaction = null;
                string str = "";
                try
                {
                    try
                    {
                        mySqlConnection.Open();
                        MySqlCommand mySqlCommand = mySqlConnection.CreateCommand();
                        mySqlTransaction = mySqlConnection.BeginTransaction();
                        mySqlCommand.Connection = mySqlConnection;
                        mySqlCommand.Transaction = mySqlTransaction;
                        mySqlCommand.Parameters.Clear();
                        mySqlCommand.CommandText = "update solicitudinscripcion set idtipodesercion=@idtipodesercion, motivocancelacion=@motivocancelacion, estatus=@estatus, idcondicion=@idcondicion where idsolicitud=@idI;";
                        mySqlCommand.Parameters.AddWithValue("@idI", this.idI.Value);
                        mySqlCommand.Parameters.AddWithValue("@idtipodesercion", this.desercion.SelectedValue);
                        mySqlCommand.Parameters.AddWithValue("@motivocancelacion", this.motcancelacion.Text.ToUpper());
                        if (this.desercion.SelectedValue.Equals("1"))
                        {
                            str = "CANCELADO";
                            mySqlCommand.Parameters.AddWithValue("@idcondicion", 5);
                        }
                        else if (this.desercion.SelectedValue.Equals("2"))
                        {
                            str = "DESERCIÓN";
                            mySqlCommand.Parameters.AddWithValue("@idcondicion", 3);
                        }
                        mySqlCommand.Parameters.AddWithValue("@estatus", str);
                        mySqlCommand.ExecuteNonQuery();
                        mySqlTransaction.Commit();
                        this.listadoAlumnos(sender, e);
                        ScriptManager.RegisterStartupScript(this, base.GetType(), "myScriptName", "cerrarLoading(); toastExito(); $('#wcancelar').modal('hide');", true);
                    }
                    catch (Exception exception1)
                    {
                        Exception exception = exception1;
                        mySqlTransaction.Rollback();
                        Console.WriteLine(string.Concat("error:", exception.ToString()));
                    }
                }
                finally
                {
                    mySqlConnection.Close();
                }
            }
        }

        protected void conteoRegistros(object sender, EventArgs e)
        {
            using (MySqlConnection mySqlConnection = new MySqlConnection(WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {
                try
                {
                    try
                    {
                        mySqlConnection.Open();
                        MySqlDataReader mySqlDataReader = (new MySqlCommand(string.Concat("SELECT COUNT(al.idalumno) as total  from alumno al  left join solicitudinscripcion si on si.idalumno = al.idalumno  where si.idcurso = ", this.idP.Value, " "), mySqlConnection)).ExecuteReader();
                        if (mySqlDataReader.HasRows)
                        {
                            mySqlDataReader.Read();
                        }
                    }
                    catch (Exception exception)
                    {
                    }
                }
                finally
                {
                    mySqlConnection.Close();
                }
            }
        }

        protected void descargaArchivo(object sender, EventArgs e)
        {
            try
            {
                using (MySqlConnection mySqlConnection = new MySqlConnection(WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
                {
                    mySqlConnection.Open();
                    string str = "";
                    MySqlDataReader mySqlDataReader = (new MySqlCommand(string.Concat(new string[] { "select archivo from cursodocumentacion where idsolicitud = ", this.idI.Value, " and iddocumentacion=", this.idDoc.Value, "; " }), mySqlConnection)).ExecuteReader();
                    if (mySqlDataReader.HasRows)
                    {
                        mySqlDataReader.Read();
                        byte[] item = (byte[])mySqlDataReader["archivo"];
                        if (this.idDoc.Value.Equals("1"))
                        {
                            str = string.Concat("acta_", this.idI.Value, ".zip");
                        }
                        else if (this.idDoc.Value.Equals("2"))
                        {
                            str = string.Concat("curp_", this.idI.Value, ".zip");
                        }
                        else if (this.idDoc.Value.Equals("3"))
                        {
                            str = string.Concat("compdomicilio_", this.idI.Value, ".zip");
                        }
                        else if (this.idDoc.Value.Equals("5"))
                        {
                            str = string.Concat("ine_", this.idI.Value, ".zip");
                        }
                        else if (this.idDoc.Value.Equals("6"))
                        {
                            str = string.Concat("compestudios_", this.idI.Value, ".zip");
                        }
                        else if (this.idDoc.Value.Equals("9"))
                        {
                            str = string.Concat("comppago_", this.idI.Value, ".zip");
                        }
                        else if (this.idDoc.Value.Equals("8"))
                        {
                            str = string.Concat("licencia_", this.idI.Value, ".zip");
                        }
                        base.Response.Clear();
                        base.Response.ClearHeaders();
                        base.Response.AddHeader("Content-Type", "application/octet-stream");
                        base.Response.AddHeader("Content-Length", ((int)item.Length).ToString());
                        base.Response.AddHeader("Content-Disposition", string.Format("attachment;filename={0}", str));
                        base.Response.BinaryWrite(item);
                        base.Response.Flush();
                        base.Response.End();
                    }
                    mySqlDataReader.Close();
                }
            }
            catch (Exception exception)
            {
            }
        }

        protected void editaRegistro(object sender, EventArgs e)
        {
            this.Session["idP"] = this.idP.Value;
            this.Session["idS"] = this.idS.Value;
            base.Response.Redirect("~/catalogos/directorio/frminstructor.aspx");
        }

        private void ExportToPDF(Telerik.Reporting.Report reportToExport, string nombre)
        {
            ReportProcessor reportProcessor = new ReportProcessor();
            InstanceReportSource instanceReportSource = new InstanceReportSource()
            {
                ReportDocument = reportToExport
            };
            RenderingResult renderingResult = reportProcessor.RenderReport("PDF", instanceReportSource, null);
            string str = string.Concat(nombre, ".", renderingResult.Extension);
            base.Response.Clear();
            base.Response.ContentType = renderingResult.MimeType;
            base.Response.Cache.SetCacheability(HttpCacheability.Private);
            base.Response.Expires = -1;
            base.Response.Buffer = true;
            base.Response.AddHeader("Content-Disposition", string.Format("{0};FileName=\"{1}\"", "attachment", str));
            base.Response.BinaryWrite(renderingResult.DocumentBytes);
            base.Response.End();
        }

        protected void generaFechasCurso(object sender, EventArgs e)
        {
            using (MySqlConnection mySqlConnection = new MySqlConnection(WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {
                MySqlTransaction mySqlTransaction = null;
                MySqlDataReader mySqlDataReader = null;
                string str = "";
                int num = 0;
                int lastInsertedId = 0;
                int num1 = 0;
                List<elecion.fechascurso> fechascursos = null;
                try
                {
                    try
                    {
                        mySqlConnection.Open();
                        MySqlCommand mySqlCommand = mySqlConnection.CreateCommand();
                        mySqlTransaction = mySqlConnection.BeginTransaction();
                        mySqlCommand.Connection = mySqlConnection;
                        mySqlCommand.Transaction = mySqlTransaction;
                        if (Convert.ToInt32(this.idP.Value) != 0)
                        {
                            mySqlCommand.Parameters.Clear();
                            mySqlCommand.CommandText = string.Concat("update curso set nombre=@nombre, idcicloescolar=@idcicloescolar, idtipocurso=@idtipocurso, idarea=@idarea, idespecialidad=@idespecialidad, idinstructor=@idinstructor, idinstalacion=@idinstalacion, fechaini=@fechaini, fechafin=@fechafin, dias=@dias, horaini=@horaini, horafin=@horafin, horas=@horas,  costomodulo=@costomodulo, costo=@costo, pagohora=@pagohora, observaciones=@observaciones, diascurso=@diascurso, idtipooferta=@idtipooferta, instalacionext=@instalacionext, alumnosminimo=@alumnosminimo, fechalimite=@fechalimite, instalaciondomext=@instalaciondomext ", "where idcurso=@idcurso;");
                            mySqlCommand.Parameters.AddWithValue("@idcurso", this.idP.Value);
                            mySqlCommand.Parameters.AddWithValue("@idcicloescolar", 1);
                            mySqlCommand.Parameters.AddWithValue("@nombre", this.nombre.Text.ToUpper().Trim());
                            mySqlCommand.Parameters.AddWithValue("@idtipocurso", this.tipocurso.SelectedValue);
                            mySqlCommand.Parameters.AddWithValue("@idarea", this.area.SelectedValue);
                            mySqlCommand.Parameters.AddWithValue("@idespecialidad", this.especialidad.SelectedValue);
                            mySqlCommand.Parameters.AddWithValue("@idinstructor", this.instructor.SelectedValue);
                            mySqlCommand.Parameters.AddWithValue("@idinstalacion", this.instalacion.SelectedValue);
                            mySqlCommand.Parameters.AddWithValue("@fechaini", this.fechaini.Text);
                            mySqlCommand.Parameters.AddWithValue("@fechafin", this.fechafin.Text);
                            mySqlCommand.Parameters.AddWithValue("@dias", this.dias.Text);
                            mySqlCommand.Parameters.AddWithValue("@horaini", this.horaini.Text);
                            mySqlCommand.Parameters.AddWithValue("@horafin", this.horafin.Text);
                            mySqlCommand.Parameters.AddWithValue("@horas", this.horas.Text);
                            if (this.costomodulo.Text.Equals(""))
                            {
                                mySqlCommand.Parameters.AddWithValue("@costomodulo", "0");
                            }
                            else
                            {
                                mySqlCommand.Parameters.AddWithValue("@costomodulo", this.costomodulo.Text);
                            }
                            if (this.costoalumno.Text.Equals(""))
                            {
                                mySqlCommand.Parameters.AddWithValue("@costo", "0");
                            }
                            else
                            {
                                mySqlCommand.Parameters.AddWithValue("@costo", this.costoalumno.Text);
                            }
                            if (this.pagohora.Text.Equals(""))
                            {
                                mySqlCommand.Parameters.AddWithValue("@pagohora", "0");
                            }
                            else
                            {
                                mySqlCommand.Parameters.AddWithValue("@pagohora", this.pagohora.Text);
                            }
                            mySqlCommand.Parameters.AddWithValue("@observaciones", this.observaciones.Text.Trim());
                            mySqlCommand.Parameters.AddWithValue("@diascurso", this.hdias.Value);
                            mySqlCommand.Parameters.AddWithValue("@idtipooferta", this.tipooferta.SelectedValue);
                            mySqlCommand.Parameters.AddWithValue("@instalacionext", this.instalacionext.Text.ToUpper().Trim());
                            mySqlCommand.Parameters.AddWithValue("@instalaciondomext", this.instalaciondomext.Text.ToUpper().Trim());
                            mySqlCommand.Parameters.AddWithValue("@alumnosminimo", this.alumnosminimo.Text);
                            mySqlCommand.Parameters.AddWithValue("@fechalimite", this.fechalimite.Text);
                            mySqlCommand.ExecuteNonQuery();
                        }
                        else
                        {
                            mySqlCommand.Parameters.Clear();
                            mySqlCommand.CommandText = "insert into curso(idsucursal, idcicloescolar, nombre, idtipocurso, idarea, idespecialidad, idinstructor, idinstalacion, fechaini, fechafin, dias, horaini, horafin, horas, costomodulo, costo, pagohora, observaciones, estatus, pagado, diascurso, idtipooferta, instalacionext, alumnosminimo, fechalimite, instalaciondomext, solicita, autoriza) values(@idsucursal, @idcicloescolar, @nombre, @idtipocurso, @idarea, @idespecialidad, @idinstructor, @idinstalacion, @fechaini, @fechafin, @dias, @horaini, @horafin, @horas, @costomodulo, @costo, @pagohora, @observaciones, 'EN CAPTURA', 0, @diascurso, @idtipooferta, @instalacionext, @alumnosminimo, @fechalimite, @instalaciondomext, (select encargado from sucursal where idsucursal=@idsucursal), 'PROF. GERSOM PÉREZ RAMÍREZ'); ";
                            mySqlCommand.Parameters.AddWithValue("@idcicloescolar", 1);
                            mySqlCommand.Parameters.AddWithValue("@idsucursal", this.idsucursal);
                            mySqlCommand.Parameters.AddWithValue("@nombre", this.nombre.Text.ToUpper().Trim());
                            mySqlCommand.Parameters.AddWithValue("@idtipocurso", this.tipocurso.SelectedValue);
                            mySqlCommand.Parameters.AddWithValue("@idarea", this.area.SelectedValue);
                            mySqlCommand.Parameters.AddWithValue("@idespecialidad", this.especialidad.SelectedValue);
                            mySqlCommand.Parameters.AddWithValue("@idinstructor", this.instructor.SelectedValue);
                            mySqlCommand.Parameters.AddWithValue("@idinstalacion", this.instalacion.SelectedValue);
                            mySqlCommand.Parameters.AddWithValue("@fechaini", this.fechaini.Text);
                            mySqlCommand.Parameters.AddWithValue("@fechafin", this.fechafin.Text);
                            mySqlCommand.Parameters.AddWithValue("@dias", this.dias.Text);
                            mySqlCommand.Parameters.AddWithValue("@horaini", this.horaini.Text);
                            mySqlCommand.Parameters.AddWithValue("@horafin", this.horafin.Text);
                            mySqlCommand.Parameters.AddWithValue("@horas", this.horas.Text);
                            if (this.costomodulo.Text.Equals(""))
                            {
                                mySqlCommand.Parameters.AddWithValue("@costomodulo", "0");
                            }
                            else
                            {
                                mySqlCommand.Parameters.AddWithValue("@costomodulo", this.costomodulo.Text);
                            }
                            if (this.costoalumno.Text.Equals(""))
                            {
                                mySqlCommand.Parameters.AddWithValue("@costo", "0");
                            }
                            else
                            {
                                mySqlCommand.Parameters.AddWithValue("@costo", this.costoalumno.Text);
                            }
                            if (this.pagohora.Text.Equals(""))
                            {
                                mySqlCommand.Parameters.AddWithValue("@pagohora", "0");
                            }
                            else
                            {
                                mySqlCommand.Parameters.AddWithValue("@pagohora", this.pagohora.Text);
                            }
                            mySqlCommand.Parameters.AddWithValue("@observaciones", this.observaciones.Text.Trim());
                            mySqlCommand.Parameters.AddWithValue("@diascurso", this.hdias.Value);
                            mySqlCommand.Parameters.AddWithValue("@idtipooferta", this.tipooferta.SelectedValue);
                            mySqlCommand.Parameters.AddWithValue("@instalacionext", this.instalacionext.Text.ToUpper().Trim());
                            mySqlCommand.Parameters.AddWithValue("@instalaciondomext", this.instalaciondomext.Text.ToUpper().Trim());
                            mySqlCommand.Parameters.AddWithValue("@alumnosminimo", this.alumnosminimo.Text);
                            mySqlCommand.Parameters.AddWithValue("@fechalimite", this.fechalimite.Text);
                            mySqlCommand.ExecuteNonQuery();
                            lastInsertedId = (int)mySqlCommand.LastInsertedId;
                            this.idP.Value = lastInsertedId.ToString();
                        }
                        mySqlCommand.Parameters.Clear();
                        mySqlCommand.CommandText = string.Concat(new string[] { "select * from (select adddate('1970-01-01', t4.i * 10000 + t3.i * 1000 + t2.i * 100 + t1.i * 10 + t0.i) fecha from  (select 0 i union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t0,  (select 0 i union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t1,  (select 0 i union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t2,  (select 0 i union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t3,  (select 0 i union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t4) v where fecha between '", this.fechaini.Text, "' and '", this.fechafin.Text, "'and DAYOFWEEK(fecha) in (", this.hdias.Value, ")" });
                        fechascursos = new List<elecion.fechascurso>();
                        mySqlDataReader = mySqlCommand.ExecuteReader();
                        while (mySqlDataReader.Read())
                        {
                            elecion.fechascurso _fechascurso = new elecion.fechascurso()
                            {
                                fecha = mySqlDataReader.GetString(0)
                            };
                            fechascursos.Add(_fechascurso);
                        }
                        mySqlDataReader.Close();
                        mySqlCommand.Parameters.Clear();
                        mySqlCommand.CommandText = string.Concat("SELECT COALESCE(MAX(idfecha),0)as idfecha FROM fechascurso where idcurso=", this.idP.Value, ";");
                        mySqlDataReader = mySqlCommand.ExecuteReader();
                        while (mySqlDataReader.Read())
                        {
                            num = mySqlDataReader.GetInt32(0) + 1;
                        }
                        mySqlDataReader.Close();
                        mySqlCommand.Parameters.Clear();
                        str = "delete from fechascurso where idcurso=@idcurso; ";
                        mySqlCommand.Parameters.AddWithValue("@idcurso", this.idP.Value);
                        mySqlCommand.CommandText = str;
                        mySqlCommand.ExecuteNonQuery();
                        foreach (elecion.fechascurso fechascurso in fechascursos)
                        {
                            mySqlCommand.Parameters.Clear();
                            mySqlCommand.CommandText = "insert into fechascurso (idcurso, idfecha, fecha, horaini, horafin) values (@idcurso, @idfecha, @fecha, @horaini, @horafin); ";
                            mySqlCommand.Parameters.AddWithValue("@idcurso", this.idP.Value);
                            mySqlCommand.Parameters.AddWithValue("@idfecha", num);
                            mySqlCommand.Parameters.AddWithValue("@fecha", fechascurso.fecha);
                            mySqlCommand.Parameters.AddWithValue("@horaini", this.horaini.Text);
                            mySqlCommand.Parameters.AddWithValue("@horafin", this.horafin.Text);
                            num++;
                            mySqlCommand.ExecuteNonQuery();
                        }
                        mySqlCommand.Parameters.Clear();
                        mySqlCommand.CommandText = string.Concat("select sum(TIMESTAMPDIFF(HOUR, horaini, horafin))as horas from fechascurso where idcurso =", this.idP.Value, ";");
                        mySqlDataReader = mySqlCommand.ExecuteReader();
                        while (mySqlDataReader.Read())
                        {
                            num1 = mySqlDataReader.GetInt32(0);
                        }
                        mySqlDataReader.Close();
                        mySqlCommand.Parameters.Clear();
                        mySqlCommand.CommandText = "update curso set dias=@dias, horas=@horas where idcurso=@idcurso; ";
                        mySqlCommand.Parameters.AddWithValue("@idcurso", this.idP.Value);
                        mySqlCommand.Parameters.AddWithValue("@dias", fechascursos.Count);
                        mySqlCommand.Parameters.AddWithValue("@horas", num1);
                        mySqlCommand.ExecuteNonQuery();
                        this.dias.Text = fechascursos.Count.ToString();
                        this.horas.Text = num1.ToString();
                        mySqlTransaction.Commit();
                        this.getCalendario(sender, e);
                        ScriptManager.RegisterStartupScript(this, base.GetType(), "myScriptName", "cerrarLoading(); ", true);
                    }
                    catch (Exception exception1)
                    {
                        Exception exception = exception1;
                        mySqlTransaction.Rollback();
                        Console.WriteLine(string.Concat("error:", exception.ToString()));
                    }
                }
                finally
                {
                    mySqlConnection.Close();
                }
            }
        }

        protected void getAlumno(object sender, EventArgs e)
        {
            using (MySqlConnection mySqlConnection = new MySqlConnection(WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {
                try
                {
                    try
                    {
                        mySqlConnection.Open();
                        MySqlDataReader mySqlDataReader = (new MySqlCommand(string.Concat("select idalumno, idedocivil, idescolaridad, nocontrol, nombre, apaterno, amaterno, sexo, curp, telefono, domicilio, colonia, cp, identidad, idmunicipio, cast(fechanacimiento as char)as fechanacimiento, email,  empresa, puesto, antiguedad, direccion, telefonoempresa  from alumno where idalumno = ", this.idA.Value, " "), mySqlConnection)).ExecuteReader();
                        if (mySqlDataReader.HasRows)
                        {
                            mySqlDataReader.Read();
                            this.idA.Value = mySqlDataReader["idalumno"].ToString();
                            this.nocontrol.Text = mySqlDataReader["nocontrol"].ToString();
                            this.nombrealumno.Text = mySqlDataReader["nombre"].ToString();
                            this.apaterno.Text = mySqlDataReader["apaterno"].ToString();
                            this.amaterno.Text = mySqlDataReader["amaterno"].ToString();
                            this.sexo.SelectedValue = mySqlDataReader["sexo"].ToString();
                            this.curp.Text = mySqlDataReader["curp"].ToString();
                            this.domicilio.Text = mySqlDataReader["domicilio"].ToString();
                            this.telefono.Text = mySqlDataReader["telefono"].ToString();
                            this.colonia.Text = mySqlDataReader["colonia"].ToString();
                            this.cp.Text = mySqlDataReader["cp"].ToString();
                            this.entidad.SelectedValue = mySqlDataReader["identidad"].ToString();
                            this.DSmunicipios.DataBind();
                            this.municipio.DataBind();
                            this.municipio.SelectedValue = mySqlDataReader["idmunicipio"].ToString();
                            this.fechanacimiento.Text = mySqlDataReader["fechanacimiento"].ToString();
                            this.escolaridad.SelectedValue = mySqlDataReader["idescolaridad"].ToString();
                            this.empresa.Text = mySqlDataReader["empresa"].ToString();
                            this.puesto.Text = mySqlDataReader["puesto"].ToString();
                            this.antiguedad.Text = mySqlDataReader["antiguedad"].ToString();
                            this.domicilioempresa.Text = mySqlDataReader["direccion"].ToString();
                            this.telefonoempresa.Text = mySqlDataReader["telefonoempresa"].ToString();
                            this.email.Text = mySqlDataReader["email"].ToString();
                            mySqlDataReader.Close();
                        }
                        ScriptManager.RegisterClientScriptBlock(this.Page, typeof(string), "myScriptName", "cerrarLoading(); $('#walumnos').modal('hide');", true);
                    }
                    catch (Exception exception)
                    {
                    }
                }
                finally
                {
                    mySqlConnection.Close();
                }
            }
        }

        protected void getCalendario(object sender, EventArgs e)
        {
            string str = "";
            try
            {
                using (MySqlConnection mySqlConnection = new MySqlConnection(WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
                {
                    mySqlConnection.Open();
                    MySqlDataReader mySqlDataReader = null;
                    mySqlDataReader = (new MySqlCommand(string.Concat("select idfecha, cast(fecha as char)as fecha, cast(TIME_FORMAT(horaini, '%H:%i')as char)as horaini, cast(TIME_FORMAT(horafin, '%H:%i')as char)as horafin, concat(cast(TIME_FORMAT(horaini, '%H:%i')as char),' - ', cast(TIME_FORMAT(horafin, '%H:%i')as char)) as horario from fechascurso where idcurso = ", this.idP.Value, " order by fecha"), mySqlConnection)).ExecuteReader();
                    str = string.Concat(str, "[");
                    if (mySqlDataReader.HasRows)
                    {
                        while (mySqlDataReader.Read())
                        {
                            str = string.Concat(str, "{");
                            str = string.Concat(str, "id:'", mySqlDataReader["idfecha"].ToString(), "',");
                            str = string.Concat(str, "title:'", mySqlDataReader["horario"].ToString(), "',");
                            str = string.Concat(new string[] { str, "description:'", mySqlDataReader["horaini"].ToString(), " - ", mySqlDataReader["horafin"].ToString(), "'," });
                            str = string.Concat(str, "fecha:'", mySqlDataReader["fecha"].ToString(), "',");
                            str = string.Concat(str, "horaini:'", mySqlDataReader["horaini"].ToString(), "',");
                            str = string.Concat(str, "horafin:'", mySqlDataReader["horafin"].ToString(), "',");
                            str = string.Concat(str, "start:'", mySqlDataReader["fecha"].ToString(), "',");
                            str = string.Concat(str, "end:'", mySqlDataReader["fecha"].ToString(), "'");
                            str = string.Concat(str, "},");
                        }
                    }
                    str = string.Concat(str, "]");
                    mySqlDataReader.Close();
                }
            }
            catch (Exception exception)
            {
            }
            ScriptManager.RegisterStartupScript(this, base.GetType(), "inicilizarMun", string.Concat("dataEvent =", str), true);
        }

        protected void guardaEdita(object sender, EventArgs e)
        {
            using (MySqlConnection mySqlConnection = new MySqlConnection(WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {
                MySqlTransaction mySqlTransaction = null;
                try
                {
                    try
                    {
                        mySqlConnection.Open();
                        MySqlCommand mySqlCommand = mySqlConnection.CreateCommand();
                        mySqlTransaction = mySqlConnection.BeginTransaction();
                        mySqlCommand.Connection = mySqlConnection;
                        mySqlCommand.Transaction = mySqlTransaction;
                        if (Convert.ToInt32(this.idP.Value) != 0)
                        {
                            mySqlCommand.Parameters.Clear();
                            mySqlCommand.CommandText = string.Concat("update curso set nombre=@nombre, idcicloescolar=@idcicloescolar, idtipocurso=@idtipocurso, idarea=@idarea, idespecialidad=@idespecialidad, idinstructor=@idinstructor, idinstalacion=@idinstalacion, fechaini=@fechaini, fechafin=@fechafin, dias=@dias, horaini=@horaini, horafin=@horafin, horas=@horas,  costomodulo=@costomodulo, costo=@costo, pagohora=@pagohora, observaciones=@observaciones, diascurso=@diascurso, idtipooferta=@idtipooferta, instalacionext=@instalacionext, alumnosminimo=@alumnosminimo, fechalimite=@fechalimite, instalaciondomext=@instalaciondomext ", "where idcurso=@idcurso;");
                            mySqlCommand.Parameters.AddWithValue("@idcurso", this.idP.Value);
                            mySqlCommand.Parameters.AddWithValue("@idcicloescolar", 1);
                            mySqlCommand.Parameters.AddWithValue("@nombre", this.nombre.Text.ToUpper().Trim());
                            mySqlCommand.Parameters.AddWithValue("@idtipocurso", this.tipocurso.SelectedValue);
                            mySqlCommand.Parameters.AddWithValue("@idarea", this.area.SelectedValue);
                            mySqlCommand.Parameters.AddWithValue("@idespecialidad", this.especialidad.SelectedValue);
                            mySqlCommand.Parameters.AddWithValue("@idinstructor", this.instructor.SelectedValue);
                            mySqlCommand.Parameters.AddWithValue("@idinstalacion", this.instalacion.SelectedValue);
                            mySqlCommand.Parameters.AddWithValue("@fechaini", this.fechaini.Text);
                            mySqlCommand.Parameters.AddWithValue("@fechafin", this.fechafin.Text);
                            mySqlCommand.Parameters.AddWithValue("@dias", this.dias.Text);
                            mySqlCommand.Parameters.AddWithValue("@horaini", this.horaini.Text);
                            mySqlCommand.Parameters.AddWithValue("@horafin", this.horafin.Text);
                            mySqlCommand.Parameters.AddWithValue("@horas", this.horas.Text);
                            if (this.costomodulo.Text.Equals(""))
                            {
                                mySqlCommand.Parameters.AddWithValue("@costomodulo", "0");
                            }
                            else
                            {
                                mySqlCommand.Parameters.AddWithValue("@costomodulo", this.costomodulo.Text);
                            }
                            if (this.costoalumno.Text.Equals(""))
                            {
                                mySqlCommand.Parameters.AddWithValue("@costo", "0");
                            }
                            else
                            {
                                mySqlCommand.Parameters.AddWithValue("@costo", this.costoalumno.Text);
                            }
                            if (this.pagohora.Text.Equals(""))
                            {
                                mySqlCommand.Parameters.AddWithValue("@pagohora", "0");
                            }
                            else
                            {
                                mySqlCommand.Parameters.AddWithValue("@pagohora", this.pagohora.Text);
                            }
                            mySqlCommand.Parameters.AddWithValue("@observaciones", this.observaciones.Text.Trim());
                            mySqlCommand.Parameters.AddWithValue("@diascurso", this.hdias.Value);
                            mySqlCommand.Parameters.AddWithValue("@idtipooferta", this.tipooferta.SelectedValue);
                            mySqlCommand.Parameters.AddWithValue("@instalacionext", this.instalacionext.Text.ToUpper().Trim());
                            mySqlCommand.Parameters.AddWithValue("@instalaciondomext", this.instalaciondomext.Text.ToUpper().Trim());
                            mySqlCommand.Parameters.AddWithValue("@alumnosminimo", this.alumnosminimo.Text);
                            mySqlCommand.Parameters.AddWithValue("@fechalimite", this.fechalimite.Text);
                            mySqlCommand.ExecuteNonQuery();
                        }
                        else
                        {
                            mySqlCommand.Parameters.Clear();
                            mySqlCommand.CommandText = "insert into curso(idsucursal, idcicloescolar, nombre, idtipocurso, idarea, idespecialidad, idinstructor, idinstalacion, fechaini, fechafin, dias, horaini, horafin, horas, costomodulo, costo, pagohora, observaciones, estatus, pagado, diascurso, idtipooferta, instalacionext, alumnosminimo, fechalimite, instalaciondomext, solicita, autoriza, foto) values(@idsucursal, @idcicloescolar, @nombre, @idtipocurso, @idarea, @idespecialidad, @idinstructor, @idinstalacion, @fechaini, @fechafin, @dias, @horaini, @horafin, @horas, @costomodulo, @costo, @pagohora, @observaciones, 'EN CAPTURA', 0, @diascurso, @idtipooferta, @instalacionext, @alumnosminimo, @fechalimite, @instalaciondomext, (select encargado from sucursal where idsucursal=@idsucursal), 'PROF. GERSOM PÉREZ RAMÍREZ', @imagen); ";
                            mySqlCommand.Parameters.AddWithValue("@idcicloescolar", 1);
                            mySqlCommand.Parameters.AddWithValue("@idsucursal", this.idsucursal);
                            mySqlCommand.Parameters.AddWithValue("@nombre", this.nombre.Text.ToUpper().Trim());
                            mySqlCommand.Parameters.AddWithValue("@idtipocurso", this.tipocurso.SelectedValue);
                            mySqlCommand.Parameters.AddWithValue("@idarea", this.area.SelectedValue);
                            mySqlCommand.Parameters.AddWithValue("@idespecialidad", this.especialidad.SelectedValue);
                            mySqlCommand.Parameters.AddWithValue("@idinstructor", this.instructor.SelectedValue);
                            mySqlCommand.Parameters.AddWithValue("@idinstalacion", this.instalacion.SelectedValue);
                            mySqlCommand.Parameters.AddWithValue("@fechaini", this.fechaini.Text);
                            mySqlCommand.Parameters.AddWithValue("@fechafin", this.fechafin.Text);
                            mySqlCommand.Parameters.AddWithValue("@dias", this.dias.Text);
                            mySqlCommand.Parameters.AddWithValue("@horaini", this.horaini.Text);
                            mySqlCommand.Parameters.AddWithValue("@horafin", this.horafin.Text);
                            mySqlCommand.Parameters.AddWithValue("@horas", this.horas.Text);
                            if (this.costomodulo.Text.Equals(""))
                            {
                                mySqlCommand.Parameters.AddWithValue("@costomodulo", "0");
                            }
                            else
                            {
                                mySqlCommand.Parameters.AddWithValue("@costomodulo", this.costomodulo.Text);
                            }
                            if (this.costoalumno.Text.Equals(""))
                            {
                                mySqlCommand.Parameters.AddWithValue("@costo", "0");
                            }
                            else
                            {
                                mySqlCommand.Parameters.AddWithValue("@costo", this.costoalumno.Text);
                            }
                            if (this.pagohora.Text.Equals(""))
                            {
                                mySqlCommand.Parameters.AddWithValue("@pagohora", "0");
                            }
                            else
                            {
                                mySqlCommand.Parameters.AddWithValue("@pagohora", this.pagohora.Text);
                            }
                            mySqlCommand.Parameters.AddWithValue("@observaciones", this.observaciones.Text.Trim());
                            mySqlCommand.Parameters.AddWithValue("@diascurso", this.hdias.Value);
                            mySqlCommand.Parameters.AddWithValue("@idtipooferta", this.tipooferta.SelectedValue);
                            mySqlCommand.Parameters.AddWithValue("@instalacionext", this.instalacionext.Text.ToUpper().Trim());
                            mySqlCommand.Parameters.AddWithValue("@instalaciondomext", this.instalaciondomext.Text.ToUpper().Trim());
                            mySqlCommand.Parameters.AddWithValue("@alumnosminimo", this.alumnosminimo.Text);
                            mySqlCommand.Parameters.AddWithValue("@fechalimite", this.fechalimite.Text);
                            mySqlCommand.ExecuteNonQuery();
                        }
                        mySqlTransaction.Commit();
                        this.listadoClientes(sender, e);
                        ScriptManager.RegisterStartupScript(this, base.GetType(), "myScriptName", "cerrarLoading(); toastExito(); $('#winscripcion').modal('hide');", true);
                    }
                    catch (Exception exception1)
                    {
                        Exception exception = exception1;
                        mySqlTransaction.Rollback();
                        Console.WriteLine(string.Concat("error:", exception.ToString()));
                    }
                }
                finally
                {
                    mySqlConnection.Close();
                }
            }
        }

        protected void guardaEditaFechas(object sender, EventArgs e)
        {
            int num = 0;
            using (MySqlConnection mySqlConnection = new MySqlConnection(WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {
                MySqlTransaction mySqlTransaction = null;
                MySqlDataReader mySqlDataReader = null;
                try
                {
                    try
                    {
                        mySqlConnection.Open();
                        MySqlCommand mySqlCommand = mySqlConnection.CreateCommand();
                        mySqlTransaction = mySqlConnection.BeginTransaction();
                        mySqlCommand.Connection = mySqlConnection;
                        mySqlCommand.Transaction = mySqlTransaction;
                        mySqlCommand.Parameters.Clear();
                        mySqlCommand.CommandText = "update fechascurso set horaini=@horaini,  horafin=@horafin where idcurso=@idcurso and idfecha=@idfecha; ";
                        mySqlCommand.Parameters.AddWithValue("@idcurso", this.idP.Value);
                        mySqlCommand.Parameters.AddWithValue("@idfecha", this.idF.Value);
                        mySqlCommand.Parameters.AddWithValue("@horaini", this.horanini.Text);
                        mySqlCommand.Parameters.AddWithValue("@horafin", this.horanfin.Text);
                        mySqlCommand.ExecuteNonQuery();
                        mySqlCommand.Parameters.Clear();
                        mySqlCommand.CommandText = string.Concat("select sum(TIMESTAMPDIFF(HOUR, horaini, horafin))as horas from fechascurso where idcurso =", this.idP.Value, ";");
                        mySqlDataReader = mySqlCommand.ExecuteReader();
                        while (mySqlDataReader.Read())
                        {
                            num = mySqlDataReader.GetInt32(0);
                        }
                        mySqlDataReader.Close();
                        mySqlCommand.Parameters.Clear();
                        mySqlCommand.CommandText = "update curso set horas=@horas where idcurso=@idcurso; ";
                        mySqlCommand.Parameters.AddWithValue("@idcurso", this.idP.Value);
                        mySqlCommand.Parameters.AddWithValue("@horas", num);
                        mySqlCommand.ExecuteNonQuery();
                        this.horas.Text = num.ToString();
                        mySqlTransaction.Commit();
                        this.getCalendario(sender, e);
                        ScriptManager.RegisterStartupScript(this, base.GetType(), "myScriptName", "cerrarLoading();  $('#wfechas').modal('hide');", true);
                    }
                    catch (Exception exception1)
                    {
                        Exception exception = exception1;
                        mySqlTransaction.Rollback();
                        Console.WriteLine(string.Concat("error:", exception.ToString()));
                    }
                }
                finally
                {
                    mySqlConnection.Close();
                }
            }
        }

        protected void guardaEditaIns(object sender, EventArgs e)
        {
            using (MySqlConnection mySqlConnection = new MySqlConnection(WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {
                MySqlTransaction mySqlTransaction = null;
                string str = "";
                int lastInsertedId = 0;
                int num = 0;
                if (this.idA.Value.Equals(""))
                {
                    this.idA.Value = "0";
                }
                try
                {
                    try
                    {
                        mySqlConnection.Open();
                        MySqlCommand mySqlCommand = mySqlConnection.CreateCommand();
                        mySqlTransaction = mySqlConnection.BeginTransaction();
                        mySqlCommand.Connection = mySqlConnection;
                        mySqlCommand.Transaction = mySqlTransaction;
                        if (Convert.ToInt32(this.idA.Value) != 0)
                        {
                            mySqlCommand.Parameters.Clear();
                            str = "update alumno set idedocivil=@idedocivil, idescolaridad=@idescolaridad, nombre=@nombre, apaterno=@apaterno, amaterno=@amaterno, sexo=@sexo, nocontrol=@nocontrol, curp=@curp, telefono=@telefono,domicilio = @domicilio, colonia = @colonia, cp = @cp, identidad = @identidad, idmunicipio = @idmunicipio, fechanacimiento=@fechanacimiento, discapacidades=@discapacidades, empresa=@empresa, puesto=@puesto, antiguedad=@antiguedad, direccion=@direccion, telefonoempresa=@telefonoempresa, email=@email ";
                            string[] strArrays = this.hpicture.Value.Split(new char[] { ',' });
                            if ((int)strArrays.Length > 1)
                            {
                                str = string.Concat(str, ", foto=@imagen ");
                            }
                            str = string.Concat(str, "where idalumno = @idalumno; ");
                            mySqlCommand.CommandText = str;
                            mySqlCommand.Parameters.AddWithValue("@idalumno", this.idA.Value);
                            mySqlCommand.Parameters.AddWithValue("@idedocivil", this.edocivil.SelectedValue);
                            mySqlCommand.Parameters.AddWithValue("@idescolaridad", this.escolaridad.SelectedValue);
                            mySqlCommand.Parameters.AddWithValue("@nocontrol", this.nocontrol.Text.ToUpper().Trim());
                            mySqlCommand.Parameters.AddWithValue("@nombre", this.nombrealumno.Text.ToUpper().Trim());
                            mySqlCommand.Parameters.AddWithValue("@apaterno", this.apaterno.Text.ToUpper().Trim());
                            mySqlCommand.Parameters.AddWithValue("@amaterno", this.amaterno.Text.ToUpper().Trim());
                            mySqlCommand.Parameters.AddWithValue("@sexo", this.sexo.SelectedValue);
                            mySqlCommand.Parameters.AddWithValue("@curp", this.curp.Text.ToUpper().Trim());
                            mySqlCommand.Parameters.AddWithValue("@telefono", this.telefono.Text.Replace("-", "").Replace("(", "").Replace(") ", "").Trim());
                            mySqlCommand.Parameters.AddWithValue("@domicilio", this.domicilio.Text.ToUpper().Trim());
                            mySqlCommand.Parameters.AddWithValue("@colonia", this.colonia.Text.ToUpper().Trim());
                            mySqlCommand.Parameters.AddWithValue("@cp", this.cp.Text.ToUpper().Trim());
                            mySqlCommand.Parameters.AddWithValue("@identidad", this.entidad.SelectedValue);
                            mySqlCommand.Parameters.AddWithValue("@idmunicipio", this.municipio.SelectedValue);
                            mySqlCommand.Parameters.AddWithValue("@fechanacimiento", this.fechanacimiento.Text.ToUpper().Trim());
                            mySqlCommand.Parameters.AddWithValue("@discapacidades", this.tagsdiscap.Value);
                            mySqlCommand.Parameters.AddWithValue("@empresa", this.empresa.Text.ToUpper().Trim());
                            mySqlCommand.Parameters.AddWithValue("@antiguedad", this.antiguedad.Text.ToUpper().Trim());
                            mySqlCommand.Parameters.AddWithValue("@puesto", this.puesto.Text.ToUpper().Trim());
                            mySqlCommand.Parameters.AddWithValue("@direccion", this.domicilioempresa.Text.ToUpper().Trim());
                            mySqlCommand.Parameters.AddWithValue("@telefonoempresa", this.telefonoempresa.Text.ToUpper().Trim());
                            mySqlCommand.Parameters.AddWithValue("@email", this.email.Text.Trim());
                            if ((int)strArrays.Length > 1)
                            {
                                mySqlCommand.Parameters.Add("@imagen", MySqlDbType.MediumBlob);
                                byte[] numArray = Convert.FromBase64String(strArrays[1]);
                                mySqlCommand.Parameters["@imagen"].Value = numArray;
                            }
                            mySqlCommand.ExecuteNonQuery();
                        }
                        else
                        {
                            mySqlCommand.Parameters.Clear();
                            str = "insert into alumno(nocontrol, idedocivil, idescolaridad, nombre, apaterno, amaterno, sexo, curp, telefono, domicilio, colonia, cp, identidad, idmunicipio, fechanacimiento, activo, discapacidades, empresa, puesto, antiguedad, direccion, telefonoempresa, foto, email) values(@nocontrol, @idedocivil, @idescolaridad, @nombre, @apaterno, @amaterno, @sexo, @curp, @telefono, @domicilio, @colonia, @cp, @identidad, @idmunicipio, @fechanacimiento, 1, @discapacidades, @empresa, @puesto, @antiguedad, @direccion, @telefonoempresa, @imagen, @email);";
                            mySqlCommand.CommandText = str;
                            mySqlCommand.Parameters.AddWithValue("@idedocivil", this.edocivil.SelectedValue);
                            mySqlCommand.Parameters.AddWithValue("@idescolaridad", this.escolaridad.SelectedValue);
                            mySqlCommand.Parameters.AddWithValue("@nocontrol", this.nocontrol.Text.ToUpper().Trim());
                            mySqlCommand.Parameters.AddWithValue("@nombre", this.nombrealumno.Text.ToUpper().Trim());
                            mySqlCommand.Parameters.AddWithValue("@apaterno", this.apaterno.Text.ToUpper().Trim());
                            mySqlCommand.Parameters.AddWithValue("@amaterno", this.amaterno.Text.ToUpper().Trim());
                            mySqlCommand.Parameters.AddWithValue("@sexo", this.sexo.SelectedValue);
                            mySqlCommand.Parameters.AddWithValue("@curp", this.curp.Text.ToUpper().Trim());
                            mySqlCommand.Parameters.AddWithValue("@telefono", this.telefono.Text.Replace("-", "").Replace("(", "").Replace(") ", "").Trim());
                            mySqlCommand.Parameters.AddWithValue("@domicilio", this.domicilio.Text.ToUpper().Trim());
                            mySqlCommand.Parameters.AddWithValue("@colonia", this.colonia.Text.ToUpper().Trim());
                            mySqlCommand.Parameters.AddWithValue("@cp", this.cp.Text.ToUpper().Trim());
                            mySqlCommand.Parameters.AddWithValue("@identidad", this.entidad.SelectedValue);
                            mySqlCommand.Parameters.AddWithValue("@idmunicipio", this.municipio.SelectedValue);
                            mySqlCommand.Parameters.AddWithValue("@fechanacimiento", this.fechanacimiento.Text.ToUpper().Trim());
                            mySqlCommand.Parameters.AddWithValue("@discapacidades", this.tagsdiscap.Value);
                            mySqlCommand.Parameters.AddWithValue("@empresa", this.empresa.Text.ToUpper().Trim());
                            mySqlCommand.Parameters.AddWithValue("@antiguedad", this.antiguedad.Text.ToUpper().Trim());
                            mySqlCommand.Parameters.AddWithValue("@puesto", this.puesto.Text.ToUpper().Trim());
                            mySqlCommand.Parameters.AddWithValue("@direccion", this.domicilioempresa.Text.ToUpper().Trim());
                            mySqlCommand.Parameters.AddWithValue("@telefonoempresa", this.telefonoempresa.Text.ToUpper().Trim());
                            mySqlCommand.Parameters.AddWithValue("@email", this.email.Text.Trim());
                            string[] strArrays1 = this.hpicture.Value.Split(new char[] { ',' });
                            if ((int)strArrays1.Length <= 1)
                            {
                                mySqlCommand.Parameters.Add("@imagen", MySqlDbType.MediumBlob);
                                mySqlCommand.Parameters["@imagen"].Value = null;
                            }
                            else
                            {
                                byte[] numArray1 = Convert.FromBase64String(strArrays1[1]);
                                mySqlCommand.Parameters.Add("@imagen", MySqlDbType.MediumBlob);
                                mySqlCommand.Parameters["@imagen"].Value = numArray1;
                            }
                            mySqlCommand.ExecuteNonQuery();
                            lastInsertedId = (int)mySqlCommand.LastInsertedId;
                            this.idA.Value = lastInsertedId.ToString();
                        }
                        if (Convert.ToInt32(this.idI.Value) != 0)
                        {
                            mySqlCommand.Parameters.Clear();
                            str = "update solicitudinscripcion set    becado = @becado, idescolaridad = @idescolaridad, idconvenio=@idconvenio, medios=@medios, motivos=@motivos, jefafamilia=@jefafamilia, indigena=@indigena, porcentaje=@porcentaje, condicioncalle=@condicioncalle where idsolicitud=@idsolicitud; ";
                            mySqlCommand.CommandText = str;
                            mySqlCommand.Parameters.AddWithValue("@idsolicitud", this.idI.Value);
                            mySqlCommand.Parameters.AddWithValue("@becado", this.apoyo.SelectedValue);
                            mySqlCommand.Parameters.AddWithValue("@idescolaridad", this.escolaridad.SelectedValue);
                            mySqlCommand.Parameters.AddWithValue("@idconvenio", this.convenio.SelectedValue);
                            mySqlCommand.Parameters.AddWithValue("@medios", this.tagsmed.Value);
                            mySqlCommand.Parameters.AddWithValue("@motivos", this.tagsmot.Value);
                            mySqlCommand.Parameters.AddWithValue("@jefafamilia", this.jefafamilia.SelectedValue);
                            mySqlCommand.Parameters.AddWithValue("@indigena", this.indigena.SelectedValue);
                            mySqlCommand.Parameters.AddWithValue("@condicioncalle", this.condicioncalle.SelectedValue);
                            mySqlCommand.Parameters.AddWithValue("@porcentaje", this.porcentaje.Text);
                            mySqlCommand.ExecuteNonQuery();
                        }
                        else
                        {
                            mySqlCommand.Parameters.Clear();
                            str = "insert into solicitudinscripcion(idsucursal,idalumno,idusuario, fecha, hora, pagado, costo,  becado, idcondicion, idescolaridad, idconvenio, idcurso, medios, motivos, jefafamilia, indigena, porcentaje, condicioncalle) values(@idsucursal, @idalumno, @idusuario, curdate(), curtime(), 0, 0, @becado, 1, @idescolaridad, @idconvenio, @idccurso, @medios, @motivos, @jefafamilia, @indigena, @porcentaje, @condicioncalle); ";
                            mySqlCommand.CommandText = str;
                            mySqlCommand.Parameters.AddWithValue("@idsucursal", this.idsucursal);
                            mySqlCommand.Parameters.AddWithValue("@idalumno", this.idA.Value);
                            mySqlCommand.Parameters.AddWithValue("@idusuario", this.idusuario);
                            mySqlCommand.Parameters.AddWithValue("@idccurso", this.idP.Value);
                            mySqlCommand.Parameters.AddWithValue("@becado", this.apoyo.SelectedValue);
                            mySqlCommand.Parameters.AddWithValue("@idescolaridad", this.escolaridad.SelectedValue);
                            mySqlCommand.Parameters.AddWithValue("@idconvenio", this.convenio.SelectedValue);
                            mySqlCommand.Parameters.AddWithValue("@medios", this.tagsmed.Value);
                            mySqlCommand.Parameters.AddWithValue("@motivos", this.tagsmot.Value);
                            mySqlCommand.Parameters.AddWithValue("@jefafamilia", this.jefafamilia.SelectedValue);
                            mySqlCommand.Parameters.AddWithValue("@indigena", this.indigena.SelectedValue);
                            mySqlCommand.Parameters.AddWithValue("@condicioncalle", this.condicioncalle.SelectedValue);
                            mySqlCommand.Parameters.AddWithValue("@porcentaje", this.porcentaje.Text);
                            mySqlCommand.ExecuteNonQuery();
                            num = (int)mySqlCommand.LastInsertedId;
                            this.idI.Value = num.ToString();
                        }
                        mySqlCommand.Parameters.Clear();
                        str = "delete from cursodocumentacion where idsolicitud=@idsolicitud; ";
                        mySqlCommand.CommandText = str;
                        mySqlCommand.Parameters.AddWithValue("@idsolicitud", this.idI.Value);
                        mySqlCommand.ExecuteNonQuery();
                        string[] strArrays2 = this.tagsdoc.Value.Split(new char[] { ',' });
                        for (int i = 0; i < (int)strArrays2.Length; i++)
                        {
                            string str1 = strArrays2[i];
                            if (!str1.Equals(""))
                            {
                                mySqlCommand.Parameters.Clear();
                                str = "insert into cursodocumentacion(iddocumentacion, idsolicitud) values(@iddocumentacion, @idsolicitud); ";
                                mySqlCommand.CommandText = str;
                                mySqlCommand.Parameters.AddWithValue("@iddocumentacion", Convert.ToInt32(str1));
                                mySqlCommand.Parameters.AddWithValue("@idsolicitud", this.idI.Value);
                                mySqlCommand.ExecuteNonQuery();
                            }
                        }
                        mySqlTransaction.Commit();
                        this.listadoAlumnos(sender, e);
                        this.listadoAlumnosBus(sender, e);
                        this.listadoDocumentacion(sender, e);
                        ScriptManager.RegisterStartupScript(this, base.GetType(), "myScriptName", "cerrarLoading(); toastExito(); $('#winscripcion').modal('hide');", true);
                    }
                    catch (Exception exception1)
                    {
                        Exception exception = exception1;
                        mySqlTransaction.Rollback();
                        Console.WriteLine(string.Concat("error:", exception.ToString()));
                    }
                }
                finally
                {
                    mySqlConnection.Close();
                }
            }
        }

        protected void gUsuarios_RowCreated(object sender, GridViewRowEventArgs e)
        {
        }

        protected void gUsuarios_SelectedIndexChanged(object sender, EventArgs e)
        {
        }

        protected void imprimeCredencial(object sender, EventArgs e)
        {
            Credencial credencial = new Credencial();
            credencial.ReportParameters["idsolicitud"].Value = this.idI.Value;
            string str = string.Concat("Credencial ", this.idctr.Value);
            this.ExportToPDF(credencial, str);
        }

        protected void imprimeDiploma(object sender, EventArgs e)
        {
            Diploma diploma = new Diploma();
            diploma.ReportParameters["idsolicitud"].Value = this.idI.Value;
            string str = string.Concat("Diploma ", this.idctr.Value);
            this.ExportToPDF(diploma, str);
        }

        protected void imprimeSolicitud(object sender, EventArgs e)
        {
            SolicitudInscripcion solicitudInscripcion = new SolicitudInscripcion();
            solicitudInscripcion.ReportParameters["idsolicitud"].Value = this.idI.Value;
            solicitudInscripcion.ReportParameters["idalumno"].Value = this.idA.Value;
            string str = string.Concat("Solicitud Inscripción ", this.idctr.Value);
            this.ExportToPDF(solicitudInscripcion, str);
        }

        protected void imprimeSolicitudAut(object sender, EventArgs e)
        {
            SolicitudInscripcion solicitudInscripcion = new SolicitudInscripcion();
            solicitudInscripcion.ReportParameters["idsolicitud"].Value = this.idI.Value;
            solicitudInscripcion.ReportParameters["idalumno"].Value = this.idA.Value;
            string str = string.Concat("Credencial ", this.idctr.Value);
            this.ExportToPDF(solicitudInscripcion, str);
        }

        protected void insertaFechas(object sender, EventArgs e)
        {
        }

        protected void instalacion_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (this.instalacion.SelectedValue == "9999")
            {
                this.extramuros.Visible = true;
                return;
            }
            this.extramuros.Visible = false;
        }

        protected void limpiarCampos(object sender, EventArgs e)
        {
            string str = "";
            try
            {
                this.idA.Value = "0";
                this.nombrealumno.Text = "";
                this.nocontrol.Text = "";
                this.nombrealumno.Text = "";
                this.apaterno.Text = "";
                this.amaterno.Text = "";
                this.sexo.ClearSelection();
                this.curp.Text = "";
                this.domicilio.Text = "";
                this.telefono.Text = "";
                this.colonia.Text = "";
                this.cp.Text = "";
                this.entidad.ClearSelection();
                this.municipio.ClearSelection();
                this.fechanacimiento.Text = "";
                this.escolaridad.ClearSelection();
            }
            catch (Exception exception)
            {
            }
            ScriptManager.RegisterStartupScript(this, base.GetType(), "myScriptName", "cerrarLoading(); $('#tabgenerales').click(); $('#winscripcion').modal('show');  $('#fc-basic-views').fullCalendar('render'); dar(); ", true);
            ScriptManager.RegisterStartupScript(this, base.GetType(), "inicilizarMun", string.Concat("dataEvent =", str), true);
        }

        protected void limpiarCamposInscripcion(object sender, EventArgs e)
        {
            try
            {
                this.idA.Value = "0";
                this.idI.Value = "0";
                this.nocontrol.Text = "";
                this.apaterno.Text = "";
                this.amaterno.Text = "";
                this.nombrealumno.Text = "";
                this.curp.Text = "";
                this.fechanacimiento.Text = "";
                this.telefono.Text = "";
                this.sexo.ClearSelection();
                this.domicilio.Text = "";
                this.colonia.Text = "";
                this.cp.Text = "";
                this.entidad.ClearSelection();
                this.DSentidades.DataBind();
                this.municipio.DataBind();
                this.municipio.ClearSelection();
                this.edocivil.ClearSelection();
                this.xxdiscapacidad.ClearSelection();
                this.curso.SelectedValue = this.idP.Value;
                this.escolaridad.ClearSelection();
                this.empresa.Text = "";
                this.puesto.Text = "";
                this.antiguedad.Text = "";
                this.domicilioempresa.Text = "";
                this.telefonoempresa.Text = "";
                this.xxdiscapacidad.ClearSelection();
                this.medio.ClearSelection();
                this.motivo.ClearSelection();
                this.otromed.Text = "";
                this.otromot.Text = "";
                this.tagsdiscap.Value = "";
                this.tagsmed.Value = "";
                this.tagsmot.Value = "";
                this.jefafamilia.ClearSelection();
                this.indigena.ClearSelection();
                this.porcentaje.Text = "";
                this.listadoDocumentacion(sender, e);
                this.divConv.Visible = false;
            }
            catch (Exception exception)
            {
            }
            ScriptManager.RegisterStartupScript(this, base.GetType(), "myScriptName", "cerrarLoading(); $('#tabgenerales').click(); $('#winscripcion').modal('show'); cargatags(); ", true);
        }

        protected void listadoAlumnos(object sender, EventArgs e)
        {
            try
            {
                this.GValumnos.DataSourceID = this.DSalumnos.ID;
                string str = string.Concat("select al.idalumno, al.nocontrol, si.idsolicitud, si.estatus, concat(al.apaterno,' ', al.amaterno,' ', al.nombre)as nombrealumno, case si.becado when 1 then round(c.costo -c.costo * (si.porcentaje / 100),2) else c.costo end as costoalumno, si.folio,  cast(si.fecha as char)as fecha, si.observaciones as observacionesalumno, c.estatus as cursoestatus  from alumno al  left join solicitudinscripcion si on si.idalumno = al.idalumno  left join curso c on si.idcurso = c.idcurso  where si.idcurso = ", this.idP.Value, " and si.estatus not in('CANCELADO') ");
                if (this.busnom.Text.Trim() != "")
                {
                    str = string.Concat(str, " and concat(al.apaterno,' ',al.amaterno,' ',al.nombre) LIKE '%", this.busnom.Text.Trim().ToUpper(), "%' ");
                }
                str = string.Concat(str, " order by nombrealumno");
                this.DSalumnos.SelectCommand = str;
                this.lbcurso.Text = this.labelCurso.Value;
                if (this.idP.Value != "0")
                {
                    this.nuevo.Visible = true;
                    this.barrabus.Visible = true;
                }
                else
                {
                    this.nuevo.Visible = false;
                    this.barrabus.Visible = false;
                }
                ScriptManager.RegisterClientScriptBlock(this.Page, typeof(string), "myScriptName", "cerrarLoading();", true);
            }
            catch (Exception exception)
            {
            }
        }

        protected void listadoAlumnosBus(object sender, EventArgs e)
        {
            try
            {
                this.GVlistaalumnos.DataSourceID = this.DSlistaalumnos.ID;
                string str = string.Concat("select a.idalumno, a.nocontrol, concat(a.apaterno,' ',a.amaterno,' ',a.nombre)as ncompleto, a.sexo, a.fechanacimiento, ( select count(s.idalumno) from solicitudinscripcion s where s.idcurso = ", this.idP.Value, " and s.idalumno = a.idalumno ) as registrado from alumno a where true ");
                if (this.bnombre.Text.Trim() != "")
                {
                    str = string.Concat(str, " and concat(a.apaterno,' ',a.amaterno,' ',a.nombre) LIKE '%", this.bnombre.Text.Trim().ToUpper(), "%' ");
                }
                str = string.Concat(str, " order by a.apaterno, a.amaterno, a.nombre");
                this.DSlistaalumnos.SelectCommand = str;
                this.DSlistaalumnos.DataBind();
                this.GVlistaalumnos.DataBind();
                if (this.GVlistaalumnos.Rows.Count <= 0)
                {
                    this.divResultados.Visible = true;
                }
                else
                {
                    this.divResultados.Visible = false;
                }
            }
            catch (Exception exception)
            {
            }
        }

        protected void listadoClientes(object sender, EventArgs e)
        {
        }

        protected void listadoDocumentacion(object sender, EventArgs e)
        {
            try
            {
                this.GVdocumentacion.DataSourceID = this.DSdocumentacion.ID;
                string str = string.Concat(new string[] { "select d.iddocumentacion, d.documentacion, ( select count(c.iddocumentacion) from cursodocumentacion c where c.idsolicitud = ", this.idI.Value, " and c.iddocumentacion = d.iddocumentacion )as entregado, (select movilidad from curso where idcurso=", this.idP.Value, ")as movilidad, (select enlinea from curso where idcurso=", this.idP.Value, ")as enlinea from documentacion d order by d.documentacion" });
                this.DSdocumentacion.SelectCommand = str;
            }
            catch (Exception exception)
            {
            }
        }

        protected void listadoFechas(object sender, EventArgs e)
        {
            try
            {
                this.listadoDocumentacion(sender, e);
                ScriptManager.RegisterStartupScript(this, base.GetType(), "myScriptName", "cerrarLoading();  $('#winscripcion').modal('show'); cargatags(); ", true);
            }
            catch (Exception exception)
            {
            }
        }

        protected void listadoGrupos(object sender, EventArgs e)
        {
            try
            {
                this.lgrupos.DataSourceID = this.DSgrupos.ID;
                string str = "select c.idcurso, c.idsucursal, coalesce(c.nombre,'NO DEFINIDO')as nombre,  coalesce(a.area,'AREA NO ASIGNADA') as area,  coalesce(e.especialidad,'ESPECIALIDAD NO ASIGNADA')as especialidad,  coalesce(i.nombre,'INSTRUCTOR NO DEFINIDO') as instructor, t.tipocurso, c.estatus, c.costo, cast(c.fechaini as char)as fechaini, cast(c.fechafin as char)as fechafin, cast(TIME_FORMAT(c.horaini, '%h:%i %p') as char)as horaini, cast(TIME_FORMAT(c.horafin, '%h:%i %p') as char)as horafin,  c.alumnosminimo, (select count(s.idalumno) from solicitudinscripcion s where s.idcurso = c.idcurso) as inscritos, s.nombre as plantel from curso c left join area a on a.idarea = c.idarea left join especialidad e on e.idespecialidad = c.idespecialidad left join tipocurso t on t.idtipocurso = c.idtipocurso left join instructor i on i.idinstructor = c.idinstructor left join sucursal s on s.idsucursal = c.idsucursal where c.tipo='C' and c.estatus in('EN CAPTURA','EN REVISION','OBSERVADO','AUTORIZADO', 'FINALIZADO') ";
                if (!this.bplantel.Visible)
                {
                    str = string.Concat(new object[] { str, " and c.idsucursal = ", this.idsucursal, " " });
                }
                else if (!this.bplantel.SelectedValue.Equals("0"))
                {
                    str = string.Concat(str, " and c.idsucursal=", this.bplantel.SelectedValue, " ");
                }
                if (this.bname.Text.Trim() != "")
                {
                    str = string.Concat(str, " and c.nombre LIKE '%", this.bname.Text.Trim().ToUpper(), "%' ");
                }
                str = string.Concat(str, " order by c.idsucursal, c.nombre");
                this.DSgrupos.SelectCommand = str;
                this.listadoAlumnos(sender, e);
            }
            catch (Exception exception)
            {
            }
        }

        protected void lusuarios_Sorting(object sender, GridViewSortEventArgs e)
        {
            e.SortDirection.ToString().Equals("Ascending");
        }

        protected void nuevoRegistro(object sender, EventArgs e)
        {
            this.Session["idP"] = 0;
            this.Session["idS"] = this.idS.Value;
            base.Response.Redirect("~/catalogos/directorio/frminstructor.aspx");
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            string[] strArrays = ((FormsIdentity)this.Page.User.Identity).Ticket.UserData.Split(new char[] { ',' });
            string[] strArrays1 = strArrays[1].Split(new char[] { ';' });
            this.idusuario = Convert.ToInt32(strArrays[0]);
            this.idsucursal = Convert.ToInt32(strArrays1[4]);
            this.idS.Value = this.idsucursal.ToString();
            if (strArrays1[3].ToString().IndexOf('1', 0) < 0)
            {
                this.busplantel.Visible = false;
            }
            else
            {
                this.busplantel.Visible = true;
            }
            if (!base.IsPostBack)
            {
                this.listadoAlumnos(sender, e);
                this.listadoGrupos(sender, e);
                this.nuevo.Visible = false;
                this.barrabus.Visible = false;
            }
            if (this.lbcurso.Text.Equals(""))
            {
                this.lbcurso.Text = "SELECCIONE UN CURSO";
            }
            ScriptManager.RegisterStartupScript(this, base.GetType(), "actu", "cargatags(); ", true);
        }

        protected void recuperaSolicitud(object sender, EventArgs e)
        {
            try
            {
                using (MySqlConnection mySqlConnection = new MySqlConnection(WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
                {
                    mySqlConnection.Open();
                    this.fotopa.ImageUrl = "";
                    MySqlDataReader mySqlDataReader = (new MySqlCommand(string.Concat("select a.idalumno, a.nocontrol, a.nombre, a.apaterno, a.amaterno, a.sexo, a.curp, cast(a.fechanacimiento as char)as fechanacimiento, a.telefono, a.empresa, a.puesto, a.antiguedad, a.direccion , a.telefonoempresa, a.domicilio, a.colonia, a.cp, a.identidad, a.idmunicipio, a.idedocivil, a.idescolaridad, s.becado, s.idconvenio, s.idcurso, a.email, coalesce(a.discapacidades, '') as discapacidades, c.idespecialidad, c.idcurso, coalesce(s.medios, '') as medios, s.otromedio, coalesce(s.motivos, '') as motivos, s.otromotivo, s.jefafamilia, s.indigena, s.porcentaje, a.foto, s.condicioncalle from solicitudinscripcion s left join alumno a on a.idalumno = s.idalumno left join curso c on s.idcurso = c.idcurso where s.idsolicitud = ", this.idI.Value), mySqlConnection)).ExecuteReader();
                    if (!mySqlDataReader.HasRows)
                    {
                        this.nocontrol.Text = "";
                        this.nombrealumno.Text = "";
                        this.apaterno.Text = "";
                        this.amaterno.Text = "";
                        this.sexo.ClearSelection();
                        this.curp.Text = "";
                        this.domicilio.Text = "";
                        this.telefono.Text = "";
                        this.colonia.Text = "";
                        this.cp.Text = "";
                        this.entidad.SelectedValue = "17";
                        this.DSmunicipios.DataBind();
                        this.municipio.DataBind();
                        this.fechanacimiento.Text = "";
                        this.escolaridad.ClearSelection();
                        this.tagsdiscap.Value = "";
                        this.tagsmed.Value = "";
                        this.otromed.Text = "";
                        this.tagsmot.Value = "";
                        this.otromot.Text = "";
                        this.apoyo.ClearSelection();
                        this.empresa.Text = "";
                        this.puesto.Text = "";
                        this.antiguedad.Text = "";
                        this.domicilioempresa.Text = "";
                        this.telefonoempresa.Text = "";
                        this.convenio.ClearSelection();
                        this.divConv.Visible = false;
                        this.curso.SelectedValue = this.idP.Value;
                        this.jefafamilia.ClearSelection();
                        this.indigena.ClearSelection();
                        this.condicioncalle.ClearSelection();
                        this.porcentaje.Text = "0";
                        this.email.Text = "";
                    }
                    else
                    {
                        mySqlDataReader.Read();
                        this.nocontrol.Text = mySqlDataReader["nocontrol"].ToString();
                        this.nombrealumno.Text = mySqlDataReader["nombre"].ToString();
                        this.apaterno.Text = mySqlDataReader["apaterno"].ToString();
                        this.amaterno.Text = mySqlDataReader["amaterno"].ToString();
                        this.sexo.SelectedValue = mySqlDataReader["sexo"].ToString();
                        this.curp.Text = mySqlDataReader["curp"].ToString();
                        this.domicilio.Text = mySqlDataReader["domicilio"].ToString();
                        this.telefono.Text = mySqlDataReader["telefono"].ToString();
                        this.colonia.Text = mySqlDataReader["colonia"].ToString();
                        this.cp.Text = mySqlDataReader["cp"].ToString();
                        this.entidad.SelectedValue = mySqlDataReader["identidad"].ToString();
                        this.DSmunicipios.DataBind();
                        this.municipio.DataBind();
                        this.municipio.SelectedValue = mySqlDataReader["idmunicipio"].ToString();
                        this.fechanacimiento.Text = mySqlDataReader["fechanacimiento"].ToString();
                        this.escolaridad.SelectedValue = mySqlDataReader["idescolaridad"].ToString();
                        this.tagsdiscap.Value = mySqlDataReader["discapacidades"].ToString();
                        this.tagsmed.Value = mySqlDataReader["medios"].ToString();
                        this.otromed.Text = mySqlDataReader["otromedio"].ToString();
                        this.tagsmot.Value = mySqlDataReader["motivos"].ToString();
                        this.otromot.Text = mySqlDataReader["otromotivo"].ToString();
                        this.apoyo.SelectedValue = mySqlDataReader["becado"].ToString();
                        this.empresa.Text = mySqlDataReader["empresa"].ToString();
                        this.puesto.Text = mySqlDataReader["puesto"].ToString();
                        this.antiguedad.Text = mySqlDataReader["antiguedad"].ToString();
                        this.domicilioempresa.Text = mySqlDataReader["direccion"].ToString();
                        this.telefonoempresa.Text = mySqlDataReader["telefonoempresa"].ToString();
                        if (mySqlDataReader["idconvenio"].GetType() != typeof(DBNull))
                        {
                            this.convenio.SelectedValue = mySqlDataReader["idconvenio"].ToString();
                        }
                        if (this.apoyo.SelectedValue != "1")
                        {
                            this.divConv.Visible = false;
                        }
                        else
                        {
                            this.divConv.Visible = true;
                        }
                        this.curso.SelectedValue = mySqlDataReader["idcurso"].ToString();
                        this.jefafamilia.SelectedValue = mySqlDataReader["jefafamilia"].ToString();
                        this.indigena.SelectedValue = mySqlDataReader["indigena"].ToString();
                        this.condicioncalle.SelectedValue = mySqlDataReader["condicioncalle"].ToString();
                        this.porcentaje.Text = mySqlDataReader["porcentaje"].ToString();
                        this.email.Text = mySqlDataReader["email"].ToString();
                        if (mySqlDataReader["foto"].GetType() != typeof(DBNull))
                        {
                            byte[] item = (byte[])mySqlDataReader["foto"];
                            if (item != null)
                            {
                                this.fotopa.ImageUrl = string.Concat("data:image/jpeg;base64,", Convert.ToBase64String(item));
                                this.fotopa.DataBind();
                            }
                        }
                    }
                    mySqlDataReader.Close();
                    this.listadoDocumentacion(sender, e);
                    ScriptManager.RegisterStartupScript(this, base.GetType(), "myScriptName", "cerrarLoading();  $('#tabgenerales').click(); $('#winscripcion').modal('show'); cargatags(); ", true);
                }
            }
            catch (Exception exception)
            {
            }
        }

        protected void refrescaGrid(object sender, EventArgs e)
        {
        }

        protected void solicitaAutorizacion(object sender, EventArgs e)
        {
            using (MySqlConnection mySqlConnection = new MySqlConnection(WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {
                MySqlTransaction mySqlTransaction = null;
                try
                {
                    try
                    {
                        mySqlConnection.Open();
                        MySqlCommand mySqlCommand = mySqlConnection.CreateCommand();
                        mySqlTransaction = mySqlConnection.BeginTransaction();
                        mySqlCommand.Connection = mySqlConnection;
                        mySqlCommand.Transaction = mySqlTransaction;
                        mySqlCommand.Parameters.Clear();
                        mySqlCommand.CommandText = "update curso set estatus='EN REVISION' where idcurso=@idcurso;";
                        mySqlCommand.Parameters.AddWithValue("@idcurso", this.idP.Value);
                        mySqlCommand.ExecuteNonQuery();
                        mySqlTransaction.Commit();
                        this.listadoClientes(sender, e);
                        ScriptManager.RegisterStartupScript(this, base.GetType(), "myScriptName", "cerrarLoading(); $('#bootstrap').modal('hide');", true);
                    }
                    catch (Exception exception1)
                    {
                        Exception exception = exception1;
                        mySqlTransaction.Rollback();
                        Console.WriteLine(string.Concat("error:", exception.ToString()));
                    }
                }
                finally
                {
                    mySqlConnection.Close();
                }
            }
        }
    }
}