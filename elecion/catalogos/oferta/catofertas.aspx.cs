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
    public partial class catofertas : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (String.IsNullOrEmpty(lgastos.SortExpression)) lgastos.Sort("ofertaeducativa", SortDirection.Ascending);
            }
        }

        protected void conteoRegistros(object sender, EventArgs e)
        {
            DataView dv = (DataView)DsListadoGastos.Select(DataSourceSelectArguments.Empty);
            int numberOfRows = int.Parse(dv.Table.Compute("Count(idofertaeducativa)", "").ToString());

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
                    
                    MySqlTransaction transaction = null;
                    MySqlDataReader reader = null;

                    try
                    {
                        con.Open();
                        MySqlCommand cmd = con.CreateCommand();

                        // Start a local transaction
                        transaction = con.BeginTransaction();
                        // Must assign both transaction object and connection
                        // to Command object for a pending local transaction
                        cmd.Connection = con;
                        cmd.Transaction = transaction;

                        String query = "";

                            int uvigente;
                            if (vigente.Checked)
                                uvigente = 1;
                            else
                                uvigente = 0;

                        //Si el idmunicipio es mayor que cero se hace UPDATE
                        if (Int32.Parse(idS.Value) > 0)
                                query = "UPDATE ofertaeducativa set ofertaeducativa=@ofertaeducativa, vigente=@vigente where idofertaeducativa=@idofertaeducativa;";
                            else
                                query = "INSERT INTO ofertaeducativa(ofertaeducativa, vigente) values(@ofertaeducativa, @vigente);";


                        cmd.CommandText = query;
                        cmd.Parameters.AddWithValue("@idofertaeducativa", idS.Value);
                        cmd.Parameters.AddWithValue("@vigente", uvigente);
                        cmd.Parameters.AddWithValue("@ofertaeducativa", ofertaeducativa.Text.ToUpper().Trim());
                        cmd.ExecuteNonQuery();

                        if (uvigente == 1)
                        {
                            cmd.Parameters.Clear();
                            query = "update ofertaeducativa set vigente=0 where idofertaeducativa not in(@idofertaeducativa);";
                            cmd.CommandText = query;
                            cmd.Parameters.AddWithValue("@idofertaeducativa", idS.Value);
                            cmd.ExecuteNonQuery();
                        }
                        

                        transaction.Commit();

                        ScriptManager.RegisterClientScriptBlock(Page, typeof(string), "myScriptName", "cerrarLoading();", true);


                    }
                    catch (Exception ex)
                    {
                        transaction.Rollback();
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