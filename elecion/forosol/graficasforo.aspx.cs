using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace elecion.foro
{
    public partial class graficasforo : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                getTotal();
                List<int> arrl = new List<int>();
                List<int> arrl2 = new List<int>();
                List<String> labels = new List<String>();
                String json = "";
                Random random = new Random();
                using (SqlConnection con = new SqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
                {
                    try
                    {
                        con.Open();
                        string query = "select top 10 m.municipio, "+
                                       " ( " +
                                       " select coalesce(count(p.idP), 0) " +
                                       " from promovidos p " +
                                       " where p.idmunicipio = m.idmunicipio " +
                                       " ) as total " +
                                       " from municipios m " +
                                       " where m.entidad = 18 " +
                                       " order by total desc";
                        SqlCommand cmd = new SqlCommand(query, con);
                        SqlDataReader rdr = cmd.ExecuteReader();
                        if (rdr.HasRows)
                        {
                            //rdr.Read();
                            //valor = rdr.GetInt32(1);
                            while (rdr.Read())
                            {
                                arrl.Add(rdr.GetInt32(1));                               
                                labels.Add(rdr.GetString(0));
                            }
                            
                        }


                    }
                    catch(Exception ex) {
                        String rx = ex.Message;
                    }
                    finally
                    {
                        con.Close();
                    }
                    List<datasets> list = new List<datasets>();
                    datasets dts = new datasets();
                    int[] arr2 = arrl.ToArray();
                    dts.data = null;
                    dts.backgroundColor = "'#00A5A8', '#626E82', '#FF7D4D', '#FF4558', '#16D39A','#6666CC','#FF99CC','#FFFF00','#CCCCCC','#FF9900'";
                    dts.label = "Municipios";


                    list.Add(dts);
                    //list.Add(dts2);
                    json = JsonConvert.SerializeObject(arr2);
                    string lb = "\"" + string.Join("\",\"", labels.ToArray()) + "\"";
                    System.Diagnostics.Debug.WriteLine("userPageVisitData ={ labels: [" + lb + "], datasets:  [ { label:'" + dts.label + "', data: " + json + ",backgroundColor:[" + dts.backgroundColor + "]  }] };");
                    ScriptManager.RegisterStartupScript(this, GetType(), "inicilizarMun", "userPageVisitData={ labels: [" + lb + "], datasets:  [ { label:'"+dts.label+"', data:" + json + ",backgroundColor:[" + dts.backgroundColor + "]  }] };", true);
                }

            }
        }


        private void getTotal()
        {

            using (SqlConnection con = new SqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {
                try
                {
                    con.Open();

                    string sql =    "select count(p.idP) as total, p.estado,round(cast(count(p.idP) * 100 as float) / (select sum(d.listanominal) from secciones d),2)as porcentaje "+
                                    "from promovidos p " +
                                    "group by p.estado "+
                                    "order by p.estado ";
                                    
                    int i = 1;

                    SqlCommand cmd = new SqlCommand(sql, con);
                    SqlDataReader rdr = cmd.ExecuteReader();

                    while (rdr.Read())
                    {

                        
                      

                        switch (i)
                        {
                            case 1:
                                
                                ltotalcontra.Text = rdr["total"].ToString();
                                lporcentajecontra.Text = rdr["porcentaje"].ToString()+" %";
                                break;

                            case 2:
                               
                                ltotalfavor.Text = rdr["total"].ToString();
                                lporcentajefavor.Text = rdr["porcentaje"].ToString() + " %";
                                break;

                            case 3:
                                
                                ltotalindecisos.Text = rdr["total"].ToString();
                                lporcentajeindecisos.Text = rdr["porcentaje"].ToString() + " %";
                                break;

                        }
                        i++;


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


    }
}