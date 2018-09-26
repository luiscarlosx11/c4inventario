using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace elecion
{
    public class Usuarios
    {
        public int id { get; set; }
        public string usuario { get; set; }
        public string nombre { get; set; }
        public string img { get; set; }
        public string rol { get; set; }
        public int entidad { get; set; }
        public int idtipousuario { get; set; }
        public int idsucursal { get; set; }
        public Usuarios()
        {

        }
        public Usuarios(int id, string usuario, string nombre, string img, string rol, int entidad, int idtipousuario, int idsucursal)
        {
            this.id = id;
            this.usuario = usuario;
            this.nombre = nombre;
            this.img = img;
            this.rol = rol;
            this.entidad = entidad;
            this.idtipousuario = idtipousuario;
            this.idsucursal = idsucursal;
        }
    }
}