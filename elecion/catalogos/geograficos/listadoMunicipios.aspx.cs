using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace elecion.catalogos.geograficos
{
    public partial class listadomunicipios : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (String.IsNullOrEmpty(lmunicipios.SortExpression)) lmunicipios.Sort("cvomun", SortDirection.Ascending);
            }
        }

        protected void refrescaGrid(object sender, EventArgs e)
        {
            DsListadoMunicipios.DataBind();
            lmunicipios.DataBind();
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
                    if (Int32.Parse(idm.Value) > 0)
                        query = "UPDATE municipios set municipio=@municipio where idMunicipio=@idmunicipio;";
                    else
                        query = "INSERT INTO municipios(cvomun,municipio,entidad,nombre) values(@cvomun,@municipio,@entidad,@nombre)";

                    SqlCommand cmd = new SqlCommand(query, con);

                    //Update
                    if (Int32.Parse(idm.Value) > 0)
                        cmd.Parameters.AddWithValue("@idmunicipio", idm.Value);
                    else
                    {
                        cmd.Parameters.AddWithValue("@cvomun", cvomun.Text);
                        cmd.Parameters.AddWithValue("@entidad", "18");
                        cmd.Parameters.AddWithValue("@nombre", "Nayarit");
                    }
                    cmd.Parameters.AddWithValue("@municipio",municipio.Text);

                    cmd.ExecuteNonQuery();


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

        protected void borrarRegistro(object sender, EventArgs e)
        {
            using (System.Data.SqlClient.SqlConnection con = new System.Data.SqlClient.SqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {
                System.Diagnostics.Debug.WriteLine("en eliminar:");
                Console.WriteLine("en eliminar:");

                try
                {

                    con.Open();
                    String query = "DELETE FROM municipios where idMunicipio=@idmunicipio;";
                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@idmunicipio", idm.Value);
                    cmd.ExecuteNonQuery();


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