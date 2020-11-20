using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.SessionState;

namespace elecion.cs
{
    /// <summary>
    /// Descripción breve de KeepSession
    /// </summary>
    public class SessionHeartbeat : IHttpHandler, IRequiresSessionState
    {
        public bool IsReusable { get { return false; } }

        public void ProcessRequest(HttpContext context)
        {
            context.Session["Heartbeat"] = DateTime.Now;

            using (MySqlConnection con2 = new MySqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {
                try
                {
                    con2.Open();
                    string query = "select 1 ";

                    MySqlCommand cmd2 = new MySqlCommand(query, con2);

                    MySqlDataReader rdr = cmd2.ExecuteReader();
                    rdr.Close();

                }
                catch (Exception ex)
                {
                    System.Diagnostics.Debug.WriteLine("ERROR:" + ex.Message.Replace("\r\n", ""));
                }
                finally
                {
                    con2.Close();
                }
            }
        }
    }
}