using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using MySql.Data.MySqlClient;

namespace elecion.catalogos.configuracion
{
    public partial class catsucursales : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (String.IsNullOrEmpty(lgastos.SortExpression)) lgastos.Sort("nombre", SortDirection.Ascending);
            }
        }

        protected void conteoRegistros(object sender, EventArgs e)
        {
            DataView dv = (DataView)DsListadoGastos.Select(DataSourceSelectArguments.Empty);
            int numberOfRows = int.Parse(dv.Table.Compute("Count(idsucursal)", "").ToString());

            
            labelConteo.Text = numberOfRows.ToString();
        }

        protected void refrescaGrid(object sender, EventArgs e)
        {
            DsListadoGastos.DataBind();
            lgastos.DataBind();
        }

        protected void guardaEdita(object sender, EventArgs e)
        {
            using (MySqlConnection con = new MySqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {

                int uactivo = 0;
                try
                {

                    con.Open();
                    String query = "";

                    //Si el idmunicipio es mayor que cero se hace UPDATE
                    if (Int32.Parse(idS.Value) > 0)
                        query = "UPDATE sucursal set idtiposucursal=@idtiposucursal, nombre=@nombre, clavecct=@clavecct, calle=@calle, numext=@numext, colonia=@colonia, cp=@cp, telefono=@telefono, activo=@activo, telefono2=@telefono2, localidad=@localidad, encargado=@encargado where idsucursal=@idsucursal;";
                    else
                        query = "INSERT INTO sucursal(idtiposucursal, nombre, clavecct, calle, numext, colonia, cp, telefono, activo, telefono2, localidad, encargado) values(@idtiposucursal, @nombre, @clavecct, @calle, @numext, @colonia, @cp, @telefono, @activo, @telefono2, @localidad, @encargado);";

                    MySqlCommand cmd = new MySqlCommand(query, con);

                   
                    cmd.Parameters.AddWithValue("@idsucursal", idS.Value);
                    cmd.Parameters.AddWithValue("@nombre", nombre.Text.ToUpper().Trim());
                    cmd.Parameters.AddWithValue("@clavecct", clavecct.Text.ToUpper().Trim());
                    cmd.Parameters.AddWithValue("@calle", calle.Text.ToUpper().Trim());
                    cmd.Parameters.AddWithValue("@numext", numext.Text.ToUpper().Trim());
                    cmd.Parameters.AddWithValue("@colonia", colonia.Text.ToUpper().Trim());
                    cmd.Parameters.AddWithValue("@cp", cp.Text.ToUpper().Trim());
                    cmd.Parameters.AddWithValue("@telefono", telefono.Text.Replace("-", "").Replace("(","").Replace(") ","").Trim());
                    cmd.Parameters.AddWithValue("@telefono2", adicional.Text.Replace("-", "").Replace("(", "").Replace(") ", "").Trim());
                    cmd.Parameters.AddWithValue("@localidad", localidad.Text.ToUpper().Trim());
                    cmd.Parameters.AddWithValue("@idtiposucursal", tiposucursal.SelectedValue);
                    cmd.Parameters.AddWithValue("@encargado", encargado.Text.ToUpper().Trim());

                    if (activo.Checked)
                        uactivo = 1;
                    else
                        uactivo = 0;

                    cmd.Parameters.AddWithValue("@activo", uactivo);

                    cmd.ExecuteNonQuery();

                    ScriptManager.RegisterClientScriptBlock(Page, typeof(string), "myScriptName", "cerrarLoading(); ", true);


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
            using (MySqlConnection con = new MySqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {

                try
                {

                    con.Open();
                    String query = "DELETE FROM tipoventa where idtipoventa=@idarea;";
                    MySqlCommand cmd = new MySqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@idarea", idS.Value);
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

        protected void lgastos_Sorting(object sender, GridViewSortEventArgs e)
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