using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using MySql.Data.MySqlClient;

namespace elecion.catalogos.oferta
{
    public partial class catareas : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                listadoGrid(sender, e);
            }
        }

        protected void conteoRegistros(object sender, EventArgs e)
        {
            using (MySqlConnection con2 = new MySqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {
                try
                {
                    con2.Open();
                    string query = "SELECT COUNT(idarea) as total " +
                                            "FROM idarea " +
                                            "WHERE true ";

                    if (boferta.SelectedValue != "0")
                        query = query + " and idofertaeducativa = " + Convert.ToInt32(boferta.SelectedValue) + " ";

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

            String query = "select s.idarea,  s.area " +
                           "from area s  " +
                           "where true ";


            //if (idtipousuario == 4)
            //    query = query + " AND T.ATIENDE=" + idusuario;

            if (boferta.SelectedValue != "")
                query = query + " and s.idofertaeducativa = " + boferta.SelectedValue + " ";

            else
                query = query + " and s.idofertaeducativa = (select idofertaeducativa from ofertaeducativa where vigente=1)";

            /* if (cliente.SelectedValue != "0")
                 query = query + " AND T.IDCLIENTE=" + Convert.ToInt32(cliente.SelectedValue);*/

            if (barea.Text.Trim() != "")
                query = query + " and s.area LIKE '%" + barea.Text.ToUpper().Trim() + "%' ";


            //query = query + " LIMIT " + limit + " OFFSET " + offset;

            if (String.IsNullOrEmpty(lgastos.SortExpression))
                query = query + " ORDER BY s.area ";

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

                    int uactivo = 0;
                    try
                    {

                        con.Open();
                        String query = "";

                        //Si el idmunicipio es mayor que cero se hace UPDATE
                        if (Int32.Parse(idS.Value) > 0)
                            query = "UPDATE area set area=@nombre where idarea=@idsucursal;";
                        else
                            query = "INSERT INTO area(area, idofertaeducativa) values(@nombre, @idofertaeducativa);";

                        MySqlCommand cmd = new MySqlCommand(query, con);


                        cmd.Parameters.AddWithValue("@idsucursal", idS.Value);
                        cmd.Parameters.AddWithValue("@idofertaeducativa", boferta.SelectedValue);
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
                listadoGrid(sender, e);

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