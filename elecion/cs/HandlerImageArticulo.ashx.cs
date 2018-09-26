using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace elecion.cs
{
    /// <summary>
    /// Descripción breve de HandlerImageArticulo
    /// </summary>
    public class HandlerImageArticulo : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            using (MySqlConnection con = new MySqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {



                string imageid = context.Request.QueryString["id"];

                con.Open();
                MySqlCommand command = new MySqlCommand("select foto from articulo where idarticulo=" + imageid, con);
                MySqlDataReader dr = command.ExecuteReader();
                dr.Read();
                context.Response.BinaryWrite((Byte[])dr[0]);
                con.Close();
                context.Response.End();

            }
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}