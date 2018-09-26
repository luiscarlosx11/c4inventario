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
using Telerik.ReportViewer.Html5.WebForms;

namespace elecion.promovidos
{
    public partial class listado : System.Web.UI.Page
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
            Response.Redirect("~/promovidos/registrar.aspx");
        }


        protected void nuevoRegistro(object sender, EventArgs e)
        {
            //Session["idP"] = 0;
           // Response.Redirect("~/promovidos/registrar.aspx");

            

            string url = "ReportViewerForm1.aspx";
            string s = "window.open('" + url + "','_blank');";
            ScriptManager.RegisterClientScriptBlock(Page, typeof(string), "popupss", s, true);
        }

        protected void borrarRegistro(object sender, EventArgs e)
        {
            using (System.Data.SqlClient.SqlConnection con = new System.Data.SqlClient.SqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {
                SqlCommand cmd = con.CreateCommand();
                cmd.Connection.Open();

                SqlTransaction transaction = con.BeginTransaction();
                cmd.Transaction = transaction;

                try
                {
                                        
                    String query = "DELETE FROM promovidos where idP=@idP;";

                    cmd.CommandText = query;
                    cmd.Parameters.AddWithValue("@idP", idP.Value);
                    cmd.ExecuteNonQuery();

                    cmd.Parameters.Clear();

                    query = "UPDATE datos15 set promovido=0 where ife=@clave;";
                    cmd.CommandText = query;
                    cmd.Parameters.AddWithValue("@clave", clave_e.Value);
                    cmd.ExecuteNonQuery();

                    transaction.Commit();
                    //ClientScript.RegisterStartupScript(GetType(), "JsScript", "<script type='text/javascript'>  alert('sii');  </script>");
                    ScriptManager.RegisterClientScriptBlock(Page, typeof(string), "myScriptName", "cerrarLoading();", true);

                }
                catch (Exception ex)
                {
                    transaction.Rollback();
                    System.Diagnostics.Debug.WriteLine("error:" + ex.ToString());
                    Console.WriteLine("error:" + ex.ToString());
                }
                finally
                {
                    cmd.Connection.Close();
                }

                refrescaGrid(sender, e);


            }


        }

        protected void refrescaGrid(object sender, EventArgs e)
        {
            DsListado.DataBind();
            lpromovidos.DataBind();
        }

    }
}