using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace elecion
{
    public partial class _default : System.Web.UI.Page
    {
        int idusuario = 0;
        int idtipousuario = 0;
        protected void Page_Load(object sender, EventArgs e)
        {

            var id = (FormsIdentity)Page.User.Identity;
            var ticket = id.Ticket;
            string[] datos = ticket.UserData.Split(',');
            string[] datos2 = datos[1].Split(';');
            
            idusuario = Convert.ToInt32(datos[0]);
            idtipousuario = Convert.ToInt32(datos2[3]);

            using (MySqlConnection con = new MySqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {
                try
                {
                    con.Open();
                    string query = "SELECT u.IDUSUARIO, (CONCAT(COALESCE(u.nombre, ''), ' ', COALESCE(u.apaterno, ''), ' ', COALESCE(u.amaterno, ''))) as nombre, a.area, u.login, u.telefono, u.email " +
                                    "from usuario u " +
                                    "left join area a on a.IDAREA = u.IDAREA " +
                                    "where u.idusuario = " + idusuario + " "; 

                    // "where month(t2.FECHA) = month(CURRENT_DATE)";
                    MySqlCommand cmd = new MySqlCommand(query, con);

                    MySqlDataReader rdr = cmd.ExecuteReader();
                    if (rdr.HasRows)
                    {
                        //rdr.Read();
                        //valor = rdr.GetInt32(1);
                        while (rdr.Read())
                        {

                            nombre.Text = rdr["nombre"].ToString();
                            apellidos.Text = rdr["area"].ToString();

                            login.Text = rdr["login"].ToString();
                            telefono.Text = rdr["telefono"].ToString();
                            email.Text = rdr["email"].ToString();

                            user.Text = rdr["login"].ToString();
                            telefono2.Text = rdr["telefono"].ToString();
                            email2.Text = rdr["email"].ToString(); 
                        }

                    }
                    rdr.Close();

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

            totales();         

        }


        protected void guardaEdita(object sender, EventArgs e)
        {

            /*if (!pass.Equals("") && !psswd.Text.Equals(""))
            {
                string key = Request.Cookies["SessionCookie"].Value;
                Response.Cookies["SessionCookie"].Expires = DateTime.Now.AddDays(-1);
                byte[] llave = Convert.FromBase64String(key);
                byte[] dc = Convert.FromBase64String(pass);

                string iv = Request.Cookies["IV"].Value;
                Response.Cookies["IV"].Expires = DateTime.Now.AddDays(-1);
                byte[] InitializationVector = Convert.FromBase64String(iv);
                //byte[] InitializationVector = GetBytes(iv);

                String kp = "8SCvR5DB8b2wEOSpA+4U7du97FroxZ6J9XV0C1NRybM=";
                byte[] llavep = Convert.FromBase64String(kp);
                String ivp = "AZsuprHgsLi/KmaUpA5+zA==";
                byte[] ivpp = Convert.FromBase64String(ivp);
                String dp = DecryptStringFromBytes_Aes(dc, llave, InitializationVector);
                byte[] encryptedMessage = EncryptStringToBytes_Aes(dp, llavep, ivpp);
                hs = Convert.ToBase64String(encryptedMessage);
            }*/

            using (MySqlConnection con = new MySqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {
                try
                {
                    con.Open();

                    String query = "UPDATE usuario set email=@email, telefono=@telefono, pass=@pass WHERE idusuario = @idu ";
                    

                    MySqlCommand cmd = new MySqlCommand(query, con);
                   

                    cmd.Parameters.AddWithValue("@idu", idusuario);
                    
                    cmd.Parameters.AddWithValue("@email", email2.Text);
                    cmd.Parameters.AddWithValue("@telefono", telefono2.Text);                    
                    cmd.Parameters.AddWithValue("@pass", pass2.Text);

                    cmd.ExecuteNonQuery();

                }
                catch (Exception ex)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "cerrarMod", "window.onload = function(){ swal('Correcto', 'Credenciales actualizadas con éxito.', 'success');}", true);
                }
                finally
                {
                    con.Close();
                }


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
                                "SELECT coalesce(count(t.IDTICKET),0) " +
                                "from ticket t " +
                                "where t.estatus = 'CERRADO' ";

                    if (idtipousuario == 4)
                        sql = sql + " AND T.ATIENDE=" + idusuario;

                    sql = sql + ")AS ATENDIDOS, " +
                                "( " +
                                "SELECT coalesce(count(t.IDTICKET),0) " +
                                "from ticket t " +
                                "where t.estatus = 'ACTIVO' ";

                    if (idtipousuario == 4)
                        sql = sql + " AND T.ATIENDE=" + idusuario;

                    sql = sql + ")AS ACTIVOS, " +
                                "( " +
                                "SELECT coalesce(count(t.IDTICKET),0) " +
                                "from ticket t " +
                                "where t.idterminacion = 2 ";

                    if (idtipousuario == 4)
                        sql = sql + " AND T.ATIENDE=" + idusuario;

                    sql = sql + ")AS CANCELADOS, " +
                                "( " +
                                "SELECT coalesce(count(t.IDTICKET),0) " +
                                "from seguimiento t left join ticket t2 on t.idticket = t2.idticket ";

                    if (idtipousuario == 4)
                        sql = sql + " where T2.ATIENDE=" + idusuario;

                    sql = sql + ")AS NOTAS " +

                                "FROM ticket " +
                                "limit 0,1 ";
                    MySqlCommand cmd = new MySqlCommand(sql, con);
                    MySqlDataReader rdr = cmd.ExecuteReader();
                    if (rdr.HasRows)
                    {
                        rdr.Read();

                        atendidos.Text = rdr["atendidos"].ToString();
                        activos.Text = rdr["activos"].ToString();
                        cancelados.Text = rdr["cancelados"].ToString();
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