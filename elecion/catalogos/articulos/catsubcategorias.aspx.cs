using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using MySql.Data.MySqlClient;

namespace elecion.catalogos.articulos
{
    public partial class catsubcatcategorias : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                
            }

            
            listadoGrid(sender, e);
        }

        protected void conteoRegistros(object sender, EventArgs e)
        {
            using (MySqlConnection con2 = new MySqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {
                try
                {
                    con2.Open();
                    string query = "SELECT COUNT(idsubcategoria) as total " +
                                            "FROM subcategoria " +
                                            "WHERE true ";

                    if (bcategoria.SelectedValue != "0")
                        query = query + " and idcategoria = " + Convert.ToInt32(bcategoria.SelectedValue) + " ";

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


        protected void listadoGrid(object sender, EventArgs e)
        {

            lgastos.DataSourceID = DsListadoGastos.ID;

            String query = "select s.idsubcategoria,  s.idcategoria, s.subcategoria, c.categoria " +
                           "from subcategoria s  " +
                           "left join categoria c on c.idcategoria = s.idcategoria ";
                           

            //if (idtipousuario == 4)
            //    query = query + " AND T.ATIENDE=" + idusuario;

            if (bcategoria.SelectedValue != "0")
                query = query + " where s.idcategoria = " + Convert.ToInt32(bcategoria.SelectedValue)+" ";

           /* if (cliente.SelectedValue != "0")
                query = query + " AND T.IDCLIENTE=" + Convert.ToInt32(cliente.SelectedValue);

            if (concepto.Text.Trim() != "")
                query = query + " AND T.CONCEPTO LIKE '%" + concepto.Text.Trim() + "%' ";*/

           
            //query = query + " LIMIT " + limit + " OFFSET " + offset;
            DsListadoGastos.SelectCommand = query;

            DsListadoGastos.DataBind();
            lgastos.DataBind();

            if (String.IsNullOrEmpty(lgastos.SortExpression)) lgastos.Sort("categoria, subcategoria", SortDirection.Ascending);
            //ScriptManager.RegisterClientScriptBlock(Page, typeof(string), "myScriptName", "cerrarLoading();", true);
            //gridSeguimiento.DataBind();

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
                    if (Int32.Parse(idg.Value) > 0)
                        query = "UPDATE subcategoria set subcategoria=@area, idcategoria=@idcategoria where idsubcategoria=@idarea;";
                    else
                        query = "INSERT INTO subcategoria(subcategoria, idcategoria) values(@area,@idcategoria);";

                    MySqlCommand cmd = new MySqlCommand(query, con);


                    cmd.Parameters.AddWithValue("@idarea", idg.Value);
                    cmd.Parameters.AddWithValue("@idcategoria", area.SelectedValue);
                    cmd.Parameters.AddWithValue("@area", tipogasto.Text.ToUpper());

                   

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
                    String query = "DELETE FROM subcategoria where idsubcategoria=@idarea;";
                    MySqlCommand cmd = new MySqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@idarea", idg.Value);
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