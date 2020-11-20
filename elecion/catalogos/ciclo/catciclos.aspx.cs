using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using MySql.Data.MySqlClient;

namespace elecion.catalogos.ciclo
{
    public partial class catciclos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (String.IsNullOrEmpty(lgastos.SortExpression)) lgastos.Sort("idcicloescolar", SortDirection.Descending);
            }
        }

        protected void conteoRegistros(object sender, EventArgs e)
        {
            DataView dv = (DataView)DsListadoGastos.Select(DataSourceSelectArguments.Empty);
            int numberOfRows = int.Parse(dv.Table.Compute("Count(idcicloescolar)", "").ToString());

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
                        query = "UPDATE cicloescolar set cicloescolar=@cicloescolar, fechaini=@fechaini, fechafin=@fechafin where idcicloescolar=@idcicloescolar;";
                    else
                        query = "INSERT INTO cicloescolar(cicloescolar, fechaini, fechafin) values(@cicloescolar, @fechaini, @fechafin);";

                    MySqlCommand cmd = new MySqlCommand(query, con);


                    cmd.Parameters.AddWithValue("@idcicloescolar", idS.Value);
                    cmd.Parameters.AddWithValue("@cicloescolar", cicloescolar.Text.ToUpper().Trim());
                    cmd.Parameters.AddWithValue("@fechaini", fechaini.Text);
                    cmd.Parameters.AddWithValue("@fechafin", fechafin.Text);


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


        protected void guardaEditaPeriodo(object sender, EventArgs e)
        {



            using (MySqlConnection con = new MySqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {

                int uactivo = 0;
                try
                {

                    con.Open();
                    String query = "";

                    //Si el idmunicipio es mayor que cero se hace UPDATE
                    if (Int32.Parse(idP.Value) > 0)
                        query = "UPDATE periodo set idcicloescolar=@idcicloescolar, periodo=@periodo, fechaini=@fechaini, fechafin=@fechafin where idperiodo=@idperiodo;";
                    else
                        query = "INSERT INTO periodo(idcicloescolar, periodo, fechaini, fechafin) values(@idcicloescolar, @periodo, @fechaini, @fechafin);";

                    MySqlCommand cmd = new MySqlCommand(query, con);


                    cmd.Parameters.AddWithValue("@idcicloescolar", idS.Value);
                    cmd.Parameters.AddWithValue("@idperiodo", idP.Value);
                    cmd.Parameters.AddWithValue("@periodo", periodo.Text.ToUpper().Trim());
                    cmd.Parameters.AddWithValue("@fechaini", Pfini.Text);
                    cmd.Parameters.AddWithValue("@fechafin", Pffin.Text);


                    cmd.ExecuteNonQuery();

                    ScriptManager.RegisterClientScriptBlock(Page, typeof(string), "myScriptName", "cerrarLoading();", true);

                    //ScriptManager.RegisterStartupScript(this, GetType(), "myScriptName", "cerrarLoading();  ", true);


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
                listadoPeriodos(sender, e);

                if (Int32.Parse(idP.Value) == 0)
                    refrescaGrid(sender, e);

            }



        }

        protected void borrarPeriodo(object sender, EventArgs e)
        {
            using (MySqlConnection con = new MySqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {

                try
                {

                    con.Open();
                    String query = "DELETE FROM periodo where idperiodo=@idP;";
                    MySqlCommand cmd = new MySqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@idP", idP.Value);
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

                listadoPeriodos(sender, e);
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


        protected void listadoPeriodos(object sender, EventArgs e)
        {

            try
            {

                GVperiodos.DataSourceID = DSperiodos.ID;

                String query = "select c.idcicloescolar, c.idperiodo, c.periodo, cast(c.fechaini as char)as fechaini, cast(c.fechafin as char)as fechafin "+
                               "from periodo c "+
                               "where c.idcicloescolar = "+idS.Value+" ";

                query = query + " order by c.idperiodo";

                //query = query + " LIMIT " + limit + " OFFSET " + offset;
                DSperiodos.SelectCommand = query;



            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("ERROR:" + ex.Message.Replace("\r\n", ""));
            }

            //ScriptManager.RegisterClientScriptBlock(Page, typeof(string), "myScriptName", "cerrarLoading();", true);
            //gridSeguimiento.DataBind();

        }


        protected void recuperaPeriodos(object sender, EventArgs e)
        {

            listadoPeriodos(sender, e);
            ScriptManager.RegisterStartupScript(this, GetType(), "myScriptName", "cerrarLoading();  $('#wperiodos').modal('show'); ", true);


        }

    }

}