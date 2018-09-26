using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace elecion.prep
{
    public partial class resultados : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            String json = "";
            String json2 = "";
            String datos = "";
            using (SqlConnection con = new SqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {
                List<datosGrafica> arrl = new List<datosGrafica>();
                List<EchartsData> arrl2 = new List<EchartsData>();
                try
                {

                    con.Open();
                    string query = "SELECT NOMBRE, PARTIDO, SUM(VOTOS) as votos FROM vot_gobernador GROUP BY NOMBRE, PARTIDO";
                    SqlCommand cmd = new SqlCommand(query, con);
                    SqlDataReader rdr = cmd.ExecuteReader();
                    if (rdr.HasRows)
                    {
                        //rdr.Read();
                        //valor = rdr.GetInt32(1);
                        while (rdr.Read())
                        {
                            datosGrafica dt = new datosGrafica();
                            EchartsData dt2 = new EchartsData();
                            dt.data = rdr.GetInt32(2);
                            dt.label = rdr["NOMBRE"].ToString();
                            dt2.value = rdr.GetInt32(2);
                            dt2.name = rdr["NOMBRE"].ToString();
                            arrl.Add(dt);
                            arrl2.Add(dt2);
                            datos = datos +"'"+ rdr["NOMBRE"].ToString() + "',";
                        }
                        datos = datos.TrimEnd(',');
                        datos = "[ " + datos + " ]";
                        datosGrafica[] arr2 = arrl.ToArray();
                        EchartsData[] arr3 = arrl2.ToArray();
                        json = JsonConvert.SerializeObject(arr2);
                        json2 = JsonConvert.SerializeObject(arr3);
                        int o = 1;
                    }


                }
                catch (Exception ex)
                {
                    String rx = ex.Message;
                }

                con.Close();
            }

            ScriptManager.RegisterStartupScript(this, GetType(), "inicilizarMun", "data ="+json+ "; datos=" + datos + "; data2 =" + json2 + ";", true);
        }

        protected void municipos_SelectedIndexChanged(object sender, EventArgs e)
        {
            String json = "";
            String datos = "";
            using (SqlConnection con = new SqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {
                List<datosGrafica> arrl = new List<datosGrafica>();
                try
                {

                    con.Open();
                    string query = "Select NOMBRE, PARTIDO, SUM(VOTOS) as votos "+
                                    "FROM vot_gobernador v "+
                                    "INNER JOIN secciones s on s.seccion = v.secc and s.idMunicipio = @idm "+
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
                            datos = datos + rdr["NOMBRE"].ToString() + ",";
                        }
                        datos = datos.TrimEnd(',');
                        datos = "[ " + datos + " ]";
                        datosGrafica[] arr2 = arrl.ToArray();
                        json = JsonConvert.SerializeObject(arr2);
                        int o = 1;
                    }


                }
                catch (Exception ex)
                {
                    String rx = ex.Message;
                }

                con.Close();
            }
            // window.onload = function(){ swal('Correcto!', 'Información guardada con éxito', 'success'); }
            //ScriptManager.RegisterStartupScript(this, GetType(), "inicilizarMun", "alert('alert'); window.onload = function(){ alert('hola'); swal('Correcto!', 'Información guardada con éxito', 'success');", true);
            ScriptManager.RegisterStartupScript(this, GetType(), "alerta", "data =" + json + "; datos="+datos+";", true);
        }
    }
}