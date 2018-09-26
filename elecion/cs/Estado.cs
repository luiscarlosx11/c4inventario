using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace elecion
{
    public class Estado
    {
        public string estado { get; set; }

        public Estado()
        {
            estado = "";
        }

        public Estado(string estado)
        {
            this.estado = estado;
        }
    }
}