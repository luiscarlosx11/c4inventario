using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Threading;
using System.Web;
using System.Web.Services;

namespace elecion.ws
{
    /// <summary>
    /// Descripción breve de webserv
    /// </summary>
    [WebService(Namespace = "https://www.placel.com.mx/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.Web.Script.Services.ScriptService]
    [System.ComponentModel.ToolboxItem(false)]
    // Para permitir que se llame a este servicio web desde un script, usando ASP.NET AJAX, quite la marca de comentario de la línea siguiente. 
    // [System.Web.Script.Services.ScriptService]
    public class webserv : WebService
    {

        int idp;

        [WebMethod(EnableSession = true)]
        public String inicio(String usr, String plb)
        {

            string sql = "select id, nombre, usuario, tipo, email from control where '" + usr + "' = usuario and 1 = pwdcompare('" + plb + "',palabra2,0)";

            JObject o = new JObject();
            JArray array = new JArray();
            List<datos> ldatos = new List<datos>();
            List<info> linfo = new List<info>();
            var datos = new datos();
            var info = new info();


            using (SqlConnection con = new SqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {
                con.Open();

                try
                {
                    SqlCommand cmd = new SqlCommand(sql, con);
                    SqlDataReader rdr = cmd.ExecuteReader();
                    if (rdr.HasRows)
                    {
                        rdr.Read();
                        //idp = rdr.GetInt32(0);
                        datos.exito = 1;
                        datos.mensaje = "Inicio correcto.";
                        ldatos.Add(datos);
                        array = JArray.Parse(JsonConvert.SerializeObject(ldatos));
                        o["datos"] = array;

                        info.id = rdr.GetInt32(0);
                        info.usuario = rdr.GetString(2);
                        try { info.email = rdr.GetString(4); } catch { info.email = ""; }
                        linfo.Add(info);
                        array = JArray.Parse(JsonConvert.SerializeObject(linfo));
                        o["info"] = array;

                    }
                    else
                    {
                        datos.exito = 0;
                        datos.mensaje = "Usuario o contraseña incorrecto, por favor intenta de nuevo.";
                        ldatos.Add(datos);
                        array = JArray.Parse(JsonConvert.SerializeObject(ldatos));
                        o["datos"] = array;
                    }

                }
                catch (Exception ex)
                {
                    datos.exito = 0;
                    datos.mensaje = "Ocurrio un error favor de intentar de nuevo.";
                    ldatos.Add(datos);
                    array = JArray.Parse(JsonConvert.SerializeObject(ldatos));
                    o["datos"] = array;

                }

                /*
                 		$response["success"] = 0;
						$response["message"] = "Login email and Password do not match. Please try again.";
                 
                 */

                con.Close();
            }

            return o.ToString();
        }

        [WebMethod(EnableSession = true)]
        public String getListadoP(String nomp, String ent)
        {

            JObject o = new JObject();
            JArray array = new JArray();
            List<Promovidos> ldatos = new List<Promovidos>();
            List<Mantenimiento> mantenimiento = new List<Mantenimiento>();
            List<Estado> lestado = new List<Estado>();

            Promovidos promovido = new Promovidos();
            
            string sql = "Select top 25 idp,nombre,appaterno,apmaterno,COLONIA as Colonia,(calle+(case(numext) when 'S/N' then ' '+numext else (' # '+numext)end))as calle, m.municipio as Municipio, Cast(fechanac as date) as fechanac,  CASE WHEN (promovido=1) THEN 'checked' ELSE '' END as promovido, promovido as promovidoint from datos15 INNER JOIN municipios m on m.idMunicipio = datos15.MUNICIPIO and entidad =@ent WHERE  CONTAINS (NOMBRE_COMPLETO,'*"+nomp.Trim().Replace(" ", "~")+ "*') ORDER BY NOMBRE, APPATERNO, APMATERNO";
            using (SqlConnection con = new SqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {
                con.Open();
                try
                {
                    SqlCommand cmd = new SqlCommand(sql, con);
                    cmd.Parameters.AddWithValue("@nomb", nomp);
                    cmd.Parameters.AddWithValue("@ent", ent);

                    SqlDataReader rdr = cmd.ExecuteReader();
                    if (rdr.HasRows)
                    {
                        while (rdr.Read())
                        {
                            promovido = new Promovidos();
                            promovido.id = rdr.GetInt32(0);
                            promovido.nombre = rdr.GetString(1);
                            promovido.paterno = rdr.GetString(2);
                            promovido.materno = rdr.GetString(3);
                            promovido.colonia = rdr.GetString(4);
                            promovido.calle = rdr.GetString(5);
                            promovido.municipio = rdr.GetString(6);
                            promovido.estructura = "Promoción del Voto";
                            promovido.num_ext = ".";
                            promovido.num_int = ".";
                            ldatos.Add(promovido);

                        }


                        array = JArray.Parse(JsonConvert.SerializeObject(ldatos));
                        o["Promovidos"] = array;
                    }

                    Estado estado = new Estado();
                    estado.estado = "Ok";
                    lestado.Add(estado);
                    array = JArray.Parse(JsonConvert.SerializeObject(lestado));
                    o["MSJ"] = array;


                }
                catch(Exception ex) {


                    Estado estado = new Estado();
                    estado.estado = "Error";
                    lestado.Add(estado);
                    array = JArray.Parse(JsonConvert.SerializeObject(lestado));
                    o["MSJ"] = array;

                }

                con.Close();

            }

            return o.ToString();
        }

        [WebMethod(EnableSession = true)]
        public String detDetalle(String idps)
        {

            JObject o = new JObject();
            JArray array = new JArray();
            List<Promovidos> ldatos = new List<Promovidos>();
            List<Mantenimiento> mantenimiento = new List<Mantenimiento>();
            List<Estado> lestado = new List<Estado>();

            Promovidos promovido = new Promovidos();

            string sql = "Select top 25 idp,nombre,appaterno,apmaterno,COLONIA as Colonia,(calle+(case(numext) when 'S/N' then ' '+numext else (' # '+numext)end))as calle, m.municipio as Municipio, Cast(fechanac as date) as fechanac,  CASE WHEN (promovido=1) THEN 'checked' ELSE '' END as promovido, promovido as promovidoint from datos15 INNER JOIN municipios m on m.idMunicipio = datos15.MUNICIPIO and entidad =18 WHERE idP = @idp ORDER BY NOMBRE, APPATERNO, APMATERNO";
            using (SqlConnection con = new SqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {
                con.Open();
                try
                {
                    SqlCommand cmd = new SqlCommand(sql, con);
                    cmd.Parameters.AddWithValue("@idp", idps);

                    SqlDataReader rdr = cmd.ExecuteReader();
                    if (rdr.HasRows)
                    {
                        while (rdr.Read())
                        {
                            promovido = new Promovidos();
                            promovido.id = rdr.GetInt32(0);
                            promovido.nombre = rdr.GetString(1);
                            promovido.paterno = rdr.GetString(2);
                            promovido.materno = rdr.GetString(3);
                            promovido.colonia = rdr.GetString(4);
                            promovido.calle = rdr.GetString(5);
                            promovido.municipio = rdr.GetString(6);
                            promovido.estructura = "Promoción del Voto";
                            promovido.num_ext = ".";
                            promovido.num_int = ".";
                            ldatos.Add(promovido);

                        }


                        array = JArray.Parse(JsonConvert.SerializeObject(ldatos));
                        o["Promovidos"] = array;
                    }

                    Estado estado = new Estado();
                    estado.estado = "Ok";
                    lestado.Add(estado);
                    array = JArray.Parse(JsonConvert.SerializeObject(lestado));
                    o["MSJ"] = array;


                }
                catch (Exception ex)
                {


                    Estado estado = new Estado();
                    estado.estado = "Error";
                    lestado.Add(estado);
                    array = JArray.Parse(JsonConvert.SerializeObject(lestado));
                    o["MSJ"] = array;

                }

                con.Close();

            }

            return o.ToString();
        }

        [WebMethod(EnableSession = true)]
        public String grafica()
        {
            return getGraficaBarras();
        }

        [WebMethod(EnableSession = true)]
        public String graficadona()
        {
            return getGraficaDona();
        }

        private String getGraficaBarras()
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
                                   "and entidad=@entidad " +
                                   " ) as total " +
                                   " from preferencia e " +
                                   " order by e.idpreferencia";
                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@entidad", 18);
                    SqlDataReader rdr = cmd.ExecuteReader();



                    if (rdr.HasRows)
                    {
                        while (rdr.Read())
                        {
                            datosGraficaBar dt = new datosGraficaBar();
                            dt.data = new int[] { rdr.GetInt32(1) };
                            dt.label = rdr["estado"].ToString();

                            if (rdr["estado"].ToString() == "Favor")
                                dt.backgroundColor = "#16D39A";
                            else if (rdr["estado"].ToString() == "Indeciso")
                                dt.backgroundColor = "#FF7D4D";
                            else
                                dt.backgroundColor = "#FF4558";


                            dt.borderColor = "transparent";
                            arra.Add(dt);


                        }

                        datosGraficaBar[] arr3 = arra.ToArray();
                        json = JsonConvert.SerializeObject(arr3);

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

                //ScriptManager.RegisterStartupScript(this, GetType(), "datosBarra", "datosBar ={ labels: [' '], datasets: " + json + "};", true);
                return json;

            }

        }

        private String getGraficaDona()
        {

            List<datosGraficaBar> arra = new List<datosGraficaBar>();
            String json = "";
            List<int> vars = new List<int>();
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
                                   "and entidad=@entidad " +
                                   " ) as total " +
                                   " from preferencia e " +
                                   " order by e.idpreferencia";
                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@entidad", 18);
                    SqlDataReader rdr = cmd.ExecuteReader();

                   

                    if (rdr.HasRows)
                    {
                        while (rdr.Read())
                        {
                            datosGraficaBar dt = new datosGraficaBar();
                            dt.data = new int[] { rdr.GetInt32(1) };

                            vars.Add(rdr.GetInt32(1));

                            dt.label = rdr["estado"].ToString();

                            if (rdr["estado"].ToString() == "Favor")
                                dt.backgroundColor = "#16D39A";
                            else if (rdr["estado"].ToString() == "Indeciso")
                                dt.backgroundColor = "#FF7D4D";
                            else
                                dt.backgroundColor = "#FF4558";


                            dt.borderColor = "transparent";
                            arra.Add(dt);


                        }

                        
                        json = string.Join(",", vars.ToArray());
                        

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

                //ScriptManager.RegisterStartupScript(this, GetType(), "datosBarra", "datosBar ={ labels: [' '], datasets: " + json + "};", true);
                return json;

            }

        }
    }
}
