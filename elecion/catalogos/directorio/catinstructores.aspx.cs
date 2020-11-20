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

namespace elecion.catalogos.directorio
{
    public partial class catinstructores : System.Web.UI.Page
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
                listadoClientes(sender, e);
            }

            //if (bnombre.Text.Trim().)

        }

        protected void listadoClientes(object sender, EventArgs e)
        {
            int limit = Convert.ToInt32(limite.Value);
            int pag = Convert.ToInt32(pagina.Value);

            int offset = 0;

            if (pag > 1)
            {
                offset = limit * (pag - 1);
            }
            try
            {
                 
                lusuarios.DataSourceID = DsUsuarios.ID;

                String query = "select idinstructor, idsucursal, idespecialidad, idescolaridad, nombre, profesion, telefono, telefono2 as celular, email, activo, domicilio, localidad, rfc, curp, cast(fechanacimiento as char) as fechanacimiento, observaciones, " +
                               " case " +
                               " when activo = 1 then 'ACTIVO' " +
                               " else 'INACTIVO' " +
                               " end " +
                               " as activoText, observaciones " +
                               " from instructor " +
                               " where idsucursal = " + idsucursal + " ";
                               
    
           
                if (bname.Text.Trim() != "")
                    query = query + " and nombre LIKE '%" + bname.Text.Trim().ToUpper() + "%' ";


                
                query= query + " order by nombre";

                if (bname.Text.Trim().Equals(""))
                    query = query + " LIMIT " + limit + " OFFSET " + offset;
                DsUsuarios.SelectCommand = query;

                //DsUsuarios.DataBind();
               // lusuarios.DataBind();

                //if (String.IsNullOrEmpty(lusuarios.SortExpression)) lusuarios.Sort("ncompleto", SortDirection.Ascending);

            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("ERROR:" + ex.Message.Replace("\r\n", ""));
            }
            
            //ScriptManager.RegisterClientScriptBlock(Page, typeof(string), "myScriptName", "cerrarLoading();", true);
            //gridSeguimiento.DataBind();

        }

        protected void guardaEdita(object sender, EventArgs e)
        {

            int idinstructor = 0;
            int idempeno = 0;
            int folio = 0;
            int idarticulo = 0;
            int consecutivo = 0;
            int idmovimiento = 0;
            string folioi;
            string tipo;

            using (MySqlConnection con = new MySqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {

                MySqlTransaction transaction = null;
                MySqlDataReader reader = null;

                String query = "";
                int uactivo = 0;

                if (activo.Checked)
                    uactivo = 1;
                else
                    uactivo = 0;

                try
                {

                    con.Open();

                    MySqlCommand cmd = con.CreateCommand();

                    // Start a local transaction
                    transaction = con.BeginTransaction();
                    // Must assign both transaction object and connection
                    // to Command object for a pending local transaction
                    cmd.Connection = con;
                    cmd.Transaction = transaction;

                    //SI EL CLIENTE ES NUEVO SE GUARDA PRIMERO 
                    if (Convert.ToInt32(idP.Value) == 0)
                    {
                        //cmd.Parameters.Clear();
                        cmd.CommandText = "SELECT COALESCE(MAX(idinstructor),0)as idinstructor FROM instructor where idsucursal=" + idsucursal + ";";


                        reader = cmd.ExecuteReader();
                        while (reader.Read())
                        {
                            idinstructor = reader.GetInt32(0) + 1;
                        }
                        reader.Close();

                        


                        cmd.Parameters.Clear();
                        query = "insert into instructor(idsucursal, nombre, idespecialidad, idescolaridad, profesion, activo, rfc, curp, fechanacimiento, domicilio, localidad, email, telefono, telefono2, observaciones) " +
                                             "values(@idsucursal, @nombre, @idespecialidad, @idescolaridad, @profesion, @activo, @rfc, @curp, @fechanacimiento, @domicilio, @localidad, @email, @telefono, @telefono2, @observaciones); ";

                        cmd.CommandText = query;
                        
                        cmd.Parameters.AddWithValue("@idsucursal", idsucursal);
                        cmd.Parameters.AddWithValue("@nombre", nombre.Text.ToUpper().Trim());
                        cmd.Parameters.AddWithValue("@idespecialidad", especialidad.SelectedValue);
                        cmd.Parameters.AddWithValue("@idescolaridad", escolaridad.SelectedValue);
                        cmd.Parameters.AddWithValue("@profesion", profesion.Text.ToUpper().Trim());
                        cmd.Parameters.AddWithValue("@activo", uactivo);
                        cmd.Parameters.AddWithValue("@rfc", rfc.Text.ToUpper().Trim());
                        cmd.Parameters.AddWithValue("@curp", curp.Text.ToUpper().Trim());
                        cmd.Parameters.AddWithValue("@fechanacimiento", fechanacimiento.Text);
                        cmd.Parameters.AddWithValue("@domicilio", domicilio.Text.ToUpper().Trim());
                        cmd.Parameters.AddWithValue("@localidad", localidad.Text.ToUpper().Trim());

                        cmd.Parameters.AddWithValue("@email", email.Text.Replace("-", "").Replace("(", "").Replace(") ", "").Trim());
                        cmd.Parameters.AddWithValue("@telefono", telefono.Text.Replace("-", "").Replace("(", "").Replace(") ", "").Trim());
                        cmd.Parameters.AddWithValue("@telefono2", adicional.Text.Replace("-", "").Replace("(", "").Replace(") ", "").Trim());
                        

                        cmd.Parameters.AddWithValue("@observaciones", observaciones.Text.Trim());
                        
                        cmd.ExecuteNonQuery();
                        

                    }
                    //SI NO SE ACTUALIZAN LOS DATOS DEL CLIENTE
                    else
                    {
                        

                        cmd.Parameters.Clear();
                        query = "update instructor set nombre=@nombre, idespecialidad=@idespecialidad, idescolaridad=@idescolaridad, profesion=@profesion, activo=@activo, rfc=@rfc, curp=@curp, fechanacimiento=@fechanacimiento, domicilio=@domicilio,localidad=@localidad,  " +
                                "email=@email, telefono=@telefono, telefono2=@telefono2, observaciones=@observaciones ";
                        
                        query = query + "where idinstructor=@idinstructor and idsucursal=@idsucursal;";


                        cmd.CommandText = query;
                        cmd.Parameters.AddWithValue("@idinstructor", idP.Value);
                        cmd.Parameters.AddWithValue("@idsucursal", idS.Value);
                        cmd.Parameters.AddWithValue("@nombre", nombre.Text.ToUpper().Trim());
                        cmd.Parameters.AddWithValue("@idespecialidad", especialidad.SelectedValue);
                        cmd.Parameters.AddWithValue("@idescolaridad", escolaridad.SelectedValue);
                        cmd.Parameters.AddWithValue("@profesion", profesion.Text.ToUpper().Trim());
                        cmd.Parameters.AddWithValue("@activo", uactivo);
                        cmd.Parameters.AddWithValue("@rfc", rfc.Text.ToUpper().Trim());
                        cmd.Parameters.AddWithValue("@curp", curp.Text.ToUpper().Trim());
                        cmd.Parameters.AddWithValue("@fechanacimiento", fechanacimiento.Text);
                        cmd.Parameters.AddWithValue("@domicilio", domicilio.Text.ToUpper().Trim());
                        cmd.Parameters.AddWithValue("@localidad", localidad.Text.ToUpper().Trim());

                        cmd.Parameters.AddWithValue("@email", email.Text.Replace("-", "").Replace("(", "").Replace(") ", "").Trim());
                        cmd.Parameters.AddWithValue("@telefono", telefono.Text.Replace("-", "").Replace("(", "").Replace(") ", "").Trim());
                        cmd.Parameters.AddWithValue("@telefono2", adicional.Text.Replace("-", "").Replace("(", "").Replace(") ", "").Trim());


                        cmd.Parameters.AddWithValue("@observaciones", observaciones.Text.Trim());

                        cmd.ExecuteNonQuery();

                    }
                    


                    transaction.Commit();

                    ScriptManager.RegisterClientScriptBlock(Page, typeof(string), "myScriptName", "cerrarLoading();", true);




                }
                catch (Exception ex)
                {
                    transaction.Rollback();
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
                    string query = "SELECT COUNT(idinstructor) as total " +
                                            "FROM instructor " +
                                            "WHERE idsucursal ="+idsucursal+" ";

                    if (bname.Text.Trim() != "")
                        query = query + " AND nombre LIKE '%" + bname.Text.Trim().ToUpper() + "%' ";

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
            Response.Redirect("~/catalogos/directorio/frminstructor.aspx");
        }


        protected void nuevoRegistro(object sender, EventArgs e)
        {
            Session["idP"] = 0;
            Session["idS"] = idS.Value;
            // Response.RedirectToRoute("AgregarUsuarios");
            Response.Redirect("~/catalogos/directorio/frminstructor.aspx");
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