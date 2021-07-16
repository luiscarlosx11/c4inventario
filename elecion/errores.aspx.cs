using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace elecion
{
    public partial class errores : System.Web.UI.Page
    {
        //
        protected void Page_Load(object sender, EventArgs e)
        {
            String msj = Request["msg"];
            if (msj != null)
            {
                numError.Text = msj;

                if (msj.Equals("404"))
                {
                    msjerror.Text = "¡Página no encontrada!";
                }
                else if (msj.Equals("403"))
                {
                    msjerror.Text = "¡Acceso denegado/Prohibido!";
                }
                else if (msj.Equals("400"))
                {
                    msjerror.Text = "¡Solicitud incorrecta!";
                }
                else if (msj.Equals("401"))
                {
                    msjerror.Text = "¡Acceso no autorizado!";
                }
                else if (msj.Equals("500"))
                {
                    msjerror.Text = "¡Error interno del servidor!";
                }
            }
            else
            {
                Response.Redirect("~/");
            }
        }
    }
}