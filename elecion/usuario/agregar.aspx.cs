using System;
using System.Collections.Generic;

using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using MySql.Data.MySqlClient;
using System.Net.Mail;
using System.Net.Mail;
using System.Net;
using System.Threading;

namespace elecion.usuarios
{
    public partial class agregar : System.Web.UI.Page
    {
        private static int idUsuario;

        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                String idProm = "";

                try
                {
                    idProm = Session["idP"].ToString();
                    idUsuario = Convert.ToInt32(idProm);

                    if(idUsuario>0)
                        getUsuario(idUsuario);
                    //Session.Remove("idP");
                    //ScriptManager.RegisterStartupScript(this, GetType(), "abrirModal", "window.onload = function(){ $(document).prop('title', 'PLACEL - Editar Usuario'); };", true);
                }
                catch
                {
                   
                }

                
            }
           
        }

        private void getUsuario(int idUser)
        {
            using (MySqlConnection con = new MySqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {
                try
                {
                    con.Open();
                    string sql = "SELECT IDUSUARIO, IDTIPOUSUARIO, IDSUCURSAL, NOMBRE, APATERNO, AMATERNO, ACTIVO, EMAIL, TELEFONO, LOGIN, PASS from usuario where idusuario=@idP";
                   
                    MySqlCommand cmd = new MySqlCommand(sql, con);
                    cmd.Parameters.AddWithValue("@idP", idUser);
                    MySqlDataReader rdr = cmd.ExecuteReader();
                    if (rdr.HasRows)
                    {
                        rdr.Read();
                        idP.Value = rdr["idusuario"].ToString();
                        usuario.Text = rdr["login"].ToString();
                        pass.Text = rdr["pass"].ToString();

                        nombre.Text = rdr["nombre"].ToString();
                        apaterno.Text = rdr["apaterno"].ToString();
                        amaterno.Text = rdr["amaterno"].ToString();

                        email.Text = rdr["email"].ToString();
                        telefono.Text = rdr["telefono"].ToString();

                        tipo.SelectedValue = rdr["idtipousuario"].ToString();
                        area.SelectedValue = rdr["idsucursal"].ToString();


                        if (rdr["activo"].ToString()=="1") 
                          activo.Checked = true;
                        
                    }
                   
                    area.Enabled = false;
                    

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

        protected void volverListado(object sender, EventArgs e)
        {
            Response.Redirect("~/usuario/control.aspx");
            //Response.RedirectToRoute("Usuarios");
        }

        
        public static string RemoveAccentsWithRegEx(string inputString)
        {
            System.Text.RegularExpressions.Regex replace_a_Accents = new System.Text.RegularExpressions.Regex("[á|à|ä|â]", System.Text.RegularExpressions.RegexOptions.Compiled);
            System.Text.RegularExpressions.Regex replace_e_Accents = new System.Text.RegularExpressions.Regex("[é|è|ë|ê]", System.Text.RegularExpressions.RegexOptions.Compiled);
            System.Text.RegularExpressions.Regex replace_i_Accents = new System.Text.RegularExpressions.Regex("[í|ì|ï|î]", System.Text.RegularExpressions.RegexOptions.Compiled);
            System.Text.RegularExpressions.Regex replace_o_Accents = new System.Text.RegularExpressions.Regex("[ó|ò|ö|ô]", System.Text.RegularExpressions.RegexOptions.Compiled);
            System.Text.RegularExpressions.Regex replace_u_Accents = new System.Text.RegularExpressions.Regex("[ú|ù|ü|û]", System.Text.RegularExpressions.RegexOptions.Compiled);
            inputString = replace_a_Accents.Replace(inputString, "a");
            inputString = replace_e_Accents.Replace(inputString, "e");
            inputString = replace_i_Accents.Replace(inputString, "i");
            inputString = replace_o_Accents.Replace(inputString, "o");
            inputString = replace_u_Accents.Replace(inputString, "u");
            return inputString;
        }

        static byte[] EncryptStringToBytes_Aes(string plainText, byte[] Key, byte[] IV)
        {
            // Check arguments.
            if (plainText == null || plainText.Length <= 0)
                throw new ArgumentNullException("plainText");
            if (Key == null || Key.Length <= 0)
                throw new ArgumentNullException("Key");
            if (IV == null || IV.Length <= 0)
                throw new ArgumentNullException("Key");
            byte[] encrypted;
            // Create an Aes object
            // with the specified key and IV.
            using (System.Security.Cryptography.Aes aesAlg = System.Security.Cryptography.Aes.Create())
            {
                aesAlg.Key = Key;
                aesAlg.IV = IV;

                // Create a decrytor to perform the stream transform.
                System.Security.Cryptography.ICryptoTransform encryptor = aesAlg.CreateEncryptor(aesAlg.Key, aesAlg.IV);

                // Create the streams used for encryption.
                using (System.IO.MemoryStream msEncrypt = new System.IO.MemoryStream())
                {
                    using (System.Security.Cryptography.CryptoStream csEncrypt = new System.Security.Cryptography.CryptoStream(msEncrypt, encryptor, System.Security.Cryptography.CryptoStreamMode.Write))
                    {
                        using (System.IO.StreamWriter swEncrypt = new System.IO.StreamWriter(csEncrypt))
                        {

                            //Write all data to the stream.
                            swEncrypt.Write(plainText);
                        }
                        encrypted = msEncrypt.ToArray();
                    }
                }
            }


            // Return the encrypted bytes from the memory stream.
            return encrypted;

        }

        static string DecryptStringFromBytes_Aes(byte[] cipherText, byte[] Key, byte[] IV)
        {
            // Check arguments.
            if (cipherText == null || cipherText.Length <= 0)
                throw new ArgumentNullException("cipherText");
            if (Key == null || Key.Length <= 0)
                throw new ArgumentNullException("Key");
            if (IV == null || IV.Length <= 0)
                throw new ArgumentNullException("Key");

            // Declare the string used to hold
            // the decrypted text.
            string plaintext = null;

            // Create an Aes object
            // with the specified key and IV.
            using (System.Security.Cryptography.Aes aesAlg = System.Security.Cryptography.Aes.Create())
            {
                aesAlg.Key = Key;
                aesAlg.IV = IV;

                // Create a decrytor to perform the stream transform.
                System.Security.Cryptography.ICryptoTransform decryptor = aesAlg.CreateDecryptor(aesAlg.Key, aesAlg.IV);

                // Create the streams used for decryption.
                using (System.IO.MemoryStream msDecrypt = new System.IO.MemoryStream(cipherText))
                {
                    using (System.Security.Cryptography.CryptoStream csDecrypt = new System.Security.Cryptography.CryptoStream(msDecrypt, decryptor, System.Security.Cryptography.CryptoStreamMode.Read))
                    {
                        using (System.IO.StreamReader srDecrypt = new System.IO.StreamReader(csDecrypt))
                        {

                            // Read the decrypted bytes from the decrypting stream and place them in a string.
                            plaintext = srDecrypt.ReadToEnd();
                        }
                    }
                }

            }

            return plaintext;

        }

        private class PasswordHash
        {
            // The following constants may be changed without breaking existing hashes.
            public const int SALT_BYTE_SIZE = 24;
            public const int HASH_BYTE_SIZE = 24;
            public const int PBKDF2_ITERATIONS = 1000;

            public const int ITERATION_INDEX = 0;
            public const int SALT_INDEX = 1;
            public const int PBKDF2_INDEX = 2;

            /// <summary>
            /// Creates a salted PBKDF2 hash of the password.
            /// </summary>
            /// <param name="password">The password to hash.</param>
            /// <returns>The hash of the password.</returns>
            

            /// <summary>
            /// Compares two byte arrays in length-constant time. This comparison
            /// method is used so that password hashes cannot be extracted from
            /// on-line systems using a timing attack and then attacked off-line.
            /// </summary>
            /// <param name="a">The first byte array.</param>
            /// <param name="b">The second byte array.</param>
            /// <returns>True if both byte arrays are equal. False otherwise.</returns>
            private static bool SlowEquals(byte[] a, byte[] b)
            {
                uint diff = (uint)a.Length ^ (uint)b.Length;
                for (int i = 0; i < a.Length && i < b.Length; i++)
                    diff |= (uint)(a[i] ^ b[i]);
                return diff == 0;
            }

            /// <summary>
            /// Computes the PBKDF2-SHA1 hash of a password.
            /// </summary>
            /// <param name="password">The password to hash.</param>
            /// <param name="salt">The salt.</param>
            /// <param name="iterations">The PBKDF2 iteration count.</param>
            /// <param name="outputBytes">The length of the hash to generate, in bytes.</param>
            /// <returns>A hash of the password.</returns>
            /*private static byte[] PBKDF2(string password, byte[] salt, int iterations, int outputBytes)
            {
                System.Security.Cryptography.Rfc2898DeriveBytes pbkdf2 = new System.Security.Cryptography.Rfc2898DeriveBytes(password, salt);
                pbkdf2.IterationCount = iterations;
                returnpbkdf2.GetBytes(outputBytes);
            }*/
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

                    String query = "";

                    if (idUsuario==0)
                    {
                        string consulta="select coalesce(max(idusuario),0) from usuario where idsucursal="+area.SelectedValue+";";
                        MySqlCommand cmdu = new MySqlCommand(consulta, con);
                        idUsuario = Convert.ToInt32(cmdu.ExecuteScalar()) + 1;


                        query = "INSERT INTO usuario(idusuario, idtipousuario, idsucursal, nombre, apaterno, amaterno, activo,  email, telefono, login, pass) " +
                      "values(@idu, @idtipousuario,@idsucursal,@nombre,@apaterno,@amaterno,@activo,@email,@telefono,@login,@pass)";
                    }
                    else
                    {                       
                        query = "UPDATE usuario set idtipousuario=@idtipousuario, idsucursal=@idsucursal, nombre=@nombre, apaterno=@apaterno, amaterno=@amaterno, activo=@activo, email=@email, telefono=@telefono, login=@login, pass=@pass WHERE idusuario = @idu and idsucursal=@idsucursal"; 
                    }

                    MySqlCommand cmd = new MySqlCommand(query, con);
                    /*if (!hs.Equals(""))
                    {
                       cmd.Parameters.AddWithValue("@palabra", hs);
                    }
                    if (!idUsuario.Equals("null"))
                    {
                        cmd.Parameters.AddWithValue("@idu", idUsuario);
                    }*/
                    int uactivo;
                    if (activo.Checked)
                        uactivo = 1;
                    else
                        uactivo = 0;

                    cmd.Parameters.AddWithValue("@idu", idUsuario);
                    cmd.Parameters.AddWithValue("@idtipousuario", tipo.SelectedValue);
                    cmd.Parameters.AddWithValue("@idsucursal", area.SelectedValue);

                    cmd.Parameters.AddWithValue("@nombre", nombre.Text.ToUpper());
                    cmd.Parameters.AddWithValue("@apaterno", apaterno.Text.ToUpper());
                    cmd.Parameters.AddWithValue("@amaterno", amaterno.Text.ToUpper());
                    cmd.Parameters.AddWithValue("@activo", uactivo);

                    cmd.Parameters.AddWithValue("@email", email.Text);
                    cmd.Parameters.AddWithValue("@telefono", telefono.Text.Replace("-", "").Replace("(", "").Replace(")", "").Replace(" ", "").Replace(" ","").Trim());                    
                    cmd.Parameters.AddWithValue("@login", usuario.Text);
                    cmd.Parameters.AddWithValue("@pass", pass.Text);

                    cmd.ExecuteNonQuery();

                    if (idUsuario == 0)
                    {
                       // enviarMail(email.Text, usuario.Text, pass.Text);
                    }
                    volverListado(sender, e);
                    //ClearTextBoxes(this.Controls);
                    /*if (idUsuario.Equals("null"))
                        ScriptManager.RegisterStartupScript(this, GetType(), "abrirModal", "window.onload = function(){ exito(); };", true);
                    else
                        ScriptManager.RegisterStartupScript(this, GetType(), "abrirModal", "window.onload = function(){ swal('Correcto!', 'Cambios en datos de usuario han sido guardados con exito', 'success'); };", true);*/


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

        private void ClearTextBoxes(ControlCollection controls)
        {
            foreach (TextBox tb in controls.OfType<TextBox>())
                tb.Text = string.Empty;
            foreach (Control c in controls)
                ClearTextBoxes(c.Controls);
        }

        public void enviarMail(string destinatario, string usuario, string pass)
        {

            SmtpClient smtp = new SmtpClient("smtpout.asia.secureserver.net", 80);
            smtp.EnableSsl = false;
            smtp.DeliveryMethod = SmtpDeliveryMethod.Network;

            smtp.UseDefaultCredentials = false;
            smtp.Credentials = new NetworkCredential("soporte@ipsec.mx", "Am90123k%r");

            MailMessage email = new MailMessage();

            email.From = new MailAddress("soporte@ipsec.mx");
            email.To.Add(destinatario);
            email.Subject = "Cuenta Soporte Ipsec";
            email.Body = "Su cuenta para ingreso a la Plataforma de Soporte Ipsec ha sido creada con las siguientes credenciales <br><br> " +
                        "<b>Usuario:</b> "+ usuario + "<br> " +
                        "<b>Password:</b> "+pass+"<br><br><br>"+
                        "Ingreso al portal en <b><a href='soporte.ipsec.mx'>soporte.ipsec.mx</a></b>";
            email.IsBodyHtml = true;

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
            t1.Start();

        }
    }
}