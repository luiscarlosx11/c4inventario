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
            usn.Text = "HOLA "+datos2[0] +" ";


           // int idtipousuario = 0;//Convert.ToInt32(datos2[3]);
            
           // string roles = datos2[3].ToString();
            //int idsucursal = Convert.ToInt32(datos2[4]);

            catalogos.Visible = false;
            ciclo.Visible = false;           
            seguridad.Visible = false;                       
            capacitacion.Visible = false;
            oferta.Visible = false;           
            
                //depositos.Visible = false;




            //SUPERADMINISTRADOR
           // if (roles.IndexOf('1', 0) >= 0)
           // {
                catalogos.Visible = true;
                ciclo.Visible = true;                
                seguridad.Visible = true;                
                capacitacion.Visible = true;
                oferta.Visible = true;                               
                
                //depositos.Visible = true;
            

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