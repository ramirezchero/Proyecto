using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using FactElec.AccesoDatos;
using FactElec.EntidadNegocio;
using System.IO;
namespace FactElec.LogicaNegocio
{
    public class Ln_comprobante
    {
        readonly log4net.ILog log = log4net.LogManager.GetLogger(typeof(Ln_comprobante));
        private Ad_comprobante oDatos = new Ad_comprobante();

        public List<En_Archivo> ObtenerRespuestaPendiente()
        {
           
            return oDatos.ObtenerRespuestaPendiente();
        }
        public string RutaTemporalCdr(string codigo)
        {

            return oDatos.RutaTemporalCdr(codigo);


        }

        public void ProcesarCDR() {
            List<En_Archivo> listaRespuesta=new List<En_Archivo>();
            listaRespuesta = ObtenerRespuestaPendiente();
            log.Info("Cantidad es " + listaRespuesta.Count.ToString());
            if (listaRespuesta.Count >0) {
                Task[] taskArray = new Task[listaRespuesta.Count ];

                int index = 0;
                foreach (En_Archivo archivo in listaRespuesta)
                {
                    if (archivo != null) {
                        taskArray[index] = Task.Factory.StartNew(() => ExtraerCDR(archivo.IdComprobante, archivo.Archivo));
                        index += 1;
                    }                    
                }
                Task.WaitAll(taskArray.ToArray());
            }            
        }

        public Boolean ExtraerCDR(long Idcomprobante,byte[] archivoRespuesta)
        {

            log.Info("Extraer CDR" + Idcomprobante.ToString());
            En_Respuesta oRespuesta = new En_Respuesta();
            Ln_Utilitario oUtilitario = new Ln_Utilitario();

            string nombreArchivoRespuesta = String.Format("{0}{1}{2}{3}{4}{5}.zip",DateTime.Now.ToString("yyyyMMdd"), DateTime.Now.Hour, DateTime.Now.Minute, DateTime.Now.Second, DateTime.Now.Millisecond,Idcomprobante);
                
            try
            {
                string rutaTemporal = RutaTemporalCdr("TempCDR");

                if (!Directory.Exists(rutaTemporal))
                {
                    Directory.CreateDirectory(rutaTemporal);
                }
                System.IO.File.WriteAllBytes(rutaTemporal + @"\" + nombreArchivoRespuesta, archivoRespuesta);
                
               

               

                string nombreArchivoDescomprimido = oUtilitario.Descomprimir(rutaTemporal, nombreArchivoRespuesta);
                oRespuesta = oUtilitario.LeerRespuestaXml(nombreArchivoDescomprimido);
                oRespuesta.Idcomprobante = Idcomprobante;
                oRespuesta.Archivo = archivoRespuesta;
                //guardar en base de datos
                oDatos.RegistrarRespuestaSunat(oRespuesta);
                string archivoEliminar = rutaTemporal + @"\" + nombreArchivoDescomprimido;
                if (File.Exists(archivoEliminar)){
                    File.Delete(archivoEliminar);
                }


            }
            catch (Exception ex)
            {
                //throw ex.Message;
                
            }
            return true;
        }

    }
}
