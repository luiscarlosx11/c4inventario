using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace elecion
{
    public class datosGraficaBar
    {
        public string label { get; set; }
        public int[] data { get; set; }

        public string color { get; set; }

        public string backgroundColor { get; set; }

        public string borderColor { get; set; }

        public datosGraficaBar()
        {
            label = "";
            data = null;
            borderColor = "";
        }

        public datosGraficaBar(string label, string color, string backgroundColor,string borderColor, int[] data)
        {
            this.label = label;
            this.data = data;
            this.color = color;
            this.backgroundColor = backgroundColor;
            this.borderColor = borderColor;
        }
    }
}