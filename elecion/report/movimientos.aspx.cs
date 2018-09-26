﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using MySql.Data.MySqlClient;
using System.Web.Security;

namespace elecion.report
{
    public partial class movimientos : System.Web.UI.Page
    {
        private int idusuario;
        private int idsucursal;

        protected void Page_Load(object sender, EventArgs e)
        {

            var idu = (FormsIdentity)Page.User.Identity;
            var ticket = idu.Ticket;
            string[] datos = ticket.UserData.Split(',');
            string[] datos2 = datos[1].Split(';');

            idusuario = Convert.ToInt32(datos[0]);
            idsucursal = Convert.ToInt32(datos2[4]);           
            idS.Value = idsucursal.ToString();

            if (!IsPostBack)
            {
                //if (String.IsNullOrEmpty(lgastos.SortExpression)) lgastos.Sort("fecha", SortDirection.Ascending);

                listadoTickets(sender, e);
            }
        }

        protected void conteoRegistros(object sender, EventArgs e)
        {
            using (MySqlConnection con2 = new MySqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {
                try
                {
                    con2.Open();
                    /*string query = "select count(d.idmovimiento)as total " +
                            "from movimientos d " +
                            "left join sucursal s on d.idsucursal = s.idsucursal " +
                            "left join usuario u on u.idusuario = d.idusuario where true ";


                    if (bfolio.Text.Trim() != "")
                        query = query + " AND d.concepto LIKE '%" + bfolio.Text.ToUpper() + "%' ";

                    if (bfecha.Text.Trim() != "")
                        query = query + " AND d.fecha ='" + bfecha.Text + "' ";

                    MySqlCommand cmd2 = new MySqlCommand(query, con2);

                    MySqlDataReader rdr = cmd2.ExecuteReader();
                    if (rdr.HasRows)
                    {
                        rdr.Read();
                        labelConteo.Text = rdr["total"].ToString();

                    }
                    */

                    lventas.Text = "$ 0.00";
                    lapartados.Text = "$ 0.00";
                    lrefrendos.Text = "$ 0.00";
                    lprestamos.Text = "$ 0.00";

                    string query = "select d.tipo, sum(d.importe)as total " +
                                    "from movimientos d " +
                                    "where d.fecha = '" + bfecha.Text + "' and d.ignorar = 0 " +
                                    "group by d.tipo";

                    MySqlCommand cmd2 = new MySqlCommand(query, con2);

                    MySqlDataReader rdr = cmd2.ExecuteReader();
                    if (rdr.HasRows)
                    {
                        while (rdr.Read())
                        {

                            if(rdr["tipo"].Equals("V"))
                                lventas.Text = "$ "+rdr["total"].ToString();
                            else if (rdr["tipo"].Equals("A"))
                                lapartados.Text = "$ " + rdr["total"].ToString();                           
                            else if (rdr["tipo"].Equals("R"))
                                lrefrendos.Text = "$ " + rdr["total"].ToString();
                            else if (rdr["tipo"].Equals("P"))
                                lprestamos.Text = "$ " + rdr["total"].ToString();

                        }

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

            lgastos.DataSourceID = DsListadoGastos.ID;

            String query = "select s.nombre as sucursal, d.idmovimiento, d.idsucursal, d.concepto, d.importe, cast(d.fecha as char) as fecha, cast(d.hora as char)as hora,  "+
                            "(CONCAT(COALESCE(u.nombre, ''), ' ', COALESCE(u.apaterno, ''), ' ', COALESCE(u.amaterno, ''))) as usuario, d.tipo " +
                            "from movimientos d " +
                            "left join sucursal s on d.idsucursal = s.idsucursal " +
                            "left join usuario u on u.idusuario = d.idusuario where true ";


            if (bfolio.Text.Trim() != "")
                query = query + " AND d.concepto LIKE '%" + bfolio.Text.ToUpper() + "%' ";

            if (bfecha.Text.Trim() != "")
                query = query + " AND d.fecha ='" + bfecha.Text + "' ";

            query = query + " order by d.fecha desc, d.hora desc ";
            DsListadoGastos.SelectCommand = query;

            DsListadoGastos.DataBind();
            lgastos.DataBind();

            idP.Value = "0";            

            //ScriptManager.RegisterClientScriptBlock(Page, typeof(string), "myScriptName", "cerrarLoading();", true);
            //gridSeguimiento.DataBind();

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

                MySqlTransaction transaction = null;
                MySqlDataReader reader = null;

                String query = "";
                int iddet = 0;
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

                    //Si el idmunicipio es mayor que cero se hace UPDATE
                    if (Int32.Parse(idP.Value) > 0)
                    {
                        query = "UPDATE detallecaja set concepto=@concepto, importe=@importe where iddetallecaja=@idP and idsucursal=@idS;";
                        iddet = Convert.ToInt32(idP.Value);
                    }
                        
                    else
                    {

                        cmd.CommandText = "SELECT COALESCE(MAX(iddetallecaja),0)as iddet FROM detallecaja where idsucursal=" + idS.Value + ";";


                        reader = cmd.ExecuteReader();
                        while (reader.Read())
                        {
                            iddet = reader.GetInt32(0) + 1;
                        }
                        reader.Close();

                        cmd.Parameters.Clear();

                        query = "INSERT INTO detallecaja(iddetallecaja, idsucursal, idusuario, fecha, hora, concepto, importe, tipo, estatus) " +
                                                "values( @idP, @idS, @idU, current_date, current_time, @concepto, @importe, 'I', 'ACTIVO');";
                    }

                    cmd.CommandText = query;


                    cmd.Parameters.AddWithValue("@idP", iddet);
                    cmd.Parameters.AddWithValue("@idS", idS.Value);
                    cmd.Parameters.AddWithValue("@idU", idusuario);
                    cmd.Parameters.AddWithValue("@concepto", concepto.Text.ToUpper());
                    cmd.Parameters.AddWithValue("@importe", importe.Text);
                    cmd.ExecuteNonQuery();

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
                listadoTickets(sender, e);

            }


        }

        protected void borrarRegistro(object sender, EventArgs e)
        {
            using (MySqlConnection con = new MySqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {

                try
                {

                    con.Open();
                    String query = "UPDATE detallecaja set estatus='CANCELADO' where iddetallecaja=@idP and idsucursal=@idS;";
                    MySqlCommand cmd = new MySqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@idP", idP.Value);
                    cmd.Parameters.AddWithValue("@idS", idS.Value);
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

                listadoTickets(sender, e);


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