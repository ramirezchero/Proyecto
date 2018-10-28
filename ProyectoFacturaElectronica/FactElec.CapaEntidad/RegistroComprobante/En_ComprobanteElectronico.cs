using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FactElec.CapaEntidad.RegistroComprobante
{
    public class En_ComprobanteElectronico
    {
        public string SerieNumero { get; set; }
        
        public string FechaEmision { get; set; }
        public string HoraEmision { get; set; }

        public string Moneda { get; set; }

        public string TipoOperacion { get; set; }
        public string TipoComprobante { get; set; }
        public decimal TotalImpuesto { get; set; }

        public decimal TotalValorVenta { get; set; }
        public decimal TotalPrecioVenta { get; set; }
        public decimal ImporteTotal { get; set; }
       
        public En_Emisor Emisor { get; set; }

        public En_Receptor Receptor { get; set; }

        public En_MontosTotales MontoTotales { get; set; }

        public List<En_DescuentoCargo> DescuentoCargo { get; set; }

        public decimal TotalCargo { get; set; }

        public decimal TotalDescuento { get; set; }

        public List<En_ComprobanteDetalle> ComprobanteDetalle { get; set; }

        public List<En_Leyenda> Leyenda { get; set; }

        public List<En_DocumentoReferencia> DocumentoReferencia { get; set; }

    }
}
