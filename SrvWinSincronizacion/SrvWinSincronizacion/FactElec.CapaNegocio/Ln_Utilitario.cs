﻿using FactElec.EntidadNegocio;
using ICSharpCode.SharpZipLib.Zip;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml;
using System.Xml.XPath;

namespace FactElec.LogicaNegocio
{
    public class Ln_Utilitario
    {

        public En_Respuesta LeerRespuestaXml(string nombreArchivoDescomprimido)
        {            
            string cadenaXML = "";
            En_Respuesta oRespuesta = new En_Respuesta();
            StreamReader strreader = new StreamReader(nombreArchivoDescomprimido, System.Text.Encoding.UTF8);
            cadenaXML = strreader.ReadToEnd();

            XmlDocument xmlRespuesta = new XmlDocument();
            xmlRespuesta.LoadXml(cadenaXML);

            strreader.Dispose();
            XPathNavigator nav = xmlRespuesta.CreateNavigator();
            XmlNamespaceManager ns = ObtenerXmlNamespaces(nav);

            foreach (XPathNavigator nodoXML in nav.Select("*/cac:DocumentResponse/cac:Response", ns))
            {
                oRespuesta.Codigo = NodeValue(nodoXML.SelectSingleNode("cbc:ResponseCode", ns), "");
                oRespuesta.Descripcion = NodeValue(nodoXML.SelectSingleNode("cbc:Description", ns), "");                
            }

            List<string> listaMensaje = new List<string>();
            foreach (XPathNavigator nodoXML in nav.Select("*/cbc:Note", ns))
            {
                string mensaje = NodeValue(nodoXML.SelectSingleNode("cbc:ResponseCode", ns), "");
                if (mensaje.Trim().Length > 0) {
                    listaMensaje.Add(mensaje);
                }                
            }

            if (listaMensaje.Count > 0) {
                oRespuesta.Detalle = listaMensaje.ToArray();
            }

            oRespuesta.FecharespuestaSunat = NodeValue(nav.SelectSingleNode("*/cbc:ResponseDate", ns),"");
            oRespuesta.HoraRespuestaSunat = NodeValue(nav.SelectSingleNode("*/cbc:ResponseTime", ns),"");

            return oRespuesta;
        }
        public static XmlNamespaceManager ObtenerXmlNamespaces(XPathNavigator nav)
        {
            var ns = new XmlNamespaceManager(nav.NameTable);
            var nodes = nav.Select("/*/namespace::cac");
            while (nodes.MoveNext())
            {
                var nsis = nodes.Current.GetNamespacesInScope(XmlNamespaceScope.Local);
                foreach (var nsi in nsis)
                {
                    var prf = nsi.Key == string.Empty ? "global" : nsi.Key;
                    ns.AddNamespace(prf, nsi.Value);
                }
            }

            return ns;
        }
        public static string NodeValue(XPathItem node, string defaultValue)
        {
            if (node != null)
                return node.Value ?? defaultValue;
            return defaultValue;
        }
        public string Descomprimir(string directorio, string zipFic = "")
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
