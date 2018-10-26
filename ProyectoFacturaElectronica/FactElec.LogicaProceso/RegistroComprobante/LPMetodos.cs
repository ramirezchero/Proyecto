using FactElec.CapaEntidad.ComprobanteElectronico.Invoice;
using FactElec.CapaEntidad.RegistroComprobante;
using System;
using System.Collections.Generic;
using System.IO;
using System.Text;
using System.Xml;
using System.Xml.Serialization;

namespace FactElec.LogicaProceso.RegistroComprobante
{
    public class LPMetodos
    {
        public bool RegistroComprobante(En_ComprobanteElectronico Comprobante)
        {
            InvoiceType invoice = new InvoiceType();
            LlenarCabecera(Comprobante, ref invoice);
            LlenarEmisor(Comprobante.Emisor, ref invoice);
            LlenarReceptor(Comprobante.Receptor, ref invoice);
            LlenarDescuentoCargo(Comprobante, ref invoice);
            LlenarMontosIGV(Comprobante, ref invoice);
            LlenarMontosTotales(Comprobante, ref invoice);
            LlenarDetalle(Comprobante, ref invoice);
            CrearXML(ref invoice);
            return true;
        }


        TaxSubtotalType LlenarSubTotalDetalle(decimal MontoOperaciones, decimal MontoTotalImpuesto, string Moneda, decimal PorcentajeImpuesto, string CodigoInternacionalTributo, string NombreTributo, string CodigoTributo, string AfectacionIGV)
        {
            TaxSubtotalType oSubtotal = new TaxSubtotalType
            {
                TaxableAmount = new TaxableAmountType
                {
                    Value = MontoOperaciones,
                    currencyID = Moneda
                },
                TaxAmount = new TaxAmountType
                {
                    Value = MontoTotalImpuesto,
                    currencyID = Moneda
                },
                TaxCategory = new TaxCategoryType
                {
                    Percent = new PercentType1
                    {
                        Value = PorcentajeImpuesto
                    },
                    TaxExemptionReasonCode = new TaxExemptionReasonCodeType
                    {
                        listAgencyName = "PE:SUNAT",
                        listName = "Afectacion del IGV",
                        listURI = "urn:pe:gob:sunat:cpe:see:gem:catalogos:catalogo07",
                        Value = AfectacionIGV
                    },
                    TaxScheme = new TaxSchemeType
                    {
                        ID = new IDType
                        {
                            schemeAgencyName = "PE:SUNAT",
                            schemeName = "Codigo de tributos",
                            schemeURI = "urn:pe:gob:sunat:cpe:see:gem:catalogos:catalogo05",
                            Value = CodigoInternacionalTributo
                        },
                        Name = new NameType1
                        {
                            Value = NombreTributo
                        },
                        TaxTypeCode = new TaxTypeCodeType
                        {
                            Value = CodigoTributo
                        }
                    }
                }
            };
            return oSubtotal;

        }

        void LlenarDetalle(En_ComprobanteElectronico Comprobante, ref InvoiceType invoice)
        {
            List<InvoiceLineType> oListaDetalle = new List<InvoiceLineType>();

            foreach (En_ComprobanteDetalle oDet in Comprobante.ComprobanteDetalle)
            {

                List<TaxSubtotalType> oListaSubtotal = new List<TaxSubtotalType>();

                foreach (En_ComprobanteDetalleImpuestos odetImpuesto in oDet.ComprobanteDetalleImpuestos)
                {
                    TaxSubtotalType oSubTotal = new TaxSubtotalType();
                    oSubTotal = LlenarSubTotalDetalle(odetImpuesto.MontoOperacion, odetImpuesto.MontoTotalImpuesto, Comprobante.Moneda.Trim(), odetImpuesto.Porcentaje, odetImpuesto.CodigoInternacionalTributo, odetImpuesto.NombreTributo, odetImpuesto.CodigoTributo, odetImpuesto.AfectacionIGV);
                    oListaSubtotal.Add(oSubTotal);
                }

                InvoiceLineType oInvoiceLine = new InvoiceLineType
                {
                    ID = new IDType
                    {
                        Value = oDet.Item
                    },
                    InvoicedQuantity = new InvoicedQuantityType
                    {
                        unitCode = "NIU",
                        unitCodeListAgencyName = "United Nations Economic Commission for Europe",
                        unitCodeListID = "UN/ECE rec 20",
                        Value = oDet.Cantidad
                    },
                    LineExtensionAmount = new LineExtensionAmountType
                    {
                        Value = oDet.Total,
                        currencyID = Comprobante.Moneda.Trim()
                    },
                    PricingReference = new PricingReferenceType
                    {
                        AlternativeConditionPrice = new PriceType[] {
                           new PriceType {
                               PriceAmount=new PriceAmountType{
                                   Value =oDet.ValorVentaUnitarioIncIgv,
                                   currencyID=Comprobante.Moneda .Trim ()
                               },
                               PriceTypeCode=new PriceTypeCodeType{
                                   Value =oDet.CodigoTipoPrecio,
                                   listAgencyName="PE:SUNAT" ,
                                   listName ="Tipo de Precio" ,
                                   listURI ="urn:pe:gob:sunat:cpe:see:gem:catalogos:catalogo16"
                               }

                           }
                       }
                    },
                    TaxTotal = new TaxTotalType[] {
                        new TaxTotalType{
                            TaxAmount =new TaxAmountType{
                                Value =oDet.ImpuestoTotal ,
                                currencyID =Comprobante.Moneda.Trim ()
                            },
                            TaxSubtotal =oListaSubtotal.ToArray()

                            }
                        },
                    Price = new PriceType {
                        PriceAmount = new PriceAmountType {
                            Value = oDet.ValorVentaUnitario,
                            currencyID = Comprobante.Moneda.Trim()
                        }
                    },
                    Item = new ItemType
                    {
                        Description = new DescriptionType[] {
                        },
                        SellersItemIdentification = new ItemIdentificationType
                        {
                            ID = new IDType
                            {
                                Value = ""
                            }
                        },
                        CommodityClassification = new CommodityClassificationType[]
                        {
                            new CommodityClassificationType{
                                CommodityCode =new CommodityCodeType
                                {
                                        listAgencyName="GS1 US",
                                        listID ="UNSPSC" ,
                                        listName ="Item Classification",
                                        Value =""
                                }
                            }
                            //=new CommodityClassificationType{
                            //       ItemClassificationCodeType =new ItemClassificationCodeType
                            //{
                            //    listAgencyName="GS1 US",
                            //    listID ="UNSPSC" ,
                            //    listName ="Item Classification",
                            //    Value =""
                            //}
                            //}
                            //CommodityClassificationType=new CommodityClassificationType
                            //{
                            //    ItemClassificationCodeType =new ItemClassificationCodeType
                            //{
                            //    listAgencyName="GS1 US",
                            //    listID ="UNSPSC" ,
                            //    listName ="Item Classification",
                            //    Value =""
                            //}
                            //}
                            
                        }
                    }

                };
                oListaDetalle.Add(oInvoiceLine);


            };
            invoice.InvoiceLine = oListaDetalle.ToArray();          

        }
        

   
    void LlenarDescuentoCargo(En_ComprobanteElectronico Comprobante, ref InvoiceType invoice)
    {
        List<AllowanceChargeType> oListaDescuentoCargo = new List<AllowanceChargeType>();

        foreach (En_DescuentoCargo oDescar in Comprobante.DescuentoCargo)
        {
            AllowanceChargeType oDescuentoCargo = new AllowanceChargeType
            {
                ChargeIndicator = new ChargeIndicatorType
                {
                    Value = oDescar.Indicador
                },
                AllowanceChargeReasonCode = new AllowanceChargeReasonCodeType
                {
                    listAgencyName = "PE:SUNAT",
                    listName = "Cargo/descuento",
                    listURI = "urn:pe:gob:sunat:cpe:see:gem:catalogos:catalogo53",
                    Value = oDescar.CodigoMotivo
                },
                MultiplierFactorNumeric = new MultiplierFactorNumericType
                {
                    Value = oDescar.Factor
                },
                Amount = new AmountType2
                {
                    Value = oDescar.MontoTotal,
                    currencyID = Comprobante.Moneda.Trim()
                },
                BaseAmount = new BaseAmountType
                {
                    Value = oDescar.MontoBase,
                    currencyID = Comprobante.Moneda.Trim()
                }

            };
            oListaDescuentoCargo.Add(oDescuentoCargo);
        }
        invoice.AllowanceCharge = oListaDescuentoCargo.ToArray();

    }

    void LlenarMontosTotales(En_ComprobanteElectronico Comprobante, ref InvoiceType invoice)
    {
        MonetaryTotalType oTotal = new MonetaryTotalType
        {
            LineExtensionAmount = new LineExtensionAmountType
            {
                Value = Comprobante.TotalValorVenta,
                currencyID = Comprobante.Moneda.Trim()
            },
            TaxInclusiveAmount = new TaxInclusiveAmountType
            {
                Value = Comprobante.TotalPrecioVenta,
                currencyID = Comprobante.Moneda.Trim()
            },
            PayableAmount = new PayableAmountType
            {
                Value = Comprobante.ImporteTotal,
                currencyID = Comprobante.Moneda.Trim()
            },
            ChargeTotalAmount = new ChargeTotalAmountType
            {
                Value = Comprobante.TotalCargo,
                currencyID = Comprobante.Moneda.Trim()
            },
            AllowanceTotalAmount = new AllowanceTotalAmountType
            {
                Value = Comprobante.TotalDescuento,
                currencyID = Comprobante.Moneda.Trim()
            }
        };
        invoice.LegalMonetaryTotal = oTotal;

    }
    void LlenarMontosIGV(En_ComprobanteElectronico Comprobante, ref InvoiceType invoice)
    {
        List<TaxSubtotalType> oListaSubtotal = new List<TaxSubtotalType>();

        if (Comprobante.MontoTotales != null)
        {
            if (Comprobante.MontoTotales.Gravado != null)
            {
                if (Comprobante.MontoTotales.Gravado.GrabadoIGV != null)
                {
                    TaxSubtotalType oTotalGravado = LlenarSubTotalCabecera(Comprobante.MontoTotales.Gravado.GrabadoIGV.MontoOperaciones, Comprobante.MontoTotales.Gravado.GrabadoIGV.MontoTotalImpuesto, Comprobante.Moneda, Comprobante.MontoTotales.Gravado.GrabadoIGV.Porcentaje, "1000", "IGV", "VAT");
                    oListaSubtotal.Add(oTotalGravado);
                }

            }
        }


        TaxTotalType oTaxTotal = new TaxTotalType
        {
            TaxAmount = new TaxAmountType
            {
                Value = Comprobante.TotalImpuesto,
                currencyID = Comprobante.Moneda
            },
            TaxSubtotal = oListaSubtotal.ToArray()
        };

        invoice.TaxTotal = new TaxTotalType[] { oTaxTotal };

    }
    TaxSubtotalType LlenarSubTotalCabecera(decimal MontoOperaciones, decimal MontoTotalImpuesto, string Moneda, decimal PorcentajeImpuesto, string CodigoInternacionalTributo, string NombreTributo, string CodigoTributo)
    {
        TaxSubtotalType oSubtotal = new TaxSubtotalType
        {
            TaxableAmount = new TaxableAmountType
            {
                Value = MontoOperaciones,
                currencyID = Moneda
            },
            TaxAmount = new TaxAmountType
            {
                Value = MontoTotalImpuesto,
                currencyID = Moneda
            },
            Percent = new PercentType1
            {
                Value = PorcentajeImpuesto
            },
            TaxCategory = new TaxCategoryType
            {
                TaxScheme = new TaxSchemeType
                {
                    ID = new IDType
                    {
                        schemeAgencyName = "PE:SUNAT",
                        schemeName = "Codigo de tributos",
                        schemeURI = "urn:pe:gob:sunat:cpe:see:gem:catalogos:catalogo05",
                        Value = CodigoInternacionalTributo
                    },
                    Name = new NameType1
                    {
                        Value = NombreTributo
                    },
                    TaxTypeCode = new TaxTypeCodeType
                    {
                        Value = CodigoTributo
                    }
                }
            }
        };
        return oSubtotal;

    }
    void CrearXML(ref InvoiceType invoice)
    {

        XmlSerializer oxmlSerializer = new XmlSerializer(typeof(InvoiceType));
        var xmlNameSpaceNom = new XmlSerializerNamespaces();
        xmlNameSpaceNom.Add("cac", "urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2");
        xmlNameSpaceNom.Add("cbc", "urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2");
        xmlNameSpaceNom.Add("ds", "http://www.w3.org/2000/09/xmldsig#");
        xmlNameSpaceNom.Add("ext", "urn:oasis:names:specification:ubl:schema:xsd:CommonExtensionComponents-2");
        xmlNameSpaceNom.Add("qdt", "urn:oasis:names:specification:ubl:schema:xsd:QualifiedDatatypes-2");
        xmlNameSpaceNom.Add("sac", "urn:sunat:names:specification:ubl:peru:schema:xsd:SunatAggregateComponents-1");
        xmlNameSpaceNom.Add("udt", "urn:un:unece:uncefact:data:specification:UnqualifiedDataTypesSchemaModule:2");

        string ruta = @"D:\XML\PrimeraFactura.xml";
        string sxml = "";

        using (var sw = new StringWriter())
        {
            using (XmlWriter writter = XmlWriter.Create(sw))
            {                    
               oxmlSerializer.Serialize(writter, invoice, xmlNameSpaceNom);                
                sxml = sw.ToString();
            }
            
        }

        File.WriteAllText(ruta, sxml, Encoding.UTF8);

    }
    void LlenarCabecera(CapaEntidad.RegistroComprobante.En_ComprobanteElectronico Comprobante, ref InvoiceType invoice)
    {
        //Serie y Numero          
        invoice.ID = new IDType
        {
            Value = String.Format("{0}-{1}", Comprobante.Serie.Trim(), Comprobante.Numero.Trim())
        };

        invoice.UBLVersionID = new UBLVersionIDType
        {
            Value = "2.1"
        };

        invoice.IssueDate = new IssueDateType
        {
            Value = Convert.ToDateTime(Comprobante.FechaEmision)
        };
        invoice.IssueTime = new IssueTimeType
        {
            Value = Convert.ToDateTime(Comprobante.HoraEmision)
        };

        invoice.DocumentCurrencyCode = new DocumentCurrencyCodeType
        {
            listAgencyName = "United Nations Economic Commission for Europe",
            listID = "ISO 4217 Alpha",
            listName = "Currency",
            Value = Comprobante.Moneda.Trim()
        };

        invoice.CustomizationID = new CustomizationIDType
        {
            Value = "2.0"
        };

        invoice.InvoiceTypeCode = new InvoiceTypeCodeType
        {
            listAgencyName = "PE:SUNAT",
            listID = "0101",
            listName = "Tipo de Documento",
            listSchemeURI = "urn:pe:gob:sunat:cpe:see:gem:catalogos:catalogo51",
            listURI = "urn:pe:gob:sunat:cpe:see:gem:catalogos:catalogo01",
            name = "Tipo de Operacion",
            Value = Comprobante.TipoOperacion.Trim()
        };

    }


    void LlenarEmisor(CapaEntidad.RegistroComprobante.En_Emisor Emisor, ref InvoiceType invoice)
    {

        WebsiteURIType EmisorPaginaWeb = new WebsiteURIType
        {
            Value = Emisor.PaginaWeb.Trim()
        };

        List<PartyNameType> oListaNombreComercial = new List<PartyNameType>();
        PartyNameType PartyName = new PartyNameType
        {
            Name = new NameType1
            {
                Value = Emisor.NombreComercial.Trim()
            }
        };
        oListaNombreComercial.Add(PartyName);


        PartyIdentificationType EmisorIdentificacion = new PartyIdentificationType();
        List<PartyIdentificationType> EmisorListaIdentificacion = new List<PartyIdentificationType>();
        EmisorIdentificacion.ID = new IDType
        {
            Value = Emisor.NumeroDocumentoIdentidad.Trim(),
            schemeAgencyID = "PE:SUNAT",
            schemeID = Emisor.TipoDocumentoIdentidad.Trim(),
            schemeName = "Documento de Identidad",
            schemeURI = "urn:pe:gob:sunat:cpe:see:gem:catalogos:catalogo06"
        };
        EmisorListaIdentificacion.Add(EmisorIdentificacion);

        //Razon social
        PartyLegalEntityType oRazonSocial = new PartyLegalEntityType
        {
            RegistrationName = new RegistrationNameType
            {
                Value = Emisor.RazonSocial,
            },

            RegistrationAddress = new AddressType
            {
                ID = new IDType
                {
                    Value = Emisor.CodigoUbigeo.Trim(),
                    schemeAgencyName = "PE:INEI",
                    schemeName = "Ubigeos"
                },
                AddressTypeCode = new AddressTypeCodeType
                {
                    Value = Emisor.CodigoDomicilioFiscal.Trim(),
                    listAgencyName = "PE:SUNAT",
                    listName = "Establecimientos anexos"
                },
                CitySubdivisionName = new CitySubdivisionNameType
                {
                    Value = Emisor.Urbanizacion.Trim()
                },
                CityName = new CityNameType
                {
                    Value = Emisor.Provincia.Trim()
                },
                CountrySubentity = new CountrySubentityType
                {
                    Value = Emisor.Departamento.Trim()
                },
                District = new DistrictType
                {
                    Value = Emisor.Distrito.Trim()
                },
                AddressLine = new AddressLineType[] {
                        new AddressLineType {
                            Line =new LineType{
                                Value =Emisor.Direccion.Trim()
                            }
                        }
                    },
                Country = new CountryType
                {
                    IdentificationCode = new IdentificationCodeType
                    {
                        listAgencyName = "United Nations Economic Commission for Europe",
                        listID = "ISO 3166-1",
                        listName = "Country",
                        Value = Emisor.CodigoPais.Trim()
                    }
                }

            }
        };

        ContactType oContacto = new ContactType
        {
            ElectronicMail = new ElectronicMailType()
            {
                Value = Emisor.Contacto.Correo.Trim()
            },
            Name = new NameType1
            {
                Value = Emisor.Contacto.Nombre.Trim()
            },
            Telephone = new TelephoneType
            {
                Value = Emisor.Contacto.Telefono.Trim()
            }
        };

        SupplierPartyType oEmisor = new SupplierPartyType
        {
            Party = new PartyType
            {
                WebsiteURI = EmisorPaginaWeb,
                PartyIdentification = EmisorListaIdentificacion.ToArray(),
                PartyName = oListaNombreComercial.ToArray(),
                PartyLegalEntity = new PartyLegalEntityType[] { oRazonSocial },
                Contact = oContacto

            }
        };

        invoice.AccountingSupplierParty = oEmisor;


    }

    void LlenarReceptor(CapaEntidad.RegistroComprobante.En_Receptor Receptor, ref InvoiceType invoice)
    {

        WebsiteURIType EmisorPaginaWeb = new WebsiteURIType
        {
            Value = Receptor.PaginaWeb.Trim()
        };

        List<PartyNameType> oListaNombreComercial = new List<PartyNameType>();
        PartyNameType PartyName = new PartyNameType
        {
            Name = new NameType1
            {
                Value = Receptor.NombreComercial.Trim()
            }
        };
        oListaNombreComercial.Add(PartyName);


        PartyIdentificationType EmisorIdentificacion = new PartyIdentificationType();
        List<PartyIdentificationType> EmisorListaIdentificacion = new List<PartyIdentificationType>();
        EmisorIdentificacion.ID = new IDType
        {
            Value = Receptor.NumeroDocumentoIdentidad.Trim(),
            schemeAgencyID = "PE:SUNAT",
            schemeID = Receptor.TipoDocumentoIdentidad.Trim(),
            schemeName = "Documento de Identidad",
            schemeURI = "urn:pe:gob:sunat:cpe:see:gem:catalogos:catalogo06"
        };
        EmisorListaIdentificacion.Add(EmisorIdentificacion);

        //Razon social
        PartyLegalEntityType oRazonSocial = new PartyLegalEntityType
        {
            RegistrationName = new RegistrationNameType
            {
                Value = Receptor.RazonSocial,
            },

            RegistrationAddress = new AddressType
            {
                ID = new IDType
                {
                    Value = Receptor.CodigoUbigeo.Trim(),
                    schemeAgencyName = "PE:INEI",
                    schemeName = "Ubigeos"
                },
                AddressTypeCode = new AddressTypeCodeType
                {
                    Value = Receptor.CodigoDomicilioFiscal.Trim(),
                    listAgencyName = "PE:SUNAT",
                    listName = "Establecimientos anexos"
                },
                CitySubdivisionName = new CitySubdivisionNameType
                {
                    Value = Receptor.Urbanizacion.Trim()
                },
                CityName = new CityNameType
                {
                    Value = Receptor.Provincia.Trim()
                },
                CountrySubentity = new CountrySubentityType
                {
                    Value = Receptor.Departamento.Trim()
                },
                District = new DistrictType
                {
                    Value = Receptor.Distrito.Trim()
                },
                AddressLine = new AddressLineType[] {
                        new AddressLineType {
                            Line =new LineType{
                                Value =Receptor.Direccion.Trim()
                            }
                        }
                    },
                Country = new CountryType
                {
                    IdentificationCode = new IdentificationCodeType
                    {
                        listAgencyName = "United Nations Economic Commission for Europe",
                        listID = "ISO 3166-1",
                        listName = "Country",
                        Value = Receptor.CodigoPais.Trim()
                    }
                }

            }
        };

        ContactType oContacto = new ContactType
        {
            ElectronicMail = new ElectronicMailType()
            {
                Value = Receptor.Contacto.Correo.Trim()
            },
            Name = new NameType1
            {
                Value = Receptor.Contacto.Nombre.Trim()
            },
            Telephone = new TelephoneType
            {
                Value = Receptor.Contacto.Telefono.Trim()
            }
        };

        CustomerPartyType oReceptor = new CustomerPartyType
        {
            Party = new PartyType
            {
                WebsiteURI = EmisorPaginaWeb,
                PartyIdentification = EmisorListaIdentificacion.ToArray(),
                PartyName = oListaNombreComercial.ToArray(),
                PartyLegalEntity = new PartyLegalEntityType[] { oRazonSocial },
                Contact = oContacto

            }
        };

        invoice.AccountingCustomerParty = oReceptor;


    }
}
}
