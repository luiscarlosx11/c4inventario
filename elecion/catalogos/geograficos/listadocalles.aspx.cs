using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace elecion.catalogos.geograficos
{
    public partial class listadocalles : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (String.IsNullOrEmpty(lcalles.SortExpression)) lcalles.Sort("calle", SortDirection.Ascending);
                var id = (FormsIdentity)Page.User.Identity;
                var ticket = id.Ticket;
                string[] datos = ticket.UserData.Split(',');
                string[] datos2 = datos[1].Split(';');
                hentidad.Value = datos2[3];

            }
        }

        protected void conteoRegistros(object sender, EventArgs e)
        {
            DataView dv = (DataView)DsListadoCalles.Select(DataSourceSelectArguments.Empty);
            int numberOfRows = int.Parse(dv.Table.Compute("Count(idCalle)", "").ToString());

            labelConteo.Text = numberOfRows.ToString();
        }

        protected void refrescaColonias(object sender, EventArgs e)
        {
            DsColoniasBus.DataBind();
            coloniabus.DataBind();
        }

        protected void refrescaGrid(object sender, EventArgs e)
        {
            DsListadoCalles.DataBind();
            lcalles.DataBind();
        }

        protected void guardaEdita(object sender, EventArgs e)
        {
            using (System.Data.SqlClient.SqlConnection con = new System.Data.SqlClient.SqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {


                try
                {

                    con.Open();
                    String query = "";

                    //System.Diagnostics.Debug.WriteLine("Entrando a guardar editar idcalle:"+ idc.Value+ ", calle:"+calle.Text);

                    //Si el idmunicipio es mayor que cero se hace UPDATE
                    if (Int32.Parse(idc.Value) > 0)
                        query = "UPDATE vialidades set idcolonia=@idcolonia, calle=@calle where idCalle=@idCalle and entidad=@entidad;";
                    else
                        query = "INSERT INTO vialidades(calle,idcolonia,tipo,entidad) values(@calle,@idcolonia,@tipo,@entidad);";

                    SqlCommand cmd = new SqlCommand(query, con);

                    //Update
                    if (Int32.Parse(idc.Value) > 0)
                    {
                        cmd.Parameters.AddWithValue("@idCalle", idc.Value);
                    }

                    else
                    {
                        cmd.Parameters.AddWithValue("@tipo", "calle");
                        
                    }

                    cmd.Parameters.AddWithValue("@entidad", hentidad.Value);
                    cmd.Parameters.AddWithValue("@calle", calle.Text);
                    cmd.Parameters.AddWithValue("@idcolonia", colonia.SelectedValue);

                    /*System.Diagnostics.Debug.WriteLine("idCalle:" + idc.Value);
                    System.Diagnostics.Debug.WriteLine("idcolonia:" + colonia.SelectedValue);
                    System.Diagnostics.Debug.WriteLine("entidad:" + hentidad.Value);*/



                    cmd.ExecuteNonQuery();
                    ScriptManager.RegisterClientScriptBlock(Page, typeof(string), "myScriptName", "cerrarLoading();", true);


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

                //ScriptManager.RegisterStartupScript(this, GetType(), "cerrar", "$('.modal-backdrop').remove();", true);
                refrescaGrid(sender, e);

            }


        }

        protected void borrarRegistro(object sender, EventArgs e)
        {
            using (System.Data.SqlClient.SqlConnection con = new System.Data.SqlClient.SqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {
                
                try
                {

                    con.Open();
                    String query = "DELETE FROM calles where idcalle=@idcalle and entidad=@entidad;";
                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@idcalle", idc.Value);
                    cmd.Parameters.AddWithValue("@entidad", hentidad.Value);
                    cmd.ExecuteNonQuery();

                   
                    ScriptManager.RegisterClientScriptBlock(Page, typeof(string), "myScriptName", "cerrarLoading();", true);


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

        protected void lcalles_Sorting(object sender, GridViewSortEventArgs e)
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