using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace elecion
{
    public class datosGrafica
    {
        public string label { get; set; }
        public int data { get; set; }

        public datosGrafica()
        {
            label = "";
            data = 0;
        }

        public datosGrafica(string labe, int data)
        {
            this.label = label;
            this.data = data;
        }
    }
}