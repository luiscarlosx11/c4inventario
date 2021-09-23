using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using MySql.Data.MySqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

namespace elecion
{
    public partial class login : Page
    {
        static Usuarios usr;
        static AuthyClient.IAuthyApiClient client;
        static string authyUserId;
        //

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void ilogin_Click(object sender, EventArgs e)
        {
            String pass = hep.Value;
            if (pass.Equals(""))
            {
                pass = "-";
            }
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
            String hs = Convert.ToBase64String(encryptedMessage);
            String rol = "";


            using (MySqlConnection con = new MySqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {
                String SQL = "select u.idusuario, u.nombre, u.apellidos, u.idrol "+
                            "from usuario u "+                            
                            "where u.login = @u and u.secret=@p and u.activo=1;"; //1 = pwdcompare(@p,palabra,0)";
                con.Open();
                try
                {
                    MySqlCommand cmd = new MySqlCommand(SQL, con);
                    cmd.Parameters.AddWithValue("@u", username.Text.Trim());
                    cmd.Parameters.AddWithValue("@p", userpasswd.Text.Trim());
                    MySqlDataReader rdr = cmd.ExecuteReader();

                    if (rdr.HasRows)
                    {
                        rdr.Read();
                        rol = rdr.GetString(3);
                        usr = new Usuarios();
                        usr.nombre = rdr.GetString(1);
                        usr.usuario = rdr.GetString(2);
                        //usr.rol = rdr.GetString(7);
                        usr.id = rdr.GetInt32(0);
                        
                        //usr.entidad = rdr.GetInt16(6);
                        //usr.img = rdr.GetString(4);
                        error.Text = "";

                        Session["idusuario"] = usr.id; 
             /* client = new AuthyClient.AuthyApiClient("S82vzHddyhFA5g7Xs02VPqq1BfzY518q", testMode: false);
                        authyUserId = client.CreateAuthyUser("salvador.cb@infix.com.mx", rdr.GetString(4), 52);
                        client.SendToken(authyUserId, true);*/
                        
                        String datos = usr.nombre + ";" + usr.usuario + ";" + usr.usuario ;
                        FormsAuthenticationTicket tkt;
                        string cookiestr;
                        HttpCookie ck;
                        tkt = new FormsAuthenticationTicket(1,
                             usr.nombre,
                            DateTime.Now,
                        DateTime.Now.AddMinutes(30), true, usr.id + "," + datos + "," + usr.rol);
                        cookiestr = FormsAuthentication.Encrypt(tkt);
                        ck = new HttpCookie(FormsAuthentication.FormsCookieName, cookiestr);
                        if (true)
                            ck.Expires = tkt.Expiration;
                        ck.Path = FormsAuthentication.FormsCookiePath;
                        Response.Cookies.Add(ck);

                        string url = Request["ReturnUrl"];

                        
                        Response.Redirect("default.aspx");
                                               /*

                       ScriptManager.RegisterStartupScript(this, GetType(), "abrirModal", "window.onload = function(){ cerrarLoading(); modal(); };", true);*/
                       
                    }
                    else
                    {
                       error.Text = "Usuario o contraseña incorrecto, intente de nuevo.";
                    }

                }
                catch (Exception ex)
                {
                    String excep = ex.ToString();
                    error.Text = "Usuario o contraseña incorrecto, intente de nuevo.";
                }

                
                con.Close();
            }

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

        private static void MemoryStream()
        {
            throw new NotImplementedException();
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

       
    }
}