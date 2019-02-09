
using ServicioRepresentImpresa.Entidad.ComprobanteElectronico.Invoice;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;
using System.Drawing;
using com.barcodelib.barcode;
//using CrystalDecisions.Windows.Forms;
using ServicioRepresentImpresa.Entidad;
using CrystalDecisions.CrystalReports.Engine;

namespace ServicioRepresentImpresa.Negocio
{
    public class Ne_Invoice
    {
        readonly log4net.ILog log = log4net.LogManager.GetLogger(typeof(Ne_Invoice));

        #region procedimientos - funciones
        private DataTable FnTablaCabeceraInvoice(InvoiceType ocomprobante,En_Archivo archivo)
        {

            DataTable dtCabecera = new DataTable();
            dtCabecera.Columns.Add(new DataColumn("SerieNumero", typeof(string)));
            dtCabecera.Columns.Add(new DataColumn("FechaEmision", typeof(string)));
            dtCabecera.Columns.Add(new DataColumn("FechaVencimiento", typeof(string)));
            dtCabecera.Columns.Add(new DataColumn("TipoComprobante", typeof(string)));
            dtCabecera.Columns.Add(new DataColumn("Moneda", typeof(string)));
            dtCabecera.Columns.Add(new DataColumn("MontoLetras", typeof(string)));
            dtCabecera.Columns.Add(new DataColumn("QR", typeof(Byte[])));
            dtCabecera.Columns.Add(new DataColumn("TotalValorVentaGravada", typeof(string)));
            dtCabecera.Columns.Add(new DataColumn("IGV", typeof(string)));
            dtCabecera.Columns.Add(new DataColumn("ImporteTotal", typeof(string)));

            DataRow fila;
            fila = dtCabecera.NewRow();
            fila["SerieNumero"] = FnValidarNulo(ocomprobante.ID.Value.ToString());
            fila["FechaEmision"] = FnValidarNulo(ocomprobante.IssueDate.Value.ToString());
            fila["FechaVencimiento"] = FnValidarNulo(ocomprobante.DueDate.Value.ToString());

            if (ocomprobante.InvoiceTypeCode.Value.ToString() == "01") fila["TipoComprobante"] = "FACTURA ELECTRÓNICA";
            if (ocomprobante.InvoiceTypeCode.Value.ToString() == "03") fila["TipoComprobante"] = "BOLETA ELECTRÓNICA";

            if (ocomprobante.DocumentCurrencyCode.Value.ToString() == "PEN") fila["Moneda"] = "NUEVO SOL";
            if (ocomprobante.DocumentCurrencyCode.Value.ToString() == "USD") fila["Moneda"] = "DOLAR AMERICANO";


            fila["MontoLetras"] = "";
            if (ocomprobante.Note != null)
            {
                if (ocomprobante.Note.Length > 0)
                {
                    foreach (NoteType nota in ocomprobante.Note)
                    {
                        if (nota.languageLocaleID == "1000") fila["MontoLetras"] = nota.Value.ToString();
                    }
                }
            }

            fila["QR"] = FnCodigoQR(archivo.Qr);

            if (ocomprobante.TaxTotal != null)
            {
                foreach (TaxTotalType total in ocomprobante.TaxTotal)
                {
                    foreach (TaxSubtotalType subTotal in total.TaxSubtotal)
                    {
                        if (subTotal.TaxCategory.TaxScheme.Name.Value.ToString() == "IGV")
                        {
                            fila["IGV"] = FnValidarNulo(subTotal.TaxAmount.Value.ToString());
                        }
                    }
                }
            }

            if (ocomprobante.LegalMonetaryTotal != null)
            {
                fila["TotalValorVentaGravada"] = FnValidarNulo(ocomprobante.LegalMonetaryTotal.LineExtensionAmount.Value.ToString());
                fila["ImporteTotal"] = FnValidarNulo(ocomprobante.LegalMonetaryTotal.PayableAmount.Value.ToString());
            }


            dtCabecera.Rows.Add(fila);

            return dtCabecera;
        }

        public static Bitmap GetImageFromByteArray(byte[] byteArray)
        {
            ImageConverter _imageConverter = new ImageConverter();
            Bitmap bm = (Bitmap)_imageConverter.ConvertFrom(byteArray);
            if (bm != null && (bm.HorizontalResolution != System.Convert.ToInt32(bm.HorizontalResolution) || bm.VerticalResolution != System.Convert.ToInt32(bm.VerticalResolution)))
                bm.SetResolution(System.Convert.ToInt32((bm.HorizontalResolution + 0.5F)), System.Convert.ToInt32((bm.VerticalResolution + 0.5F)));

            return bm;
        }

        public static byte[] FnCodigoQR(string _code, int Scale = 1)
        {
            try
            {
                byte[] ArregloCodigoBarras;

                string initialString = _code;
                QRCode barcode = new QRCode();
                barcode.setData(initialString);
                barcode.setDataMode(QRCode.MODE_AUTO);
                barcode.setVersion(10);

                barcode.setEcl(QRCode.ECL_Q);
                barcode.setProcessTilde(true);
                barcode.setUOM(QRCode.UOM_INCH);

                barcode.setLeftMargin((float)0.874);
                barcode.setRightMargin((float)0.875);
                barcode.setTopMargin((float)0.05);
                barcode.setBottomMargin((float)0.05);
                barcode.setResolution(72);
                barcode.setModuleSize((float)0.04);

                ArregloCodigoBarras = barcode.renderBarcodeToBytes();

                ArregloCodigoBarras = barcode.renderBarcodeToBytes();

                MemoryStream memoria = new MemoryStream();
                Bitmap newBitmap = GetImageFromByteArray(ArregloCodigoBarras);
                newBitmap.Save(memoria, System.Drawing.Imaging.ImageFormat.Bmp);

                return memoria.ToArray();
            }

            catch (Exception ex)
            {
                throw new Exception("Error generating FnCodigoQR barcode. Desc:" + ex.Message);
            }
        }


        private DataTable FnTablaEmisor(InvoiceType ocomprobante)
        {

            DataTable dtEmisor = new DataTable();
            dtEmisor.Columns.Add(new DataColumn("RucEmisor", typeof(string)));
            dtEmisor.Columns.Add(new DataColumn("RazonSocialEmisor", typeof(string)));
            dtEmisor.Columns.Add(new DataColumn("NombreComercialEmisor", typeof(string)));
            dtEmisor.Columns.Add(new DataColumn("DepartamentoEmisor", typeof(string)));
            dtEmisor.Columns.Add(new DataColumn("ProvinciaEmisor", typeof(string)));
            dtEmisor.Columns.Add(new DataColumn("DistritoEmisor", typeof(string)));
            dtEmisor.Columns.Add(new DataColumn("DireccionEmisor", typeof(string)));

            DataRow fila;
            fila = dtEmisor.NewRow();

            if (ocomprobante.AccountingSupplierParty != null)
            {
                fila["RucEmisor"] = FnValidarNulo(ocomprobante.AccountingSupplierParty.Party.PartyIdentification[0].ID.Value.ToString());
                fila["RazonSocialEmisor"] = FnValidarNulo(ocomprobante.AccountingSupplierParty.Party.PartyLegalEntity[0].RegistrationName.Value.ToString());
                fila["NombreComercialEmisor"] = FnValidarNulo(ocomprobante.AccountingSupplierParty.Party.PartyName[0].Name.Value.ToString());
                fila["DepartamentoEmisor"] = FnValidarNulo(ocomprobante.AccountingSupplierParty.Party.PartyLegalEntity[0].RegistrationAddress.CountrySubentity.Value.ToString());
                fila["ProvinciaEmisor"] = FnValidarNulo(ocomprobante.AccountingSupplierParty.Party.PartyLegalEntity[0].RegistrationAddress.CityName.Value.ToString());
                fila["DistritoEmisor"] = FnValidarNulo(ocomprobante.AccountingSupplierParty.Party.PartyLegalEntity[0].RegistrationAddress.District.Value.ToString());
                fila["DireccionEmisor"] = FnValidarNulo(ocomprobante.AccountingSupplierParty.Party.PartyLegalEntity[0].RegistrationAddress.AddressLine[0].Line.Value.ToString());
            }

            dtEmisor.Rows.Add(fila);

            return dtEmisor;
        }

        private DataTable FnTablaReceptor(InvoiceType ocomprobante)
        {

            DataTable dtReceptor = new DataTable();
            dtReceptor.Columns.Add(new DataColumn("RucReceptor", typeof(string)));
            dtReceptor.Columns.Add(new DataColumn("RazonSocialReceptor", typeof(string)));
            dtReceptor.Columns.Add(new DataColumn("NombreComercialReceptor", typeof(string)));
            dtReceptor.Columns.Add(new DataColumn("DepartamentoReceptor", typeof(string)));
            dtReceptor.Columns.Add(new DataColumn("ProvinciaReceptor", typeof(string)));
            dtReceptor.Columns.Add(new DataColumn("DistritoReceptor", typeof(string)));
            dtReceptor.Columns.Add(new DataColumn("DireccionReceptor", typeof(string)));

            DataRow fila;
            fila = dtReceptor.NewRow();

            if (ocomprobante.AccountingCustomerParty != null)
            {
                fila["RucReceptor"] = FnValidarNulo(ocomprobante.AccountingCustomerParty.Party.PartyIdentification[0].ID.Value.ToString());
                fila["RazonSocialReceptor"] = FnValidarNulo(ocomprobante.AccountingCustomerParty.Party.PartyLegalEntity[0].RegistrationName.Value.ToString());
                fila["NombreComercialReceptor"] = FnValidarNulo(ocomprobante.AccountingCustomerParty.Party.PartyName[0].Name.Value.ToString());
                fila["DepartamentoReceptor"] = FnValidarNulo(ocomprobante.AccountingCustomerParty.Party.PartyLegalEntity[0].RegistrationAddress.CountrySubentity.Value.ToString());
                fila["ProvinciaReceptor"] = FnValidarNulo(ocomprobante.AccountingCustomerParty.Party.PartyLegalEntity[0].RegistrationAddress.CityName.Value.ToString());
                fila["DistritoReceptor"] = FnValidarNulo(ocomprobante.AccountingCustomerParty.Party.PartyLegalEntity[0].RegistrationAddress.District.Value.ToString());
                fila["DireccionReceptor"] = FnValidarNulo(ocomprobante.AccountingCustomerParty.Party.PartyLegalEntity[0].RegistrationAddress.AddressLine[0].Line.Value.ToString());
            }

            dtReceptor.Rows.Add(fila);

            return dtReceptor;
        }

        private DataTable FnTablaDetalle(InvoiceType ocomprobante)
        {

            DataTable dtDetalle = new DataTable();
            dtDetalle.Columns.Add(new DataColumn("Item", typeof(string)));
            dtDetalle.Columns.Add(new DataColumn("Descripcion", typeof(string)));
            dtDetalle.Columns.Add(new DataColumn("UM", typeof(string)));
            dtDetalle.Columns.Add(new DataColumn("VU", typeof(string)));
            dtDetalle.Columns.Add(new DataColumn("PU", typeof(string)));
            dtDetalle.Columns.Add(new DataColumn("Cantidad", typeof(string)));
            dtDetalle.Columns.Add(new DataColumn("ImporteSinIGV", typeof(string)));

            DataRow fila;
            fila = dtDetalle.NewRow();

            if (ocomprobante.InvoiceLine != null)
            {

                foreach (InvoiceLineType detalle in ocomprobante.InvoiceLine)
                {
                    fila["Item"] = FnValidarNulo(detalle.ID.Value.ToString());
                    fila["Descripcion"] = FnValidarNulo(detalle.Item.Description[0].Value.ToString());
                    fila["UM"] = "UND";
                    fila["VU"] = FnValidarNulo(detalle.PricingReference.AlternativeConditionPrice[0].PriceAmount.Value.ToString());
                    fila["PU"] = FnValidarNulo(detalle.PricingReference.AlternativeConditionPrice[0].PriceAmount.Value.ToString());
                    fila["Cantidad"] = FnValidarNulo(detalle.InvoicedQuantity.Value.ToString());
                    fila["ImporteSinIGV"] = FnValidarNulo(detalle.LineExtensionAmount.Value.ToString());
                }
            }

            dtDetalle.Rows.Add(fila);

            return dtDetalle;
        }

        private string FnValidarNulo(object valor)
        {
            try
            {
                string cadena = "";
                if (!String.IsNullOrEmpty(valor.ToString()))
                {
                    cadena = valor.ToString();
                }
                return cadena;
            }
            catch (Exception)
            {

                return "";
            }
        }
        #endregion


        public void GenerarInvoice(En_Archivo archivo)
        {            
            InvoiceType ocomprobante;
            string rutaXml = archivo.Ruta + @"\" + archivo.NombreXML;
            string rutaPdf = archivo.Ruta + @"\" + archivo.NombreXML.Replace("xml","pdf"); 
            string nombrePdf= archivo.NombreXML.Replace("xml", "pdf"); 
            XmlSerializer oserial = new XmlSerializer(typeof(InvoiceType));

            using (StreamReader reader = new StreamReader(rutaXml))
            {
                ocomprobante = (InvoiceType)oserial.Deserialize(reader);
            }


            DataSet general = new DataSet();
            //Para la cabecera
            DataTable TablaCabecera = FnTablaCabeceraInvoice(ocomprobante,archivo);
            TablaCabecera.TableName = "Comprobante";
            general.Tables.Add(TablaCabecera);
            //Emisor
            DataTable TablaEmisor = FnTablaEmisor(ocomprobante);
            TablaEmisor.TableName = "Emisor";
            general.Tables.Add(TablaEmisor);
            //Receptor
            DataTable TablaReceptor = FnTablaReceptor(ocomprobante);
            TablaReceptor.TableName = "receptor";
            general.Tables.Add(TablaReceptor);

            //Detalle
            DataTable TablaDetalle = FnTablaDetalle(ocomprobante);
            TablaDetalle.TableName = "Detalle";
            general.Tables.Add(TablaDetalle);


            ReportDocument rpt = new ReportDocument();
            try
            {
                //String rutaReporte = @"C:\Facturacion\CrpInvoice.rpt";
               
                String rutaReporte = System.AppDomain.CurrentDomain.BaseDirectory.ToString() + @"CrpInvoice.rpt";
                //System.IO.Path.GetDirectoryName(System.Reflection.Assembly.GetEntryAssembly().Location) + @"\CrpInvoice.rpt";
                log.Info(rutaReporte);
                rpt.Load(rutaReporte);
                rpt.SetDataSource(general);

                rpt.ExportToDisk(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, rutaPdf);

                if (File.Exists(rutaPdf)) {
                    byte[] archivoPdf = File.ReadAllBytes(rutaPdf);
                    archivo.ArchivoPdf = archivoPdf;
                    archivo.NombrePdf = nombrePdf;
                    Ne_Comprobante oComprobante = new Ne_Comprobante();
                    oComprobante.InsertarRepresentacionImpresa(archivo);
                    log.Info(archivo.NombrePdf + " se genero correctamente la representacion impresa");
                }
            }
            catch (Exception ex)
            {
                log.Error(archivo.NombreXML + " Error " + ex.Message);
            }
        }
    }
}
