using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;

namespace elecion
{
    public partial class satisfaccion : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            totales();
            lineCalificaciones();
        }



        private void totales()
        {

            

            using (MySqlConnection con = new MySqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {
                try
                {
                    con.Open();
                    string query = "select round(AVG(t2.idcalificacion), 1) as idcalificacion " +
                                    "from ticket t2 ";
                                   // "where month(t2.FECHA) = month(CURRENT_DATE)";
                    MySqlCommand cmd = new MySqlCommand(query, con);

                    MySqlDataReader rdr = cmd.ExecuteReader();
                    if (rdr.HasRows)
                    {
                        //rdr.Read();
                        //valor = rdr.GetInt32(1);
                        while (rdr.Read())
                        {
                           
                            ltotalGral.Text= rdr["idcalificacion"].ToString();
                        }

                    }
                    rdr.Close();
                    //con.Close();
                    //con.Open();
                    query = "select round(AVG(t2.idcalificacion), 1) as idcalificacion " +
                                    "from ticket t2 "+
                                    "where month(t2.FECHA) = month(CURRENT_DATE)";
                    cmd = new MySqlCommand(query, con);

                    rdr = cmd.ExecuteReader();
                    if (rdr.HasRows)
                    {
                        //rdr.Read();
                        //valor = rdr.GetInt32(1);
                        while (rdr.Read())
                        {

                            ltotalMes.Text = rdr["idcalificacion"].ToString();
                        }

                    }


                }
                catch (Exception ex)
                {
                    String rx = ex.Message;
                }
                finally
                {
                    con.Close();
                }
                
            }
        }
        
        private void lineCalificaciones()
        {

            List<double> arrl = new List<double>();
            List<int> arrl2 = new List<int>();
            List<String> labels = new List<String>();
            String json = "";
            
            using (MySqlConnection con = new MySqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {
                try
                {
                    con.Open();
                    string query = "SELECT DISTINCT(month(t.FECHA))as mes, "+
                                   "( " +
                                   "case  " +
                                   "when month(t.FECHA) = 1 then 'Enero' " +
                                   "when month(t.FECHA) = 2 then 'Febrero' " +
                                   "when month(t.FECHA) = 3 then 'Marzo' " +
                                   "when month(t.FECHA) = 4 then 'Abril' " +
                                   "when month(t.FECHA) = 5 then 'Mayo' " +
                                   "when month(t.FECHA) = 6 then 'Junio' " +
                                   "when month(t.FECHA) = 7 then 'Julio' " +
                                   "when month(t.FECHA) = 8 then 'Agosto' " +
                                   "when month(t.FECHA) = 9 then 'Septiembre' " +
                                   "when month(t.FECHA) = 10 then 'Octubre' " +
                                   "when month(t.FECHA) = 11 then 'Noviembre' " +
                                   "when month(t.FECHA) = 12 then 'Diciembre' " +
                                   "end " +
                                   ") as nombre, " +
                                   "  ( " +
                                   "   select round(AVG(t2.idcalificacion), 1) " +
                                   "   from ticket t2 " +
                                   "   where month(t2.FECHA) = mes " +
                                   "  )as idcalificacion " +
                                   "from ticket t";
                    MySqlCommand cmd = new MySqlCommand(query, con);

                    MySqlDataReader rdr = cmd.ExecuteReader();
                    if (rdr.HasRows)
                    {
                        //rdr.Read();
                        //valor = rdr.GetInt32(1);
                        while (rdr.Read())
                        {
                            arrl.Add(Convert.ToDouble(rdr["idcalificacion"]));
                            labels.Add(rdr["nombre"].ToString());
                        }

                    }


                }
                catch (Exception ex)
                {
                    String rx = ex.Message;
                }
                finally
                {
                    con.Close();
                }
                List<datasets> list = new List<datasets>();
                datasets dts = new datasets();
                double[] arr2 = arrl.ToArray();
                dts.data = null;                
                dts.label = "Satisfacción";


                list.Add(dts);
                //list.Add(dts2);
                json = JsonConvert.SerializeObject(arr2);

                string lb = "\"" + string.Join("\",\"", labels.ToArray()) + "\"";
                //System.Diagnostics.Debug.WriteLine("userPageVisitData ={ labels: [" + lb + "], datasets:  [ { label:'" + dts.label + "', data: " + json + ",backgroundColor:[" + dts.backgroundColor + "]  }] };");
                ScriptManager.RegisterStartupScript(this, GetType(), "lineCalif", "dataCalif={ labels: [" + lb + "], datasets:  [ { label:'" + dts.label + "', data:" + json + ",fill: false, borderDash: [5, 5], borderColor: '#00A5A8',pointBorderColor: '#00A5A8', pointBackgroundColor: '#FFF', pointBorderWidth: 2,pointHoverBorderWidth: 2, pointRadius: 4  }] };", true);

            }
        }
    }
}