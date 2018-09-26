using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace elecion.catalogos.geograficos
{
    public partial class listadocol : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (String.IsNullOrEmpty(lcolonias.SortExpression)) lcolonias.Sort("colonia", SortDirection.Ascending);

                var id = (FormsIdentity)Page.User.Identity;
                var ticket = id.Ticket;
                string[] datos = ticket.UserData.Split(',');
                string[] datos2 = datos[1].Split(';');
                hentidad.Value = datos2[3];

            }
        }

        protected void conteoRegistros(object sender, EventArgs e)
        {
            DataView dv = (DataView)DsListadoColonias.Select(DataSourceSelectArguments.Empty);
            int numberOfRows = int.Parse(dv.Table.Compute("Count(idColonia)", "").ToString());

            labelConteo.Text = numberOfRows.ToString();
        }

        protected void refrescaGrid(object sender, EventArgs e)
        {
            DsListadoColonias.DataBind();
            lcolonias.DataBind();
        }

        protected void guardaEdita(object sender, EventArgs e)
        {
            using (System.Data.SqlClient.SqlConnection con = new System.Data.SqlClient.SqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {


                try
                {

                    con.Open();
                    String query = "";                  

                    //Si el idmunicipio es mayor que cero se hace UPDATE
                    if (Int32.Parse(idcol.Value) > 0)
                        query = "UPDATE colonias set idmunicipio=@idMunicipio, colonia=@colonia where idcolonia=@idcol and entidad=@entidad;";
                    else
                        query = "INSERT INTO colonias(colonia,idMunicipio,entidad) values(@colonia,@idMunicipio,@entidad);";
                    
                    SqlCommand cmd = new SqlCommand(query, con);

                    //Update
                    if (Int32.Parse(idcol.Value) > 0)
                    {
                        cmd.Parameters.AddWithValue("@idcol", idcol.Value);
                    }
                                                                   
                    cmd.Parameters.AddWithValue("@entidad", hentidad.Value);                                                                                     
                    cmd.Parameters.AddWithValue("@colonia", colonia.Text);
                    cmd.Parameters.AddWithValue("@idMunicipio", municipio.SelectedValue);                   

                    cmd.ExecuteNonQuery();
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

                //ScriptManager.RegisterStartupScript(this, GetType(), "cerrar", "$('.modal-backdrop').remove();", true);
                refrescaGrid(sender, e);

            }


        }

        protected void borrarRegistro(object sender, EventArgs e)
        {
            using (System.Data.SqlClient.SqlConnection con = new System.Data.SqlClient.SqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {
                
                try
                {

                    con.Open();
                    String query = "DELETE FROM colonias where idcolonia=@idcol and entidad=@entidad;";
                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@entidad", hentidad.Value);
                    cmd.Parameters.AddWithValue("@idcolonia", idcol.Value);
                    cmd.ExecuteNonQuery();
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

        protected void lcolonias_Sorting(object sender, GridViewSortEventArgs e)
        {
            string sort = e.SortDirection.ToString();


            if (sort.Equals("Ascending"))
            {


            }
            else
            {

            }

        }

    }

    
}