using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace elecion
{
    public class Mantenimiento
    {
        public String MSJ { get; set; }
        public String Borarr { get; set; }

        public Mantenimiento()
        {
            this.MSJ = "";
            this.Borarr = "";
        }

        public Mantenimiento(String MSJ, String Borrar)
        {
            this.MSJ = MSJ;
            this.Borarr = Borarr;
        }
    }
}