using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Globalization;
using System.Linq;
using System.Threading;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace elecion.promocion
{
    public partial class agregarevento : System.Web.UI.Page
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
                    
                    getPromovido(idGasto);

                }
                catch
                {
                    Response.Redirect("~/promocion/agenda.aspx");
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

                    System.Diagnostics.Debug.WriteLine("idGasto:" + idGasto);
                    string sql = "SELECT fechaini, fechafin, CONVERT(varchar(15),CAST(horaini AS TIME),100)as horaini, CONVERT(varchar(15),CAST(horafin AS TIME),100)as horafin, concepto,observaciones FROM agenda where idagenda=@idP";
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
                        if (rdr["horaini"] != DBNull.Value)
                        {
                            horaini.Text = rdr["horaini"].ToString();
                        }
                        if (rdr["horafin"] != DBNull.Value)
                        {
                            horafin.Text = rdr["horafin"].ToString();
                        }

                        concepto.Text = rdr["concepto"].ToString();
                       
                        observaciones.Text = rdr["observaciones"].ToString();

                    }

                }
                catch (Exception ex)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "abrirModal", "window.onload = function(){ swaError('" + ex.Message.Replace("\r\n", "") + "'); };", true);

                    //System.Diagnostics.Debug.WriteLine("ERROR:" + ex.Message.Replace("\r\n", ""));
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
                    string sql = "INSERT INTO detalleAgenda(idagenda,nota) values(@idagenda,@nota);";

                    SqlCommand cmd = new SqlCommand(sql, con);
                    cmd.Parameters.AddWithValue("@idagenda", idP.Value);
                    cmd.Parameters.AddWithValue("@nota", nota.Text);
                    cmd.ExecuteNonQuery();

                    refrescaGrid(sender, e);
                    

                }
                catch (Exception ex)
                {

                    //ScriptManager.RegisterStartupScript(this, GetType(), "abrirModal", "window.onload = function(){ swaError('" + ex.Message.Replace("\r\n", "") + "'); };", true);
                    ScriptManager.RegisterClientScriptBlock(Page, typeof(string), "myScriptName", "swaError('" + ex.Message.Replace("\r\n", "") + "');", true);
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
                    String query = "DELETE FROM detalleAgenda where idnota=@idP;";
                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@idP", idtP.Value);
                    cmd.ExecuteNonQuery();


                    refrescaGrid(sender, e);
                    

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

        

        protected void refrescaGrid(object sender, EventArgs e)
        {
            DsListado.DataBind();
            ldetallegasto.DataBind();
        }


        protected void regresar(object sender, EventArgs e)
        {

            Response.Redirect("~/promocion/agenda.aspx");

        }

        protected void guardaEdita(object sender, EventArgs e)
        {

            using (SqlConnection con = new SqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {
                try
                {
                    con.Open();

                    string sql = "UPDATE agenda set concepto=@concepto,fechaini=@fechaini,fechafin=@fechafin,horaini=@horaini,horafin=@horafin,observaciones=@observaciones where idagenda=@idagenda;";

                    SqlCommand cmd = new SqlCommand(sql, con);


                    cmd.Parameters.AddWithValue("@idagenda", idP.Value);
                    cmd.Parameters.AddWithValue("@concepto", concepto.Text);
                    
                    cmd.Parameters.AddWithValue("@fechaini", fechaini.Text);

                    if(fechafin.Text!="")
                        cmd.Parameters.AddWithValue("@fechafin", fechafin.Text);
                    else
                        cmd.Parameters.AddWithValue("@fechafin", DBNull.Value);

                    if (horaini.Text != "")
                        cmd.Parameters.AddWithValue("@horaini", horaini.Text);
                    else
                        cmd.Parameters.AddWithValue("@horaini", DBNull.Value);

                    if (horafin.Text != "")
                        cmd.Parameters.AddWithValue("@horafin", horafin.Text);
                    else
                        cmd.Parameters.AddWithValue("@horafin", DBNull.Value);
                   
                    cmd.Parameters.AddWithValue("@observaciones", observaciones.Text);
                  

                    cmd.ExecuteNonQuery();

                    // ScriptManager.RegisterClientScriptBlock(Page, typeof(string), "myScriptName", "cerrarLoading();", true);
                    Response.Redirect("~/promocion/agenda.aspx");


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