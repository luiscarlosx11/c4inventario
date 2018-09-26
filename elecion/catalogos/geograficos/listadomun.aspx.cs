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
    public partial class listadomun : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (String.IsNullOrEmpty(lmunicipios.SortExpression)) lmunicipios.Sort("cvomun", SortDirection.Ascending);

                var id = (FormsIdentity)Page.User.Identity;
                var ticket = id.Ticket;
                string[] datos = ticket.UserData.Split(',');
                string[] datos2 = datos[1].Split(';');
                hentidad.Value = datos2[3];

            }
        }

        protected void refrescaGrid(object sender, EventArgs e)
        {
            DsListadoMunicipios.DataBind();
            lmunicipios.DataBind();
        }

        protected void conteoRegistros(object sender, EventArgs e)
        {
            DataView dv = (DataView)DsListadoMunicipios.Select(DataSourceSelectArguments.Empty);
            int numberOfRows = int.Parse(dv.Table.Compute("Count(idMunicipio)", "").ToString());

            labelConteo.Text = numberOfRows.ToString();
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
                    if (Int32.Parse(idm.Value)>0)
                        query = "UPDATE municipios set municipio=@municipio where idMunicipio=@idmunicipio and entidad=@entidad;";
                    else
                        query = "INSERT INTO municipios(municipio,entidad) values(@municipio,@entidad)";

                    SqlCommand cmd = new SqlCommand(query, con);

                    //Update
                    if (Int32.Parse(idm.Value) > 0)
                        cmd.Parameters.AddWithValue("@idmunicipio", idm.Value);
                    
                    cmd.Parameters.AddWithValue("@entidad", hentidad.Value);
                    cmd.Parameters.AddWithValue("@municipio", municipio.Text);

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
                    String query = "DELETE FROM municipios where idMunicipio=@idmunicipio and entidad=@entidad;";                    
                    SqlCommand cmd = new SqlCommand(query, con);                    
                    cmd.Parameters.AddWithValue("@idmunicipio", idm.Value);
                    cmd.Parameters.AddWithValue("@entidad", hentidad.Value);
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

        protected void lmunicipios_Sorting(object sender, GridViewSortEventArgs e)
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