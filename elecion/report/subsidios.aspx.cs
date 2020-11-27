using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using MySql.Data.MySqlClient;
using System.Web.Security;
using Telerik.Reporting.Processing;
using System.Web.Configuration;
using Telerik.Reporting;
using ReportLibrary;

namespace elecion.report
{
    public partial class subsidios : System.Web.UI.Page
    {
        private int idusuario;
        private int idsucursal;

        protected void borrarRegistro(object sender, EventArgs e)
        {
            using (MySqlConnection mySqlConnection = new MySqlConnection(WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {
                try
                {
                    try
                    {
                        mySqlConnection.Open();
                        MySqlCommand mySqlCommand = new MySqlCommand("UPDATE detallecaja set estatus='CANCELADO' where iddetallecaja=@idP and idsucursal=@idS;", mySqlConnection);
                        mySqlCommand.Parameters.AddWithValue("@idP", this.idP.Value);
                        mySqlCommand.Parameters.AddWithValue("@idS", this.idS.Value);
                        mySqlCommand.ExecuteNonQuery();
                        ScriptManager.RegisterClientScriptBlock(this.Page, typeof(string), "myScriptName", "cerrarLoading();", true);
                    }
                    catch (Exception exception)
                    {
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
        }

        private void ExportToPDF(Telerik.Reporting.Report reportToExport, string tipo)
        {
            ReportProcessor reportProcessor = new ReportProcessor();
            InstanceReportSource instanceReportSource = new InstanceReportSource()
            {
                ReportDocument = reportToExport
            };
            RenderingResult renderingResult = reportProcessor.RenderReport(tipo, instanceReportSource, null);
            string str = string.Concat(renderingResult.DocumentName, ".", renderingResult.Extension);
            base.Response.Clear();
            base.Response.ContentType = renderingResult.MimeType;
            base.Response.Cache.SetCacheability(HttpCacheability.Private);
            base.Response.Expires = -1;
            base.Response.Buffer = true;
            base.Response.AddHeader("Content-Disposition", string.Format("{0};FileName=\"{1}\"", "attachment", str));
            base.Response.BinaryWrite(renderingResult.DocumentBytes);
            base.Response.End();
        }

        protected void guardaEdita(object sender, EventArgs e)
        {
            using (MySqlConnection mySqlConnection = new MySqlConnection(WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {
                MySqlTransaction mySqlTransaction = null;
                MySqlDataReader mySqlDataReader = null;
                string str = "";
                int num = 0;
                try
                {
                    try
                    {
                        mySqlConnection.Open();
                        MySqlCommand mySqlCommand = mySqlConnection.CreateCommand();
                        mySqlTransaction = mySqlConnection.BeginTransaction();
                        mySqlCommand.Connection = mySqlConnection;
                        mySqlCommand.Transaction = mySqlTransaction;
                        if (int.Parse(this.idP.Value) <= 0)
                        {
                            mySqlCommand.CommandText = string.Concat("SELECT COALESCE(MAX(iddetallecaja),0)as iddet FROM detallecaja where idsucursal=", this.idS.Value, ";");
                            mySqlDataReader = mySqlCommand.ExecuteReader();
                            while (mySqlDataReader.Read())
                            {
                                num = mySqlDataReader.GetInt32(0) + 1;
                            }
                            mySqlDataReader.Close();
                            mySqlCommand.Parameters.Clear();
                            str = "INSERT INTO detallecaja(iddetallecaja, idsucursal, idusuario, fecha, hora, concepto, importe, tipo, estatus) values( @idP, @idS, @idU, current_date, current_time, @concepto, @importe, 'I', 'ACTIVO');";
                        }
                        else
                        {
                            str = "UPDATE detallecaja set concepto=@concepto, importe=@importe where iddetallecaja=@idP and idsucursal=@idS;";
                            num = Convert.ToInt32(this.idP.Value);
                        }
                        mySqlCommand.CommandText = str;
                        mySqlCommand.Parameters.AddWithValue("@idP", num);
                        mySqlCommand.Parameters.AddWithValue("@idS", this.idS.Value);
                        mySqlCommand.Parameters.AddWithValue("@idU", this.idusuario);
                        mySqlCommand.Parameters.AddWithValue("@concepto", this.concepto.Text.ToUpper());
                        mySqlCommand.Parameters.AddWithValue("@importe", this.importe.Text);
                        mySqlCommand.ExecuteNonQuery();
                        mySqlTransaction.Commit();
                        ScriptManager.RegisterClientScriptBlock(this.Page, typeof(string), "myScriptName", "cerrarLoading();", true);
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

        protected void imprimeCursos(object sender, EventArgs e)
        {
            FormatoSubsidios formatoSubsidio = new FormatoSubsidios();
            formatoSubsidio.ReportParameters["idsucursal"].Value = this.bplantel.SelectedValue;
            formatoSubsidio.ReportParameters["idusuario"].Value = idusuario;
            formatoSubsidio.ReportParameters["idtipocurso"].Value = this.btipocurso.SelectedValue;
            formatoSubsidio.ReportParameters["fechaini"].Value = this.fechaini.Text.Trim();
            formatoSubsidio.ReportParameters["fechafin"].Value = this.fechafin.Text.Trim();
            this.ExportToPDF(formatoSubsidio, "XLS");
        }

        protected void imprimeSolicitud(object sender, EventArgs e)
        {
            FormatoEscolaridadMexico formatoEscolaridadMexico = new FormatoEscolaridadMexico();
            formatoEscolaridadMexico.ReportParameters["idsucursal"].Value = this.idsucursal;
            this.ExportToPDF(formatoEscolaridadMexico, "XLS");
        }

        protected void lgastos_Sorting(object sender, GridViewSortEventArgs e)
        {
            e.SortDirection.ToString().Equals("Ascending");
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            string[] strArrays = ((FormsIdentity)this.Page.User.Identity).Ticket.UserData.Split(new char[] { ',' });
            string[] strArrays1 = strArrays[1].Split(new char[] { ';' });
            this.idusuario = Convert.ToInt32(strArrays[0]);
            this.idsucursal = Convert.ToInt32(strArrays1[4]);
            this.idS.Value = this.idsucursal.ToString();
            if (!base.IsPostBack)
            {
                this.setFecha(sender, e);
            }
        }

        protected void setFecha(object sender, EventArgs e)
        {
            using (MySqlConnection mySqlConnection = new MySqlConnection(WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {
                try
                {
                    try
                    {
                        mySqlConnection.Open();
                        MySqlDataReader mySqlDataReader = (new MySqlCommand("select DATE_FORMAT(current_date,'%Y-%m-%d') as fecha;", mySqlConnection)).ExecuteReader();
                        if (mySqlDataReader.HasRows)
                        {
                            while (mySqlDataReader.Read())
                            {
                                this.bfecha.Text = mySqlDataReader["fecha"].ToString();
                                this.bfechafin.Text = mySqlDataReader["fecha"].ToString();
                            }
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
    }
}