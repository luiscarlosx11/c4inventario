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
    public partial class catregulares : System.Web.UI.Page
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
                    string query = "SELECT COUNT(idespecialidad) as total " +
                                            "FROM especialidad " +
                                            "WHERE true ";

                    if (bcategoria.SelectedValue != "0")
                        query = query + " and idarea = " + Convert.ToInt32(bcategoria.SelectedValue) + " ";

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

            String query = "select s.idcursoregular, s.idarea, s.idespecialidad, s.clave, s.nombre, c.area, e.especialidad " +
                           "from cursoregular s  " +
                           "left join area c on c.idarea = s.idarea " +
                           "left join especialidad e on e.idespecialidad = s.idespecialidad ";


            //if (idtipousuario == 4)
            //    query = query + " AND T.ATIENDE=" + idusuario;

            if (bcategoria.SelectedValue != "")
                query = query + " where s.idarea = " + Convert.ToInt32(bcategoria.SelectedValue) + " ";
            else
                query = query + " where s.idarea = 0 ";

            if (bespecialidad.SelectedValue != "")
                query = query + " and s.idespecialidad = " + Convert.ToInt32(bespecialidad.SelectedValue) + " ";

            /* if (cliente.SelectedValue != "0")
                 query = query + " AND T.IDCLIENTE=" + Convert.ToInt32(cliente.SelectedValue);*/



            //query = query + " LIMIT " + limit + " OFFSET " + offset;

            if (String.IsNullOrEmpty(lgastos.SortExpression))
                query = query + " ORDER BY c.area, e.especialidad, s.clave, s.nombre ";

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
                        query = "UPDATE especialidad set especialidad=@nombre, idarea=@identidad, clave=@clave where idespecialidad=@idsucursal;";
                    else
                        query = "INSERT INTO especialidad(especialidad, idarea, clave) values(@nombre, @identidad, @clave);";

                    MySqlCommand cmd = new MySqlCommand(query, con);


                    cmd.Parameters.AddWithValue("@idsucursal", idS.Value);
                    cmd.Parameters.AddWithValue("@identidad", identidad.SelectedValue);
                    cmd.Parameters.AddWithValue("@nombre", nombre.Text.ToUpper().Trim());
                    cmd.Parameters.AddWithValue("@clave", clave.Text.ToUpper().Trim());


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
                listadoGrid(sender, e);

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

        protected void refrescaCombos(object sender, EventArgs e)
        {
            bespecialidad.DataSourceID = Dsespecialidades.ID;
            bespecialidad.Items.Clear();

            String query = "select idespecialidad, especialidad FROM especialidad WHERE idarea ="+bcategoria.SelectedValue+" ORDER BY especialidad ";
            Dsespecialidades.SelectCommand = query;
            Dsespecialidades.DataBind();
            bespecialidad.DataBind();


        }


    }

}