using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;
using System.Drawing;

namespace elecion.tickets
{
    public partial class listadoprestamos : System.Web.UI.Page
    {
        int idtipousuario;
        int idusuario;
        int idsucursal;
        protected void Page_Load(object sender, EventArgs e)
        {
            var idu = (FormsIdentity)Page.User.Identity;
            var ticket = idu.Ticket;
            string[] datos = ticket.UserData.Split(',');
            string[] datos2 = datos[1].Split(';');

            idusuario = Convert.ToInt32(datos[0]);
            idtipousuario = Convert.ToInt32(datos2[3]);
            idsucursal = Convert.ToInt32(datos2[4]);

            //TECNICO
            if (idtipousuario == 4)
            {
                nuevo.Visible = false;
                //datiende.Visible = false;
            }

            if (!IsPostBack) {
               
                listadoTickets(sender, e);
            }

            /*ScriptManager.RegisterClientScriptBlock(this, GetType(), "myScriptName", "$('.cks').iCheck({checkboxClass: 'icheckbox_flat-green',increaseArea: '20%'});"+
            "$('.cks').on('ifChecked', function (event) { "+
            "var actual = this;           "+
            "$('#refrendar_' + actual.id).click(); " +
            "var aux = actual.id; "+

            "$('.cks').each(function(id) { " +
            "    if (this.id != actual.id) " +
            "    {" +
            "        $(this).iCheck('uncheck'); " +
            "    } " +
            "}); " +
          "});", true);*/
        }

        protected void nuevoRegistro(object sender, EventArgs e)
        {
            Session["idP"] = idP.Value;
            Response.Redirect("~/prestamos/agregarprestamo.aspx");           

        }

        protected void editarRegistro(object sender, EventArgs e)
        {
            Session["idP"] = idP.Value;
            Response.Redirect("~/prestamos/agregarprestamo.aspx");
        }

        protected void conteoRegistros(object sender, EventArgs e)
        {
            using (MySqlConnection con2 = new MySqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {
                try
                {
                    con2.Open();
                    string query = "select count(e.idempeno)as total "+
                           "from empeno e left " +
                           "join cliente c on c.idcliente = e.idcliente and c.idsucursal = e.idsucursal " +
                           "left join articulo a on a.idarticulo = e.idarticulo and a.idsucursal = e.idsucursal " +
                           "left join usuario u on u.idusuario = e.idusuario and u.idsucursal = e.idsucursal where e.idsucursal = " + idsucursal+" and e.etapa in ('PRESTAMO','PRESTAMO REFRENDO') ";

                    if (bfolio.Text.Trim() != "")
                        query = query + " AND e.folio LIKE '%" + bfolio.Text.ToUpper() + "%' ";

                    if (bcliente.Text.Trim() != "")
                        query = query + " AND c.ncompleto LIKE '%" + bcliente.Text.ToUpper() + "%' ";

                    if (barticulo.Text.Trim() != "")
                        query = query + " AND a.descripcion LIKE '%" + barticulo.Text.ToUpper() + "%' ";

                    if (bcodigo.Text.Trim() != "")
                        query = query + " AND e.codigo ='" + bcodigo.Text.Trim() + "' ";

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
    

        protected void listadoTickets(object sender, EventArgs e)
        {
            /*int limit = 12;
            int pag = Convert.ToInt32(pagina.Value);

            int offset = 0;

            if (pag > 1)
            {
                offset = limit * (pag - 1);
            }*/

            dlCustomers.DataSourceID = DSTickets.ID;

            String query = "select e.idempeno, e.idsucursal, e.folio, e.concepto, cast(e.fechaempeno as char) as fechaempeno, cast(e.horaempeno as char)as horaempeno, e.prestamo, e.etapa, "+
                           "c.ncompleto as cliente, c.celular, a.idarticulo, a.descripcion, (CONCAT(COALESCE(u.nombre, ''), ' ', COALESCE(u.apaterno, ''), ' ', COALESCE(u.amaterno, ''))) as usuario,  " +
                           "cast(e.fechavence as char) as fechavence,DATEDIFF(current_date, e.fechainicia) as dias , (e.diasventa + e.diastolerancia) as diascomerc," +

                            /*"case  " +
                            "when DATEDIFF(current_date, e.fechainicia) > (select d.diafin from detalleplazoempeno d where d.idplazo = e.idplazo order by d.diafin desc limit 1) then " +
                            "coalesce(round( " +
                            "((( " +
                            "select d.porcentaje " +
                            "from detalleplazoempeno d " +
                            "where d.idplazo = e.idplazo " +
                            "order by d.diafin desc " +
                            "limit 1 " +
                            ") " +
                            "+ " +
                            "( " +
                            "select e.interesdiario * (DATEDIFF(current_date, e.fechainicia) - (select d.diafin from detalleplazoempeno d where d.idplazo = e.idplazo order by d.diafin desc limit 1)) " +
                            "" +
                            ") " +
                            ")/ 100 )*e.prestamo,2),0) " +

                            "else  " +
                            "coalesce(round( " +
                            "( " +
                            "select d.porcentaje / 100  " +
                            "from detalleplazoempeno d " +
                            "where d.idplazo = e.idplazo " +
                            "and DATEDIFF(current_date, e.fechainicia) between d.diainicio and d.diafin " +
                            ") * e.prestamo,2),0) " +
                            "end as pagar, " +*/


                            "case " +
                            "when DATEDIFF(current_date, e.fechainicia) > (select d.diafin from detalleplazoempeno d where d.idplazo = e.idplazo order by d.diafin desc limit 1) then " +
                            "coalesce " +
                            "(round( " +
                            "( " +
                            "select d.porcentaje / 100  " +
                            "from detalleplazoempeno d " +
                            "where d.idplazo = e.idplazo " +
                            "order by d.diafin desc " +
                            "limit 1 " +
                            ") * e.prestamo " +
                            ", 2) " +
                            ",0) " +
                            "else coalesce( " +
                            "round( " +
                            "( " +
                            "select d.porcentaje / 100 " +
                            "from detalleplazoempeno d " +
                            "where d.idplazo = e.idplazo " +
                            "and DATEDIFF(current_date, e.fechainicia) between d.diainicio and d.diafin " +
                            ") * e.prestamo, 2),0) " +
                            "end as pagar, " +
                            "case  " +
                            "when DATEDIFF(current_date, e.fechainicia) < (select d.diafin from detalleplazoempeno d where d.idplazo = e.idplazo order by d.diafin desc limit 1) then 0 " +
                            "else  " +
                             "  CASE " +
                             "    when DATE_ADD(e.fechainicia, INTERVAL(select d.diafin + 10 from detalleplazoempeno d where d.idplazo = e.idplazo order by d.diafin desc limit 1) DAY) >= current_date and DAYOFWEEK(current_date) = 5 then 0 " +
                             "    else " +
                                        "( " +
                                        " e.interesdiario * (DATEDIFF(current_date, e.fechainicia) - (select d.diafin from detalleplazoempeno d where d.idplazo = e.idplazo order by d.diafin desc limit 1)) " +
                                        "*e.prestamo " +
                                        ") " +
                                    "end " +

                            "end as recargos, " +
                            "case " +
                            "when DATEDIFF(current_date, e.fechainicia) > (select d.diafin from detalleplazoempeno d where d.idplazo = e.idplazo order by d.diafin desc limit 1) then " +
                            "coalesce(round( " +
                            "((( " +
                            "select d.porcentaje " +
                            "from detalleplazoempeno d " +
                            "where d.idplazo = e.idplazo " +
                            "order by d.diafin desc " +
                            "limit 1 " +
                            ") " +

                            ") " +
                            ")),3) " +

                            "else coalesce( " +
                            "round( " +
                            "( " +
                            "select d.porcentaje " +
                            "from detalleplazoempeno d " +
                            "where d.idplazo = e.idplazo " +
                            "and DATEDIFF(current_date, e.fechainicia) between d.diainicio and d.diafin " +
                            "), 0),0) " +
                            "end as tasa " +

                            "from empeno e " +
                            "left join cliente c on c.idcliente = e.idcliente and c.idsucursal = e.idsucursal " +
                            "left join articulo a on a.idarticulo = e.idarticulo and a.idsucursal = e.idsucursal " +
                            "left join usuario u on u.idusuario = e.idusuario and u.idsucursal = e.idsucursal " +
                            "where e.idsucursal = " +idsucursal+" and e.etapa in ('PRESTAMO','PRESTAMO REFRENDO') ";

           
            if (bfolio.Text.Trim() != "")
                query = query + " AND e.folio LIKE '%" + bfolio.Text.ToUpper() + "%' ";

            if (bcliente.Text.Trim() != "")
                query = query + " AND c.ncompleto LIKE '%" + bcliente.Text.ToUpper() + "%' ";

            if (barticulo.Text.Trim() != "")
                query = query + " AND a.descripcion LIKE '%" + barticulo.Text.ToUpper() + "%' ";

            if (bcodigo.Text.Trim() != "")
                query = query + " AND e.codigo ='" + bcodigo.Text.Trim() + "' ";

            query = query + " ORDER BY e.fechaempeno desc, e.horaempeno desc ";
            //query = query + " LIMIT "+limit+" OFFSET "+offset;
            DSTickets.SelectCommand = query;

            DSTickets.DataBind();
            dlCustomers.DataBind();

            idP.Value = "0";
            idS.Value = "0";


            //ScriptManager.RegisterClientScriptBlock(Page, typeof(string), "myScriptName", "cerrarLoading();", true);
            //gridSeguimiento.DataBind();

        }


        protected void listadoHistorial(object sender, EventArgs e)
        {
            /*int limit = 12;
            int pag = Convert.ToInt32(pagina.Value);

            int offset = 0;

            if (pag > 1)
            {
                offset = limit * (pag - 1);
            }*/

            ghistorial.DataSourceID = DShistorial.ID;

            String query = "select h.idhistorial, h.idempeno, h.idsucursal, h.idtipomovimiento, cast(h.fecha as char)as fecha, cast(h.hora as char)as hora, t.tipomovimiento, h.importe, h.estatus, e.folio " +
                           " from historialempeno h " +
                           " left join tipomovimiento t on t.idtipomovimiento = h.idtipomovimiento " +
                           " left join empeno e on e.idempeno= h.idempeno and e.idsucursal = h.idsucursal " +
                           " where h.idempeno = " +idP.Value+ " " +
                           " and h.idsucursal = "+idS.Value;

            DShistorial.SelectCommand = query;

            DShistorial.DataBind();
            ghistorial.DataBind();


           // ScriptManager.RegisterClientScriptBlock(Page, typeof(string), "myScriptName", "cerrarLoading(); $('#mhistorial').modal('show');", true);

            ScriptManager.RegisterStartupScript(this, GetType(), "myScriptName", "cerrarLoading(); $('#mhistorial').modal('show');", true);

            //gridSeguimiento.DataBind();

        }
        protected void refrendaEmpeno(object sender, EventArgs e)
        {

            int idhistorial = 0;
            int idmovimiento = 0;
          
            using (MySqlConnection con = new MySqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {

                MySqlTransaction transaction = null;
                MySqlDataReader reader = null;

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

                    //SI EL CLIENTE ES NUEVO SE GUARDA PRIMERO 
                
                        //cmd.Parameters.Clear();
                        cmd.CommandText = "SELECT COALESCE(MAX(idhistorial),0)as idhistorial FROM historialempeno where idempeno="+idP.Value+" and idsucursal=" + idS.Value + ";";


                        reader = cmd.ExecuteReader();
                        while (reader.Read())
                        {
                            idhistorial = reader.GetInt32(0) + 1;
                        }
                        reader.Close();

                        cmd.Parameters.Clear();
                        query = "insert into historialempeno(idhistorial, idempeno, idsucursal, idtipomovimiento, idsucursalmovimiento, idusuario, fecha, hora, estatus, importe, fechainicia, fechavence, fechacomercializacion) " +
                                                    "values(@idhistorial, @idempeno, @idsucursal, @idtipomovimiento, @idsucursalmovimiento, @idusuario, current_date, current_time, 'CERRADO', @importe, (select e.fechainicia from empeno e where e.idempeno = @idempeno and idsucursal=@idsucursal) , (select ADDDATE(current_date, INTERVAL (e.diasventa) DAY) from empeno e where e.idempeno = @idempeno and idsucursal=@idsucursal), (select ADDDATE(current_date, INTERVAL (e.diasventa+e.diastolerancia) DAY) from empeno e where e.idempeno = @idempeno and idsucursal=@idsucursal) ); ";

                        cmd.CommandText = query;
                        cmd.Parameters.AddWithValue("@idhistorial", idhistorial);
                        cmd.Parameters.AddWithValue("@idempeno", idP.Value);
                        cmd.Parameters.AddWithValue("@idsucursal", idS.Value);
                        
                        cmd.Parameters.AddWithValue("@idtipomovimiento", idO.Value);
                        cmd.Parameters.AddWithValue("@idsucursalmovimiento", idsucursal);
                        cmd.Parameters.AddWithValue("@idusuario", idusuario);
                        cmd.Parameters.AddWithValue("@importe", hpago.Value);                        
                        cmd.ExecuteNonQuery();


                    //UPDATE A TABLA EMPEÑO
                    cmd.Parameters.Clear();

                    if (idO.Value.Equals("1"))
                        query = "update empeno set fecharefrendo=current_date, horarefrendo=current_time, fechainicia=current_date, fechavence=ADDDATE(current_date, INTERVAL (diasventa) DAY), fechacomercializacion=ADDDATE(current_date, INTERVAL (diasventa+diastolerancia) DAY), etapa=@etapa where idempeno=@idempeno and idsucursal=@idsucursal;";
                    else if (idO.Value.Equals("2"))
                        query = "update empeno set fechaenajenacion=current_date, horaenajenacion=current_time, etapa=@etapa where idempeno=@idempeno and idsucursal=@idsucursal;";
                    else if (idO.Value.Equals("6"))
                        query = "update empeno set fechadesempeno=current_date, horadesempeno=current_time, etapa=@etapa where idempeno=@idempeno and idsucursal=@idsucursal;";

                    cmd.CommandText = query;
                    
                    cmd.Parameters.AddWithValue("@idempeno", idP.Value);
                    cmd.Parameters.AddWithValue("@idsucursal", idS.Value);

                    if(idO.Value.Equals("1"))
                        cmd.Parameters.AddWithValue("@etapa", "PRESTAMO REFRENDO");
                    else if (idO.Value.Equals("2"))
                        cmd.Parameters.AddWithValue("@etapa", "ENAJENACION");
                    else if(idO.Value.Equals("6"))
                        cmd.Parameters.AddWithValue("@etapa", "DESEMPEÑO");

                    cmd.ExecuteNonQuery();


                    if (!idO.Value.Equals("2"))
                    {

                        // MOVIMIENTOS DIARIOS
                        cmd.Parameters.Clear();
                        cmd.CommandText = "SELECT COALESCE(MAX(idmovimiento),0)as idmovimiento FROM movimientos where idsucursal=" + idS.Value + " ;";


                        reader = cmd.ExecuteReader();
                        while (reader.Read())
                        {
                            idmovimiento = reader.GetInt32(0) + 1;
                        }
                        reader.Close();


                        cmd.Parameters.Clear();
                        query = "insert into movimientos(idmovimiento, idsucursal, idusuario, fecha, hora, concepto, importe, tipo) " +
                                "values(@idmovimiento, @idsucursal, @idusuario, current_date, current_time, @concepto, @importe, @tipo); ";

                        cmd.CommandText = query;
                        cmd.Parameters.AddWithValue("@idmovimiento", idmovimiento);
                        cmd.Parameters.AddWithValue("@idsucursal", idS.Value);
                        cmd.Parameters.AddWithValue("@idusuario", idusuario);


                        if (idO.Value.Equals("1"))
                        {
                            cmd.Parameters.AddWithValue("@concepto", "REFRENDO DEL FOLIO " + idF.Value);
                            cmd.Parameters.AddWithValue("@tipo", "R");
                        }
                            

                        else if (idO.Value.Equals("6"))
                        {
                            cmd.Parameters.AddWithValue("@concepto", "DESEMPEÑO DEL FOLIO " + idF.Value);
                            cmd.Parameters.AddWithValue("@tipo", "D");
                        }
                            


                        cmd.Parameters.AddWithValue("@importe", hpago.Value);
                        cmd.ExecuteNonQuery();

                    }



                    transaction.Commit();

                    var url = "";

                    if (idO.Value.Equals("1"))
                        url = "../reportes/RVTicket.aspx?idempeno=" + idP.Value + "&idsucursal=" + idS.Value + "&idhistorial=" + idhistorial;
                    else if (idO.Value.Equals("6"))
                        url = "../reportes/RVTicketDesempeno.aspx?idempeno=" + idP.Value + "&idsucursal=" + idS.Value + "&idhistorial=" + idhistorial;

                    if (!idO.Value.Equals("2"))
                        ScriptManager.RegisterStartupScript(this, GetType(), "myScriptName", "window.open('" + url + "','_blank');", true);

                    listadoTickets(sender, e);

                    idP.Value = "0";
                    idS.Value = "0";

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
                }

                //ScriptManager.RegisterStartupScript(this, GetType(), "cerrar", "$('.modal-backdrop').remove();", true);
                // refrescaGrid(sender, e);

            }


        }



        protected void cancelaEmpeno(object sender, EventArgs e)
        {

            int idhistorial = 0;
            int idmovimiento = 0;

            using (MySqlConnection con = new MySqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {

                MySqlTransaction transaction = null;
                MySqlDataReader reader = null;

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

                    //SI EL CLIENTE ES NUEVO SE GUARDA PRIMERO 

                    //cmd.Parameters.Clear();
                    cmd.CommandText = "SELECT COALESCE(MAX(idhistorial),0)as idhistorial FROM historialempeno where idempeno=" + idP.Value + " and idsucursal=" + idS.Value + ";";


                    reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        idhistorial = reader.GetInt32(0) + 1;
                    }
                    reader.Close();

                    cmd.Parameters.Clear();
                    query = "insert into historialempeno(idhistorial, idempeno, idsucursal, idtipomovimiento, idsucursalmovimiento, idusuario, fecha, hora, estatus, importe, fechainicia, fechavence, fechacomercializacion) " +
                                                "values(@idhistorial, @idempeno, @idsucursal, @idtipomovimiento, @idsucursalmovimiento, @idusuario, current_date, current_time, 'CERRADO',(select e.prestamo*-1 from empeno e where e.idempeno = @idempeno and idsucursal=@idsucursal) , (select e.fechainicia from empeno e where e.idempeno = @idempeno and idsucursal=@idsucursal) , (select ADDDATE(current_date, INTERVAL (e.diasventa) DAY) from empeno e where e.idempeno = @idempeno and idsucursal=@idsucursal), (select ADDDATE(current_date, INTERVAL (e.diasventa+e.diastolerancia) DAY) from empeno e where e.idempeno = @idempeno and idsucursal=@idsucursal) ); ";

                    cmd.CommandText = query;
                    cmd.Parameters.AddWithValue("@idhistorial", idhistorial);
                    cmd.Parameters.AddWithValue("@idempeno", idP.Value);
                    cmd.Parameters.AddWithValue("@idsucursal", idS.Value);

                    cmd.Parameters.AddWithValue("@idtipomovimiento", 101);
                    cmd.Parameters.AddWithValue("@idsucursalmovimiento", idsucursal);
                    cmd.Parameters.AddWithValue("@idusuario", idusuario);
                   
                    cmd.ExecuteNonQuery();


                    //UPDATE A TABLA EMPEÑO
                    cmd.Parameters.Clear();
                   
                    query = "update empeno set estatus='CANCELADO', etapa='CANCELADO' where idempeno=@idempeno and idsucursal=@idsucursal;";
                    cmd.CommandText = query;
                    cmd.Parameters.AddWithValue("@idempeno", idP.Value);
                    cmd.Parameters.AddWithValue("@idsucursal", idS.Value);

                    cmd.ExecuteNonQuery();

                    
                        // MOVIMIENTOS DIARIOS
                        cmd.Parameters.Clear();
                        cmd.CommandText = "SELECT COALESCE(MAX(idmovimiento),0)as idmovimiento FROM movimientos where idsucursal=" + idS.Value + " ;";


                        reader = cmd.ExecuteReader();
                        while (reader.Read())
                        {
                            idmovimiento = reader.GetInt32(0) + 1;
                        }
                        reader.Close();


                        cmd.Parameters.Clear();
                        query = "insert into movimientos(idmovimiento, idsucursal, idusuario, fecha, hora, concepto, importe, tipo) " +
                                "values(@idmovimiento, @idsucursal, @idusuario, current_date, current_time, @concepto, (select e.prestamo*-1 from empeno e where e.idempeno = @idempeno and idsucursal=@idsucursal) , @tipo); ";

                        cmd.CommandText = query;
                        cmd.Parameters.AddWithValue("@idmovimiento", idmovimiento);
                        cmd.Parameters.AddWithValue("@idsucursal", idS.Value);
                        cmd.Parameters.AddWithValue("@idempeno", idP.Value);
                        cmd.Parameters.AddWithValue("@idusuario", idusuario);
                        cmd.Parameters.AddWithValue("@concepto", "CANCELACIÓN EL EMPEÑO FOLIO " + idF.Value);
                        cmd.Parameters.AddWithValue("@tipo", "C");                        

                        
                        cmd.ExecuteNonQuery();
                    
                    transaction.Commit();

                    
                    listadoTickets(sender, e);

                    idP.Value = "0";
                    idS.Value = "0";

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
                }

                ScriptManager.RegisterStartupScript(this, GetType(), "myScriptName", "cerrarLoading();", true);
                //ScriptManager.RegisterStartupScript(this, GetType(), "cerrar", "$('.modal-backdrop').remove();", true);
                // refrescaGrid(sender, e);

            }


        }

        protected void dlCustomers_RowCreated(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.ToolTip = "Click para Seleccionar";
                e.Row.Attributes["onclick"] = ClientScript.GetPostBackClientHyperlink(this.dlCustomers, "Select$" + e.Row.RowIndex);
            }
        }

        protected void dlCustomers_SelectedIndexChanged(object sender, EventArgs e)
        {
            dlCustomers.Rows[dlCustomers.SelectedIndex].BackColor = Color.FromName("#0cf27d");
            //dlCustomers.DataBind();
        }

        protected void dlCustomers_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            // To check condition on integer value
            if (Convert.ToInt16(DataBinder.Eval(e.Row.DataItem, "dias")) > (Convert.ToInt16(DataBinder.Eval(e.Row.DataItem, "diascomerc"))))
            {
                //e.Row.BackColor = System.Drawing.Color.FromArgb(255, 117, 136);

                e.Row.Cells[1].BackColor = System.Drawing.Color.FromArgb(255, 117, 136);
                e.Row.Cells[2].BackColor = System.Drawing.Color.FromArgb(255, 117, 136);
                e.Row.Cells[3].BackColor = System.Drawing.Color.FromArgb(255, 117, 136);
                e.Row.Cells[4].BackColor = System.Drawing.Color.FromArgb(255, 117, 136);
                e.Row.Cells[5].BackColor = System.Drawing.Color.FromArgb(255, 117, 136);
                e.Row.Cells[6].BackColor = System.Drawing.Color.FromArgb(255, 117, 136);
                e.Row.Cells[7].BackColor = System.Drawing.Color.FromArgb(255, 117, 136);

                e.Row.ForeColor = Color.White;
            }
        }

        
    }
}