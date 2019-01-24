using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ServicioEnvio.Entidad
{
    public class En_Archivo
    {
        public long IdComprobante { get; set; }
        public string Nombre { get; set; }
        public byte[] Contenido { get; set; }
    }
}
