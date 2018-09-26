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

namespace elecion.tickets
{
    public partial class listado : System.Web.UI.Page
    {
        int idtipousuario;
        int idusuario;
        protected void Page_Load(object sender, EventArgs e)
        {
            var idu = (FormsIdentity)Page.User.Identity;
            var ticket = idu.Ticket;
            string[] datos = ticket.UserData.Split(',');
            string[] datos2 = datos[1].Split(';');

            idusuario = Convert.ToInt32(datos[0]);
            idtipousuario = Convert.ToInt32(datos2[3]);

            //TECNICO
            if (idtipousuario == 4)
            {
                nuevo.Visible = false;
                datiende.Visible = false;
            }

            if (!IsPostBack) {
               
                listadoTickets(sender, e);
            }
        }

        protected void nuevoRegistro(object sender, EventArgs e)
        {
            Session["idP"] = idP.Value;
            Response.Redirect("~/tickets/agregar.aspx");
        }

        protected void editarRegistro(object sender, EventArgs e)
        {
            Session["idP"] = idP.Value;
            Response.Redirect("~/tickets/agregar.aspx");
        }

        protected void conteoRegistros(object sender, EventArgs e)
        {
            using (MySqlConnection con2 = new MySqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {
                try
                {
                    con2.Open();
                    string sql2 = "SELECT COUNT(T.IDTICKET) as total "+
                                            "FROM ticket T " +
                                            "WHERE T.ESTATUS='ACTIVO' ";

                    if (idtipousuario == 4)
                        sql2 = sql2 + " AND T.ATIENDE=" + idusuario;

                    MySqlCommand cmd2 = new MySqlCommand(sql2, con2);
                    
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
            int limit = 12;
            int pag = Convert.ToInt32(pagina.Value);

            int offset = 0;

            if (pag > 1)
            {
                offset = limit * (pag - 1);
            }

            dlCustomers.DataSourceID = DSTickets.ID;

            String query = "SELECT T.IDTICKET, T.FOLIO, T.IDCALIFICACION, CAST(T.FECHA AS char)AS FECHA, CAST(T.HORA AS char)AS HORA, T.CONCEPTO, T.OBSERVACIONES, " +
                                            "C.NOMBRE AS CLIENTE, " +
                                            "(CONCAT(COALESCE(U.NOMBRE, ''), ' ', COALESCE(U.APATERNO, ''), ' ', COALESCE(U.AMATERNO, ''))) as atiende, " +
                                            "P.PRIORIDAD " +
                                            "FROM ticket T " +
                                            "LEFT JOIN usuario U on U.IDUSUARIO = T.ATIENDE " +
                                            "LEFT JOIN cliente C on C.IDCLIENTE = T.IDCLIENTE " +
                                            "LEFT JOIN prioridad P on P.IDPRIORIDAD = T.IDPRIORIDAD " +
                                            "WHERE ESTATUS='ACTIVO' ";

            if(idtipousuario==4)
                query = query + " AND T.ATIENDE=" + idusuario;

            if (atiende.SelectedValue != "0")
                query = query + " AND T.ATIENDE=" + Convert.ToInt32(atiende.SelectedValue);

            if (cliente.SelectedValue != "0")
                query = query + " AND T.IDCLIENTE="+Convert.ToInt32( cliente.SelectedValue);

            if (concepto.Text.Trim() != "")
                query = query + " AND T.CONCEPTO LIKE '%" + concepto.Text.Trim() +"%' ";

            query = query + " ORDER BY T.IDTICKET";
            query = query + " LIMIT "+limit+" OFFSET "+offset;
            DSTickets.SelectCommand = query;

            DSTickets.DataBind();
            dlCustomers.DataBind();
           

            //ScriptManager.RegisterClientScriptBlock(Page, typeof(string), "myScriptName", "cerrarLoading();", true);
            //gridSeguimiento.DataBind();

        }


    }
}