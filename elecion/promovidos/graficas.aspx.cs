using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace elecion.promovidos
{
    public partial class graficas : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                var id = (FormsIdentity)Page.User.Identity;
                var ticket = id.Ticket;
                string[] datos = ticket.UserData.Split(',');
                string[] datos2 = datos[1].Split(';');
                hentidad.Value = datos2[3];

                getTotal();
                getGraficaBarra();
                //getGraficaSecciones();
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
                                       " where m.entidad = @entidad " +
                                       " order by total desc";
                        SqlCommand cmd = new SqlCommand(query, con);
                        cmd.Parameters.AddWithValue("@entidad", hentidad.Value);
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
                    //System.Diagnostics.Debug.WriteLine("userPageVisitData ={ labels: [" + lb + "], datasets:  [ { label:'" + dts.label + "', data: " + json + ",backgroundColor:[" + dts.backgroundColor + "]  }] };");
                    ScriptManager.RegisterStartupScript(this, GetType(), "inicilizarMun", "userPageVisitData={ labels: [" + lb + "], datasets:  [ { label:'"+dts.label+"', data:" + json + ",backgroundColor:[" + dts.backgroundColor + "]  }] };", true);
                }

            }
        }

        private void getGraficaBarra()
        {

           
            List<datosGraficaBar> arra = new List<datosGraficaBar>();
            String json = "";
         
            using (SqlConnection con = new SqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {
                try
                {
                    con.Open();
                    string query = "select e.preferencia as estado, " +
                                   " ( " +
                                   " select count(idP) as total " +
                                   " from promovidos " +
                                   " where estado = e.preferencia " +
                                   "and entidad=@entidad "+
                                   " ) as total " +
                                   " from preferencia e " +
                                   " order by e.idpreferencia";
                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@entidad", hentidad.Value);
                    SqlDataReader rdr = cmd.ExecuteReader();

                    

                    if (rdr.HasRows)
                    {
                        while (rdr.Read())
                        {
                            datosGraficaBar dt = new datosGraficaBar();
                            dt.data = new int[] { rdr.GetInt32(1) };
                            dt.label = rdr["estado"].ToString();

                            if(rdr["estado"].ToString()=="Favor")
                                dt.backgroundColor = "#16D39A"; 
                            else if(rdr["estado"].ToString() == "Indeciso")
                                 dt.backgroundColor = "#FF7D4D";
                            else
                                 dt.backgroundColor = "#FF4558"; 
                            

                            dt.borderColor = "transparent";
                            arra.Add(dt);
                            

                        }

                        datosGraficaBar[] arr3 = arra.ToArray();
                        json = Newtonsoft.Json.JsonConvert.SerializeObject(arr3);                        

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
                                               
                ScriptManager.RegisterStartupScript(this, GetType(), "datosBarra", "datosBar ={ labels: [' '], datasets: " + json + "};", true);


            }

        }


        private void getGraficaSecciones()
        {

            List<int> arrl = new List<int>();
            List<int> arrl2 = new List<int>();
            List<String> labels = new List<String>();
            String json = "";
       
            List<datosGraficaBar> arra = new List<datosGraficaBar>();

            using (SqlConnection con = new SqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {
                try
                {
                    con.Open();


                    string query = "select e.preferencia as estado, " +
                                   "( " +
                                   "select count(idP) as total " +
                                   " from promovidos " +
                                   " where entidad = @entidad " +
                                   " and seccion = @seccion " +
                                   " and estado = e.preferencia " +
                                   " ) as total " +
                                   " from preferencia e " +
                                   " order by e.idpreferencia";


                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@seccion", seccional.SelectedValue);
                    cmd.Parameters.AddWithValue("@entidad", hentidad.Value);

                    SqlDataReader rdr = cmd.ExecuteReader();
                    if (rdr.HasRows)
                    {

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
                    dts.backgroundColor = "'#16D39A', '#FF7D4D','#FF4558'";
                    dts.label = "Promoción del Voto";


                    list.Add(dts);
                    //list.Add(dts2);
                    json = JsonConvert.SerializeObject(arr2);
                    string lb = "\"" + string.Join("\",\"", labels.ToArray()) + "\"";
                    ScriptManager.RegisterStartupScript(this, GetType(), "inicilizarSecc", "var chartDataUserMun={ labels: [" + lb + "], datasets:  [ { data:" + json + ",backgroundColor:[" + dts.backgroundColor + "]  }] };", true);
                

                    
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
                                    "where entidad=@entidad "+
                                    "group by p.estado "+
                                    "order by p.estado ";
                                    
                    int i = 1;

                    SqlCommand cmd = new SqlCommand(sql, con);
                    cmd.Parameters.AddWithValue("@entidad", hentidad.Value);
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


        protected void municipios_DataBound(object sender, EventArgs e)
        {
            DsSeccional.DataBind();
            seccional.DataBind();
        }

        protected void seccion_SelectedIndexChanged(object sender, EventArgs e)
        {
            getGraficaSecciones();
        }


    }
}