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

namespace elecion.estructuras
{
    public partial class listadoEstructura : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // lpromovidos.HeaderRow.TableSection = TableRowSection.TableHeader;
            if (!IsPostBack)
            {
                if (String.IsNullOrEmpty(lpromovidos.SortExpression)) lpromovidos.Sort("tipo", SortDirection.Ascending);
                /*var id = (FormsIdentity)Page.User.Identity;
                var ticket = id.Ticket;
                string[] datos = ticket.UserData.Split(',');
                string[] datos2 = datos[1].Split(';');
                hent.Value = datos2[3];*/
            }
        }

        protected void conteoRegistros(object sender, EventArgs e)
        {
            DataView dv = (DataView)DsListado.Select(DataSourceSelectArguments.Empty);
            int numberOfRows = int.Parse(dv.Table.Compute("Count(idCoordinador)", "").ToString());

            labelConteo.Text = numberOfRows.ToString();
        }

        protected void editaRegistro(object sender, EventArgs e)
        {
            Session["idP"] = idP.Value;
            Response.Redirect("~/estructuras/coordinador.aspx");
        }


        protected void nuevoRegistro(object sender, EventArgs e)
        {
            Session["idP"] = 0;
            Response.Redirect("~/estructuras/coordinador.aspx");
        }

        protected void borrarRegistro(object sender, EventArgs e)
        {
            using (System.Data.SqlClient.SqlConnection con = new System.Data.SqlClient.SqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {

                try
                {

                    con.Open();

                    String query = "DELETE FROM coordinadores where idcoordinador=@idP;";
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

    }
}