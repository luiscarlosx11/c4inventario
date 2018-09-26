using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace elecion.prep
{
    public partial class altacasas : System.Web.UI.Page
    {
        private static string idc;
        private static string secc;

        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                var id = (System.Web.Security.FormsIdentity)Page.User.Identity;
                var ticket = id.Ticket;
                string[] datos = ticket.UserData.Split(',');
                string[] datos2 = datos[1].Split(';');
                hentidad.Value = datos2[3];
            }

            if (!IsPostBack)
            {
                String idCasa = "";

                try
                {
                    idCasa = Session["idC"].ToString();
                    idc = idCasa;
                    getCasa(idc);
                    Session.Remove("idC");
                    ScriptManager.RegisterStartupScript(this, GetType(), "abrirModal", "window.onload = function(){ $(document).prop('title', 'PLACEL - Editar Casa Amiga'); };", true);
                    labelcasa.Text = "Editar Casa Amiga ";
                }
                catch
                {
                    idc = "null";
                    secc = "null";
                    ScriptManager.RegisterStartupScript(this, GetType(), "abrirModal", "window.onload = function(){ $(document).prop('title', 'PLACEL - Agregar Casa Amiga'); };", true);
                    labelcasa.Text = "Agregar Casa Amiga";
                }

                Session.Remove("idC");

                if (idc.Equals("null"))
                {
                    string url = HttpContext.Current.Request.Url.AbsolutePath;
                    if (url.Equals("/editar-usuario"))
                    {
                        Response.RedirectToRoute("Usuarios");
                    }
                }

            }
        }

        private void getCasa(String idcasr)
        {
            using (SqlConnection con = new SqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {
                try
                {
                    con.Open();
                    string sql = "SELECT [id],[nombre],[idMunicipio],[seccion],[meta_op],[colonias] FROM [casas_amigas] where id=@idP";

                    SqlCommand cmd = new SqlCommand(sql, con);
                    cmd.Parameters.AddWithValue("@idP", idcasr);
                    SqlDataReader rdr = cmd.ExecuteReader();
                    if (rdr.HasRows)
                    {
                        rdr.Read();
                        idch.Value = rdr["id"].ToString();
                        nombre.Text = rdr["nombre"].ToString();

                        municipio.SelectedValue = rdr["idMunicipio"].ToString();
                        dseccion.SelectedValue = rdr["seccion"].ToString();
                        secc = rdr["seccion"].ToString();
                        colonias.Text = rdr["colonias"].ToString();
                        meta_op.Text = rdr["meta_op"].ToString();
                        hsecc.Value = secc;

                    }

                }
                catch (Exception ex)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "abrirModal", " swaError('Error al cargar datos de la casa: " + ex.Message.Replace("\r\n", "").Replace("'", "") + "'); ", true);
                }
                finally
                {
                    con.Close();
                }
            }
        }

        protected void pantalla_Click(object sender, EventArgs e)
        {

        }

        protected void guardaEdita_Click(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {
                con.Open();
                try
                {
                    String sql = "INSERT INTO casas_amigas (idMunicipio,municipio,seccion,colonias,meta_op,nombre) " +
                                 "values(@idm,@mun,@secc,@col,@meta,@nomb)";

                    SqlCommand cmd = new SqlCommand(sql, con);
                    cmd.Parameters.AddWithValue("@idm", municipio.SelectedValue);
                    cmd.Parameters.AddWithValue("@mun", municipio.SelectedItem.Text);
                    cmd.Parameters.AddWithValue("@secc", dseccion.SelectedValue);
                    cmd.Parameters.AddWithValue("@col", colonias.Text);
                    cmd.Parameters.AddWithValue("@meta", meta_op.Text);
                    cmd.Parameters.AddWithValue("@nomb", nombre.Text);
                    cmd.ExecuteNonQuery();
                   
                    ScriptManager.RegisterStartupScript(this, GetType(), "abrirModal", " exito(); ", true);

                }
                catch (Exception ex)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "abrirModal", " swaError('" + ex.Message.Replace("\r\n", "").Replace("'", "") + "'); ", true);
                }
                con.Close();
            }
        }

        protected void dseccion_DataBinding(object sender, EventArgs e)
        {
            //dseccion.CssClass = dseccion.CssClass.Replace("select2", "");
            if (!secc.Equals("null"))
            {
               
                //dseccion.SelectedValue = secc;
                //dseccion.SelectedValue = secc;
            }

            int t = dseccion.Items.Count;
            t =21;

        }

        protected void municipio_DataBinding(object sender, EventArgs e)
        {
            DsSeccion.DataBind();
            //dseccion.DataBind();

             if (!secc.Equals("null"))
             {
                int t= dseccion.Items.Count;
                dseccion.SelectedValue = secc;
             }

            //ScriptManager.RegisterStartupScript(this, GetType(), "abrirModal", " setSeccion('"+secc+"'); ", true);
        }
    }
}