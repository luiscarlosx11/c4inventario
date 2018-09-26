using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;

namespace elecion.promocion
{
    public partial class agenda : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                
                
                String json = "";
               
                using (SqlConnection con = new SqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
                {
                    try
                    {
                        con.Open();
                        string query = "select idagenda, cast(fechaini as varchar)as fechaini, cast(fechafin as varchar)as fechafin, convert(char(5),convert(time(0),horaini)) as horaini, convert(char(5),convert(time(0),horafin))as horafin, concepto from agenda ";
                        SqlCommand cmd = new SqlCommand(query, con);
                        SqlDataReader rdr = cmd.ExecuteReader();

                       
                        json += "[";

                        //new queryString/command setup

                        if (rdr.HasRows)
                        {
                            
                            while (rdr.Read())
                            {
                          
                                json += "{";
                                json += "id:'"+rdr["idagenda"]+"',";
                                json += "title:'"+rdr["horaini"].ToString() +" "+ rdr["concepto"].ToString() + "',";                                
                                json += "start:'" + rdr["fechaini"].ToString() + "',";
                                json += "end:'" + rdr["fechafin"].ToString()+"'";
                                json += "},";
                               
                            }

                        }
                        
                        json += "]";


                    }
                    catch (Exception ex)
                    {
                        
                        ScriptManager.RegisterStartupScript(this, GetType(), "abrirModal", " swaError('" + ex.Message.Replace("\r\n", "") + "'); ", true);
                    }
                    finally
                    {
                        con.Close();
                    }
                    
                    System.Diagnostics.Debug.WriteLine("dataEvent ="+json);
                    ScriptManager.RegisterStartupScript(this, GetType(), "inicilizarMun", "dataEvent =" + json, true);
                }

            }

        }


        protected void editaRegistro(object sender, EventArgs e)
        {
            Session["idP"] = idP.Value;
            Response.Redirect("~/promocion/agregarevento.aspx");
        }


        protected void nuevoRegistro(object sender, EventArgs e)
        {

            using (SqlConnection con = new SqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {
                try
                {
                    con.Open();
                    string sql = "INSERT INTO agenda(usuarioRegistra) output INSERTED.IDAGENDA values(@idusuario)";
                    SqlCommand cmd = new SqlCommand(sql, con);
                    cmd.Parameters.AddWithValue("@idusuario", 7);                    

                    //cmd.ExecuteNonQuery();

                    int modified = (int)cmd.ExecuteScalar();
                  

                    Session["idP"] = modified;

                    Response.Redirect("~/promocion/agregarevento.aspx");

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





    }


    }
