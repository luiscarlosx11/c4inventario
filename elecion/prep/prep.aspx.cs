using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace elecion.prep
{
    public partial class prep : System.Web.UI.Page
    {

        private static string tipo;
        private static string sec;

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void gCasillas_DataBound(object sender, EventArgs e)
        {
               
        }

        protected void gCasillas_RowCreated(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.ToolTip = "Click para seleccionar";
                e.Row.Attributes["onclick"] = ClientScript.GetPostBackClientHyperlink(this.gCasillas, "Select$" + e.Row.RowIndex);
            }
        }

        protected void gCasillas_SelectedIndexChanged(object sender, EventArgs e)
        {
            var idc = gCasillas.DataKeys[gCasillas.SelectedIndex].Value;
            hidc.Value = idc.ToString();
            tipo = gCasillas.Rows[gCasillas.SelectedIndex].Cells[0].Text;
            uDiv.Visible = true;
            LeyendaC.Text = "<h3>Casilla " + sec + " " + tipo+"</h3>";
        }

        private System.Data.DataTable ExecuteQuery(SqlCommand cmd, string action)
        {
            using (SqlConnection con = new SqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {
                cmd.Connection = con;
                switch (action)
                {
                    case "SELECT":
                        using (SqlDataAdapter sda = new SqlDataAdapter())
                        {
                            sda.SelectCommand = cmd;
                            using (System.Data.DataTable dt = new System.Data.DataTable())
                            {
                                sda.Fill(dt);
                                return dt;
                            }
                        }
                    case "UPDATE":
                        con.Open();
                        cmd.ExecuteNonQuery();
                        con.Close();
                        break;
                }
                return null;
            }
        }

        protected void btnUpdate_GOB(object sender, EventArgs e)
        {
            int fail = 0;
            foreach (GridViewRow row in gGobernador.Rows)
            {
                if (row.RowType == DataControlRowType.DataRow)
                {
                    try
                    {
                        SqlCommand cmd = new SqlCommand("UPDATE vot_gobernador SET votos = @votos WHERE id = @ids");
                        var vt = row.Cells[2].Controls.OfType<TextBox>().FirstOrDefault().Text;
                        cmd.Parameters.AddWithValue("@votos", vt);
                        cmd.Parameters.AddWithValue("@ids", gGobernador.DataKeys[row.RowIndex].Value);
                        ExecuteQuery(cmd, "UPDATE");
                       

                    }
                    catch(Exception ex)
                    {
                        fail = 1;
                    }

                }
            }

            if (fail == 0)
            {
                ClientScript.RegisterStartupScript(GetType(), "JsScript", "<script type='text/javascript'> window.onload = function(){ swal('Correcto!' , 'Información guardada con éxito', 'success');  };   </script>");
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "abrirModal", "window.onload = function(){ swaError('Ocurrio un erro al intentar guardar.'); };", true);
            }
                

            

        }

        protected void Botonbuscar_Click(object sender, EventArgs e)
        {
            uDiv.Visible = false;
            if (bseccion.Text.Length > 0)
            {
                Legendcasilla.Text = "<h2>Casilla " + bseccion.Text + "</h2>";
                sec = bseccion.Text;
            }
            else
            {
                Legendcasilla.Text = "";
                sec = "";
            }
        }

        protected void btnUpdate_PM(object sender, EventArgs e)
        {
            int fail = 0;
            foreach (GridViewRow row in gPM.Rows)
            {
                if (row.RowType == DataControlRowType.DataRow)
                {
                    try
                    {
                        SqlCommand cmd = new SqlCommand("UPDATE vot_pm SET votos = @votos WHERE id = @ids");
                        cmd.Parameters.AddWithValue("@votos", row.Cells[2].Controls.OfType<TextBox>().FirstOrDefault().Text);
                        cmd.Parameters.AddWithValue("@ids", gPM.DataKeys[row.RowIndex].Value);
                        this.ExecuteQuery(cmd, "UPDATE");

                    }
                    catch
                    {
                        fail = 1;
                    }

                }
            }

            if (fail == 0)
            {
                ClientScript.RegisterStartupScript(GetType(), "JsScript", "<script type='text/javascript'> window.onload = function(){ $('.nav-tabs a[href=\"#pm-tab\"]').tab('show'); swal('Correcto!' , 'Información guardada con éxito', 'success');  };   </script>");
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "abrirModal", "window.onload = function(){  $('.nav-tabs a[href=\"#pm-tab\"]').tab('show'); swaError('Ocurrio un erro al intentar guardar.'); };", true);
            }

        }

        protected void btnUpdate_Reigor(object sender, EventArgs e)
        {

            int fail = 0;

            foreach (GridViewRow row in gRegidor.Rows)
            {
                if (row.RowType == DataControlRowType.DataRow)
                {
                    try
                    {
                        SqlCommand cmd = new SqlCommand("UPDATE vot_regidores SET votos = @votos WHERE id = @ids");
                        cmd.Parameters.AddWithValue("@votos", row.Cells[2].Controls.OfType<TextBox>().FirstOrDefault().Text);
                        cmd.Parameters.AddWithValue("@ids", gRegidor.DataKeys[row.RowIndex].Value);
                        this.ExecuteQuery(cmd, "UPDATE");

                    }
                    catch
                    {
                        fail = 1;
                    }

                }
            }

            if (fail == 0)
            {
                ClientScript.RegisterStartupScript(GetType(), "JsScript", "<script type='text/javascript'> window.onload = function(){ $('.nav-tabs a[href=\"#dip_tap\"]').tab('show'); swal('Correcto!' , 'Información guardada con éxito', 'success');  };   </script>");
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "abrirModal", "window.onload = function(){  $('.nav-tabs a[href=\"#dip_tap\"]').tab('show'); swaError('Ocurrio un erro al intentar guardar.'); };", true);
            }

        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {

            int fail = 0;
            foreach (GridViewRow row in gDiputados.Rows)
            {
                if (row.RowType == DataControlRowType.DataRow)
                {
                    try
                    {
                        SqlCommand cmd = new SqlCommand("UPDATE vot_diputados SET votos = @votos WHERE id = @ids");
                        cmd.Parameters.AddWithValue("@votos", row.Cells[2].Controls.OfType<TextBox>().FirstOrDefault().Text);
                        cmd.Parameters.AddWithValue("@ids", gDiputados.DataKeys[row.RowIndex].Value);
                        this.ExecuteQuery(cmd, "UPDATE");

                    }
                    catch
                    {
                        fail = 1;
                    }

                }
            }

            if (fail == 0)
            {
                ClientScript.RegisterStartupScript(GetType(), "JsScript", "<script type='text/javascript'> window.onload = function(){ $('.nav-tabs a[href=\"#regidores\"]').tab('show'); swal('Correcto!' , 'Información guardada con éxito', 'success');  };   </script>");
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "abrirModal", "window.onload = function(){  $('.nav-tabs a[href=\"#regidores\"]').tab('show'); swaError('Ocurrio un erro al intentar guardar.'); };", true);
            }

        }
    }
}