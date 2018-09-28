namespace elecion.reportes
{
    using System;
    using Telerik.ReportViewer.Html5.WebForms;
    using MySql.Data.MySqlClient;
    using System.Web.Security;

    public partial class RVTicketCorte : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            var idu = (FormsIdentity)Page.User.Identity;
            var ticket = idu.Ticket;
            string[] datos = ticket.UserData.Split(',');
            string[] datos2 = datos[1].Split(';');

            int idusuario = Convert.ToInt32(datos[0]);

            if (!IsPostBack)
            {               
               reportViewer1.ReportSource.Parameters["idsucursal"].Value = Request.Params["idsucursal"];
               reportViewer1.ReportSource.Parameters["idusuario"].Value = idusuario;
               reportViewer1.ReportSource.Parameters["fecha"].Value = Request.Params["fecha"];
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {

        }
    }
}