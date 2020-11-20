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

using System.Data;
using System.IO;
using System.Drawing;

namespace elecion.catalogos.directorio
{
    public partial class frminstructor : System.Web.UI.Page
    {
        private static int idUsuario;
        private static int idsucursal;

        protected void Page_Load(object sender, EventArgs e)
        {

            var id = (FormsIdentity)Page.User.Identity;
            var ticket = id.Ticket;
            string[] datos = ticket.UserData.Split(',');
            string[] datos2 = datos[1].Split(';');
           
            idsucursal = Convert.ToInt32(datos2[4]);

            if (!IsPostBack)
            {
                String idProm = "";
                String idSuc = "";

                try
                {
                    idProm = Session["idP"].ToString();
                    idUsuario = Convert.ToInt32(idProm);



                    if (idUsuario > 0)
                    {
                        idSuc = Session["idS"].ToString();
                        idsucursal = Convert.ToInt32(idSuc);
                        getUsuario(idUsuario);
                       
                    }
                    //Session.Remove("idP");
                    //ScriptManager.RegisterStartupScript(this, GetType(), "abrirModal", "window.onload = function(){ $(document).prop('title', 'PLACEL - Editar Usuario'); };", true);
                }
                catch
                {
                   
                }

                
            }
           
        }

        private DataTable GetData(string query)
        {
            DataTable dt = new DataTable();
            //string constr = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
            using (MySqlConnection con = new MySqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {
                using (MySqlCommand cmd = new MySqlCommand(query))
                {
                    using (MySqlDataAdapter sda = new MySqlDataAdapter())
                    {
                        cmd.CommandType = CommandType.Text;
                        cmd.Connection = con;
                        sda.SelectCommand = cmd;
                        sda.Fill(dt);
                    }
                }
                return dt;
            }
        }

        private void getUsuario(int idUser)
        {
            using (MySqlConnection con = new MySqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {
                try
                {
                    con.Open();
                    string sql = "select idcliente, clave, CAST(fecharegistro as char)as fecharegistro, "+
                                 "ncompleto, foto, " +                                
                                 "domicilio, colonia, identidad, localidad, cp, email, telefono, celular, observaciones "+
                                 "from cliente "+
                                 "where idcliente=@idP and idsucursal=@idS ";


                    MySqlCommand cmd = new MySqlCommand(sql, con);
                    cmd.Parameters.AddWithValue("@idP", idUser);
                    cmd.Parameters.AddWithValue("@idS", idsucursal);
                    MySqlDataReader rdr = cmd.ExecuteReader();
                    if (rdr.HasRows)
                    {
                        rdr.Read();
                        idP.Value = rdr["idcliente"].ToString();
                        // usuario.Text = rdr["login"].ToString();
                        // pass.Text = rdr["pass"].ToString();

                        clave.Text = rdr["clave"].ToString();
                        nombre.Text = rdr["ncompleto"].ToString();
                       // apaterno.Text = rdr["apaterno"].ToString();
                        //amaterno.Text = rdr["amaterno"].ToString();

                        calle.Text = rdr["domicilio"].ToString();
                        colonia.Text = rdr["colonia"].ToString();
                        cp.Text = rdr["cp"].ToString();
                        entidad.SelectedValue = rdr["identidad"].ToString();
                        localidad.Text = rdr["localidad"].ToString();

                        email.Text = rdr["email"].ToString();
                        telefono.Text = rdr["telefono"].ToString();
                        celular.Text = rdr["celular"].ToString();

                        observaciones.Text = rdr["observaciones"].ToString();
                        

                        // if (rdr["activo"].ToString()=="1") 
                        //  activo.Checked = true;

                       
                            Byte[] ImageByte = (Byte[])(rdr["foto"]);


                            if (ImageByte != null)
                            {
                                // You need to convert it in bitmap to display the imgage
                                fotopa.ImageUrl = "data:image/jpeg;base64," + Convert.ToBase64String(ImageByte);
                                fotopa.DataBind();

                            }
                                     

                    }


                    /*byte[] bytes = (byte[])GetData("SELECT foto FROM cliente WHERE idcliente =" + idUser).Rows[0]["foto"];
                    string base64String = Convert.ToBase64String(bytes, 0, bytes.Length);
                    fotopa.ImageUrl = "data:image/png;base64," + base64String;*/
                    //area.Enabled = false;


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
            Response.Redirect("~/catalogos/directorio/catinstructores.aspx");
            //Response.RedirectToRoute("Usuarios");
        }


        protected void guardaEdita(object sender, EventArgs e)
        {
            
         
            using (MySqlConnection con = new MySqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {
                try
                {
                    con.Open();

                    String query = "";

                    if (idUsuario==0)
                    {
                        string consulta= "select coalesce(max(idcliente),0) from cliente where idsucursal=" + idsucursal+";";
                        MySqlCommand cmdu = new MySqlCommand(consulta, con);
                        idUsuario = Convert.ToInt32(cmdu.ExecuteScalar()) + 1;


                        query = "INSERT INTO cliente(idcliente, idsucursal, clave, ncompleto, domicilio, colonia, cp, identidad, localidad, email, telefono, celular, observaciones, foto, fecharegistro, horaregistro) " +
                      "values(@idu, @idsucursal, @clave, @ncompleto,@domicilio,@colonia, @cp, @identidad, @localidad,@email,@telefono,@celular,@observaciones,@foto,current_date, current_time);";
                    }
                    else
                    {                       
                        query = "UPDATE cliente set clave=@clave, ncompleto=@ncompleto, domicilio=@domicilio, colonia=@colonia, cp=@cp, identidad=@identidad, localidad=@localidad, "+
                                " email=@email, telefono=@telefono, celular=@celular, observaciones=@observaciones, foto=@foto WHERE idcliente = @idu and idsucursal=@idsucursal;"; 
                    }

                    MySqlCommand cmd = new MySqlCommand(query, con);
                    

                    cmd.Parameters.AddWithValue("@idu", idUsuario);
                    cmd.Parameters.AddWithValue("@idsucursal", idsucursal);

                    cmd.Parameters.AddWithValue("@clave", clave.Text.ToUpper());
                    cmd.Parameters.AddWithValue("@ncompleto", nombre.Text.ToUpper());
                    //cmd.Parameters.AddWithValue("@apaterno", apaterno.Text.ToUpper());
                    //cmd.Parameters.AddWithValue("@amaterno", amaterno.Text.ToUpper());

                    cmd.Parameters.AddWithValue("@domicilio", calle.Text.ToUpper());
                    cmd.Parameters.AddWithValue("@colonia", colonia.Text.ToUpper());
                    cmd.Parameters.AddWithValue("@identidad", entidad.SelectedValue);
                    cmd.Parameters.AddWithValue("@localidad", localidad.Text.ToUpper());
                    cmd.Parameters.AddWithValue("@cp", cp.Text.ToUpper());
                    //cmd.Parameters.AddWithValue("@activo", uactivo);

                    cmd.Parameters.AddWithValue("@email", email.Text);
                    cmd.Parameters.AddWithValue("@telefono", telefono.Text.Replace("-", "").Replace("(", "").Replace(")", "").Replace(" ", "").Replace(" ","").Trim());
                    cmd.Parameters.AddWithValue("@celular", celular.Text.Replace("-", "").Replace("(", "").Replace(")", "").Replace(" ", "").Replace(" ", "").Trim());

                    cmd.Parameters.AddWithValue("@observaciones", observaciones.Text.ToUpper());
                    //cmd.Parameters.AddWithValue("@foto", fotopa);

                    Stream fs = Bfoto.PostedFile.InputStream;
                    BinaryReader br = new BinaryReader(fs);

                    byte[] bytes = br.ReadBytes((Int32)fs.Length);


                    cmd.Parameters.Add("@foto", MySqlDbType.Blob);
                    cmd.Parameters["@foto"].Value = bytes;
                    //cmd.Parameters.AddWithValue("@foto", bytes);
                    //cmd.Parameters.AddWithValue("@login", usuario.Text);
                    //cmd.Parameters.AddWithValue("@pass", pass.Text);

                    cmd.ExecuteNonQuery();
                    volverListado(sender,e);
                   

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

       
    }
}