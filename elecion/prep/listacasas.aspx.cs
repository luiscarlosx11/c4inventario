using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace elecion.prep
{
    public partial class listacasas : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                var id = (System.Web.Security.FormsIdentity)Page.User.Identity;
                var ticket = id.Ticket;
                string[] datos = ticket.UserData.Split(',');
                string[] datos2 = datos[1].Split(';');
                hentidad.Value = datos2[3];
                conteoRegistros();
            }
        }

        protected void conteoRegistros()
        {
            using (SqlConnection con = new SqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {
                con.Open();
                try
                {
                    string sql = "Select count(*) from casas_amigas";
                    SqlCommand cmd = new SqlCommand(sql, con);
                    SqlDataReader rdr = cmd.ExecuteReader();
                    if (rdr.HasRows)
                    {
                        rdr.Read();
                        labelConteo.Text = rdr.GetInt32(0).ToString();
                    }
                    
                }
                catch { }

                con.Close();
            }
        }

        protected void Beditar_Click(object sender, EventArgs e)
        {
            Session["idC"] = idP.Value;
            Response.RedirectToRoute("CasasAmigaEditar");
        }

        protected void Bborrar_Click(object sender, EventArgs e)
        {

        }

        protected void Bnuevo_Click(object sender, EventArgs e)
        {
            Response.RedirectToRoute("CasasAmigasNueva");
        }
        protected void refrescaGrid(object sender, EventArgs e)
        {
           // DsListado.DataBind();
            //lpromovidos.DataBind();
        }

        protected void seccion_DataBound(object sender, EventArgs e)
        {
            //seccionbus.Items.Clear();
            seccionbus.Items.Insert(0, new ListItem("Todos", "%"));
        }
    }
}