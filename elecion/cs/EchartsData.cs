using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace elecion
{
    public class EchartsData
    {
        public int value { get; set; }
        public string name { get; set; }
        

        public EchartsData()
        {
            name = "";
            value = 0;
        }

        public EchartsData(string name, int value)
        {
            this.name = name;
            this.value = value;
        }
    }
}