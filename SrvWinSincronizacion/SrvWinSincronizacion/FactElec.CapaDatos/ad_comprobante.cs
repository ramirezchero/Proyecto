using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using FactElec.EntidadNegocio;

namespace FactElec.AccesoDatos
{
    public class Ad_comprobante  
    {
       
        public List<En_Archivo> ObtenerRespuestaPendiente()
        {            
            
            List<En_Archivo> listaArchivo = new List<En_Archivo>();
            List<SqlParameter> parameters = new List<SqlParameter>();
            //parameters.Add(new SqlParameter { ParameterName = "@Serie", SqlDbType = SqlDbType.VarChar, Size = 6, Value = serie });
            //parameters.Add(new SqlParameter { ParameterName = "@Numero", SqlDbType = SqlDbType.VarChar, Size = 20, Value = numero });
            //parameters.Add(new SqlParameter { ParameterName = "@TipoComprobante", SqlDbType = SqlDbType.VarChar, Size = 50, Value = tipo_comprobante });
            //parameters.Add(new SqlParameter { ParameterName = "@Ruc", SqlDbType = SqlDbType.VarChar, Size = 15, Value = ruc });
            SqlCommand cmd = new SqlCommand();


            try
            {
                SqlDataReader dr =SqlHelper.ExecuteReader("usp_ListaCDRPendiente", parameters);
               // SqlDataReader dr = SqlHelper.ExecuteReader("usp_ListaCDRPendiente", cmd);
                while (dr.Read())
                {
                    En_Archivo Archivo = new En_Archivo();
                    Archivo.Archivo = (byte[])(dr[1]);
                    Archivo.IdComprobante = (long)dr[0];
                    Archivo.FechaRegistro = (DateTime)dr[2];
                    listaArchivo.Add(Archivo);
                }
            }
            catch (Exception ex)
            {
                // log.Error(ex.Message, ex);
                throw new Exception(ex.Message);
            }
            return listaArchivo;
        }
        public string RutaTemporalCdr(string codigo)
        {

            string ruta = "";
            List<SqlParameter> parameters = new List<SqlParameter>();
            parameters.Add(new SqlParameter { ParameterName = "@codigo", SqlDbType = SqlDbType.VarChar, Size = 10, Value = codigo });

            //SqlCommand cmd = new SqlCommand();
            //cmd.Parameters.Add("@codigo", SqlDbType.VarChar, 10).Value = codigo;

            try
            {
                DataTable tablaconfiguracion = SqlHelper.FillDataTable("usp_ListaConfiguracion", parameters);
                ruta = tablaconfiguracion.Rows[0][1].ToString();

            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return ruta;
        }

        public int RegistrarRespuestaSunat(En_Respuesta oRespuesta)
        {
            
            int respuesta = 0;
            List<SqlParameter> parameters = new List<SqlParameter>();
            parameters.Add(new SqlParameter { ParameterName = "@CodigoSUNAT", SqlDbType = SqlDbType.VarChar, Size = 50, Value = oRespuesta.Codigo });
            parameters.Add(new SqlParameter { ParameterName = "@IdComprobante", SqlDbType = SqlDbType.BigInt, Value = oRespuesta.Idcomprobante });
            parameters.Add(new SqlParameter { ParameterName = "@Archivo", SqlDbType = SqlDbType.VarBinary, Value = oRespuesta.Archivo });
            parameters.Add(new SqlParameter { ParameterName = "@Descripcion", SqlDbType = SqlDbType.VarChar, Value = oRespuesta.Descripcion });
            parameters.Add(new SqlParameter { ParameterName = "@FechaSunat", SqlDbType = SqlDbType.VarChar, Size = 20, Value = oRespuesta.FecharespuestaSunat });
            parameters.Add(new SqlParameter { ParameterName = "@HoraSunat", SqlDbType = SqlDbType.VarChar, Size = 20, Value = oRespuesta.HoraRespuestaSunat });


            //SqlCommand cmd = new SqlCommand();
            //cmd.Parameters.Add("@CodigoSUNAT", SqlDbType.VarChar, 50).Value = oRespuesta.Codigo;
            //cmd.Parameters.Add("@IdComprobante", SqlDbType.VarChar, 10).Value = oRespuesta.Idcomprobante;
            //cmd.Parameters.Add("@Archivo", SqlDbType.VarChar, 10).Value = oRespuesta.Archivo;
            //cmd.Parameters.Add("@Descripcion", SqlDbType.VarChar, 10).Value = oRespuesta.Descripcion;
            //cmd.Parameters.Add("@FechaSunat", SqlDbType.VarChar, 10).Value = oRespuesta.FecharespuestaSunat;
            //cmd.Parameters.Add("@HoraSunat", SqlDbType.VarChar, 10).Value = oRespuesta.HoraRespuestaSunat;



            try
            {
                respuesta = SqlHelper.ExecuteNonQuery("usp_RegistraRespuestaSUNAT", parameters);
                return respuesta;

            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }            
        }

    }
}
