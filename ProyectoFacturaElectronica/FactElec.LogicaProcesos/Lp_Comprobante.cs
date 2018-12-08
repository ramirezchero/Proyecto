using FactElec.CapaDatos;
using FactElec.CapaEntidad.RegistroComprobante;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FactElec.LogicaProceso
{
    public class Lp_Comprobante
    {
        public bool InsertarComprobante(En_ComprobanteElectronico comprobante, string nombreXML, byte[] archivoXML, string codigoHASH, string codigoQR, ref string mensajeRetorno)
        {
            Da_Comprobante daComprobante = new Da_Comprobante();
            return daComprobante.InsertarComprobante(comprobante, nombreXML, archivoXML, codigoHASH, codigoQR, ref mensajeRetorno);
        }
    }
}
