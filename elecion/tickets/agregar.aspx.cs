using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;
using System.Net.Mail;
using System.Net.Mail;
using System.Net;
using System.Threading;

namespace elecion.tickets
{
    public partial class agregar : System.Web.UI.Page
    {
        static string ide;
        private static int id;
        int idusuario;
        protected void Page_Load(object sender, EventArgs e)
        {
            var idu = (FormsIdentity)Page.User.Identity;
            var ticket = idu.Ticket;
            string[] datos = ticket.UserData.Split(',');
            string[] datos2 = datos[1].Split(';');

            idusuario = Convert.ToInt32(datos[0]);
            int idtipousuario = Convert.ToInt32(datos2[3]);

            //TECNICO
            if (idtipousuario == 4)
            {
                atiende.Enabled = false;


                cliente.Enabled = false;

                contrato.Enabled = false;

                tiposervicio.Enabled = false;

                lugarservicio.Enabled = false;

                prioridad.Enabled = false;

                concepto.Enabled = false;
                observaciones.Enabled = false;
                contacto.Enabled = false;
                contactotel.Enabled = false;
                contactomail.Enabled = false;
            }

            if (!IsPostBack)
            {

               

                //PUDatos.Focus();
                try
                {

                    id = Convert.ToInt32(Session["idP"]);


                    idP.Value = id.ToString();

                    if (id > 0)
                    {
                        recupera(id);

                    }

                    else
                        generaNuevo();

                    recuperaSeguimiento(id);


                }
                catch
                {
                    //Response.Redirect("~/estructuras/listadoEstructura.aspx");

                }

            }



        }


        private void generaNuevo()
        {
            int idticketmes = 0;
            string folio = null;

            using (MySqlConnection con = new MySqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {
                try
                {
                    con.Open();

                    
                    string sql = "select coalesce(max(IDTICKETMES),0)AS ID," +
                                 "   CONCAT " +
                                 "   (  " +
                                 "         case  " +
                                 "         when month(CURRENT_DATE) = 1 then 'EN' " +
                                 "         when month(CURRENT_DATE) = 2 then 'FB' " +
                                 "         when month(CURRENT_DATE) = 3 then 'MR' " +
                                 "         when month(CURRENT_DATE) = 4 then 'Ab' " +
                                 "         when month(CURRENT_DATE) = 5 then 'MY' " +
                                 "         when month(CURRENT_DATE) = 6 then 'JN' " +
                                 "         when month(CURRENT_DATE) = 7 then 'JL' " +
                                 "         when month(CURRENT_DATE) = 8 then 'AG' " +
                                 "         when month(CURRENT_DATE) = 9 then 'SP' " +
                                 "         when month(CURRENT_DATE) = 10 then 'OC' " +
                                 "         when month(CURRENT_DATE) = 11 then 'NV' " +
                                 "         when month(CURRENT_DATE) = 12 then 'DI' " +
                                 "         end " +
                                 "       , " +
                                 "       Substring(EXTRACT(YEAR FROM CURRENT_DATE), 3) " +
                                 "   )AS CADENA " +
                                 "   from ticket";

                    MySqlCommand cmd = new MySqlCommand(sql, con);
                    
                    MySqlDataReader rdr = cmd.ExecuteReader();
                    if (rdr.HasRows)
                    {
                        rdr.Read();
                        idticketmes = Convert.ToInt32(rdr["id"].ToString())+1;
                        folio = "IPS" + idticketmes + rdr["cadena"].ToString();

                    }

                    rdr.Close();

                    sql = "insert into ticket(fecha, hora, recibe, idprioridad, estatus, idticketmes, folio) values(current_date, current_time, @recibe, 3, 'ACTIVO', @idticketmes, @folio);";

                     cmd = new MySqlCommand(sql, con);
                    cmd.Parameters.AddWithValue("@recibe", idusuario);
                    cmd.Parameters.AddWithValue("@idticketmes", idticketmes);
                    cmd.Parameters.AddWithValue("@folio", folio);
                    cmd.ExecuteNonQuery();

                    int idticket = (int)cmd.LastInsertedId;

                    idP.Value = idticket.ToString();
                    lticket.Text = "TCK # " + folio;

                    id = Convert.ToInt32(idticket.ToString());

                    //SE RECUPERA LA FECHA Y HORA DEL TICKET
                    using (MySqlConnection con2 = new MySqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
                    {
                        try
                        {
                            con2.Open();
                            string sql2 = "SELECT cast(fecha as char)as fecha, hora from ticket where idticket=@idP";
                            MySqlCommand cmd2 = new MySqlCommand(sql2, con2);
                            cmd2.Parameters.AddWithValue("@idP", idticket);

                            rdr = cmd2.ExecuteReader();
                            if (rdr.HasRows)
                            {
                                rdr.Read();
                                lfechahora.Text = rdr["fecha"].ToString() + " a las " + rdr["hora"].ToString() + " hrs.";

                            }


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
                catch (Exception ex)
                {

                    System.Diagnostics.Debug.WriteLine("ERROR:" + ex.Message.Replace("\r\n", ""));
                }
                finally
                {
                    con.Close();
                }
            }
        }

        private void recupera(int id)
        {
            using (MySqlConnection con = new MySqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {
                try
                {
                    con.Open();
                    string sql = "SELECT t.idticket, t.atiende, t.idcliente, t.idcontrato, t.idprioridad, t.folio, " +
                                "cast(t.fecha as char)as fecha, t.hora, cast(t.fechacierre as char)as fechacierre, t.horacierre, cast(t.fechaatiende as char)as fechaatiende, t.horaatiende," +
                                "t.concepto, t.observaciones, t.contacto, t.contactomail, t.contactotel, t.idtiposervicio, t.idlugarservicio, c.terminacion, t.idcalificacion, t.idcalificacion_tec " +
                                "from ticket t left join terminacion c on t.idterminacion = c.idterminacion  where t.idticket=@idP";
                    MySqlCommand cmd = new MySqlCommand(sql, con);
                    cmd.Parameters.AddWithValue("@idP", id);

                    MySqlDataReader rdr = cmd.ExecuteReader();
                    if (rdr.HasRows)
                    {
                        rdr.Read();
                        lticket.Text = "TCK # " + rdr["folio"].ToString();
                        lfechahora.Text = rdr["fecha"].ToString() + " a las " + rdr["hora"].ToString() + " hrs.";
                        latencion.Text = "NO REGISTRADO";

                        if (!rdr["fechaatiende"].ToString().Equals(""))
                        {
                            seguir.Visible = false;
                            latencion.Text = rdr["fechaatiende"].ToString() + " a las " + rdr["horaatiende"].ToString() + " hrs.";
                        }

                        if (!rdr.IsDBNull(rdr.GetOrdinal("atiende")))
                        {
                            atiende.SelectedValue = rdr["atiende"].ToString();
                            atiendeant.Value = rdr["atiende"].ToString(); 
                        }
                            

                        if (!rdr.IsDBNull(rdr.GetOrdinal("idcliente")))
                            cliente.SelectedValue = rdr["idcliente"].ToString();

                        if (!rdr.IsDBNull(rdr.GetOrdinal("idcontrato")))
                            contrato.SelectedValue = rdr["idcontrato"].ToString();

                        if (!rdr.IsDBNull(rdr.GetOrdinal("idtiposervicio")))
                            tiposervicio.SelectedValue = rdr["idtiposervicio"].ToString();

                        if (!rdr.IsDBNull(rdr.GetOrdinal("idlugarservicio")))
                            lugarservicio.SelectedValue = rdr["idlugarservicio"].ToString();

                        prioridad.SelectedValue = rdr["idprioridad"].ToString();

                        concepto.Text = rdr["concepto"].ToString();
                        observaciones.Text = rdr["observaciones"].ToString();
                        contacto.Text = rdr["contacto"].ToString();
                        contactotel.Text = rdr["contactotel"].ToString();
                        contactomail.Text = rdr["contactomail"].ToString();


                    }


                }
                catch (Exception ex)
                {
                    System.Diagnostics.Debug.WriteLine("ERROR:" + ex.Message.Replace("\r\n", ""));
                }
                finally
                {
                    con.Close();
                }
            }
        }

        protected void actualizar(object sender, EventArgs e)
        {
            using (MySqlConnection con = new MySqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {


                try
                {
                    con.Open();
                    String query = "";
                    query = "update ticket set atiende=@atiende, idcliente=@cliente, idcontrato=@contrato, concepto=@concepto, idprioridad=@prioridad, " +
                            "observaciones=@observaciones, contacto=@contacto, contactotel= @contactotel, contactomail = @contactomail, " +
                            "idtiposervicio= @idtiposervicio, idlugarservicio=@idlugarservicio " +
                            "where idticket=@idP";


                    MySqlCommand cmd = new MySqlCommand(query, con);


                    if (Int32.Parse(idP.Value) > 0)
                        cmd.Parameters.AddWithValue("@idp", idP.Value);

                    if (atiende.SelectedValue != "")
                        cmd.Parameters.AddWithValue("@atiende", atiende.SelectedValue);

                    cmd.Parameters.AddWithValue("@cliente", cliente.SelectedValue);

                    if (contrato.SelectedValue != "")
                        cmd.Parameters.AddWithValue("@contrato", contrato.SelectedValue);
                    else
                        cmd.Parameters.AddWithValue("@contrato", null);

                    cmd.Parameters.AddWithValue("@concepto", concepto.Text);
                    cmd.Parameters.AddWithValue("@prioridad", prioridad.SelectedValue);

                    cmd.Parameters.AddWithValue("@idtiposervicio", tiposervicio.SelectedValue);
                    cmd.Parameters.AddWithValue("@idlugarservicio", lugarservicio.SelectedValue);

                    cmd.Parameters.AddWithValue("@observaciones", observaciones.Text);
                    cmd.Parameters.AddWithValue("@contacto", contacto.Text);
                    cmd.Parameters.AddWithValue("@contactotel", contactotel.Text);
                    cmd.Parameters.AddWithValue("@contactomail", contactomail.Text);

                    cmd.ExecuteNonQuery();
                                       

                }
                catch (Exception ex)
                {

                    ScriptManager.RegisterStartupScript(this, GetType(), "abrirModal", "window.onload = function(){ swaError('" + ex.Message.Replace("\r\n", "").Replace("'", "") + "'); };", true);

                }
                finally
                {
                    con.Close();
                }


            }
        }


        protected void actualizarAtiende(object sender, EventArgs e)
        {
            using (MySqlConnection con = new MySqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {


                try
                {
                    con.Open();
                    String query = "";
                    query = "update ticket set atiende=@atiende, idcliente=@cliente, idcontrato=@contrato, concepto=@concepto, idprioridad=@prioridad, " +
                            "observaciones=@observaciones, contacto=@contacto, contactotel= @contactotel, contactomail = @contactomail, " +
                            "idtiposervicio= @idtiposervicio, idlugarservicio=@idlugarservicio " +
                            "where idticket=@idP";


                    MySqlCommand cmd = new MySqlCommand(query, con);


                    if (Int32.Parse(idP.Value) > 0)
                        cmd.Parameters.AddWithValue("@idp", idP.Value);

                    if (atiende.SelectedValue != "")
                        cmd.Parameters.AddWithValue("@atiende", atiende.SelectedValue);

                    cmd.Parameters.AddWithValue("@cliente", cliente.SelectedValue);

                    if (contrato.SelectedValue != "")
                        cmd.Parameters.AddWithValue("@contrato", contrato.SelectedValue);
                    else
                        cmd.Parameters.AddWithValue("@contrato", null);

                    cmd.Parameters.AddWithValue("@concepto", concepto.Text);
                    cmd.Parameters.AddWithValue("@prioridad", prioridad.SelectedValue);

                    cmd.Parameters.AddWithValue("@idtiposervicio", tiposervicio.SelectedValue);
                    cmd.Parameters.AddWithValue("@idlugarservicio", lugarservicio.SelectedValue);

                    cmd.Parameters.AddWithValue("@observaciones", observaciones.Text);
                    cmd.Parameters.AddWithValue("@contacto", contacto.Text);
                    cmd.Parameters.AddWithValue("@contactotel", contactotel.Text);
                    cmd.Parameters.AddWithValue("@contactomail", contactomail.Text);

                    cmd.ExecuteNonQuery();

                    if (atiende.SelectedValue != "" && atiendeant.Value != atiende.SelectedValue)
                        procesoEnvio(Convert.ToInt32(atiende.SelectedValue), lticket.Text, concepto.Text);

                    atiendeant.Value = atiende.SelectedValue;
                }
                catch (Exception ex)
                {

                    ScriptManager.RegisterStartupScript(this, GetType(), "abrirModal", "window.onload = function(){ swaError('" + ex.Message.Replace("\r\n", "").Replace("'", "") + "'); };", true);

                }
                finally
                {
                    con.Close();
                }


            }
        }

        public void procesoEnvio(int idusuario, string ticket, string concepto)
        {
            string correo="";

            using (MySqlConnection con = new MySqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {
                try
                {
                    con.Open();
                    string sql = "SELECT email "+
                                "from usuario where idusuario=@idP";
                    MySqlCommand cmd = new MySqlCommand(sql, con);
                    cmd.Parameters.AddWithValue("@idP", idusuario);

                    MySqlDataReader rdr = cmd.ExecuteReader();
                    if (rdr.HasRows)
                    {
                        rdr.Read();                        
                        correo = rdr["email"].ToString();
                    }
                    enviarMail(correo, ticket, concepto);

                }
                catch (Exception ex)
                {
                    System.Diagnostics.Debug.WriteLine("ERROR:" + ex.Message.Replace("\r\n", ""));
                }
                finally
                {
                    con.Close();
                }
            }

        }

        protected void finalizar(object sender, EventArgs e)
        {
            using (MySqlConnection con = new MySqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {


                try
                {
                    con.Open();
                    String query = "";
                    query = "update ticket set estatus='CERRADO', idcalificacion=@calificacion, idcalificacion_tec= @calificaciontec, FECHACIERRE=current_date, HORACIERRE=current_time, idterminacion=@idterminacion  " +
                            "where idticket=@idP";

                    MySqlCommand cmd = new MySqlCommand(query, con);


                    cmd.Parameters.AddWithValue("@idp", idP.Value);
                    cmd.Parameters.AddWithValue("@calificacion", nestrellas.Value);
                    cmd.Parameters.AddWithValue("@calificaciontec", nestrellas_tecnicas.Value);
                    cmd.Parameters.AddWithValue("@idterminacion", terminacion.SelectedValue);

                    cmd.ExecuteNonQuery();

                    regresarListado(sender, e);

                }
                catch (Exception ex)
                {

                    ScriptManager.RegisterStartupScript(this, GetType(), "abrirModal", "window.onload = function(){ swaError('" + ex.Message.Replace("\r\n", "").Replace("'", "") + "'); };", true);

                }
                finally
                {
                    con.Close();
                }


            }
        }


        protected void iniciarSeguimiento(object sender, EventArgs e)
        {
            using (MySqlConnection con = new MySqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {


                try
                {
                    con.Open();
                    String query = "";
                    query = "update ticket set FECHAATIENDE=current_date, HORAATIENDE=current_time  " +
                            "where idticket=@idP";

                    MySqlCommand cmd = new MySqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@idp", idP.Value);
                    
                    cmd.ExecuteNonQuery();
                    recupera(id);

                    //regresarListado(sender, e);

                }
                catch (Exception ex)
                {

                    ScriptManager.RegisterStartupScript(this, GetType(), "abrirModal", "window.onload = function(){ swaError('" + ex.Message.Replace("\r\n", "").Replace("'", "") + "'); };", true);

                }
                finally
                {
                    con.Close();
                }


            }
        }

        protected void generaSeguimiento(object sender, EventArgs e)
        {
            using (MySqlConnection con = new MySqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {
                try
                {
                    con.Open();
                    string sql = "insert into seguimiento(idticket, idusuario, fecha, hora, comentario) values(@idticket, @idusuario, current_date, current_time, @comentario);";
                    MySqlCommand cmd = new MySqlCommand(sql, con);
                    cmd.Parameters.AddWithValue("@idticket", id);
                    cmd.Parameters.AddWithValue("@idusuario", idusuario);
                    cmd.Parameters.AddWithValue("@comentario", nota.Text);

                    cmd.ExecuteNonQuery();
                    recuperaSeguimiento(id);


                }
                catch (Exception ex)
                {

                    ScriptManager.RegisterStartupScript(this, GetType(), "abrirModal", "window.onload = function(){ swaError('" + ex.Message.Replace("\r\n", "").Replace("'", "") + "'); };", true);
                }
                finally
                {
                    con.Close();
                }
            }
        }

        private void recuperaSeguimiento(int id)
        {

            //repSeguimiento.DataSourceID = DSSeguimiento.ID;


            DSSeguimiento.SelectCommand = "SELECT s.IDSEGUIMIENTO, cast(s.FECHA as char)AS FECHA, cast(s.HORA as char)AS HORA, " +
                                           " s.COMENTARIO ,(CONCAT(COALESCE(u.nombre, ''), ' ', COALESCE(u.apaterno, ''), ' ', COALESCE(u.amaterno, ''))) as nombre " +
                                           " FROM seguimiento s " +
                                           " left join usuario u on u.IDUSUARIO = s.IDUSUARIO " +
                                           " WHERE s.IDTICKET = " + id + "";
            //DSSeguimiento.DataBind();
            //repSeguimiento.DataBind();

            ScriptManager.RegisterClientScriptBlock(Page, typeof(string), "myScriptName", "cerrarLoading();", true);
            //gridSeguimiento.DataBind();


        }

        protected void clientes_DataBound(object sender, EventArgs e)
        {

            // Dscontratos.DataBind();
            //contrato.DataBind();

        }


        protected void regresarListado(object sender, EventArgs e)
        {

           /* SmtpClient smtp = new SmtpClient("smtp.gmail.com", 587);
            smtp.EnableSsl = true;
            smtp.DeliveryMethod = SmtpDeliveryMethod.Network;

            smtp.UseDefaultCredentials = false;
            smtp.Credentials = new NetworkCredential("luiscarlosx10@gmail.com", "donitapuff2015");

            MailMessage email = new MailMessage();

            email.From = new MailAddress("luiscarlosx10@gmail.com");
            email.To.Add("luis.santiago@infix.com.mx");
            email.Subject =  lticket.Text +" - "+concepto.Text+" le ha sido asignado";
            email.Body = observaciones.Text;
            string output = null;

            Thread t1 = new Thread(delegate ()
            {
                  try
                   {
                        smtp.Send(email);                    
                        email.Dispose();
                        output = "Correo electrónico fue enviado satisfactoriamente.";
                    }catch (Exception ex)
                    {
                        output = "Error enviando correo electrónico: " + ex.Message;
                    }

                    Console.WriteLine(output);
            });
            t1.Start();*/

            Response.Redirect("~/tickets/listado.aspx");
        }

        public void enviarMail(string destinatario, string ticket, string concepto)
        {

            SmtpClient smtp = new SmtpClient("smtpout.asia.secureserver.net", 80);
            smtp.EnableSsl = false;
            smtp.DeliveryMethod = SmtpDeliveryMethod.Network;

            smtp.UseDefaultCredentials = false;
            smtp.Credentials = new NetworkCredential("soporte@ipsec.mx", "Am90123k%r");

            MailMessage email = new MailMessage();

            email.From = new MailAddress("soporte@ipsec.mx");
            email.To.Add(destinatario);
            email.Subject = "Nuevo Ticket Soporte Ipsec";
            email.Body = "Le ha sido asignado un ticket de servicio para su seguimiento <br><br> " +
                        "<b>Folio </b> " + ticket + "<br> " +
                        "<b>Concepto</b> " + concepto + "<br><br>" +
                        "";
            email.IsBodyHtml = true;

            string output = null;

            Thread t1 = new Thread(delegate ()
            {
                try
                {
                    smtp.Send(email);
                    email.Dispose();
                    output = "Correo electrónico fue enviado satisfactoriamente.";
                }
                catch (Exception ex)
                {
                    output = "Error enviando correo electrónico: " + ex.Message;
                }

                Console.WriteLine(output);
            });
            t1.Start();

        }


    }
}