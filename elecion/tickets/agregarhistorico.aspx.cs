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
    public partial class agregarhistorico : System.Web.UI.Page
    {
        static string ide;
        private static int id;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

                /*var id = (FormsIdentity)User.Identity;
                var ticket = id.Ticket;
                string[] datos = ticket.UserData.Split(',');
                try
                {
                    HttpContext CurrContext = HttpContext.Current;
                    ide = CurrContext.Items["ide"].ToString();
                    divestructura.Visible = false;
                }
                catch
                {
                    ide = "0";
                    divestructura.Visible = true;
                    Response.Redirect("estructuras.aspx");
                }*/

                //String idProm = "";

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
            using (MySqlConnection con = new MySqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {
                try
                {
                    con.Open();
                    string sql = "insert into ticket(fecha, hora, recibe, idprioridad, estatus) values(current_date, current_time, @recibe, 3, 'ACTIVO');";

                    MySqlCommand cmd = new MySqlCommand(sql, con);
                    cmd.Parameters.AddWithValue("@recibe", Session["idusuario"]);
                    cmd.ExecuteNonQuery();

                    int idticket = (int)cmd.LastInsertedId;

                    idP.Value = idticket.ToString();
                    lticket.Text = "TCK # " + idticket;

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

                            MySqlDataReader rdr = cmd2.ExecuteReader();
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
                    string sql = "SELECT t.idticket, t.atiende, t.idcliente, t.idcontrato, t.idprioridad, t.folio, "+
                                 "cast(t.fecha as char)as fecha, t.hora, cast(t.fechacierre as char)as fechacierre, t.horacierre, cast(t.fechaatiende as char)as fechaatiende, t.horaatiende," +
                                 "t.concepto, t.observaciones, t.contacto, t.contactomail, t.contactotel, t.idtiposervicio, t.idlugarservicio, c.terminacion, t.idcalificacion, t.idcalificacion_tec "+
                                 "from ticket t left join terminacion c on t.idterminacion = c.idterminacion  where t.idticket=@idP";
                    MySqlCommand cmd = new MySqlCommand(sql, con);
                    cmd.Parameters.AddWithValue("@idP", id);

                    MySqlDataReader rdr = cmd.ExecuteReader();
                    if (rdr.HasRows)
                    {
                        rdr.Read();
                        lticket.Text = "TCK # " + rdr["folio"].ToString();
                        lfechahora.Text = rdr["fecha"].ToString() + " a las " + rdr["hora"].ToString() + " hrs.";
                        lfechahoracierre.Text = "";
                        latencion.Text = "";
                        lterminacion.Text = rdr["terminacion"].ToString();
                        ninteres.Value = rdr["idcalificacion"].ToString();
                        ninterestec.Value = rdr["idcalificacion_tec"].ToString();


                        if (!rdr["fechaatiende"].ToString().Equals(""))
                        {                            
                            latencion.Text = rdr["fechaatiende"].ToString() + " a las " + rdr["horaatiende"].ToString() + " hrs.";
                        }

                        if (!rdr["fechacierre"].ToString().Equals(""))
                        {
                            lfechahoracierre.Text = rdr["fechacierre"].ToString() + " a las " + rdr["horacierre"].ToString() + " hrs.";
                        }

                        if (!rdr.IsDBNull(rdr.GetOrdinal("atiende")))
                            atiende.SelectedValue = rdr["atiende"].ToString();

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

        protected void finalizar(object sender, EventArgs e)
        {
            using (MySqlConnection con = new MySqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {


                try
                {
                    con.Open();
                    String query = "";
                    query = "update ticket set estatus='CERRADO', idcalificacion=@calificacion, FECHACIERRE=current_date, HORACIERRE=current_time  " +
                            "where idticket=@idP";

                    MySqlCommand cmd = new MySqlCommand(query, con);


                    cmd.Parameters.AddWithValue("@idp", idP.Value);
                    cmd.Parameters.AddWithValue("@calificacion", nestrellas.Value);

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
                    cmd.Parameters.AddWithValue("@idusuario", Convert.ToInt32(Session["idusuario"]));
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


            DSSeguimiento.SelectCommand = "SELECT s.IDSEGUIMIENTO, cast(s.FECHA as char)AS FECHA, cast(s.HORA as char)AS HORA, "+
                                           " s.COMENTARIO ,(CONCAT(COALESCE(u.nombre, ''), ' ', COALESCE(u.apaterno, ''), ' ', COALESCE(u.amaterno, ''))) as nombre " +
                                           " FROM seguimiento s " +
                                           " left join usuario u on u.IDUSUARIO = s.IDUSUARIO " +
                                           " WHERE s.IDTICKET = " +id+"";
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

            Response.Redirect("~/tickets/listadohistorico.aspx");
        }

       
    }
}