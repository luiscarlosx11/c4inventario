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
        string roles;
        protected void area_DataBound(object sender, EventArgs e)
        {
           
        }

        protected void becado_CheckedChanged(object sender, EventArgs e)
        {
            
        }

        protected void borraFechas(object sender, EventArgs e)
        {
        }

        protected void cancelaAlumno(object sender, EventArgs e)
        {
           
        }


        protected void modificaAlumno(object sender, EventArgs e)
        {
           
        }

        protected void conteoRegistros(object sender, EventArgs e)
        {
           /* using (MySqlConnection mySqlConnection = new MySqlConnection(WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {
                try
                {
                    try
                    {
                        mySqlConnection.Open();
                        MySqlDataReader mySqlDataReader = (new MySqlCommand(string.Concat("SELECT COUNT(al.idalumno) as total  from alumno al  left join solicitudinscripcion si on si.idalumno = al.idalumno  where si.idcurso = ", idP.Value, " "), mySqlConnection)).ExecuteReader();
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
            }*/
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
            this.Session["idP"] = idP.Value;
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
            
        }

        protected void getBien(object sender, EventArgs e)
        {
            using (MySqlConnection mySqlConnection = new MySqlConnection(WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {
                MySqlTransaction mySqlTransaction = null;
                string str = "";
                string query = "";
                try
                {
                    try
                    {
                        mySqlConnection.Open();
                        MySqlCommand mySqlCommand = mySqlConnection.CreateCommand();
                        mySqlTransaction = mySqlConnection.BeginTransaction();
                        mySqlCommand.Connection = mySqlConnection;
                        mySqlCommand.Transaction = mySqlTransaction;


                        int lastInsertedId = 0;

                        //Si el idmunicipio es mayor que cero se hace UPDATE
                        if (Int32.Parse(idP.Value) > 0)
                            query = "UPDATE salida set descripcion=@descripcion, usuario=@usuario, cargo=@cargo where idsalida=@idP;";
                        else
                            query = "INSERT INTO salida(fecha, descripcion, usuario, cargo) values(current_date, @descripcion, @usuario, @cargo);";

                        MySqlCommand cmd = new MySqlCommand(query, mySqlConnection);


                        cmd.Parameters.AddWithValue("@idP", idP.Value);
                        cmd.Parameters.AddWithValue("@usuario", usuario.Text.Trim().ToUpper());
                        cmd.Parameters.AddWithValue("@descripcion", descripcion.Text.Trim().ToUpper());
                        cmd.Parameters.AddWithValue("@cargo", cargo.Text.Trim().ToUpper());

                        cmd.ExecuteNonQuery();

                        if (Int32.Parse(idP.Value) == 0)
                        {
                            lastInsertedId = (int)cmd.LastInsertedId;
                            idP.Value = lastInsertedId.ToString();
                            /*
                            MySqlDataReader mySqlDataReader = (new MySqlCommand(string.Concat("select concat(LPAD(idsalida, 3, 0),'/',year(fecha))as folio, cast(fecha as char)as fechatext from salida where idsalida= ", idP.Value, " "), mySqlConnection)).ExecuteReader();
                            if (mySqlDataReader.HasRows)
                            {
                                mySqlDataReader.Read();

                                labelCurso.Text = "FOLIO " + mySqlDataReader["folio"].ToString();
                                labelfecha.Text = mySqlDataReader["fechatext"].ToString();                           
                            }
                            mySqlDataReader.Close();*/

                            query = "UPDATE salida set folio=concat(LPAD(idsalida, 3, 0),'/',year(fecha)) where idsalida=@idP;";
                            cmd = new MySqlCommand(query, mySqlConnection);
                            cmd.Parameters.AddWithValue("@idP", idP.Value);
                            cmd.ExecuteNonQuery();

                        }

                        mySqlCommand.Parameters.Clear();
                        mySqlCommand.CommandText = "update bien set idcentro=@idcentro, ubicacion=@ubicacion where idbien=@idbien;";
                        mySqlCommand.Parameters.AddWithValue("@idcentro", scentro.SelectedValue);
                        mySqlCommand.Parameters.AddWithValue("@ubicacion", idUbicacion.Value.Trim().ToUpper());
                        mySqlCommand.Parameters.AddWithValue("@idbien", idA.Value);                        
                        mySqlCommand.ExecuteNonQuery();


                        mySqlCommand.Parameters.Clear();
                        mySqlCommand.CommandText = "insert into detallesalida(idsalida, idbien, ubicacion) values(@idsalida, @idbien, @ubicacion);";
                        mySqlCommand.Parameters.AddWithValue("@idsalida", idP.Value);
                        mySqlCommand.Parameters.AddWithValue("@idbien", idA.Value);
                        mySqlCommand.Parameters.AddWithValue("@ubicacion", idUbicacion.Value.Trim().ToUpper());
                        mySqlCommand.ExecuteNonQuery();

                        mySqlTransaction.Commit();
                        this.listadoAlumnosBus(sender, e);
                        this.listadoAlumnos(sender, e);
                        ScriptManager.RegisterStartupScript(this, base.GetType(), "myScriptName", "cerrarLoading(); toastExito(); ", true);
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


        protected void eliminaBien(object sender, EventArgs e)
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
                        mySqlCommand.CommandText = "update bien set idcentro=0, ubicacion='' where idbien=@idbien;";
                        mySqlCommand.Parameters.AddWithValue("@idbien", idA.Value);
                        mySqlCommand.ExecuteNonQuery();


                        mySqlCommand.Parameters.Clear();
                        mySqlCommand.CommandText = "delete from detallesalida where idsalida=@idsalida and idbien=@idbien;";
                        mySqlCommand.Parameters.AddWithValue("@idsalida", idP.Value);
                        mySqlCommand.Parameters.AddWithValue("@idbien", idA.Value);
                        mySqlCommand.ExecuteNonQuery();

                        mySqlTransaction.Commit();
                        this.listadoAlumnos(sender, e);
                        ScriptManager.RegisterStartupScript(this, base.GetType(), "myScriptName", "cerrarLoading(); toastExito(); ", true);
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

        protected void getCalendario(object sender, EventArgs e)
        {
            
        }

        protected void guardaEdita(object sender, EventArgs e)
        {


            using (MySqlConnection mySqlConnection = new MySqlConnection(WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {

                MySqlTransaction mySqlTransaction = null;
                try
                {

                    mySqlConnection.Open();

                    MySqlCommand mySqlCommand = mySqlConnection.CreateCommand();
                    mySqlTransaction = mySqlConnection.BeginTransaction();
                    mySqlCommand.Connection = mySqlConnection;
                    mySqlCommand.Transaction = mySqlTransaction;

                    String query = "";
                    int lastInsertedId = 0;

                    //Si el idmunicipio es mayor que cero se hace UPDATE
                    if (Int32.Parse(idP.Value) > 0)
                        query = "UPDATE salida set descripcion=@descripcion, usuario=@usuario, cargo=@cargo where idsalida=@idP;";
                    else
                        query = "INSERT INTO salida(fecha, descripcion, usuario, cargo) values(current_date, @descripcion, @usuario, @cargo);";

                    MySqlCommand cmd = new MySqlCommand(query, mySqlConnection);


                    cmd.Parameters.AddWithValue("@idP", idP.Value);
                    cmd.Parameters.AddWithValue("@usuario", usuario.Text.Trim().ToUpper());
                    cmd.Parameters.AddWithValue("@descripcion", descripcion.Text.Trim().ToUpper());
                    cmd.Parameters.AddWithValue("@cargo", cargo.Text.Trim().ToUpper());
                                            
                    cmd.ExecuteNonQuery();

                    if (Int32.Parse(idP.Value) == 0)
                    {
                        lastInsertedId = (int)cmd.LastInsertedId;
                        idP.Value = lastInsertedId.ToString();
                        /*
                        MySqlDataReader mySqlDataReader = (new MySqlCommand(string.Concat("select concat(LPAD(idsalida, 3, 0),'/',year(fecha))as folio, cast(fecha as char)as fechatext from salida where idsalida= ", idP.Value, " "), mySqlConnection)).ExecuteReader();
                        if (mySqlDataReader.HasRows)
                        {
                            mySqlDataReader.Read();

                            labelCurso.Text = "FOLIO " + mySqlDataReader["folio"].ToString();
                            labelfecha.Text = mySqlDataReader["fechatext"].ToString();                           
                        }
                        mySqlDataReader.Close();*/

                        query = "UPDATE salida set folio=concat(LPAD(idsalida, 3, 0),'/',year(fecha)) where idsalida=@idP;";
                        cmd = new MySqlCommand(query, mySqlConnection);
                        cmd.Parameters.AddWithValue("@idP", idP.Value);
                        cmd.ExecuteNonQuery();

                    }

                    mySqlTransaction.Commit();
                    listadoAlumnos(sender, e);
                    ScriptManager.RegisterClientScriptBlock(Page, typeof(string), "myScriptName", "cerrarLoading(); toastExito();", true);


                }
                catch (Exception ex)
                {
                    System.Diagnostics.Debug.WriteLine("error:" + ex.ToString());
                    Console.WriteLine("error:" + ex.ToString());
                    mySqlTransaction.Rollback();
                }
                finally
                {
                    mySqlConnection.Close();
                }

                //ScriptManager.RegisterStartupScript(this, GetType(), "cerrar", "$('.modal-backdrop').remove();", true);
                

            }


        }

        protected void guardaEditaFechas(object sender, EventArgs e)
        {
           
        }

        protected void guardaEditaIns(object sender, EventArgs e)
        {
            
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

        protected void imprimeSalida(object sender, EventArgs e)
        {
            try
            {

                Session["idP"] = idP.Value;
                ScriptManager.RegisterClientScriptBlock(Page, typeof(string), "myScriptName", "window.open('../reportes/RVSalida.aspx','_blank'); ", true);
                // ScriptManager.RegisterStartupScript(this, GetType(), "ScriptName", "window.open(../reportviewers/RVColectiva.aspx,'_blank');", true);

            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("ERROR:" + ex.Message.Replace("\r\n", ""));
            }
        }

        protected void insertaFechas(object sender, EventArgs e)
        {
        }

        protected void instalacion_SelectedIndexChanged(object sender, EventArgs e)
        {
            
        }

        protected void limpiarCampos(object sender, EventArgs e)
        {
            
        }

        protected void limpiarCamposInscripcion(object sender, EventArgs e)
        {
            try
            {

                labelCurso.Text = "FOLIO AUTOMÁTICO";
                labelfecha.Text = "";
                descripcion.Text = "";
                usuario.Text = "";
                cargo.Text = "";

                //idP.Value = "0";

                listadoAlumnos(sender, e);
                gridAlumnos.Visible = true;
                gridCursos.Visible = false;


            }
            catch (Exception exception)
            {
            }
            ScriptManager.RegisterStartupScript(this, base.GetType(), "myScriptName", "cerrarLoading(); cargatags(); ", true);
        }

        protected void volverCursos(object sender, EventArgs e)
        {           
                gridAlumnos.Visible = false;
                gridCursos.Visible = true;

            listadoClientes(sender, e);

                ScriptManager.RegisterClientScriptBlock(this.Page, typeof(string), "myScriptName", "cerrarLoading();   ", true);
           
        }



        protected void listadoAlumnos(object sender, EventArgs e)
        {
            try
            {

                using (MySqlConnection mySqlConnection = new MySqlConnection(WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
                {
                    mySqlConnection.Open();
                    MySqlDataReader mySqlDataReader = (new MySqlCommand(string.Concat("select s.*, cast(s.fecha as char)as fechatext from salida s where s.idsalida= ", idP.Value, " "), mySqlConnection)).ExecuteReader();
                    if (mySqlDataReader.HasRows)
                    {
                        mySqlDataReader.Read();

                        labelCurso.Text = "FOLIO "+mySqlDataReader["folio"].ToString();
                        labelfecha.Text =  mySqlDataReader["fechatext"].ToString();
                        descripcion.Text = mySqlDataReader["descripcion"].ToString();
                        usuario.Text = mySqlDataReader["usuario"].ToString();
                        cargo.Text = mySqlDataReader["cargo"].ToString();
                    }
                    mySqlDataReader.Close();
                }


                this.GValumnos.DataSourceID = this.DSalumnos.ID;
                string str = string.Concat("select b.*, e.estado, c.centro, cast(b.fechaalta as char)as fechaaltatext, d.ubicacion as ubicacionsalida from detallesalida d left join bien b on d.idbien = b.idbien left join estado e on b.idestado = e.idestado  left join centro c on c.idcentro = b.idcentro  where d.idsalida= ", idP.Value, " ");
                
                str = string.Concat(str, " order by b.descripcion ");
                this.DSalumnos.SelectCommand = str;
                //this.lbcurso.Text = this.labelCurso.Value;
                if (idP.Value != "0")
                {
                    this.nuevo.Visible = true;
                    this.barrabus.Visible = true;
                }
                else
                {
                    //this.nuevo.Visible = false;
                    //this.barrabus.Visible = false;
                }

                                

                gridAlumnos.Visible = true;
                gridCursos.Visible = false;

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
                string str = "select b.*, e.estado, c.centro, cast(b.fechaalta as char)as fechaaltatext from bien b left join estado e on b.idestado = e.idestado left join centro c on c.idcentro = b.idcentro where b.idcentro=0 and b.idbien not in(select d.idbien from detallesalida d where d.idsalida="+idP.Value+")  ";
                if (!bbiendescripcion.Text.Equals(""))
                {
                    str = string.Concat(str, " and ( b.descripcion like '%"+ bbiendescripcion.Text.Trim().ToUpper() +"%' ");
                    str = string.Concat(str, " or  b.noinventario like '%" + bbiendescripcion.Text.Trim().ToUpper() + "%' ");
                    str = string.Concat(str, " or  b.noserie like '%" + bbiendescripcion.Text.Trim().ToUpper() + "%') ");
                }

                str = string.Concat(str, " order by b.noinventario ");
                this.DSlistaalumnos.SelectCommand = str;
                //this.DSlistaalumnos.DataBind();
                //this.GVlistaalumnos.DataBind();

                DataView dvAccess = (DataView)DSlistaalumnos.Select(DataSourceSelectArguments.Empty);

                if (dvAccess != null && dvAccess.Count > 0)
                {
                    this.divResultados.Visible = false;
                }
                else
                {
                    this.divResultados.Visible = true;
                }

               
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
                string query = "select s.*, cast(s.fecha as char) as fechatext, c.centro from salida s left join centro c on s.idcentro = c.idcentro where s.idsalida>0 ";

                if (!bfolio.Text.Trim().Equals(""))
                    query += " and s.folio like '%"+ bfolio.Text.Trim().ToUpper() +"%' ";


                if (!bdescripcion.Text.Trim().Equals(""))
                    query += " and s.descripcion like '%" + bdescripcion.Text.Trim().ToUpper() + "%' ";


                if (!brecibe.Text.Trim().Equals(""))
                    query += " and s.usuario like '%" + brecibe.Text.Trim().ToUpper() + "%' ";


                if (!bcentro.SelectedValue.Equals("-1"))
                    query += " and s.idcentro =" + bcentro.SelectedValue + " ";

                
                query = string.Concat(query, " order by s.idsalida ");
                this.DsUsuarios.SelectCommand = query;

                DataView dvAccess = (DataView)DsUsuarios.Select(DataSourceSelectArguments.Empty);

                if (dvAccess != null && dvAccess.Count > 0)
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

        protected void listadoDocumentacion(object sender, EventArgs e)
        {
           
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
                                 
            //if (!base.IsPostBack)
            //{
             //   if (this.roles.IndexOf('1', 0) < 0)
                    this.listadoClientes(sender, e);
                //this.nuevo.Visible = false;
                //this.barrabus.Visible = false;
            //    gridAlumnos.Visible = false;
           //    gridCursos.Visible = true;
                
            //}
            /*if (this.lbcurso.Text.Equals(""))
            {
                this.lbcurso.Text = "SELECCIONE UN CURSO";
            }*/
           // ScriptManager.RegisterStartupScript(this, base.GetType(), "actu", "cargatags(); ", true);

            //ScriptManager.RegisterClientScriptBlock(this.Page, typeof(string), "actu", "cargatags(); " , true);
        }

        protected void recuperaSolicitud(object sender, EventArgs e)
        {
            
        }

        protected void refrescaGrid(object sender, EventArgs e)
        {
        }

        protected void solicitaAutorizacion(object sender, EventArgs e)
        {
           
        }
    }
}