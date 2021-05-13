using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using MySql.Data.MySqlClient;

namespace elecion.catalogos.configuracion
{
    public partial class catinstalaciones : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                listadoClientes(sender, e);
            }

            


        }

        protected void conteoRegistros(object sender, EventArgs e)
        {
            using (MySqlConnection con2 = new MySqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {
                try
                {
                    con2.Open();
                    string query = "SELECT COUNT(idinstalacion) as total " +
                                            "FROM instalacion " +
                                            "WHERE true ";

                    if (bcategoria.SelectedValue != "0")
                        query = query + " and idsucursal = " + Convert.ToInt32(bcategoria.SelectedValue) + " ";

                    MySqlCommand cmd2 = new MySqlCommand(query, con2);

                    MySqlDataReader rdr = cmd2.ExecuteReader();
                    if (rdr.HasRows)
                    {
                        rdr.Read();
                        labelConteo.Text = rdr["total"].ToString();

                    }


                }
                catch (Exception ex)
                {
                    System.Diagnostics.Debug.WriteLine("ERROR:" + ex.Message.Replace("\r\n", ""));
                }
                finally
                {
                    con2.Close();
                }
            }
        }

        protected void refrescaGrid(object sender, EventArgs e)
        {
            DsListadoGastos.DataBind();
            lgastos.DataBind();
        }


        protected void listadoClientes(object sender, EventArgs e)
        {

            lgastos.DataSourceID = DsListadoGastos.ID;

            String query = "select s.idinstalacion,  s.idsucursal, s.nombre, c.nombre as sucursal " +
                           "from instalacion s  " +
                           "left join sucursal c on c.idsucursal = s.idsucursal where true ";
                           

            //if (idtipousuario == 4)
            //    query = query + " AND T.ATIENDE=" + idusuario;

            if (bcategoria.SelectedValue != "0")
                query = query + " and s.idsucursal = " + Convert.ToInt32(bcategoria.SelectedValue)+" ";

           /* if (cliente.SelectedValue != "0")
                query = query + " AND T.IDCLIENTE=" + Convert.ToInt32(cliente.SelectedValue);*/

            if (bmunicipio.Text.Trim() != "")
                query = query + " and s.nombre LIKE '%" + bmunicipio.Text.ToUpper().Trim() + "%' ";


            //query = query + " LIMIT " + limit + " OFFSET " + offset;

            if (String.IsNullOrEmpty(lgastos.SortExpression))
                query = query + " ORDER BY c.nombre, s.nombre";

                DsListadoGastos.SelectCommand = query;

            DsListadoGastos.DataBind();
            lgastos.DataBind();
            
            //ScriptManager.RegisterClientScriptBlock(Page, typeof(string), "myScriptName", "cerrarLoading();", true);
            //gridSeguimiento.DataBind();

        }
        protected void guardaEdita(object sender, EventArgs e)
        {
            using (MySqlConnection con = new MySqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {
                MySqlDataReader reader = null;
                int uactivo = 0;
                int idinstalacion = 0;
                try
                {

                    con.Open();
                    String query = "";

                    //Si el idmunicipio es mayor que cero se hace UPDATE
                    if (Int32.Parse(idS.Value) > 0)
                    {
                        query = "UPDATE instalacion set nombre=@nombre where idinstalacion=@idsucursal;";
                        idinstalacion = Convert.ToInt32(idS.Value);
                    }
                    else
                    {
                       

                        query = "INSERT INTO instalacion(nombre, idsucursal) values (@nombre, @identidad);";
                    }
                    MySqlCommand cmd = new MySqlCommand(query, con);


                    cmd.Parameters.AddWithValue("@idsucursal", idinstalacion);
                    cmd.Parameters.AddWithValue("@identidad", identidad.SelectedValue);
                    cmd.Parameters.AddWithValue("@nombre", nombre.Text.ToUpper().Trim());


                    cmd.ExecuteNonQuery();

                    ScriptManager.RegisterClientScriptBlock(Page, typeof(string), "myScriptName", "cerrarLoading();", true);

                   // ScriptManager.RegisterClientScriptBlock(Page, typeof(string), "myScriptName", "cerrarLoading();", true);


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
                listadoClientes(sender, e);

            }


        }

        protected void borrarRegistro(object sender, EventArgs e)
        {
            


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