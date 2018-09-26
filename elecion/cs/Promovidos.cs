using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace elecion
{
    public class Promovidos
    {
        //p.nombre,paterno,materno, seccion, nomMunicipio, colonia, calle, num_ext,num_int, e.nombre
        public int id { get; set; }
        public String nombre { get; set; }
        public String paterno { get; set; }
        public String materno { get; set; }
        public int seccion { get; set; }
        public String municipio { get; set; }
        public String colonia { get; set; }
        public String calle { get; set; }
        public String num_ext { get; set; }
        public String num_int { get; set; }
        public String estructura { get; set; }

        public Promovidos()
        {
            this.id = 0;
            this.nombre = "";
            this.paterno = "";
            this.materno = "";
            this.seccion = 0;
            this.municipio = "";
            this.colonia = "";
            this.calle = "";
            this.num_ext = "";
            this.num_int = "";
            this.estructura = "";
        }

        public Promovidos(int id, String nombre, String paterno, String materno, int seccion, String municipio, String colonia, String calle, String num_ext, 
            String num_int, String estructura )
        {
            this.id = id;
            this.nombre = nombre;
            this.paterno = paterno;
            this.materno = materno;
            this.seccion = seccion;
            this.municipio = municipio;
            this.colonia = colonia;
            this.calle = calle;
            this.num_ext = num_ext;
            this.num_int = num_int;
            this.estructura = estructura;
        }

    }
}