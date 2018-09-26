namespace elecion.reportes
{
    using System;
    using Telerik.ReportViewer.Html5.WebForms;
    using MySql.Data.MySqlClient;

    public partial class RVTicketCorte : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {               
               reportViewer1.ReportSource.Parameters["idsucursal"].Value = Request.Params["idsucursal"];
               reportViewer1.ReportSource.Parameters["idcierre"].Value = Request.Params["idcierre"];
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {

        }
    }
}