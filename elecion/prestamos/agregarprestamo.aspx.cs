using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;
using System.Net.Mail;
using System.Net.Mail;
using System.Net;
using System.Threading;
using System.IO;

namespace elecion.tickets
{
    public partial class agregarprestamo : System.Web.UI.Page
    {
        static string ide;
        private static int id;
        int idusuario;
        private static int idsucursal;
        private static int idprestamo;
        private string sucursalnombre;

        protected void Page_Load(object sender, EventArgs e)
        {
            var idu = (FormsIdentity)Page.User.Identity;
            var ticket = idu.Ticket;
            string[] datos = ticket.UserData.Split(',');
            string[] datos2 = datos[1].Split(';');

            idusuario = Convert.ToInt32(datos[0]); 
            idsucursal = Convert.ToInt32(datos2[4]);
            sucursalnombre = datos2[5].ToString();
            idS.Value = idsucursal.ToString();

            if (!bnombre.Text.Equals(""))
            {
                listadoClientes(sender, e);
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "abrirModal();", true);
            }else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "cerrarModal();", true);
            }
            
            

            if (!IsPostBack)
            {
                String idProm = "";


                try
                {
                    idProm = Session["idP"].ToString();
                    idprestamo = Convert.ToInt32(idProm);   
                    if(idprestamo>0)                 
                        getEmpeno(idprestamo);
                                                         
                    getConfiguracion(sender, e);
                    //Session.Remove("idP");
                    //ScriptManager.RegisterStartupScript(this, GetType(), "abrirModal", "window.onload = function(){ $(document).prop('title', 'PLACEL - Editar Usuario'); };", true);
                }
                catch
                {

                }


            }

            
            //getCliente(sender, e);

        }

        protected void categoriasDataBound(object sender, EventArgs e)
        {
            Dssubcategorias.DataBind();
            subcategorias.DataBind();

        }
        protected void conteoRegistros(object sender, EventArgs e)
        {
           /* DataView dv = (DataView)DsUsuarios.Select(DataSourceSelectArguments.Empty);
            int numberOfRows = int.Parse(dv.Table.Compute("Count(idusuario)", "").ToString());

            labelConteo.Text = numberOfRows.ToString();*/
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

                String query = "SELECT u.idcliente, u.idsucursal, u.ncompleto,  CAST(u.fecharegistro as char)as fecharegistro, u.email, u.telefono, u.celular, " +
                               "CASE WHEN u.activo = 1 THEN 'checked' ELSE '' END as activo, " +
                               "(CONCAT(COALESCE(u.domicilio, ''), ' COL. ', COALESCE(u.colonia, ''), ' - ', COALESCE(u.localidad, ''), ', ', COALESCE(e.entidad, ''))) as domicilio " +
                               "from cliente u " +
                               "left join entidad e on u.identidad = e.identidad "+
                               "where u.idsucursal ="+idS.Value+" ";


                if (bnombre.Text.Trim() != "")
                    query = query + " and u.ncompleto LIKE '%" + bnombre.Text.Trim().ToUpper() + "%' ";


                //query = query + " LIMIT " + limit + " OFFSET " + offset;
                DsUsuarios.SelectCommand = query;

                DsUsuarios.DataBind();
                lusuarios.DataBind();

               

                ScriptManager.RegisterClientScriptBlock(Page, typeof(string), "myScriptName", "cerrarLoading();", true);

                //if (String.IsNullOrEmpty(lusuarios.SortExpression)) lusuarios.Sort("ncompleto", SortDirection.Ascending);

            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("ERROR:" + ex.Message.Replace("\r\n", ""));
            }

            //ScriptManager.RegisterClientScriptBlock(Page, typeof(string), "myScriptName", "cerrarLoading();", true);
            //gridSeguimiento.DataBind();

        }

        protected void volverListado(object sender, EventArgs e)
        {
           // ScriptManager.RegisterClientScriptBlock(Page, typeof(string), "myScriptName", "window.open('listadoprestamos.aspx','_self');", true);

            Response.Redirect("~/prestamos/listadoprestamos.aspx");
            //Response.RedirectToRoute("Usuarios");
        }


        protected void getEmpeno(int idprestamo)
        {

            using (MySqlConnection con = new MySqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {
                try
                {
                    con.Open();
                    string sql ="select e.idempeno, e.idsucursal, e.idempenoorigen, e.idsucursalorigen, e.idarticulo, e.folio, coalesce(e.idplazo,0)as idplazo, coalesce(e.idconfiguracion,0) as idconfiguracion, "+
                                "cast(e.fechaempeno as char)as fechaempeno, cast(e.horaempeno as char)as horaempeno, cast(e.fecharefrendo as char)as fecharefrendo, cast(e.horarefrendo as char)as horarefrendo, "+
                                "cast(e.fechaenajenacion as char)as fechaenajenacion, cast(e.horaenajenacion as char)as horaenajenacion, cast(e.fechaapartado as char)as fechaapartado, cast(e.horaapartado as char)as horaapartado, cast(e.fechaventa as char)as fechaventa, cast(e.horaventa as char)as horaventa,  " +
                                "e.prestamo, e.avaluo, e.precio, e.preciominimo, e.cotitular,  " +
                                "a.idarticulo, a.idcategoria, a.idsubcategoria, a.descripcion, a.foto as fotoa, " +
                                "c.idcliente, c.clave, c.ncompleto, c.foto as fotoc, c.domicilio, c.colonia, c.identidad, c.localidad, c.cp, c.email, c.telefono, c.celular, c.observaciones " +
                                "from empeno e " +
                                "left join articulo a on a.idarticulo = e.idarticulo and a.idsucursal = e.idsucursal " +
                                "left join cliente c on c.idcliente = e.idcliente and e.idsucursal = c.idsucursal " +
                                "where e.idempeno = "+idprestamo+" and e.idsucursal = "+idsucursal+";";


                    MySqlCommand cmd = new MySqlCommand(sql, con);
                    

                    MySqlDataReader rdr = cmd.ExecuteReader();
                    if (rdr.HasRows)
                    {
                        rdr.Read();

                        //Llaves
                        idP.Value = rdr["idempeno"].ToString();                        
                        idS.Value = rdr["idsucursal"].ToString();
                        idA.Value = rdr["idarticulo"].ToString();
                        idC.Value = rdr["idcliente"].ToString();
                        idPlz.Value = rdr["idplazo"].ToString();
                        idCfg.Value = rdr["idconfiguracion"].ToString();

                        //Datos de la boleta
                        folio.Text = rdr["folio"].ToString();
                        fempeno.Text = "Empeñado desde "+ rdr["fechaempeno"].ToString() + " a las "+ rdr["horaempeno"].ToString()+ " hrs.";

                        if(!rdr["fecharefrendo"].ToString().Equals(""))
                            frefrendo.Text = "Último refrendo en " + rdr["fecharefrendo"].ToString() + " a las " + rdr["horarefrendo"].ToString() + " hrs.";

                        if (!rdr["fechaenajenacion"].ToString().Equals(""))
                            fenajenado.Text = "Enajenado en " + rdr["fechaenajenacion"].ToString() + " a las " + rdr["horaenajenacion"].ToString() + " hrs.";

                        if (!rdr["fechaventa"].ToString().Equals(""))
                            fventa.Text = "Vendido en " + rdr["fechaventa"].ToString() + " a las " + rdr["horaventa"].ToString() + " hrs.";

                        //Datos del cliente                       
                        clave.Text = rdr["clave"].ToString();
                        nombre.Text = rdr["ncompleto"].ToString();
                        calle.Text = rdr["domicilio"].ToString();
                        colonia.Text = rdr["colonia"].ToString();
                        cp.Text = rdr["cp"].ToString();
                        entidad.SelectedValue = rdr["identidad"].ToString();
                        localidad.Text = rdr["localidad"].ToString();
                        email.Text = rdr["email"].ToString();
                        telefono.Text = rdr["telefono"].ToString();
                        celular.Text = rdr["celular"].ToString();
                        observaciones.Text = rdr["observaciones"].ToString();
                        if (rdr["fotoc"].GetType() != typeof(DBNull))
                        {
                            Byte[] ImageByte = (Byte[])(rdr["fotoc"]);

                            fotopa.ImageUrl = "data:image/jpeg;base64," + Convert.ToBase64String(ImageByte);
                            fotopa.DataBind();
                        }


                        //Datos del articulo
                        descripcion.Text = rdr["descripcion"].ToString();
                        categorias.SelectedValue = rdr["idcategoria"].ToString();
                        subcategorias.SelectedValue = rdr["idsubcategoria"].ToString();
                        prestamo.Text = rdr["prestamo"].ToString();
                        reem.Text = rdr["avaluo"].ToString();
                        precio.Text = rdr["precio"].ToString();
                        cotitular.Text = rdr["cotitular"].ToString();

                        if (rdr["fotoa"].GetType() != typeof(DBNull))
                        {
                            Byte[] ImageBytea = (Byte[])(rdr["fotoa"]);
                            fotoarticulo.ImageUrl = "data:image/jpeg;base64," + Convert.ToBase64String(ImageBytea);
                            fotoarticulo.DataBind();

                        }

                        clave.Enabled = false;
                        nombre.Enabled = false;
                        calle.Enabled = false;
                        colonia.Enabled = false;
                        cp.Enabled = false;
                        entidad.Enabled = false;
                        localidad.Enabled = false;
                        email.Enabled = false;
                        telefono.Enabled = false;
                        celular.Enabled = false;
                        observaciones.Enabled = false;


                        descripcion.Enabled = false;
                        categorias.Enabled = false;
                        subcategorias.Enabled = false;
                        prestamo.Enabled = false;
                        cotitular.Enabled = false;


                        BBbuscarcliente.Visible = false;
                        BBguardar.Visible = false;

                        BBfoto.Visible = false;
                        BBfotoarticulo.Visible= false;


                    }

                    ScriptManager.RegisterClientScriptBlock(Page, typeof(string), "myScriptName", "cerrarLoading();", true);
                    /*byte[] bytes = (byte[])GetData("SELECT foto FROM cliente WHERE idcliente =" + idUser).Rows[0]["foto"];
                    string base64String = Convert.ToBase64String(bytes, 0, bytes.Length);
                    fotopa.ImageUrl = "data:image/png;base64," + base64String;*/
                    //area.Enabled = false;


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

        protected void getCliente(object sender, EventArgs e)
        {
            
            using (MySqlConnection con = new MySqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {
                try
                {
                    con.Open();
                    string sql = "select idcliente, clave, CAST(fecharegistro as char)as fecharegistro, " +
                                 "ncompleto, foto, " +
                                 "domicilio, colonia, identidad, localidad, cp, email, telefono, celular, observaciones " +
                                 "from cliente " +
                                 "where idcliente=@idP and idsucursal=@idS ";


                    MySqlCommand cmd = new MySqlCommand(sql, con);
                    cmd.Parameters.AddWithValue("@idP", idC.Value);
                    cmd.Parameters.AddWithValue("@idS", idS.Value);

                    MySqlDataReader rdr = cmd.ExecuteReader();
                    if (rdr.HasRows)
                    {
                        rdr.Read();
                       
                        idC.Value = rdr["idcliente"].ToString();
                        // usuario.Text = rdr["login"].ToString();
                        // pass.Text = rdr["pass"].ToString();

                        clave.Text = rdr["clave"].ToString();
                        nombre.Text = rdr["ncompleto"].ToString();
                        // apaterno.Text = rdr["apaterno"].ToString();
                        //amaterno.Text = rdr["amaterno"].ToString();

                        calle.Text = rdr["domicilio"].ToString();
                        colonia.Text = rdr["colonia"].ToString();
                        cp.Text = rdr["cp"].ToString();
                        entidad.SelectedValue = rdr["identidad"].ToString();
                        localidad.Text = rdr["localidad"].ToString();

                        email.Text = rdr["email"].ToString();
                        telefono.Text = rdr["telefono"].ToString();
                        celular.Text = rdr["celular"].ToString();

                        observaciones.Text = rdr["observaciones"].ToString();


                        // if (rdr["activo"].ToString()=="1") 
                        //  activo.Checked = true;


                        if (rdr["foto"] != null)
                        {
                            Byte[] ImageByte = (Byte[])(rdr["foto"]);


                            if (ImageByte != null)
                            {
                                // You need to convert it in bitmap to display the imgage
                                fotopa.ImageUrl = "data:image/jpeg;base64," + Convert.ToBase64String(ImageByte);
                                fotopa.DataBind();

                            }
                        }


                    }

                    ScriptManager.RegisterClientScriptBlock(Page, typeof(string), "myScriptName", "cerrarLoading();", true);
                    /*byte[] bytes = (byte[])GetData("SELECT foto FROM cliente WHERE idcliente =" + idUser).Rows[0]["foto"];
                    string base64String = Convert.ToBase64String(bytes, 0, bytes.Length);
                    fotopa.ImageUrl = "data:image/png;base64," + base64String;*/
                    //area.Enabled = false;


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


        protected void getConfiguracion(object sender, EventArgs e)
        {

            using (MySqlConnection con = new MySqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {
                try
                {
                    con.Open();
                    string sql = "select diasventa, diastolerancia, interesdiario, diasapartado, idconfiguracion, porcentajeavaluo, porcentajeventa from configuracion";

                    if (!idCfg.Value.Equals("0"))
                        sql = sql + " where idconfiguracion=" + idCfg.Value;
                    else
                        sql = sql + " where activa=1";

                    MySqlCommand cmd = new MySqlCommand(sql, con);


                    MySqlDataReader rdr = cmd.ExecuteReader();
                    if (rdr.HasRows)
                    {
                        rdr.Read();
                        idCfg.Value = rdr["idconfiguracion"].ToString();
                        dventa.Value = rdr["diasventa"].ToString();
                        dtolerancia.Value = rdr["diastolerancia"].ToString();
                        dapartado.Value = rdr["diasapartado"].ToString();
                        idiario.Value = rdr["interesdiario"].ToString();
                        porcavaluo.Value = rdr["porcentajeavaluo"].ToString();
                        porcventa.Value = rdr["porcentajeventa"].ToString();

                    }

                    rdr.Close();

                    
                    sql = "select idplazo, nombre from plazoempeno";

                    if (!idPlz.Value.Equals("0"))
                        sql = sql + " where idplazo=" + idPlz.Value;
                    else
                        sql = sql + " where activo=1";

                    MySqlCommand cmd2 = new MySqlCommand(sql, con);

                    MySqlDataReader rdr2 = cmd2.ExecuteReader();
                    if (rdr2.HasRows)
                    {
                        rdr2.Read();

                        idPlz.Value = rdr2["idplazo"].ToString();                       

                    }

                    rdr2.Close();

                    reem.Attributes.Add("readonly", "readonly");
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
        

        protected void guardaEdita(object sender, EventArgs e)
        {

            int idcliente = 0;
            int idempeno = 0;
            int folio = 0;
            int idarticulo = 0;
            int consecutivo = 0;
            string folioi;
            string tipo;

            using (MySqlConnection con = new MySqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {

                MySqlTransaction transaction = null;
                MySqlDataReader reader = null;

                String query = "";
                int exito = 0;             

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
                    if (Convert.ToInt32(idC.Value) == 0)
                    {
                        //cmd.Parameters.Clear();
                        cmd.CommandText = "SELECT COALESCE(MAX(idcliente),0)as idcliente FROM cliente where idsucursal=" + idS.Value + ";";


                        reader = cmd.ExecuteReader();
                        while (reader.Read())
                        {
                            idcliente = reader.GetInt32(0) + 1;
                        }
                        reader.Close();

                        cmd.Parameters.Clear();
                        query = "insert into cliente(idcliente, idsucursal, clave, ncompleto, domicilio, colonia, cp, localidad, identidad, email, telefono, celular, observaciones, foto, activo) "+
                                             "values(@idcliente, @idsucursal, @clave, @ncompleto, @domicilio, @colonia, @cp, @localidad, @identidad, @email, @telefono, @celular, @observaciones, @foto, 1); ";

                        cmd.CommandText = query;
                        cmd.Parameters.AddWithValue("@idcliente", idcliente);
                        cmd.Parameters.AddWithValue("@idsucursal", idS.Value);
                        cmd.Parameters.AddWithValue("@clave", clave.Text.ToUpper());
                        cmd.Parameters.AddWithValue("@ncompleto", nombre.Text.ToUpper());
                        cmd.Parameters.AddWithValue("@domicilio", calle.Text.ToUpper());
                        cmd.Parameters.AddWithValue("@colonia", colonia.Text.ToUpper());
                        cmd.Parameters.AddWithValue("@cp", cp.Text);
                        cmd.Parameters.AddWithValue("@localidad", localidad.Text.ToUpper());
                        cmd.Parameters.AddWithValue("@identidad", entidad.SelectedValue);
                        cmd.Parameters.AddWithValue("@email", email.Text);
                        cmd.Parameters.AddWithValue("@telefono", telefono.Text);
                        cmd.Parameters.AddWithValue("@celular", celular.Text);
                        cmd.Parameters.AddWithValue("@observaciones", observaciones.Text);


                        cmd.Parameters.Add("@foto", MySqlDbType.Blob);
                        Stream fs = Bfoto.PostedFile.InputStream;
                        BinaryReader br = new BinaryReader(fs);
                        byte[] bytes = br.ReadBytes((Int32)fs.Length);
                        cmd.Parameters["@foto"].Value = bytes;
                        cmd.ExecuteNonQuery();

                        idC.Value = idcliente.ToString();

                    }
                    //SI NO SE ACTUALIZAN LOS DATOS DEL CLIENTE
                    else
                    {
                        Stream fs = Bfoto.PostedFile.InputStream;

                        cmd.Parameters.Clear();
                        query = "update cliente set clave=@clave, ncompleto=@ncompleto, domicilio=@domicilio, colonia=@colonia, cp=@cp, localidad=@localidad, identidad=@identidad, " +
                                "email=@email, telefono=@telefono, celular=@celular, observaciones=@observaciones ";


                        if (fs.Length > 0)
                            query = query + ",foto = @foto ";

                         query = query + "where idcliente=@idcliente and idsucursal=@idsucursal;";
                                            

                        cmd.CommandText = query;
                        cmd.Parameters.AddWithValue("@idcliente", idC.Value);
                        cmd.Parameters.AddWithValue("@idsucursal", idS.Value);
                        cmd.Parameters.AddWithValue("@clave", clave.Text.ToUpper());
                        cmd.Parameters.AddWithValue("@ncompleto", nombre.Text.ToUpper());
                        cmd.Parameters.AddWithValue("@domicilio", calle.Text.ToUpper());
                        cmd.Parameters.AddWithValue("@colonia", colonia.Text.ToUpper());
                        cmd.Parameters.AddWithValue("@cp", cp.Text);
                        cmd.Parameters.AddWithValue("@localidad", localidad.Text.ToUpper());
                        cmd.Parameters.AddWithValue("@identidad", entidad.SelectedValue);
                        cmd.Parameters.AddWithValue("@email", email.Text);
                        cmd.Parameters.AddWithValue("@telefono", telefono.Text);
                        cmd.Parameters.AddWithValue("@celular", celular.Text);
                        cmd.Parameters.AddWithValue("@observaciones", observaciones.Text);


                        cmd.Parameters.Add("@foto", MySqlDbType.Blob);
                        
                        BinaryReader br = new BinaryReader(fs);
                        byte[] bytes = br.ReadBytes((Int32)fs.Length);
                        cmd.Parameters["@foto"].Value = bytes;
                        cmd.ExecuteNonQuery();

                    }


                    //SI ES UNA INSERCION SE GUARDA PRIMERO EL ARTICULO
                    if (Convert.ToInt32(idP.Value) == 0)
                    {
                        cmd.Parameters.Clear();
                        cmd.CommandText = "SELECT COALESCE(MAX(idarticulo),0)as idarticulo FROM articulo where idsucursal=" + idS.Value + ";";


                        reader = cmd.ExecuteReader();
                        while (reader.Read())
                        {
                            idarticulo = reader.GetInt32(0) + 1;
                        }
                        reader.Close();

                        cmd.Parameters.Clear();
                        query = "insert into articulo(idarticulo, idsucursal, idcategoria, idsubcategoria, descripcion, foto) " +
                                             "values(@idarticulo, @idsucursal, @idcategoria, @idsubcategoria, @descripcion, @foto); ";

                        cmd.CommandText = query;
                        cmd.Parameters.AddWithValue("@idarticulo", idarticulo);
                        cmd.Parameters.AddWithValue("@idsucursal", idS.Value);
                        cmd.Parameters.AddWithValue("@idcategoria", categorias.SelectedValue);
                        cmd.Parameters.AddWithValue("@idsubcategoria", subcategorias.SelectedValue);
                        cmd.Parameters.AddWithValue("@descripcion", descripcion.Text.ToUpper());

                        cmd.Parameters.Add("@foto", MySqlDbType.Blob);
                        Stream fs = Bfotoarticulo.PostedFile.InputStream;
                        BinaryReader br = new BinaryReader(fs);
                        byte[] bytes = br.ReadBytes((Int32)fs.Length);
                        cmd.Parameters["@foto"].Value = bytes;
                        cmd.ExecuteNonQuery();

                        idA.Value = idarticulo.ToString();

                        //Y DESPUES EL EMPENO
                        cmd.Parameters.Clear();
                        cmd.CommandText = "SELECT COALESCE(MAX(idempeno),0)as idempeno FROM empeno where idsucursal=" + idS.Value + " ;";


                        reader = cmd.ExecuteReader();
                        while (reader.Read())
                        {
                            idempeno = reader.GetInt32(0) + 1;
                        }
                        reader.Close();


                        cmd.Parameters.Clear();
                        cmd.CommandText = "SELECT COALESCE(MAX(folioaux),0)as idempeno FROM empeno where idsucursal=" + idS.Value + " ;";


                        reader = cmd.ExecuteReader();
                        while (reader.Read())
                        {
                            folio = reader.GetInt32(0) + 1;
                        }
                        reader.Close();

                        //SI SON VEHICULOS O JOYERIA SE SACA EL FOLIO CONSECUTIVO
                        if (Convert.ToInt32(categorias.SelectedValue) == 4 || Convert.ToInt32(categorias.SelectedValue) == 6)
                        {
                            tipo = "E";
                            cmd.Parameters.Clear();
                            cmd.CommandText = "SELECT COALESCE((consecutivo),0)as consecutivo FROM empeno where idsucursal="+idS.Value+" order by idempeno desc limit 1";
                           

                            reader = cmd.ExecuteReader();
                            while (reader.Read())
                            {
                                consecutivo = reader.GetInt32(0) + 1;
                            }
                            reader.Close();
                        }else
                        {
                            consecutivo = 0;
                            tipo = "N";
                        }

                        if(tipo.Equals("N"))
                            folioi = folio.ToString() + " " + sucursalnombre;
                        else
                        {
                            folio = folio - 1;
                            //SE FORMA EL FOLIO
                            //if (consecutivo == 0)
                            //    folioi = folio.ToString() + " " + sucursalnombre;
                            //else
                            folioi = folio.ToString() + "." + consecutivo + " " + sucursalnombre;

                        }
                        

                        cmd.Parameters.Clear();
                      

                        query = "insert into empeno(idempeno, idsucursal, idcliente, idarticulo, idsucursalorigen, idempenoorigen, consecutivo, folio, fechaempeno, horaempeno, prestamo, avaluo, precio, etapa, tipo, folioaux, cotitular, idplazo, idconfiguracion, diasventa, diastolerancia, diasapartado, interesdiario, porcentajeavaluo, porcentajeventa, fechainicia, fechavence, codigo) " +
                                            "values(@idempeno, @idsucursal, @idcliente, @idarticulo, @idsucursalorigen, @idempenoorigen, @consecutivo, @folio,  current_date, current_time, @prestamo, @avaluo, @precio, 'PRESTAMO', @tipo, @folioaux, @cotitular, @idplazo, @idconfiguracion, @diasventa, @diastolerancia, @diasapartado, @interesdiario, @porcentajeavaluo, @porcentajeventa, current_date, ADDDATE(current_date, INTERVAL @diasventa DAY), @codigo); ";

                        cmd.CommandText = query;
                        cmd.Parameters.AddWithValue("@idempeno", idempeno);
                        cmd.Parameters.AddWithValue("@idcliente", idC.Value);
                        cmd.Parameters.AddWithValue("@idarticulo", idarticulo);
                        cmd.Parameters.AddWithValue("@idsucursal", idS.Value);

                        cmd.Parameters.AddWithValue("@idsucursalorigen", idS.Value);
                        cmd.Parameters.AddWithValue("@idempenoorigen", idempeno);

                        cmd.Parameters.AddWithValue("@consecutivo", consecutivo);
                        cmd.Parameters.AddWithValue("@folio", folioi);
                        cmd.Parameters.AddWithValue("@prestamo", prestamo.Text);
                        cmd.Parameters.AddWithValue("@avaluo", reem.Text);
                        cmd.Parameters.AddWithValue("@precio", precio.Text);
                        cmd.Parameters.AddWithValue("@tipo", tipo);
                        cmd.Parameters.AddWithValue("@folioaux", folio);
                        cmd.Parameters.AddWithValue("@cotitular", cotitular.Text);
                        cmd.Parameters.AddWithValue("@idplazo", idPlz.Value);
                        cmd.Parameters.AddWithValue("@idconfiguracion", idCfg.Value);
                        cmd.Parameters.AddWithValue("@diasventa", dventa.Value);
                        cmd.Parameters.AddWithValue("@diastolerancia", dtolerancia.Value);
                        cmd.Parameters.AddWithValue("@diasapartado", dapartado.Value);
                        cmd.Parameters.AddWithValue("@interesdiario", idiario.Value);
                        cmd.Parameters.AddWithValue("@porcentajeavaluo", porcavaluo.Value);
                        cmd.Parameters.AddWithValue("@porcentajeventa", porcventa.Value);

                        cmd.Parameters.AddWithValue("@codigo", idempeno.ToString() + idS.Value + idarticulo.ToString() + idC.Value + idempeno.ToString() + idS.Value + consecutivo.ToString() );

                        cmd.ExecuteNonQuery();                                             


                    }
                    //SE HACE UPDATE 
                    else
                    {
                        //PRIMERO EL ARTICULO
                        cmd.Parameters.Clear();
                        query = "update articulo set idcategoria=@idcategoria, idsubcategoria=@idsubcategoria, descripcion=@descripcion, foto=@foto where idarticulo=@idarticulo and idsucursal=@idsucursal;";

                        cmd.CommandText = query;
                        cmd.Parameters.AddWithValue("@idarticulo", idA.Value);
                        cmd.Parameters.AddWithValue("@idsucursal", idS.Value);
                        cmd.Parameters.AddWithValue("@idcategoria", categorias.SelectedValue);
                        cmd.Parameters.AddWithValue("@idsubcategoria", subcategorias.SelectedValue);
                        cmd.Parameters.AddWithValue("@descripcion", descripcion.Text.ToUpper());

                        cmd.Parameters.Add("@foto", MySqlDbType.Blob);
                        Stream fs = Bfotoarticulo.PostedFile.InputStream;
                        BinaryReader br = new BinaryReader(fs);
                        byte[] bytes = br.ReadBytes((Int32)fs.Length);
                        cmd.Parameters["@foto"].Value = bytes;
                        cmd.ExecuteNonQuery();


                        //LUEGO EL EMPEÑO
                        cmd.Parameters.Clear();
                        query = "update empeno set idcliente=@idcliente, prestamo=@prestamo, avaluo=@avaluo, precio=@precio where idempeno=@idempeno and idsucursal=@idsucursal; ";

                        cmd.CommandText = query;
                        cmd.Parameters.AddWithValue("@idempeno", idP.Value);
                        cmd.Parameters.AddWithValue("@idsucursal", idS.Value);                                          
                        cmd.Parameters.AddWithValue("@prestamo", prestamo.Text);
                        cmd.Parameters.AddWithValue("@avaluo", reem.Text);
                        cmd.Parameters.AddWithValue("@precio", precio.Text);

                        cmd.ExecuteNonQuery();

                    }


                    transaction.Commit();
                    //ScriptManager.RegisterClientScriptBlock(Page, typeof(string), "myScriptName", "cerrarLoading();", true);

                    String url = "../reportes/RVBoleta.aspx?idempeno=" + idempeno + "&idsucursal=" + idS.Value;
                    //ScriptManager.RegisterStartupScript(this, GetType(), "myScriptName", "alert('aaaad');", true);
                    ScriptManager.RegisterClientScriptBlock(this, typeof(string), "myScriptName", " window.open('" + url + "','_blank'); window.open('listadoprestamos.aspx','_self');", true);
                    
                    //volverListado(sender, e);

                   


                }
                catch (Exception ex)
                {
                    //transaction.Rollback();
                    System.Diagnostics.Debug.WriteLine("error:" + ex.ToString());
                    Console.WriteLine("error:" + ex.ToString());
                }
                finally
                {
                    con.Close();
                    //if(exito==1)
                        //volverListado(sender, e);
                }

                //ScriptManager.RegisterStartupScript(this, GetType(), "cerrar", "$('.modal-backdrop').remove();", true);
               // refrescaGrid(sender, e);

            }


        }


    }
}