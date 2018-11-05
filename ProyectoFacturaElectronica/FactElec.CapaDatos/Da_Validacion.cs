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
            AgregarPropiedad(ref validaciones, "FechaEmision", Condicion.Mandatorio, TipoDato.Date, 0, "yyyy-MM-dd");
            AgregarPropiedad(ref validaciones, "HoraEmision", Condicion.Condicional, TipoDato.Date, 0, "HH:mm:ss");
            AgregarPropiedad(ref validaciones, "ImporteTotal", Condicion.Mandatorio, TipoDato.Decimal, 0, "");
            AgregarPropiedad(ref validaciones, "Moneda", Condicion.Mandatorio, TipoDato.String, 3, "");
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

            // DescuentoCargo
            AgregarPropiedad(ref validaciones, "CodigoMotivo", Condicion.Condicional, TipoDato.String, 2, "");
            AgregarPropiedad(ref validaciones, "Factor", Condicion.Condicional, TipoDato.Decimal, 0, "");
            AgregarPropiedad(ref validaciones, "Indicador", Condicion.Condicional, TipoDato.Boolean, 0, "");
            AgregarPropiedad(ref validaciones, "MontoBase", Condicion.Condicional, TipoDato.Decimal, 0, "");
            AgregarPropiedad(ref validaciones, "MontoTotal", Condicion.Condicional, TipoDato.Decimal, 0, "");

            // DocumentoReferenciaDespacho
            AgregarPropiedad(ref validaciones, "Fecha", Condicion.Condicional, TipoDato.Date, 0, "yyyy-MM-dd");
            AgregarPropiedad(ref validaciones, "SerieNumero", Condicion.Condicional, TipoDato.String, 30, "[FB0-9][A-Z0-9]{3}-[0-9]{1,8}$");
            AgregarPropiedad(ref validaciones, "TipoDocumento", Condicion.Condicional, TipoDato.String, 2, "");

            // Emisor
            AgregarPropiedad(ref validaciones, "CodigoDomicilioFiscal", Condicion.Mandatorio, TipoDato.String, 4, "");
            AgregarPropiedad(ref validaciones, "CodigoPais", Condicion.Condicional, TipoDato.String, 2, "");
            AgregarPropiedad(ref validaciones, "CodigoUbigeo", Condicion.Condicional, TipoDato.String, 6, "");
            AgregarPropiedad(ref validaciones, "Departamento", Condicion.Condicional, TipoDato.String, 30, "");
            AgregarPropiedad(ref validaciones, "Direccion", Condicion.Condicional, TipoDato.String, 200, "");
            AgregarPropiedad(ref validaciones, "Distrito", Condicion.Condicional, TipoDato.String, 30, "");
            AgregarPropiedad(ref validaciones, "NombreComercial", Condicion.Condicional, TipoDato.String, 1500, "");
            AgregarPropiedad(ref validaciones, "NumeroDocumentoIdentidad", Condicion.Mandatorio, TipoDato.String, 20, "");
            AgregarPropiedad(ref validaciones, "PaginaWeb", Condicion.Condicional, TipoDato.String, 200, "");
            AgregarPropiedad(ref validaciones, "Provincia", Condicion.Condicional, TipoDato.String, 30, "");
            AgregarPropiedad(ref validaciones, "RazonSocial", Condicion.Mandatorio, TipoDato.String, 1500, "");
            AgregarPropiedad(ref validaciones, "TipoDocumentoIdentidad", Condicion.Mandatorio, TipoDato.String, 1, "");
            AgregarPropiedad(ref validaciones, "Urbanizacion", Condicion.Condicional, TipoDato.String, 25, "");

            // Contacto
            AgregarPropiedad(ref validaciones, "Correo", Condicion.Condicional, TipoDato.String, 100, "");
            AgregarPropiedad(ref validaciones, "Nombre", Condicion.Condicional, TipoDato.String, 100, "");
            AgregarPropiedad(ref validaciones, "Telefono", Condicion.Condicional, TipoDato.String, 100, "");

            return validaciones;
        }
        private void AgregarPropiedad(ref List<En_Validacion> propiedades, string propiedad, Condicion condicion, TipoDato tipoDeDato, int tamanioMax, string formato)
        {
            propiedades.Add(new En_Validacion(propiedad, condicion, tipoDeDato, tamanioMax, formato));
        }
    }
}
