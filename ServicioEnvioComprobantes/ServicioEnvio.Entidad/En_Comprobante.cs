using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ServicioEnvio.Entidad
{
    public class En_Comprobante
    {
        public string RucEmisor { get; set; }
        public long IdComprobante { get; set; }
        public string SerieNumero { get; set; }
        public string TipoComprobante { get; set; }
    }
}
