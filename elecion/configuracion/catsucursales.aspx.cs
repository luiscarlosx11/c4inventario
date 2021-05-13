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
                listadoClientes(sender, e);
            }
        }

        protected void conteoRegistros(object sender, EventArgs e)
        {
            DataView dv = (DataView)DsListadoGastos.Select(DataSourceSelectArguments.Empty);
            int numberOfRows = int.Parse(dv.Table.Compute("Count(idsucursal)", "").ToString());

            
            labelConteo.Text = numberOfRows.ToString();
        }


        protected void listadoClientes(object sender, EventArgs e)
        {
            //Convert.ToInt32(this.limite.Value);
            //int pag = 1;
            try
            {

                this.lgastos.DataSourceID = this.DsListadoGastos.ID;
                string query = "select s.idsucursal, s.idcargo, s.nombre, s.clavecct,  s.calle, s.numext, s.colonia, s.cp, s.telefono, s.telefono2, s.localidad, concat(s.calle,' # ', s.numext,' COL. ',s.colonia,' ',coalesce(s.localidad,''))as direccion, t.idtiposucursal, t.tiposucursal, CASE WHEN s.activo=1 THEN 'checked' ELSE '' END as activotext, s.activo, s.encargado "+
                               "from sucursal s "+
                               "left join tiposucursal t on s.idtiposucursal = t.idtiposucursal where s.idsucursal>0 ";

                if (this.bname.Text.Trim() != "")
                {
                    query = string.Concat(new string[] { query, " and (s.nombre LIKE '%", this.bname.Text.Trim().ToUpper(), "%' or s.clavecct LIKE '%", this.bname.Text.Trim().ToUpper(), "%') " });
                }
                              
                if (!btipounidad.SelectedValue.Equals("0"))
                    query += "and t.idtiposucursal=" + btipounidad.SelectedValue + " ";


                query = string.Concat(query, " order by s.nombre");
                this.DsListadoGastos.SelectCommand = query;

                DataView dvAccess = (DataView)DsListadoGastos.Select(DataSourceSelectArguments.Empty);

                if (dvAccess != null && dvAccess.Count > 0)
                {
                    labelConteo.Text = dvAccess.Count.ToString();
                    //divNoRegistros.Visible = false;
                }

                else
                {
                    labelConteo.Text = "0";
                   // divNoRegistros.Visible = true;
                }


            }
            catch (Exception exception)
            {
            }
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
                        query = "UPDATE sucursal set idtiposucursal=@idtiposucursal, nombre=@nombre, clavecct=@clavecct, calle=@calle, numext=@numext, colonia=@colonia, cp=@cp, telefono=@telefono, activo=@activo, telefono2=@telefono2, localidad=@localidad, encargado=@encargado, idcargo=@idcargo where idsucursal=@idsucursal;";
                    else
                        query = "INSERT INTO sucursal(idtiposucursal, nombre, clavecct, calle, numext, colonia, cp, telefono, activo, telefono2, localidad, encargado, idcargo) values(@idtiposucursal, @nombre, @clavecct, @calle, @numext, @colonia, @cp, @telefono, @activo, @telefono2, @localidad, @encargado, @idcargo);";

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

                    cmd.Parameters.AddWithValue("@idcargo", cargo.SelectedValue);

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
                listadoClientes(sender, e);

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

                listadoClientes(sender, e);


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