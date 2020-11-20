using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;
using System.Web.Security;
using Telerik.Reporting.Processing;
using System.IO;
using System.Threading;

namespace elecion.catalogos.ciclo
{
    public partial class calendario : System.Web.UI.Page
    {
        private int idsucursal;
        private int idusuario;

        protected void Page_Load(object sender, EventArgs e)
        {

            var idu = (FormsIdentity)Page.User.Identity;
            var ticket = idu.Ticket;
            string[] datos = ticket.UserData.Split(',');
            string[] datos2 = datos[1].Split(';');
            idusuario = Convert.ToInt32(datos[0]);
            idsucursal = Convert.ToInt32(datos2[4]);

            if (!IsPostBack)
            {
                getCalendario(sender, e);
            }

           
        }

        protected void getCalendario(object sender, EventArgs e)
        {
            String json = "";
            String sql = "";
            MySqlCommand cmd = null;
            try
            {


                using (MySqlConnection con = new MySqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
                {
                    con.Open();
                    
                    MySqlDataReader rdr = null;                   

                    String query = "SELECT idfechalibre as idfecha, cast(fecha as char)as fecha "+
                                   "from fechaslibres " +
                                   "order by fecha";

                    cmd = new MySqlCommand(query, con);
                    rdr = cmd.ExecuteReader();


                    json += "[";

                    //new queryString/command setup

                    if (rdr.HasRows)
                    {

                        while (rdr.Read())
                        {

                            json += "{";
                            json += "id:'" + rdr["idfecha"].ToString() + "',";
                            json += "title:'INHÁBIL',";
                            //json += "description:'" + rdr["horaini"].ToString() + " - " + rdr["horafin"].ToString() + "',";
                            json += "fecha:'" + rdr["fecha"].ToString() + "',";                          
                            json += "start:'" + rdr["fecha"].ToString() + "',";
                            json += "end:'" + rdr["fecha"].ToString() + "',";
                            //json += "rendering: 'background',";
                            json += "color:'#967ADC'";
                            json += "},";

                        }

                    }

                    json += "]";


                    rdr.Close();



                }
               
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("ERROR:" + ex.Message.Replace("\r\n", ""));
            }

           // ScriptManager.RegisterClientScriptBlock(Page, typeof(string), "myScriptName", " ", true);            
            ScriptManager.RegisterStartupScript(this, GetType(), "inicilizarMun", "cerrarLoading(); $('#wfechas').modal('hide'); dataEvent =" + json, true);
           
        }


        protected void generaFechasCurso(object sender, EventArgs e)
        {



            using (MySqlConnection con = new MySqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {

                MySqlTransaction transaction = null;
                MySqlDataReader reader = null;

                String query = "";
              
                List<fechascurso> listafechas = null;
               
                try
                {

                    con.Open();

                    MySqlCommand cmd = con.CreateCommand();

                    // Start a local transaction
                    transaction = con.BeginTransaction();
                    // Must assign both transaction object and connection
                    // to Command object for a pending local transaction
                    cmd.Connection = con;
                    cmd.Transaction = transaction;
                  
                    cmd.Parameters.Clear();
                    //SE REVISA SI LA FECHA NO EXISTE YA PARA ESE CURSO
                    cmd.CommandText = "select * from " +
                    "(select adddate('1970-01-01', t4.i * 10000 + t3.i * 1000 + t2.i * 100 + t1.i * 10 + t0.i) fecha from " +
                    " (select 0 i union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t0, " +
                    " (select 0 i union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t1, " +
                    " (select 0 i union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t2, " +
                    " (select 0 i union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t3, " +
                    " (select 0 i union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t4) v " +
                    "where fecha between '" + fechaini.Text + "' and '" + fechafin.Text + "'" +
                    "and fecha not in (select fecha from fechaslibres where YEAR(fecha)=YEAR(current_date())); ";

                    listafechas = new List<fechascurso>();

                    reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        fechascurso item = new fechascurso();
                        item.fecha = reader.GetString(0);
                        listafechas.Add(item);
                    }
                    reader.Close();
                    reader.Dispose();
                   

                    foreach (fechascurso item in listafechas)
                    {

                        cmd.Parameters.Clear();
                        query = "insert into fechaslibres (fecha) values (@fecha); ";

                        cmd.CommandText = query;
                        cmd.Parameters.AddWithValue("@fecha", item.fecha);
                        cmd.ExecuteNonQuery();

                    }
                   

                    transaction.Commit();


                }
                catch (Exception ex)
                {
                    transaction.Rollback();
                    System.Diagnostics.Debug.WriteLine("error:" + ex.ToString());
                    Console.WriteLine("error:" + ex.ToString());
                }
                finally
                {
                    con.Close();
                }

                getCalendario(sender, e);
                //ScriptManager.RegisterStartupScript(this, GetType(), "myScriptName", "cerrarLoading(); ", true);

            }


        }

        protected void borraFechasCurso(object sender, EventArgs e)
        {



            using (MySqlConnection con = new MySqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {

                MySqlTransaction transaction = null;
                MySqlDataReader reader = null;

                String query = "";

                List<fechascurso> listafechas = null;

                try
                {

                    con.Open();

                    MySqlCommand cmd = con.CreateCommand();

                    // Start a local transaction
                    transaction = con.BeginTransaction();
                    // Must assign both transaction object and connection
                    // to Command object for a pending local transaction
                    cmd.Connection = con;
                    cmd.Transaction = transaction;

                    cmd.Parameters.Clear();
                    //SE REVISA SI LA FECHA NO EXISTE YA PARA ESE CURSO
                   

                   query = "delete from fechaslibres where idfechalibre=@fecha; ";

                   cmd.CommandText = query;
                   cmd.Parameters.AddWithValue("@fecha",idP.Value);
                   cmd.ExecuteNonQuery();

                    
                    transaction.Commit();


                }
                catch (Exception ex)
                {
                    transaction.Rollback();
                    System.Diagnostics.Debug.WriteLine("error:" + ex.ToString());
                    Console.WriteLine("error:" + ex.ToString());
                }
                finally
                {
                    con.Close();
                }

                getCalendario(sender, e);
                //ScriptManager.RegisterStartupScript(this, GetType(), "myScriptName", "cerrarLoading(); ", true);

            }


        }


    }

}