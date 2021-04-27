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
using System.IO;
using System.Threading;

namespace elecion.tecnicoaca
{
    public partial class catautcursos : System.Web.UI.Page
    {
        private int idsucursal;
        private int idusuario;
        int idtipousuario;
        string roles;

        protected void Page_Load(object sender, EventArgs e)
        {

            var idu = (FormsIdentity)Page.User.Identity;
            var ticket = idu.Ticket;
            string[] datos = ticket.UserData.Split(',');
            string[] datos2 = datos[1].Split(';');
            idusuario = Convert.ToInt32(datos[0]);
            idsucursal = Convert.ToInt32(datos2[4]);
             roles = datos2[3].ToString();

            

                idSU.Value = idsucursal.ToString();

            if (!IsPostBack)
            {
                listadoClientes(sender, e);
            }

            //if (bnombre.Text.Trim().)
            //diassemana.SelectedValue = hdias.Value;
            ScriptManager.RegisterStartupScript(this, GetType(), "actu", "dar(); ", true);
        }

        protected void listadoClientes(object sender, EventArgs e)
        {
          
            Convert.ToInt32(this.limite.Value);
            int pag = 1;
            try
            {
                if (idOP.Value.Equals("") || idOP.Value.Equals("2"))
                {
                    if (!bperiodo.SelectedValue.Equals(""))
                        DSperiodo.SelectCommand = "SELECT idperiodo, periodo FROM periodo where idcicloescolar=" + bciclo.SelectedValue + " UNION select 999999, 'SELECCIONE UN PERIODO' ORDER BY idperiodo desc";
                    else
                        DSperiodo.SelectCommand = "SELECT idperiodo, periodo FROM periodo where idcicloescolar=99999 UNION select 999999, 'SELECCIONE UN PERIODO' ORDER BY idperiodo desc";

                    bperiodo.DataBind();
                    DSperiodo.DataBind();
                }


                this.lGeneral.DataSourceID = this.DsUsuarios.ID;
                string query = "select c.idcurso, c.clave, c.idsucursal, coalesce(c.nombre,'NO DEFINIDO')as nombre,  coalesce(a.area,'AREA NO ASIGNADA') as area,  coalesce(e.especialidad,'ESPECIALIDAD NO ASIGNADA')as especialidad,  coalesce(i.nombre,'INSTRUCTOR NO DEFINIDO') as instructor, t.tipocurso, c.estatus, c.costo, cast(c.fechaini as char)as fechaini, cast(c.fechafin as char)as fechafin, cast(TIME_FORMAT(c.horaini, '%h:%i %p') as char)as horaini, cast(TIME_FORMAT(c.horafin, '%h:%i %p') as char)as horafin,  c.alumnosminimo, (select count(s.idalumno) from solicitudinscripcion s where s.idcurso = c.idcurso and s.estatus not in('CANCELADO')) as inscritos, s.nombre as plantel from curso c left join area a on a.idarea = c.idarea left join especialidad e on e.idespecialidad = c.idespecialidad left join tipocurso t on t.idtipocurso = c.idtipocurso left join instructor i on i.idinstructor = c.idinstructor left join sucursal s on s.idsucursal = c.idsucursal where c.tipo='C' and c.estatus not in('CANCELADO') ";
                if (this.bname.Text.Trim() != "")
                {
                    query = string.Concat(new string[] { query, " and (c.nombre LIKE '%", this.bname.Text.Trim().ToUpper(), "%' or c.clave LIKE '%", this.bname.Text.Trim().ToUpper(), "%') " });
                }
                if (this.roles.IndexOf('1', 0) < 0)
                {
                    query = string.Concat(new object[] { query, " and c.idsucursal = ", this.idsucursal, " " });
                }
                else if (!this.bplantel.SelectedValue.Equals("0"))
                {
                    query = string.Concat(query, " and c.idsucursal = ", this.bplantel.SelectedValue, " ");
                }

                if (!bciclo.SelectedValue.Equals("") && !bciclo.SelectedValue.Equals("999999"))
                    query += "and c.idcicloescolar=" + bciclo.SelectedValue + " ";

                if (!bperiodo.SelectedValue.Equals("") && !bperiodo.SelectedValue.Equals("999999"))
                    query += "and(select p.idperiodo from periodo p where c.fechaini between p.fechaini and p.fechafin)=" + bperiodo.SelectedValue + " ";

                if (!bestatus.SelectedValue.Equals("0"))
                    query += "and c.estatus='" + bestatus.SelectedValue + "' ";
                else
                    query += "and c.estatus in ('EN REVISION','AUTORIZADO','OBSERVADO','RECHAZADO','FINALIZADO')";

                query = string.Concat(query, " order by c.idsucursal, c.fechaini desc,  c.nombre");
                this.DsUsuarios.SelectCommand = query;

                DataView dvAccess = (DataView)DsUsuarios.Select(DataSourceSelectArguments.Empty);

                if (dvAccess != null && dvAccess.Count > 0)
                {
                    labelConteo.Text = dvAccess.Count.ToString();
                    divNoRegistros.Visible = false;
                }

                else
                {
                    labelConteo.Text = "0";
                    divNoRegistros.Visible = true;
                }


            }
            catch (Exception exception)
            {
            }

        }

        protected void listadoAlumnos(object sender, EventArgs e)
        {
            
            try
            {

                GValumnos.DataSourceID = DSalumnos.ID;

                String query = "select concat(al.apaterno,' ', al.amaterno,' ', al.nombre)as nombrealumno, case si.becado " +
                        "when 1 then round(c.costo -c.costo * (si.porcentaje / 100),2) " +
                        "else c.costo " +
                        "end as costoalumno, si.folio,  cast(si.fecha as char)as fecha, si.observaciones as observacionesalumno " +
                       " from alumno al " +
                       " left join solicitudinscripcion si on si.idalumno = al.idalumno " +
                       " left join curso c on si.idcurso = c.idcurso " +
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

        protected void listadoHistorial(object sender, EventArgs e)
        {

            try
            {

                GVhistorial.DataSourceID = DShistorial.ID;

                String query = "SELECT cast(h.fecha as char)as fecha, cast(h.hora as char) as hora, h.observacion, u.login as usuario " +
                                "from historialcurso h " +
                                "left join usuario u on u.idusuario = h.idusuario " +
                                "where h.idcurso = "+idP.Value+ " "+
                                "order by h.fecha, h.hora";

                DShistorial.SelectCommand = query;

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
            String bloqueo = "";
            MySqlCommand cmd = null;
            try
            {

                
                using (MySqlConnection con = new MySqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
                {
                    con.Open();


                   

                         sql = "select c.idcurso, c.idsucursal, c.clave, c.nombre, c.estatus, a.area,  e.especialidad,  i.nombre as instructor, t.tipocurso, c.estatus,  cast(c.fechaini as char)as fechaini, cast(c.fechafin as char)as fechafin, cast(TIME_FORMAT(c.horaini, '%h:%i %p') as char)as horaini, cast(TIME_FORMAT(c.horafin, '%h:%i %p') as char)as horafin,  cast(TIME_FORMAT(horaini, '%H:%i ')as char)as horainif, cast(TIME_FORMAT(horafin, '%H:%i ')as char)as horafinf, c.horas, c.dias, " +
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

                        clave.Text = rdr["clave"].ToString();
                        cve.Value = clave.Text;
                        nombre.Text = rdr["nombre"].ToString();

                        if (rdr["idtipocurso"].GetType() != typeof(DBNull))
                            tipocurso.SelectedValue = rdr["idtipocurso"].ToString();

                        if (rdr["idinstructor"].GetType() != typeof(DBNull))
                            instructor.SelectedValue = rdr["idinstructor"].ToString();

                        if (rdr["idinstalacion"].GetType() != typeof(DBNull)) { 
                            instalacion.SelectedValue = rdr["idinstalacion"].ToString();

                            instalacionext.Text = rdr["instalacionext"].ToString();
                            instalaciondomext.Text = rdr["instalaciondomext"].ToString();

                            if (instalacion.SelectedValue == "9999")
                                extramuros.Visible = true;
                            else
                                extramuros.Visible = false;
                        }

                        if (rdr["idarea"].GetType() != typeof(DBNull)) { 
                            
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


                        if (rdr["estatus"].ToString().Equals("EN REVISION")) {
                            bloqueo = "$('#tbgenerales *').attr('disabled', true);";
                            bloqueo += "$('#tbcostos *').attr('disabled', true);";
                            bloqueo += "$('#tbhorario *').attr('disabled', true);";
                            bloqueo += "$('#baprobar').show();";
                            bloqueo += "$('#brechazar').show();";
                            //bloqueo += "$('#bcerrar').show();";
                            //bloqueo = "$('#tbgenerales *').attr('disabled', true);";
                        }
                        else{
                            bloqueo = "$('#tbgenerales *').attr('disabled', true);";
                            bloqueo +=  "$('#tbcostos *').attr('disabled', true);";
                            bloqueo += "$('#tbhorario *').attr('disabled', true);";
                            bloqueo += "$('#baprobar').hide();";
                            bloqueo += "$('#brechazar').hide();";
                            //bloqueo += "$('#bcerrar').hide();";
                        }
                        

                    }

                    rdr.Close();



                    rdr = (new MySqlCommand(string.Concat("select * from  (  (  select idfecha, cast(fecha as char) as fecha, cast(TIME_FORMAT(horaini, '%H:%i') as char) as horaini, cast(TIME_FORMAT(horafin, '%H:%i') as char) as horafin, concat(cast(TIME_FORMAT(horaini, '%H:%i') as char), ' - ', cast(TIME_FORMAT(horafin, '%H:%i') as char)) as horario, 'SI' as dia  from fechascurso  where idcurso =", this.idP.Value, "  )  union  (  SELECT -1 as idfecha, cast(fecha as char) as fecha, '' as horaini, '' as horafin, '' as horario, (select case  when dayofweek(fecha) in(select distinct(dayofweek(f.fecha)) from fechascurso f where f.idcurso = ", this.idP.Value, ") then' SI'  ELSE 'NO'  end )AS dia   from fechaslibres  where fecha not in(select fecha from fechascurso where idcurso=", this.idP.Value, ") ) )as v  order by v.fecha "), con)).ExecuteReader();
                    json = string.Concat(json, "[");
                    if (rdr.HasRows)
                    {
                        while (rdr.Read())
                        {
                            json = string.Concat(json, "{");
                            json = string.Concat(json, "id:'", rdr["idfecha"].ToString(), "',");
                            if (rdr["idfecha"].ToString().Equals("-1"))
                            {
                                json = string.Concat(json, "color:'#967ADC',");
                                json = string.Concat(json, "title:'INHÁBIL',");
                                json = string.Concat(json, "description:'NO SE LABORA',");
                            }
                            else
                            {
                                json = string.Concat(json, "title:'", rdr["horario"].ToString(), "',");
                                json = string.Concat(new string[] { json, "description:'", rdr["horaini"].ToString(), " - ", rdr["horafin"].ToString(), "'," });
                            }
                            json = string.Concat(json, "fecha:'", rdr["fecha"].ToString(), "',");
                            json = string.Concat(json, "dia:'", rdr["dia"].ToString(), "',");
                            json = string.Concat(json, "horaini:'", rdr["horaini"].ToString(), "',");
                            json = string.Concat(json, "horafin:'", rdr["horafin"].ToString(), "',");
                            json = string.Concat(json, "start:'", rdr["fecha"].ToString(), "',");
                            json = string.Concat(json, "end:'", rdr["fecha"].ToString(), "'");
                            json = string.Concat(json, "},");
                        }
                    }
                    json = string.Concat(json, "]");
                    rdr.Close();

                    listadoAlumnos(sender,e);
                    listadoHistorial(sender, e);
                    listadoObjetivos(sender, e);
                    ScriptManager.RegisterStartupScript(this, GetType(), "myScriptName", "cerrarLoading();  $('#bootstrap').modal('show'); $('#tabgenerales').click(); $('#fc-basic-views').fullCalendar('render'); dar(); "+bloqueo+"", true);
                    ScriptManager.RegisterStartupScript(this, GetType(), "inicilizarMun", "dataEvent =" + json, true);

                }
                    

            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("ERROR:" + ex.Message.Replace("\r\n", ""));
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

                    String query = "select * from " +
                                   " ( " +
                                   " ( " +
                                   " select idfecha, cast(fecha as char) as fecha, cast(TIME_FORMAT(horaini, '%H:%i') as char) as horaini, cast(TIME_FORMAT(horafin, '%H:%i') as char) as horafin, concat(cast(TIME_FORMAT(horaini, '%H:%i') as char), ' - ', cast(TIME_FORMAT(horafin, '%H:%i') as char)) as horario " +
                                   " from fechascurso " +
                                   " where idcurso =" + idP.Value + " " +
                                   " ) " +
                                   " union " +
                                   " ( " +
                                   " SELECT 0 as idfecha, cast(fecha as char) as fecha, '' as horaini, '' as horafin, '' as horario " +
                                   " from fechaslibres " +
                                   " ) " +
                                   " )as v " +
                                   " order by v.fecha ";

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

                            if (rdr["idfecha"].ToString().Equals("0"))
                            {
                                json += "color:'#967ADC',";
                                json += "title:'INHÁBIL',";
                                json += "description:'NO SE LABORA',";

                            }

                            else
                            {
                                json += "title:'" + rdr["horario"].ToString() + "',";
                                json += "description:'" + rdr["horaini"].ToString() + " - " + rdr["horafin"].ToString() + "',";
                            }

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
            String bloqueo = "";
            try
            {
                idP.Value = "0";
                clave.Text = "";
                nombre.Text = "";
                tipocurso.ClearSelection();
                instructor.ClearSelection();
                instalacion.ClearSelection();
                area.ClearSelection();
                Dsespecialidades.DataBind();
                especialidad.DataBind();
                especialidad.ClearSelection();

                fechalimite.Text = "";
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
                alumnosminimo.Text = "";

                bloqueo = "$('#tbgenerales *').removeAttr('disabled');";
                bloqueo += "$('#tbcostos *').removeAttr('disabled');";
                bloqueo += "$('#tbhorario *').removeAttr('disabled');";
                


                listadoAlumnos(sender, e);
                listadoHistorial(sender, e);


            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("ERROR:" + ex.Message.Replace("\r\n", ""));
            }

            //ScriptManager.RegisterClientScriptBlock(Page, typeof(string), "myScriptName", "cerrarLoading();", true);
            ScriptManager.RegisterStartupScript(this, GetType(), "myScriptName", "cerrarLoading(); $('#tabgenerales').click(); $('#bootstrap').modal('show');  $('#fc-basic-views').fullCalendar('render'); dar(); " + bloqueo + "", true);
            ScriptManager.RegisterStartupScript(this, GetType(), "inicilizarMun", "dataEvent =" + json, true);
            //gridFechas.DataBind();

        }

        protected void listadoObjetivos(object sender, EventArgs e)
        {

            try
            {

                GVobjetivos.DataSourceID = DSobjetivos.ID;

                String query = "SELECT idobjetivo, objetivo " +
                               "from cursoobjetivo " +
                               "where idcurso = " + idP.Value;

                DSobjetivos.SelectCommand = query;

            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("ERROR:" + ex.Message.Replace("\r\n", ""));
            }

        }

        protected void guardaEdita(object sender, EventArgs e)
        {

            
            using (MySqlConnection con = new MySqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {

                MySqlTransaction transaction = null;
                MySqlDataReader reader = null;

                String query = "";
                int idcurso = 0;

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
                        query = "insert into curso(idsucursal, idcicloescolar, clave, nombre, idtipocurso, idarea, idespecialidad, idinstructor, idinstalacion, fechaini, fechafin, dias, horaini, horafin, horas, costomodulo, costo, pagohora, observaciones, estatus, pagado, diascurso, idtipooferta, instalacionext, alumnosminimo, fechalimite, instalaciondomext, solicita, autoriza) " +
                                           "values(@idsucursal, @idcicloescolar, @clave, @nombre, @idtipocurso, @idarea, @idespecialidad, @idinstructor, @idinstalacion, @fechaini, @fechafin, @dias, @horaini, @horafin, @horas, @costomodulo, @costo, @pagohora, @observaciones, 'EN CAPTURA', 0, @diascurso, @idtipooferta, @instalacionext, @alumnosminimo, @fechalimite, @instalaciondomext, (select encargado from sucursal where idsucursal=@idsucursal), 'PROF. GERSOM PÉREZ RAMÍREZ'); ";

                        cmd.CommandText = query;
                        cmd.Parameters.AddWithValue("@idcicloescolar", 1);
                        cmd.Parameters.AddWithValue("@idsucursal", idsucursal);
                        cmd.Parameters.AddWithValue("@nombre", nombre.Text.ToUpper().Trim());
                        cmd.Parameters.AddWithValue("@clave", clave.Text.ToUpper().Trim());
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


                        cmd.Parameters.Clear();
                        query = "insert into historialcurso(idcurso, idusuario, fecha, hora, observacion) " +
                                           "values(@idcurso, @idusuario, curdate(), curtime(), @observacion); ";

                        cmd.CommandText = query;
                        cmd.Parameters.AddWithValue("@idcurso", idP.Value);
                        cmd.Parameters.AddWithValue("@idusuario", idusuario);
                        cmd.Parameters.AddWithValue("@observacion", "DADO DE ALTA");

                        cmd.ExecuteNonQuery();

                        listadoHistorial(sender, e);


                    }
                    //SI NO SE ACTUALIZAN LOS DATOS DEL CURSO
                    else
                    {
                        

                        cmd.Parameters.Clear();
                        query = "update curso set clave=@clave, nombre=@nombre, idcicloescolar=@idcicloescolar, idtipocurso=@idtipocurso, idarea=@idarea, idespecialidad=@idespecialidad, idinstructor=@idinstructor, idinstalacion=@idinstalacion, fechaini=@fechaini, fechafin=@fechafin, dias=@dias, horaini=@horaini, horafin=@horafin, horas=@horas, " +
                                " costomodulo=@costomodulo, costo=@costo, pagohora=@pagohora, observaciones=@observaciones, diascurso=@diascurso, idtipooferta=@idtipooferta, instalacionext=@instalacionext, alumnosminimo=@alumnosminimo, fechalimite=@fechalimite, instalaciondomext=@instalaciondomext ";
                        
                        query = query + "where idcurso=@idcurso;";


                        cmd.CommandText = query;

                        cmd.Parameters.AddWithValue("@idcurso", idP.Value);
                        cmd.Parameters.AddWithValue("@idcicloescolar", 1);

                        cmd.Parameters.AddWithValue("@clave", clave.Text.ToUpper().Trim());
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

                        if(!costomodulo.Text.Equals(""))
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
                int idcurso = 0;
               
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
                        query = "insert into curso(idsucursal, idcicloescolar, clave, nombre, idtipocurso, idarea, idespecialidad, idinstructor, idinstalacion, fechaini, fechafin, dias, horaini, horafin, horas, costomodulo, costo, pagohora, observaciones, estatus, pagado, diascurso, idtipooferta, instalacionext, alumnosminimo, fechalimite, instalaciondomext, solicita, autoriza) " +
                                           "values(@idsucursal, @idcicloescolar, @clave, @nombre, @idtipocurso, @idarea, @idespecialidad, @idinstructor, @idinstalacion, @fechaini, @fechafin, @dias, @horaini, @horafin, @horas, @costomodulo, @costo, @pagohora, @observaciones, 'EN CAPTURA', 0, @diascurso, @idtipooferta, @instalacionext, @alumnosminimo, @fechalimite, @instalaciondomext, (select encargado from sucursal where idsucursal=@idsucursal), 'PROF. GERSOM PÉREZ RAMÍREZ'); ";

                        cmd.CommandText = query;
                        cmd.Parameters.AddWithValue("@idcicloescolar", 1);
                        cmd.Parameters.AddWithValue("@idsucursal", idsucursal);
                        cmd.Parameters.AddWithValue("@nombre", nombre.Text.ToUpper().Trim());
                        cmd.Parameters.AddWithValue("@clave", clave.Text.ToUpper().Trim());
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


                        cmd.Parameters.Clear();
                        query = "insert into historialcurso(idcurso, idusuario, fecha, hora, observacion) " +
                                           "values(@idcurso, @idusuario, curdate(), curtime(), @observacion); ";

                        cmd.CommandText = query;
                        cmd.Parameters.AddWithValue("@idcurso", idP.Value);
                        cmd.Parameters.AddWithValue("@idusuario", idusuario);
                        cmd.Parameters.AddWithValue("@observacion", "DADO DE ALTA");

                        cmd.ExecuteNonQuery();


                    }
                    //SI NO SE ACTUALIZAN LOS DATOS DEL CURSO
                    else
                    {


                        cmd.Parameters.Clear();
                        query = "update curso set clave=@clave, nombre=@nombre, idcicloescolar=@idcicloescolar, idtipocurso=@idtipocurso, idarea=@idarea, idespecialidad=@idespecialidad, idinstructor=@idinstructor, idinstalacion=@idinstalacion, fechaini=@fechaini, fechafin=@fechafin, dias=@dias, horaini=@horaini, horafin=@horafin, horas=@horas, " +
                                " costomodulo=@costomodulo, costo=@costo, pagohora=@pagohora, observaciones=@observaciones, diascurso=@diascurso, idtipooferta=@idtipooferta, instalacionext=@instalacionext, alumnosminimo=@alumnosminimo, fechalimite=@fechalimite, instalaciondomext=@instalaciondomext ";

                        query = query + "where idcurso=@idcurso;";


                        cmd.CommandText = query;

                        cmd.Parameters.AddWithValue("@idcurso", idP.Value);
                        cmd.Parameters.AddWithValue("@idcicloescolar", 1);

                        cmd.Parameters.AddWithValue("@clave", clave.Text.ToUpper().Trim());
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
                    //SI EL CURSO ES NUEVO SE GUARDA 

                    cmd.Parameters.Clear();
                        query = "update curso set estatus='EN REVISION' where idcurso=@idcurso;";

                        cmd.CommandText = query;
                        cmd.Parameters.AddWithValue("@idcurso", idP.Value);                       
                        cmd.ExecuteNonQuery();



                    cmd.Parameters.Clear();
                    query = "insert into historialcurso(idcurso, idusuario, fecha, hora, observacion) " +
                                       "values(@idcurso, @idusuario, curdate(), curtime(), @observacion); ";

                    cmd.CommandText = query;
                    cmd.Parameters.AddWithValue("@idcurso", idP.Value);
                    cmd.Parameters.AddWithValue("@idusuario", idusuario);
                    cmd.Parameters.AddWithValue("@observacion", "ENVIADO A AUTORIZACIÓN DE CURSO");

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

        protected void autorizarCurso(object sender, EventArgs e)
        {


            using (MySqlConnection con = new MySqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {

                MySqlTransaction transaction = null;
                String query = "";
                int idcurso = 0;

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


                    

                    cmd.Parameters.Clear();
                    query = "update curso set estatus='AUTORIZADO' where idcurso=@idcurso;";

                    cmd.CommandText = query;
                    cmd.Parameters.AddWithValue("@idcurso", idP.Value);
                    cmd.ExecuteNonQuery();



                    cmd.Parameters.Clear();
                    query = "insert into historialcurso(idcurso, idusuario, fecha, hora, observacion) " +
                                       "values(@idcurso, @idusuario, curdate(), curtime(), @observacion); ";

                    cmd.CommandText = query;
                    cmd.Parameters.AddWithValue("@idcurso", idP.Value);
                    cmd.Parameters.AddWithValue("@idusuario", idusuario);
                    cmd.Parameters.AddWithValue("@observacion", "AUTORIZACIÓN DE CURSO");

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


        protected void rechazarCurso(object sender, EventArgs e)
        {


            using (MySqlConnection con = new MySqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {

                MySqlTransaction transaction = null;
                String query = "";
                
                int idcurso = 0;

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


                    cmd.Parameters.Clear();


                    if(oprechazo.Value.ToString().Equals("1"))
                        query = "update curso set estatus='OBSERVADO' where idcurso=@idcurso;";
                    else
                        query = "update curso set estatus='RECHAZADO' where idcurso=@idcurso;";

                    cmd.CommandText = query;
                    cmd.Parameters.AddWithValue("@idcurso", idP.Value);
                    cmd.ExecuteNonQuery();



                    cmd.Parameters.Clear();
                    query = "insert into historialcurso(idcurso, idusuario, fecha, hora, observacion) " +
                                       "values(@idcurso, @idusuario, curdate(), curtime(), @observacion); ";

                    cmd.CommandText = query;
                    cmd.Parameters.AddWithValue("@idcurso", idP.Value);
                    cmd.Parameters.AddWithValue("@idusuario", idusuario);

                    if (oprechazo.Value.ToString().Equals("1"))
                        cmd.Parameters.AddWithValue("@observacion", "CURSO OBSERVADO POR MOTIVO:"+observrechazo.Text.ToUpper().Trim());
                    else
                        cmd.Parameters.AddWithValue("@observacion", "CURSO RECHAZADO POR MOTIVO:" + observrechazo.Text.ToUpper().Trim());

                    cmd.ExecuteNonQuery();


                    transaction.Commit();

                    listadoClientes(sender, e);
                    ScriptManager.RegisterStartupScript(this, GetType(), "myScriptName", "cerrarLoading(); $('#wrechazo').modal('hide'); $('#bootstrap').modal('hide');", true);

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
                        query = "insert into curso(idsucursal, idcicloescolar, clave, nombre, idtipocurso, idarea, idespecialidad, idinstructor, idinstalacion, fechaini, fechafin, dias, horaini, horafin, horas, costomodulo, costo, pagohora, observaciones, estatus, pagado, diascurso, idtipooferta, instalacionext, fechalimite, instalaciondomext, solicita, autoriza) " +
                                            "values(@idsucursal, @idcicloescolar, @clave, @nombre, @idtipocurso, @idarea, @idespecialidad, @idinstructor, @idinstalacion, @fechaini, @fechafin, @dias, @horaini, @horafin, @horas, @costomodulo, @costo, @pagohora, @observaciones, 'EN CAPTURA', 0, @diascurso, @idtipooferta, @instalacionext, @fechalimite, @instalaciondomext, (select encargado from sucursal where idsucursal=@idsucursal), 'PROF. GERSOM PÉREZ RAMÍREZ'); ";

                        cmd.CommandText = query;
                        cmd.Parameters.AddWithValue("@idcicloescolar", 1);
                        cmd.Parameters.AddWithValue("@idsucursal", idsucursal);
                        cmd.Parameters.AddWithValue("@clave", clave.Text.ToUpper().Trim());
                        cmd.Parameters.AddWithValue("@nombre", nombre.Text.ToUpper().Trim());
                        cmd.Parameters.AddWithValue("@idtipocurso", tipocurso.SelectedValue);
                        cmd.Parameters.AddWithValue("@idarea", area.SelectedValue);
                        cmd.Parameters.AddWithValue("@idespecialidad", especialidad.SelectedValue);
                        cmd.Parameters.AddWithValue("@idinstructor", instructor.SelectedValue);
                        cmd.Parameters.AddWithValue("@idinstalacion", instalacion.SelectedValue);
                        cmd.Parameters.AddWithValue("@fechaini", fechaini.Text);
                        cmd.Parameters.AddWithValue("@fechafin", fechafin.Text);
                        cmd.Parameters.AddWithValue("@dias", 0);
                        cmd.Parameters.AddWithValue("@horaini", horaini.Text);
                        cmd.Parameters.AddWithValue("@horafin", horafin.Text);
                        cmd.Parameters.AddWithValue("@horas", 0);
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
                        //cmd.Parameters.AddWithValue("@alumnosminimo", alumnosminimo.Text);
                        cmd.Parameters.AddWithValue("@fechalimite", fechalimite.Text);
                        cmd.ExecuteNonQuery();

                        idcurso = (int)cmd.LastInsertedId;
                        idP.Value = idcurso.ToString();

                       
                        cmd.Parameters.Clear();
                        query = "insert into historialcurso(idcurso, idusuario, fecha, hora, observacion) " +
                                           "values(@idcurso, @idusuario, curdate(), curtime(), @observacion); ";

                        cmd.CommandText = query;
                        cmd.Parameters.AddWithValue("@idcurso", idP.Value);
                        cmd.Parameters.AddWithValue("@idusuario", idusuario);
                        cmd.Parameters.AddWithValue("@observacion", "DADO DE ALTA");

                        cmd.ExecuteNonQuery();


                    }
                    //SI NO SE ACTUALIZAN LOS DATOS DEL CURSO
                    else
                    {


                        cmd.Parameters.Clear();
                        query = "update curso set nombre=@nombre, clave=@clave, idcicloescolar=@idcicloescolar, idtipocurso=@idtipocurso, idarea=@idarea, idespecialidad=@idespecialidad, idinstructor=@idinstructor, idinstalacion=@idinstalacion, fechaini=@fechaini, fechafin=@fechafin, dias=@dias, horaini=@horaini, horafin=@horafin, horas=@horas, " +
                                " costomodulo=@costomodulo, costo=@costo, pagohora=@pagohora, observaciones=@observaciones, diascurso=@diascurso, idtipooferta=@idtipooferta, instalacionext=@instalacionext, fechalimite=@fechalimite, instalaciondomext=@instalaciondomext ";

                        query = query + "where idcurso=@idcurso;";


                        cmd.CommandText = query;

                        cmd.Parameters.AddWithValue("@idcurso", idP.Value);
                        cmd.Parameters.AddWithValue("@idcicloescolar", 1);
                        cmd.Parameters.AddWithValue("@clave", clave.Text.ToUpper().Trim());
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
                        //cmd.Parameters.AddWithValue("@alumnosminimo", alumnosminimo.Text);
                        cmd.Parameters.AddWithValue("@fechalimite", fechalimite.Text);


                        cmd.ExecuteNonQuery();

                    }

                    cmd.Parameters.Clear();
                    //SE REVISA SI LA FECHA NO EXISTE YA PARA ESE CURSO
                    cmd.CommandText = "select * from "+
                    "(select adddate('1970-01-01', t4.i * 10000 + t3.i * 1000 + t2.i * 100 + t1.i * 10 + t0.i) fecha from " +
                    " (select 0 i union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t0, " +
                    " (select 0 i union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t1, " +
                    " (select 0 i union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t2, " +
                    " (select 0 i union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t3, " +
                    " (select 0 i union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t4) v " +
                    "where fecha between '"+fechaini.Text + "' and '" + fechafin.Text + "'" +
                    "and DAYOFWEEK(fecha) in ("+hdias.Value+")";

                    listafechas = new List<fechascurso>();

                    reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        fechascurso item = new fechascurso();
                        item.fecha = reader.GetString(0);
                        listafechas.Add(item);
                    }
                    reader.Close();
                    reader.Dispose();


                    cmd.Parameters.Clear();
                    cmd.CommandText = "SELECT COALESCE(MAX(idfecha),0)as idfecha FROM fechascurso where idcurso=" + idP.Value + ";";


                    //reader = cmd.ExecuteReader();
                    //while (reader.Read())
                   // {
                        idfecha = Convert.ToInt32(cmd.ExecuteScalar());
                    //}
                    //reader.Close();
                    //reader.Dispose();


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
                    cmd.CommandText = "select ROUND(sum(TIME_TO_SEC(TIMEDIFF(horafin, horaini))/3600),0)as horas from fechascurso where idcurso =" + idP.Value + ";";


                    //reader = cmd.ExecuteReader();
                    //while (reader.Read())
                   // {
                        nohoras = Convert.ToInt32(cmd.ExecuteScalar());
                    // }
                    // reader.Close();
                    // reader.Dispose();

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

                getCalendario(sender, e);
                ScriptManager.RegisterStartupScript(this, GetType(), "myScriptName", "cerrarLoading(); ", true);

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
                        //cmd.Parameters.AddWithValue("@horaini", horanini.Text);
                        //cmd.Parameters.AddWithValue("@horafin", horanfin.Text);

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
                                            "WHERE idsucursal ="+idsucursal+ " and estatus in ('EN REVISION','AUTORIZADO','OBSERVADO','RECHAZADO')  ";

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
            //DsUsuarios.DataBind();
            //lusuarios.DataBind();
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

        void ExportToPDF(Telerik.Reporting.Report reportToExport, string nombre)
        {

            ReportProcessor reportProcessor = new ReportProcessor();
            Telerik.Reporting.InstanceReportSource instanceReportSource = new Telerik.Reporting.InstanceReportSource();
            instanceReportSource.ReportDocument = reportToExport;
            RenderingResult result = reportProcessor.RenderReport("PDF", instanceReportSource, null);

            string fileName = nombre + "." + result.Extension;

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


        void SaveReport(Telerik.Reporting.Report report, string fileName)
        {
            ReportProcessor reportProcessor = new ReportProcessor();
            Telerik.Reporting.InstanceReportSource instanceReportSource = new Telerik.Reporting.InstanceReportSource();
            instanceReportSource.ReportDocument = report;
            RenderingResult result = reportProcessor.RenderReport("PDF", instanceReportSource, null);

            using (FileStream fs = new FileStream(fileName, FileMode.Create))
            {
                fs.Write(result.DocumentBytes, 0, result.DocumentBytes.Length);
            }
        }

        protected void bimprimir_Click(object sender, EventArgs e)
        {
            ReportLibrary.SolicitudAutorizacionCurso reporte = new ReportLibrary.SolicitudAutorizacionCurso();
            reporte.ReportParameters["idsucursal"].Value = idS.Value;
            reporte.ReportParameters["idcurso"].Value = idP.Value;
            // ReportLibrary.FormatoEscolaridadMexico reporte = new ReportLibrary.FormatoEscolaridadMexico();

            ExportToPDF(reporte, "SOLICITUD AUTORIZACION " + cve.Value);

            // SaveReport(new ReportLibrary.SolicitudAutorizacionCurso(), @"C:\MyReport.pdf");


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