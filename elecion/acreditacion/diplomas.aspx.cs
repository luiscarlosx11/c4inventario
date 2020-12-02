using elecion;
using MySql.Data.MySqlClient;
using ReportLibrary;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Security.Principal;
using System.Web;
using System.Web.Configuration;
using System.Web.Security;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using Telerik.Reporting;
using Telerik.Reporting.Processing;

namespace elecion.acreditacion
{
    public partial class diplomas: System.Web.UI.Page
    {
        private int idsucursal;
        private int idusuario;
        private int idtipousuario;

       

        protected void Page_Load(object sender, EventArgs e)
        {
            string[] datos = ((FormsIdentity)this.Page.User.Identity).Ticket.UserData.Split(new char[] { ',' });
            string[] datos2 = datos[1].Split(new char[] { ';' });
            this.idusuario = Convert.ToInt32(datos[0]);
            this.idsucursal = Convert.ToInt32(datos2[4]);
            this.idS.Value = this.idsucursal.ToString();
            if (datos2[3].ToString().IndexOf('1', 0) < 0)
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
            }
            if (this.lbcurso.Text.Equals(""))
            {
                this.lbcurso.Text = "SELECCIONE UN CURSO";
            }
            ScriptManager.RegisterStartupScript(this, base.GetType(), "actu", "cargatags(); ", true);
        }

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
            using (MySqlConnection con = new MySqlConnection(WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {
                MySqlTransaction transaction = null;
                string estat = "";
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
                        mySqlCommand.CommandText = "update solicitudinscripcion set idtipodesercion=@idtipodesercion, motivocancelacion=@motivocancelacion, estatus=@estatus where idsolicitud=@idI;";
                        mySqlCommand.Parameters.AddWithValue("@idI", this.idI.Value);
                        mySqlCommand.Parameters.AddWithValue("@idtipodesercion", this.desercion.SelectedValue);
                        mySqlCommand.Parameters.AddWithValue("@motivocancelacion", this.motcancelacion.Text.ToUpper());
                        if (this.desercion.SelectedValue.Equals("1"))
                        {
                            estat = "CANCELADO";
                        }
                        else if (this.desercion.SelectedValue.Equals("2"))
                        {
                            estat = "DESERCIÓN";
                        }
                        mySqlCommand.Parameters.AddWithValue("@estatus", estat);
                        mySqlCommand.ExecuteNonQuery();
                        transaction.Commit();
                        this.listadoAlumnos(sender, e);
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
                        MySqlDataReader rdr = (new MySqlCommand(string.Concat("SELECT COUNT(al.idalumno) as total  from alumno al  left join solicitudinscripcion si on si.idalumno = al.idalumno  where si.idcurso = ", this.idP.Value, " "), con2)).ExecuteReader();
                        if (rdr.HasRows)
                        {
                            rdr.Read();
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

        protected void finalizaCurso(object sender, EventArgs e)
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
                        mySqlCommand.CommandText = "update curso set estatus='FINALIZADO' where idcurso=@idP;";
                        mySqlCommand.Parameters.AddWithValue("@idP", this.idP.Value);
                        mySqlCommand.ExecuteNonQuery();
                        transaction.Commit();
                        this.listadoAlumnos(sender, e);
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

        protected void generaFechasCurso(object sender, EventArgs e)
        {
            using (MySqlConnection con = new MySqlConnection(WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {
                MySqlTransaction transaction = null;
                MySqlDataReader reader = null;
                string query = "";
                int idfecha = 0;
                int idcurso = 0;
                int nohoras = 0;
                List<fechascurso> listafechas = null;
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
                            cmd.CommandText = string.Concat("update curso set nombre=@nombre, idcicloescolar=@idcicloescolar, idtipocurso=@idtipocurso, idarea=@idarea, idespecialidad=@idespecialidad, idinstructor=@idinstructor, idinstalacion=@idinstalacion, fechaini=@fechaini, fechafin=@fechafin, dias=@dias, horaini=@horaini, horafin=@horafin, horas=@horas,  costomodulo=@costomodulo, costo=@costo, pagohora=@pagohora, observaciones=@observaciones, diascurso=@diascurso, idtipooferta=@idtipooferta, instalacionext=@instalacionext, alumnosminimo=@alumnosminimo, fechalimite=@fechalimite, instalaciondomext=@instalaciondomext ", "where idcurso=@idcurso;");
                            cmd.Parameters.AddWithValue("@idcurso", this.idP.Value);
                            cmd.Parameters.AddWithValue("@idcicloescolar", 1);
                            cmd.Parameters.AddWithValue("@nombre", this.nombre.Text.ToUpper().Trim());
                            cmd.Parameters.AddWithValue("@idtipocurso", this.tipocurso.SelectedValue);
                            cmd.Parameters.AddWithValue("@idarea", this.area.SelectedValue);
                            cmd.Parameters.AddWithValue("@idespecialidad", this.especialidad.SelectedValue);
                            cmd.Parameters.AddWithValue("@idinstructor", this.instructor.SelectedValue);
                            cmd.Parameters.AddWithValue("@idinstalacion", this.instalacion.SelectedValue);
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
                            cmd.Parameters.AddWithValue("@idtipooferta", this.tipooferta.SelectedValue);
                            cmd.Parameters.AddWithValue("@instalacionext", this.instalacionext.Text.ToUpper().Trim());
                            cmd.Parameters.AddWithValue("@instalaciondomext", this.instalaciondomext.Text.ToUpper().Trim());
                            cmd.Parameters.AddWithValue("@alumnosminimo", this.alumnosminimo.Text);
                            cmd.Parameters.AddWithValue("@fechalimite", this.fechalimite.Text);
                            cmd.ExecuteNonQuery();
                        }
                        else
                        {
                            cmd.Parameters.Clear();
                            cmd.CommandText = "insert into curso(idsucursal, idcicloescolar, nombre, idtipocurso, idarea, idespecialidad, idinstructor, idinstalacion, fechaini, fechafin, dias, horaini, horafin, horas, costomodulo, costo, pagohora, observaciones, estatus, pagado, diascurso, idtipooferta, instalacionext, alumnosminimo, fechalimite, instalaciondomext, solicita, autoriza) values(@idsucursal, @idcicloescolar, @nombre, @idtipocurso, @idarea, @idespecialidad, @idinstructor, @idinstalacion, @fechaini, @fechafin, @dias, @horaini, @horafin, @horas, @costomodulo, @costo, @pagohora, @observaciones, 'EN CAPTURA', 0, @diascurso, @idtipooferta, @instalacionext, @alumnosminimo, @fechalimite, @instalaciondomext, (select encargado from sucursal where idsucursal=@idsucursal), 'PROF. GERSOM PÉREZ RAMÍREZ'); ";
                            cmd.Parameters.AddWithValue("@idcicloescolar", 1);
                            cmd.Parameters.AddWithValue("@idsucursal", this.idsucursal);
                            cmd.Parameters.AddWithValue("@nombre", this.nombre.Text.ToUpper().Trim());
                            cmd.Parameters.AddWithValue("@idtipocurso", this.tipocurso.SelectedValue);
                            cmd.Parameters.AddWithValue("@idarea", this.area.SelectedValue);
                            cmd.Parameters.AddWithValue("@idespecialidad", this.especialidad.SelectedValue);
                            cmd.Parameters.AddWithValue("@idinstructor", this.instructor.SelectedValue);
                            cmd.Parameters.AddWithValue("@idinstalacion", this.instalacion.SelectedValue);
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
                            cmd.Parameters.AddWithValue("@idtipooferta", this.tipooferta.SelectedValue);
                            cmd.Parameters.AddWithValue("@instalacionext", this.instalacionext.Text.ToUpper().Trim());
                            cmd.Parameters.AddWithValue("@instalaciondomext", this.instalaciondomext.Text.ToUpper().Trim());
                            cmd.Parameters.AddWithValue("@alumnosminimo", this.alumnosminimo.Text);
                            cmd.Parameters.AddWithValue("@fechalimite", this.fechalimite.Text);
                            cmd.ExecuteNonQuery();
                            idcurso = (int)cmd.LastInsertedId;
                            this.idP.Value = idcurso.ToString();
                        }
                        cmd.Parameters.Clear();
                        cmd.CommandText = string.Concat(new string[] { "select * from (select adddate('1970-01-01', t4.i * 10000 + t3.i * 1000 + t2.i * 100 + t1.i * 10 + t0.i) fecha from  (select 0 i union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t0,  (select 0 i union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t1,  (select 0 i union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t2,  (select 0 i union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t3,  (select 0 i union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t4) v where fecha between '", this.fechaini.Text, "' and '", this.fechafin.Text, "'and DAYOFWEEK(fecha) in (", this.hdias.Value, ")" });
                        listafechas = new List<fechascurso>();
                        reader = cmd.ExecuteReader();
                        while (reader.Read())
                        {
                            fechascurso item = new fechascurso()
                            {
                                fecha = reader.GetString(0)
                            };
                            listafechas.Add(item);
                        }
                        reader.Close();
                        cmd.Parameters.Clear();
                        cmd.CommandText = string.Concat("SELECT COALESCE(MAX(idfecha),0)as idfecha FROM fechascurso where idcurso=", this.idP.Value, ";");
                        reader = cmd.ExecuteReader();
                        while (reader.Read())
                        {
                            idfecha = reader.GetInt32(0) + 1;
                        }
                        reader.Close();
                        cmd.Parameters.Clear();
                        query = "delete from fechascurso where idcurso=@idcurso; ";
                        cmd.Parameters.AddWithValue("@idcurso", this.idP.Value);
                        cmd.CommandText = query;
                        cmd.ExecuteNonQuery();
                        foreach (fechascurso item in listafechas)
                        {
                            cmd.Parameters.Clear();
                            cmd.CommandText = "insert into fechascurso (idcurso, idfecha, fecha, horaini, horafin) values (@idcurso, @idfecha, @fecha, @horaini, @horafin); ";
                            cmd.Parameters.AddWithValue("@idcurso", this.idP.Value);
                            cmd.Parameters.AddWithValue("@idfecha", idfecha);
                            cmd.Parameters.AddWithValue("@fecha", item.fecha);
                            cmd.Parameters.AddWithValue("@horaini", this.horaini.Text);
                            cmd.Parameters.AddWithValue("@horafin", this.horafin.Text);
                            idfecha++;
                            cmd.ExecuteNonQuery();
                        }
                        cmd.Parameters.Clear();
                        cmd.CommandText = string.Concat("select sum(TIMESTAMPDIFF(HOUR, horaini, horafin))as horas from fechascurso where idcurso =", this.idP.Value, ";");
                        reader = cmd.ExecuteReader();
                        while (reader.Read())
                        {
                            nohoras = reader.GetInt32(0);
                        }
                        reader.Close();
                        cmd.Parameters.Clear();
                        cmd.CommandText = "update curso set dias=@dias, horas=@horas where idcurso=@idcurso; ";
                        cmd.Parameters.AddWithValue("@idcurso", this.idP.Value);
                        cmd.Parameters.AddWithValue("@dias", listafechas.Count);
                        cmd.Parameters.AddWithValue("@horas", nohoras);
                        cmd.ExecuteNonQuery();
                        this.dias.Text = listafechas.Count.ToString();
                        this.horas.Text = nohoras.ToString();
                        transaction.Commit();
                        this.getCalendario(sender, e);
                        ScriptManager.RegisterStartupScript(this, base.GetType(), "myScriptName", "cerrarLoading(); ", true);
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

        protected void getAlumno(object sender, EventArgs e)
        {
            using (MySqlConnection con = new MySqlConnection(WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {
                try
                {
                    try
                    {
                        con.Open();
                        MySqlDataReader rdr = (new MySqlCommand(string.Concat("select idalumno, idedocivil, idescolaridad, nocontrol, nombre, apaterno, amaterno, sexo, curp, telefono, domicilio, colonia, cp, identidad, idmunicipio, cast(fechanacimiento as char)as fechanacimiento,  empresa, puesto, antiguedad, direccion, telefonoempresa  from alumno where idalumno = ", this.idA.Value, " "), con)).ExecuteReader();
                        if (rdr.HasRows)
                        {
                            rdr.Read();
                            this.idA.Value = rdr["idalumno"].ToString();
                            this.nocontrol.Text = rdr["nocontrol"].ToString();
                            this.nombrealumno.Text = rdr["nombre"].ToString();
                            this.apaterno.Text = rdr["apaterno"].ToString();
                            this.amaterno.Text = rdr["amaterno"].ToString();
                            this.sexo.SelectedValue = rdr["sexo"].ToString();
                            this.curp.Text = rdr["curp"].ToString();
                            this.domicilio.Text = rdr["domicilio"].ToString();
                            this.telefono.Text = rdr["telefono"].ToString();
                            this.colonia.Text = rdr["colonia"].ToString();
                            this.cp.Text = rdr["cp"].ToString();
                            this.entidad.SelectedValue = rdr["identidad"].ToString();
                            this.DSmunicipios.DataBind();
                            this.municipio.DataBind();
                            this.municipio.SelectedValue = rdr["idmunicipio"].ToString();
                            this.fechanacimiento.Text = rdr["fechanacimiento"].ToString();
                            this.escolaridad.SelectedValue = rdr["idescolaridad"].ToString();
                            this.empresa.Text = rdr["empresa"].ToString();
                            this.puesto.Text = rdr["puesto"].ToString();
                            this.antiguedad.Text = rdr["antiguedad"].ToString();
                            this.domicilioempresa.Text = rdr["direccion"].ToString();
                            this.telefonoempresa.Text = rdr["telefonoempresa"].ToString();
                            rdr.Close();
                        }
                        ScriptManager.RegisterClientScriptBlock(this.Page, typeof(string), "myScriptName", "cerrarLoading(); $('#walumnos').modal('hide');", true);
                    }
                    catch (Exception exception)
                    {
                    }
                }
                finally
                {
                    con.Close();
                }
            }
        }

        protected void getCalendario(object sender, EventArgs e)
        {
            string json = "";
            try
            {
                using (MySqlConnection con = new MySqlConnection(WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
                {
                    con.Open();
                    MySqlDataReader rdr = null;
                    rdr = (new MySqlCommand(string.Concat("select idfecha, cast(fecha as char)as fecha, cast(TIME_FORMAT(horaini, '%H:%i')as char)as horaini, cast(TIME_FORMAT(horafin, '%H:%i')as char)as horafin, concat(cast(TIME_FORMAT(horaini, '%H:%i')as char),' - ', cast(TIME_FORMAT(horafin, '%H:%i')as char)) as horario from fechascurso where idcurso = ", this.idP.Value, " order by fecha"), con)).ExecuteReader();
                    json = string.Concat(json, "[");
                    if (rdr.HasRows)
                    {
                        while (rdr.Read())
                        {
                            json = string.Concat(json, "{");
                            json = string.Concat(json, "id:'", rdr["idfecha"].ToString(), "',");
                            json = string.Concat(json, "title:'", rdr["horario"].ToString(), "',");
                            json = string.Concat(new string[] { json, "description:'", rdr["horaini"].ToString(), " - ", rdr["horafin"].ToString(), "'," });
                            json = string.Concat(json, "fecha:'", rdr["fecha"].ToString(), "',");
                            json = string.Concat(json, "horaini:'", rdr["horaini"].ToString(), "',");
                            json = string.Concat(json, "horafin:'", rdr["horafin"].ToString(), "',");
                            json = string.Concat(json, "start:'", rdr["fecha"].ToString(), "',");
                            json = string.Concat(json, "end:'", rdr["fecha"].ToString(), "'");
                            json = string.Concat(json, "},");
                        }
                    }
                    json = string.Concat(json, "]");
                    rdr.Close();
                }
            }
            catch (Exception exception)
            {
            }
            ScriptManager.RegisterStartupScript(this, base.GetType(), "inicilizarMun", string.Concat("dataEvent =", json), true);
        }

        protected void guardaCalificaciones(object sender, EventArgs e)
        {
            using (MySqlConnection con = new MySqlConnection(WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {
                MySqlTransaction transaction = null;
                int idsolicitud = Convert.ToInt32(this.idI.Value);
                try
                {
                    try
                    {
                        con.Open();

                        String sql = "select count(idsolicitud) from solicitudinscripcion where foliodiploma=@foliodiploma;";
                        MySqlCommand cmd = new MySqlCommand(sql, con);
                        cmd.Parameters.AddWithValue("@foliodiploma", folio.Text.Trim().ToUpper());
                        int conteo = Convert.ToInt32(cmd.ExecuteScalar());

                        if (conteo == 0)
                        {
                            MySqlCommand mySqlCommand = con.CreateCommand();
                            transaction = con.BeginTransaction();
                            mySqlCommand.Connection = con;
                            mySqlCommand.Transaction = transaction;
                            mySqlCommand.Parameters.Clear();
                            mySqlCommand.CommandText = "update cursofolios set estatus='CANCELADO' where idsolicitud=@idsolicitud and estatus='VIGENTE';";
                            mySqlCommand.Parameters.AddWithValue("@idsolicitud", idsolicitud);
                            mySqlCommand.ExecuteNonQuery();
                            mySqlCommand.Parameters.Clear();
                            mySqlCommand.CommandText = "insert into cursofolios (idsolicitud, fecha, folio, estatus) values (@idsolicitud, current_date, @folio, 'VIGENTE');";
                            mySqlCommand.Parameters.AddWithValue("@idsolicitud", idsolicitud);
                            mySqlCommand.Parameters.AddWithValue("@folio", this.folio.Text.Trim().ToUpper());
                            mySqlCommand.ExecuteNonQuery();
                            mySqlCommand.Parameters.Clear();
                            mySqlCommand.CommandText = "update solicitudinscripcion set foliodiploma=@folio, fechadiploma=current_date where idsolicitud=@idsolicitud;";
                            mySqlCommand.Parameters.AddWithValue("@idsolicitud", idsolicitud);
                            mySqlCommand.Parameters.AddWithValue("@folio", this.folio.Text.Trim().ToUpper());
                            mySqlCommand.ExecuteNonQuery();
                            transaction.Commit();
                            ScriptManager.RegisterStartupScript(this, base.GetType(), "myScriptName", "cerrarLoading(); toastExito(); $('#wcalificacion').modal('hide');", true);
                            this.listadoAlumnos(sender, e);
                        }
                        else
                        {
                            ScriptManager.RegisterStartupScript(this, base.GetType(), "myScriptName", " cerrarLoading(); alerta('Atención', 'El folio " + folio.Text+" ya ha sido utilizado en otro diploma, ingrese un nuevo folio', 'error',null);", true);
                        }

                        
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

        protected void guardaEdita(object sender, EventArgs e)
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
                        if (Convert.ToInt32(this.idP.Value) != 0)
                        {
                            cmd.Parameters.Clear();
                            cmd.CommandText = string.Concat("update curso set nombre=@nombre, idcicloescolar=@idcicloescolar, idtipocurso=@idtipocurso, idarea=@idarea, idespecialidad=@idespecialidad, idinstructor=@idinstructor, idinstalacion=@idinstalacion, fechaini=@fechaini, fechafin=@fechafin, dias=@dias, horaini=@horaini, horafin=@horafin, horas=@horas,  costomodulo=@costomodulo, costo=@costo, pagohora=@pagohora, observaciones=@observaciones, diascurso=@diascurso, idtipooferta=@idtipooferta, instalacionext=@instalacionext, alumnosminimo=@alumnosminimo, fechalimite=@fechalimite, instalaciondomext=@instalaciondomext ", "where idcurso=@idcurso;");
                            cmd.Parameters.AddWithValue("@idcurso", this.idP.Value);
                            cmd.Parameters.AddWithValue("@idcicloescolar", 1);
                            cmd.Parameters.AddWithValue("@nombre", this.nombre.Text.ToUpper().Trim());
                            cmd.Parameters.AddWithValue("@idtipocurso", this.tipocurso.SelectedValue);
                            cmd.Parameters.AddWithValue("@idarea", this.area.SelectedValue);
                            cmd.Parameters.AddWithValue("@idespecialidad", this.especialidad.SelectedValue);
                            cmd.Parameters.AddWithValue("@idinstructor", this.instructor.SelectedValue);
                            cmd.Parameters.AddWithValue("@idinstalacion", this.instalacion.SelectedValue);
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
                            cmd.Parameters.AddWithValue("@idtipooferta", this.tipooferta.SelectedValue);
                            cmd.Parameters.AddWithValue("@instalacionext", this.instalacionext.Text.ToUpper().Trim());
                            cmd.Parameters.AddWithValue("@instalaciondomext", this.instalaciondomext.Text.ToUpper().Trim());
                            cmd.Parameters.AddWithValue("@alumnosminimo", this.alumnosminimo.Text);
                            cmd.Parameters.AddWithValue("@fechalimite", this.fechalimite.Text);
                            cmd.ExecuteNonQuery();
                        }
                        else
                        {
                            cmd.Parameters.Clear();
                            cmd.CommandText = "insert into curso(idsucursal, idcicloescolar, nombre, idtipocurso, idarea, idespecialidad, idinstructor, idinstalacion, fechaini, fechafin, dias, horaini, horafin, horas, costomodulo, costo, pagohora, observaciones, estatus, pagado, diascurso, idtipooferta, instalacionext, alumnosminimo, fechalimite, instalaciondomext, solicita, autoriza, foto) values(@idsucursal, @idcicloescolar, @nombre, @idtipocurso, @idarea, @idespecialidad, @idinstructor, @idinstalacion, @fechaini, @fechafin, @dias, @horaini, @horafin, @horas, @costomodulo, @costo, @pagohora, @observaciones, 'EN CAPTURA', 0, @diascurso, @idtipooferta, @instalacionext, @alumnosminimo, @fechalimite, @instalaciondomext, (select encargado from sucursal where idsucursal=@idsucursal), 'PROF. GERSOM PÉREZ RAMÍREZ', @imagen); ";
                            cmd.Parameters.AddWithValue("@idcicloescolar", 1);
                            cmd.Parameters.AddWithValue("@idsucursal", this.idsucursal);
                            cmd.Parameters.AddWithValue("@nombre", this.nombre.Text.ToUpper().Trim());
                            cmd.Parameters.AddWithValue("@idtipocurso", this.tipocurso.SelectedValue);
                            cmd.Parameters.AddWithValue("@idarea", this.area.SelectedValue);
                            cmd.Parameters.AddWithValue("@idespecialidad", this.especialidad.SelectedValue);
                            cmd.Parameters.AddWithValue("@idinstructor", this.instructor.SelectedValue);
                            cmd.Parameters.AddWithValue("@idinstalacion", this.instalacion.SelectedValue);
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
                            cmd.Parameters.AddWithValue("@idtipooferta", this.tipooferta.SelectedValue);
                            cmd.Parameters.AddWithValue("@instalacionext", this.instalacionext.Text.ToUpper().Trim());
                            cmd.Parameters.AddWithValue("@instalaciondomext", this.instalaciondomext.Text.ToUpper().Trim());
                            cmd.Parameters.AddWithValue("@alumnosminimo", this.alumnosminimo.Text);
                            cmd.Parameters.AddWithValue("@fechalimite", this.fechalimite.Text);
                            cmd.ExecuteNonQuery();
                        }
                        transaction.Commit();
                        this.listadoClientes(sender, e);
                        ScriptManager.RegisterStartupScript(this, base.GetType(), "myScriptName", "cerrarLoading(); toastExito(); $('#winscripcion').modal('hide');", true);
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

        protected void guardaEditaFechas(object sender, EventArgs e)
        {
            int nohoras = 0;
            using (MySqlConnection con = new MySqlConnection(WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {
                MySqlTransaction transaction = null;
                MySqlDataReader reader = null;
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
                        cmd.CommandText = "update fechascurso set horaini=@horaini,  horafin=@horafin where idcurso=@idcurso and idfecha=@idfecha; ";
                        cmd.Parameters.AddWithValue("@idcurso", this.idP.Value);
                        cmd.Parameters.AddWithValue("@idfecha", this.idF.Value);
                        cmd.Parameters.AddWithValue("@horaini", this.horanini.Text);
                        cmd.Parameters.AddWithValue("@horafin", this.horanfin.Text);
                        cmd.ExecuteNonQuery();
                        cmd.Parameters.Clear();
                        cmd.CommandText = string.Concat("select sum(TIMESTAMPDIFF(HOUR, horaini, horafin))as horas from fechascurso where idcurso =", this.idP.Value, ";");
                        reader = cmd.ExecuteReader();
                        while (reader.Read())
                        {
                            nohoras = reader.GetInt32(0);
                        }
                        reader.Close();
                        cmd.Parameters.Clear();
                        cmd.CommandText = "update curso set horas=@horas where idcurso=@idcurso; ";
                        cmd.Parameters.AddWithValue("@idcurso", this.idP.Value);
                        cmd.Parameters.AddWithValue("@horas", nohoras);
                        cmd.ExecuteNonQuery();
                        this.horas.Text = nohoras.ToString();
                        transaction.Commit();
                        this.getCalendario(sender, e);
                        ScriptManager.RegisterStartupScript(this, base.GetType(), "myScriptName", "cerrarLoading();  $('#wfechas').modal('hide');", true);
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

        protected void guardaEditaIns(object sender, EventArgs e)
        {
            using (MySqlConnection con = new MySqlConnection(WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {
                MySqlTransaction transaction = null;
                string query = "";
                int idalumno = 0;
                int idsolicitud = 0;
                if (this.idA.Value.Equals(""))
                {
                    this.idA.Value = "0";
                }
                try
                {
                    try
                    {
                        con.Open();
                        MySqlCommand cmd = con.CreateCommand();
                        transaction = con.BeginTransaction();
                        cmd.Connection = con;
                        cmd.Transaction = transaction;
                        if (Convert.ToInt32(this.idA.Value) != 0)
                        {
                            cmd.Parameters.Clear();
                            query = "update alumno set idedocivil=@idedocivil, idescolaridad=@idescolaridad, nombre=@nombre, apaterno=@apaterno, amaterno=@amaterno, sexo=@sexo, curp=@curp, telefono=@telefono,domicilio = @domicilio, colonia = @colonia, cp = @cp, identidad = @identidad, idmunicipio = @idmunicipio, fechanacimiento=@fechanacimiento, discapacidades=@discapacidades, empresa=@empresa, puesto=@puesto, antiguedad=@antiguedad, direccion=@direccion, telefonoempresa=@telefonoempresa ";
                            string[] aux = this.hpicture.Value.Split(new char[] { ',' });
                            if ((int)aux.Length > 1)
                            {
                                query = string.Concat(query, ", foto=@imagen ");
                            }
                            query = string.Concat(query, "where idalumno = @idalumno; ");
                            cmd.CommandText = query;
                            cmd.Parameters.AddWithValue("@idalumno", this.idA.Value);
                            cmd.Parameters.AddWithValue("@idedocivil", this.edocivil.SelectedValue);
                            cmd.Parameters.AddWithValue("@idescolaridad", this.escolaridad.SelectedValue);
                            cmd.Parameters.AddWithValue("@nocontrol", this.nocontrol.Text.ToUpper().Trim());
                            cmd.Parameters.AddWithValue("@nombre", this.nombrealumno.Text.ToUpper().Trim());
                            cmd.Parameters.AddWithValue("@apaterno", this.apaterno.Text.ToUpper().Trim());
                            cmd.Parameters.AddWithValue("@amaterno", this.amaterno.Text.ToUpper().Trim());
                            cmd.Parameters.AddWithValue("@sexo", this.sexo.SelectedValue);
                            cmd.Parameters.AddWithValue("@curp", this.curp.Text.ToUpper().Trim());
                            cmd.Parameters.AddWithValue("@telefono", this.telefono.Text.Replace("-", "").Replace("(", "").Replace(") ", "").Trim());
                            cmd.Parameters.AddWithValue("@domicilio", this.domicilio.Text.ToUpper().Trim());
                            cmd.Parameters.AddWithValue("@colonia", this.colonia.Text.ToUpper().Trim());
                            cmd.Parameters.AddWithValue("@cp", this.cp.Text.ToUpper().Trim());
                            cmd.Parameters.AddWithValue("@identidad", this.entidad.SelectedValue);
                            cmd.Parameters.AddWithValue("@idmunicipio", this.municipio.SelectedValue);
                            cmd.Parameters.AddWithValue("@fechanacimiento", this.fechanacimiento.Text.ToUpper().Trim());
                            cmd.Parameters.AddWithValue("@discapacidades", this.tagsdiscap.Value);
                            cmd.Parameters.AddWithValue("@empresa", this.empresa.Text.ToUpper().Trim());
                            cmd.Parameters.AddWithValue("@antiguedad", this.antiguedad.Text.ToUpper().Trim());
                            cmd.Parameters.AddWithValue("@puesto", this.puesto.Text.ToUpper().Trim());
                            cmd.Parameters.AddWithValue("@direccion", this.domicilioempresa.Text.ToUpper().Trim());
                            cmd.Parameters.AddWithValue("@telefonoempresa", this.telefonoempresa.Text.ToUpper().Trim());
                            if ((int)aux.Length > 1)
                            {
                                cmd.Parameters.Add("@imagen", MySqlDbType.MediumBlob);
                                byte[] bytes = Convert.FromBase64String(aux[1]);
                                cmd.Parameters["@imagen"].Value = bytes;
                            }
                            cmd.ExecuteNonQuery();
                        }
                        else
                        {
                            cmd.Parameters.Clear();
                            query = "insert into alumno(nocontrol, idedocivil, idescolaridad, nombre, apaterno, amaterno, sexo, curp, telefono, domicilio, colonia, cp, identidad, idmunicipio, fechanacimiento, activo, discapacidades, empresa, puesto, antiguedad, direccion, telefonoempresa, foto) values(@nocontrol, @idedocivil, @idescolaridad, @nombre, @apaterno, @amaterno, @sexo, @curp, @telefono, @domicilio, @colonia, @cp, @identidad, @idmunicipio, @fechanacimiento, 1, @discapacidades, @empresa, @puesto, @antiguedad, @direccion, @telefonoempresa, @imagen);";
                            cmd.CommandText = query;
                            cmd.Parameters.AddWithValue("@idedocivil", this.edocivil.SelectedValue);
                            cmd.Parameters.AddWithValue("@idescolaridad", this.escolaridad.SelectedValue);
                            cmd.Parameters.AddWithValue("@nocontrol", this.nocontrol.Text.ToUpper().Trim());
                            cmd.Parameters.AddWithValue("@nombre", this.nombrealumno.Text.ToUpper().Trim());
                            cmd.Parameters.AddWithValue("@apaterno", this.apaterno.Text.ToUpper().Trim());
                            cmd.Parameters.AddWithValue("@amaterno", this.amaterno.Text.ToUpper().Trim());
                            cmd.Parameters.AddWithValue("@sexo", this.sexo.SelectedValue);
                            cmd.Parameters.AddWithValue("@curp", this.curp.Text.ToUpper().Trim());
                            cmd.Parameters.AddWithValue("@telefono", this.telefono.Text.Replace("-", "").Replace("(", "").Replace(") ", "").Trim());
                            cmd.Parameters.AddWithValue("@domicilio", this.domicilio.Text.ToUpper().Trim());
                            cmd.Parameters.AddWithValue("@colonia", this.colonia.Text.ToUpper().Trim());
                            cmd.Parameters.AddWithValue("@cp", this.cp.Text.ToUpper().Trim());
                            cmd.Parameters.AddWithValue("@identidad", this.entidad.SelectedValue);
                            cmd.Parameters.AddWithValue("@idmunicipio", this.municipio.SelectedValue);
                            cmd.Parameters.AddWithValue("@fechanacimiento", this.fechanacimiento.Text.ToUpper().Trim());
                            cmd.Parameters.AddWithValue("@discapacidades", this.tagsdiscap.Value);
                            cmd.Parameters.AddWithValue("@empresa", this.empresa.Text.ToUpper().Trim());
                            cmd.Parameters.AddWithValue("@antiguedad", this.antiguedad.Text.ToUpper().Trim());
                            cmd.Parameters.AddWithValue("@puesto", this.puesto.Text.ToUpper().Trim());
                            cmd.Parameters.AddWithValue("@direccion", this.domicilioempresa.Text.ToUpper().Trim());
                            cmd.Parameters.AddWithValue("@telefonoempresa", this.telefonoempresa.Text.ToUpper().Trim());
                            string[] aux = this.hpicture.Value.Split(new char[] { ',' });
                            if ((int)aux.Length <= 1)
                            {
                                cmd.Parameters.Add("@imagen", MySqlDbType.MediumBlob);
                                cmd.Parameters["@imagen"].Value = null;
                            }
                            else
                            {
                                byte[] bytes = Convert.FromBase64String(aux[1]);
                                cmd.Parameters.Add("@imagen", MySqlDbType.MediumBlob);
                                cmd.Parameters["@imagen"].Value = bytes;
                            }
                            cmd.ExecuteNonQuery();
                            idalumno = (int)cmd.LastInsertedId;
                            this.idA.Value = idalumno.ToString();
                        }
                        if (Convert.ToInt32(this.idI.Value) != 0)
                        {
                            cmd.Parameters.Clear();
                            query = "update solicitudinscripcion set    becado = @becado, idescolaridad = @idescolaridad, idconvenio=@idconvenio, medios=@medios, motivos=@motivos, jefafamilia=@jefafamilia, indigena=@indigena, porcentaje=@porcentaje, condicioncalle=@condicioncalle where idsolicitud=@idsolicitud; ";
                            cmd.CommandText = query;
                            cmd.Parameters.AddWithValue("@idsolicitud", this.idI.Value);
                            cmd.Parameters.AddWithValue("@becado", this.apoyo.SelectedValue);
                            cmd.Parameters.AddWithValue("@idescolaridad", this.escolaridad.SelectedValue);
                            cmd.Parameters.AddWithValue("@idconvenio", this.convenio.SelectedValue);
                            cmd.Parameters.AddWithValue("@medios", this.tagsmed.Value);
                            cmd.Parameters.AddWithValue("@motivos", this.tagsmot.Value);
                            cmd.Parameters.AddWithValue("@jefafamilia", this.jefafamilia.SelectedValue);
                            cmd.Parameters.AddWithValue("@indigena", this.indigena.SelectedValue);
                            cmd.Parameters.AddWithValue("@condicioncalle", this.condicioncalle.SelectedValue);
                            cmd.Parameters.AddWithValue("@porcentaje", this.porcentaje.Text);
                            cmd.ExecuteNonQuery();
                        }
                        else
                        {
                            cmd.Parameters.Clear();
                            query = "insert into solicitudinscripcion(idsucursal,idalumno,idusuario, fecha, hora, pagado, costo,  becado, idcondicion, idescolaridad, idconvenio, idcurso, medios, motivos, jefafamilia, indigena, porcentaje, condicioncalle) values(@idsucursal, @idalumno, @idusuario, curdate(), curtime(), 0, 0, @becado, 1, @idescolaridad, @idconvenio, @idccurso, @medios, @motivos, @jefafamilia, @indigena, @porcentaje, @condicioncalle); ";
                            cmd.CommandText = query;
                            cmd.Parameters.AddWithValue("@idsucursal", this.idsucursal);
                            cmd.Parameters.AddWithValue("@idalumno", this.idA.Value);
                            cmd.Parameters.AddWithValue("@idusuario", this.idusuario);
                            cmd.Parameters.AddWithValue("@idccurso", this.idP.Value);
                            cmd.Parameters.AddWithValue("@becado", this.apoyo.SelectedValue);
                            cmd.Parameters.AddWithValue("@idescolaridad", this.escolaridad.SelectedValue);
                            cmd.Parameters.AddWithValue("@idconvenio", this.convenio.SelectedValue);
                            cmd.Parameters.AddWithValue("@medios", this.tagsmed.Value);
                            cmd.Parameters.AddWithValue("@motivos", this.tagsmot.Value);
                            cmd.Parameters.AddWithValue("@jefafamilia", this.jefafamilia.SelectedValue);
                            cmd.Parameters.AddWithValue("@indigena", this.indigena.SelectedValue);
                            cmd.Parameters.AddWithValue("@condicioncalle", this.condicioncalle.SelectedValue);
                            cmd.Parameters.AddWithValue("@porcentaje", this.porcentaje.Text);
                            cmd.ExecuteNonQuery();
                            idsolicitud = (int)cmd.LastInsertedId;
                            this.idI.Value = idsolicitud.ToString();
                        }
                        cmd.Parameters.Clear();
                        query = "delete from cursodocumentacion where idsolicitud=@idsolicitud; ";
                        cmd.CommandText = query;
                        cmd.Parameters.AddWithValue("@idsolicitud", this.idI.Value);
                        cmd.ExecuteNonQuery();
                        string[] strArrays = this.tagsdoc.Value.Split(new char[] { ',' });
                        for (int i = 0; i < (int)strArrays.Length; i++)
                        {
                            string word = strArrays[i];
                            if (!word.Equals(""))
                            {
                                cmd.Parameters.Clear();
                                query = "insert into cursodocumentacion(iddocumentacion, idsolicitud) values(@iddocumentacion, @idsolicitud); ";
                                cmd.CommandText = query;
                                cmd.Parameters.AddWithValue("@iddocumentacion", Convert.ToInt32(word));
                                cmd.Parameters.AddWithValue("@idsolicitud", this.idI.Value);
                                cmd.ExecuteNonQuery();
                            }
                        }
                        transaction.Commit();
                        this.listadoAlumnos(sender, e);
                        this.listadoAlumnosBus(sender, e);
                        this.listadoDocumentacion(sender, e);
                        ScriptManager.RegisterStartupScript(this, base.GetType(), "myScriptName", "cerrarLoading(); toastExito(); $('#winscripcion').modal('hide');", true);
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

        protected void imprimeCredencial(object sender, EventArgs e)
        {
            Credencial reporte = new Credencial();
            reporte.ReportParameters["idsolicitud"].Value = this.idI.Value;
            string nombre = string.Concat("Credencial ", this.idctr.Value);
            this.ExportToPDF(reporte, nombre);
        }

        protected void imprimeDiploma(object sender, EventArgs e)
        {
            Diploma reporte = new Diploma();
            reporte.ReportParameters["idsolicitud"].Value = this.idI.Value;
            string nombre = string.Concat("Diploma ", this.idctr.Value);
            this.ExportToPDF(reporte, nombre);
        }

        protected void imprimeKardex(object sender, EventArgs e)
        {
            Kardex reporte = new Kardex();
            reporte.ReportParameters["idsolicitud"].Value = this.idI.Value;
            reporte.ReportParameters["idcurso"].Value = this.idP.Value;
            reporte.ReportParameters["idalumno"].Value = 0;
            string nombre = string.Concat("Kardex ", this.idctr.Value);
            this.ExportToPDF(reporte, nombre);
        }

        protected void imprimeSolicitud(object sender, EventArgs e)
        {
            SolicitudInscripcion reporte = new SolicitudInscripcion();
            reporte.ReportParameters["idsolicitud"].Value = this.idI.Value;
            reporte.ReportParameters["idalumno"].Value = this.idA.Value;
            string nombre = string.Concat("Solicitud Inscripción ", this.idctr.Value);
            this.ExportToPDF(reporte, nombre);
        }

        protected void imprimeSolicitudAut(object sender, EventArgs e)
        {
            SolicitudInscripcion reporte = new SolicitudInscripcion();
            reporte.ReportParameters["idsolicitud"].Value = this.idI.Value;
            reporte.ReportParameters["idalumno"].Value = this.idA.Value;
            string nombre = string.Concat("Credencial ", this.idctr.Value);
            this.ExportToPDF(reporte, nombre);
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
            string json = "";
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
            ScriptManager.RegisterStartupScript(this, base.GetType(), "inicilizarMun", string.Concat("dataEvent =", json), true);
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
                string query = string.Concat("select al.idalumno, al.nocontrol, si.idcurso, si.idsolicitud, si.estatus, si.foliodiploma, cast(si.fechadiploma as char) as fechadiploma, co.condicion, concat(al.apaterno,' ', al.amaterno,' ', al.nombre)as nombrealumno, case si.becado when 1 then round(c.costo -c.costo * (si.porcentaje / 100),2) else c.costo end as costoalumno, si.folio,  cast(si.fecha as char)as fecha, si.observaciones as observacionesalumno, si.calificacion, si.asistencias, c.estatus as estatuscurso, c.dias from alumno al  left join solicitudinscripcion si on si.idalumno = al.idalumno  left join curso c on si.idcurso = c.idcurso  left join condicionescolar co on co.idcondicion = si.idcondicion  where si.idcurso = ", this.idP.Value, " and si.idcondicion=2 ");
                if (this.busnom.Text.Trim() != "")
                {
                    query = string.Concat(query, " and concat(al.apaterno,' ',al.amaterno,' ',al.nombre) LIKE '%", this.busnom.Text.Trim().ToUpper(), "%' ");
                }
                query = string.Concat(query, " order by nombrealumno");
                this.DSalumnos.SelectCommand = query;
                this.lbcurso.Text = this.labelCurso.Value;
                if (this.idP.Value != "0")
                {
                    this.barrabus.Visible = true;
                }
                else
                {
                    this.barrabus.Visible = false;
                }
                this.estatusCurso.Value.Equals("FINALIZADO");
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
                string query = string.Concat("select a.idalumno, a.nocontrol, concat(a.apaterno,' ',a.amaterno,' ',a.nombre)as ncompleto, a.sexo, a.fechanacimiento, ( select count(s.idalumno) from solicitudinscripcion s where s.idcurso = ", this.idP.Value, " and s.idalumno = a.idalumno ) as registrado from alumno a where true ");
                if (this.bnombre.Text.Trim() != "")
                {
                    query = string.Concat(query, " and concat(a.apaterno,' ',a.amaterno,' ',a.nombre) LIKE '%", this.bnombre.Text.Trim().ToUpper(), "%' ");
                }
                query = string.Concat(query, " order by a.apaterno, a.amaterno, a.nombre");
                this.DSlistaalumnos.SelectCommand = query;
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
                string query = string.Concat("select d.iddocumentacion, d.documentacion, ( select count(c.iddocumentacion) from cursodocumentacion c where c.idsolicitud = ", this.idI.Value, " and c.iddocumentacion = d.iddocumentacion )as entregado from documentacion d order by d.documentacion");
                this.DSdocumentacion.SelectCommand = query;
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
                string query = "select c.idcurso, c.idsucursal, coalesce(c.nombre,'NO DEFINIDO')as nombre,  coalesce(a.area,'AREA NO ASIGNADA') as area,  coalesce(e.especialidad,'ESPECIALIDAD NO ASIGNADA')as especialidad,  coalesce(i.nombre,'INSTRUCTOR NO DEFINIDO') as instructor, t.tipocurso, c.estatus, c.costo, cast(c.fechaini as char)as fechaini, cast(c.fechafin as char)as fechafin, cast(TIME_FORMAT(c.horaini, '%h:%i %p') as char)as horaini, cast(TIME_FORMAT(c.horafin, '%h:%i %p') as char)as horafin,  c.alumnosminimo, (select count(s.idalumno) from solicitudinscripcion s where s.idcurso = c.idcurso) as inscritos, s.nombre as plantel,  c.estatus from curso c left join area a on a.idarea = c.idarea left join especialidad e on e.idespecialidad = c.idespecialidad left join tipocurso t on t.idtipocurso = c.idtipocurso left join instructor i on i.idinstructor = c.idinstructor left join sucursal s on s.idsucursal = c.idsucursal where c.tipo='C' and c.estatus='FINALIZADO' ";
                if (!this.bplantel.Visible)
                {
                    query = string.Concat(new object[] { query, " and c.idsucursal=", this.idsucursal, " " });
                }
                else if (!this.bplantel.SelectedValue.Equals("0"))
                {
                    query = string.Concat(query, " and c.idsucursal=", this.bplantel.SelectedValue, " ");
                }
                if (this.bname.Text.Trim() != "")
                {
                    query = string.Concat(query, " and c.nombre LIKE '%", this.bname.Text.Trim().ToUpper(), "%' ");
                }
                query = string.Concat(query, " order by c.idsucursal, c.nombre");
                this.DSgrupos.SelectCommand = query;
                this.listadoAlumnos(sender, e);
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
                string query = string.Concat("select folio, cast(fecha as char) as fecha, estatus from cursofolios where idsolicitud = ", this.idI.Value);
                this.DSobjetivos.SelectCommand = query;
                ScriptManager.RegisterStartupScript(this, base.GetType(), "myScriptName", "cerrarLoading();  $('#wcalificacion').modal('show');", true);
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

       

        protected void recuperaSolicitud(object sender, EventArgs e)
        {
            try
            {
                using (MySqlConnection con = new MySqlConnection(WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
                {
                    con.Open();
                    this.fotopa.ImageUrl = "";
                    MySqlDataReader rdr = (new MySqlCommand(string.Concat("select a.idalumno, a.nocontrol, a.nombre, a.apaterno, a.amaterno, a.sexo, a.curp, cast(a.fechanacimiento as char)as fechanacimiento, a.telefono, a.empresa, a.puesto, a.antiguedad, a.direccion , a.telefonoempresa, a.domicilio, a.colonia, a.cp, a.identidad, a.idmunicipio, a.idedocivil, a.idescolaridad, s.becado, s.idconvenio, s.idcurso, coalesce(a.discapacidades, '') as discapacidades, c.idespecialidad, c.idcurso, coalesce(s.medios, '') as medios, s.otromedio, coalesce(s.motivos, '') as motivos, s.otromotivo, s.jefafamilia, s.indigena, s.porcentaje, a.foto, s.condicioncalle from solicitudinscripcion s left join alumno a on a.idalumno = s.idalumno left join curso c on s.idcurso = c.idcurso where s.idsolicitud = ", this.idI.Value), con)).ExecuteReader();
                    if (!rdr.HasRows)
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
                    }
                    else
                    {
                        rdr.Read();
                        this.nocontrol.Text = rdr["nocontrol"].ToString();
                        this.nombrealumno.Text = rdr["nombre"].ToString();
                        this.apaterno.Text = rdr["apaterno"].ToString();
                        this.amaterno.Text = rdr["amaterno"].ToString();
                        this.sexo.SelectedValue = rdr["sexo"].ToString();
                        this.curp.Text = rdr["curp"].ToString();
                        this.domicilio.Text = rdr["domicilio"].ToString();
                        this.telefono.Text = rdr["telefono"].ToString();
                        this.colonia.Text = rdr["colonia"].ToString();
                        this.cp.Text = rdr["cp"].ToString();
                        this.entidad.SelectedValue = rdr["identidad"].ToString();
                        this.DSmunicipios.DataBind();
                        this.municipio.DataBind();
                        this.municipio.SelectedValue = rdr["idmunicipio"].ToString();
                        this.fechanacimiento.Text = rdr["fechanacimiento"].ToString();
                        this.escolaridad.SelectedValue = rdr["idescolaridad"].ToString();
                        this.tagsdiscap.Value = rdr["discapacidades"].ToString();
                        this.tagsmed.Value = rdr["medios"].ToString();
                        this.otromed.Text = rdr["otromedio"].ToString();
                        this.tagsmot.Value = rdr["motivos"].ToString();
                        this.otromot.Text = rdr["otromotivo"].ToString();
                        this.apoyo.SelectedValue = rdr["becado"].ToString();
                        this.empresa.Text = rdr["empresa"].ToString();
                        this.puesto.Text = rdr["puesto"].ToString();
                        this.antiguedad.Text = rdr["antiguedad"].ToString();
                        this.domicilioempresa.Text = rdr["direccion"].ToString();
                        this.telefonoempresa.Text = rdr["telefonoempresa"].ToString();
                        if (rdr["idconvenio"].GetType() != typeof(DBNull))
                        {
                            this.convenio.SelectedValue = rdr["idconvenio"].ToString();
                        }
                        if (this.apoyo.SelectedValue != "1")
                        {
                            this.divConv.Visible = false;
                        }
                        else
                        {
                            this.divConv.Visible = true;
                        }
                        this.curso.SelectedValue = rdr["idcurso"].ToString();
                        this.jefafamilia.SelectedValue = rdr["jefafamilia"].ToString();
                        this.indigena.SelectedValue = rdr["indigena"].ToString();
                        this.condicioncalle.SelectedValue = rdr["condicioncalle"].ToString();
                        this.porcentaje.Text = rdr["porcentaje"].ToString();
                        if (rdr["foto"].GetType() != typeof(DBNull))
                        {
                            byte[] ImageByte = (byte[])rdr["foto"];
                            if (ImageByte != null)
                            {
                                this.fotopa.ImageUrl = string.Concat("data:image/jpeg;base64,", Convert.ToBase64String(ImageByte));
                                this.fotopa.DataBind();
                            }
                        }
                    }
                    rdr.Close();
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
                        mySqlCommand.CommandText = "update curso set estatus='EN REVISION' where idcurso=@idcurso;";
                        mySqlCommand.Parameters.AddWithValue("@idcurso", this.idP.Value);
                        mySqlCommand.ExecuteNonQuery();
                        transaction.Commit();
                        this.listadoClientes(sender, e);
                        ScriptManager.RegisterStartupScript(this, base.GetType(), "myScriptName", "cerrarLoading(); $('#bootstrap').modal('hide');", true);
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

