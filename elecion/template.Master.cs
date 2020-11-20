using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace elecion
{
    using System.Configuration;
    using System.Web.Configuration;
    using Telerik.ReportViewer.Html5.WebForms;

    public partial class template : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            var id = (FormsIdentity)Page.User.Identity;
            var ticket = id.Ticket;
            string[] datos = ticket.UserData.Split(',');
            string[] datos2 = datos[1].Split(';');
            //inputName1.Value = datos2[0];
            usn.Text = datos2[0];


            int idtipousuario = 0;//Convert.ToInt32(datos2[3]);
            
            string roles = datos2[3].ToString();
            int idsucursal = Convert.ToInt32(datos2[4]);

            catalogos.Visible = false;
            ciclo.Visible = false;
            infraestructura.Visible = false;
            datospersonales.Visible = false;
            datosgenerales.Visible = false;
            datoscapaticacion.Visible = false;
            seguridad.Visible = false;
            otros.Visible = false;
           
            capacitacion.Visible = false;
            oferta.Visible = false;
            directorio.Visible = false;
            inscripcion.Visible = false;
                        
            tecnico.Visible = false;
            ofertatecnico.Visible = false;

            caja.Visible = false;
            pagos.Visible = false;

            Li1.Visible = false;
            Li3.Visible = false;
            reportes.Visible = false;

            acredcursos.Visible = false;
            sep.Visible = false;
                //depositos.Visible = false;




            //SUPERADMINISTRADOR
            if (roles.IndexOf('1', 0) >= 0)
            {
                catalogos.Visible = true;
                ciclo.Visible = true;
                infraestructura.Visible = true;
                datospersonales.Visible = true;
                datosgenerales.Visible = true;
                datoscapaticacion.Visible = true;
                seguridad.Visible = true;
                otros.Visible = true;

                capacitacion.Visible = true;
                oferta.Visible = true;
                directorio.Visible = true;
                inscripcion.Visible = true;

                tecnico.Visible = true;
                ofertatecnico.Visible = true;

                caja.Visible = true;
                pagos.Visible = true;

                Li1.Visible = true;
                Li3.Visible = true;
                reportes.Visible = true;

                acredcursos.Visible = true;
                sep.Visible = true;
                //depositos.Visible = true;
            }
            //CAPACITACION
            if (roles.IndexOf('2', 0) >= 0)
            {               
                capacitacion.Visible = true;
                oferta.Visible = true;
                directorio.Visible = true;
                inscripcion.Visible = true;

                Li1.Visible = true;
                Li3.Visible = true;
                reportes.Visible = true;

                acredcursos.Visible = true;
                sep.Visible = true;

            }
            //TECNICO
            if (roles.IndexOf('3', 0) >= 0)
            {                
                tecnico.Visible = true;
                ofertatecnico.Visible = true;
            }
            //INSCRIPCION
            if (roles.IndexOf('4', 0) >= 0)
            {               
                //capacitacion.Visible = true;                
                inscripcion.Visible = true;                
            }
            //CAJA
            if (roles.IndexOf('5', 0) >= 0)
            {
                caja.Visible = true;
                pagos.Visible = true;
                //depositos.Visible = true;
            }
            //ADMINISTRADOR
            if (roles.IndexOf('6', 0) >= 0)
            {                
                capacitacion.Visible = true;
                oferta.Visible = true;
                directorio.Visible = true;
                inscripcion.Visible = true;

                tecnico.Visible = true;
                ofertatecnico.Visible = true;

                caja.Visible = true;
                pagos.Visible = true;

                Li1.Visible = true;
                Li3.Visible = true;
                reportes.Visible = true;
                acredcursos.Visible = true;
                sep.Visible = true;
            }

            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            if (!this.IsPostBack)
            {
                Session["Reset"] = true;
                Configuration config = WebConfigurationManager.OpenWebConfiguration("~/Web.Config");
                SessionStateSection section = (SessionStateSection)config.GetSection("system.web/sessionState");
                int timeout = (int)section.Timeout.TotalMinutes * 1000 * 60;
                //ScriptManager.RegisterStartupScript(this, this.GetType(), "SessionAlert", "alert('11');SessionExpireAlert();", true);
                
                ScriptManager.RegisterClientScriptBlock(this, GetType(), "scr", "SessionExpireAlert("+timeout+")", true);


            }
        }

        public String getYear()
        {
            return DateTime.Now.Year.ToString();
        }

        public void Logout()
        {
            Session.Clear();
            Session.Abandon();
            Response.Cookies["ASP.NET_SessionId"].Value = string.Empty;
            Response.Cookies["ASP.NET_SessionId"].Expires = DateTime.Now.AddMonths(-10);
            FormsAuthentication.SignOut();
            Response.Redirect("~/", true);
        }
    }
}