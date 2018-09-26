using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using Microsoft.Reporting.WebForms;

namespace elecion.foro
{
    public partial class listadoforo : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // lpromovidos.HeaderRow.TableSection = TableRowSection.TableHeader;
            if (!IsPostBack)
            {
                if (String.IsNullOrEmpty(lpromovidos.SortExpression)) lpromovidos.Sort("completo", SortDirection.Ascending);
                var id = (FormsIdentity)Page.User.Identity;
                var ticket = id.Ticket;
                string[] datos = ticket.UserData.Split(',');
                string[] datos2 = datos[1].Split(';');
                hent.Value = datos2[3];
            }
        }

        protected void conteoRegistros(object sender, EventArgs e)
        {
            DataView dv = (DataView)DsListado.Select(DataSourceSelectArguments.Empty);
            int numberOfRows = int.Parse(dv.Table.Compute("Count(idP)", "").ToString());

            labelConteo.Text = numberOfRows.ToString();
        }

        protected void editaRegistro(object sender, EventArgs e)
        {            
            Session["idP"] = idP.Value;           
            Response.Redirect("~/forosol/registrarforo.aspx");
        }


        protected void nuevoRegistro(object sender, EventArgs e)
        {
            Session["idP"] = 0;
            Response.Redirect("~/forosol/registrarforo.aspx");
        }

        protected void borrarRegistro(object sender, EventArgs e)
        {
            using (System.Data.SqlClient.SqlConnection con = new System.Data.SqlClient.SqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {
               
                try
                {

                    con.Open();
                    
                    String query = "DELETE FROM forosol where idP=@idP;";
                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@idP", idP.Value);
                    cmd.ExecuteNonQuery();
                    
                    //ClientScript.RegisterStartupScript(GetType(), "JsScript", "<script type='text/javascript'>  alert('sii');  </script>");
                    ScriptManager.RegisterClientScriptBlock(Page, typeof(string), "myScriptName", "cerrarLoading();", true);

                }
                catch (Exception ex)
                {
                    System.Diagnostics.Debug.WriteLine("error:" + ex.ToString());
                    Console.WriteLine("error:" + ex.ToString());
                }
                finally
                {
                    con.Close();
                }

                refrescaGrid(sender, e);


            }


        }

        protected void refrescaGrid(object sender, EventArgs e)
        {
            DsListado.DataBind();
            lpromovidos.DataBind();
        }

        protected void bimprimir_Click(object sender, EventArgs e)
        {
            ImageButton btn = (ImageButton)sender;
            GridViewRow row = btn.NamingContainer as GridViewRow;
            string pk = lpromovidos.DataKeys[row.RowIndex].Values[0].ToString();

            var id = (FormsIdentity)Page.User.Identity;
            var ticket = id.Ticket;
            string[] datos = ticket.UserData.Split(',');
            string[] datos2 = datos[1].Split(';');
            string resp = datos2[0];

            ReportViewer1.ProcessingMode = ProcessingMode.Local;
            LocalReport localReport = ReportViewer1.LocalReport;
            ObjectDataSource ObjectDataSource1 = new ObjectDataSource("elecion.DataSourcesTableAdapters.forosolTableAdapter", "GetData");
            ObjectDataSource1.SelectParameters.Add("resp", resp);
            ObjectDataSource1.SelectParameters.Add("id", pk);
            ReportDataSource rds = new ReportDataSource("DataSet1", ObjectDataSource1);

            ReportViewer1.LocalReport.DataSources.Clear();
            ReportViewer1.LocalReport.DataSources.Add(rds);

            localReport.ReportPath = Server.MapPath("~/reportes/afiliacion.rdlc");
            //ReportViewer1.LocalReport.Refresh();
            // Variables
            Warning[] warnings;
            string[] streamIds;
            string mimeType = string.Empty;
            string encoding = string.Empty;
            string extension = string.Empty;

            byte[] bytes = localReport.Render("PDF", null, out mimeType, out encoding, out extension, out streamIds, out warnings);

            System.IO.FileStream fss = System.IO.File.Create(Server.MapPath("~/forosol/afiliaciones/" + Session.SessionID + ".pdf"));
            fss.Write(bytes, 0, bytes.Length);
            fss.Close();

            String SReportFileName = "/forosol/afiliaciones/" + Session.SessionID + ".pdf";
            ScriptManager.RegisterStartupScript(this, GetType(), "cerrarLoading", "cerrarLoading(); window.open('" + SReportFileName + "', '_blank');", true);
            //ClientScript.RegisterStartupScript(GetType(), "JsScript", "  ");

        }
    }
}