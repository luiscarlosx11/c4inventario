using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace elecion.estructuras
{
    public partial class coordinador : System.Web.UI.Page
    {
        static string ide;
        private static string idGasto;
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

                String idProm = "";

                try
                {
                    idProm = Session["idP"].ToString();


                    idGasto = idProm;
                    idP.Value = idGasto;
                    
                    getPromovido(idGasto);

                }
                catch
                {
                    Response.Redirect("~/estructuras/listadoEstructura.aspx");
                }

            }
        }

        protected void municipios_DataBound(object sender, EventArgs e)
        {
            DsColonia.DataBind();
            colonias.DataBind();
        }

        protected void municipiosCoord_DataBound(object sender, EventArgs e)
        {
            DsDemarcacion.DataBind();
            demarcacion.DataBind();
        }

        protected void demarcacion_DataBound(object sender, EventArgs e)
        {
            DsSeccional.DataBind();
            seccional.DataBind();
        }

        protected void colonias_DataBound(object sender, EventArgs e)
        {
            DsCalle.DataBind();
            calle.DataBind();
        }

        private void getPromovido(String idProm)
        {
            using (SqlConnection con = new SqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {
                try
                {
                    con.Open();
                    string sql = "SELECT [coordinador],[idcoordinador],[nombre],[paterno],[materno],[email],[telefono],[idcolonia],[idcalle],[num_ext],[num_int],[cp],[idMunicipio],[tipo],[idEstructura],[seccion],[demarcacion],[idmunicipioest] FROM [coordinadores] where idcoordinador=@idP";
                    SqlCommand cmd = new SqlCommand(sql, con);
                    cmd.Parameters.AddWithValue("@idP", idProm);
                    SqlDataReader rdr = cmd.ExecuteReader();
                    if (rdr.HasRows)
                    {
                        rdr.Read();
                        idP.Value = rdr["idcoordinador"].ToString();
                       // elector.Text = rdr["clave_e"].ToString();
                        nombre.Text = rdr["nombre"].ToString();
                        apaterno.Text = rdr["paterno"].ToString();
                        amaterno.Text = rdr["materno"].ToString();

                        email.Text = rdr["email"].ToString();
                        telefono.Text = rdr["telefono"].ToString();

                        municipio.SelectedValue = rdr["idMunicipio"].ToString();                       
                        colonias.SelectedValue = rdr["idcolonia"].ToString();
                        calle.SelectedValue = rdr["idcalle"].ToString();
                        municipiocoord.SelectedValue = rdr["idmunicipioest"].ToString();

                        dEstructura.SelectedValue = rdr["idEstructura"].ToString();
                        
                        demarcacion.SelectedValue = rdr["demarcacion"].ToString();
                        seccional.SelectedValue = rdr["seccion"].ToString();
                        
                        //Si es coordinador
                        if (rdr.GetInt32(0) == 1)
                        {
                            activo.Checked = true;
                        }else
                        {
                            activo.Checked = false;
                        }
                        //preferencia.Text = rdr["preferencia"].ToString();
                        //estado.SelectedValue = rdr["estado"].ToString();

                        numext.Text = rdr["num_ext"].ToString();
                        numint.Text = rdr["num_int"].ToString();
                        cp.Text = rdr["cp"].ToString();

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

        protected void guardar_Click(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {


                try
                {
                    con.Open();

                    String query = "";

                    //Si el idmunicipio es mayor que cero se hace UPDATE
                    if (Int32.Parse(idP.Value) > 0)
                    {                       

                        query = "UPDATE coordinadores set nombre=@nmb,paterno=@ptno,materno=@mtno,email=@mail,telefono=@tel,idMunicipio=@idm,nomMunicipio=@mun,idcolonia=@colonia,idcalle=@calle,num_ext=@nume,num_int=@numi,cp=@cp,tipo=@tipo,idEstructura=@estructura, " +
                                "seccion=@seccion,demarcacion=@dem,idmunicipioest=@munest,coordinador=@escoord "+
                                "where idcoordinador=@idp;";
                    }
                    else
                        query = "INSERT INTO coordinadores(nombre,paterno,materno,email,telefono,idMunicipio,nomMunicipio,idcolonia,idcalle,num_ext,num_int,cp,tipo,idEstructura,seccion,demarcacion,idmunicipioest,coordinador) " +
                                "values(@nmb,@ptno,@mtno,@mail,@tel,@idm,@mun,@colonia,@calle,@nume,@numi,@cp,@tipo,@estructura,@seccion,@dem,@munest,@escoord)";

                   
                    
                    SqlCommand cmd = new SqlCommand(query, con);


                    if (Int32.Parse(idP.Value) > 0)
                        cmd.Parameters.AddWithValue("@idp", idP.Value);

                    cmd.Parameters.AddWithValue("@nmb", nombre.Text);
                    cmd.Parameters.AddWithValue("@ptno", apaterno.Text);
                    cmd.Parameters.AddWithValue("@mtno", amaterno.Text);
                    cmd.Parameters.AddWithValue("@tipo", 1);
                    cmd.Parameters.AddWithValue("@mail", email.Text);
                    cmd.Parameters.AddWithValue("@tel", telefono.Text.Replace("-", "").Replace("(", "").Replace(")", "").Trim());
                    cmd.Parameters.AddWithValue("@idm", municipio.SelectedValue);
                    cmd.Parameters.AddWithValue("@mun", municipio.SelectedItem.Text);
                    cmd.Parameters.AddWithValue("@colonia", colonias.SelectedValue);
                    cmd.Parameters.AddWithValue("@calle", calle.SelectedValue);
                    cmd.Parameters.AddWithValue("@nume", numext.Text);
                    cmd.Parameters.AddWithValue("@numi", numint.Text);
                    cmd.Parameters.AddWithValue("@cp", cp.Text);
                    
                    if(activo.Checked)
                        cmd.Parameters.AddWithValue("@escoord", 1);
                    else
                        cmd.Parameters.AddWithValue("@escoord", 0);

                    cmd.Parameters.AddWithValue("@estructura", dEstructura.SelectedValue);
                    cmd.Parameters.AddWithValue("@seccion", seccional.SelectedValue);
                    cmd.Parameters.AddWithValue("@dem", demarcacion.SelectedValue);
                    cmd.Parameters.AddWithValue("@munest", municipiocoord.SelectedValue);

                    cmd.ExecuteNonQuery();

                    //ScriptManager.RegisterStartupScript(this, GetType(), "abrirModal", "window.onload = function(){ swaExito(); };", true);
                    // ClearTextBoxes(this.Controls);

                    Response.Redirect("~/estructuras/listadoEstructura.aspx");

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

        private void ClearTextBoxes(ControlCollection controls)
        {
            foreach (TextBox tb in controls.OfType<TextBox>())
                tb.Text = string.Empty;
            foreach (Control c in controls)
                ClearTextBoxes(c.Controls);
        }

        
        protected void regresarListado(object sender, EventArgs e)
        {
            Response.Redirect("~/estructuras/listadoEstructura.aspx");
        }
    }
}