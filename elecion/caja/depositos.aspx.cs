using elecion;
using MySql.Data.MySqlClient;
using ReportLibrary;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
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

namespace elecion.caja
{
    public partial class depositos : System.Web.UI.Page
    {
        private int idsucursal;
        private int idusuario;
        int idtipousuario;
        string roles;


        protected void bimprimir_Click(object sender, EventArgs e)
        {
            Poliza reporte = new Poliza();
            reporte.ReportParameters["iddeposito"].Value = this.idP.Value;
            this.ExportToPDF(reporte, "PÓLIZA ");
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
                        string query = string.Concat(" select count(d.idsucursal)as total    from deposito d   left join sucursal s on s.idsucursal = d.idsucursal   where s.idsucursal=", this.idsucursal);
                        if (this.bname.Text.Trim() != "")
                        {
                            query = string.Concat(new string[] { query, " and (d.nombre LIKE '%", this.bname.Text.Trim().ToUpper(), "%' or d.folio LIKE '%", this.bname.Text.Trim().ToUpper(), "%') " });
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

        protected void generaFechasCurso(object sender, EventArgs e)
        {
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
                    rdr = (new MySqlCommand(string.Concat("select * from  (  (  select idfecha, cast(fecha as char) as fecha, cast(TIME_FORMAT(horaini, '%H:%i') as char) as horaini, cast(TIME_FORMAT(horafin, '%H:%i') as char) as horafin, concat(cast(TIME_FORMAT(horaini, '%H:%i') as char), ' - ', cast(TIME_FORMAT(horafin, '%H:%i') as char)) as horario  from fechascurso  where idcurso =", this.idP.Value, "  )  union  (  SELECT 0 as idfecha, cast(fecha as char) as fecha, '' as horaini, '' as horafin, '' as horario  from fechaslibres  )  )as v  order by v.fecha "), con)).ExecuteReader();
                    json = string.Concat(json, "[");
                    if (rdr.HasRows)
                    {
                        while (rdr.Read())
                        {
                            json = string.Concat(json, "{");
                            json = string.Concat(json, "id:'", rdr["idfecha"].ToString(), "',");
                            if (!rdr["idfecha"].ToString().Equals("0"))
                            {
                                json = string.Concat(json, "title:'", rdr["horario"].ToString(), "',");
                                json = string.Concat(new string[] { json, "description:'", rdr["horaini"].ToString(), " - ", rdr["horafin"].ToString(), "'," });
                            }
                            else
                            {
                                json = string.Concat(json, "color:'#967ADC',");
                                json = string.Concat(json, "title:'INHÁBIL',");
                                json = string.Concat(json, "description:'NO SE LABORA',");
                            }
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

        protected void guardaEdita(object sender, EventArgs e)
        {
        }

        protected void guardaEditaFechas(object sender, EventArgs e)
        {
        }

        protected void guardaObjetivo(object sender, EventArgs e)
        {
        }

        protected void gUsuarios_RowCreated(object sender, GridViewRowEventArgs e)
        {
        }

        protected void gUsuarios_SelectedIndexChanged(object sender, EventArgs e)
        {
        }

        protected void imprimirListaAsistencia(object sender, EventArgs e)
        {

            


        }

        protected void imprimirRIADC(object sender, EventArgs e)
        {
            RIACD reporte = new RIACD();
            reporte.ReportParameters["idsucursal"].Value = this.idS.Value;
            reporte.ReportParameters["idcurso"].Value = this.idP.Value;
            this.ExportToPDF(reporte, string.Concat("RIADC-02 ", this.cve.Value));
        }

        protected void insertaFechas(object sender, EventArgs e)
        {
        }

        protected void instalacion_SelectedIndexChanged(object sender, EventArgs e)
        {
        }

        protected void limpiarCampos(object sender, EventArgs e)
        {
            this.folio.Text = "";
            this.nombre.Text = "";
            this.fecha.Text = "";
            this.monto.Text = "0";
            ScriptManager.RegisterStartupScript(this, base.GetType(), "myScriptName", "cerrarLoading();  $('#bootstrap').modal('show'); ", true);
        }

        protected void listadoAlumnos(object sender, EventArgs e)
        {
            try
            {
                this.GValumnos.DataSourceID = this.DSalumnos.ID;
                string query = string.Concat("select  cast(cp.fecha as char) as fecha, cp.folio, cp.importe, cp.iddeposito,  concat(a.nombre, ' ', a.apaterno, ' ', a.amaterno) as alumno  from curso c   left join especialidad e on c.idespecialidad = e.idespecialidad  left join instructor i on i.idinstructor = c.idinstructor  left join solicitudinscripcion s on s.idcurso = c.idcurso  left join cursopago cp on cp.idsolicitud = s.idsolicitud  left join alumno a on a.idalumno = s.idalumno  where cp.tipo='O' and cp.iddeposito =  ", this.idP.Value, " order by cp.fecha desc ");
                this.DSalumnos.SelectCommand = query;
            }
            catch (Exception exception)
            {
            }
        }

        protected void listadoareas(object sender, EventArgs e)
        {
        }

        protected void listadoClientes(object sender, EventArgs e)
        {
            Convert.ToInt32(this.limite.Value);
            int pag = 1;
            try
            {
                this.lusuarios.DataSourceID = this.DsUsuarios.ID;
                string query = string.Concat(" select d.idsucursal, d.iddeposito, cast(d.fecha as char)as fecha, d.nombre, s.nombre as sucursal, d.folio,   (select sum(cp.importe) from cursopago cp where cp.iddeposito=d.iddeposito and cp.tipo='O')as monto   from deposito d   left join sucursal s on s.idsucursal = d.idsucursal   where s.idsucursal=", this.idsucursal);
                if (this.bname.Text.Trim() != "")
                {
                    query = string.Concat(new string[] { query, " and (d.nombre LIKE '%", this.bname.Text.Trim().ToUpper(), "%' or d.folio LIKE '%", this.bname.Text.Trim().ToUpper(), "%') " });
                }
                query = string.Concat(query, " order by d.fecha desc");
                this.DsUsuarios.SelectCommand = query;
            }
            catch (Exception exception)
            {
            }
        }

        protected void listadoEspecialidades(object sender, EventArgs e)
        {
        }

        protected void listadoFechas(object sender, EventArgs e)
        {
            string bloqueo = "";
            try
            {
                using (MySqlConnection con = new MySqlConnection(WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
                {
                    con.Open();
                    MySqlDataReader rdr = (new MySqlCommand(string.Concat("select d.iddeposito, cast(d.fecha as char)as fecha, d.nombre, s.nombre as sucursal, d.folio,    (select sum(cp.importe) from cursopago cp where cp.iddeposito=d.iddeposito and cp.tipo='O')as monto from deposito d  left join sucursal s on s.idsucursal = d.idsucursal where d.iddeposito=", this.idP.Value), con)).ExecuteReader();
                    if (rdr.HasRows)
                    {
                        rdr.Read();
                        this.folio.Text = rdr["folio"].ToString();
                        this.fecha.Text = rdr["fecha"].ToString();
                        this.nombre.Text = rdr["nombre"].ToString();
                        this.monto.Text = rdr["monto"].ToString();
                    }
                    rdr.Close();
                    this.listadoAlumnos(sender, e);
                    ScriptManager.RegisterStartupScript(this, base.GetType(), "myScriptName", string.Concat("cerrarLoading();  $('#bootstrap').modal('show'); $('#tabgenerales').click();  ", bloqueo) ?? "", true);
                }
            }
            catch (Exception exception)
            {
            }
        }

        protected void listadoHistorial(object sender, EventArgs e)
        {
        }

        protected void listadoObjetivos(object sender, EventArgs e)
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
            this.idsucursal = Convert.ToInt32(datos2[4]);
            this.roles = datos2[3].ToString();
            this.idSU.Value = this.idsucursal.ToString();
            if (!base.IsPostBack)
            {
                this.listadoClientes(sender, e);
            }
            ScriptManager.RegisterStartupScript(this, base.GetType(), "actu", "dar(); ", true);
        }

        protected void refrescaGrid(object sender, EventArgs e)
        {
            this.DsUsuarios.DataBind();
            this.lusuarios.DataBind();
        }

        protected void regular_DataBound(object sender, EventArgs e)
        {
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
        }
    }
}
