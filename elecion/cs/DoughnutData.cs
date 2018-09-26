using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace elecion.cs
{
    public class DoughnutData
    {

        public string type { get; set; }
        public string[] center { get; set; }
        public int[] radius { get; set; }

        public DoughnutData()
        {
            type = "";
            radius = new int[] { 3, 4 };
            center = new string[] { "10%", "32.5%" };
        }

        public DoughnutData(string name, int value)
        {
          
        }

        /* type: 'pie',
        center: ['10%', '32.5%'],
                                    radius: radius,
                                    itemStyle: labelFromatter,
                                    data: [
                                        { name: 'other', value: 46, itemStyle: labelBottom },
                                        { name: 'GoogleMaps', value: 54, itemStyle: labelTop
}
                                    ]*/
    }
}