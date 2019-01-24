using ServicioEnvio.Entidad;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ServicioEnvio.Datos
{
    public class Ad_Comprobante
    {
        readonly string connectionString = ConfigurationManager.ConnectionStrings["cnx"].ConnectionString;

        public void InsertarCdrPendiente(long idComprobante, byte[] archivo)
        {
            SqlConnection cn = new SqlConnection(connectionString);
            SqlCommand cmd = new SqlCommand("dbo.usp_InsertarCdrPendiente", cn)
            {
                CommandType = CommandType.StoredProcedure
            };
            cmd.Parameters.Add(new SqlParameter { ParameterName = "@IdComprobante", SqlDbType = SqlDbType.BigInt, Value = idComprobante });
            cmd.Parameters.Add(new SqlParameter { ParameterName = "@Archivo", SqlDbType = SqlDbType.VarBinary, Value = archivo });

            try
            {
                cn.Open();
                cmd.ExecuteNonQuery();
                cn.Close();
            }
            catch (SqlException ex)
            {
                if (cn.State == ConnectionState.Open) { cn.Close(); }
                throw ex;
            }
            catch (Exception ex)
            {
                if (cn.State == ConnectionState.Open) { cn.Close(); }
                throw ex;
            }
        }

        public int QuitarPendienteEnvio(long idComprobante, string codigoRespuesta)
        {
            int resultado = 0;
            SqlConnection cn = new SqlConnection(connectionString);
            SqlCommand cmd = new SqlCommand("dbo.usp_QuitarPendienteEnvio", cn)
            {
                CommandType = CommandType.StoredProcedure
            };
            cmd.Parameters.Add(new SqlParameter { ParameterName = "@IdComprobante", SqlDbType = SqlDbType.BigInt, Value = idComprobante });
            cmd.Parameters.Add(new SqlParameter { ParameterName = "@codigoRespuesta", SqlDbType = SqlDbType.VarChar, Size = 20, Value = codigoRespuesta });

            try
            {
                cn.Open();
                resultado = (int)cmd.ExecuteScalar();
                cn.Close();
                return resultado;
            }
            catch (SqlException ex)
            {
                if (cn.State == ConnectionState.Open) { cn.Close(); }
                throw ex;
            }
            catch (Exception ex)
            {
                if (cn.State == ConnectionState.Open) { cn.Close(); }
                throw ex;
            }
        }

        public List<En_Comprobante> ComprobantesPendientesDeEnvio()
        {
            List<En_Comprobante> comprobantes = new List<En_Comprobante>();
            SqlConnection cn = new SqlConnection(connectionString);
            SqlCommand cmd = new SqlCommand("dbo.usp_ComprobantesPendientesDeEnvio", cn)
            {
                CommandType = CommandType.StoredProcedure
            };

            try
            {
                cn.Open();

                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    En_Comprobante comprobante = new En_Comprobante();
                    comprobante.RucEmisor = (string)(dr[0]);
                    comprobante.IdComprobante = (long)dr[1];
                    comprobante.TipoComprobante = (string)dr[2];
                    comprobante.SerieNumero = (string)dr[3];
                    comprobantes.Add(comprobante);
                }

                cn.Close();

                return comprobantes;
            }
            catch (SqlException ex)
            {
                if (cn.State == ConnectionState.Open) { cn.Close(); }
                throw ex;
            }
            catch (Exception ex)
            {
                if (cn.State == ConnectionState.Open) { cn.Close(); }
                throw ex;
            }
        }
    }
}
