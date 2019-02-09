//using ICSharpCode.SharpZipLib.Core;
//using ICSharpCode.SharpZipLib.Zip;
using ServicioRepresentImpresa.Datos;
using ServicioRepresentImpresa.Entidad;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.ServiceModel;
using System.Text;
using System.Threading.Tasks;
using System.Xml;
using System.Xml.XPath;
using com.barcodelib.barcode;
namespace ServicioRepresentImpresa.Negocio
{
    public class Ne_Comprobante
    {
        readonly log4net.ILog log = log4net.LogManager.GetLogger(typeof(Ne_Comprobante));
        public void ProcesarRepresentacionImpresa()
        {
            try
            {
                Ad_Comprobante adComprobante = new Ad_Comprobante();
                List<En_Archivo> listaComprobante = adComprobante.ComprobantesPendientesGenerarPdf();

                if (listaComprobante.Count > 0)
                {
                    Task[] taskArray = new Task[listaComprobante.Count];

                    int i = 0;
                    foreach (En_Archivo comprobante in listaComprobante)
                    {
                        En_Archivo comprobanteParam = comprobante;
                        taskArray[i] = Task.Factory.StartNew(() => GenerarPdf(comprobanteParam));
                        i += 1;
                    }
                    Task.WaitAll(taskArray.ToArray());
                }
            }
            catch (Exception ex)
            {
                log.Error(ex.Message.ToString(), ex);
            }
        }
        public void InsertarRepresentacionImpresa(En_Archivo archivo)
        {
            try
            {
                Ad_Comprobante adComprobante = new Ad_Comprobante();
                adComprobante.InsertarRepresentacionImpresa(archivo);
               
            }
            catch (Exception ex)
            {
                log.Error(archivo.NombreXML + " "+ex.Message.ToString(), ex);
            }
        }
        public void GenerarPdf(En_Archivo comprobante)
        {
            string archivoXML = comprobante.Ruta + @"\" + comprobante.NombreXML;

            if (!Directory.Exists(comprobante.Ruta)){
                Directory.CreateDirectory(comprobante.Ruta);
            }

            try
            {
                if (!File.Exists(archivoXML))
                {
                    File.WriteAllBytes(archivoXML, comprobante.ArchivoXML);
                }
            }
            catch (Exception ex)
            {

                log.Error(String.Format("{0} Error : ", comprobante.NombreXML,ex.Message.ToString()));
                return;
            }


            if (comprobante.TipoComprobante == "01" || comprobante.TipoComprobante == "03")
            {
                Ne_Invoice oInvoice = new Ne_Invoice();
                oInvoice.GenerarInvoice(comprobante);
            }

            if (comprobante.TipoComprobante == "07")
            {
                Ne_CreditNote oInvoice = new Ne_CreditNote();
                oInvoice.GenerarCreditNote(comprobante);
            }

            if (comprobante.TipoComprobante == "08")
            {
                Ne_DebitNote oInvoice = new Ne_DebitNote();
                oInvoice.GenerarDebitNote(comprobante);
            }
                       
            //EliminarArchivo(rutaZipResponse);
            //EliminarArchivo(rutaArchivoZIP);
        }
    } 
}
