using ICSharpCode.SharpZipLib.Core;
using ICSharpCode.SharpZipLib.Zip;
using ServicioEnvio.Datos;
using ServicioEnvio.Entidad;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.ServiceModel;
using System.Text;
using System.Threading.Tasks;
using System.Xml;
using System.Xml.XPath;

namespace ServicioEnvio.Negocio
{
    public class Ne_Comprobante
    {
        readonly log4net.ILog log = log4net.LogManager.GetLogger(typeof(Ne_Comprobante));
        public void ProcesarEnviarComprobantes()
        {
            try
            {
                Ad_Comprobante adComprobante = new Ad_Comprobante();
                List<En_Comprobante> comprobantes = adComprobante.ComprobantesPendientesDeEnvio();

                if (comprobantes.Count > 0)
                {
                    Task[] taskArray = new Task[comprobantes.Count];

                    int i = 0;
                    foreach (En_Comprobante comprobante in comprobantes)
                    {
                        En_Comprobante comprobanteParam = comprobante;
                        taskArray[i] = Task.Factory.StartNew(() => EnviarComprobante(comprobanteParam));
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

        public void EnviarComprobante(En_Comprobante comprobante)
        {
            long idComprobante = comprobante.IdComprobante;
            Ad_Archivo adArchivo = new Ad_Archivo();
            Ad_Comprobante adComprobante = new Ad_Comprobante();
            En_Archivo archivo = adArchivo.ObtenerArchivoComprobante(idComprobante);
            string nombre = archivo.Nombre;
            byte[] contenido = archivo.Contenido;
            string carpetaTemporal = adArchivo.ObtenerRutaTemporal("TempENVIO");
            string carpetaArchivo = Path.GetFileNameWithoutExtension(nombre);
            string rutaCarpetaXML = Path.Combine(carpetaTemporal, carpetaArchivo);
            string rutaArchivoXML = Path.Combine(rutaCarpetaXML, nombre);
            string rutaArchivoZIP = string.Concat(rutaCarpetaXML, ".zip");
            string nombreArchivoZIP = Path.GetFileName(rutaArchivoZIP);
            string nombreArchivoZipResponse = string.Concat("R-", nombreArchivoZIP);
            string rutaZipResponse = Path.Combine(carpetaTemporal, nombreArchivoZipResponse);

            CrearCarpeta(rutaCarpetaXML);
            CrearArchivo(rutaArchivoXML, contenido);
            Comprimir(rutaArchivoZIP, rutaCarpetaXML);
            EliminarCarpeta(rutaCarpetaXML);

            byte[] archivoZip = File.ReadAllBytes(rutaArchivoZIP);
            wsSUNAT.sendBillRequest sendBill = new wsSUNAT.sendBillRequest();
            wsSUNAT.billServiceClient billService = new wsSUNAT.billServiceClient();

            try
            {
                billService.Open();
                byte[] archivoResponse = billService.sendBill(nombreArchivoZIP, archivoZip, "");
                adComprobante.InsertarCdrPendiente(idComprobante, archivoResponse);
                billService.Close();
                log.Info(string.Format("El comprobante {0}-{1} de la empresa emisora con ruc: {2} se procesó correctamente.",
                    comprobante.TipoComprobante, comprobante.SerieNumero, comprobante.RucEmisor));
            }
            catch (FaultException ex)
            {
                if (billService.State == CommunicationState.Opened)
                {
                    billService.Close();
                }
                string codigo = ex.Code.Name.ToLower().Replace("client.", "");
                string mensaje = ex.Message.ToString();
                int reintento = adComprobante.QuitarPendienteEnvio(idComprobante, codigo);
                string mensajeReintento = (reintento == 1) ? "Se dejará de reintentar el envío de éste comprobante." : "";

                log.Error(string.Format("El comprobante {0}-{1} de la empresa emisora con ruc: {2} obtuvo el código de error \"{3}\" con mensaje \"{4}\". {5}",
                    comprobante.TipoComprobante, comprobante.SerieNumero, comprobante.RucEmisor, codigo, mensaje, mensajeReintento));
            }

            EliminarArchivo(rutaZipResponse);
            EliminarArchivo(rutaArchivoZIP);
        }

        private void CrearCarpeta(string rutaCarpeta)
        {
            if (Directory.Exists(rutaCarpeta)) Directory.Delete(rutaCarpeta);
            Directory.CreateDirectory(rutaCarpeta);
        }

        private void EliminarCarpeta(string rutaCarpeta)
        {
            if (Directory.Exists(rutaCarpeta)) Directory.Delete(rutaCarpeta, true);
        }

        private void CrearArchivo(string rutaArchivo, byte[] contenido)
        {
            if (File.Exists(rutaArchivo)) File.Delete(rutaArchivo);
            File.WriteAllBytes(rutaArchivo, contenido);
        }

        private void EliminarArchivo(string rutaArchivo)
        {
            if (File.Exists(rutaArchivo)) File.Delete(rutaArchivo);
        }

        private void Comprimir(string rutaArchivoZip, string rutaCarpetaXML)
        {
            FileStream fsOut = File.Create(rutaArchivoZip);
            ZipOutputStream zipStream = new ZipOutputStream(fsOut);
            zipStream.SetLevel(3); //0-9, 9 being the highest level of compression
            int folderOffset = rutaCarpetaXML.Length + (rutaCarpetaXML.EndsWith("\\") ? 0 : 1);

            ProcesoCompresion(rutaCarpetaXML, zipStream, folderOffset);

            zipStream.IsStreamOwner = true; // Makes the Close also Close the underlying stream
            zipStream.Close();
        }

        private void ProcesoCompresion(string path, ZipOutputStream zipStream, int folderOffset)
        {
            string[] files = Directory.GetFiles(path);

            foreach (string filename in files)
            {
                FileInfo fi = new FileInfo(filename);
                string entryName = filename.Substring(folderOffset); // Makes the name in zip based on the folder
                entryName = ZipEntry.CleanName(entryName); // Removes drive from name and fixes slash direction
                ZipEntry newEntry = new ZipEntry(entryName);
                newEntry.DateTime = fi.LastWriteTime; // Note the zip format stores 2 second granularity
                newEntry.Size = fi.Length;
                zipStream.PutNextEntry(newEntry);
                byte[] buffer = new byte[4096];
                using (FileStream streamReader = File.OpenRead(filename))
                {
                    StreamUtils.Copy(streamReader, zipStream, buffer);
                }
                zipStream.CloseEntry();
            }
            string[] folders = Directory.GetDirectories(path);
            foreach (string folder in folders)
            {
                ProcesoCompresion(folder, zipStream, folderOffset);
            }
        }

        private string Descomprimir(string directorio, string zipFic = "")
        {
            string RutaArchivo = string.Empty;
            try
            {

                if (!zipFic.ToLower().EndsWith(".zip"))
                    zipFic = Directory.GetFiles(zipFic, "*.zip")[0];
                if (directorio == "")
                    directorio = ".";
                ZipInputStream z = new ZipInputStream(File.OpenRead(directorio + @"\" + zipFic));
                ZipEntry theEntry;
                do
                {
                    theEntry = z.GetNextEntry();
                    if (theEntry != null)
                    {
                        string fileName = directorio + @"\" + Path.GetFileName(theEntry.Name);
                        if (!Directory.Exists(fileName))
                        {
                            if (Path.GetExtension(fileName).ToString().ToUpper() == ".XML")
                            {
                                RutaArchivo = fileName;
                                FileStream streamWriter;
                                try
                                {
                                    streamWriter = File.Create(fileName);
                                }
                                catch (DirectoryNotFoundException ex)
                                {
                                    Directory.CreateDirectory(Path.GetDirectoryName(fileName));
                                    streamWriter = File.Create(fileName);
                                }
                                // 
                                int size;
                                byte[] data = new byte[2049];
                                do
                                {
                                    size = z.Read(data, 0, data.Length);
                                    if ((size > 0))
                                        streamWriter.Write(data, 0, size);
                                    else
                                        break;
                                }
                                while (true);
                                streamWriter.Close();
                            }
                        }
                    }
                    else
                        break;
                }
                while (true);
                z.Close();
                return RutaArchivo;
            }
            catch (Exception ex)
            {
                //Log.Error(ex.Message, excepcion: ex);
            }
            return "";
        }
    }
}
