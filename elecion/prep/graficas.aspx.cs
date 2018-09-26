using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace elecion.prep
{
    public partial class graficas : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void municipos_SelectedIndexChanged(object sender, EventArgs e)
        {
            String json = "";
            using (SqlConnection con = new SqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {
                List<datosGrafica> arrl = new List<datosGrafica>();
                try
                {

                    con.Open();
                    string query = "Select NOMBRE, PARTIDO, SUM(VOTOS) as votos " +
                                    "FROM vot_gobernador v " +
                                    "INNER JOIN secciones s on s.seccion = v.secc and s.idMunicipio = @idm " +
                                    "GROUP BY NOMBRE, PARTIDO";

                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@idm", municipos.SelectedValue);
                    SqlDataReader rdr = cmd.ExecuteReader();
                    if (rdr.HasRows)
                    {
                        //rdr.Read();
                        //valor = rdr.GetInt32(1);
                        while (rdr.Read())
                        {
                            datosGrafica dt = new datosGrafica();
                            dt.data = rdr.GetInt32(2);
                            dt.label = rdr["NOMBRE"].ToString();
                            arrl.Add(dt);
                        }

                        datosGrafica[] arr2 = arrl.ToArray();
                        json = Newtonsoft.Json.JsonConvert.SerializeObject(arr2);
                        int o = 1;
                    }


                }
                catch (Exception ex)
                {
                    String rx = ex.Message;
                }

                con.Close();
            }

            ScriptManager.RegisterStartupScript(this, GetType(), "inicilizarMun", " var data ='"+json+"'", true);
        }
    }
}