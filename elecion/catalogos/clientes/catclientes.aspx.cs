using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;
using System.Web.Security;

namespace elecion.catalogos
{
    public partial class catclientes : System.Web.UI.Page
    {
        private int idsucursal;

        protected void Page_Load(object sender, EventArgs e)
        {

            var idu = (FormsIdentity)Page.User.Identity;
            var ticket = idu.Ticket;
            string[] datos = ticket.UserData.Split(',');
            string[] datos2 = datos[1].Split(';');
            
            idsucursal = Convert.ToInt32(datos2[4]);

            if (!IsPostBack)
            {
                
                
            }
            listadoClientes(sender, e);

        }

        protected void listadoClientes(object sender, EventArgs e)
        {
            /*int limit = 12;
            int pag = Convert.ToInt32(pagina.Value);

            int offset = 0;

            if (pag > 1)
            {
                offset = limit * (pag - 1);
            }*/
            try
            {
                 
                lusuarios.DataSourceID = DsUsuarios.ID;

                String query = "SELECT u.idcliente, u.idsucursal, u.ncompleto,  CAST(u.fecharegistro as char)as fecharegistro, u.email, u.telefono, u.celular, "+
                               "CASE WHEN u.activo = 1 THEN 'checked' ELSE '' END as activo, " +
                               "(CONCAT(COALESCE(u.domicilio, ''), ' COL. ', COALESCE(u.colonia, ''), ' - ', COALESCE(u.localidad, ''), ', ', COALESCE(e.entidad, ''))) as domicilio " +
                               "from cliente u " +
                               "left join entidad e on u.identidad = e.identidad "+
                               "where u.idsucursal="+idsucursal+" ";

           
                if (bnombre.Text.Trim() != "")
                    query = query + " and u.ncompleto LIKE '%" + bnombre.Text.Trim().ToUpper() + "%' ";


                //query = query + " LIMIT " + limit + " OFFSET " + offset;
                DsUsuarios.SelectCommand = query;

                DsUsuarios.DataBind();
                lusuarios.DataBind();

                if (String.IsNullOrEmpty(lusuarios.SortExpression)) lusuarios.Sort("ncompleto", SortDirection.Ascending);

            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("ERROR:" + ex.Message.Replace("\r\n", ""));
            }
            
            //ScriptManager.RegisterClientScriptBlock(Page, typeof(string), "myScriptName", "cerrarLoading();", true);
            //gridSeguimiento.DataBind();

        }

        protected void gUsuarios_RowCreated(object sender, GridViewRowEventArgs e)
        {
            /*if (e.Row.RowType == DataControlRowType.DataRow)
            {                
                e.Row.ToolTip = "Click para seleccionar";
                e.Row.Attributes["onclick"] = ClientScript.GetPostBackClientHyperlink(this.gUsuarios, "Select$" + e.Row.RowIndex);
            }*/
        }

        protected void gUsuarios_SelectedIndexChanged(object sender, EventArgs e)
        {
           /* HttpContext CurrContext = HttpContext.Current;
            var valor = gUsuarios.DataKeys[gUsuarios.SelectedIndex].Value;
            String idd = valor.ToString();
            CurrContext.Items.Add("idu", idd);
            Server.Transfer("~/usuarios/usuario.aspx", true);*/
        }


        protected void conteoRegistros(object sender, EventArgs e)
        {
            using (MySqlConnection con2 = new MySqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {
                try
                {
                    con2.Open();
                    string query = "SELECT COUNT(idcliente) as total " +
                                            "FROM cliente " +
                                            "WHERE idsucursal ="+idsucursal+" ";

                    if (bnombre.Text.Trim() != "")
                        query = query + " AND ncompleto LIKE '%" + bnombre.Text.Trim().ToUpper() + "%' ";

                    MySqlCommand cmd2 = new MySqlCommand(query, con2);

                    MySqlDataReader rdr = cmd2.ExecuteReader();
                    if (rdr.HasRows)
                    {
                        rdr.Read();
                        labelConteo.Text = rdr["total"].ToString();

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

        protected void editaRegistro(object sender, EventArgs e)
        {
            Session["idP"] = idP.Value;
            Session["idS"] = idS.Value;
            //Response.RedirectToRoute("EditarUsuarios");
            Response.Redirect("~/catalogos/clientes/agregarcliente.aspx");
        }


        protected void nuevoRegistro(object sender, EventArgs e)
        {
            Session["idP"] = 0;
            Session["idS"] = idS.Value;
            // Response.RedirectToRoute("AgregarUsuarios");
            Response.Redirect("~/catalogos/clientes/agregarcliente.aspx");
        }

   
        protected void refrescaGrid(object sender, EventArgs e)
        {
            DsUsuarios.DataBind();
            lusuarios.DataBind();
        }


        protected void lusuarios_Sorting(object sender, GridViewSortEventArgs e)
        {
            string sort = e.SortDirection.ToString();


            if (sort.Equals("Ascending"))
            {


            }
            else
            {

            }

        }

    }

}