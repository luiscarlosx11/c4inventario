using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace elecion.report
{
    public partial class cierre : System.Web.UI.Page
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
                setFecha(sender, e);
                getDatos(sender, e);
            }
        }

        protected void setFecha(Object sender, EventArgs e)
        {
            using (MySqlConnection con2 = new MySqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {
                try
                {
                    con2.Open();
                    string query = "select DATE_FORMAT(current_date,'%Y-%m-%d') as fecha;";

                    MySqlCommand cmd2 = new MySqlCommand(query, con2);

                    MySqlDataReader rdr = cmd2.ExecuteReader();
                    if (rdr.HasRows)
                    {
                        while (rdr.Read())
                        {
                            bfecha.Text = rdr["fecha"].ToString();                            
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

        protected void getDatos(Object sender, EventArgs e)
        {

            using (MySqlConnection con2 = new MySqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["DBconexion"].ConnectionString))
            {
                try
                {
                    con2.Open();
                   
                    lventas.Text = "$ 0.00";
                    lapartados.Text = "$ 0.00";
                    lrefrendos.Text = "$ 0.00";
                    lprestamos.Text = "$ 0.00";

                    Decimal caja =  new Decimal(0);
                    string query = "select "+
                                    "( " +
                                    "   select d.caja " +
                                    "   from cierre d " +
                                    "   where d.idsucursal = s.idsucursal " +
                                    "   and d.fecha < '" + bfecha.Text+ "'  " +
                                    "   order by d.idcierre desc " +
                                    "   limit 1 " +
                                    ") as saldoinicial, " +
                                    " ( " +
                                    "select coalesce(sum(d.importe), 0) as total " +
                                    "from movimientos d " +
                                    "where d.fecha = '" + bfecha.Text+ "' and d.ignorar = 0 " +
                                    "and d.tipo in('V') " +
                                    "and d.idsucursal = s.idsucursal " +
                                    ")as ventas, " +
                                    "( " +
                                    "select coalesce(sum(d.importe), 0) as total " +
                                    "from movimientos d " +
                                    "where d.fecha = '" + bfecha.Text+ "' and d.ignorar = 0 " +
                                    "and d.tipo in('R') " +
                                    "and d.idsucursal = s.idsucursal " +
                                    ")as refrendos, " +
                                    "( " +
                                    "select coalesce(sum(d.importe), 0) as total " +
                                    "from movimientos d " +
                                    "where d.fecha = '" + bfecha.Text+ "' and d.ignorar = 0 " +
                                    "and d.tipo in('A') " +
                                    "and d.idsucursal = 1 " +
                                    ")as apartados, " +
                                    "( " +
                                    "select coalesce(sum(d.prestamo), 0) as total " +
                                    "from empeno d " +
                                    "where d.fechaempeno = '" + bfecha.Text+ "' and d.estatus = 'ACTIVO' " +
                                    "and d.idsucursal = s.idsucursal " +
                                    ")as prestamos, " +
                                    "( " +
                                    "select coalesce(sum(d.importe), 0) as total " +
                                    "from detallecaja d " +
                                    "where d.fecha = '" + bfecha.Text+ "' and d.estatus = 'ACTIVO' " +
                                    "and d.idsucursal = s.idsucursal " +
                                    "and tipo = 'I' " +
                                    ")as ingresos, " +
                                    "( " +
                                    "select coalesce(sum(d.importe), 0) as total " +
                                    "from detallecaja d " +
                                    "where d.fecha = '" + bfecha.Text+ "' and d.estatus = 'ACTIVO' " +
                                    "and d.idsucursal = s.idsucursal " +
                                    "and tipo = 'E' " +
                                    ")as egresos " +
                                    "from sucursal s " +
                                    "where s.idsucursal = "+ idS.Value +" ";

                    MySqlCommand cmd2 = new MySqlCommand(query, con2);

                    MySqlDataReader rdr = cmd2.ExecuteReader();
                    if (rdr.HasRows)
                    {
                        while (rdr.Read())
                        {

                            caja = decimal.Parse(rdr["saldoinicial"].ToString());
                            lsaldoinicial.Text = caja.ToString("C", new CultureInfo("es-MX"));

                            caja = Decimal.Parse(rdr["ventas"].ToString());
                            lventas.Text = caja.ToString("C", new CultureInfo("es-MX"));
                            caja = Decimal.Parse(rdr["apartados"].ToString());
                            lapartados.Text = caja.ToString("C", new CultureInfo("es-MX"));
                            caja = Decimal.Parse(rdr["refrendos"].ToString());
                            lrefrendos.Text = caja.ToString("C", new CultureInfo("es-MX"));
                            caja = Decimal.Parse(rdr["prestamos"].ToString());
                            lprestamos.Text = caja.ToString("C", new CultureInfo("es-MX"));

                            caja = Decimal.Parse(rdr["ingresos"].ToString());
                            lingresos.Text = caja.ToString("C", new CultureInfo("es-MX"));

                            caja = Decimal.Parse(rdr["egresos"].ToString());
                            legresos.Text = caja.ToString("C", new CultureInfo("es-MX"));

                            caja = Decimal.Parse(rdr["saldoinicial"].ToString()) + Decimal.Parse(rdr["ingresos"].ToString()) - Decimal.Parse(rdr["egresos"].ToString()) + Decimal.Parse(rdr["ventas"].ToString()) + Decimal.Parse(rdr["apartados"].ToString()) + Decimal.Parse(rdr["refrendos"].ToString()) - Decimal.Parse(rdr["prestamos"].ToString());

                            lsaldocaja.Text = caja.ToString("C", new CultureInfo("es-MX")); 

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

    }
}