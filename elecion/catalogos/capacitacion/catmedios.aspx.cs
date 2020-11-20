using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using MySql.Data.MySqlClient;

namespace elecion.catalogos.capacitacion
{
    public partial class catmedios : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (String.IsNullOrEmpty(lgastos.SortExpression)) lgastos.Sort("clave", SortDirection.Ascending);
            }
        }

        protected void conteoRegistros(object sender, EventArgs e)
        {
            DataView dv = (DataView)DsListadoGastos.Select(DataSourceSelectArguments.Empty);
            int numberOfRows = int.Parse(dv.Table.Compute("Count(idmedio)", "").ToString());

            labelConteo.Text = numberOfRows.ToString();
        }

        protected void refrescaGrid(object sender, EventArgs e)
        {
            DsListadoGastos.DataBind();
            lgastos.DataBind();
        }

        protected void guardaEdita(object sender, EventArgs e)
        {
           


                using (MySqlConnection con = new MySqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
                {

                    int uactivo = 0;
                    try
                    {

                        con.Open();
                        String query = "";

                        //Si el idmunicipio es mayor que cero se hace UPDATE
                        if (Int32.Parse(idS.Value) > 0)
                            query = "UPDATE medio set clave=@clave,medio=@nombre where idmedio=@idsucursal;";
                        else
                            query = "INSERT INTO medio(clave,medio) values(@clave,@nombre);";

                        MySqlCommand cmd = new MySqlCommand(query, con);


                        cmd.Parameters.AddWithValue("@idsucursal", idS.Value);
                    cmd.Parameters.AddWithValue("@clave", clave.Text.ToUpper().Trim());
                    cmd.Parameters.AddWithValue("@nombre", nombre.Text.ToUpper().Trim());


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
            using (MySqlConnection con = new MySqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {

                try
                {

                    con.Open();
                    String query = "DELETE FROM tipoventa where idtipoventa=@idarea;";
                    MySqlCommand cmd = new MySqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@idarea", idS.Value);
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

        protected void lgastos_Sorting(object sender, GridViewSortEventArgs e)
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