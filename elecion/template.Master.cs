using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace elecion
{
    using Telerik.ReportViewer.Html5.WebForms;

    public partial class template : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            var id = (FormsIdentity)Page.User.Identity;
            var ticket = id.Ticket;
            string[] datos = ticket.UserData.Split(',');
            string[] datos2 = datos[1].Split(';');
            inputName1.Value = datos2[0];
            usn.Text = datos2[0];


            int idtipousuario = Convert.ToInt32(datos2[3]);
            int idsucursal = Convert.ToInt32(datos2[4]);

            //OPERADOR O TECNICO
            if (idtipousuario == 2 || idtipousuario==4)
            {
               catalogos.Visible = false;
               servicio.Visible = false;
               sistema.Visible = false;
               clientes.Visible = false;
               seguridad.Visible = false;
            }
        }

        public String getYear()
        {
            return DateTime.Now.Year.ToString();
        }
    }
}