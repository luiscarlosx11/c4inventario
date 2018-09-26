using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace elecion.estructuras
{
    public partial class estructura : System.Web.UI.Page
    {
        static string ide;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                String idu = "";

                var id = (FormsIdentity)User.Identity;
                var ticket = id.Ticket;
                string[] datos = ticket.UserData.Split(',');
                try
                {
                    HttpContext CurrContext = HttpContext.Current;
                    idu = CurrContext.Items["ide"].ToString();
                    getEstructura(idu);
                    ide = idu;
                    DsEstructura.SelectCommand = "SELECT [idCoordinador], CONCAT([nombre],' ',[paterno],' ',[materno]) as nombre, [email], [telefono], [coordinacion] "+
                                                 "FROM[coordinadores] c " +
                                                 "INNER  JOIN[tipoCoordinador] tc on tc.idTipo = c.tipo WHERE idEstructura = "+ idu;
                }
                catch
                {
                    Response.Redirect("estructuras.aspx");
                }

            }
        }

        private void getEstructura(String id)
        {
            using (SqlConnection con = new SqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {
                try
                {
                    con.Open();
                    string sql = "SELECT nombre, descripcion from estructuras WHERE idEstructura = @ide";
                    SqlCommand cmd = new SqlCommand(sql, con);
                    cmd.Parameters.AddWithValue("@ide", id);
                    SqlDataReader rdr = cmd.ExecuteReader();
                    if (rdr.HasRows)
                    {
                        rdr.Read();
                        nombrEstructura.Text = rdr["nombre"].ToString();
                        nombrEstructura2.Text = nombrEstructura.Text;
                    }

                    rdr.Close();

                }catch(Exception ex)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "abrirModal", "window.onload = function(){ swaError('" + ex.Message.Replace("\r\n", "").Replace("'","") + "'); };", true);
                }
                finally
                {
                    con.Close();
                }
            }
        }

        protected void irCoord_Click(object sender, EventArgs e)
        {
            HttpContext CurrContext = HttpContext.Current;
            String idd = ide;
            CurrContext.Items.Add("ide", idd);
            Server.Transfer("coordinador.aspx", true);
        }
    }
}