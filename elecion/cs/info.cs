using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace elecion
{
    public class info
    {

        public int id { get; set; }
        public string usuario { get; set; }
        public string email { get; set; }


        public info()
        {
            this.id = 0;
            this.usuario = "";
            this.email = "";
        }

        public info(int id, string usuario, string email)
        {
            this.id = id;
            this.usuario = usuario;
            this.email = email;
        }

    }
}