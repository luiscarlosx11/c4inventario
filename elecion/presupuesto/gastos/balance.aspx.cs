using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace elecion.presupuesto.gastos
{
    public partial class balance : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

                getTotal();
                getTop3Conceptos();
                getGraficaConceptos();
                getGraficaMunicipios();

            }
        }


        private void getGraficaConceptos()
        {

            List<double> arrl = new List<double>();
            List<int> arrl2 = new List<int>();
            List<String> labels = new List<String>();
            String json = "";
            Random random = new Random();
            
            using (SqlConnection con = new SqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {
                try
                {
                    con.Open();
               
                    string query = "select t.tipogasto, " +
                                   "(" +
                                   "select cast( sum(d.monto) as float) " +
                                   "from detalleGasto d " +
                                   "where d.idtipogasto = t.idtipogasto " +
                                   ")as total " +
                                   "from tipoGasto t " +
                                   "order by t.tipoGasto";
  

                    SqlCommand cmd = new SqlCommand(query, con);
                    SqlDataReader rdr = cmd.ExecuteReader();
                    if (rdr.HasRows)
                    {

                        while (rdr.Read())
                        {
                            System.Diagnostics.Debug.WriteLine(rdr.GetString(0));

                            arrl.Add(rdr.GetDouble(1));
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
                double[] arr2 = arrl.ToArray();
                dts.data = null;
                dts.backgroundColor = "'#16D39A'";
                dts.label = "Conceptos";



                list.Add(dts);
                //list.Add(dts2);
                json = JsonConvert.SerializeObject(arr2);
                string lb = "\"" + string.Join("\",\"", labels.ToArray()) + "\"";
                ScriptManager.RegisterStartupScript(this, GetType(), "inicilizar", "chartDataUser={ labels: [" + lb + "], datasets:  [ { data:" + json + ",backgroundColor:[" + dts.backgroundColor + "]  }] };", true);
                

            }

        }


        private void getGraficaMunicipios()
        {

            List<double> arrl = new List<double>();
            List<int> arrl2 = new List<int>();
            List<String> labels = new List<String>();
            String json = "";
           

            using (SqlConnection con = new SqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {
                try
                {
                    con.Open();
                    

                    string query = "select top 5 m.municipio, "+
                                   "(" +
                                   "select cast(coalesce(sum(d.monto), 0) as float) " +
                                   "from detalleGasto d " +

                                   "left join gasto g on g.idgasto = d.idgasto " +

                                   "left join secciones s on s.seccion = g.seccion " +
                                   "where s.idmunicipio = m.idmunicipio and s.entidad = 18 " +
                                   ") as total " +
                                   "from municipios m " +

                                   "where m.entidad = 18 " +
                                   "order by total desc";

                   

                    SqlCommand cmd = new SqlCommand(query, con);
                    SqlDataReader rdr = cmd.ExecuteReader();
                    if (rdr.HasRows)
                    {

                        while (rdr.Read())
                        {
                            System.Diagnostics.Debug.WriteLine(rdr.GetString(0));

                            arrl.Add(rdr.GetDouble(1));
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
                double[] arr2 = arrl.ToArray();
                dts.data = null;
                dts.backgroundColor = "'#00A5A8', '#626E82', '#FF7D4D', '#FF4558', '#16D39A','#6666CC','#FF99CC','#FFFF00','#CCCCCC','#FF9900'";
                dts.label = "Municipios";


                list.Add(dts);
                //list.Add(dts2);
                json = JsonConvert.SerializeObject(arr2);
                string lb = "\"" + string.Join("\",\"", labels.ToArray()) + "\"";
                ScriptManager.RegisterStartupScript(this, GetType(), "inicilizarMun", "chartDataUserMun={ labels: [" + lb + "], datasets:  [ { data:" + json + ",backgroundColor:[" + dts.backgroundColor + "]  }] };", true);


            }

        }

        private void getTotal()
        {
            using (SqlConnection con = new SqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {
                try
                {
                    con.Open();
                    
                    string sql = "select REPLACE(CONVERT(VARCHAR(20), CAST(sum(monto) AS MONEY), 1), '.00', '')as total from detalleGasto";
                    SqlCommand cmd = new SqlCommand(sql, con);                   
                    SqlDataReader rdr = cmd.ExecuteReader();
                    if (rdr.HasRows)
                    {
                        rdr.Read();
                        
                        lTotalGral.Text="$ "+ rdr["total"].ToString();

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


        private void getTop3Conceptos()
        {
            using (SqlConnection con = new SqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {
                try
                {
                    con.Open();

                    string sql = "select top 3 REPLACE(CONVERT(VARCHAR(20), CAST(sum(d.monto) AS MONEY), 1), '.00', '')as total,t.tipoGasto "+
                                 "from detalleGasto d " +
                                 "left join tipoGasto t on d.idtipogasto = t.idtipogasto " +
                                 "group by t.tipogasto " +
                                 "order by sum(d.monto)desc ";
                    int i = 1;

                    SqlCommand cmd = new SqlCommand(sql, con);
                    SqlDataReader rdr = cmd.ExecuteReader();

                    while (rdr.Read())
                    {

                        System.Diagnostics.Debug.WriteLine("cet:" + rdr["tipoGasto"].ToString());

                        switch (i)
                        {
                            case 1:
                                lconcepto1.Text = rdr["tipoGasto"].ToString();
                                ltotal1.Text = "$ " + rdr["total"].ToString();
                            break;

                            case 2:
                                lconcepto2.Text = rdr["tipoGasto"].ToString();
                                ltotal2.Text = "$ " + rdr["total"].ToString();
                                break;

                            case 3:
                                lconcepto3.Text = rdr["tipoGasto"].ToString();
                                ltotal3.Text = "$ " + rdr["total"].ToString();
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