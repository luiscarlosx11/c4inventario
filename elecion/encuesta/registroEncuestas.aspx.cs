using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Globalization;
using System.Linq;
using System.Threading;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace elecion.encuesta
{
    public partial class registroEncuestas : System.Web.UI.Page
    {

        private static string idGasto;

        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                String idProm = "";

                try
                {
                    idProm = Session["idP"].ToString();


                    idGasto = idProm;
                    idP.Value = idGasto;
                    refrescaGrid(sender, e);                    
                    //getPromovido(idGasto);

                }
                catch
                {
                    Response.Redirect("~/encuesta/listadoencuestas.aspx");
                }

            }
            else
            {

            }

        }

        private void getPromovido(String idGasto)
        {
            using (SqlConnection con = new SqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {
                try
                {
                    con.Open();
               
                    string sql = "SELECT fechaini,fechafin, concepto FROM encuesta where idencuesta=@idP";
                    SqlCommand cmd = new SqlCommand(sql, con);
                    cmd.Parameters.AddWithValue("@idP", idGasto);
                    SqlDataReader rdr = cmd.ExecuteReader();
                    if (rdr.HasRows)
                    {
                        rdr.Read();
                        //idP.Value = rdr["idgasto"].ToString();

                        if (rdr["fechaini"] != DBNull.Value)
                        {
                            DateTime dt = DateTime.Parse(rdr["fechaini"].ToString());
                            fechaini.Text = dt.ToString("yyyy-MM-dd");
                        }
                        if (rdr["fechafin"] != DBNull.Value)
                        {
                            DateTime dt = DateTime.Parse(rdr["fechafin"].ToString());
                            fechafin.Text = dt.ToString("yyyy-MM-dd");
                        }

                        concepto.Text = rdr["concepto"].ToString();
                       

                    }

                }
                catch (Exception ex)
                {
                    //ScriptManager.RegisterStartupScript(this, GetType(), "abrirModal", "window.onload = function(){ swaError('" + ex.Message.Replace("\r\n", "") + "'); };", true);

                    System.Diagnostics.Debug.WriteLine("ERROR:" + ex.Message.Replace("\r\n", ""));
                }
                finally
                {
                    con.Close();
                }
            }
        }

        protected void guardaEditaConcepto(object sender, EventArgs e)
        {

            using (SqlConnection con = new SqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {
                try
                {
                    con.Open();

                    string sql = "INSERT INTO detalleGasto(idgasto,idtipogasto,monto) values(@idgasto,@idtipogasto,@monto);";

                    SqlCommand cmd = new SqlCommand(sql, con);


                    cmd.Parameters.AddWithValue("@idgasto", idP.Value);
                    cmd.Parameters.AddWithValue("@idtipogasto", tipogasto.SelectedValue);
                    cmd.Parameters.AddWithValue("@monto", monto.Text);

                    cmd.ExecuteNonQuery();


                    refrescaGrid(sender, e);
                    refrescaCombo(sender, e);

                }
                catch (Exception ex)
                {

                    System.Diagnostics.Debug.WriteLine("ERROR:" + ex.Message.Replace("\r\n", ""));
                }
                finally
                {
                    con.Close();
                    ScriptManager.RegisterClientScriptBlock(Page, typeof(string), "myScriptName", "cerrarLoading();", true);
                }

            }

        }


        protected void borrarRegistro(object sender, EventArgs e)
        {
            using (System.Data.SqlClient.SqlConnection con = new System.Data.SqlClient.SqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {

                try
                {

                    con.Open();
                    String query = "DELETE FROM detalleGasto where idtipogasto=@idP;";
                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@idP", idtP.Value);
                    cmd.ExecuteNonQuery();


                    refrescaGrid(sender, e);
                    refrescaCombo(sender, e);

                }
                catch (Exception ex)
                {
                    System.Diagnostics.Debug.WriteLine("error:" + ex.ToString());
                    Console.WriteLine("error:" + ex.ToString());
                }
                finally
                {
                    con.Close();
                    ScriptManager.RegisterClientScriptBlock(Page, typeof(string), "myScriptName", "cerrarLoading();", true);
                }

            }

        }

        protected void refrescaCombo(object sender, EventArgs e)
        {
            DsTipoGasto.DataBind();
            tipogasto.DataBind();
        }

        protected void refrescaGrid(object sender, EventArgs e)
        {
            //DsListado.DataBind();
           // ldetallegasto.DataBind();
        }


        protected void regresar(object sender, EventArgs e)
        {

            Response.Redirect("~/presupuesto/gastos/listadogastos.aspx");

        }

        protected void guardaEdita(object sender, EventArgs e)
        {

            using (SqlConnection con = new SqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {
                try
                {
                    con.Open();

                    string sql = "UPDATE Gasto set concepto=@concepto,fecha=@fecha,seccion=@seccion,observaciones=@observaciones where idgasto=@idgasto;";

                    SqlCommand cmd = new SqlCommand(sql, con);


                    cmd.Parameters.AddWithValue("@idgasto", idP.Value);
                    cmd.Parameters.AddWithValue("@concepto", concepto.Text);
                    

                    cmd.ExecuteNonQuery();

                    // ScriptManager.RegisterClientScriptBlock(Page, typeof(string), "myScriptName", "cerrarLoading();", true);
                    Response.Redirect("~/presupuesto/gastos/listadogastos.aspx");


                }
                catch (Exception ex)
                {

                    System.Diagnostics.Debug.WriteLine("ERROR:" + ex.Message.Replace("\r\n", ""));
                }
                finally
                {
                    con.Close();
                }

            }


        }

        private object CDate(object text)
        {
            throw new NotImplementedException();
        }
    }

}