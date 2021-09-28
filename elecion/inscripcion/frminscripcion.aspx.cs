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
            
        }

        protected void getAlumno(object sender, EventArgs e)
        {
            
        }

        protected void getCalendario(object sender, EventArgs e)
        {
            
        }

        protected void guardaEdita(object sender, EventArgs e)
        {
            
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
            
        }

        protected void limpiarCampos(object sender, EventArgs e)
        {
            
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
               
            }
            catch (Exception exception)
            {
            }
            ScriptManager.RegisterStartupScript(this, base.GetType(), "myScriptName", "cerrarLoading(); $('#tabgenerales').click(); $('#winscripcion').modal('show'); cargatags(); ", true);
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
                    MySqlDataReader mySqlDataReader = (new MySqlCommand(string.Concat("select s.*, cast(s.fecha as char)as fechatext from salida s where s.idsalida= ", this.idP.Value, " "), mySqlConnection)).ExecuteReader();
                    if (mySqlDataReader.HasRows)
                    {
                        mySqlDataReader.Read();

                        labelCurso.Text = "FOLIO "+mySqlDataReader["folio"].ToString();
                        labelfecha.Text =  mySqlDataReader["fechatext"].ToString();
                        descripcion.Text = mySqlDataReader["descripcion"].ToString();
                        usuario.Text = mySqlDataReader["usuario"].ToString();
                    }
                    mySqlDataReader.Close();
                }


                this.GValumnos.DataSourceID = this.DSalumnos.ID;
                string str = string.Concat("select b.*, e.estado, c.centro, cast(b.fechaalta as char)as fechaaltatext, d.ubicacion as ubicacionsalida from detallesalida d left join bien b on d.idbien = b.idbien left join estado e on b.idestado = e.idestado  left join centro c on c.idcentro = b.idcentro  where d.idsalida= ", this.idP.Value, " ");
                
                str = string.Concat(str, " order by b.descripcion ");
                this.DSalumnos.SelectCommand = str;
                //this.lbcurso.Text = this.labelCurso.Value;
                if (this.idP.Value != "0")
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

            Convert.ToInt32(this.limite.Value);
            int pag = 1;
            try
            {
               
                this.lGeneral.DataSourceID = this.DsUsuarios.ID;
                string query = "select s.*, cast(s.fecha as char) as fechatext, c.centro from salida s left join centro c on s.idcentro = c.idcentro ";
               


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