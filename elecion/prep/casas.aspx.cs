using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace elecion.prep
{
    public partial class casas : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Botonbuscar_Click(object sender, EventArgs e)
        {
            uDiv.Visible = false;
            hidc.Value = bseccion.Text;
            int activo = 0;
            using (System.Data.SqlClient.SqlConnection con = new System.Data.SqlClient.SqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {
                con.Open();
                try
                {
                    string sql = "SELECT secc, municipio, colonia, activacion, operadores_activo FROM casas_amiga WHERE secc = @bsec";
                    System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand(sql, con);
                    cmd.Parameters.AddWithValue("@bsec", bseccion.Text);
                    System.Data.SqlClient.SqlDataReader rdr = cmd.ExecuteReader();
                    if (rdr.HasRows)
                    {
                        rdr.Read();
                        mun.Text = rdr.GetString(1); 
                        nsecc.Text = rdr["secc"].ToString();
                        col.Text = rdr["colonia"].ToString();
                        activo = rdr.GetInt32(3);
                        operadores.Text = rdr.GetInt32(4).ToString();
                        uDiv.Visible = true;
                    }

                    if (activo == 0)
                    {
                        nop.Visible = false;
                        activar.Visible = true;
                    }
                    else
                    {
                        activar.Visible = false;
                        nop.Visible = true;
                    }

                    ScriptManager.RegisterStartupScript(this, GetType(), "abrirModal", " cerrarLoading();", true);

                }
                catch(Exception ex)
                {
                    uDiv.Visible = false;
                    //ScriptManager.RegisterStartupScript(this, GetType(), "abrirModal", "window.onload = function(){ swaError('Ocurrio un error al cargar: " + ex.Message.Replace("\r\n", "") + "'); };", true);
                    ScriptManager.RegisterStartupScript(this, GetType(), "abrirModal", "window.onload = function(){ swaError('Ocurrio un error al cargar: " + ex.Message.Replace("\r\n", "") + "'); };", true);
                }
                con.Close();
            }

                
        }

        protected void activar_Click(object sender, EventArgs e)
        {
            using (System.Data.SqlClient.SqlConnection con = new System.Data.SqlClient.SqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {
                con.Open();
            
                if (!hidc.Value.Equals(""))
                {
                    try
                    {
                        string sql= "UPDATE casas_amiga set activacion = 1 where secc = @bsec";
                        System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand(sql, con);
                        cmd.Parameters.AddWithValue("@bsec", bseccion.Text);
                        cmd.ExecuteNonQuery();
                        activar.Visible = false;
                        nop.Visible = true;
                        //ClientScript.RegisterStartupScript(GetType(), "JsScript", "<script type='text/javascript'> window.onload = function(){ swal('Correcto!' , 'Cambios guardado con éxito', 'success');  };   </script>");
                        ScriptManager.RegisterStartupScript(this, GetType(), "abrirModal", " swal('Correcto!' , 'Se marco como activa esta casa amiga', 'success');", true);
                    }
                    catch(Exception ex)
                    {
                        ScriptManager.RegisterStartupScript(this, GetType(), "abrirModal", " swaError('Ocurrio un error: " + ex.Message.Replace("\r\n", "") + "');", true);
                    }
                }



                con.Close();

            }
        }

        protected void guardar_Click(object sender, EventArgs e)
        {
            if (!operadores.Text.Equals(""))
            {
                using (System.Data.SqlClient.SqlConnection con = new System.Data.SqlClient.SqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
                {
                    con.Open();

                    if (!hidc.Value.Equals(""))
                    {
                        try
                        {
                            string sql = "UPDATE casas_amiga set operadores_activo = @noa where secc = @bsec";
                            System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand(sql, con);
                            cmd.Parameters.AddWithValue("@noa", operadores.Text);
                            cmd.Parameters.AddWithValue("@bsec", bseccion.Text);
                            cmd.ExecuteNonQuery();
                            ScriptManager.RegisterStartupScript(this, GetType(), "abrirModal", " swal('Correcto!' , 'Cambios guardado con éxito', 'success');", true);
                        }
                        catch (Exception ex)
                        {
                            ScriptManager.RegisterStartupScript(this, GetType(), "abrirModal", " swaError('Error al guardar: " + ex.Message.Replace("\r\n", "") + "');", true);
                        }
                    }



                    con.Close();

                }
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "abrirModal", "  swaError('No puede quedar en blanco número de operadores'); ", true);
            }
           
        }
    }
}