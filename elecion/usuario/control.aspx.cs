using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;

namespace elecion.usuarios
{
    public partial class control : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                listadoClientes(sender, e);
            }

        }


        protected void listadoClientes(object sender, EventArgs e)
        {
           
            try
            {


                this.lusuarios.DataSourceID = this.DsUsuarios.ID;
                string query = "SELECT u.idusuario, (CONCAT(COALESCE(u.nombre,''),' ',COALESCE(u.apaterno,''),' ',COALESCE(u.amaterno,'')))as nombre, u.email, u.telefono,  CASE WHEN u.activo=1 THEN 'checked' ELSE '' END as activo, t.TIPOUSUARIO, s.nombre as sucursal,  " +
                               " (  " +
                               "select GROUP_CONCAT(t.tipousuario) from tipousuario t where FIND_IN_SET(cast(t.idtipousuario as char), replace(u.roles, '|', ','))  " +
                               ") as rol  " +
                               "from usuario u  " +
                               "left join tipousuario t on u.idtipousuario = t.idtipousuario  " +
                                "left join sucursal s on s.idsucursal = u.idsucursal where u.idusuario>0 ";

                if (this.bname.Text.Trim() != "")
                {
                    query = string.Concat(new string[] { query, " and CONCAT(COALESCE(u.nombre,''),' ',COALESCE(u.apaterno,''),' ',COALESCE(u.amaterno,'')) LIKE '%", this.bname.Text.Trim().ToUpper(), "%' " });
                }
                if (!this.bplantel.SelectedValue.Equals("0"))
                {
                    query = string.Concat(query, " and u.idsucursal = ", this.bplantel.SelectedValue, " ");
                }



                query = string.Concat(query, " order by sucursal, u.nombre");
                this.DsUsuarios.SelectCommand = query;

                DataView dvAccess = (DataView)DsUsuarios.Select(DataSourceSelectArguments.Empty);

                if (dvAccess != null && dvAccess.Count > 0)
                {
                    labelConteo.Text = dvAccess.Count.ToString();
                    //divNoRegistros.Visible = false;
                }

                else
                {
                    labelConteo.Text = "0";
                    //divNoRegistros.Visible = true;
                }


            }
            catch (Exception exception)
            {
            }
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
            DataView dv = (DataView)DsUsuarios.Select(DataSourceSelectArguments.Empty);
            int numberOfRows = int.Parse(dv.Table.Compute("Count(idusuario)", "").ToString());

            labelConteo.Text = numberOfRows.ToString();
        }

        protected void editaRegistro(object sender, EventArgs e)
        {
            Session["idP"] = idP.Value;
            Response.RedirectToRoute("EditarUsuarios");
            //Response.Redirect("~/usuarios/");
        }


        protected void nuevoRegistro(object sender, EventArgs e)
        {
            Session["idP"] = 0;
            Response.RedirectToRoute("AgregarUsuarios");
        }

        protected void borrarRegistro(object sender, EventArgs e)
        {
            using (MySqlConnection con = new MySqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {

                try
                {

                    con.Open();
                    String query = "DELETE FROM usuario where id=@id;";
                    MySqlCommand cmd = new MySqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@id", idP.Value);
                    cmd.ExecuteNonQuery();


                }
                catch (Exception ex)
                {
                    System.Diagnostics.Debug.WriteLine("error:" + ex.ToString());
                    Console.WriteLine("error:" + ex.ToString());
                }
                finally
                {
                    con.Close();
                }

                refrescaGrid(sender, e);


            }


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