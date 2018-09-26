using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

namespace elecion.estructuras
{
    public partial class agregar : System.Web.UI.Page
    {

        private static string idEstructura;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                String idProm = "";

                try
                {
                    idProm = Session["idP"].ToString();
                    idEstructura = idProm;
                    getEstructura(idEstructura);
                }
                catch
                {
                    Response.Redirect("~/estructuras/estructuras.aspx");
                }

            }
            else
            {


            }
        }

        private void getEstructura(String idEstructura)
        {            

            using (SqlConnection con = new SqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {
                try
                {
                    con.Open();
                    string sql = "SELECT [idEstructura],[nombre],[descripcion] FROM [estructuras] where idEstructura=@idP";
                    SqlCommand cmd = new SqlCommand(sql, con);
                    cmd.Parameters.AddWithValue("@idP", idEstructura);
                    SqlDataReader rdr = cmd.ExecuteReader();
                    if (rdr.HasRows)
                    {
                        rdr.Read();
                        idP.Value = rdr["idEstructura"].ToString();
                        nombre.Text = rdr["nombre"].ToString();
                        descripcion.Text = rdr["descripcion"].ToString();

                        /*if (rdr["tipoorganizacion"].ToString() == "1")
                        {
                            tipogral.Checked = true;
                            nivelorg.Enabled = false;
                        }
                        else
                        {
                            tipoespec.Checked = true;
                            nivelorg.Enabled = true;
                            nivelorg.SelectedValue = rdr["nivelorganizacion"].ToString();
                        }*/

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


        protected void guardaEdita(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {

                
                try
                {
                    con.Open();

                    String query = "";

                    if (Int32.Parse(idP.Value) > 0)
                        query = "UPDATE estructuras set nombre=@nmb, descripcion=@dsc where idEstructura=@idP";
                    else
                        query = "INSERT INTO estructuras(nombre, descripcion) values(@nmb, @dsc)";

                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@idP", idP.Value);
                    cmd.Parameters.AddWithValue("@nmb", nombre.Text);
                    cmd.Parameters.AddWithValue("@dsc", descripcion.Text);

                    //if (tipogral.Checked) cmd.Parameters.AddWithValue("@tipoorg", 1);
                   // else if (tipoespec.Checked) cmd.Parameters.AddWithValue("@tipoorg", 2);

                    //cmd.Parameters.AddWithValue("@nivelorg", nivelorg.SelectedValue);

                    cmd.ExecuteNonQuery();

                    
                    Response.Redirect("~/estructuras/estructuras.aspx");
                   
                    
                }
                catch (Exception ex)
                {

                    //ScriptManager.RegisterStartupScript(this, GetType(), "abrirModal", "window.onload = function(){ swaError('" + ex.Message.Replace("\r\n", "") + "'); };", true);

                }
                finally
                {
                    con.Close();
                }


            }
        }

        protected void regresar(object sender, EventArgs e)
        {
            Response.Redirect("~/estructuras/estructuras.aspx");
        }

        protected void tipogral_CheckedChanged(object sender, EventArgs e)
        {
            //asdads
            if (tipogral.Checked)
            {
                nivelorg.Enabled = false;
            }else if(tipoespec.Checked)
            {
                nivelorg.Enabled = true;
            }
        }
    }
}