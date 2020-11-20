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
using Telerik.Reporting.Processing;


namespace elecion.inscripcion2
{
    public partial class frminscripcion : System.Web.UI.Page
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
            //diassemana.SelectedValue = hdias.Value;
            ScriptManager.RegisterStartupScript(this, GetType(), "actu", "dar(); ", true);
        }

        protected void listadoAlumnosBus(object sender, EventArgs e)
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

                GVlistaalumnos.DataSourceID = DSlistaalumnos.ID;

                String query = "select idalumno, nocontrol, concat(apaterno,' ',amaterno,' ',nombre)as ncompleto, sexo, fechanacimiento " +
                                "from alumno " +
                                "where idalumno not in " +
                                "( " +
                                "select idalumno " +
                                "from solicitudinscripcion " +
                                "where idcurso = "+idP.Value+" " +
                                ") ";
                                


                if (bnombre.Text.Trim() != "")
                    query = query + " and concat(apaterno,' ',amaterno,' ',nombre) LIKE '%" + bnombre.Text.Trim().ToUpper() + "%' ";



                query = query + " order by apaterno, amaterno, nombre";
                //query = query + " LIMIT " + limit + " OFFSET " + offset;
                DSlistaalumnos.SelectCommand = query;

                DSlistaalumnos.DataBind();
                GVlistaalumnos.DataBind();

                int numero = GVlistaalumnos.Rows.Count;


                if (numero > 0)
                {
                    // ScriptManager.RegisterClientScriptBlock(this, typeof(string), "myScriptName", " $('#divResultados').hide(); cerrarLoading();", true);
                    divResultados.Visible = false;
                }

                else
                {
                    // ScriptManager.RegisterClientScriptBlock(this, typeof(string), "myScriptName", " $('#divResultados').show(); cerrarLoading();", true);
                    divResultados.Visible = true;
                }


                //if (String.IsNullOrEmpty(lusuarios.SortExpression)) lusuarios.Sort("ncompleto", SortDirection.Ascending);

                //ScriptManager.RegisterClientScriptBlock(this, typeof(string), "myScriptName", " cerrarLoading();", true);

            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("ERROR:" + ex.Message.Replace("\r\n", ""));
            }

            //ScriptManager.RegisterClientScriptBlock(Page, typeof(string), "myScriptName", "cerrarLoading();", true);
            //gridSeguimiento.DataBind();

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

                String query = "select c.idcurso, c.idsucursal, coalesce(c.nombre,'NO DEFINIDO')as nombre,  coalesce(a.area,'AREA NO ASIGNADA') as area,  coalesce(e.especialidad,'ESPECIALIDAD NO ASIGNADA')as especialidad,  coalesce(i.nombre,'INSTRUCTOR NO DEFINIDO') as instructor, t.tipocurso, c.estatus, c.costo, cast(c.fechaini as char)as fechaini, cast(c.fechafin as char)as fechafin, cast(TIME_FORMAT(c.horaini, '%h:%i %p') as char)as horaini, cast(TIME_FORMAT(c.horafin, '%h:%i %p') as char)as horafin,  " +
                               "c.alumnosminimo, (select count(s.idalumno) from solicitudinscripcion s where s.idcurso = c.idcurso) as inscritos " +
                               "from curso c " +
                               "left join area a on a.idarea = c.idarea " +
                               "left join especialidad e on e.idespecialidad = c.idespecialidad " +
                               "left join tipocurso t on t.idtipocurso = c.idtipocurso " +
                               "left join instructor i on i.idinstructor = c.idinstructor " +
                               "where c.idsucursal = " + idsucursal + " ";



                if (bname.Text.Trim() != "")
                    query = query + " and c.nombre LIKE '%" + bname.Text.Trim().ToUpper() + "%' ";



                query = query + " order by c.nombre";

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

        protected void listadoAlumnos(object sender, EventArgs e)
        {

            try
            {

                GValumnos.DataSourceID = DSalumnos.ID;

                String query = "select concat(al.apaterno,' ', al.amaterno,' ', al.nombre)as nombrealumno, si.costo as costoalumno, si.folio,  cast(si.fecha as char)as fecha, si.observaciones as observacionesalumno " +
                       " from alumno al " +
                       " left join solicitudinscripcion si on si.idalumno = al.idalumno " +
                       " where si.idcurso = " + idP.Value + " " +
                       " order by nombrealumno";

                DSalumnos.SelectCommand = query;

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
		
		
		protected void listadoDocumentacion(object sender, EventArgs e)
        {

            try
            {

                GVdocumentacion.DataSourceID = DSdocumentacion.ID;

                String query = "select d.iddocumentacion, d.documentacion, "+
							   "( "+
							   "select count(c.iddocumentacion) "+
							   "from cursodocumentacion c "+
							   "where c.idsolicitud = "+ idI.Value +" "+
							   "and c.iddocumentacion = d.iddocumentacion "+
							   ")as entregado "+
							   "from documentacion d "+
							   "order by d.documentacion";

                DSdocumentacion.SelectCommand = query;

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

        protected void listadoFechas(object sender, EventArgs e)
        {
            String json = "";
            String sql = "";
            MySqlCommand cmd = null;
            try
            {


                using (MySqlConnection con = new MySqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
                {
                    con.Open();




                    sql = "select c.idcurso, c.idsucursal, c.nombre, c.estatus,  a.area,  e.especialidad,  i.nombre as instructor, t.tipocurso, c.estatus,  cast(c.fechaini as char)as fechaini, cast(c.fechafin as char)as fechafin, cast(TIME_FORMAT(c.horaini, '%h:%i %p') as char)as horaini, cast(TIME_FORMAT(c.horafin, '%h:%i %p') as char)as horafin,  cast(TIME_FORMAT(horaini, '%H:%i ')as char)as horainif, cast(TIME_FORMAT(horafin, '%H:%i ')as char)as horafinf, c.horas, c.dias, " +
                     "c.idtipocurso, c.idarea, c.idespecialidad, c.idinstructor, c.idinstalacion, c.observaciones, c.costo, c.costomodulo, c.pagohora, c.diascurso, c.idtipooferta, c.instalacionext, c.alumnosminimo, cast(c.fechalimite as char)as fechalimite, c.instalaciondomext " +
                     "from curso c " +
                     "left join area a on a.idarea = c.idarea " +
                     "left join especialidad e on e.idespecialidad = c.idespecialidad " +
                     "left join tipocurso t on t.idtipocurso = c.idtipocurso " +
                     "left join instructor i on i.idinstructor = c.idinstructor " +
                     "where c.idcurso = " + idP.Value + " ";


                    cmd = new MySqlCommand(sql, con);


                    MySqlDataReader rdr = cmd.ExecuteReader();


                    if (rdr.HasRows)
                    {
                        rdr.Read();

                        nombre.Text = rdr["nombre"].ToString();

                        if (rdr["idtipocurso"].GetType() != typeof(DBNull))
                            tipocurso.SelectedValue = rdr["idtipocurso"].ToString();

                        if (rdr["idinstructor"].GetType() != typeof(DBNull))
                            instructor.SelectedValue = rdr["idinstructor"].ToString();

                        if (rdr["idinstalacion"].GetType() != typeof(DBNull))
                        {
                            instalacion.SelectedValue = rdr["idinstalacion"].ToString();

                            instalacionext.Text = rdr["instalacionext"].ToString();
                            instalaciondomext.Text = rdr["instalaciondomext"].ToString();

                            if (instalacion.SelectedValue == "9999")
                                extramuros.Visible = true;
                            else
                                extramuros.Visible = false;
                        }

                        if (rdr["idarea"].GetType() != typeof(DBNull))
                        {

                            area.SelectedValue = rdr["idarea"].ToString();
                            Dsespecialidades.DataBind();
                            especialidad.DataBind();
                            especialidad.SelectedValue = rdr["idespecialidad"].ToString();
                        }

                        if (rdr["idtipooferta"].GetType() != typeof(DBNull))
                            tipooferta.SelectedValue = rdr["idtipooferta"].ToString();

                        fechaini.Text = rdr["fechaini"].ToString();
                        fechafin.Text = rdr["fechafin"].ToString();
                        dias.Text = rdr["dias"].ToString();
                        horaini.Text = rdr["horainif"].ToString();
                        horafin.Text = rdr["horafinf"].ToString();
                        horas.Text = rdr["horas"].ToString();

                        costomodulo.Text = rdr["costomodulo"].ToString();
                        costoalumno.Text = rdr["costo"].ToString();
                        pagohora.Text = rdr["pagohora"].ToString();

                        observaciones.Text = rdr["observaciones"].ToString();
                        hdias.Value = rdr["diascurso"].ToString();

                        alumnosminimo.Text = rdr["alumnosminimo"].ToString();
                        fechalimite.Text = rdr["fechalimite"].ToString();

                        


                    }

                    rdr.Close();




                    listadoAlumnos(sender, e);
                    ScriptManager.RegisterStartupScript(this, GetType(), "myScriptName", "cerrarLoading();  $('#bootstrap').modal('show'); $('#tabgenerales').click(); dar();", true);
                   // ScriptManager.RegisterStartupScript(this, GetType(), "inicilizarMun", "dataEvent =" + json, true);

                }


            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("ERROR:" + ex.Message.Replace("\r\n", ""));
            }





        }

		protected void getAlumno(object sender, EventArgs e)
        {
            
            using (MySqlConnection con = new MySqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {
                try
                {
                    con.Open();
                    string sql = "select idalumno, idedocivil, idescolaridad, nocontrol, nombre, apaterno, amaterno, sexo, curp, telefono, domicilio, colonia, cp, identidad, idmunicipio, cast(fechanacimiento as char)as fechanacimiento,  "+
				  "empresa, puesto, antiguedad  "+
				  "from alumno "+
				  "where idalumno = "+ idA.Value +" ";


                    MySqlCommand cmd = new MySqlCommand(sql, con);

                    MySqlDataReader rdr = cmd.ExecuteReader();
                   /* if (rdr.HasRows)
                    {
                        rdr.Read();
                       
                        idA.Value = rdr["idalumno"].ToString();
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


                        if (rdr["foto"].GetType() != typeof(DBNull))
                        {
                            Byte[] ImageByte = (Byte[])(rdr["foto"]);


                            if (ImageByte != null)
                            {
                                // You need to convert it in bitmap to display the imgage
                                fotopa.ImageUrl = "data:image/jpeg;base64," + Convert.ToBase64String(ImageByte);
                                fotopa.DataBind();

                            }
                        }


                    }*/

                    ScriptManager.RegisterClientScriptBlock(Page, typeof(string), "myScriptName", "cerrarLoading();", true);
                    
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


        protected void getCalendario(object sender, EventArgs e)
        {
            String json = "";
            String sql = "";
            MySqlCommand cmd = null;
            try
            {


                using (MySqlConnection con = new MySqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
                {
                    con.Open();

                    MySqlDataReader rdr = null;

                    String query = "select idfecha, cast(fecha as char)as fecha, cast(TIME_FORMAT(horaini, '%H:%i')as char)as horaini, cast(TIME_FORMAT(horafin, '%H:%i')as char)as horafin, concat(cast(TIME_FORMAT(horaini, '%H:%i')as char),' - ', cast(TIME_FORMAT(horafin, '%H:%i')as char)) as horario " +
                               "from fechascurso " +
                               "where idcurso = " + idP.Value + " " +
                               //"and idsucursal = " + idS.Value + " " +
                               "order by fecha";

                    cmd = new MySqlCommand(query, con);
                    rdr = cmd.ExecuteReader();


                    json += "[";

                    //new queryString/command setup

                    if (rdr.HasRows)
                    {

                        while (rdr.Read())
                        {

                            json += "{";
                            json += "id:'" + rdr["idfecha"].ToString() + "',";
                            json += "title:'" + rdr["horario"].ToString() + "',";
                            json += "description:'" + rdr["horaini"].ToString() + " - " + rdr["horafin"].ToString() + "',";
                            json += "fecha:'" + rdr["fecha"].ToString() + "',";
                            json += "horaini:'" + rdr["horaini"].ToString() + "',";
                            json += "horafin:'" + rdr["horafin"].ToString() + "',";
                            json += "start:'" + rdr["fecha"].ToString() + "',";
                            json += "end:'" + rdr["fecha"].ToString() + "'";
                            json += "},";

                        }

                    }

                    json += "]";


                    rdr.Close();



                }
                /*gridFechas.DataSourceID = Dslistadofechas.ID;

            String query = "select idfecha, cast(fecha as char)as fecha, cast(TIME_FORMAT(horaini, '%h:%i %p')as char)as horaini, cast(TIME_FORMAT(horafin, '%h:%i %p')as char)as horafin, concat(cast(TIME_FORMAT(horaini, '%h:%i %p')as char),' - ', cast(TIME_FORMAT(horafin, '%h:%i %p')as char)) as horario "+
                           "from fechascurso "+
                           "where idcurso = "+ idP.Value +" "+
                           "and idsucursal = "+ idS.Value +" "+
                           "order by fecha";




           Dslistadofechas.SelectCommand = query;

            Dslistadofechas.DataBind();
            gridFechas.DataBind();

            //if (String.IsNullOrEmpty(lusuarios.SortExpression)) lusuarios.Sort("ncompleto", SortDirection.Ascending);
*/
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("ERROR:" + ex.Message.Replace("\r\n", ""));
            }

            //ScriptManager.RegisterClientScriptBlock(Page, typeof(string), "myScriptName", "cerrarLoading();", true);

            ScriptManager.RegisterStartupScript(this, GetType(), "inicilizarMun", "dataEvent =" + json, true);
            //ScriptManager.RegisterStartupScript(this, GetType(), "myScriptName", "cerrarLoading(); $('#wfechas').modal('close'); ", true);
            //gridFechas.DataBind();

        }

        protected void limpiarCampos(object sender, EventArgs e)
        {
            String json = "";
            try
            {
                idP.Value = "0";
                nombre.Text = "";
                tipocurso.ClearSelection();
                instructor.ClearSelection();
                instalacion.ClearSelection();
                area.ClearSelection();
                Dsespecialidades.DataBind();
                especialidad.DataBind();
                especialidad.ClearSelection();

                fechaini.Text = "";
                fechafin.Text = "";
                dias.Text = "";
                horaini.Text = "";
                horafin.Text = "";
                horas.Text = "";

                costomodulo.Text = "";
                costoalumno.Text = "";
                pagohora.Text = "";
                observaciones.Text = "";
                hdias.Value = "";
                json = "[]";


            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("ERROR:" + ex.Message.Replace("\r\n", ""));
            }

            //ScriptManager.RegisterClientScriptBlock(Page, typeof(string), "myScriptName", "cerrarLoading();", true);
            ScriptManager.RegisterStartupScript(this, GetType(), "myScriptName", "cerrarLoading(); $('#tabgenerales').click(); $('#bootstrap').modal('show');  $('#fc-basic-views').fullCalendar('render'); dar(); ", true);
            ScriptManager.RegisterStartupScript(this, GetType(), "inicilizarMun", "dataEvent =" + json, true);
            //gridFechas.DataBind();

        }
		
		protected void limpiarCamposInscripcion(object sender, EventArgs e)
        {
            String json = "";
            try
            {
                idA.Value = "0";
				idI.Value = "0";

                nocontrol.Text = "";				
                apaterno.Text = "";
				amaterno.Text = "";
				nombrealumno.Text = "";
				
				curp.Text = "";
				fechanacimiento.Text = "";
				telefono.Text = "";				
                sexo.ClearSelection();
				
				domicilio.Text = "";
				colonia.Text = "";
				cp.Text = "";
				                
                entidad.ClearSelection();
                DSentidades.DataBind();
                municipio.DataBind();
                municipio.ClearSelection();
				
				edocivil.ClearSelection();
				discapacidad.ClearSelection();
				
				especialidadins.ClearSelection();
                Dsespecialidadesins.DataBind();
                curso.DataBind();
                curso.ClearSelection();
				
				escolaridad.ClearSelection();
				
				empresa.Text = "";
				antiguedad.Text = "";
				domicilioempresa.Text = "";
				telefonoempresa.Text = "";
                
				otromed.Text = "";
				otromot.Text = "";

                listadoDocumentacion(sender, e);


            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("ERROR:" + ex.Message.Replace("\r\n", ""));
            }

            //ScriptManager.RegisterClientScriptBlock(Page, typeof(string), "myScriptName", "cerrarLoading();", true);
            ScriptManager.RegisterStartupScript(this, GetType(), "myScriptName", "cerrarLoading(); $('#tabgenerales').click(); $('#winscripcion').modal('show'); dar(); ", true);
            
            //gridFechas.DataBind();

        }
		
		
        protected void guardaEdita(object sender, EventArgs e)
        {


            using (MySqlConnection con = new MySqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {

                MySqlTransaction transaction = null;
                MySqlDataReader reader = null;

                String query = "";
                int uactivo = 0;

                /* if (activo.Checked)
                     uactivo = 1;
                 else
                     uactivo = 0;*/

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

                    //SI EL CURSO ES NUEVO SE GUARDA 
                    if (Convert.ToInt32(idP.Value) == 0)
                    {
                        //cmd.Parameters.Clear();
                        /* cmd.CommandText = "SELECT COALESCE(MAX(idinstructor),0)as idinstructor FROM instructor where idsucursal=" + idsucursal + ";";


                         reader = cmd.ExecuteReader();
                         while (reader.Read())
                         {
                             idinstructor = reader.GetInt32(0) + 1;
                         }
                         reader.Close();
                         */

                        cmd.Parameters.Clear();
                        query = "insert into curso(idsucursal, idcicloescolar, nombre, idtipocurso, idarea, idespecialidad, idinstructor, idinstalacion, fechaini, fechafin, dias, horaini, horafin, horas, costomodulo, costo, pagohora, observaciones, estatus, pagado, diascurso, idtipooferta, instalacionext, alumnosminimo, fechalimite, instalaciondomext, solicita, autoriza) " +
                                           "values(@idsucursal, @idcicloescolar, @nombre, @idtipocurso, @idarea, @idespecialidad, @idinstructor, @idinstalacion, @fechaini, @fechafin, @dias, @horaini, @horafin, @horas, @costomodulo, @costo, @pagohora, @observaciones, 'EN CAPTURA', 0, @diascurso, @idtipooferta, @instalacionext, @alumnosminimo, @fechalimite, @instalaciondomext, (select encargado from sucursal where idsucursal=@idsucursal), 'PROF. GERSOM PÉREZ RAMÍREZ'); ";

                        cmd.CommandText = query;
                        cmd.Parameters.AddWithValue("@idcicloescolar", 1);
                        cmd.Parameters.AddWithValue("@idsucursal", idsucursal);
                        cmd.Parameters.AddWithValue("@nombre", nombre.Text.ToUpper().Trim());
                        cmd.Parameters.AddWithValue("@idtipocurso", tipocurso.SelectedValue);
                        cmd.Parameters.AddWithValue("@idarea", area.SelectedValue);
                        cmd.Parameters.AddWithValue("@idespecialidad", especialidad.SelectedValue);
                        cmd.Parameters.AddWithValue("@idinstructor", instructor.SelectedValue);
                        cmd.Parameters.AddWithValue("@idinstalacion", instalacion.SelectedValue);
                        cmd.Parameters.AddWithValue("@fechaini", fechaini.Text);
                        cmd.Parameters.AddWithValue("@fechafin", fechafin.Text);
                        cmd.Parameters.AddWithValue("@dias", dias.Text);
                        cmd.Parameters.AddWithValue("@horaini", horaini.Text);
                        cmd.Parameters.AddWithValue("@horafin", horafin.Text);
                        cmd.Parameters.AddWithValue("@horas", horas.Text);
                        if (!costomodulo.Text.Equals(""))
                            cmd.Parameters.AddWithValue("@costomodulo", costomodulo.Text);
                        else
                            cmd.Parameters.AddWithValue("@costomodulo", "0");

                        if (!costoalumno.Text.Equals(""))
                            cmd.Parameters.AddWithValue("@costo", costoalumno.Text);
                        else
                            cmd.Parameters.AddWithValue("@costo", "0");

                        if (!pagohora.Text.Equals(""))
                            cmd.Parameters.AddWithValue("@pagohora", pagohora.Text);
                        else
                            cmd.Parameters.AddWithValue("@pagohora", "0");

                        cmd.Parameters.AddWithValue("@observaciones", observaciones.Text.Trim());
                        cmd.Parameters.AddWithValue("@diascurso", hdias.Value);


                        cmd.Parameters.AddWithValue("@idtipooferta", tipooferta.SelectedValue);
                        cmd.Parameters.AddWithValue("@instalacionext", instalacionext.Text.ToUpper().Trim());
                        cmd.Parameters.AddWithValue("@instalaciondomext", instalaciondomext.Text.ToUpper().Trim());
                        cmd.Parameters.AddWithValue("@alumnosminimo", alumnosminimo.Text);
                        cmd.Parameters.AddWithValue("@fechalimite", fechalimite.Text);

                        cmd.ExecuteNonQuery();


                    }
                    //SI NO SE ACTUALIZAN LOS DATOS DEL CURSO
                    else
                    {


                        cmd.Parameters.Clear();
                        query = "update curso set nombre=@nombre, idcicloescolar=@idcicloescolar, idtipocurso=@idtipocurso, idarea=@idarea, idespecialidad=@idespecialidad, idinstructor=@idinstructor, idinstalacion=@idinstalacion, fechaini=@fechaini, fechafin=@fechafin, dias=@dias, horaini=@horaini, horafin=@horafin, horas=@horas, " +
                                " costomodulo=@costomodulo, costo=@costo, pagohora=@pagohora, observaciones=@observaciones, diascurso=@diascurso, idtipooferta=@idtipooferta, instalacionext=@instalacionext, alumnosminimo=@alumnosminimo, fechalimite=@fechalimite, instalaciondomext=@instalaciondomext ";

                        query = query + "where idcurso=@idcurso;";


                        cmd.CommandText = query;

                        cmd.Parameters.AddWithValue("@idcurso", idP.Value);
                        cmd.Parameters.AddWithValue("@idcicloescolar", 1);

                        cmd.Parameters.AddWithValue("@nombre", nombre.Text.ToUpper().Trim());
                        cmd.Parameters.AddWithValue("@idtipocurso", tipocurso.SelectedValue);
                        cmd.Parameters.AddWithValue("@idarea", area.SelectedValue);
                        cmd.Parameters.AddWithValue("@idespecialidad", especialidad.SelectedValue);
                        cmd.Parameters.AddWithValue("@idinstructor", instructor.SelectedValue);
                        cmd.Parameters.AddWithValue("@idinstalacion", instalacion.SelectedValue);
                        cmd.Parameters.AddWithValue("@fechaini", fechaini.Text);
                        cmd.Parameters.AddWithValue("@fechafin", fechafin.Text);
                        cmd.Parameters.AddWithValue("@dias", dias.Text);
                        cmd.Parameters.AddWithValue("@horaini", horaini.Text);
                        cmd.Parameters.AddWithValue("@horafin", horafin.Text);
                        cmd.Parameters.AddWithValue("@horas", horas.Text);

                        if (!costomodulo.Text.Equals(""))
                            cmd.Parameters.AddWithValue("@costomodulo", costomodulo.Text);
                        else
                            cmd.Parameters.AddWithValue("@costomodulo", "0");

                        if (!costoalumno.Text.Equals(""))
                            cmd.Parameters.AddWithValue("@costo", costoalumno.Text);
                        else
                            cmd.Parameters.AddWithValue("@costo", "0");

                        if (!pagohora.Text.Equals(""))
                            cmd.Parameters.AddWithValue("@pagohora", pagohora.Text);
                        else
                            cmd.Parameters.AddWithValue("@pagohora", "0");


                        cmd.Parameters.AddWithValue("@observaciones", observaciones.Text.Trim());
                        cmd.Parameters.AddWithValue("@diascurso", hdias.Value);

                        cmd.Parameters.AddWithValue("@idtipooferta", tipooferta.SelectedValue);
                        cmd.Parameters.AddWithValue("@instalacionext", instalacionext.Text.ToUpper().Trim());
                        cmd.Parameters.AddWithValue("@instalaciondomext", instalaciondomext.Text.ToUpper().Trim());
                        cmd.Parameters.AddWithValue("@alumnosminimo", alumnosminimo.Text);
                        cmd.Parameters.AddWithValue("@fechalimite", fechalimite.Text);


                        cmd.ExecuteNonQuery();

                    }

                    transaction.Commit();

                    listadoClientes(sender, e);
                    //ScriptManager.RegisterStartupScript(this, GetType(), "cerrar", "$('.modal-backdrop').remove();", true);
                    ScriptManager.RegisterStartupScript(this, GetType(), "myScriptName", "cerrarLoading();", true);

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



            }


        }


        protected void solicitaAutorizacion(object sender, EventArgs e)
        {


            using (MySqlConnection con = new MySqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {

                MySqlTransaction transaction = null;
                String query = "";

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

                    //SI EL CURSO ES NUEVO SE GUARDA 

                    cmd.Parameters.Clear();
                    query = "update curso set estatus='EN REVISION' where idcurso=@idcurso;";

                    cmd.CommandText = query;
                    cmd.Parameters.AddWithValue("@idcurso", idP.Value);
                    cmd.ExecuteNonQuery();


                    transaction.Commit();

                    listadoClientes(sender, e);
                    ScriptManager.RegisterStartupScript(this, GetType(), "myScriptName", "cerrarLoading(); $('#bootstrap').modal('hide');", true);

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



            }


        }

        protected void generaFechasCurso(object sender, EventArgs e)
        {



            using (MySqlConnection con = new MySqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {

                MySqlTransaction transaction = null;
                MySqlDataReader reader = null;

                String query = "";
                int idfecha = 0;
                int idcurso = 0;
                int nohoras = 0;


                List<fechascurso> listafechas = null;
                /* if (activo.Checked)
                     uactivo = 1;
                 else
                     uactivo = 0;*/

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



                    if (Convert.ToInt32(idP.Value) == 0)
                    {
                        //cmd.Parameters.Clear();
                        /* cmd.CommandText = "SELECT COALESCE(MAX(idinstructor),0)as idinstructor FROM instructor where idsucursal=" + idsucursal + ";";


                         reader = cmd.ExecuteReader();
                         while (reader.Read())
                         {
                             idinstructor = reader.GetInt32(0) + 1;
                         }
                         reader.Close();
                         */

                        cmd.Parameters.Clear();
                        query = "insert into curso(idsucursal, idcicloescolar, nombre, idtipocurso, idarea, idespecialidad, idinstructor, idinstalacion, fechaini, fechafin, dias, horaini, horafin, horas, costomodulo, costo, pagohora, observaciones, estatus, pagado, diascurso, idtipooferta, instalacionext, alumnosminimo, fechalimite, instalaciondomext, solicita, autoriza) " +
                                            "values(@idsucursal, @idcicloescolar, @nombre, @idtipocurso, @idarea, @idespecialidad, @idinstructor, @idinstalacion, @fechaini, @fechafin, @dias, @horaini, @horafin, @horas, @costomodulo, @costo, @pagohora, @observaciones, 'EN CAPTURA', 0, @diascurso, @idtipooferta, @instalacionext, @alumnosminimo, @fechalimite, @instalaciondomext, (select encargado from sucursal where idsucursal=@idsucursal), 'PROF. GERSOM PÉREZ RAMÍREZ'); ";

                        cmd.CommandText = query;
                        cmd.Parameters.AddWithValue("@idcicloescolar", 1);
                        cmd.Parameters.AddWithValue("@idsucursal", idsucursal);
                        cmd.Parameters.AddWithValue("@nombre", nombre.Text.ToUpper().Trim());
                        cmd.Parameters.AddWithValue("@idtipocurso", tipocurso.SelectedValue);
                        cmd.Parameters.AddWithValue("@idarea", area.SelectedValue);
                        cmd.Parameters.AddWithValue("@idespecialidad", especialidad.SelectedValue);
                        cmd.Parameters.AddWithValue("@idinstructor", instructor.SelectedValue);
                        cmd.Parameters.AddWithValue("@idinstalacion", instalacion.SelectedValue);
                        cmd.Parameters.AddWithValue("@fechaini", fechaini.Text);
                        cmd.Parameters.AddWithValue("@fechafin", fechafin.Text);
                        cmd.Parameters.AddWithValue("@dias", dias.Text);
                        cmd.Parameters.AddWithValue("@horaini", horaini.Text);
                        cmd.Parameters.AddWithValue("@horafin", horafin.Text);
                        cmd.Parameters.AddWithValue("@horas", horas.Text);
                        if (!costomodulo.Text.Equals(""))
                            cmd.Parameters.AddWithValue("@costomodulo", costomodulo.Text);
                        else
                            cmd.Parameters.AddWithValue("@costomodulo", "0");

                        if (!costoalumno.Text.Equals(""))
                            cmd.Parameters.AddWithValue("@costo", costoalumno.Text);
                        else
                            cmd.Parameters.AddWithValue("@costo", "0");

                        if (!pagohora.Text.Equals(""))
                            cmd.Parameters.AddWithValue("@pagohora", pagohora.Text);
                        else
                            cmd.Parameters.AddWithValue("@pagohora", "0");

                        cmd.Parameters.AddWithValue("@observaciones", observaciones.Text.Trim());
                        cmd.Parameters.AddWithValue("@diascurso", hdias.Value);


                        cmd.Parameters.AddWithValue("@idtipooferta", tipooferta.SelectedValue);
                        cmd.Parameters.AddWithValue("@instalacionext", instalacionext.Text.ToUpper().Trim());
                        cmd.Parameters.AddWithValue("@instalaciondomext", instalaciondomext.Text.ToUpper().Trim());
                        cmd.Parameters.AddWithValue("@alumnosminimo", alumnosminimo.Text);
                        cmd.Parameters.AddWithValue("@fechalimite", fechalimite.Text);
                        cmd.ExecuteNonQuery();

                        idcurso = (int)cmd.LastInsertedId;
                        idP.Value = idcurso.ToString();


                    }
                    //SI NO SE ACTUALIZAN LOS DATOS DEL CURSO
                    else
                    {


                        cmd.Parameters.Clear();
                        query = "update curso set nombre=@nombre, idcicloescolar=@idcicloescolar, idtipocurso=@idtipocurso, idarea=@idarea, idespecialidad=@idespecialidad, idinstructor=@idinstructor, idinstalacion=@idinstalacion, fechaini=@fechaini, fechafin=@fechafin, dias=@dias, horaini=@horaini, horafin=@horafin, horas=@horas, " +
                                " costomodulo=@costomodulo, costo=@costo, pagohora=@pagohora, observaciones=@observaciones, diascurso=@diascurso, idtipooferta=@idtipooferta, instalacionext=@instalacionext, alumnosminimo=@alumnosminimo, fechalimite=@fechalimite, instalaciondomext=@instalaciondomext ";

                        query = query + "where idcurso=@idcurso;";


                        cmd.CommandText = query;

                        cmd.Parameters.AddWithValue("@idcurso", idP.Value);
                        cmd.Parameters.AddWithValue("@idcicloescolar", 1);

                        cmd.Parameters.AddWithValue("@nombre", nombre.Text.ToUpper().Trim());
                        cmd.Parameters.AddWithValue("@idtipocurso", tipocurso.SelectedValue);
                        cmd.Parameters.AddWithValue("@idarea", area.SelectedValue);
                        cmd.Parameters.AddWithValue("@idespecialidad", especialidad.SelectedValue);
                        cmd.Parameters.AddWithValue("@idinstructor", instructor.SelectedValue);
                        cmd.Parameters.AddWithValue("@idinstalacion", instalacion.SelectedValue);
                        cmd.Parameters.AddWithValue("@fechaini", fechaini.Text);
                        cmd.Parameters.AddWithValue("@fechafin", fechafin.Text);
                        cmd.Parameters.AddWithValue("@dias", dias.Text);
                        cmd.Parameters.AddWithValue("@horaini", horaini.Text);
                        cmd.Parameters.AddWithValue("@horafin", horafin.Text);
                        cmd.Parameters.AddWithValue("@horas", horas.Text);

                        if (!costomodulo.Text.Equals(""))
                            cmd.Parameters.AddWithValue("@costomodulo", costomodulo.Text);
                        else
                            cmd.Parameters.AddWithValue("@costomodulo", "0");

                        if (!costoalumno.Text.Equals(""))
                            cmd.Parameters.AddWithValue("@costo", costoalumno.Text);
                        else
                            cmd.Parameters.AddWithValue("@costo", "0");

                        if (!pagohora.Text.Equals(""))
                            cmd.Parameters.AddWithValue("@pagohora", pagohora.Text);
                        else
                            cmd.Parameters.AddWithValue("@pagohora", "0");


                        cmd.Parameters.AddWithValue("@observaciones", observaciones.Text.Trim());
                        cmd.Parameters.AddWithValue("@diascurso", hdias.Value);

                        cmd.Parameters.AddWithValue("@idtipooferta", tipooferta.SelectedValue);
                        cmd.Parameters.AddWithValue("@instalacionext", instalacionext.Text.ToUpper().Trim());
                        cmd.Parameters.AddWithValue("@instalaciondomext", instalaciondomext.Text.ToUpper().Trim());
                        cmd.Parameters.AddWithValue("@alumnosminimo", alumnosminimo.Text);
                        cmd.Parameters.AddWithValue("@fechalimite", fechalimite.Text);


                        cmd.ExecuteNonQuery();

                    }

                    cmd.Parameters.Clear();
                    //SE REVISA SI LA FECHA NO EXISTE YA PARA ESE CURSO
                    cmd.CommandText = "select * from " +
                    "(select adddate('1970-01-01', t4.i * 10000 + t3.i * 1000 + t2.i * 100 + t1.i * 10 + t0.i) fecha from " +
                    " (select 0 i union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t0, " +
                    " (select 0 i union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t1, " +
                    " (select 0 i union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t2, " +
                    " (select 0 i union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t3, " +
                    " (select 0 i union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t4) v " +
                    "where fecha between '" + fechaini.Text + "' and '" + fechafin.Text + "'" +
                    "and DAYOFWEEK(fecha) in (" + hdias.Value + ")";

                    listafechas = new List<fechascurso>();

                    reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        fechascurso item = new fechascurso();
                        item.fecha = reader.GetString(0);
                        listafechas.Add(item);
                    }
                    reader.Close();


                    cmd.Parameters.Clear();
                    cmd.CommandText = "SELECT COALESCE(MAX(idfecha),0)as idfecha FROM fechascurso where idcurso=" + idP.Value + ";";


                    reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        idfecha = reader.GetInt32(0) + 1;
                    }
                    reader.Close();


                    cmd.Parameters.Clear();
                    query = "delete from fechascurso where idcurso=@idcurso; ";
                    cmd.Parameters.AddWithValue("@idcurso", idP.Value);
                    cmd.CommandText = query;
                    cmd.ExecuteNonQuery();

                    foreach (fechascurso item in listafechas)
                    {

                        cmd.Parameters.Clear();
                        query = "insert into fechascurso (idcurso, idfecha, fecha, horaini, horafin) values (@idcurso, @idfecha, @fecha, @horaini, @horafin); ";

                        cmd.CommandText = query;

                        cmd.Parameters.AddWithValue("@idcurso", idP.Value);
                        cmd.Parameters.AddWithValue("@idfecha", idfecha);
                        cmd.Parameters.AddWithValue("@fecha", item.fecha);
                        cmd.Parameters.AddWithValue("@horaini", horaini.Text);
                        cmd.Parameters.AddWithValue("@horafin", horafin.Text);
                        idfecha++;
                        cmd.ExecuteNonQuery();

                    }

                    cmd.Parameters.Clear();
                    cmd.CommandText = "select sum(TIMESTAMPDIFF(HOUR, horaini, horafin))as horas from fechascurso where idcurso =" + idP.Value + ";";


                    reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        nohoras = reader.GetInt32(0);
                    }
                    reader.Close();

                    cmd.Parameters.Clear();
                    query = "update curso set dias=@dias, horas=@horas where idcurso=@idcurso; ";
                    cmd.CommandText = query;
                    cmd.Parameters.AddWithValue("@idcurso", idP.Value);
                    cmd.Parameters.AddWithValue("@dias", listafechas.Count);
                    cmd.Parameters.AddWithValue("@horas", nohoras);
                    cmd.ExecuteNonQuery();

                    dias.Text = listafechas.Count.ToString();
                    horas.Text = nohoras.ToString();

                    transaction.Commit();
                    getCalendario(sender, e);
                    ScriptManager.RegisterStartupScript(this, GetType(), "myScriptName", "cerrarLoading(); ", true);

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

            }


        }

        protected void guardaEditaFechas(object sender, EventArgs e)
        {


            int nohoras = 0;

            using (MySqlConnection con = new MySqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {

                MySqlTransaction transaction = null;
                MySqlDataReader reader = null;
                String query = "";

                /* if (activo.Checked)
                     uactivo = 1;
                 else
                     uactivo = 0;*/

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



                    //SE INSERTA EN FECHASCURSO
                    cmd.Parameters.Clear();
                    query = "update fechascurso set horaini=@horaini,  horafin=@horafin where idcurso=@idcurso and idfecha=@idfecha; ";

                    cmd.CommandText = query;

                    cmd.Parameters.AddWithValue("@idcurso", idP.Value);
                    cmd.Parameters.AddWithValue("@idfecha", idF.Value);
                    cmd.Parameters.AddWithValue("@horaini", horanini.Text);
                    cmd.Parameters.AddWithValue("@horafin", horanfin.Text);

                    cmd.ExecuteNonQuery();

                    cmd.Parameters.Clear();
                    cmd.CommandText = "select sum(TIMESTAMPDIFF(HOUR, horaini, horafin))as horas from fechascurso where idcurso =" + idP.Value + ";";


                    reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        nohoras = reader.GetInt32(0);
                    }
                    reader.Close();

                    cmd.Parameters.Clear();
                    query = "update curso set horas=@horas where idcurso=@idcurso; ";
                    cmd.CommandText = query;
                    cmd.Parameters.AddWithValue("@idcurso", idP.Value);
                    cmd.Parameters.AddWithValue("@horas", nohoras);
                    cmd.ExecuteNonQuery();
                    horas.Text = nohoras.ToString();
                    transaction.Commit();
                    getCalendario(sender, e);

                    //ScriptManager.RegisterStartupScript(this, GetType(), "cerrar", "$('.modal-backdrop').remove();", true);
                    //
                    ScriptManager.RegisterStartupScript(this, GetType(), "myScriptName", "cerrarLoading();  $('#wfechas').modal('hide');", true);
                    //ScriptManager.RegisterStartupScript(this, GetType(), "myScriptName", "cerrarLoading(); $('#wfechas').modal('hide'); ", true);

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


            }


        }

        protected void borraFechas(object sender, EventArgs e)
        {


            /*
            using (MySqlConnection con = new MySqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {

                MySqlTransaction transaction = null;               
                String query = "";
                
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
                                           
                        //SE INSERTA EN FECHASCURSO
                        cmd.Parameters.Clear();
                        query = "delete from fechascurso where idcurso=@idcurso and idfecha=@idfecha; ";

                        cmd.CommandText = query;

                        cmd.Parameters.AddWithValue("@idcurso", idP.Value);
                        cmd.Parameters.AddWithValue("@idfecha", idF.Value);
                       

                        cmd.ExecuteNonQuery();

                        transaction.Commit();
                        getCalendario(sender, e);

                    

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
                //
                ScriptManager.RegisterStartupScript(this, GetType(), "myScriptName", "cerrarLoading(); $('#wfechas').modal('hide'); ", true);
                //ScriptManager.RegisterStartupScript(this, GetType(), "myScriptName", "cerrarLoading(); $('#wfechas').modal('hide'); ", true);


            }*/


        }

        protected void insertaFechas(object sender, EventArgs e)
        {



            /*using (MySqlConnection con = new MySqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {

                MySqlTransaction transaction = null;
                String query = "";

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

                    //SE INSERTA EN FECHASCURSO
                    cmd.Parameters.Clear();
                    query = "delete from fechascurso where idcurso=@idcurso and idfecha=@idfecha; ";

                    cmd.CommandText = query;

                    cmd.Parameters.AddWithValue("@idcurso", idP.Value);
                    cmd.Parameters.AddWithValue("@idfecha", idF.Value);


                    cmd.ExecuteNonQuery();

                    transaction.Commit();
                    getCalendario(sender, e);



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
                //
                ScriptManager.RegisterStartupScript(this, GetType(), "myScriptName", "cerrarLoading(); $('#wfechas').modal('hide'); ", true);
                //ScriptManager.RegisterStartupScript(this, GetType(), "myScriptName", "cerrarLoading(); $('#wfechas').modal('hide'); ", true);


            }*/


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
                    string query = "SELECT COUNT(idcurso) as total " +
                                            "FROM curso " +
                                            "WHERE idsucursal =" + idsucursal + " ";

                    if (bname.Text.Trim() != "")
                        query = query + " AND c.nombre LIKE '%" + bname.Text.Trim().ToUpper() + "%' ";

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

        protected void area_DataBound(object sender, EventArgs e)
        {
            Dsespecialidades.DataBind();
            especialidad.DataBind();




            // ScriptManager.RegisterStartupScript(this, GetType(), "myScriptName", "$("*[id$= 'especialidad']").change();", true);

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

        void ExportToPDF(Telerik.Reporting.Report reportToExport)
        {
            ReportProcessor reportProcessor = new ReportProcessor();
            Telerik.Reporting.InstanceReportSource instanceReportSource = new Telerik.Reporting.InstanceReportSource();
            instanceReportSource.ReportDocument = reportToExport;
            RenderingResult result = reportProcessor.RenderReport("PDF", instanceReportSource, null);

            string fileName = result.DocumentName + "." + result.Extension;

            Response.Clear();
            Response.ContentType = result.MimeType;
            Response.Cache.SetCacheability(HttpCacheability.Private);
            Response.Expires = -1;
            Response.Buffer = true;

            Response.AddHeader("Content-Disposition",
                               string.Format("{0};FileName=\"{1}\"",
                                             "attachment",
                                             fileName));

            Response.BinaryWrite(result.DocumentBytes);

            Response.End();
        }

        protected void bimprimir_Click(object sender, EventArgs e)
        {
            ReportLibrary.SolicitudAutorizacionCurso reporte = new ReportLibrary.SolicitudAutorizacionCurso();
            reporte.ReportParameters["idsucursal"].Value = idS.Value;
            reporte.ReportParameters["idcurso"].Value = idP.Value;
            ExportToPDF(reporte);


        }

        protected void instalacion_SelectedIndexChanged(object sender, EventArgs e)
        {
            //SI SE SELECCIONA INSTALACIÓN EXTRAMUROS
            if (instalacion.SelectedValue == "9999")
            {
                extramuros.Visible = true;
            }
            else
            {
                extramuros.Visible = false;
            }

        }
    }

}