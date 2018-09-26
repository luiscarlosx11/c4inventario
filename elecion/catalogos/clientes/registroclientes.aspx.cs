using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;

namespace elecion.catalogos.sistema
{
    public partial class registroclientes : System.Web.UI.Page
    {
        static string ide;
        private static int id;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

                
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

                   
                }
                catch
                {
                    Response.Redirect("~/catalogos/clientes/catentidades.aspx");

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
                    string sql = "insert into cliente(nombre,telefono,mail) values('','','');";
                    
                    MySqlCommand cmd = new MySqlCommand(sql, con);             
                    cmd.ExecuteNonQuery();

                    int idticket = (int)cmd.LastInsertedId;

                    idP.Value = idticket.ToString();
                    
                    

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
                    string sql = "SELECT nombre,telefono,mail from cliente where idcliente=@idP";
                    MySqlCommand cmd = new MySqlCommand(sql, con);
                    cmd.Parameters.AddWithValue("@idP", id);
                    cmd.ExecuteNonQuery();

                    MySqlDataReader rdr = cmd.ExecuteReader();
                    if (rdr.HasRows)
                    {
                        rdr.Read();
                        

                        nombre.Text = rdr["nombre"].ToString();
                        telefono.Text = rdr["telefono"].ToString();
                        email.Text = rdr["mail"].ToString();
                       

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

       

        protected void guardaContrato(object sender, EventArgs e)
        {
            using (MySqlConnection con = new MySqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {


                try
                {
                    con.Open();
                    String query = "";
                    //Si el idmunicipio es mayor que cero se hace UPDATE
                    if (Int32.Parse(idg.Value) > 0)
                        query = "UPDATE contrato set nombre=@nombre where idcontrato=@idcontrato;";
                    else
                        query = "INSERT INTO contrato(nombre,idcliente) values(@nombre,@idcliente);";

                    MySqlCommand cmd = new MySqlCommand(query, con);


                    cmd.Parameters.AddWithValue("@idcontrato", idg.Value);
                    cmd.Parameters.AddWithValue("@idcliente", idP.Value);
                    cmd.Parameters.AddWithValue("@nombre", nombrec.Text);


                    cmd.ExecuteNonQuery();

                    ScriptManager.RegisterClientScriptBlock(Page, typeof(string), "myScriptName", "cerrarLoading();", true);

                    refrescaGrid(sender, e);


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

        protected void guardaEdita(object sender, EventArgs e)
        {
            using (MySqlConnection con = new MySqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {


                try
                {
                    con.Open();                
                    String query = "";
                    query = "update cliente set nombre=@nombre, telefono=@telefono, mail=@mail where idcliente=@idP";
                    

                    MySqlCommand cmd = new MySqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@idP", idP.Value);
                    cmd.Parameters.AddWithValue("@nombre", nombre.Text);
                    cmd.Parameters.AddWithValue("@telefono", telefono.Text);                                        
                    cmd.Parameters.AddWithValue("@mail", email.Text);                  

                    cmd.ExecuteNonQuery();
                    Response.Redirect("~/catalogos/clientes/catentidades.aspx");


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

        protected void finalizar(object sender, EventArgs e)
        {
            using (MySqlConnection con = new MySqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {


                try
                {
                    con.Open();
                    String query = "";
                    query = "update ticket set estatus='CERRADO', idcalificacion=@calificacion " +
                            "where idticket=@idP";

                    MySqlCommand cmd = new MySqlCommand(query, con);

                    
                    cmd.Parameters.AddWithValue("@idp", idP.Value);
                    //cmd.Parameters.AddWithValue("@calificacion", nestrellas.Value);

                    cmd.ExecuteNonQuery();

                    regresarListado(sender,e);

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
                    //cmd.Parameters.AddWithValue("@comentario", nota.Text);

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

        protected void refrescaGrid(object sender, EventArgs e)
        {
            DScontratos.DataBind();
            lcontratos.DataBind();
        }

        protected void listadoContratos()
        {
/*
            lcontratos.DataSourceID = DScontratos.ID;

            String query = "select idcontrato, nombre from contrato where idcliente=" + idP.Value + " order by nombre ";
            DScontratos.SelectCommand = query;

            DScontratos.DataBind();
            lcontratos.DataBind();*/

        }



        private void recuperaSeguimiento(int id)
        {

           
            
           // DSSeguimiento.SelectCommand = "SELECT IDSEGUIMIENTO, cast(FECHA as char)AS FECHA, cast(HORA as char)AS HORA, COMENTARIO FROM seguimiento  WHERE IDTICKET = "+id+";";            
           

            //ScriptManager.RegisterClientScriptBlock(Page, typeof(string), "myScriptName", "cerrarLoading();", true);
            

        }

        protected void clientes_DataBound(object sender, EventArgs e)
        {

           // Dscontratos.DataBind();
            //contrato.DataBind();

        }

               
        protected void regresarListado(object sender, EventArgs e)
        {
            Response.Redirect("~/catalogos/clientes/catentidades.aspx");
        }

       
    }
}