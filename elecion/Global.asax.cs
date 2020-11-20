using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.SessionState;

namespace elecion
{
    public class Global : System.Web.HttpApplication
    {

        protected void Application_Start(object sender, EventArgs e)
        {
            

            Telerik.Reporting.Services.WebApi.ReportsControllerConfiguration.RegisterRoutes(System.Web.Http.GlobalConfiguration.Configuration);

            

            System.Web.Routing.RouteTable.Routes.MapPageRoute("Promovidos",
              "promovidos/"
              , "~/promovidos/listado.aspx", false
              );

            System.Web.Routing.RouteTable.Routes.MapPageRoute("RegistrarPromovido",
              "promovidos/registrar"
              , "~/promovidos/registrar.aspx", false
              );

            System.Web.Routing.RouteTable.Routes.MapPageRoute("GraficaPromovido",
              "promovidos/graficas"
              , "~/promovidos/graficas.aspx", false
              );

            System.Web.Routing.RouteTable.Routes.MapPageRoute("Usuarios",
              "usuarios/"
              , "~/usuario/control.aspx", false
              );

            System.Web.Routing.RouteTable.Routes.MapPageRoute("AgregarUsuarios",
              "agregar-usuario/"
              , "~/usuario/agregar.aspx", false
              );

            System.Web.Routing.RouteTable.Routes.MapPageRoute("EditarUsuarios",
              "editar-usuario/"
              , "~/usuario/agregar.aspx", false
              );

            System.Web.Routing.RouteTable.Routes.MapPageRoute("Estructuras",
              "estructuras/"
              , "~/estructuras/estructuras.aspx", false
              );

            System.Web.Routing.RouteTable.Routes.MapPageRoute("AgregarEstructuras",
              "estructuras/registrar"
              , "~/estructuras/agregar.aspx", false
              );

            System.Web.Routing.RouteTable.Routes.MapPageRoute("CatalogosMunicipio",
              "catalogos/municipios"
              , "~/catalogos/geograficos/listadomun.aspx", false
              );
            System.Web.Routing.RouteTable.Routes.MapPageRoute("CatalogoSeccion",
              "catalogos/secciones"
              , "~/catalogos/geograficos/listadosecc.aspx", false
              );

            System.Web.Routing.RouteTable.Routes.MapPageRoute("Error",
              "ErrorPage/"
              , "~/errores.aspx", false
              );

            System.Web.Routing.RouteTable.Routes.MapPageRoute("CasasAmigaEditar",
           "casas-amigas/editar"
           , "~/prep/altacasas.aspx", false
           );

            System.Web.Routing.RouteTable.Routes.MapPageRoute("CasasAmigasNueva",
           "casas-amigas/agregar"
           , "~/prep/altacasas.aspx", false
           );

            System.Web.Routing.RouteTable.Routes.MapPageRoute("CasasAmigas",
           "casas-amigas/"
           , "~/prep/listacasas.aspx", false
           );


            System.Web.Routing.RouteTable.Routes.MapPageRoute("PrepResultados",
           "prep/resultados"
           , "~/prep/resultados.aspx", false
           );
        }

        protected void Session_Start(object sender, EventArgs e)
        {
            Session.Timeout = 1;
        }

        protected void Application_BeginRequest(object sender, EventArgs e)
        {

        }

        protected void Application_AuthenticateRequest(object sender, EventArgs e)
        {

        }

        protected void Application_Error(object sender, EventArgs e)
        {

        }

        protected void Session_End(object sender, EventArgs e)
        {

        }

        protected void Application_End(object sender, EventArgs e)
        {

        }
    }
}