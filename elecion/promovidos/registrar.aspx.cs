using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

namespace elecion.promovidos
{
    public partial class registrar : System.Web.UI.Page
    {
        private static string idPromovido;
        private static string hcalle;
        private static string hcolonia;
        private static string hsecc;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                String idProm = "";
                hcolonia = null;
                hcalle = null;
                hsecc = null;
                var id = (FormsIdentity)Page.User.Identity;
                var ticket = id.Ticket;
                string[] datos = ticket.UserData.Split(',');
                string[] datos2 = datos[1].Split(';');
                hentidad.Value = datos2[3];
                try
                {
                    idProm = Session["idP"].ToString();
                    idPromovido = idProm;
                    if(idPromovido == "0")
                    {
                        divBus.Visible = true;
                    }
                    else
                    {
                        divBus.Visible = false;
                        //divBus.Visible = false;
                        divDatos.Visible = true;
                        getPromovido(idPromovido);
                    }
                   
                }
                catch
                {
                    Response.Redirect("~/promovidos/listado.aspx");
                }

            }else
            {

                
            }
        }


        private void getPromovido(String idProm)
        {
            using (SqlConnection con = new SqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {
                try
                {
                    con.Open();
                    string sql = "SELECT [idP],[clave_e],[nombre],[paterno],[materno],[seccion],[email],[telefono],[colonia],[calle],[num_ext],[num_int],[cp],[idMunicipio],[estado],[idEstructura],[preferencia] FROM [promovidos] where idP=@idP";
                    SqlCommand cmd = new SqlCommand(sql, con);
                    cmd.Parameters.AddWithValue("@idP", idProm);
                    SqlDataReader rdr = cmd.ExecuteReader();
                    if (rdr.HasRows)
                    {
                        rdr.Read();
                        idP.Value = rdr["idP"].ToString();
                        elector.Text = rdr["clave_e"].ToString();
                        nombre.Text = rdr["nombre"].ToString();
                        apaterno.Text = rdr["paterno"].ToString();
                        amaterno.Text = rdr["materno"].ToString();                                               

                        email.Text = rdr["email"].ToString();
                        telefono.Text = rdr["telefono"].ToString();

                        municipio.SelectedValue = rdr["idMunicipio"].ToString();

                        hsecc = rdr["seccion"].ToString();
                        /*hcolonia = rdr["colonia"].ToString();
                        hcalle = rdr["calle"].ToString();*/

                        if (colonias.Items.FindByValue(rdr["colonia"].ToString()) != null)
                            colonias.SelectedValue = rdr["colonia"].ToString();

                        if (calle.Items.FindByValue(rdr["colonia"].ToString()) != null)
                            calle.SelectedValue = rdr["calle"].ToString();

                        estructura.SelectedValue = rdr["idEstructura"].ToString();
                        preferencia.Text = rdr["preferencia"].ToString();
                        estado.SelectedValue = rdr["estado"].ToString();

                        numext.Text = rdr["num_ext"].ToString();
                        numint.Text = rdr["num_int"].ToString();
                        cp.Text = rdr["cp"].ToString();



                    }

                }
                catch (Exception ex) { 
                    ScriptManager.RegisterStartupScript(this, GetType(), "abrirModal", " swaError('" + ex.Message.Replace("\r\n", "") + "'); ", true);
                }
                finally
                {
                    con.Close();
                }
            }
        }

        protected void pantalla(object sender, EventArgs e)
        {
            // Response.Redirect("~/promovidos/listado.aspx");
            idP.Value = "0";
            Session["idP"] = 0;
            elector.Text = "";
            nombre.Text = "";
            apaterno.Text = "";
            amaterno.Text = "";

            email.Text = "";
            telefono.Text = "";

            municipio.ClearSelection();
            seccional.ClearSelection();
            colonias.ClearSelection();
            calle.ClearSelection();

            numext.Text = "";
            numint.Text = "";
            cp.Text = "";
            buscar.Text = "";

            gBusqueda.DataSourceID = null;
            gBusqueda.DataBind();

            divBus.Visible = true;
            divDatos.Visible = false;
        }

        /// <summary>
        /// EDICION DE DATOS PREVIAMENTE GUARDADOS
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void guardaEdita(object sender, EventArgs e)
        {

            using (SqlConnection con = new SqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {

                SqlCommand cmd = con.CreateCommand();
                cmd.Connection.Open();
                
                SqlTransaction transaction = con.BeginTransaction();
                cmd.Transaction = transaction;

                try
                {
                    //con.Open();
                    String query = "";

                    //EDICION
                    if (Int32.Parse(idP.Value) > 0)
                        query = "UPDATE promovidos set clave_e=@clave,nombre=@nmb,paterno=@ptno,materno=@mtno,seccion=@secc,email=@mail,telefono=@tel,idMunicipio=@idm,nomMunicipio=@mun,colonia=@colonia, " +
                                "calle=@calle,num_ext=@nume,num_int=@numi,cp=@cp, idEstructura = @idEst, estado = @estado, preferencia = @preferencia, entidad = @entidad where idP=@idP;";

                    else
                    {
                        query = "INSERT INTO promovidos(clave_e,nombre,paterno,materno,seccion,email,telefono,idMunicipio,nomMunicipio,colonia,calle,num_ext,num_int,cp,idEstructura,estado,preferencia,entidad) " +
                        "values(@clave,@nmb,@ptno,@mtno,@secc,@mail,@tel,@idm,@mun,@colonia,@calle,@nume,@numi,@cp,@idEst,@estado,@preferencia,@entidad);";                        

                    }

                    //SqlCommand cmd = new SqlCommand(query, con);
                    cmd.CommandText = query;
                    cmd.Parameters.AddWithValue("@idP", idP.Value);
                    cmd.Parameters.AddWithValue("@clave", elector.Text);
                    cmd.Parameters.AddWithValue("@nmb", nombre.Text);
                    cmd.Parameters.AddWithValue("@ptno", apaterno.Text);
                    cmd.Parameters.AddWithValue("@mtno", amaterno.Text);
                    cmd.Parameters.AddWithValue("@secc", seccional.SelectedValue);
                    cmd.Parameters.AddWithValue("@mail", email.Text);
                    cmd.Parameters.AddWithValue("@tel", telefono.Text.Replace("-", "").Replace("(","").Replace(")","").Trim());
                    cmd.Parameters.AddWithValue("@idm", municipio.SelectedValue);
                    cmd.Parameters.AddWithValue("@mun", municipio.SelectedItem.Text);
                    cmd.Parameters.AddWithValue("@colonia", colonias.SelectedValue);
                    cmd.Parameters.AddWithValue("@calle", calle.SelectedValue);
                    cmd.Parameters.AddWithValue("@nume", numext.Text);
                    cmd.Parameters.AddWithValue("@numi", numint.Text);
                    cmd.Parameters.AddWithValue("@cp", cp.Text);
                    cmd.Parameters.AddWithValue("@idEst", estructura.SelectedValue);
                    cmd.Parameters.AddWithValue("@estado", estado.SelectedValue);
                    cmd.Parameters.AddWithValue("@preferencia", preferencia.Text);
                    cmd.Parameters.AddWithValue("@entidad", hentidad.Value);
                    cmd.ExecuteNonQuery();

                    cmd.Parameters.Clear();

                    query = "UPDATE datos15 set promovido=1 where ife=@clave;";
                    cmd.CommandText = query;
                    cmd.Parameters.AddWithValue("@clave", elector.Text.Trim());
                    cmd.ExecuteNonQuery();

                    transaction.Commit();

                    //EDICION
                    if (Int32.Parse(idP.Value) > 0)
                    {
                        ScriptManager.RegisterClientScriptBlock(Page, typeof(string), "myScriptName", "toastExito();", true);
                    }

                    else
                    {
                        idP.Value = "0";
                        elector.Text = "";
                        nombre.Text = "";
                        apaterno.Text = "";
                        amaterno.Text = "";

                        email.Text = "";
                        telefono.Text = "";

                        municipio.ClearSelection();

                        seccional.ClearSelection();
                        colonias.ClearSelection();
                        calle.ClearSelection();

                        numext.Text = "";
                        numint.Text = "";
                        cp.Text = "";

                        buscar.Text = "";

                        gBusqueda.DataSourceID = null;
                        gBusqueda.DataBind();

                        divBus.Visible = true;
                        divDatos.Visible = false;

                        ScriptManager.RegisterClientScriptBlock(Page, typeof(string), "myScriptName", "toastExito();", true);
                        
                        //ClientScript.RegisterStartupScript(GetType(), "JsScript", "<script type='text/javascript'> window.onload = function(){ swal('Correcto!' , 'Información guardada con éxito', 'success');  };   </script>");

                    }
                }
                catch(Exception ex)
                {

                    transaction.Rollback();
                    ScriptManager.RegisterStartupScript(this, GetType(), "abrirModal", " swaError('"+ex.Message.Replace("\r\n", "").Replace("'", "")+"'); ", true);

                }
                finally
                {
                    cmd.Connection.Close();
                }
                
                
            }
        }

        /// <summary>
        /// OBTIENE LAS CALLES PERTENECIENTES A LA COLONIA SELECCIONADA
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void colonias_DataBound(object sender, EventArgs e)
        {
            DsCalle.DataBind();
            calle.DataBind();

            sColonia.Text = hcolonia;
            sCalle.Text = hcalle;

        }

        /// <summary>
        /// OBTIENE LAS COLONIAS Y SECCIONES DEL MUNICIPIO SELECCIONADO
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void municipios_DataBound(object sender, EventArgs e)
        {

            DsSeccional.DataBind();
            seccional.DataBind();

            DsColonias.DataBind();
            colonias.DataBind();

        }

        /// <summary>
        /// BUSCA EN LISTADO SI SE ENCUENTRA EL NOMBRE DE LA PERSONA DESEADA
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void bbuscar_Click(object sender, EventArgs e)
        {
            gBusqueda.DataSourceID = DsBusqueda.ID;
            String search = buscar.Text;
            search = search.Trim();
            search = search.Replace(" ", "~");
            
            DsBusqueda.SelectCommand = "Select top 25 ife as Clave, NOMBRE_COMPLETO AS Nombre, COLONIA as Colonia, (calle+(case(numext) when 'S/N' then ' '+numext else (' # '+numext)end))as calle, m.municipio as Municipio, Cast(fechanac as date) as fechanac, CASE WHEN (promovido=1) THEN 'checked' ELSE '' END as promovido, promovido as promovidoint from datos15 INNER JOIN municipios m on m.idMunicipio = datos15.MUNICIPIO and entidad = " + hentidad.Value+ " WHERE  CONTAINS (NOMBRE_COMPLETO,'*" + search.ToUpper() + "*') ORDER BY NOMBRE, APPATERNO, APMATERNO";
            DsBusqueda.DataBind();
            gBusqueda.DataBind();

            int numero = gBusqueda.Rows.Count;

            if (numero > 0)
            {
                divResultados.Visible = false;
            }
            else
            {
                divResultados.Visible = true;
            }
          
            ScriptManager.RegisterClientScriptBlock(Page, typeof(string), "myScriptName", "cerrarLoading();", true);
            // ClientScript.RegisterStartupScript(GetType(), "JsScript", "<script type='text/javascript'> window.onload = function(){  cerrarLoading(); };   </script>");

        }

        protected void gBusqueda_RowCreated(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
               // System.Diagnostics.Debug.WriteLine("error:" + e.Row.Cells[1].Text);
                e.Row.ToolTip = "Click para seleccionar";   
                e.Row.Attributes["onclick"] = ClientScript.GetPostBackClientHyperlink(this.gBusqueda, "Select$" + e.Row.RowIndex);
            }
        }

        protected void gBusqueda_SelectedIndexChanged(object sender, EventArgs e)
        {

            HttpContext CurrContext = HttpContext.Current;
            var clave = gBusqueda.Rows[gBusqueda.SelectedIndex].Cells[1].Text;
            using (SqlConnection con = new SqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {
                con.Open();
                try
                {
                    string sql = "SELECT IFE,NOMBRE,APPATERNO,APMATERNO,COLONIA,CALLE,MUNICIPIO,SECCION,NUMINT,NUMEXT,PROMOVIDO FROM datos15 WHERE IFE = @clave";
                    SqlCommand cmd = new SqlCommand(sql, con);
                    cmd.Parameters.AddWithValue("@clave", clave.Trim());
                    SqlDataReader rdr = cmd.ExecuteReader();

                    if (rdr.HasRows)
                    {

                        rdr.Read();

                        if (rdr["PROMOVIDO"].ToString() == "0")
                        {
                            divBus.Visible = false;
                            divDatos.Visible = true;
                            elector.Text = rdr["IFE"].ToString();
                            nombre.Text = rdr["NOMBRE"].ToString();
                            apaterno.Text = rdr["APPATERNO"].ToString();
                            amaterno.Text = rdr["APMATERNO"].ToString();
                            municipio.SelectedValue = rdr["MUNICIPIO"].ToString();
                            //seccional.SelectedValue = rdr["SECCION"].ToString();
                            numext.Text = rdr["NUMEXT"].ToString();
                            numint.Text = rdr["NUMINT"].ToString();
                            sColonia.Text = "(" + rdr["COLONIA"].ToString() + ")";
                            sCalle.Text = "(" + rdr["CALLE"].ToString() + ")";

                            hsecc = rdr["SECCION"].ToString();
                            hcolonia = rdr["COLONIA"].ToString();
                            hcalle = rdr["CALLE"].ToString();

                            gBusqueda.DataSourceID = null;
                            gBusqueda.DataBind();

                        }
                        else
                        {
                            ScriptManager.RegisterClientScriptBlock(Page, typeof(string), "myScriptName", "swaError('La persona ya se encuentra registrada como promovida, no es posible seleccionarla');", true);

                        }
                        ScriptManager.RegisterClientScriptBlock(Page, typeof(string), "myScriptName", "cerrarLoading();", true);

                    }

                }
                catch (Exception ex)
                {

                    ScriptManager.RegisterStartupScript(this, GetType(), "abrirModal", "swaError('" + ex.Message.Replace("\r\n", "") + "'); ", true);
                    //ClientScript.RegisterStartupScript(GetType(), "JsScript", "<script type='text/javascript'> window.onload = function(){  cerrarLoading(); };   </script>");
                    con.Close();
                }
            }

        }

        protected void registroManual(object sender, EventArgs e)
        {
           // ScriptManager.RegisterClientScriptBlock(Page, typeof(string), "myScriptName", "mostrarLoading();", true);
            divDatos.Visible = true;
            divBus.Visible = false;
            divResultados.Visible = false;

            gBusqueda.DataSourceID = null;
            gBusqueda.DataBind();
            ScriptManager.RegisterClientScriptBlock(Page, typeof(string), "myScriptName", "cerrarLoading();", true);
        }

        protected void seccional_DataBound(object sender, EventArgs e)
        {
            if(hsecc!=null && hsecc.Length > 0)
            {
                seccional.SelectedValue = hsecc;
                hsecc = null;
            }
        }
    }

}