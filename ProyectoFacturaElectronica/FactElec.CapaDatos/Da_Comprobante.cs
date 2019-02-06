using FactElec.CapaEntidad.RegistroComprobante;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FactElec.CapaDatos
{
    public class Da_Comprobante
    {
        readonly string connectionString = ConfigurationManager.ConnectionStrings["cnx"].ConnectionString;
        readonly log4net.ILog log = log4net.LogManager.GetLogger(typeof(Da_Comprobante));

        public bool InsertarComprobante(En_ComprobanteElectronico comprobante, string nombreXML, byte[] archivoXML, string codigoHASH, string firma, ref string mensajeRetorno)
        {
            StringBuilder firmaQR = new StringBuilder();
            string[] serieNumero = comprobante.SerieNumero.Split('-');

            firmaQR.Append(comprobante.Emisor.NumeroDocumentoIdentidad).Append('|');
            firmaQR.Append(comprobante.TipoComprobante).Append('|');
            firmaQR.Append(serieNumero[0]).Append('|');
            firmaQR.Append(serieNumero[1]).Append('|');
            firmaQR.Append(comprobante.TotalImpuesto.ToString()).Append('|');
            firmaQR.Append(comprobante.ImporteTotal).Append('|');
            firmaQR.Append(comprobante.FechaEmision).Append('|');
            firmaQR.Append(comprobante.Receptor.TipoDocumentoIdentidad).Append('|');
            firmaQR.Append(comprobante.Receptor.NumeroDocumentoIdentidad).Append('|');
            firmaQR.Append(codigoHASH).Append('|');
            firmaQR.Append(firma);

            SqlConnection cn = new SqlConnection(connectionString);
            SqlCommand cmd = new SqlCommand("dbo.usp_InsertarComprobante", cn)
            {
                CommandType = CommandType.StoredProcedure
            };
            cmd.Parameters.Add(new SqlParameter { ParameterName = "@NroDocumentoIdentidadEmisor", SqlDbType = SqlDbType.VarChar, Size = 30, Value = comprobante.Emisor.NumeroDocumentoIdentidad });
            cmd.Parameters.Add(new SqlParameter { ParameterName = "@TipoDocumentoIdentidad", SqlDbType = SqlDbType.VarChar, Size = 2, Value = comprobante.Receptor.TipoDocumentoIdentidad });
            cmd.Parameters.Add(new SqlParameter { ParameterName = "@NroDocumentoIdentidad", SqlDbType = SqlDbType.VarChar, Size = 30, Value = comprobante.Receptor.NumeroDocumentoIdentidad });
            cmd.Parameters.Add(new SqlParameter { ParameterName = "@RazonSocial", SqlDbType = SqlDbType.VarChar, Size = 500, Value = comprobante.Receptor.RazonSocial });
            cmd.Parameters.Add(new SqlParameter { ParameterName = "@TipoComprobante", SqlDbType = SqlDbType.VarChar, Size = 2, Value = comprobante.TipoComprobante });
            cmd.Parameters.Add(new SqlParameter { ParameterName = "@SerieNumero", SqlDbType = SqlDbType.VarChar, Size = 13, Value = comprobante.SerieNumero });
            cmd.Parameters.Add(new SqlParameter { ParameterName = "@FechaEmison", SqlDbType = SqlDbType.VarChar, Size = 10, Value = comprobante.FechaEmision });
            cmd.Parameters.Add(new SqlParameter { ParameterName = "@CorreoElectronico", SqlDbType = SqlDbType.VarChar, Size = 500, Value = comprobante.Receptor.Contacto.Correo });
            cmd.Parameters.Add(new SqlParameter { ParameterName = "@TotalImpuesto", SqlDbType = SqlDbType.Decimal, Value = comprobante.TotalImpuesto });
            cmd.Parameters.Add(new SqlParameter { ParameterName = "@TotalValorVenta", SqlDbType = SqlDbType.Decimal, Value = comprobante.TotalValorVenta });
            cmd.Parameters.Add(new SqlParameter { ParameterName = "@TotalPrecioVenta", SqlDbType = SqlDbType.Decimal, Value = comprobante.TotalPrecioVenta });
            cmd.Parameters.Add(new SqlParameter { ParameterName = "@TotalDescuento", SqlDbType = SqlDbType.Decimal, Value = comprobante.TotalDescuento });
            cmd.Parameters.Add(new SqlParameter { ParameterName = "@TotalCargo", SqlDbType = SqlDbType.Decimal, Value = comprobante.TotalCargo });
            cmd.Parameters.Add(new SqlParameter { ParameterName = "@ImporteTotal", SqlDbType = SqlDbType.Decimal, Value = comprobante.ImporteTotal });
            cmd.Parameters.Add(new SqlParameter { ParameterName = "@FechaVencimiento", SqlDbType = SqlDbType.VarChar, Size = 50, Value = comprobante.FechaVencimiento });
            cmd.Parameters.Add(new SqlParameter { ParameterName = "@HoraEmision", SqlDbType = SqlDbType.VarChar, Size = 8, Value = comprobante.HoraEmision });
            cmd.Parameters.Add(new SqlParameter { ParameterName = "@Moneda", SqlDbType = SqlDbType.VarChar, Size = 5, Value = comprobante.Moneda });
            cmd.Parameters.Add(new SqlParameter { ParameterName = "@TipoOperacion", SqlDbType = SqlDbType.VarChar, Size = 4, Value = comprobante.TipoOperacion });
            cmd.Parameters.Add(new SqlParameter { ParameterName = "@NombreXML", SqlDbType = SqlDbType.VarChar, Size = 50, Value = nombreXML });
            cmd.Parameters.Add(new SqlParameter { ParameterName = "@ArchivoXML", SqlDbType = SqlDbType.VarBinary, Value = archivoXML });
            cmd.Parameters.Add(new SqlParameter { ParameterName = "@CodigoHash", SqlDbType = SqlDbType.VarChar, Value = codigoHASH });
            cmd.Parameters.Add(new SqlParameter { ParameterName = "@CodigoQR", SqlDbType = SqlDbType.VarChar, Value = firmaQR.ToString() });
            
            try
            {
                cn.Open();
                cmd.ExecuteNonQuery();
                cn.Close();
                mensajeRetorno = "Se registró el comprobante satisfactoriamente.";
                log.Info(mensajeRetorno);
                return true;
            }
            catch (SqlException ex)
            {
                if (cn.State == ConnectionState.Open) { cn.Close(); }
                mensajeRetorno = ex.Message.ToString();
                return false;
            }
            catch (Exception ex)
            {
                if (cn.State == ConnectionState.Open) { cn.Close(); }
                mensajeRetorno = "Ocurrió un error al registrar el comprobante, revisar el log.";
                log.Error(mensajeRetorno, ex);
                return false;
            }
        }
    }
}
