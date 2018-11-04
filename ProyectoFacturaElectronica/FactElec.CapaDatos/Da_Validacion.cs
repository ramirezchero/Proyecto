using FactElec.CapaEntidad.RegistroComprobante;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FactElec.CapaDatos
{
    public class Da_Validacion
    {
        public List<En_Validacion> ListarValidaciones()
        {
            List<En_Validacion> validaciones = new List<En_Validacion>();

            // Comprobante
            AgregarPropiedad(ref validaciones, "SerieNumero", Condicion.Mandatorio, TipoDato.String, 13, "[FB0-9][A-Z0-9]{3}-[0-9]{1,8}$");
            AgregarPropiedad(ref validaciones, "TipoComprobante", Condicion.Mandatorio, TipoDato.String, 2, "");
            AgregarPropiedad(ref validaciones, "TipoOperacion", Condicion.Mandatorio, TipoDato.String, 4, "");
            AgregarPropiedad(ref validaciones, "TotalCargo", Condicion.Condicional, TipoDato.Decimal, 0, "");
            AgregarPropiedad(ref validaciones, "TotalDescuento", Condicion.Condicional, TipoDato.Decimal, 0, "");
            AgregarPropiedad(ref validaciones, "TotalImpuesto", Condicion.Condicional, TipoDato.Decimal, 0, "");
            AgregarPropiedad(ref validaciones, "TotalPrecioVenta", Condicion.Condicional, TipoDato.Decimal, 0, "");
            AgregarPropiedad(ref validaciones, "TotalValorVenta", Condicion.Condicional, TipoDato.Decimal, 0, "");

            // ComprobanteDetalle            
            AgregarPropiedad(ref validaciones, "Cantidad", Condicion.Mandatorio, TipoDato.Decimal, 0, "");
            AgregarPropiedad(ref validaciones, "Codigo", Condicion.Mandatorio, TipoDato.String, 30, "");
            AgregarPropiedad(ref validaciones, "CodigoSunat", Condicion.Condicional, TipoDato.String, 8, "");
            AgregarPropiedad(ref validaciones, "CodigoTipoPrecio", Condicion.Mandatorio, TipoDato.String, 2, "");
            AgregarPropiedad(ref validaciones, "Descripcion", Condicion.Mandatorio, TipoDato.String, 500, "");
            AgregarPropiedad(ref validaciones, "ImpuestoTotal", Condicion.Mandatorio, TipoDato.Decimal, 0, "");
            AgregarPropiedad(ref validaciones, "Item", Condicion.Mandatorio, TipoDato.Decimal, 0, "");
            AgregarPropiedad(ref validaciones, "MultiDescripcion", Condicion.Mandatorio, TipoDato.ArrayString, 500, "");
            AgregarPropiedad(ref validaciones, "Total", Condicion.Mandatorio, TipoDato.Decimal, 0, "");
            AgregarPropiedad(ref validaciones, "UnidadMedida", Condicion.Mandatorio, TipoDato.String, 3, "");
            AgregarPropiedad(ref validaciones, "ValorVentaUnitarioIncIgv", Condicion.Mandatorio, TipoDato.Decimal, 0, "");
            AgregarPropiedad(ref validaciones, "ValorVentaUnitario", Condicion.Mandatorio, TipoDato.Decimal, 0, "");

            // ComprobanteDetalleImpuestos
            AgregarPropiedad(ref validaciones, "AfectacionIGV", Condicion.Mandatorio, TipoDato.String, 2, "");
            AgregarPropiedad(ref validaciones, "CodigoInternacionalTributo", Condicion.Mandatorio, TipoDato.String, 4, "");
            AgregarPropiedad(ref validaciones, "CodigoTributo", Condicion.Mandatorio, TipoDato.String, 4, "");
            AgregarPropiedad(ref validaciones, "MontoBase", Condicion.Mandatorio, TipoDato.Decimal, 0, "");
            AgregarPropiedad(ref validaciones, "MontoTotalImpuesto", Condicion.Mandatorio, TipoDato.Decimal, 0, "");
            AgregarPropiedad(ref validaciones, "NombreTributo", Condicion.Mandatorio, TipoDato.String, 6, "");
            AgregarPropiedad(ref validaciones, "Porcentaje", Condicion.Condicional, TipoDato.Decimal, 0, "");

            return validaciones;
        }
        private void AgregarPropiedad(ref List<En_Validacion> propiedades, string propiedad, Condicion condicion, TipoDato tipoDeDato, int tamanioMax, string formato)
        {
            propiedades.Add(new En_Validacion(propiedad, condicion, tipoDeDato, tamanioMax, formato));
        }
    }
}
