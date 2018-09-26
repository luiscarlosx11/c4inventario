using System;
using System.Data.SqlClient;
using System.Web;
using System.Web.Security;
using System.Web.UI;

namespace elecion.usuarios
{
    public partial class usuario : System.Web.UI.Page
    {

        private static string idUsuario;
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                String idD = "";

                var id = (FormsIdentity)User.Identity;
                var ticket = id.Ticket;
                string[] datos = ticket.UserData.Split(',');
                try
                {
                    HttpContext CurrContext = HttpContext.Current;
                    idD = CurrContext.Items["idu"].ToString();
                    idUsuario = idD;
                    getUsuario(idUsuario);
                }catch
                {
                    Response.Redirect("control.aspx");
                }
               
            }
           
        }

        private void getUsuario(String idu)
        {
            using (SqlConnection con = new SqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {
                try
                {
                    con.Open();
                    string sql = "SELECT usuario, nombre, email, activo, telefono, tipo FROM control where id = @idu";
                    SqlCommand cmd = new SqlCommand(sql, con);
                    cmd.Parameters.AddWithValue("@idu", idu);
                    SqlDataReader rdr = cmd.ExecuteReader();
                    if (rdr.HasRows)
                    {
                        rdr.Read();
                        cusuario.Text = rdr["usuario"].ToString();
                        nombre.Text = rdr["nombre"].ToString();
                        activo.SelectedValue = rdr["activo"].ToString();
                        email.Text = rdr["email"].ToString();
                        telefono.Text = rdr["telefono"].ToString();
                        tipo.SelectedValue = rdr["tipo"].ToString();
                    }
  
                }
                catch (Exception ex)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "abrirModal", "window.onload = function(){ swaError('" + ex.Message.Replace("\r\n", "") + "'); };", true);
                }
                finally
                {
                    con.Close();
                }
            }
        }

        protected void colonias_DataBound(object sender, EventArgs e)
        {
            DsCalle.DataBind();
            calle.DataBind();
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
            public static string CreateHash(string password)
            {
                // Generate a random salt
                System.Security.Cryptography.RNGCryptoServiceProvider csprng = new System.Security.Cryptography.RNGCryptoServiceProvider();
                byte[] salt = new byte[SALT_BYTE_SIZE];
                csprng.GetBytes(salt);

                // Hash the password and encode the parameters
                byte[] hash = PBKDF2(password, salt, PBKDF2_ITERATIONS, HASH_BYTE_SIZE);
                return PBKDF2_ITERATIONS + ":" +
                    Convert.ToBase64String(salt) + ":" +
                    Convert.ToBase64String(hash);
            }

            /// <summary>
            /// Validates a password given a hash of the correct one.
            /// </summary>
            /// <param name="password">The password to check.</param>
            /// <param name="correctHash">A hash of the correct password.</param>
            /// <returns>True if the password is correct. False otherwise.</returns>
            public static bool ValidatePassword(string password, string correctHash)
            {
                // Extract the parameters from the hash
                char[] delimiter = { ':' };
                string[] split = correctHash.Split(delimiter);
                int iterations = Int32.Parse(split[ITERATION_INDEX]);
                byte[] salt = Convert.FromBase64String(split[SALT_INDEX]);
                byte[] hash = Convert.FromBase64String(split[PBKDF2_INDEX]);

                byte[] testHash = PBKDF2(password, salt, iterations, hash.Length);
                return SlowEquals(hash, testHash);
            }

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
            private static byte[] PBKDF2(string password, byte[] salt, int iterations, int outputBytes)
            {
                System.Security.Cryptography.Rfc2898DeriveBytes pbkdf2 = new System.Security.Cryptography.Rfc2898DeriveBytes(password, salt);
                pbkdf2.IterationCount = iterations;
                return pbkdf2.GetBytes(outputBytes);
            }
        }

        protected void guardar_Click(object sender, EventArgs e)
        {
            String pass = hep.Value;
            String hs = "";
            if (!pass.Equals(""))
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
            }
            
            using (SqlConnection con = new SqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {
                try
                {
                    con.Open();
                    String query = "";
                    if (!psswd.Text.Equals(""))
                    {
                        query = "UPDATE control set usuario = @usr, nombre = @nmb, email = @mail, telefono = @tel, activo = @activo, tipo = @tipo, palabra = pwdencrypt(@palabra) WHERE id = @id";
                    }
                    else
                    {
                        /* query = "INSERT INTO control(usuario, nombre, email, telefono, activo, tipo) " +
                          "values(@usr,@nmb,@mail,@tel,@activo,@tipo)";*/
                        query = "UPDATE control set usuario = @usr, nombre = @nmb, email = @mail, telefono = @tel, activo = @activo, tipo = @tipo WHERE id = @id ";
                    }

                    SqlCommand cmd = new SqlCommand(query, con);

                    if (!psswd.Text.Equals(""))
                    {
                        cmd.Parameters.AddWithValue("@palabra", hs);
                    }
                    cmd.Parameters.AddWithValue("@id", idUsuario);
                    cmd.Parameters.AddWithValue("@usr", cusuario.Text);
                    cmd.Parameters.AddWithValue("@nmb", nombre.Text);
                    cmd.Parameters.AddWithValue("@mail", email.Text);
                    cmd.Parameters.AddWithValue("@tel", telefono.Text.Replace("-", "").Replace("(", "").Replace(")", "").Replace(" ","").Trim());
                    cmd.Parameters.AddWithValue("@activo", activo.SelectedValue);
                    cmd.Parameters.AddWithValue("@tipo", tipo.SelectedItem.Text);
                   
                    cmd.ExecuteNonQuery();

                    HttpCookie cookie = FormsAuthentication.GetAuthCookie(FormsAuthentication.FormsCookieName, true);
                    var ticket1 = FormsAuthentication.Decrypt(cookie.Value);
                    var id = (FormsIdentity)Page.User.Identity;
                    var ticket = id.Ticket;
                    string[] data = ticket.UserData.Split(',');

                    String datos = nombre.Text + ";" + cusuario.Text + ";" + cusuario.Text;
                    String ndata = nombre.Text + "," + datos + "," + data[2];
                    FormsAuthenticationTicket newticket = new FormsAuthenticationTicket
                           (ticket1.Version, // Ticket version
                            ticket1.Name, // Username associated with ticket
                            ticket1.IssueDate, // Date/time issued
                            ticket1.Expiration, // Date/time to expire                    
                            true, //"true" for a persistent user cookie                    
                            ndata, //User-data, in this case the roles from a dropdown                    
                            ticket1.CookiePath);

                    // Encrypt the ticket and store it in the cookie
                    cookie.Value = FormsAuthentication.Encrypt(newticket);

                    // Set the cookie's expiration time to the tickets expiration time
                    if (ticket1.IsPersistent) cookie.Expires = newticket.Expiration;

                    // Add the cookie to the list for outgoing response
                    HttpContext.Current.Response.Cookies.Add(cookie);
                    ScriptManager.RegisterStartupScript(this, GetType(), "abrirModal", "window.onload = function(){ swaExito(); };", true);

                }
                catch (Exception ex)
                {

                    ScriptManager.RegisterStartupScript(this, GetType(), "abrirModal", "window.onload = function(){ swaError('" + ex.Message.Replace("\r\n", "").Replace("'","") + "'); };", true);

                }
                finally
                {
                    con.Close();
                }


            }
        }
    }
}