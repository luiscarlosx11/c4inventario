using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace elecion
{
    public class datasets
    {

        public String label { get; set; }
        public int [] data { get; set; }
        public String backgroundColor { get; set; }
        public String borderColor { get; set; }
        public String pointBorderColor { get; set; }
        public String pointBackgroundColor { get; set; }
        public int pointRadius { get; set; }
        public int pointBorderWidth { get; set; }
        public int pointHoverBorderWidth { get; set; }

        public datasets()
        {
            backgroundColor = "rgba(22,211,154,0.7)";
            borderColor= "transparent";
            pointBorderColor = "transparent";
            pointBackgroundColor = "transparent";
            pointRadius = 2;
            pointBorderWidth= 2;
            pointHoverBorderWidth= 2;
        }

    }
}