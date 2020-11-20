using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace elecion
{
    public class fechascurso
    {
        
        public String fecha { get; set; }

        public fechascurso()
        {
           
            this.fecha = "";
        }

        public fechascurso(int exito, string fecha)
        {
            this.fecha = fecha;           
        }
    }
}