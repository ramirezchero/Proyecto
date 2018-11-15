use master 
go
if exists(select * from sysdatabases where name='BD_eFacturacion') BEGIN
DROP DATABASE BD_eFacturacion
END
GO
CREATE DATABASE BD_eFacturacion
GO
USE  BD_eFacturacion

CREATE TABLE [dbo].[CatalogoErrorSunat](
	[IdCatalogo] [bigint] IDENTITY(1,1) NOT NULL,
	[codigoRespuesta] [varchar](50) NULL,
	[Descripcion] [varchar](1000) NULL,
	[Reintentar] [int] NULL,
 CONSTRAINT [PK_CatalogoErrorSunat] PRIMARY KEY CLUSTERED 
(
	[IdCatalogo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CDRSunatPendiente]    Script Date: 15/11/2018 06:57:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CDRSunatPendiente](
	[IdComprobante] [bigint] NOT NULL,
	[Archivo] [varbinary](max) NOT NULL,
	[FechaRegistro] [datetime] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CDRSunatProcesado]    Script Date: 15/11/2018 06:57:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CDRSunatProcesado](
	[IdArchivo] [bigint] IDENTITY(1,1) NOT NULL,
	[Archivo] [varbinary](max) NOT NULL,
	[FechaRegistro] [datetime] NOT NULL,
 CONSTRAINT [PK_CDRSunat] PRIMARY KEY CLUSTERED 
(
	[IdArchivo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Comprobante]    Script Date: 15/11/2018 06:57:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Comprobante](
	[IdComprobante] [bigint] IDENTITY(1,1) NOT NULL,
	[IdEmpresa] [int] NOT NULL,
	[TipoDocumentoIdentidad] [varchar](2) NOT NULL,
	[NroDocumentoIdentidad] [varchar](30) NOT NULL,
	[RazonSocial] [varchar](500) NOT NULL,
	[TipoComprobante] [varchar](2) NOT NULL,
	[SerieNumero] [varchar](13) NOT NULL,
	[FechaEmison] [varchar](10) NOT NULL,
	[CorreoElectronico] [varchar](500) NULL,
	[TotalImpuesto] [decimal](12, 2) NOT NULL,
	[TotalValorVenta] [decimal](12, 2) NOT NULL,
	[TotalPrecioVenta] [decimal](12, 2) NOT NULL,
	[TotalDescuento] [decimal](12, 2) NOT NULL,
	[TotalCargo] [decimal](12, 2) NOT NULL,
	[ImporteTotal] [decimal](12, 2) NOT NULL,
	[FechaVencimiento] [varchar](50) NOT NULL,
	[HoraEmision] [varchar](8) NOT NULL,
	[Moneda] [varchar](5) NOT NULL,
	[TipoOperacion] [varchar](4) NOT NULL,
	[FechaRegistro] [datetime] NOT NULL,
 CONSTRAINT [PK_Comprobante] PRIMARY KEY CLUSTERED 
(
	[IdComprobante] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ComprobanteDocumento]    Script Date: 15/11/2018 06:57:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ComprobanteDocumento](
	[IdComprobante] [bigint] NOT NULL,
	[NombreXML] [varchar](50) NOT NULL,
	[ArchivoXML] [varbinary](max) NOT NULL,
	[CodigoHash] [varchar](max) NOT NULL,
	[CodigoQR] [varchar](max) NOT NULL,
	[FechaRegistro] [datetime] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ComprobanteMontos]    Script Date: 15/11/2018 06:57:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ComprobanteMontos](
	[IdComprobante] [bigint] NOT NULL,
	[CodigoTributo] [varchar](4) NOT NULL,
	[MontoOperaciones] [decimal](12, 2) NOT NULL,
	[MontoTotalImpuesto] [decimal](12, 2) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ComprobanteReferenciaNota]    Script Date: 15/11/2018 06:57:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ComprobanteReferenciaNota](
	[IdComprobante] [bigint] NOT NULL,
	[SerieNumero] [varchar](30) NOT NULL,
	[TipoComprobante] [varchar](2) NOT NULL,
	[FechaEmision] [varchar](10) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ComprobanteRespuesta]    Script Date: 15/11/2018 06:57:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ComprobanteRespuesta](
	[IdComprobante] [bigint] NOT NULL,
	[IdCatalogo] [bigint] NOT NULL,
	[DescripcionSUNAT] [varchar](max) NOT NULL,
	[IdTipoRespuesta] [int] NOT NULL,
	[FechaRegistro] [datetime] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ComprobanteRespuestaHistorial]    Script Date: 15/11/2018 06:57:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ComprobanteRespuestaHistorial](
	[IdComprobante] [bigint] NOT NULL,
	[IdArchivo] [bigint] NOT NULL,
	[IdCatalogo] [bigint] NOT NULL,
	[Descripcion] [varchar](max) NOT NULL,
	[FechaRespuestaSunat] [datetime] NOT NULL,
	[FechaRegistro] [datetime] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ComprobanteSustentoNota]    Script Date: 15/11/2018 06:57:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ComprobanteSustentoNota](
	[IdComprobante] [bigint] NOT NULL,
	[SerieNumero] [varchar](30) NOT NULL,
	[CodigoAnulacion] [varchar](10) NOT NULL,
	[MotivoAnulacion] [varchar](500) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Empresa]    Script Date: 15/11/2018 06:57:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Empresa](
	[IdEmpresa] [int] IDENTITY(1,1) NOT NULL,
	[TipoDocumentoIdentidad] [varchar](2) NULL,
	[NumeroDocumentoIdentidad] [varchar](20) NULL,
	[RazonSocial] [varchar](1500) NOT NULL,
	[NombreComercial] [varchar](1500) NOT NULL,
	[Direccion] [varchar](200) NOT NULL,
	[Departamento] [varchar](30) NOT NULL,
	[Provincia] [varchar](30) NOT NULL,
	[Distrito] [varchar](30) NOT NULL,
	[Urbanizacion] [varchar](25) NULL,
	[CodigoUbigeo] [varchar](6) NOT NULL,
	[PaginaWeb] [varchar](200) NOT NULL,
	[CodigoDomicilioFiscal] [varchar](4) NULL,
	[CodigoPais] [varchar](2) NULL,
	[ContactoNombre] [varchar](100) NULL,
	[ContactoCorreo] [varchar](100) NULL,
	[ContactoTelefono] [varchar](100) NULL,
 CONSTRAINT [PK_Empresa] PRIMARY KEY CLUSTERED 
(
	[IdEmpresa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PendienteEnvio]    Script Date: 15/11/2018 06:57:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PendienteEnvio](
	[IdComprobante] [bigint] NOT NULL,
	[Estado] [int] NOT NULL,
	[Prioridad] [int] NOT NULL,
	[TipoDocumento] [varchar](2) NOT NULL,
	[FechaRegistro] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RepresentacionImpresa]    Script Date: 15/11/2018 06:57:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RepresentacionImpresa](
	[IdComprobante] [bigint] NOT NULL,
	[NombreRepresentacionImpresa] [varchar](50) NOT NULL,
	[Archivo] [varbinary](max) NOT NULL,
	[FechaRegistro] [datetime] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TipoRespuesta]    Script Date: 15/11/2018 06:57:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TipoRespuesta](
	[IdTipoRespuesta] [int] NOT NULL,
	[Codigo] [int] NOT NULL,
	[Descripcion] [varchar](50) NOT NULL,
 CONSTRAINT [PK_TipoRespuesta] PRIMARY KEY CLUSTERED 
(
	[IdTipoRespuesta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CDRSunatPendiente]  WITH CHECK ADD  CONSTRAINT [FK_CDRSunatPendiente_Comprobante] FOREIGN KEY([IdComprobante])
REFERENCES [dbo].[Comprobante] ([IdComprobante])
GO
ALTER TABLE [dbo].[CDRSunatPendiente] CHECK CONSTRAINT [FK_CDRSunatPendiente_Comprobante]
GO
ALTER TABLE [dbo].[Comprobante]  WITH CHECK ADD  CONSTRAINT [FK_Comprobante_Empresa] FOREIGN KEY([IdEmpresa])
REFERENCES [dbo].[Empresa] ([IdEmpresa])
GO
ALTER TABLE [dbo].[Comprobante] CHECK CONSTRAINT [FK_Comprobante_Empresa]
GO
ALTER TABLE [dbo].[ComprobanteDocumento]  WITH CHECK ADD  CONSTRAINT [FK_ComprobanteDocumento_Comprobante] FOREIGN KEY([IdComprobante])
REFERENCES [dbo].[Comprobante] ([IdComprobante])
GO
ALTER TABLE [dbo].[ComprobanteDocumento] CHECK CONSTRAINT [FK_ComprobanteDocumento_Comprobante]
GO
ALTER TABLE [dbo].[ComprobanteMontos]  WITH CHECK ADD  CONSTRAINT [FK_ComprobanteMontos_Comprobante] FOREIGN KEY([IdComprobante])
REFERENCES [dbo].[Comprobante] ([IdComprobante])
GO
ALTER TABLE [dbo].[ComprobanteMontos] CHECK CONSTRAINT [FK_ComprobanteMontos_Comprobante]
GO
ALTER TABLE [dbo].[ComprobanteReferenciaNota]  WITH CHECK ADD  CONSTRAINT [FK_ComprobanteReferenciaNota_Comprobante] FOREIGN KEY([IdComprobante])
REFERENCES [dbo].[Comprobante] ([IdComprobante])
GO
ALTER TABLE [dbo].[ComprobanteReferenciaNota] CHECK CONSTRAINT [FK_ComprobanteReferenciaNota_Comprobante]
GO
ALTER TABLE [dbo].[ComprobanteRespuesta]  WITH CHECK ADD  CONSTRAINT [FK_ComprobanteRespuesta_CatalogoErrorSunat] FOREIGN KEY([IdCatalogo])
REFERENCES [dbo].[CatalogoErrorSunat] ([IdCatalogo])
GO
ALTER TABLE [dbo].[ComprobanteRespuesta] CHECK CONSTRAINT [FK_ComprobanteRespuesta_CatalogoErrorSunat]
GO
ALTER TABLE [dbo].[ComprobanteRespuesta]  WITH CHECK ADD  CONSTRAINT [FK_ComprobanteRespuesta_Comprobante] FOREIGN KEY([IdComprobante])
REFERENCES [dbo].[Comprobante] ([IdComprobante])
GO
ALTER TABLE [dbo].[ComprobanteRespuesta] CHECK CONSTRAINT [FK_ComprobanteRespuesta_Comprobante]
GO
ALTER TABLE [dbo].[ComprobanteRespuesta]  WITH CHECK ADD  CONSTRAINT [FK_ComprobanteRespuesta_TipoRespuesta] FOREIGN KEY([IdTipoRespuesta])
REFERENCES [dbo].[TipoRespuesta] ([IdTipoRespuesta])
GO
ALTER TABLE [dbo].[ComprobanteRespuesta] CHECK CONSTRAINT [FK_ComprobanteRespuesta_TipoRespuesta]
GO
ALTER TABLE [dbo].[ComprobanteRespuestaHistorial]  WITH CHECK ADD  CONSTRAINT [FK_ComprobanteRespuestaHistorial_CatalogoErrorSunat] FOREIGN KEY([IdCatalogo])
REFERENCES [dbo].[CatalogoErrorSunat] ([IdCatalogo])
GO
ALTER TABLE [dbo].[ComprobanteRespuestaHistorial] CHECK CONSTRAINT [FK_ComprobanteRespuestaHistorial_CatalogoErrorSunat]
GO
ALTER TABLE [dbo].[ComprobanteRespuestaHistorial]  WITH CHECK ADD  CONSTRAINT [FK_ComprobanteRespuestaHistorial_CDRSunatProcesado] FOREIGN KEY([IdArchivo])
REFERENCES [dbo].[CDRSunatProcesado] ([IdArchivo])
GO
ALTER TABLE [dbo].[ComprobanteRespuestaHistorial] CHECK CONSTRAINT [FK_ComprobanteRespuestaHistorial_CDRSunatProcesado]
GO
ALTER TABLE [dbo].[ComprobanteRespuestaHistorial]  WITH CHECK ADD  CONSTRAINT [FK_ComprobanteRespuestaHistorial_Comprobante] FOREIGN KEY([IdComprobante])
REFERENCES [dbo].[Comprobante] ([IdComprobante])
GO
ALTER TABLE [dbo].[ComprobanteRespuestaHistorial] CHECK CONSTRAINT [FK_ComprobanteRespuestaHistorial_Comprobante]
GO
ALTER TABLE [dbo].[ComprobanteSustentoNota]  WITH CHECK ADD  CONSTRAINT [FK_ComprobanteSustentoNota_Comprobante] FOREIGN KEY([IdComprobante])
REFERENCES [dbo].[Comprobante] ([IdComprobante])
GO
ALTER TABLE [dbo].[ComprobanteSustentoNota] CHECK CONSTRAINT [FK_ComprobanteSustentoNota_Comprobante]
GO
ALTER TABLE [dbo].[PendienteEnvio]  WITH CHECK ADD  CONSTRAINT [FK_PendienteEnvio_Comprobante] FOREIGN KEY([IdComprobante])
REFERENCES [dbo].[Comprobante] ([IdComprobante])
GO
ALTER TABLE [dbo].[PendienteEnvio] CHECK CONSTRAINT [FK_PendienteEnvio_Comprobante]
GO
ALTER TABLE [dbo].[RepresentacionImpresa]  WITH CHECK ADD  CONSTRAINT [FK_RepresentacionImpresa_Comprobante] FOREIGN KEY([IdComprobante])
REFERENCES [dbo].[Comprobante] ([IdComprobante])
GO
ALTER TABLE [dbo].[RepresentacionImpresa] CHECK CONSTRAINT [FK_RepresentacionImpresa_Comprobante]
GO
