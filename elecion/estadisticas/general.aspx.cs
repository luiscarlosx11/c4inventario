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
    public partial class general : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            totales();
            pieClientes();
            barraTickets();
        }


        private void pieClientes()
        {

            List<int> arrl = new List<int>();
            List<int> arrl2 = new List<int>();
            List<String> labels = new List<String>();
            String json = "";
            Random random = new Random();
            using (MySqlConnection con = new MySqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {
                try
                {
                    con.Open();
                    string query = "select c.NOMBRE,  ( " +
                                       "select coalesce(count(t2.idticket), 0) " +
                                       " from ticket t2 " +
                                       " where t2.IDCLIENTE = c.idcliente " +
                                       " ) as total " +
                                       " from cliente c " +
                                       " order by total desc " +
                                       " limit 0,10";
                    MySqlCommand cmd = new MySqlCommand(query, con);

                    MySqlDataReader rdr = cmd.ExecuteReader();
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
                int[] arr2 = arrl.ToArray();
                dts.data = null;
                dts.backgroundColor = "'#00A5A8', '#626E82', '#FF7D4D', '#FF4558', '#16D39A','#6666CC','#FF99CC','#FFFF00','#CCCCCC','#FF9900'";
                dts.label = "Clientes";


                list.Add(dts);
                //list.Add(dts2);
                json = JsonConvert.SerializeObject(arr2);
                
                string lb = "\"" + string.Join("\",\"", labels.ToArray()) + "\"";
                //System.Diagnostics.Debug.WriteLine("userPageVisitData ={ labels: [" + lb + "], datasets:  [ { label:'" + dts.label + "', data: " + json + ",backgroundColor:[" + dts.backgroundColor + "]  }] };");
                ScriptManager.RegisterStartupScript(this, GetType(), "pieClientes", "dataClientes={ labels: [" + lb + "], datasets:  [ { label:'" + dts.label + "', data:" + json + ",backgroundColor:[" + dts.backgroundColor + "]  }] };", true);

            }
        }


        private void barraTickets()
        {

            //Atendidos
            List<int> arrl = new List<int>();
            List<int> arrl2 = new List<int>();

            //Cancelados
            List<int> arrl3 = new List<int>();
            List<int> arrl4 = new List<int>();
            List<String> labels = new List<String>();
            String json = "", json2 = "";
            Random random = new Random();
            using (MySqlConnection con = new MySqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {
                try
                {
                    con.Open();
                    string query = "SELECT DISTINCT(month(t.FECHA))as mes, "+
                                    "( " +
                                    "case  " +
                                    "    when month(t.FECHA) = 1 then 'Enero'  " +
                                    "    when month(t.FECHA) = 2 then 'FebrERO'  " +
                                    "    when month(t.FECHA) = 3 then 'Marzo'  " +
                                    "    when month(t.FECHA) = 4 then 'Abril' " +
                                    "    when month(t.FECHA) = 5 then 'Mayo' " +
                                    "    when month(t.FECHA) = 6 then 'Junio' " +
                                    "    when month(t.FECHA) = 7 then 'Julio' " +
                                    "    when month(t.FECHA) = 8 then 'Agosto' " +
                                    "    when month(t.FECHA) = 9 then 'Septiembre' " +
                                    "    when month(t.FECHA) = 10 then 'Octubre' " +
                                    "    when month(t.FECHA) = 11 then 'Noviembre' " +
                                    "    when month(t.FECHA) = 12 then 'Diciembre' " +
                                    "end " +
                                    ")as nombre, " +
                                    "( " +
                                    "select count(t2.IDTICKET)  " +
                                    "    from ticket t2 " +
                                    "    where t2.ESTATUS = 'CERRADO' " +
                                    "    and month(t2.FECHA) = mes " +
                                    ") as atendidos, " +
                                    "( " +
                                    "select count(t2.IDTICKET) " +
                                    "    from ticket t2 " +
                                    "    where t2.ESTATUS = 'CANCELADO' " +
                                    "    and month(t2.FECHA) = mes " +
                                    ")as cancelados " +
                                    "from ticket t " +
                                    "order by mes";
                    MySqlCommand cmd = new MySqlCommand(query, con);

                    MySqlDataReader rdr = cmd.ExecuteReader();
                    if (rdr.HasRows)
                    {
                        //rdr.Read();
                        //valor = rdr.GetInt32(1);
                        while (rdr.Read())
                        {
                            arrl.Add(Convert.ToInt32(rdr["atendidos"]));
                            arrl3.Add(Convert.ToInt32(rdr["cancelados"]));
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
                int[] arr2 = arrl.ToArray();
                dts.data = null;
                dts.backgroundColor = "'#16D39A','#16D39A','#16D39A'";
                dts.label = "Atendidos";
                list.Add(dts);

                datasets dts2 = new datasets();
                int[] arr4 = arrl3.ToArray();
                dts2.data = null;
                dts2.backgroundColor = "'#FF6275','#FF6275','#FF6275'";
                dts2.label = "Cancelados";
                list.Add(dts2);

                //list.Add(dts2);
                json = JsonConvert.SerializeObject(arr2);
                json2 = JsonConvert.SerializeObject(arr4);
                string lb = "\"" + string.Join("\",\"", labels.ToArray()) + "\"";
                //System.Diagnostics.Debug.WriteLine("userPageVisitData ={ labels: [" + lb + "], datasets:  [ { label:'" + dts.label + "', data: " + json + ",backgroundColor:[" + dts.backgroundColor + "]  }] };");
                ScriptManager.RegisterStartupScript(this, GetType(), "barraTotales", "datosBar={ labels: [" + lb + "], datasets:  [ { label:'" + dts.label + "', data:" + json + ",backgroundColor:[" + dts.backgroundColor + "], borderColor: 'transparent'  } , { label:'" + dts2.label + "', data:" + json2 + ",backgroundColor:[" + dts2.backgroundColor + "], borderColor: 'transparent'  }] };", true);

            }
        }

        private void totales()
        {
            using (MySqlConnection con = new MySqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {
                try
                {
                    con.Open();

                    string sql = "SELECT " +
                                "(  " +
                                "SELECT count(t.IDTICKET) " +
                                "from ticket t " +
                                "where t.estatus = 'CERRADO' " +
                                ")AS ATENDIDOS, " +
                                "( " +
                                "SELECT count(t.IDTICKET) " +
                                "from ticket t " +
                                "where t.estatus = 'ACTIVO' " +
                                ")AS ACTIVOS, " +
                                "( " +
                                "SELECT count(t.IDTICKET) " +
                                "from ticket t " +
                                "where t.idterminacion = 2 " +
                                ")AS CANCELADOS, " +
                                "( " +
                                "SELECT count(t.IDTICKET) " +
                                "from seguimiento t " +
                                ")AS NOTAS " +

                                "FROM ticket " +
                                "limit 0,1 ";
                    MySqlCommand cmd = new MySqlCommand(sql, con);
                    MySqlDataReader rdr = cmd.ExecuteReader();
                    if (rdr.HasRows)
                    {
                        rdr.Read();

                        atendidos.Text = rdr["atendidos"].ToString();
                        activos.Text =  rdr["activos"].ToString();
                        cancelados.Text =  rdr["cancelados"].ToString();
                        notas.Text = rdr["notas"].ToString();

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