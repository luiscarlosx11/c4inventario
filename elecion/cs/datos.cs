using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace elecion
{
    public class datos
    {
        public int exito { get; set; }
        public String mensaje { get; set; }

        public datos()
        {
            this.exito = 0;
            this.mensaje = "";
        }

        public datos(int exito, string mensaje)
        {
            this.exito = exito;
            this.mensaje = mensaje;
        }
    }
}