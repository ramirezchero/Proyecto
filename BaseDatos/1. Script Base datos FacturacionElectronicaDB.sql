CREATE DATABASE [FacturacionElectronicaDB]
GO

USE [FacturacionElectronicaDB]
GO
/****** Object:  UserDefinedTableType [dbo].[TypeComprobanteReferenciaNota]    Script Date: 9/02/2019 17:01:36 ******/
CREATE TYPE [dbo].[TypeComprobanteReferenciaNota] AS TABLE(
	[SerieNumero] [varchar](30) NOT NULL,
	[FechaEmision] [varchar](10) NOT NULL,
	[TipoComprobante] [varchar](2) NOT NULL
)
GO
/****** Object:  Table [dbo].[CatalogoErrorSunat]    Script Date: 9/02/2019 17:01:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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
/****** Object:  Table [dbo].[CDRSunatPendiente]    Script Date: 9/02/2019 17:01:36 ******/
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
/****** Object:  Table [dbo].[CDRSunatProcesado]    Script Date: 9/02/2019 17:01:36 ******/
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
/****** Object:  Table [dbo].[Comprobante]    Script Date: 9/02/2019 17:01:36 ******/
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
/****** Object:  Table [dbo].[ComprobanteDocumento]    Script Date: 9/02/2019 17:01:36 ******/
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
/****** Object:  Table [dbo].[ComprobanteMontos]    Script Date: 9/02/2019 17:01:36 ******/
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
/****** Object:  Table [dbo].[ComprobanteReferenciaNota]    Script Date: 9/02/2019 17:01:36 ******/
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
/****** Object:  Table [dbo].[ComprobanteRespuesta]    Script Date: 9/02/2019 17:01:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ComprobanteRespuesta](
	[IdComprobante] [bigint] NOT NULL,
	[IdCatalogo] [bigint] NOT NULL,
	[DescripcionSUNAT] [varchar](max) NOT NULL,
	[IdTipoRespuesta] [int] NOT NULL,
	[FechaRegistro] [datetime] NOT NULL,
	[FechaSUNAT] [varchar](20) NULL,
	[HoraSUNAT] [varchar](20) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ComprobanteRespuestaHistorial]    Script Date: 9/02/2019 17:01:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ComprobanteRespuestaHistorial](
	[IdComprobante] [bigint] NOT NULL,
	[IdArchivo] [bigint] NOT NULL,
	[IdCatalogo] [bigint] NOT NULL,
	[Descripcion] [varchar](max) NOT NULL,
	[FechaRegistro] [datetime] NOT NULL,
	[FechaRespuestaSunat] [varchar](20) NOT NULL,
	[HoraRespuestaSunat] [varchar](20) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ComprobanteSustentoNota]    Script Date: 9/02/2019 17:01:36 ******/
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
/****** Object:  Table [dbo].[Configuracion]    Script Date: 9/02/2019 17:01:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Configuracion](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Servicio] [varchar](50) NULL,
	[Codigo] [varchar](10) NULL,
	[Valor] [varchar](500) NULL,
 CONSTRAINT [PK_Configuracion] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Empresa]    Script Date: 9/02/2019 17:01:36 ******/
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
/****** Object:  Table [dbo].[Hoja1$]    Script Date: 9/02/2019 17:01:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Hoja1$](
	[Codigo] [nvarchar](255) NULL,
	[Mensaje] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PendienteEnvio]    Script Date: 9/02/2019 17:01:36 ******/
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
/****** Object:  Table [dbo].[RepresentacionImpresa]    Script Date: 9/02/2019 17:01:36 ******/
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
/****** Object:  Table [dbo].[TipoRespuesta]    Script Date: 9/02/2019 17:01:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TipoRespuesta](
	[IdTipoRespuesta] [int] IDENTITY(1,1) NOT NULL,
	[Codigo] [int] NOT NULL,
	[Descripcion] [varchar](50) NOT NULL,
 CONSTRAINT [PK_TipoRespuesta] PRIMARY KEY CLUSTERED 
(
	[IdTipoRespuesta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[CatalogoErrorSunat] ON 

INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1, N'0', N'Aceptado', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (2, N'0100', N'El sistema no puede responder su solicitud. Intente nuevamente o comuníquese con su Administrador', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (3, N'0101', N'El encabezado de seguridad es incorrecto', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (4, N'0102', N'Usuario o contraseña incorrectos', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (5, N'0103', N'El Usuario ingresado no existe', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (6, N'0104', N'La Clave ingresada es incorrecta', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (7, N'0105', N'El Usuario no está activo', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (8, N'0106', N'El Usuario no es válido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (9, N'0109', N'El sistema no puede responder su solicitud. (El servicio de autenticación no está disponible)', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (10, N'0110', N'No se pudo obtener la informacion del tipo de usuario', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (11, N'0111', N'No tiene el perfil para enviar comprobantes electronicos', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (12, N'0112', N'El usuario debe ser secundario', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (13, N'0113', N'El usuario no esta afiliado a Factura Electronica', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (14, N'0125', N'No se pudo obtener la constancia', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (15, N'0126', N'El ticket no le pertenece al usuario', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (16, N'0127', N'El ticket no existe', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (17, N'0130', N'El sistema no puede responder su solicitud. (No se pudo obtener el ticket de proceso)', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (18, N'0131', N'El sistema no puede responder su solicitud. (No se pudo grabar el archivo en el directorio)', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (19, N'0132', N'El sistema no puede responder su solicitud. (No se pudo grabar escribir en el archivo zip)', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (20, N'0133', N'El sistema no puede responder su solicitud. (No se pudo grabar la entrada del log)', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (21, N'0134', N'El sistema no puede responder su solicitud. (No se pudo grabar en el storage)', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (22, N'0135', N'El sistema no puede responder su solicitud. (No se pudo encolar el pedido)', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (23, N'0136', N'El sistema no puede responder su solicitud. (No se pudo recibir una respuesta del batch)', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (24, N'0137', N'El sistema no puede responder su solicitud. (Se obtuvo una respuesta nula)', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (25, N'0138', N'El sistema no puede responder su solicitud. (Error en Base de Datos)', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (26, N'0151', N'El nombre del archivo ZIP es incorrecto', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (27, N'0152', N'No se puede enviar por este método un archivo de resumen', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (28, N'0153', N'No se puede enviar por este método un archivo por lotes', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (29, N'0154', N'El RUC del archivo no corresponde al RUC del usuario o el proveedor no esta autorizado a enviar comprobantes del contribuyente', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (30, N'0155', N'El archivo ZIP esta vacio', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (31, N'0156', N'El archivo ZIP esta corrupto', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (32, N'0157', N'El archivo ZIP no contiene comprobantes', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (33, N'0158', N'El archivo ZIP contiene demasiados comprobantes para este tipo de envío', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (34, N'0159', N'El nombre del archivo XML es incorrecto', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (35, N'0160', N'El archivo XML esta vacio', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (36, N'0161', N'El nombre del archivo XML no coincide con el nombre del archivo ZIP', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (37, N'0200', N'No se pudo procesar su solicitud. (Ocurrio un error en el batch)', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (38, N'0201', N'No se pudo procesar su solicitud. (Llego un requerimiento nulo al batch)', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (39, N'0202', N'No se pudo procesar su solicitud. (No llego información del archivo ZIP)', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (40, N'0203', N'No se pudo procesar su solicitud. (No se encontro archivos en la informacion del archivo ZIP)', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (41, N'0204', N'No se pudo procesar su solicitud. (Este tipo de requerimiento solo acepta 1 archivo)', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (42, N'0250', N'No se pudo procesar su solicitud. (Ocurrio un error desconocido al hacer unzip)', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (43, N'0251', N'No se pudo procesar su solicitud. (No se pudo crear un directorio para el unzip)', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (44, N'0252', N'No se pudo procesar su solicitud. (No se encontro archivos dentro del zip)', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (45, N'0253', N'No se pudo procesar su solicitud. (No se pudo comprimir la constancia)', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (46, N'0300', N'No se encontró la raíz documento xml', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (47, N'0301', N'Elemento raiz del xml no esta definido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (48, N'0302', N'Codigo del tipo de comprobante no registrado', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (49, N'0303', N'No existe el directorio de schemas', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (50, N'0304', N'No existe el archivo de schema', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (51, N'0305', N'El sistema no puede procesar el archivo xml', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (52, N'0306', N'No se puede leer (parsear) el archivo XML', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (53, N'0307', N'No se pudo recuperar la constancia', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (54, N'0400', N'No tiene permiso para enviar casos de pruebas', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (55, N'0401', N'El caso de prueba no existe', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (56, N'0402', N'La numeracion o nombre del documento ya ha sido enviado anteriormente', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (57, N'0403', N'El documento afectado por la nota no existe', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (58, N'0404', N'El documento afectado por la nota se encuentra rechazado', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (59, N'1001', N'ID - El dato SERIE-CORRELATIVO no cumple con el formato de acuerdo al tipo de comprobante', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (60, N'1002', N'El XML no contiene informacion en el tag ID', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (61, N'1003', N'InvoiceTypeCode - El valor del tipo de documento es invalido o no coincide con el nombre del archivo', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (62, N'1004', N'El XML no contiene el tag o no existe informacion de InvoiceTypeCode', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (63, N'1005', N'CustomerAssignedAccountID -  El dato ingresado no cumple con el estandar', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (64, N'1006', N'El XML no contiene el tag o no existe informacion de CustomerAssignedAccountID del emisor del documento', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (65, N'1007', N'El dato ingresado no cumple con el estandar', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (66, N'1008', N'El XML no contiene el tag o no existe informacion en tipo de documento del emisor.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (67, N'1009', N'IssueDate - El dato ingresado  no cumple con el patron YYYY-MM-DD', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (68, N'1010', N'El XML no contiene el tag IssueDate', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (69, N'1011', N'IssueDate- El dato ingresado no es valido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (70, N'1012', N'ID - El dato ingresado no cumple con el patron SERIE-CORRELATIVO', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (71, N'1013', N'El XML no contiene informacion en el tag ID', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (72, N'1014', N'CustomerAssignedAccountID - El dato ingresado no cumple con el estandar', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (73, N'1015', N'El XML no contiene el tag o no existe informacion de CustomerAssignedAccountID del emisor del documento', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (74, N'1016', N'AdditionalAccountID - El dato ingresado no cumple con el estandar', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (75, N'1017', N'El XML no contiene el tag AdditionalAccountID del emisor del documento', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (76, N'1018', N'IssueDate - El dato ingresado no cumple con el patron YYYY-MM-DD', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (77, N'1019', N'El XML no contiene el tag IssueDate', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (78, N'1020', N'IssueDate- El dato ingresado no es valido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (79, N'1021', N'Error en la validacion de la nota de credito', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (80, N'1022', N'La serie o numero del documento modificado por la Nota Electrónica no cumple con el formato establecido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (81, N'1023', N'No se ha especificado el tipo de documento modificado por la Nota electronica', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (82, N'1024', N'CustomerAssignedAccountID - El dato ingresado no cumple con el estandar', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (83, N'1025', N'El XML no contiene el tag o no existe informacion de CustomerAssignedAccountID del emisor del documento', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (84, N'1026', N'AdditionalAccountID - El dato ingresado no cumple con el estandar', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (85, N'1027', N'El XML no contiene el tag AdditionalAccountID del emisor del documento', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (86, N'1028', N'IssueDate - El dato ingresado no cumple con el patron YYYY-MM-DD', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (87, N'1029', N'El XML no contiene el tag IssueDate', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (88, N'1030', N'IssueDate- El dato ingresado no es valido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (89, N'1031', N'Error en la validacion de la nota de debito', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (90, N'1032', N'El comprobante fue informado previamente en una comunicacion de baja', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (91, N'1033', N'El comprobante fue registrado previamente con otros datos', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (92, N'1034', N'Número de RUC del nombre del archivo no coincide con el consignado en el contenido del archivo XML', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (93, N'1035', N'Numero de Serie del nombre del archivo no coincide con el consignado en el contenido del archivo XML', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (94, N'1036', N'Número de documento en el nombre del archivo no coincide con el consignado en el contenido del XML', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (95, N'1037', N'El XML no contiene el tag o no existe informacion de RegistrationName del emisor del documento', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (96, N'1038', N'RegistrationName - El nombre o razon social del emisor no cumple con el estandar', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (97, N'1039', N'Solo se pueden recibir notas electronicas que modifican facturas', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (98, N'1040', N'El tipo de documento modificado por la nota electronica no es valido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (99, N'1041', N'cac:PrepaidPayment/cbc:ID - El tag no contiene el atributo @SchemaID. que indica el tipo de documento que realiza el anticipo', 0)
GO
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (100, N'1042', N'cac:PrepaidPayment/cbc:InstructionID – El tag no contiene el atributo @SchemaID. Que indica el tipo de documento del emisor del documento del anticipo.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (101, N'1043', N'cac:OriginatorDocumentReference/cbc:ID - El tag no contiene el atributo @SchemaID. Que indica el tipo de documento del originador del documento electrónico.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (102, N'1044', N'cac:PrepaidPayment/cbc:InstructionID – El dato ingresado no cumple con el estándar.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (103, N'1045', N'cac:OriginatorDocumentReference/cbc:ID – El dato ingresado no cumple con el estándar.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (104, N'1046', N'cbc:Amount - El dato ingresado no cumple con el estándar.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (105, N'1047', N'cbc:Quantity - El dato ingresado no cumple con el estándar.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (106, N'1048', N'El XML no contiene el tag o no existe información de PrepaidAmount para un documento con anticipo.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (107, N'1049', N'ID - Serie y Número del archivo no coincide con el consignado en el contenido del XML.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (108, N'1050', N'El XML no contiene informacion en el tag DespatchAdviceTypeCode.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (109, N'1051', N'DespatchAdviceTypeCode - El valor del tipo de guía es inválido.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (110, N'1052', N'DespatchAdviceTypeCode - No coincide con el consignado en el contenido del XML.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (111, N'1053', N'cac:OrderReference - El XML no contiene informacion en serie y numero dado de baja (cbc:ID).', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (112, N'1054', N'cac:OrderReference - El valor en numero de documento no cumple con un formato valido (SERIE-NUMERO).', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (113, N'1055', N'cac:OrderReference - Numero de serie del documento no cumple con un formato valido (EG01 ó TXXX).', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (114, N'1056', N'cac:OrderReference - El XML no contiene informacion en el código de tipo de documento (cbc:OrderTypeCode).', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (115, N'1057', N'cac:AdditionalDocumentReference - El XML no contiene el tag o no existe información en el numero de documento adicional (cbc:ID).', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (116, N'1058', N'cac:AdditionalDocumentReference - El XML no contiene el tag o no existe información en el tipo de documento adicional (cbc:DocumentTypeCode).', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (117, N'1059', N'El XML no contiene firma digital.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (118, N'1060', N'cac:Shipment - El XML no contiene el tag o no existe informacion del numero de RUC del Remitente (cac:).', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (119, N'1061', N'El numero de RUC del Remitente no existe.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (120, N'1062', N'El XML no contiene el atributo o no existe informacion del motivo de traslado.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (121, N'1063', N'El valor ingresado como motivo de traslado no es valido.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (122, N'1064', N'El XML no contiene el atributo o no existe informacion en el tag cac:DespatchLine de bienes a transportar.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (123, N'1065', N'El XML no contiene el atributo o no existe informacion en modalidad de transporte.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (124, N'1066', N'El XML no contiene el atributo o no existe informacion de datos del transportista.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (125, N'1067', N'El XML no contiene el atributo o no existe información de vehiculos.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (126, N'1068', N'El XML no contiene el atributo o no existe información de conductores.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (127, N'1069', N'El XML no contiene el atributo o no existe información de la fecha de inicio de traslado o fecha de entrega del bien al transportista.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (128, N'1070', N'El valor ingresado  como fecha de inicio o fecha de entrega al transportista no cumple con el estandar (YYYY-MM-DD).', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (129, N'1071', N'El valor ingresado  como fecha de inicio o fecha de entrega al transportista no es valido.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (130, N'1072', N'Starttime - El dato ingresado  no cumple con el patron HH:mm:ss.SZ.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (131, N'1073', N'StartTime - El dato ingresado no es valido.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (132, N'1074', N'cac:Shipment - El XML no contiene o no existe información en punto de llegada (cac:DeliveryAddress).', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (133, N'1075', N'cac:Shipment - El XML no contiene o no existe información en punto de partida (cac:OriginAddress).', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (134, N'1076', N'El XML no contiene el atributo o no existe información de sustento de traslado de mercaderias para el tipo de operación.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (135, N'1077', N'El XML contiene el tag de sustento de traslado de mercaderias que no corresponde al tipo de operación.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (136, N'2104', N'El Numero de RUC del emisor no existe', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (137, N'2010', N'El contribuyente no esta activo', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (138, N'2011', N'El contribuyente no esta habido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (139, N'2012', N'El contribuyente no está autorizado a emitir comprobantes electrónicos', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (140, N'2013', N'El contribuyente no cumple con tipo de empresa o tributos requeridos', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (141, N'2014', N'El XML no contiene el tag o no existe informacion de CustomerAssignedAccountID del receptor del documento', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (142, N'2015', N'El XML no contiene el tag o no existe informacion de AdditionalAccountID del receptor del documento', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (143, N'2016', N'El dato ingresado  en el tipo de documento de identidad del receptor no cumple con el estandar o no esta permitido.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (144, N'2017', N'El numero de documento de identidad del receptor debe ser  RUC', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (145, N'2018', N'El dato ingresado no cumple con el estandar', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (146, N'2019', N'El XML no contiene el tag o no existe informacion de nombre o razon social del emisor del documento', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (147, N'2020', N'El nombre o razon social del emisor no cumple con el estandar', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (148, N'2021', N'El XML no contiene el tag o no existe informacion de RegistrationName del receptor del documento', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (149, N'2022', N'RegistrationName -  El dato ingresado no cumple con el estandar', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (150, N'2023', N'El Numero de orden del item no cumple con el formato establecido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (151, N'2024', N'El XML no contiene el tag InvoicedQuantity en el detalle de los Items o es cero (0)', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (152, N'2025', N'InvoicedQuantity El dato ingresado no cumple con el estandar', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (153, N'2026', N'El XML no contiene el tag cac:Item/cbc:Description en el detalle de los Items', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (154, N'2027', N'El XML no contiene el tag o no existe informacion de cac:Item/cbc:Description del item', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (155, N'2028', N'Debe existir el tag cac:AlternativeConditionPrice', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (156, N'2029', N'PriceTypeCode El dato ingresado no cumple con el estandar', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (157, N'2030', N'El XML no contiene el tag cbc:PriceTypeCode', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (158, N'2031', N'El dato ingresado en total valor de venta no cumple con el estandar', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (159, N'2032', N'El XML no contiene el tag LineExtensionAmount en el detalle de los Items', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (160, N'2033', N'El dato ingresado en TaxAmount de la linea no cumple con el formato establecido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (161, N'2034', N'TaxAmount es obligatorio', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (162, N'2035', N'cac:TaxCategory/cac:TaxScheme/cbc:ID El dato ingresado no cumple con el estandar', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (163, N'2036', N'El codigo del tributo es invalido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (164, N'2037', N'El XML no contiene el tag cac:TaxCategory/cac:TaxScheme/cbc:ID del Item', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (165, N'2038', N'cac:TaxScheme/cbc:Name del item - No existe el tag o el dato ingresado no cumple con el estandar', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (166, N'2039', N'El XML no contiene el tag cac:TaxCategory/cac:TaxScheme/cbc:Name del Item', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (167, N'2040', N'El tipo de afectacion del IGV es incorrecto', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (168, N'2041', N'El sistema de calculo del ISC es incorrecto', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (169, N'2042', N'Debe indicar el IGV. Es un campo obligatorio', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (170, N'2043', N'El dato ingresado en PayableAmount no cumple con el formato establecido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (171, N'2044', N'PayableAmount es obligatorio', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (172, N'2045', N'El valor ingresado en AdditionalMonetaryTotal/cbc:ID es incorrecto', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (173, N'2046', N'AdditionalMonetaryTotal/cbc:ID debe tener valor', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (174, N'2047', N'Es obligatorio al menos un AdditionalMonetaryTotal con codigo 1001, 1002, 1003 o 3001', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (175, N'2048', N'El dato ingresado en TaxAmount no cumple con el formato establecido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (176, N'2049', N'TaxAmount es obligatorio', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (177, N'2050', N'TaxScheme ID - No existe el tag o el dato ingresado no cumple con el estandar', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (178, N'2051', N'El codigo del tributo es invalido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (179, N'2052', N'El XML no contiene el tag código de tributo internacional de impuestos globales', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (180, N'2053', N'TaxScheme Name - No existe el tag o el dato ingresado no cumple con el estandar', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (181, N'2054', N'El XML no contiene el tag TaxScheme Name de impuestos globales', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (182, N'2055', N'TaxScheme TaxTypeCode - El dato ingresado no cumple con el estandar', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (183, N'2056', N'El XML no contiene el tag TaxScheme TaxTypeCode de impuestos globales', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (184, N'2057', N'El Name o TaxTypeCode debe corresponder con el Id para el IGV', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (185, N'2058', N'El Name o TaxTypeCode debe corresponder con el Id para el ISC', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (186, N'2059', N'El dato ingresado en TaxSubtotal/cbc:TaxAmount no cumple con el formato establecido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (187, N'2060', N'TaxSubtotal/cbc:TaxAmount es obligatorio', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (188, N'2061', N'El tag global cac:TaxTotal/cbc:TaxAmount debe tener el mismo valor que cac:TaxTotal/cac:Subtotal/cbc:TaxAmount', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (189, N'2062', N'El dato ingresado en PayableAmount no cumple con el formato establecido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (190, N'2063', N'El XML no contiene el tag PayableAmount', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (191, N'2064', N'El dato ingresado en ChargeTotalAmount no cumple con el formato establecido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (192, N'2065', N'El dato ingresado en el campo Total Descuentos no cumple con el formato establecido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (193, N'2066', N'Debe indicar una descripcion para el tag sac:AdditionalProperty/cbc:Value', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (194, N'2067', N'cac:Price/cbc:PriceAmount - El dato ingresado no cumple con el estandar', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (195, N'2068', N'El XML no contiene el tag cac:Price/cbc:PriceAmount en el detalle de los Items', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (196, N'2069', N'DocumentCurrencyCode - El dato ingresado no cumple con la estructura', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (197, N'2070', N'El XML no contiene el tag o no existe informacion de DocumentCurrencyCode', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (198, N'2071', N'La moneda debe ser la misma en todo el documento. Salvo las percepciones que sólo son en moneda nacional.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (199, N'2072', N'CustomizationID - La versión del documento no es la correcta', 0)
GO
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (200, N'2073', N'El XML no existe informacion de CustomizationID', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (201, N'2074', N'UBLVersionID - La versión del UBL no es correcta', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (202, N'2075', N'El XML no contiene el tag o no existe informacion de UBLVersionID', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (203, N'2076', N'cac:Signature/cbc:ID - Falta el identificador de la firma', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (204, N'2077', N'El tag cac:Signature/cbc:ID debe contener informacion', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (205, N'2078', N'cac:Signature/cac:SignatoryParty/cac:PartyIdentification/cbc:ID - Debe ser igual al RUC del emisor', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (206, N'2079', N'El XML no contiene el tag cac:Signature/cac:SignatoryParty/cac:PartyIdentification/cbc:ID', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (207, N'2080', N'cac:Signature/cac:SignatoryParty/cac:PartyName/cbc:Name - No cumple con el estandar', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (208, N'2081', N'El XML no contiene el tag cac:Signature/cac:SignatoryParty/cac:PartyName/cbc:Name', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (209, N'2082', N'cac:Signature/cac:DigitalSignatureAttachment/cac:ExternalReference/cbc:URI - No cumple con el estandar', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (210, N'2083', N'El XML no contiene el tag cac:Signature/cac:DigitalSignatureAttachment/cac:ExternalReference/cbc:URI', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (211, N'2084', N'ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/ds:Signature/@Id - No cumple con el estandar', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (212, N'2085', N'El XML no contiene el tag ext:UBLExtensions/ext:UBLExtension/ext:ExtensionContent/ds:Signature/@Id', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (213, N'2086', N'ext:UBLExtensions/.../ds:Signature/ds:SignedInfo/ds:CanonicalizationMethod/@Algorithm - No cumple con el estandar', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (214, N'2087', N'El XML no contiene el tag ext:UBLExtensions/.../ds:Signature/ds:SignedInfo/ds:CanonicalizationMethod/@Algorithm', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (215, N'2088', N'ext:UBLExtensions/.../ds:Signature/ds:SignedInfo/ds:SignatureMethod/@Algorithm - No cumple con el estandar', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (216, N'2089', N'El XML no contiene el tag ext:UBLExtensions/.../ds:Signature/ds:SignedInfo/ds:SignatureMethod/@Algorithm', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (217, N'2090', N'ext:UBLExtensions/.../ds:Signature/ds:SignedInfo/ds:Reference/@URI - Debe estar vacio para id', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (218, N'2091', N'El XML no contiene el tag ext:UBLExtensions/.../ds:Signature/ds:SignedInfo/ds:Reference/@URI', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (219, N'2092', N'ext:UBLExtensions/.../ds:Signature/ds:SignedInfo/.../ds:Transform@Algorithm - No cumple con el estandar', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (220, N'2093', N'El XML no contiene el tag ext:UBLExtensions/.../ds:Signature/ds:SignedInfo/ds:Reference/ds:Transform@Algorithm', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (221, N'2094', N'ext:UBLExtensions/.../ds:Signature/ds:SignedInfo/ds:Reference/ds:DigestMethod/@Algorithm - No cumple con el estandar', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (222, N'2095', N'El XML no contiene el tag ext:UBLExtensions/.../ds:Signature/ds:SignedInfo/ds:Reference/ds:DigestMethod/@Algorithm', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (223, N'2096', N'ext:UBLExtensions/.../ds:Signature/ds:SignedInfo/ds:Reference/ds:DigestValue - No  cumple con el estandar', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (224, N'2097', N'El XML no contiene el tag ext:UBLExtensions/.../ds:Signature/ds:SignedInfo/ds:Reference/ds:DigestValue', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (225, N'2098', N'ext:UBLExtensions/.../ds:Signature/ds:SignatureValue - No cumple con el estandar', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (226, N'2099', N'El XML no contiene el tag ext:UBLExtensions/.../ds:Signature/ds:SignatureValue', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (227, N'2100', N'ext:UBLExtensions/.../ds:Signature/ds:KeyInfo/ds:X509Data/ds:X509Certificate - No cumple con el estandar', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (228, N'2101', N'El XML no contiene el tag ext:UBLExtensions/.../ds:Signature/ds:KeyInfo/ds:X509Data/ds:X509Certificate', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (229, N'2102', N'Error al procesar la factura', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (230, N'2103', N'La serie ingresada no es válida', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (231, N'2104', N'Numero de RUC del emisor no existe', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (232, N'2105', N'Factura a dar de baja no se encuentra registrada en SUNAT', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (233, N'2106', N'Factura a dar de baja ya se encuentra en estado de baja', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (234, N'2107', N'Numero de RUC SOL no coincide con RUC emisor', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (235, N'2108', N'Presentacion fuera de fecha', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (236, N'2109', N'El comprobante fue registrado previamente con otros datos', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (237, N'2110', N'UBLVersionID - La versión del UBL no es correcta', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (238, N'2111', N'El XML no contiene el tag o no existe informacion de UBLVersionID', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (239, N'2112', N'CustomizationID - La version del documento no es correcta', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (240, N'2113', N'El XML no contiene el tag o no existe informacion de CustomizationID', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (241, N'2114', N'DocumentCurrencyCode -  El dato ingresado no cumple con la estructura', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (242, N'2115', N'El XML no contiene el tag o no existe informacion de DocumentCurrencyCode', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (243, N'2116', N'El tipo de documento modificado por la Nota de credito debe ser factura electronica o ticket', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (244, N'2117', N'La serie o numero del documento modificado por la Nota de Credito no cumple con el formato establecido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (245, N'2118', N'Debe indicar las facturas relacionadas a la Nota de Credito', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (246, N'2119', N'El documento modificado en la Nota de credito no esta registrada.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (247, N'2120', N'El documento modificado en la Nota de credito se encuentra de baja', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (248, N'2121', N'El documento modificado en la Nota de credito esta registrada como rechazada', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (249, N'2122', N'El tag cac:LegalMonetaryTotal/cbc:PayableAmount debe tener informacion valida', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (250, N'2123', N'RegistrationName -  El dato ingresado no cumple con el estandar', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (251, N'2124', N'El XML no contiene el tag RegistrationName del emisor del documento', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (252, N'2125', N'ReferenceID -  El dato ingresado debe indicar SERIE-CORRELATIVO del documento al que se relaciona la Nota', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (253, N'2126', N'El XML no contiene informacion en el tag ReferenceID del documento al que se relaciona la nota', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (254, N'2127', N'ResponseCode -  El dato ingresado no cumple  con  la  estructura', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (255, N'2128', N'El XML no contiene el tag o no existe informacion de ResponseCode', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (256, N'2129', N'AdditionalAccountID -  El dato ingresado  en el tipo de documento de identidad del receptor no cumple con el estandar', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (257, N'2130', N'El XML no contiene el tag o no existe informacion de AdditionalAccountID del receptor del documento', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (258, N'2131', N'CustomerAssignedAccountID - El numero de documento de identidad del receptor debe ser RUC', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (259, N'2132', N'El XML no contiene el tag o no existe informacion de CustomerAssignedAccountID del receptor del documento', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (260, N'2133', N'RegistrationName -  El dato ingresado no cumple con el estandar', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (261, N'2134', N'El XML no contiene el tag o no existe informacion de RegistrationName del receptor del documento', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (262, N'2135', N'cac:DiscrepancyResponse/cbc:Description - El dato ingresado no cumple con la estructura', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (263, N'2136', N'El XML no contiene el tag o no existe informacion de cac:DiscrepancyResponse/cbc:Description', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (264, N'2137', N'El Numero de orden del item no cumple con el formato establecido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (265, N'2138', N'CreditedQuantity/@unitCode - El dato ingresado no cumple con el estandar', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (266, N'2139', N'CreditedQuantity - El dato ingresado no cumple con el estandar', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (267, N'2140', N'El PriceTypeCode debe tener el valor 01', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (268, N'2141', N'cac:TaxCategory/cac:TaxScheme/cbc:ID - El dato ingresado no cumple con el estandar', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (269, N'2142', N'El codigo del tributo es invalido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (270, N'2143', N'cac:TaxScheme/cbc:Name del item - No existe el tag o el dato ingresado no cumple con el estandar', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (271, N'2144', N'cac:TaxCategory/cac:TaxScheme/cbc:TaxTypeCode El dato ingresado no cumple con el estandar', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (272, N'2145', N'El tipo de afectacion del IGV es incorrecto', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (273, N'2146', N'El Nombre Internacional debe ser VAT', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (274, N'2147', N'El sistema de calculo del ISC es incorrecto', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (275, N'2148', N'El Nombre Internacional debe ser EXC', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (276, N'2149', N'El dato ingresado en PayableAmount no cumple con el formato establecido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (277, N'2150', N'El valor ingresado en AdditionalMonetaryTotal/cbc:ID es incorrecto', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (278, N'2151', N'AdditionalMonetaryTotal/cbc:ID debe tener valor', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (279, N'2152', N'Es obligatorio al menos un AdditionalInformation', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (280, N'2153', N'Error al procesar la Nota de Credito', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (281, N'2154', N'TaxAmount - El dato ingresado en impuestos globales no cumple con el estandar', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (282, N'2155', N'El XML no contiene el tag TaxAmount de impuestos globales', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (283, N'2156', N'TaxScheme ID - El dato ingresado no cumple con el estandar', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (284, N'2157', N'El codigo del tributo es invalido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (285, N'2158', N'El XML no contiene el tag o no existe informacion de TaxScheme ID de impuestos globales', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (286, N'2159', N'TaxScheme Name - El dato ingresado no cumple con el estandar', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (287, N'2160', N'El XML no contiene el tag o no existe informacion de TaxScheme Name de impuestos globales', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (288, N'2161', N'CustomizationID - La version del documento no es correcta', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (289, N'2162', N'El XML no contiene el tag o no existe informacion de CustomizationID', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (290, N'2163', N'UBLVersionID - La versión del UBL no es correcta', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (291, N'2164', N'El XML no contiene el tag o no existe informacion de UBLVersionID', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (292, N'2165', N'Error al procesar la Nota de Debito', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (293, N'2166', N'RegistrationName - El dato ingresado no cumple con el estandar', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (294, N'2167', N'El XML no contiene el tag RegistrationName del emisor del documento', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (295, N'2168', N'DocumentCurrencyCode -  El dato ingresado no cumple con el formato establecido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (296, N'2169', N'El XML no contiene el tag o no existe informacion de DocumentCurrencyCode', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (297, N'2170', N'ReferenceID - El dato ingresado debe indicar SERIE-CORRELATIVO del documento al que se relaciona la Nota', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (298, N'2171', N'El XML no contiene informacion en el tag ReferenceID del documento al que se relaciona la nota', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (299, N'2172', N'ResponseCode - El dato ingresado no cumple con la estructura', 0)
GO
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (300, N'2173', N'El XML no contiene el tag o no existe informacion de ResponseCode', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (301, N'2174', N'cac:DiscrepancyResponse/cbc:Description - El dato ingresado no cumple con la estructura', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (302, N'2175', N'El XML no contiene el tag o no existe informacion de cac:DiscrepancyResponse/cbc:Description', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (303, N'2176', N'AdditionalAccountID -  El dato ingresado  en el tipo de documento de identidad del receptor no cumple con el estandar', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (304, N'2177', N'El XML no contiene el tag o no existe informacion de AdditionalAccountID del receptor del documento', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (305, N'2178', N'CustomerAssignedAccountID - El numero de documento de identidad del receptor debe ser RUC.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (306, N'2179', N'El XML no contiene el tag o no existe informacion de CustomerAssignedAccountID del receptor del documento', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (307, N'2180', N'RegistrationName - El dato ingresado no cumple con el estandar', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (308, N'2181', N'El XML no contiene el tag o no existe informacion de RegistrationName del receptor del documento', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (309, N'2182', N'TaxScheme ID - El dato ingresado no cumple con el estandar', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (310, N'2183', N'El codigo del tributo es invalido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (311, N'2184', N'El XML no contiene el tag o no existe informacion de TaxScheme ID de impuestos globales', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (312, N'2185', N'TaxScheme Name - El dato ingresado no cumple con el estandar', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (313, N'2186', N'El XML no contiene el tag o no existe informacion de TaxScheme Name de impuestos globales', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (314, N'2187', N'El Numero de orden del item no cumple con el formato establecido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (315, N'2188', N'DebitedQuantity/@unitCode El dato ingresado no cumple con el estandar', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (316, N'2189', N'DebitedQuantity El dato ingresado no cumple con el estandar', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (317, N'2190', N'El XML no contiene el tag Price/cbc:PriceAmount en el detalle de los Items', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (318, N'2191', N'El XML no contiene el tag Price/cbc:LineExtensionAmount en el detalle de los Items', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (319, N'2192', N'EL PriceTypeCode debe tener el valor 01', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (320, N'2193', N'cac:TaxCategory/cac:TaxScheme/cbc:ID El dato ingresado no cumple con el estandar', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (321, N'2194', N'El codigo del tributo es invalido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (322, N'2195', N'cac:TaxScheme/cbc:Name del item - No existe el tag o el dato ingresado no cumple con el estandar', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (323, N'2196', N'cac:TaxCategory/cac:TaxScheme/cbc:TaxTypeCode El dato ingresado no cumple con el estandar', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (324, N'2197', N'El tipo de afectacion del IGV es incorrecto', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (325, N'2198', N'El Nombre Internacional debe ser VAT', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (326, N'2199', N'El sistema de calculo del ISC es incorrecto', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (327, N'2200', N'El Nombre Internacional debe ser EXC', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (328, N'2201', N'El tag cac:RequestedMonetaryTotal/cbc:PayableAmount debe tener informacion valida', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (329, N'2202', N'TaxAmount - El dato ingresado en impuestos globales no cumple con el estandar', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (330, N'2203', N'El XML no contiene el tag TaxAmount de impuestos globales', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (331, N'2204', N'El tipo de documento modificado por la Nota de Debito debe ser factura electronica o ticket', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (332, N'2205', N'La serie o numero del documento modificado por la Nota de Debito no cumple con el formato establecido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (333, N'2206', N'Debe indicar los documentos afectados por la Nota de Debito', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (334, N'2207', N'El documento modificado en la Nota de debito se encuentra de baja', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (335, N'2208', N'El documento modificado en la Nota de debito esta registrada como rechazada', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (336, N'2209', N'El documento modificado en la Nota de debito no esta registrada', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (337, N'2210', N'El dato ingresado no cumple con el formato RC-fecha-correlativo', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (338, N'2211', N'El XML no contiene el tag ID', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (339, N'2212', N'UBLVersionID - La versión del UBL del resumen de boletas no es correcta', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (340, N'2213', N'El XML no contiene el tag UBLVersionID', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (341, N'2214', N'CustomizationID - La versión del resumen de boletas no es correcta', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (342, N'2215', N'El XML no contiene el tag CustomizationID', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (343, N'2216', N'CustomerAssignedAccountID -  El dato ingresado no cumple con el estandar', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (344, N'2217', N'El XML no contiene el tag CustomerAssignedAccountID del emisor del documento', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (345, N'2218', N'AdditionalAccountID - El dato ingresado no cumple con el estandar', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (346, N'2219', N'El XML no contiene el tag AdditionalAccountID del emisor del documento', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (347, N'2220', N'El ID debe coincidir con el nombre del archivo', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (348, N'2221', N'El RUC debe coincidir con el RUC del nombre del archivo', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (349, N'2222', N'El contribuyente no está autorizado a emitir comprobantes electronicos', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (350, N'2223', N'El archivo ya fue presentado anteriormente', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (351, N'2224', N'Numero de RUC SOL no coincide con RUC emisor', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (352, N'2225', N'Numero de RUC del emisor no existe', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (353, N'2226', N'El contribuyente no esta activo', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (354, N'2227', N'El contribuyente no cumple con tipo de empresa o tributos requeridos', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (355, N'2228', N'RegistrationName - El dato ingresado no cumple con el estandar', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (356, N'2229', N'El XML no contiene el tag RegistrationName del emisor del documento', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (357, N'2230', N'IssueDate - El dato ingresado no cumple con el patron YYYY-MM-DD', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (358, N'2231', N'El XML no contiene el tag IssueDate', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (359, N'2232', N'IssueDate- El dato ingresado no es valido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (360, N'2233', N'ReferenceDate - El dato ingresado no cumple con el patron YYYY-MM-DD', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (361, N'2234', N'El XML no contiene el tag ReferenceDate', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (362, N'2235', N'ReferenceDate- El dato ingresado no es valido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (363, N'2236', N'La fecha del IssueDate no debe ser mayor al Today', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (364, N'2237', N'La fecha del ReferenceDate no debe ser mayor al Today', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (365, N'2238', N'LineID - El dato ingresado no cumple con el estandar', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (366, N'2239', N'LineID - El dato ingresado debe ser correlativo mayor a cero', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (367, N'2240', N'El XML no contiene el tag LineID de SummaryDocumentsLine', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (368, N'2241', N'DocumentTypeCode - El valor del tipo de documento es invalido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (369, N'2242', N'El XML no contiene el tag DocumentTypeCode', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (370, N'2243', N'El dato ingresado  no cumple con el patron SERIE', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (371, N'2244', N'El XML no contiene el tag DocumentSerialID', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (372, N'2245', N'El dato ingresado en StartDocumentNumberID debe ser numerico', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (373, N'2246', N'El XML no contiene el tag StartDocumentNumberID', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (374, N'2247', N'El dato ingresado en sac:EndDocumentNumberID debe ser numerico', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (375, N'2248', N'El XML no contiene el tag sac:EndDocumentNumberID', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (376, N'2249', N'Los rangos deben ser mayores a cero', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (377, N'2250', N'En el rango de comprobantes, el EndDocumentNumberID debe ser mayor o igual al StartInvoiceNumberID', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (378, N'2251', N'El dato ingresado en TotalAmount debe ser numerico mayor o igual a cero', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (379, N'2252', N'El XML no contiene el tag TotalAmount', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (380, N'2253', N'El dato ingresado en TotalAmount debe ser numerico mayor a cero', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (381, N'2254', N'PaidAmount - El dato ingresado no cumple con el estandar', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (382, N'2255', N'El XML no contiene el tag PaidAmount', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (383, N'2256', N'InstructionID - El dato ingresado no cumple con el estandar', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (384, N'2257', N'El XML no contiene el tag InstructionID', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (385, N'2258', N'Debe indicar Referencia de Importes asociados a las boletas de venta', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (386, N'2259', N'Debe indicar 3 Referencias de Importes asociados a las boletas de venta', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (387, N'2260', N'PaidAmount - El dato ingresado debe ser mayor o igual a 0.00', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (388, N'2261', N'cbc:Amount - El dato ingresado no cumple con el estandar', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (389, N'2262', N'El XML no contiene el tag cbc:Amount', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (390, N'2263', N'ChargeIndicator - El dato ingresado no cumple con el estandar', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (391, N'2264', N'El XML no contiene el tag ChargeIndicator', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (392, N'2265', N'Debe indicar Información acerca del Importe Total de Otros Cargos', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (393, N'2266', N'Debe indicar cargos mayores o iguales a cero', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (394, N'2267', N'TaxScheme ID - El dato ingresado no cumple con el estandar', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (395, N'2268', N'El codigo del tributo es invalido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (396, N'2269', N'El XML no contiene el tag TaxScheme ID de Información acerca del importe total de un tipo particular de impuesto', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (397, N'2270', N'TaxScheme Name - El dato ingresado no cumple con el estandar', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (398, N'2271', N'El XML no contiene el tag TaxScheme Name de impuesto', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (399, N'2272', N'TaxScheme TaxTypeCode - El dato ingresado no cumple con el estandar', 0)
GO
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (400, N'2273', N'TaxAmount - El dato ingresado no cumple con el estandar', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (401, N'2274', N'El XML no contiene el tag TaxAmount', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (402, N'2275', N'Si el codigo de tributo es 2000, el nombre del tributo debe ser ISC', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (403, N'2276', N'Si el codigo de tributo es 1000, el nombre del tributo debe ser IGV', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (404, N'2277', N'No se ha consignado ninguna informacion del importe total de tributos', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (405, N'2278', N'Debe indicar Información acerca del importe total de IGV', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (406, N'2279', N'Debe indicar Items de consolidado de documentos', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (407, N'2280', N'Existen problemas con la informacion del resumen de comprobantes', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (408, N'2281', N'Error en la validacion de los rangos de los comprobantes', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (409, N'2282', N'Existe documento ya informado anteriormente', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (410, N'2283', N'El dato ingresado no cumple con el formato RA-fecha-correlativo', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (411, N'2284', N'El tag ID esta vacío', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (412, N'2285', N'El ID debe coincidir  con el nombre del archivo', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (413, N'2286', N'El RUC debe coincidir con el RUC del nombre del archivo', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (414, N'2287', N'AdditionalAccountID - El dato ingresado no cumple con el estandar', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (415, N'2288', N'El XML no contiene el tag AdditionalAccountID del emisor del documento', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (416, N'2289', N'CustomerAssignedAccountID - El dato ingresado no cumple con el estandar', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (417, N'2290', N'El XML no contiene el tag CustomerAssignedAccountID del emisor del documento', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (418, N'2291', N'El contribuyente no esta autorizado a emitir comprobantes electronicos', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (419, N'2292', N'Numero de RUC SOL no coincide con RUC emisor', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (420, N'2293', N'Numero de RUC del emisor no existe', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (421, N'2294', N'El contribuyente no esta activo', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (422, N'2295', N'El contribuyente no cumple con tipo de empresa o tributos requeridos', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (423, N'2296', N'RegistrationName - El dato ingresado no cumple con el estandar', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (424, N'2297', N'El XML no contiene el tag RegistrationName del emisor del documento', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (425, N'2298', N'IssueDate - El dato ingresado no cumple con el patron YYYY-MM-DD', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (426, N'2299', N'El XML no contiene el tag IssueDate', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (427, N'2300', N'IssueDate - El dato ingresado no es valido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (428, N'2301', N'La fecha del IssueDate no debe ser mayor al Today', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (429, N'2302', N'ReferenceDate - El dato ingresado no cumple con el patron YYYY-MM-DD', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (430, N'2303', N'El XML no contiene el tag ReferenceDate', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (431, N'2304', N'ReferenceDate - El dato ingresado no es valido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (432, N'2305', N'LineID - El dato ingresado no cumple con el estandar', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (433, N'2306', N'LineID - El dato ingresado debe ser correlativo mayor a cero', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (434, N'2307', N'El tag LineID de VoidedDocumentsLine esta vacío', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (435, N'2308', N'DocumentTypeCode - El valor del tipo de documento es invalido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (436, N'2309', N'El tag DocumentTypeCode es vacío', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (437, N'2310', N'El dato ingresado  no cumple con el patron SERIE', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (438, N'2311', N'El tag DocumentSerialID es vacío', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (439, N'2312', N'El dato ingresado en DocumentNumberID debe ser numerico y como maximo de 8 digitos', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (440, N'2313', N'El tag DocumentNumberID esta vacío', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (441, N'2314', N'El dato ingresado en VoidReasonDescription debe contener información válida', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (442, N'2315', N'El tag VoidReasonDescription esta vacío', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (443, N'2316', N'Debe indicar Items en VoidedDocumentsLine', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (444, N'2317', N'Error al procesar el resumen de anulados', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (445, N'2318', N'CustomizationID - La version del documento no es correcta', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (446, N'2319', N'El XML no contiene el tag CustomizationID', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (447, N'2320', N'UBLVersionID - La version del UBL  no es la correcta', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (448, N'2321', N'El XML no contiene el tag UBLVersionID', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (449, N'2322', N'Error en la validacion de los rangos', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (450, N'2323', N'Existe documento ya informado anteriormente en una comunicacion de baja', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (451, N'2324', N'El archivo de comunicacion de baja ya fue presentado anteriormente', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (452, N'2325', N'El certificado usado no es el comunicado a SUNAT', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (453, N'2326', N'El certificado usado se encuentra de baja', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (454, N'2327', N'El certificado usado no se encuentra vigente', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (455, N'2328', N'El certificado usado se encuentra revocado', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (456, N'2329', N'La fecha de emision se encuentra fuera del limite permitido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (457, N'2330', N'La fecha de generación de la comunicación debe ser igual a la fecha consignada en el nombre del archivo', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (458, N'2331', N'Número de RUC del nombre del archivo no coincide con el consignado en el contenido del archivo XML', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (459, N'2332', N'Número de Serie del nombre del archivo no coincide con el consignado en el contenido del archivo XML', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (460, N'2333', N'Número de documento en el nombre del archivo no coincide con el consignado en el contenido del XML', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (461, N'2334', N'El documento electrónico ingresado ha sido alterado', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (462, N'2335', N'El documento electrónico ingresado ha sido alterado', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (463, N'2336', N'Ocurrió un error en el proceso de validación de la firma digital', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (464, N'2337', N'La moneda debe ser la misma en todo el documento', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (465, N'2338', N'La moneda debe ser la misma en todo el documento', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (466, N'2339', N'El dato ingresado en PayableAmount no cumple con el formato establecido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (467, N'2340', N'El valor ingresado en AdditionalMonetaryTotal/cbc:ID es incorrecto', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (468, N'2341', N'AdditionalMonetaryTotal/cbc:ID debe tener valor', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (469, N'2342', N'Fecha de emision de la factura no coincide con la informada en la comunicacion', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (470, N'2343', N'cac:TaxTotal/cac:TaxSubtotal/cbc:TaxAmount - El dato ingresado no cumple con el estandar', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (471, N'2344', N'El XML no contiene el tag cac:TaxTotal/cac:TaxSubtotal/cbc:TaxAmount', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (472, N'2345', N'La serie no corresponde al tipo de comprobante', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (473, N'2346', N'La fecha de generación del resumen debe ser igual a la fecha consignada en el nombre del archivo', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (474, N'2347', N'Los rangos informados en el archivo XML se encuentran duplicados o superpuestos', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (475, N'2348', N'Los documentos informados en el archivo XML se encuentran duplicados', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (476, N'2349', N'Debe consignar solo un elemento sac:AdditionalMonetaryTotal con cbc:ID igual a 1001', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (477, N'2350', N'Debe consignar solo un elemento sac:AdditionalMonetaryTotal con cbc:ID igual a 1002', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (478, N'2351', N'Debe consignar solo un elemento sac:AdditionalMonetaryTotal con cbc:ID igual a 1003', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (479, N'2352', N'Debe consignar solo un elemento cac:TaxTotal a nivel global para IGV (cbc:ID igual a 1000)', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (480, N'2353', N'Debe consignar solo un elemento cac:TaxTotal a nivel global para ISC (cbc:ID igual a 2000)', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (481, N'2354', N'Debe consignar solo un elemento cac:TaxTotal a nivel global para Otros (cbc:ID igual a 9999)', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (482, N'2355', N'Debe consignar solo un elemento cac:TaxTotal a nivel de item para IGV (cbc:ID igual a 1000)', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (483, N'2356', N'Debe consignar solo un elemento cac:TaxTotal a nivel de item para ISC (cbc:ID igual a 2000)', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (484, N'2357', N'Debe consignar solo un elemento sac:BillingPayment a nivel de item con cbc:InstructionID igual a 01', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (485, N'2358', N'Debe consignar solo un elemento sac:BillingPayment a nivel de item con cbc:InstructionID igual a 02', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (486, N'2359', N'Debe consignar solo un elemento sac:BillingPayment a nivel de item con cbc:InstructionID igual a 03', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (487, N'2360', N'Debe consignar solo un elemento sac:BillingPayment a nivel de item con cbc:InstructionID igual a 04', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (488, N'2361', N'Debe consignar solo un elemento cac:TaxTotal a nivel de item para Otros (cbc:ID igual a 9999)', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (489, N'2362', N'Debe consignar solo un tag cac:AccountingSupplierParty/cbc:AdditionalAccountID', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (490, N'2363', N'Debe consignar solo un tag cac:AccountingCustomerParty/cbc:AdditionalAccountID', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (491, N'2364', N'El comprobante contiene un tipo y número de Guía de Remisión repetido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (492, N'2365', N'El comprobante contiene un tipo y número de Documento Relacionado repetido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (493, N'2366', N'El codigo en el tag sac:AdditionalProperty/cbc:ID debe tener 4 posiciones', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (494, N'2367', N'El dato ingresado en PriceAmount del Precio de venta unitario por item no cumple con el formato establecido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (495, N'2368', N'El dato ingresado en TaxSubtotal/cbc:TaxAmount del item no cumple con el formato establecido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (496, N'2369', N'El dato ingresado en PriceAmount del Valor de venta unitario por item no cumple con el formato establecido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (497, N'2370', N'El dato ingresado en LineExtensionAmount del item no cumple con el formato establecido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (498, N'2371', N'El XML no contiene el tag cbc:TaxExemptionReasonCode de Afectacion al IGV', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (499, N'2372', N'El tag en el item cac:TaxTotal/cbc:TaxAmount debe tener el mismo valor que cac:TaxTotal/cac:TaxSubtotal/cbc:TaxAmount', 0)
GO
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (500, N'2373', N'Si existe monto de ISC en el ITEM debe especificar el sistema de calculo', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (501, N'2374', N'La factura a dar de baja tiene una fecha de recepcion fuera del plazo permitido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (502, N'2375', N'Fecha de emision del comprobante no coincide con la fecha de emision consignada en la comunicación', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (503, N'2376', N'La boleta de venta a dar de baja fue informada en un resumen con fecha de recepcion fuera del plazo permitido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (504, N'2377', N'El Name o TaxTypeCode debe corresponder con el Id para el IGV', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (505, N'2378', N'El Name o TaxTypeCode debe corresponder con el Id para el ISC', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (506, N'2379', N'La numeracion de boleta de venta a dar de baja fue generada en una fecha fuera del plazo permitido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (507, N'2380', N'El documento tiene observaciones', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (508, N'2381', N'Comprobante no cumple con el Grupo 1: No todos los items corresponden a operaciones gravadas a IGV', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (509, N'2382', N'Comprobante no cumple con el Grupo 2: No todos los items corresponden a operaciones inafectas o exoneradas al IGV', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (510, N'2383', N'Comprobante no cumple con el Grupo 3: Falta leyenda con codigo 1002', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (511, N'2384', N'Comprobante no cumple con el Grupo 3: Existe item con operación onerosa', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (512, N'2385', N'Comprobante no cumple con el Grupo 4: Debe exitir Total descuentos mayor a cero', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (513, N'2386', N'Comprobante no cumple con el Grupo 5: Todos los items deben tener operaciones afectas a ISC', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (514, N'2387', N'Comprobante no cumple con el Grupo 6: El monto de percepcion no existe o es cero', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (515, N'2388', N'Comprobante no cumple con el Grupo 6: Todos los items deben tener código de Afectación al IGV igual a 10', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (516, N'2389', N'Comprobante no cumple con el Grupo 7: El codigo de moneda no es diferente a PEN', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (517, N'2390', N'Comprobante no cumple con el Grupo 8: No todos los items corresponden a operaciones gravadas a IGV', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (518, N'2391', N'Comprobante no cumple con el Grupo 9: No todos los items corresponden a operaciones inafectas o exoneradas al IGV', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (519, N'2392', N'Comprobante no cumple con el Grupo 10: Falta leyenda con codigo 1002', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (520, N'2393', N'Comprobante no cumple con el Grupo 10: Existe item con operación onerosa', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (521, N'2394', N'Comprobante no cumple con el Grupo 11: Debe existir Total descuentos mayor a cero', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (522, N'2395', N'Comprobante no cumple con el Grupo 12: El codigo de moneda no es diferente a PEN', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (523, N'2396', N'Si el monto total es mayor a S/. 700.00 debe consignar tipo y numero de documento del adquiriente', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (524, N'2397', N'El tipo de documento del adquiriente no puede ser Numero de RUC', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (525, N'2398', N'El documento a dar de baja se encuentra rechazado', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (526, N'2399', N'El tipo de documento modificado por la Nota de credito debe ser boleta electronica', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (527, N'2400', N'El tipo de documento modificado por la Nota de debito debe ser boleta electronica', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (528, N'2401', N'No se puede leer (parsear) el archivo XML', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (529, N'2402', N'El caso de prueba no existe', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (530, N'2403', N'La numeracion o nombre del documento ya ha sido enviado anteriormente', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (531, N'2404', N'Documento afectado por la nota electronica no se encuentra autorizado', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (532, N'2405', N'Contribuyente no se encuentra autorizado como emisor de boletas electronicas', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (533, N'2406', N'Existe mas de un tag sac:AdditionalMonetaryTotal con el mismo ID', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (534, N'2407', N'Existe mas de un tag sac:AdditionalProperty con el mismo ID', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (535, N'2408', N'El dato ingresado en PriceAmount del Valor referencial unitario por item no cumple con el formato establecido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (536, N'2409', N'Existe mas de un tag cac:AlternativeConditionPrice con el mismo cbc:PriceTypeCode', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (537, N'2410', N'Se ha consignado un valor invalido en el campo cbc:PriceTypeCode', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (538, N'2411', N'Ha consignado mas de un elemento cac:AllowanceCharge con el mismo campo cbc:ChargeIndicator', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (539, N'2412', N'Se ha consignado mas de un documento afectado por la nota (tag cac:BillingReference)', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (540, N'2413', N'Se ha consignado mas de un motivo o sustento de la nota (tag cac:DiscrepancyResponse/cbc:Description)', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (541, N'2414', N'No se ha consignado en la nota el tag cac:DiscrepancyResponse', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (542, N'2415', N'Se ha consignado en la nota mas de un tag cac:DiscrepancyResponse', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (543, N'2416', N'Si existe leyenda Transferencia Gratuita debe consignar Total Valor de Venta de Operaciones Gratuitas', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (544, N'2417', N'Debe consignar Valor Referencial unitario por item en operaciones no onerosas', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (545, N'2418', N'Si consigna Valor Referencial unitario por item en operaciones no onerosas,la operacion debe ser no onerosa.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (546, N'2419', N'El dato ingresado en AllowanceTotalAmount no cumple con el formato establecido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (547, N'2420', N'Ya transcurrieron mas de 25 dias calendarios para concluir con su proceso de homologacion', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (548, N'2421', N'Debe indicar  toda la informacion de  sustento de translado de bienes.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (549, N'2422', N'El valor unitario debe ser menor al precio unitario.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (550, N'2423', N'Si ha consignado monto ISC a nivel de item, debe consignar un monto a nivel de total.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (551, N'2424', N'RC Debe consignar solo un elemento sac:BillingPayment a nivel de item con cbc:InstructionID igual a 05.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (552, N'2425', N'Si la  operacion es gratuita PriceTypeCode =02 y cbc:PriceAmount> 0 el codigo de afectacion de igv debe ser  no onerosa es  decir diferente de 10,20,30.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (553, N'2426', N'Documentos relacionados duplicados en el comprobante.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (554, N'2427', N'Solo debe de existir un tag AdditionalInformation.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (555, N'2428', N'Comprobante no cumple con grupo de facturas con detracciones.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (556, N'2429', N'Comprobante no cumple con grupo de facturas con comercio exterior.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (557, N'2430', N'Comprobante no cumple con grupo de facturas con tag de factura guia.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (558, N'2431', N'Comprobante no cumple con grupo de facturas con tags no tributarios.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (559, N'2432', N'Comprobante no cumple con grupo de boletas con tags no tributarios.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (560, N'2433', N'Comprobante no cumple con grupo de facturas con tag venta itinerante.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (561, N'2434', N'Comprobante no cumple con grupo de boletas con tag venta itinerante.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (562, N'2435', N'Comprobante no cumple con grupo de boletas con ISC.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (563, N'2436', N'Comprobante no cumple con el grupo de boletas de venta con percepcion: El monto de percepcion no existe o es cero.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (564, N'2437', N'Comprobante no cumple con el grupo de boletas de venta con percepcion: Todos los items deben tener código de Afectación al IGV igual a 10.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (565, N'2438', N'Comprobante no cumple con grupo de facturas con tag venta anticipada I.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (566, N'2439', N'Comprobante no cumple con grupo de facturas con tag venta anticipada II.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (567, N'2500', N'Ingresar descripción y valor venta por ítem para documento de anticipos.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (568, N'2501', N'Valor venta debe ser mayor a cero.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (569, N'2502', N'El importe total para tipo de operación Venta interna-Anticipos debe ser mayor a cero.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (570, N'2503', N'PaidAmount: monto anticipado por documento debe ser mayor a cero.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (571, N'2504', N'Falta referencia de la factura relacionada con anticipo.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (572, N'2505', N'Código de documento de referencia debe ser 02 o 03.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (573, N'2506', N'cac:PrepaidPayment/cbc:ID: Factura o boleta no existe o comunicada de Baja.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (574, N'2507', N'Factura relacionada con anticipo no corresponde como factura de anticipo.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (575, N'2508', N'Ingresar documentos por anticipos.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (576, N'2509', N'Total de anticipos diferente a los montos anticipados por documento.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (577, N'2510', N'Nro nombre del documento no tiene el formato correcto.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (578, N'2511', N'El tipo de documento no es aceptado.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (579, N'2512', N'No existe información de serie o número.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (580, N'2513', N'Dato no cumple con formato de acuerdo al número de comprobante.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (581, N'2514', N'No existe información de receptor de documento.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (582, N'2515', N'Dato ingresado no cumple con catalogo 6.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (583, N'2516', N'Debe indicar tipo de documento.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (584, N'2517', N'Dato no cumple con formato establecido.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (585, N'2518', N'Calculo IGV no es correcto.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (586, N'2519', N'El importe total no coincide con la sumatoria de los valores de venta mas los tributos mas los cargos menos los descuentos que no afectan la base imponible', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (587, N'2520', N'El tipo documento del emisor que realiza el anticipo debe ser 6 del catalogo de tipo de documento.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (588, N'2521', N'El dato ingresado debe indicar SERIE-CORRELATIVO del documento que se realizo el anticipo.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (589, N'2522', N'No existe información del documento del anticipo.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (590, N'2523', N'GrossWeightMeasure – El dato ingresado no cumple con el formato establecido.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (591, N'2524', N'El dato ingresado en Amount no cumple con el formato establecido.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (592, N'2525', N'El dato ingresado en Quantity no cumple con el formato establecido.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (593, N'2526', N'El dato ingresado en Percent no cumple con el formato establecido.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (594, N'2527', N'PrepaidAmount: Monto total anticipado debe ser mayor a cero.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (595, N'2528', N'cac:OriginatorDocumentReference/cbc:ID/@SchemaID – El tipo documento debe ser 6 del catalogo de tipo de documento.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (596, N'2529', N'RUC que emitio documento de anticipo, no existe.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (597, N'2530', N'RUC que solicita la emision de la factura, no existe.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (598, N'2531', N'Codigo del Local Anexo del emisor no existe.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (599, N'2532', N'No existe información de modalidad de transporte.', 0)
GO
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (600, N'2533', N'Si ha consignado Transporte Privado, debe consignar Licencia de conducir, Placa, N constancia de inscripcion y marca del vehiculo.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (601, N'2534', N'Si ha consignado Transporte Público, debe consignar Datos del transportista.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (602, N'2535', N'La nota de crédito por otros conceptos tributarios debe tener Otros Documentos Relacionados.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (603, N'2536', N'Serie y numero no se encuentra registrado como baja por cambio de destinatario.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (604, N'2537', N'cac:OrderReference/cac:DocumentReference/cbc:DocumentTypeCode - El tipo de documento de serie y número dado de baja es incorrecta.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (605, N'2538', N'El contribuyente no se encuentra autorizado como emisor electronico de Guía o de factura o de boletaFactura GEM.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (606, N'2539', N'El contribuyente no esta activo.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (607, N'2540', N'El contribuyente no esta habido.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (608, N'2541', N'El XML no contiene el tag o no existe informacion del tipo de documento identidad del remitente.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (609, N'2542', N'cac:DespatchSupplierParty/cbc:CustomerAssignedAccountID@schemeID - El valor ingresado como tipo de documento identidad del remitente es incorrecta.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (610, N'2543', N'El XML no contiene el tag o no existe informacion de la dirección completa y detallada en domicilio fiscal.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (611, N'2544', N'El XML no contiene el tag o no existe información de la provincia en domicilio fiscal.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (612, N'2545', N'El XML no contiene el tag o no existe información del departamento en domicilio fiscal.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (613, N'2546', N'El XML no contiene el tag o no existe información del distrito en domicilio fiscal.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (614, N'2547', N'El XML no contiene el tag o no existe información del país en domicilio fiscal.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (615, N'2548', N'El valor del país inválido.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (616, N'2549', N'El XML no contiene el tag o no existe informacion del tipo de documento identidad del destinatario.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (617, N'2550', N'cac:DeliveryCustomerParty/cbc:CustomerAssignedAccountID@schemeID - El dato ingresado de tipo de documento identidad del destinatario no cumple con el estandar.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (618, N'2551', N'El XML no contiene el tag o no existe informacion de CustomerAssignedAccountID del proveedor de servicios.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (619, N'2552', N'El XML no contiene el tag o no existe informacion del tipo de documento identidad del proveedor.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (620, N'2553', N'cac:SellerSupplierParty/cbc:CustomerAssignedAccountID@schemeID - El dato ingresado no es valido.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (621, N'2554', N'Para el motivo de traslado ingresado el Destinatario debe ser igual al remitente.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (622, N'2555', N'Destinatario no debe ser igual al remitente.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (623, N'2556', N'cbc:TransportModeCode -  dato ingresado no es valido.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (624, N'2557', N'La fecha del StartDate no debe ser menor al Today.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (625, N'2558', N'El XML no contiene el tag o no existe informacion en Numero de Ruc del transportista.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (626, N'2559', N'/DespatchAdvice/cac:Shipment/cac:ShipmentStage/cac:CarrierParty/cac:PartyIdentification/cbc:ID  - El dato ingresado no cumple con el formato establecido.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (627, N'2560', N'Transportista  no debe ser igual al remitente o destinatario.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (628, N'2561', N'El XML no contiene el tag o no existe informacion del tipo de documento identidad del transportista.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (629, N'2562', N'/DespatchAdvice/cac:Shipment/cac:ShipmentStage/cac:CarrierParty/cac:PartyIdentification/cbc:ID@schemeID  - El dato ingresado no es valido.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (630, N'2563', N'El XML no contiene el tag o no existe informacion de Apellido, Nombre o razon social del transportista.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (631, N'2564', N'Razon social transportista - El dato ingresado no cumple con el formato establecido.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (632, N'2565', N'El XML no contiene el tag o no existe informacion del tipo de unidad de transporte.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (633, N'2566', N'El XML no contiene el tag o no existe informacion del Numero de placa del vehículo.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (634, N'2567', N'Numero de placa del vehículo - El dato ingresado no cumple con el formato establecido.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (635, N'2568', N'El XML no contiene el tag o no existe informacion en el Numero de documento de identidad del conductor.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (636, N'2569', N'Documento identidad del conductor - El dato ingresado no cumple con el formato establecido.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (637, N'2570', N'El XML no contiene el tag o no existe informacion del tipo de documento identidad del conductor.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (638, N'2571', N'cac:DriverPerson/ID@schemeID - El valor ingresado de tipo de documento identidad de conductor es incorrecto.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (639, N'2572', N'El XML no contiene el tag o no existe informacion del Numero de licencia del conductor.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (640, N'2573', N'Numero de licencia del conductor - El dato ingresado no cumple con el formato establecido.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (641, N'2574', N'El XML no contiene el tag o no existe informacion de direccion detallada de punto de llegada.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (642, N'2575', N'El XML no contiene el tag o no existe informacion de CityName.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (643, N'2576', N'El XML no contiene el tag o no existe informacion de District.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (644, N'2577', N'El XML no contiene el tag o no existe informacion de direccion detallada de punto de partida.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (645, N'2578', N'El XML no contiene el tag o no existe informacion de CityName.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (646, N'2579', N'El XML no contiene el tag o no existe informacion de District.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (647, N'2580', N'El XML No contiene el tag o no existe información de la cantidad del item.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (648, N'2600', N'El comprobante fue enviado fuera del plazo permitido.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (649, N'2601', N'Señor contribuyente a la fecha no se encuentra registrado ó habilitado con la condición de Agente de percepción.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (650, N'2602', N'El régimen percepción enviado no corresponde con su condición de Agente de percepción.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (651, N'2603', N'La tasa de percepción enviada no corresponde con el régimen de percepción.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (652, N'2604', N'El Cliente no puede ser el mismo que el Emisor del comprobante de percepción.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (653, N'2605', N'Número de RUC del Cliente no existe.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (654, N'2606', N'Documento de identidad del Cliente no existe.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (655, N'2607', N'La moneda del importe de cobro debe ser la misma que la del documento relacionado.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (656, N'2608', N'Los montos de pago, percibidos y montos cobrados consignados para el documento relacionado no son correctos.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (657, N'2609', N'El comprobante electrónico enviado no se encuentra registrado en la SUNAT.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (658, N'2610', N'La fecha de emisión, Importe total del comprobante y la moneda del comprobante electrónico enviado no son los registrados en los Sistemas de SUNAT.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (659, N'2611', N'El comprobante electrónico no ha sido emitido al cliente.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (660, N'2612', N'La fecha de cobro debe estar entre el primer día calendario del mes al cual corresponde la fecha de emisión del comprobante de percepción o desde la fecha de emisión del comprobante relacionado.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (661, N'2613', N'El Nro. de documento con número de cobro ya se encuentra en la Relación de Documentos Relacionados agregados.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (662, N'2614', N'El Nro. de documento con el número de cobro ya se encuentra registrado como pago realizado.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (663, N'2615', N'Importe total percibido debe ser igual a la suma de los importes percibidos por cada documento relacionado.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (664, N'2616', N'Importe total cobrado debe ser igual a la suma de los importe totales cobrados por cada documento relacionado.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (665, N'2617', N'Señor contribuyente a la fecha no se encuentra registrado ó habilitado con la condición de Agente de retención.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (666, N'2618', N'El régimen retención enviado no corresponde con su condición de Agente de retención.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (667, N'2619', N'La tasa de retención enviada no corresponde con el régimen de retención.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (668, N'2620', N'El Proveedor no puede ser el mismo que el Emisor del comprobante de retención.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (669, N'2621', N'Número de RUC del Proveedor no existe.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (670, N'2622', N'La moneda del importe de pago debe ser la misma que la del documento relacionado.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (671, N'2623', N'Los montos de pago, retenidos y montos pagados consignados para el documento relacionado no son correctos.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (672, N'2624', N'El comprobante electrónico no ha sido emitido por el proveedor.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (673, N'2625', N'La fecha de pago debe estar entre el primer día calendario del mes al cual corresponde la fecha de emisión del comprobante de retención o desde la fecha de emisión del comprobante relacionado.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (674, N'2626', N'El Nro. de documento con el número de pago ya se encuentra en la Relación de Documentos Relacionados agregados.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (675, N'2627', N'El Nro. de documento con el número de pago ya se encuentra registrado como pago realizado.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (676, N'2628', N'Importe total retenido debe ser igual a la suma de los importes retenidos por cada documento relacionado.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (677, N'2629', N'Importe total pagado debe ser igual a la suma de los importes pagados por cada documento relacionado.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (678, N'2630', N'La serie o numero del documento(01) modificado por la Nota de Credito no cumple con el formato establecido para tipo codigo Nota Credito 10.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (679, N'2631', N'La serie o numero del documento(12) modificado por la Nota de Credito no cumple con el formato establecido para tipo codigo Nota Credito 10.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (680, N'2632', N'La serie o numero del documento(56) modificado por la Nota de Credito no cumple con el formato establecido para tipo codigo Nota Credito 10.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (681, N'2633', N'La serie o numero del documento(03) modificado por la Nota de Credito no cumple con el formato establecido para tipo codigo Nota Credito 10.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (682, N'2634', N'ReferenceID - El dato ingresado debe indicar serie correcta del documento al que se relaciona la Nota tipo 10.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (683, N'2635', N'Debe existir DocumentTypeCode de Otros documentos relacionados con valor 99 para un tipo codigo Nota Credito 10.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (684, N'2636', N'No existe datos del ID de los documentos relacionados con valor 99 para un tipo codigo Nota Credito 10.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (685, N'2637', N'No existe datos del DocumentType de los documentos relacionados con valor 99 para un tipo codigo Nota Credito 10.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (686, N'2640', N'Operacion gratuita, solo debe consignar un monto referencial', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (687, N'2641', N'Operacion gratuita,  debe consignar Total valor venta - operaciones gratuitas  mayor a cero', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (688, N'2642', N'Operaciones de exportacion, deben consignar Tipo Afectacion igual a 40', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (689, N'2643', N'Factura de operacion sujeta IVAP debe consignar Monto de impuestos por item', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (690, N'2644', N'Comprobante operacion sujeta IVAP solo debe tener ítems con código de afectación del IGV igual a 17', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (691, N'2645', N'Factura de operacion sujeta a IVAP debe consignar items con codigo de tributo 1000', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (692, N'2646', N'Factura de operacion sujeta a IVAP debe consignar  items con nombre  de tributo IVAP', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (693, N'2647', N'Código tributo  UN/ECE debe ser VAT', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (694, N'2648', N'Factura de operacion sujeta al IVAP, solo puede consignar informacion para operacion gravadas', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (695, N'2649', N'Operación sujeta al IVAP, debe consignar monto en total operaciones gravadas', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (696, N'2650', N'Factura de operacion sujeta al IVAP , no debe consignar valor para ISC o debe ser 0', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (697, N'2651', N'Factura de operacion sujeta al IVAP , no debe consignar valor para IGV o debe ser 0', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (698, N'2652', N'Factura de operacion sujeta al IVAP , debe registrar mensaje 2007', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (699, N'2653', N'Servicios prestados No domiciliados. Total IGV debe se mayor a cero', 0)
GO
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (700, N'2654', N'Servicios prestados No domiciliados. Código tributo a consignar debe ser 1000', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (701, N'2655', N'Servicios prestados No domiciliados. El código de afectación debe ser 40', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (702, N'2656', N'Servicios prestados No domiciliados. Código tributo  UN/ECE debe ser VAT', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (703, N'2657', N'El Nro. de documento ya fué utilizado en la emision de CPE.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (704, N'2658', N'El Nro. de documento no se ha informado o no se encuentra en estado Revertido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (705, N'2659', N'La fecha de cobro de cada documento relacionado deben ser del mismo Periodo (mm/aaaa), asimismo estas fechas podrán ser menores o iguales a la fecha de emisión del comprobante de percepción', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (706, N'2660', N'Los datos del CPE revertido no corresponden a los registrados en la SUNAT', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (707, N'2661', N'La fecha de cobro de cada documento relacionado deben ser del mismo Periodo (mm/aaaa), asimismo estas fechas podrán ser menores o iguales a la fecha de emisión del comprobante de retencion', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (708, N'2662', N'El Nro. de documento ya fué utilizado en la emision de CRE.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (709, N'2663', N'El documento indicado no existe no puede ser modificado/eliminado', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (710, N'2664', N'El calculo de la base imponible de percepción y el monto de la percepción no coincide con el monto total informado.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (711, N'2665', N'El contribuyente no se encuentra autorizado a emitir Tickets', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (712, N'2666', N'Las percepciones son solo válidas para boletas de venta al contado.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (713, N'2667', N'Importe total percibido debe ser igual a la suma de los importes percibidos por cada documento relacionado.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (714, N'2668', N'Importe total cobrado debe ser igual a la suma de los importes cobrados por cada documento relacionado.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (715, N'2669', N'El dato ingresado en TotalInvoiceAmount debe ser numérico mayor a cero', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (716, N'2670', N'La razón social no corresponde al ruc informado.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (717, N'2671', N'La fecha de generación de la comunicación debe ser mayor o igual a la fecha de generación del documento revertido.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (718, N'2672', N'La fecha de generación del documento revertido debe ser menor o igual a la fecha actual.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (719, N'2673', N'El dato ingresado no cumple con el formato RR-fecha-correlativo.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (720, N'2674', N'El dato ingresado  no cumple con el formato de DocumentSerialID, para DocumentTypeCode con valor 20.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (721, N'2675', N'El dato ingresado  no cumple con el formato de DocumentSerialID, para DocumentTypeCode con valor 40.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (722, N'2676', N'El XML no contiene el tag o no existe información del número de RUC del emisor', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (723, N'2677', N'El valor ingresado como número de RUC del emisor es incorrecto', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (724, N'2678', N'El XML no contiene el atributo o no existe información del tipo de documento del emisor', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (725, N'2679', N'El XML no contiene el tag o no existe información del número de documento de identidad del cliente', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (726, N'2680', N'El valor ingresado como documento de identidad del cliente es incorrecto', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (727, N'2681', N'El XML no contiene el atributo o no existe información del tipo de documento del cliente', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (728, N'2682', N'El valor ingresado como tipo de documento del cliente es incorrecto', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (729, N'2683', N'El XML no contiene el tag o no existe información del Importe total Percibido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (730, N'2684', N'El XML no contiene el tag o no existe información de la moneda del Importe total Percibido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (731, N'2685', N'El valor de la moneda del Importe total Percibido debe ser PEN', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (732, N'2686', N'El XML no contiene el tag o no existe información del Importe total Cobrado', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (733, N'2687', N'El dato ingresado en SUNATTotalCashed debe ser numérico mayor a cero', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (734, N'2689', N'El XML no contiene el tag o no existe información de la moneda del Importe total Cobrado', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (735, N'2690', N'El valor de la moneda del Importe total Cobrado debe ser PEN', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (736, N'2691', N'El XML no contiene el tag o no existe información del tipo de documento relacionado', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (737, N'2692', N'El tipo de documento relacionado no es válido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (738, N'2693', N'El XML no contiene el tag o no existe información del número de documento relacionado', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (739, N'2694', N'El número de documento relacionado no está permitido o no es valido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (740, N'2695', N'El XML no contiene el tag o no existe información del Importe total documento Relacionado', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (741, N'2696', N'El dato ingresado en el importe total documento relacionado debe ser numérico mayor a cero', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (742, N'2697', N'El XML no contiene el tag o no existe información del número de cobro', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (743, N'2698', N'El dato ingresado en el número de cobro no es válido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (744, N'2699', N'El XML no contiene el tag o no existe información del Importe del cobro', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (745, N'2700', N'El dato ingresado en el Importe del cobro debe ser numérico mayor a cero', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (746, N'2701', N'El XML no contiene el tag o no existe información de la moneda del documento Relacionado', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (747, N'2702', N'El XML no contiene el tag o no existe información de la fecha de cobro del documento Relacionado', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (748, N'2703', N'La fecha de cobro del documento relacionado no es válido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (749, N'2704', N'El XML no contiene el tag o no existe información del Importe percibido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (750, N'2705', N'El dato ingresado en el Importe percibido debe ser numérico mayor a cero', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (751, N'2706', N'El XML no contiene el tag o no existe información de la moneda de importe percibido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (752, N'2707', N'El valor de la moneda de importe percibido debe ser PEN', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (753, N'2708', N'El XML no contiene el tag o no existe información de la Fecha de Percepción', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (754, N'2709', N'La fecha de percepción no es válido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (755, N'2710', N'El XML no contiene el tag o no existe información del Monto total a cobrar', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (756, N'2711', N'El dato ingresado en el Monto total a cobrar debe ser numérico mayor a cero', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (757, N'2712', N'El XML no contiene el tag o no existe información de la moneda del Monto total a cobrar', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (758, N'2713', N'El valor de la moneda del Monto total a cobrar debe ser PEN', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (759, N'2714', N'El valor de la moneda de referencia para el tipo de cambio no es válido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (760, N'2715', N'El valor de la moneda objetivo para la Tasa de Cambio debe ser PEN', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (761, N'2716', N'El dato ingresado en el tipo de cambio debe ser numérico mayor a cero', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (762, N'2717', N'La fecha de cambio no es válido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (763, N'2718', N'El valor de la moneda del documento Relacionado no es válido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (764, N'2719', N'El XML no contiene el tag o no existe información de la moneda de referencia para el tipo de cambio', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (765, N'2720', N'El XML no contiene el tag o no existe información de la moneda objetivo para la Tasa de Cambio', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (766, N'2721', N'El XML no contiene el tag o no existe información del tipo de cambio', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (767, N'2722', N'El XML no contiene el tag o no existe información de la fecha de cambio', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (768, N'2723', N'El XML no contiene el tag o no existe información del número de documento de identidad del proveedor', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (769, N'2724', N'El valor ingresado como documento de identidad del proveedor es incorrecto', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (770, N'2725', N'El XML no contiene el tag o no existe información del Importe total Retenido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (771, N'2726', N'El XML no contiene el tag o no existe información de la moneda del Importe total Retenido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (772, N'2727', N'El XML no contiene el tag o no existe información de la moneda del Importe total Retenido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (773, N'2728', N'El valor de la moneda del Importe total Retenido debe ser PEN', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (774, N'2729', N'El XML no contiene el tag o no existe información del Importe total Pagado', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (775, N'2730', N'El dato ingresado en SUNATTotalPaid debe ser numérico mayor a cero', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (776, N'2731', N'El XML no contiene el tag o no existe información de la moneda del Importe total Pagado', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (777, N'2732', N'El valor de la moneda del Importe total Pagado debe ser PEN', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (778, N'2733', N'El XML no contiene el tag o no existe información del número de pago', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (779, N'2734', N'El dato ingresado en el número de pago no es válido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (780, N'2735', N'El XML no contiene el tag o no existe información del Importe del pago', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (781, N'2736', N'El dato ingresado en el Importe del pago debe ser numérico mayor a cero', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (782, N'2737', N'El XML no contiene el tag o no existe información de la fecha de pago del documento Relacionado', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (783, N'2738', N'La fecha de pago del documento relacionado no es válido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (784, N'2739', N'El XML no contiene el tag o no existe información del Importe retenido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (785, N'2740', N'El dato ingresado en el Importe retenido debe ser numérico mayor a cero', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (786, N'2741', N'El XML no contiene el tag o no existe información de la moneda de importe retenido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (787, N'2742', N'El valor de la moneda de importe retenido debe ser PEN', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (788, N'2743', N'El XML no contiene el tag o no existe información de la Fecha de Retención', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (789, N'2744', N'La fecha de retención no es válido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (790, N'2745', N'El XML no contiene el tag o no existe información del Importe total a pagar (neto)', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (791, N'2746', N'El dato ingresado en el Importe total a pagar (neto) debe ser numérico mayor a cero', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (792, N'2747', N'El XML no contiene el tag o no existe información de la Moneda del monto neto pagado', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (793, N'2748', N'El valor de la Moneda del monto neto pagado debe ser PEN', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (794, N'2749', N'La moneda de referencia para el tipo de cambio debe ser la misma que la del documento relacionado', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (795, N'2750', N'El comprobante que desea revertir no existe.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (796, N'2751', N'El comprobante fue informado previamente en una reversión.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (797, N'2752', N'El número de ítem no puede estar duplicado.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (798, N'2753', N'No debe existir mas de una referencia en guía dada de baja.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (799, N'2754', N'El tipo de documento de la guia dada de baja es incorrecto (tipo documento = 09).', 0)
GO
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (800, N'2755', N'El tipo de documento relacionado es incorrecto (ver catalogo nro 21).', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (801, N'2756', N'El numero de documento relacionado no cumple con el estandar.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (802, N'2757', N'El XML no contiene el tag o no existe información del número de documento de identidad del destinatario.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (803, N'2758', N'El valor ingresado como numero de documento de identidad del destinatario no cumple con el estandar.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (804, N'2759', N'El XML no contiene el atributo o no existe información del tipo de documento del destinatario.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (805, N'2760', N'El valor ingresado como tipo de documento del destinatario es incorrecto.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (806, N'2761', N'El XML no contiene el atributo o no existe información del nombre o razon social del destinatario.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (807, N'2762', N'El valor ingresado como tipo de documento del nombre o razon social del destinatario es incorrecto.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (808, N'2763', N'El XML no contiene el tag o no existe información del número de documento de identidad del tercero relacionado.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (809, N'2764', N'El valor ingresado como numero de documento de identidad del tercero relacionado no cumple con el estandar.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (810, N'2765', N'El XML no contiene el atributo o no existe información del tipo de documento del tercero relacionado.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (811, N'2766', N'El valor ingresado como tipo de documento del tercero relacionado es incorrecto.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (812, N'2767', N'Para importación, el XML no contiene el tag o no existe informacion del numero de DAM.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (813, N'2768', N'Para importación, el XML no contiene el tag o no existe informacion del numero de manifiesto de carga.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (814, N'2769', N'El valor ingresado como numero de DAM no cumple con el estandar.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (815, N'2770', N'El valor ingresado como numero de manifiesto de carga no cumple con el estandar.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (816, N'2771', N'El XML no contiene el atributo o no existe informacion en numero de bultos o pallets obligatorio para importación.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (817, N'2772', N'El valor ingresado como numero de bultos o pallets no cumple con el estandar.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (818, N'2773', N'El valor ingresado como modalidad de transporte no es correcto.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (819, N'2774', N'El XML no contiene datos de vehiculo o datos de conductores para una operación de transporte publico completo.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (820, N'2775', N'El XML no contiene el atributo o no existe informacion del codigo de ubigeo.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (821, N'2776', N'El valor ingresado como codigo de ubigeo no cumple con el estandar.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (822, N'2777', N'El XML no contiene el atributo o no existe informacion de direccion completa y detallada.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (823, N'2778', N'El valor ingresado como direccion completa y detallada no cumple con el estandar.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (824, N'2779', N'El XML no contiene el atributo o no existe informacion de cantida de items', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (825, N'2780', N'El valor ingresado en cantidad de items no cumple con el estandar', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (826, N'2781', N'El XML no contiene el atributo o no existe informacion de descripcion del items', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (827, N'2782', N'El valor ingresado en descripcion del items no cumple con el estandar', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (828, N'2783', N'El valor ingresado en codigo del item no cumple con el estandar.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (829, N'2784', N'Debe consignar codigo de regimen de percepcion (sac:AdditionalMonetaryTotal/cbc:ID@schemeID).', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (830, N'2785', N'sac:ReferenceAmount es obligatorio y mayor a cero cuando sac:AdditionalMonetaryTotal/cbc:ID es 2001', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (831, N'2786', N'El dato ingresado en sac:ReferenceAmount no cumple con el formato establecido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (832, N'2787', N'Debe consignar la moneda para la Base imponible percepcion.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (833, N'2788', N'El dato ingresado en moneda de base imponible de la percepcion debe ser PEN', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (834, N'2789', N'cbc:PayableAmount es obligatorio y mayor a cero cuando sac:AdditionalMonetaryTotal/cbc:ID es 2001', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (835, N'2790', N'El dato ingresado en cbc:PayableAmount no cumple con el formato establecido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (836, N'2791', N'Debe consignar la moneda para el Monto de la percepcion (cbc:PayableAmount/@currencyID)', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (837, N'2792', N'El dato ingresado en moneda del monto de cargo/descuento para percepcion debe ser PEN', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (838, N'2793', N'sac:TotalAmount es obligatorio y mayor a cero cuando sac:AdditionalMonetaryTotal/cbc:ID es 2001', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (839, N'2794', N'El dato ingresado en sac:TotalAmount no cumple con el formato establecido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (840, N'2795', N'Debe consignar la moneda para el Monto Total incluido la percepcion (sac:TotalAmount/@currencyID)', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (841, N'2796', N'El dato ingresado en sac:TotalAmount/@currencyID debe ser PEN', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (842, N'2797', N'El Monto de percepcion no puede ser mayor al importe total del comprobante.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (843, N'2798', N'El Monto de percepcion no tiene el valor correcto según el tipo de percepcion.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (844, N'2799', N'sac:TotalAmount no tiene el valor correcto cuando sac:AdditionalMonetaryTotal/cbc:ID es 2001', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (845, N'2800', N'El dato ingresado en el tipo de documento de identidad del receptor no esta permitido.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (846, N'2801', N'El DNI ingresado no cumple con el estandar.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (847, N'2802', N'El dato ingresado como numero de documento de identidad del receptor no cumple con el formato establecido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (848, N'2803', N'ID - No cumple con el formato UUID', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (849, N'2804', N'La fecha de recepcion del comprobante por ose, no debe de ser mayor a la fecha de recepcion de sunat', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (850, N'2805', N'El XML no contiene el tag IssueTime', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (851, N'2806', N'IssueTime - El dato ingresado  no cumple con el patrón hh:mm:ss.sssss', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (852, N'2807', N'El XML no contiene el tag ResponseDate', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (853, N'2808', N'ResponseDate - El dato ingresado  no cumple con el patrón YYYY-MM-DD', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (854, N'2809', N'La fecha de recepcion del comprobante por ose, no debe de ser mayor a la fecha de comprobacion del ose', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (855, N'2810', N'La fecha de comprobacion del comprobante en OSE no puede ser mayor a la fecha de recepcion en SUNAT.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (856, N'2811', N'El XML no contiene el tag ResponseTime', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (857, N'2812', N'ResponseTime - El dato ingresado  no cumple con el patrón hh:mm:ss.sssss', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (858, N'2813', N'El XML no contiene el tag o no existe información del Número de documento de identificación del que envía el CPE (emisor o PSE)', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (859, N'2814', N'El valor ingresado como Número de documento de identificación del que envía el CPE (emisor o PSE) es incorrecto', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (860, N'2816', N'El XML no contiene el atributo schemeID o no existe información del Tipo de documento de identidad del que envía el CPE (emisor o PSE)', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (861, N'2817', N'El valor ingresado como Tipo de documento de identidad del que envía el CPE (emisor o PSE) es incorrecto', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (862, N'2818', N'El XML no contiene el atributo schemeAgencyName o no existe información del Tipo de documento de identidad del que envía el CPE (emisor o PSE)', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (863, N'2819', N'El valor ingresado en el atributo schemeAgencyName del Tipo de documento de identidad del que envía el CPE (emisor o PSE) es incorrecto', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (864, N'2820', N'El XML no contiene el atributo schemeURI o no existe información del Tipo de documento de identidad del que envía el CPE (emisor o PSE)', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (865, N'2821', N'El valor ingresado en el atributo schemeURI del Tipo de documento de identidad del que envía el CPE (emisor o PSE) es incorrecto', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (866, N'2822', N'El XML no contiene el tag o no existe información del Número de documento de identificación del OSE', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (867, N'2823', N'El valor ingresado como Número de documento de identificación del OSE es incorrecto', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (868, N'2824', N'El certificado digital con el que se firma el CDR OSE no corresponde con el RUC del OSE informado', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (869, N'2825', N'El Número de documento de identificación del OSE informado no esta registrado en el padron.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (870, N'2826', N'El XML no contiene el atributo schemeID o no existe información del Tipo de documento de identidad del OSE', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (871, N'2827', N'El valor ingresado como Tipo de documento de identidad del OSE es incorrecto', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (872, N'2828', N'El XML no contiene el atributo schemeAgencyName o no existe información del Tipo de documento de identidad del OSE', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (873, N'2829', N'El valor ingresado en el atributo schemeAgencyName del Tipo de documento de identidad del OSE es incorrecto', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (874, N'2830', N'El XML no contiene el atributo schemeURI o no existe información del Tipo de documento de identidad del OSE', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (875, N'2831', N'El valor ingresado en el atributo schemeURI del Tipo de documento de identidad del OSE es incorrecto', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (876, N'2832', N'El XML no contiene el tag o no existe información del Código de Respuesta', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (877, N'2833', N'El valor ingresado como Código de Respuesta es incorrecto', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (878, N'2834', N'El XML no contiene el atributo listAgencyName o no existe información del Código de Respuesta', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (879, N'2835', N'El valor ingresado en el atributo listAgencyName del Código de Respuesta es incorrecto', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (880, N'2836', N'El XML no contiene el tag o no existe información de la Descripción de la Respuesta', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (881, N'2837', N'El valor ingresado como Descripción de la Respuesta es incorrecto', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (882, N'2838', N'El valor ingresado como Código de observación es incorrecto', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (883, N'2839', N'El XML no contiene el atributo listURI o no existe información del Código de observación', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (884, N'2840', N'El valor ingresado en el atributo listURI del Código de observación es incorrecto', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (885, N'2841', N'El XML no contiene el tag o no existe información de la Descripción de la observación', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (886, N'2842', N'El valor ingresado como Descripción de la observación es incorrecto', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (887, N'2843', N'Se ha encontrado mas de una Descripción de la observación, tag cac:Response/cac:Status/cbc:StatusReason', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (888, N'2844', N'No se encontro el tag cbc:StatusReasonCode cuando ingresó la Descripción de la observación', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (889, N'2845', N'El XML contiene mas de un elemento cac:DocumentReference', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (890, N'2846', N'El XML no contiene informacion en el tag cac:DocumentReference/cbc:ID', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (891, N'2848', N'El valor ingresado como Serie y número del comprobante no corresponde con el del comprobante', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (892, N'2849', N'El XML no contiene el tag o no existe información de la Fecha de emisión del comprobante', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (893, N'2851', N'El valor ingresado como Fecha de emisión del comprobante no corresponde con el del comprobante', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (894, N'2852', N'El XML no contiene el tag o no existe información de la Hora de emisión del comprobante', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (895, N'2853', N'El valor ingresado como Hora de emisión del comprobante no cumple con el patrón hh:mm:ss.sssss', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (896, N'2854', N'El valor ingresado como Hora de emisión del comprobante no corresponde con el del comprobante', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (897, N'2855', N'El XML no contiene el tag o no existe información del Tipo de comprobante', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (898, N'2856', N'El valor ingresado como Tipo de comprobante es incorrecto', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (899, N'2857', N'El valor ingresado como Tipo de comprobante no corresponde con el del comprobante', 0)
GO
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (900, N'2858', N'El XML no contiene el tag o no existe información del Hash del comprobante', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (901, N'2859', N'El valor ingresado como Hash del comprobante es incorrecto', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (902, N'2860', N'El valor ingresado como Hash del comprobante no corresponde con el del comprobante', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (903, N'2861', N'El XML no contiene el tag o no existe información del Número de documento de identificación del emisor', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (904, N'2862', N'El valor ingresado como Número de documento de identificación del emisor es incorrecto', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (905, N'2863', N'El valor ingresado como Número de documento de identificación del emisor no corresponde con el del comprobante', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (906, N'2864', N'El XML no contiene el atributo o no existe información del Tipo de documento de identidad del emisor', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (907, N'2865', N'El valor ingresado como Tipo de documento de identidad del emisor es incorrecto', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (908, N'2866', N'El valor ingresado como Tipo de documento de identidad del emisor no corresponde con el del comprobante', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (909, N'2867', N'El XML no contiene el tag o no existe información del Número de documento de identificación del receptor', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (910, N'2868', N'El valor ingresado como Número de documento de identificación del receptor es incorrecto', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (911, N'2869', N'El valor ingresado como Número de documento de identificación del receptor no corresponde con el del comprobante', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (912, N'2870', N'El XML no contiene el atributo o no existe información del Tipo de documento de identidad del receptor', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (913, N'2871', N'El valor ingresado como Tipo de documento de identidad del receptor es incorrecto', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (914, N'2872', N'El valor ingresado como Tipo de documento de identidad del receptor no corresponde con el del comprobante', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (915, N'2873', N'El PSE informado no se encuentra vinculado con el  emisor del comprobante en la fecha de comprobación', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (916, N'2874', N'El Número de documento de identificación del OSE informado no se encuentra vinculado al emisor del comprobante en la fecha de comprobación', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (917, N'2875', N'ID - El dato ingresado no cumple con el formato R#-fecha-correlativo', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (918, N'2876', N'La fecha de recepción del comprobante por OSE debe ser mayor a la fecha de emisión del comprobante enviado', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (919, N'2880', N'Es obligatorio ingresar el peso bruto total de la guía', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (920, N'2881', N'Es obligatorio indicar la unidad de medida del Peso Total de la guía', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (921, N'2883', N'Es obligatorio indicar la unidad de medida del ítem', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (922, N'2891', N'El código ingresado como tasa de percepción no existe en el catálogo', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (923, N'2892', N'El valor del tag no cumple con el formato establecido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (924, N'2893', N'Debe consignar um importe igual o mayor a cero (0)', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (925, N'2894', N'El valor del tag no cumple con el formato establecido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (926, N'2895', N'Debe consignar um importe igual o mayor a cero (0)', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (927, N'2896', N'El código ingresado como estado del ítem no existe en el catálogo', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (928, N'2897', N'Debe consignar um importe igual o mayor a cero (0)', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (929, N'2900', N'El Número de comprobante de fin de rango debe ser igual o mayor al de inicio', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (930, N'2901', N'El nombre comercial del emisor no cumple con el formato establecido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (931, N'2902', N'La urbanización del domicilio fiscal del emisor no cumple con el formato establecido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (932, N'2903', N'La provincia del domicilio fiscal del emisor no cumple con el formato establecido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (933, N'2904', N'El departamento del domicilio fiscal del emisor no cumple con el formato establecido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (934, N'2905', N'El distrito del domicilio fiscal del emisor no cumple con el formato establecido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (935, N'2906', N'El nombre comercial del proveedor no cumple con el formato establecido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (936, N'2907', N'La urbanización del domicilio fiscal del proveedor no cumple con el formato establecido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (937, N'2908', N'La provincia del domicilio fiscal del proveedor no cumple con el formato establecido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (938, N'2909', N'El departamento del domicilio fiscal del proveedor no cumple con el formato establecido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (939, N'2910', N'El distrito del domicilio fiscal del proveedor no cumple con el formato establecido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (940, N'2911', N'El nombre comercial del cliente no cumple con el formato establecido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (941, N'2912', N'La urbanización del domicilio fiscal del cliente no cumple con el formato establecido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (942, N'2913', N'La provincia del domicilio fiscal del cliente no cumple con el formato establecido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (943, N'2914', N'El departamento del domicilio fiscal del cliente no cumple con el formato establecido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (944, N'2915', N'El distrito del domicilio fiscal del cliente no cumple con el formato establecido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (945, N'2916', N'La dirección completa y detallada del domicilio fiscal del emisor no cumple con el formato establecido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (946, N'2917', N'Debe corresponder a algún valor válido establecido en el catálogo 13', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (947, N'2918', N'La dirección completa y detallada del domicilio fiscal del proveedor no cumple con el formato establecido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (948, N'2919', N'La dirección completa y detallada del domicilio fiscal del cliente no cumple con el formato establecido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (949, N'2920', N'Dato no cumple con formato de acuerdo al número de comprobante.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (950, N'2921', N'Es obligatorio informar el detalle el tipo de servicio público', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (951, N'2922', N'El valor del Tag no se encuentra en el catálogo', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (952, N'2923', N'Es obligatorio informar el código de servicios de telecomunicaciones para el tipo servicio público informado', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (953, N'2924', N'Sólo enviar información para el tipos de servicios públicos 5', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (954, N'2925', N'El valor del Tag no se encuentra en el catálogo', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (955, N'2926', N'Es obligatorio informar el número del suministro para el tipo servicio público informado', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (956, N'2927', N'Comprobante de Servicio Publico no se encuenta registrado en sunat', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (957, N'2928', N'El valor del Tag no cumple con el tipo y longitud esperada', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (958, N'2929', N'Debe remitir información del número de teléfono para el código de servicios de telecomunicaciones informado', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (959, N'2930', N'El tipo de documento modificado por la Nota de debito debe ser Servicio Publico electronico', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (960, N'2931', N'El valor del Tag no cumple con el tipo y longitud esperada', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (961, N'2932', N'Es obligatorio informar el código de tarifa contratada para el tipo servicio público informado', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (962, N'2933', N'Sólo enviar información para el tipos de servicios públicos 1 o 2', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (963, N'2934', N'El valor del Tag no se encuentra en el catálogo', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (964, N'2935', N'Es obligatorio informar el detalle de la potencia contratada', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (965, N'2936', N'Sólo enviar información para el tipo de servicios público 1', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (966, N'2937', N'Es obligatorio informar el detalle de la potencia contratada', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (967, N'2938', N'Sólo enviar información para el tipo de servicios público 1', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (968, N'2939', N'El valor del Tag no cumple con el tipo y longitud esperada', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (969, N'2940', N'Es obligatorio informar el tipo de medidor ', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (970, N'2941', N'Sólo enviar información para el tipo de servicios público 1', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (971, N'2942', N'El valor del Tag no se encuentra en el catálogo', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (972, N'2943', N'Es obligatorio informar el número del medidor', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (973, N'2944', N'Sólo enviar información para el tipos de servicios públicos 1 o 2', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (974, N'2945', N'El valor del Tag no cumple con el tipo y longitud esperada', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (975, N'2946', N'Sólo enviar información para el tipos de servicios públicos 1 o 2', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (976, N'2947', N'No existe el detalle del número del medidor', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (977, N'2948', N'Sólo enviar información para el tipos de servicios públicos 1 o 2', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (978, N'2949', N'El valor del atributo no existe', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (979, N'2950', N'No existe el detalle del número del medidor', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (980, N'2951', N'Sólo enviar información para el tipos de servicios públicos 1 o 2', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (981, N'2952', N'El valor del Tag no cumple con el tipo y longitud esperada', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (982, N'2953', N'El valor del atributo no existe', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (983, N'2954', N'El valor ingresado como codigo de motivo de cargo/descuento por linea no es valido (catalogo 53)', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (984, N'2955', N'El formato ingresado en el tag cac:InvoiceLine/cac:Allowancecharge/cbc:Amount no cumple con el formato establecido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (985, N'2956', N'El Monto total de impuestos es obligatorio', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (986, N'2957', N'El valor del tag categoria de impuestos no corresponde al valor esperado.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (987, N'2958', N'El valor del atributo del tag cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cbc:ID no corresponde al esperado.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (988, N'2959', N'El valor del atributo del tag cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cbc:ID/ no corresponde al esperado.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (989, N'2960', N'El valor del tag no corresponde al esperado.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (990, N'2961', N'El valor del tag codigo de tributo internacional no corresponde al esperado.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (991, N'2962', N'El valor del atributo del tag cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cac:TaxScheme/cbc:ID no corresponde al esperado.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (992, N'2963', N'El valor del atributo del tag cac:TaxTotal/cac:TaxSubtotal/cac:TaxCategory/cbc:ID/ no corresponde al esperado.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (993, N'2964', N'El valor del tag nombre del tributo no corresponde al esperado.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (994, N'2965', N'La sumatoria de otros tributos no corresponde al total', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (995, N'2966', N'Sólo se puede indicar el códigos 55 del catálogo 53', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (996, N'2967', N'Los importes de otros cargos a nivel de línea no corresponden a la suma total.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (997, N'2968', N'Debe contener un importe mayor a 0.00 si envía el tag cac:AllowanceCharge/cbc:Amount', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (998, N'2969', N'Los importes de otros cargos a nivel de línea no corresponden a la suma total.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (999, N'2970', N'El dato ingresado en sac:SUNATTotalPaidBeforeRounding debe ser numérico mayor a cero', 0)
GO
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1000, N'2971', N'Si existe tag sac:SUNATTotalPaidBeforeRounding debe existir tag cbc:PayableRoundingAmount', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1001, N'2972', N'Importe total pagado antes de redondeo debe ser igual a la suma de los importes pagados por cada documento relacionado', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1002, N'2973', N'El valor de la moneda del Importe total pagado antes de redondeo debe ser PEN', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1003, N'2974', N'El dato ingresado en cbc:PayableRoundingAmount debe ser numérico valido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1004, N'2975', N'Si existe tag cbc:PayableRoundingAmount debe existir tag sac:SUNATTotalPaidBeforeRounding', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1005, N'2976', N'El valor para el ajuste por redondeo no es válido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1006, N'2977', N'El valor de la moneda del Ajuste por redondeo debe ser PEN', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1007, N'2978', N'Importe total pagado debe ser igual a la suma del Importe total pagado antes de redondeo mas el Ajuste por redondeo', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1008, N'2979', N'El dato ingresado en sac:SUNATTotalCashedBeforeRounding debe ser numérico mayor a cero', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1009, N'2980', N'Si existe tag sac:SUNATTotalCashedBeforeRounding debe existir tag cbc:PayableRoundingAmount', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1010, N'2981', N'Importe total cobrado antes de redondeo debe ser igual a la suma de los importes cobrados por cada documento relacionado', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1011, N'2982', N'El valor de la moneda del Importe total cobrado antes de redondeo debe ser PEN', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1012, N'2983', N'Si existe tag cbc:PayableRoundingAmount debe existir tag sac:SUNATTotalCashedBeforeRounding', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1013, N'2984', N'Importe total cobrado debe ser igual a la suma del Importe total cobrado antes de redondeo mas el Ajuste por redondeo', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1014, N'2985', N'Solo se acepta comprobantes con fecha de emisión hasta el 28/02/2014 si la tasa del comprobante de retencion 6%', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1015, N'2986', N'Solo se acepta informacion de percepcion para nuevas boletas.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1016, N'2987', N'El comprobante ya fue informado y se encuentra anulado o rechazado.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1017, N'2988', N'El comprobante (fisico) a la que hace referencia la nota, no se encuentra autorizado.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1018, N'2989', N'El comprobante (electronico) a la que hace referencia la nota, no se encuentra informado.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1019, N'2990', N'El comprobante (electronico) a la que hace referencia la nota, se encuentra anulado o rechazada.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1020, N'2991', N'El tipo de documento modificado por la Nota de credito debe ser comprobante de servicio publico', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1021, N'2992', N'El XML no contiene el tag de la tasa del tributo de la línea', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1022, N'2993', N'El factor de afectación de IGV por linea debe ser diferente a 0.00.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1023, N'2994', N'La categoría de impuesto de la línea no corresponde al valor esperado (catalogo 5)', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1024, N'2995', N'El XML no contiene el tag o no existe información del código internacional de tributo de la línea', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1025, N'2996', N'El XML no contiene el tag o no existe información del nombre de tributo de la línea', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1026, N'2997', N'El XML no contiene el tag o no existe información del código de tributo de la línea', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1027, N'2998', N'El código de tributo de la línea no corresponde al valor esperado', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1028, N'2999', N'El dato ingresado en el total valor de venta globales no cumple con el formato establecido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1029, N'3000', N'El monto total del impuestos sobre el valor de venta de operaciones gratuitas/inafectas/exoneradas debe ser igual a 0.00 ', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1030, N'3001', N'El Código producto de SUNAT no puede ser vacio si es de Exportacion', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1031, N'3002', N'El Código producto de SUNAT  no es válido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1032, N'3003', N'El XML no contiene el tag o no existe información de total valor de venta globales', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1033, N'3004', N'El XML no contiene el tag o no existe información de la categoría de impuesto globales', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1034, N'3005', N'El XML no contiene el tag o no existe información del código de tributo en operaciones inafectas/exoneradas', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1035, N'3006', N'El dato ingresado en descripcion de leyenda no cumple con el formato establecido.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1036, N'3007', N'El dato ingresado como codigo de tributo global no corresponde al valor esperado.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1037, N'3008', N'La sumatoria del total valor de venta - Otros tributos de pago de línea no corresponden al total', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1038, N'3009', N'La sumatoria del total del importe del tributo Otros tributos de línea no corresponden al total', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1039, N'3010', N'El XML no contiene el tag o no existe información de total valor de venta en operaciones gravadas', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1040, N'3011', N'El dato ingresado en el total valor de venta en operaciones gravadas  no cumple con el formato establecido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1041, N'3012', N'El dato ingresado en el importe del tributo en operaciones gravadas  no cumple con el formato establecido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1042, N'3013', N'El XML no contiene el tag o no existe información de la categoría de impuesto en operaciones gravadas', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1043, N'3014', N'El codigo de leyenda no debe repetirse en el comprobante.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1044, N'3015', N'El XML no contiene el tag o no existe información del código de tributo en operaciones gravadas', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1045, N'3016', N'El dato ingresado en base monto por cargo/descuento globales no cumple con el formato establecido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1046, N'3017', N'El XML no contiene el tag o no existe información del nombre de tributo en operaciones gravadas', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1047, N'3018', N'El XML no contiene el tag o no existe información del código internacional del tributo en operaciones gravadas', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1048, N'3019', N'El dato ingresado en total precio de venta no cumple con el formato establecido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1049, N'3020', N'El dato ingresado en el monto total de impuestos no cumple con el formato establecido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1050, N'3021', N'El dato ingresado en el monto total de impuestos por línea no cumple con el formato establecido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1051, N'3022', N'El importe total de impuestos por línea no coincide con la sumatoria de los impuestos por línea.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1052, N'3023', N'El tipo de documento no se encuentra en el catálogo ', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1053, N'3024', N'El tag cac:TaxTotal no debe repetirse a nivel de totales', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1054, N'3025', N'El dato ingresado en factor de cargo o descuento global no cumple con el formato establecido.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1055, N'3026', N'El tag cac:TaxTotal no debe repetirse a nivel de Item', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1056, N'3027', N'El valor del atributo no se encuentra en el catálogo', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1057, N'3028', N'El dato ingresado en código de SW de facturación no cumple con el formato establecido.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1058, N'3029', N'El XML no contiene el tag o no existe información del tipo de documento de identidad del emisor', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1059, N'3030', N'El XML no contiene el tag o no existe información del código de local anexo del emisor', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1060, N'3031', N'El dato ingresado en TaxableAmount de la linea no cumple con el formato establecido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1061, N'3032', N'El XML no contiene el tag o no existe información de la categoría de impuesto de la línea', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1062, N'3033', N'El codigo de bien o servicio sujeto a detracción no existe en el listado.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1063, N'3034', N'El xml no contiene el tag o no existe información en el nro de cuenta de detracción', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1064, N'3035', N'El xml no contiene el tag o no existe información en el monto de detraccion', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1065, N'3036', N'El XML no contiene el tag o no existe información del nombre del tributo', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1066, N'3037', N'El dato ingresado en monto de detraccion no cumple con el formato establecido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1067, N'3038', N'La sumatoria de los IGV (operaciones gravadas) de línea no corresponden al total', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1068, N'3039', N'La sumatoria del total valor de venta - operaciones gravadas de línea no corresponden al total', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1069, N'3040', N'La sumatoria del total valor de venta - Exportaciones de línea no corresponden al total', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1070, N'3041', N'La sumatoria del total valor de venta - operaciones inafectas de línea no corresponden al total', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1071, N'3042', N'La sumatoria del total valor de venta - operaciones exoneradas de línea no corresponden al total', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1072, N'3043', N'El XML no contiene el tag o no existe información de total valor de venta ISC e IVAP', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1073, N'3044', N'El dato ingresado en el total valor de venta ISC e IVAP no cumple con el formato establecido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1074, N'3045', N'La sumatoria del total valor de venta - ISC de línea no corresponden al total', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1075, N'3046', N'La sumatoria del total valor de venta - IVAP de línea no corresponden al total', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1076, N'3047', N'El dato ingresado en el importe del tributo para ISC e IVAP no cumple con el formato establecido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1077, N'3048', N'La sumatoria del total del importe del tributo ISC de línea no corresponden al total', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1078, N'3049', N'El importe del IVAP no corresponden al determinado por la información consignada.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1079, N'3050', N'Afectación de IGV no corresponde al código de tributo de la linea.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1080, N'3051', N'Nombre de tributo no corresponde al código de tributo de la linea.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1081, N'3052', N'El factor de cargo/descuento por linea no cumple con el formato establecido.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1082, N'3053', N'El Monto base de cargo/descuento por linea no cumple con el formato establecido.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1083, N'3054', N'El XML no contiene el tag o no existe información de la categoría de impuesto en ISC o IVAP', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1084, N'3055', N'Si el código de tributo es 2000, la categoría del tributo debe ser S', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1085, N'3056', N'Si el código de tributo es 1016, la categoría del tributo debe ser S', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1086, N'3057', N'La sumatoria del total valor de venta - operaciones gratuitas de línea no corresponden al total', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1087, N'3058', N'El XML no contiene el tag o no existe información del código de tributo para ISC o IVAP', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1088, N'3059', N'el XML no contiene el tag o no existe información de código de tributo.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1089, N'3060', N'El valor del tag código de tributo no corresponde al esperado.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1090, N'3061', N'No se permite importe mayor a cero cuando el codigo de tributo es IVAP y el comprobante esta sujeta a IVAP', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1091, N'3062', N'La tasa o porcentaje de detracción no corresponde al valor esperado.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1092, N'3063', N'El XML no contiene el tag de matricula de embarcación en Detracciones para recursos hidrobiologicos.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1093, N'3064', N'El XML no contiene tag o no existe información del valor del concepto por linea.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1094, N'3065', N'El XML no contiene tag de la fecha del concepto por linea.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1095, N'3066', N'El XML contiene un codigo de tributo no valido para Servicios Publicos.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1096, N'3067', N'El código de tributo no debe repetirse a nivel de item', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1097, N'3068', N'El código de tributo no debe repetirse a nivel de totales', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1098, N'3069', N'El xml contiene una linea con mas de un codigo de tributo repetitivo.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1099, N'3070', N'EL codigo internacional del tributo por linea no corresponde al valor esperado por su Id.', 0)
GO
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1100, N'3071', N'El dato ingresado como codigo de motivo de cargo/descuento global no es valido (catalogo nro 53)', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1101, N'3072', N'El XML no contiene el tag o no existe informacion de codigo de motivo de cargo/descuento global.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1102, N'3073', N'El XML no contiene el tag o no existe informacion de codigo de motivo de cargo/descuento por item.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1103, N'3074', N'El monto del cargo para el para FISE debe ser igual mayor a 0.00 ', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1104, N'3075', N'La sumatoria de descuentos que afectan a BI por linea no corresponden al total', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1105, N'3076', N'La sumatoria de descuentos que no afectan a BI por linea no corresponden al total', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1106, N'3077', N'La sumatoria de cargos que afectan a BI por linea no corresponden al total', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1107, N'3078', N'La sumatoria de cargos que no afectan a BI por linea no corresponden al total', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1108, N'3079', N'La sumatoria de montos bases de los descuentos que afectan a BI por linea no corresponden al total', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1109, N'3080', N'La sumatoria de montos bases de los descuentos que no afectan a BI por linea no corresponden al total', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1110, N'3081', N'La sumatoria de montos bases de los cargos que afectan a BI por linea no corresponden al total', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1111, N'3082', N'La sumatoria de montos bases de los cargos que no afectan a BI por linea no corresponden al total', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1112, N'3083', N'El XML no contiene el tag o no existe información del total valor de venta.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1113, N'3084', N'La sumatoria de valor de venta no corresponde a los importes consignados', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1114, N'3085', N'El XML no contiene el tag o no existe información del total precio de venta.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1115, N'3086', N'La sumatoria consignados en descuentos globales no corresponden al total.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1116, N'3087', N'La sumatoria consignados en cargos globales no corresponden al total', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1117, N'3088', N'El valor ingresado como moneda del comprobante no es valido (catalogo nro 02).', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1118, N'3089', N'El XML contiene mas de un tag como elemento de numero de documento del emisor', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1119, N'3090', N'El XML contiene mas de un tag como elemento de numero de documento del receptor.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1120, N'3091', N'Si se tipo de operación es Venta Interna - Sujeta al FISE, debe ingresar cargo para FISE', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1121, N'3092', N'Para cargo/descuento FISE, debe ingresar monto base y debe ser mayor a 0.00', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1122, N'3093', N'Si el tipo de operación es Operación Sujeta a Percepción, debe ingresar cargo para Percepción', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1123, N'3094', N'El comprobante más "código de operación del ítem" no debe repetirse', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1124, N'3095', N'El comprobante no debe ser emitido y editado en el mismo envío', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1125, N'3096', N'El comprobante no debe ser editado y anulado en el mismo envío', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1126, N'3097', N'El emisor a la fecha no se encuentra registrado ó habilitado en el Registro de exportadores de servicios SUNAT', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1127, N'3098', N'El XML no contiene el tag o no existe información del pais de uso, exploración o aprovechamiento', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1128, N'3099', N'El dato ingresado como pais de uso, exploracion o aprovechamiento es incorrecto.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1129, N'3100', N'El dato ingresado como codigo de tributo por linea es invalido para tipo de operación.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1130, N'3101', N'El factor de afectación de IGV por linea debe ser igual a 0.00 para Exoneradas, Inafectas, Exportación, Gratuitas de exoneradas o Gratuitas de inafectas.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1131, N'3102', N'El dato ingresado como factor de afectacion por linea no cumple con el formato establecido.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1132, N'3103', N'El producto del factor y monto base de la afectación del IGV/IVAP no corresponde al monto de afectacion de linea.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1133, N'3104', N'El factor de afectación de ISC por linea debe ser diferente a 0.00.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1134, N'3105', N'El XML debe contener al menos un tributo por linea de afectacion por IGV (Gravada, Exonerada, Inafecta, Exportación)', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1135, N'3106', N'El XML contiene mas de un tributo por linea (Gravado, Exonerado, Inafecto, Exportación)', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1136, N'3107', N'El dato ingresado como codigo de tributo global es invalido para tipo de operación.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1137, N'3108', N'El producto del factor y monto base de la afectación del ISC no corresponde al monto de afectacion de linea.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1138, N'3109', N'El producto del factor y monto base de la afectación de otros tributos no corresponde al monto de afectacion de linea.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1139, N'3110', N'El monto de afectacion de IGV por linea debe ser igual a 0.00 para Exoneradas, Inafectas, Exportación, Gratuitas de exoneradas o Gratuitas de inafectas.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1140, N'3111', N'El monto de afectación de IGV por linea debe ser diferente a 0.00.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1141, N'3112', N'La sumatoria de los IGV de operaciones gratuitas de la línea (codigo tributo 9996) no corresponden al total', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1142, N'3113', N'El xml contiene información FISE que no corresponde al tipo de operación.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1143, N'3114', N'El dato ingresado como indicador de cargo/descuento no corresponde al valor esperado.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1144, N'3115', N'El dato ingresado como unidad de medida de cantidad de especie vendidas no corresponde al valor esperado.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1145, N'3116', N'El XML no contiene el tag o no existe información del ubigeo de punto de origen en Detracciones - Servicio de transporte de carga.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1146, N'3117', N'El XML no contiene el tag o no existe información de la dirección del punto de origen en Detracciones - Servicio de transporte de carga.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1147, N'3118', N'El XML no contiene el tag o no existe información del ubigeo de punto de destino en Detracciones - Servicio de transporte de carga.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1148, N'3119', N'El XML no contiene el tag o no existe información de la dirección del punto de destino en Detracciones - Servicio de transporte de carga.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1149, N'3120', N'El XML no contiene el tag o no existe información del Detalle del viaje en Detracciones - Servicio de transporte de carga.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1150, N'3121', N'El XML no contiene el tag o no existe información del tipo de valor referencial en Detracciones - Servicios de transporte de carga.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1151, N'3122', N'El XML no contiene el tag o no existe información del monto del valor referencial en Detracciones - Servicios de transporte de carga.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1152, N'3123', N'El dato ingresado como monto valor referencial en Detracciones - Servicios de transporte de carga no cumple con el formato establecido.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1153, N'3124', N'Detracciones - Servicio de transporte de carga, debe tener un (y solo uno) Valor Referencial del Servicio de Transporte.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1154, N'3125', N'Detracciones - Servicio de transporte de carga, debe tener un (y solo uno) Valor Referencial sobre la carga efectiva.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1155, N'3126', N'Detracciones - Servicio de transporte de carga, debe tener un (y solo uno) Valor Referencial sobre la carga util nominal.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1156, N'3127', N'El XML no contiene el tag o no existe información del Codigo de BBSS de detracción para el tipo de operación.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1157, N'3128', N'El XML contiene información de codigo de bien y servicio de detracción que no corresponde al tipo de operación.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1158, N'3129', N'El dato ingresado como codigo de BBSS de detracción no corresponde al valor esperado.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1159, N'3130', N'El XML no contiene el tag de nombre de embarcación en Detracciones para recursos hidrobiologicos.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1160, N'3131', N'El XML no contiene el tag de tipo de especie vendidas en Detracciones para recursos hidrobiologicos.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1161, N'3132', N'El XML no contiene el tag de lugar de descarga en Detracciones para recursos hidrobiologicos.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1162, N'3133', N'El XML no contiene el tag de cantidad de especies vendidas en Detracciones para recursos hidrobiologicos.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1163, N'3134', N'El XML no contiene el tag de fecha de descarga en Detracciones para recursos hidrobiologicos.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1164, N'3135', N'El XML no contiene tag de la cantidad del concepto por linea.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1165, N'3136', N'El XML no contiene el tag de numero de documentos del huesped.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1166, N'3137', N'El XML no contiene el tag de tipo de documentos del huesped.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1167, N'3138', N'El XML no contiene el tag de codigo de pais de emision del documento de identidad', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1168, N'3139', N'El XML no contiene el tag de apellidos y nombres del huesped.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1169, N'3140', N'El XML no contiene el tag de codigo del pais de residencia.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1170, N'3141', N'El XML no contiene el tag de fecha de ingreso del pais.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1171, N'3142', N'El XML no contiene el tag de fecha de ingreso al establecimiento.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1172, N'3143', N'El XML no contiene el tag de fecha de salida del establecimiento.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1173, N'3144', N'El XML no contiene el tag de fecha de consumo.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1174, N'3145', N'El XML no contiene el tag de numero de dias de permanencia.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1175, N'3146', N'El XML no contiene el tag de Proveedores Estado: Número de Expediente', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1176, N'3147', N'El XML no contiene el tag de Proveedores Estado: Código de Unidad Ejecutora', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1177, N'3148', N'El XML no contiene el tag de Proveedores Estado: N° de Proceso de Selección', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1178, N'3149', N'El XML no contiene el tag de Proveedores Estado: N° de Contrato', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1179, N'3150', N'El XML no contiene el tag de Créditos Hipotecarios: Tipo de préstamo', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1180, N'3151', N'El XML no contiene el tag de Créditos Hipotecarios: Partida Registral', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1181, N'3152', N'El XML no contiene el tag de Créditos Hipotecarios: Número de contrato', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1182, N'3153', N'El XML no contiene el tag de Créditos Hipotecarios: Fecha de otorgamiento del crédito', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1183, N'3154', N'El XML no contiene el tag de Créditos Hipotecarios: Dirección del predio - Código de ubigeo', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1184, N'3155', N'El XML no contiene el tag de Créditos Hipotecarios: Dirección del predio - Dirección completa', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1185, N'3156', N'El XML no contiene el tag de BVME transporte ferroviario: Agente de Viajes: Numero de Ruc', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1186, N'3157', N'El XML no contiene el tag de BVME transporte ferroviario: Agente de Viajes: Tipo de documento', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1187, N'3158', N'El dato ingresado como Agente de Viajes-Tipo de documento no corresponde al valor esperado.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1188, N'3159', N'El XML no contiene el tag de BVME transporte ferroviario: Pasajero - Apellidos y Nombres', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1189, N'3160', N'El XML no contiene el tag de BVME transporte ferroviario: Pasajero - Tipo de documento de identidad', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1190, N'3161', N'El XML no contiene el tag de BVME transporte ferroviario: Servicio transporte: Ciudad o lugar de origen - Código de ubigeo', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1191, N'3162', N'El XML no contiene el tag de BVME transporte ferroviario: Servicio transporte: Ciudad o lugar de origen - Dirección detallada', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1192, N'3163', N'El XML no contiene el tag de BVME transporte ferroviario: Servicio transporte: Ciudad o lugar de destino - Código de ubigeo', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1193, N'3164', N'El XML no contiene el tag de BVME transporte ferroviario: Servicio transporte: Ciudad o lugar de destino - Dirección detallada', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1194, N'3165', N'El XML no contiene el tag de BVME transporte ferroviario: Servicio transporte:Número de asiento', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1195, N'3166', N'El XML no contiene el tag de BVME transporte ferroviario: Servicio transporte: Hora programada de inicio de viaje', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1196, N'3167', N'El XML no contiene el tag de BVME transporte ferroviario: Servicio transporte: Fecha programada de inicio de viaje', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1197, N'3168', N'El XML no contiene el tag de Carta Porte Aéreo:  Lugar de origen - Código de ubigeo', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1198, N'3169', N'El XML no contiene el tag de Carta Porte Aéreo:  Lugar de origen - Dirección detallada', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1199, N'3170', N'El XML no contiene el tag de Carta Porte Aéreo:  Lugar de destino - Código de ubigeo', 0)
GO
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1200, N'3171', N'El XML no contiene el tag de Carta Porte Aéreo:  Lugar de destino - Dirección detallada', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1201, N'3172', N'El XML no contiene tag de la Hora del concepto por linea.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1202, N'3173', N'El XML no contiene el tag de BVME transporte ferroviario: Servicio transporte: Forma de Pago', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1203, N'3174', N'El dato ingreso como Servicio transporte: Forma de Pago no corresponde al valor esperado (catalogo nro 59)', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1204, N'3175', N'El XML no contiene el tag de BVME transporte ferroviario: Servicio de transporte: Número de autorización de la transacción', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1205, N'3176', N'El XML no contiene el tag de Regalía Petrolera: Decreto Supremo de aprobación del contrato', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1206, N'3177', N'El XML no contiene el tag de Regalía Petrolera: Area de contrato (Lote)', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1207, N'3178', N'El XML no contiene el tag de Regalía Petrolera: Periodo de pago - Fecha de inicio', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1208, N'3179', N'El XML no contiene el tag de Regalía Petrolera: Periodo de pago - Fecha de fin', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1209, N'3180', N'El XML no contiene el tag de Regalía Petrolera: Fecha de Pago', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1210, N'3181', N'El dato ingresado como Codigo de producto SUNAT no corresponde al valor esperado para tipo de operación.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1211, N'3182', N'El XML no contiene el tag de Transportre Terreste - Número de asiento', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1212, N'3183', N'El XML no contiene el tag de Transporte Terrestre - Información de manifiesto de pasajeros', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1213, N'3184', N'El XML no contiene el tag de Transporte Terrestre - Número de documento de identidad del pasajero', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1214, N'3185', N'El XML no contiene el tag de Transporte Terrestre - Tipo de documento de identidad del pasajero', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1215, N'3186', N'El XML no contiene el tag de Transporte Terrestre - Nombres y apellidos del pasajero', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1216, N'3187', N'El XML no contiene el tag de Transporte Terrestre - Ciudad o lugar de destino - Dirección detallada', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1217, N'3188', N'El XML no contiene el tag de Transporte Terrestre - Ciudad o lugar de origen - Ubigeo', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1218, N'3189', N'El XML no contiene el tag de Transporte Terrestre - Ciudad o lugar de origen - Dirección detallada', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1219, N'3190', N'El XML no contiene el tag de Transporte Terrestre - Fecha de inicio programado', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1220, N'3191', N'El XML no contiene el tag de Transporte Terrestre - Hora de inicio programado', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1221, N'3192', N'El XML no contiene el tag de Total de anticipos', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1222, N'3193', N'El dato ingresado Total anticipos no corresponde para el tipo de operación', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1223, N'3194', N'Para los ajustes de operaciones de exportación solo es permitido registrar un documento que modifica.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1224, N'3195', N'El xml no contiene el tag de impuesto por linea (TaxtTotal).', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1225, N'3196', N'La sumatoria de impuestos globales no corresponde al monto total de impuestos.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1226, N'3197', N'El XML no contiene el tag de Transporte Terrestre - Ciudad o lugar de destino - Ubigeo', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1227, N'3198', N'La fecha de cierre no puede ser inferior a la fecha de inicio del cómputo del ciclo de facturación', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1228, N'3199', N'Si utiliza el estandar GS1 debe especificar el tipo de estructura GTIN', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1229, N'3200', N'El tipo de estructura GS1 no tiene un valor permitido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1230, N'3201', N'El código de producto GS1 no cumple el estandar', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1231, N'3202', N'El numero de RUC del receptor no existe.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1232, N'3203', N'El tipo de nota es un dato único', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1233, N'3204', N'El XML no contiene el tag de BVME transporte ferroviario: Pasajero - Número de documento de identidad', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1234, N'3205', N'Debe consignar el tipo de operación', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1235, N'3206', N'El dato ingresado como tipo de operación no corresponde a un valor esperado (catálogo nro. 51)', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1236, N'3207', N'Comprobante físico no se encuentra autorizado como comprobante de contingencia', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1237, N'3208', N'La moneda del monto de la detracción debe ser PEN', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1238, N'3209', N'El tipo de moneda de la nota debe ser el mismo que el declarado en el documento que modifica', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1239, N'3210', N'Solo debe consignar sistema de calculo si el tributo es ISC', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1240, N'3211', N'Falta identificador del pago del Monto de anticipo para relacionarlo con el comprobante que se realizo el  anticipo', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1241, N'3212', N'El comprobante contiene un identificador de pago repetido en los montos anticipados', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1242, N'3213', N'El comprobante contiene un pago anticipado pero no se ha consignado el documento que se realizo el anticipo', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1243, N'3214', N'No existe información del Monto Anticipado para el comprobante que se realizo el anticipo', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1244, N'3215', N'El comprobante contiene un identificador de pago repetido en los comprobantes que se realizo el anticipo', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1245, N'3216', N'Falta identificador del pago del comprobante para relacionarlo con el monto de  anticipo', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1246, N'3217', N'Debe consignar Numero de RUC del emisor del comprobante de anticipo', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1247, N'3218', N'El comprobante que se realizo el anticipo no existe', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1248, N'3219', N'El comprobante que se realizo el anticipo no se encuentra autorizado', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1249, N'3220', N'Si consigna montos de anticipo debe informar el Total de Anticipos', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1250, N'3221', N'El dato ingresado como codigo de tributo global es invalido para tipo de nota', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1251, N'3222', N'No existe información a nivel global de un tributo informado en la línea', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1252, N'3223', N'La combinación de tributos no es permitida', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1253, N'3224', N'Si existe ''Valor referencial unitario en operac. no onerosas'' con monto mayor a cero, la operacion debe ser gratuita (codigo de tributo 9996)', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1254, N'3225', N'La base imponible a nivel de línea difiere de la información consignada en el comprobante', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1255, N'3226', N'El resultado del monto del cargo o descuento global es incorrecto en base a la información consignada', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1256, N'3227', N'La sumatoria del Total del valor de venta más los impuestos no concuerda con la base imponible', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1257, N'4000', N'El documento ya fue presentado anteriormente.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1258, N'4001', N'El numero de RUC del receptor no existe.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1259, N'4002', N'Para el TaxTypeCode, esta usando un valor que no existe en el catalogo.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1260, N'4003', N'El comprobante fue registrado previamente como rechazado.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1261, N'4004', N'El DocumentTypeCode de las guias debe existir y tener 2 posiciones', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1262, N'4005', N'El DocumentTypeCode de las guias debe ser 09 o 31', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1263, N'4006', N'El ID de las guias debe tener informacion de la SERIE-NUMERO de guia.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1264, N'4007', N'El XML no contiene el ID de las guias.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1265, N'4008', N'El DocumentTypeCode de Otros documentos relacionados no cumple con el estandar.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1266, N'4009', N'El DocumentTypeCode de Otros documentos relacionados tiene valores incorrectos.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1267, N'4010', N'El ID de los documentos relacionados no cumplen con el estandar.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1268, N'4011', N'El XML no contiene el tag ID de documentos relacionados.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1269, N'4012', N'El ubigeo indicado en el comprobante no es el mismo que esta registrado para el contribuyente.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1270, N'4013', N'El RUC  del receptor no esta activo', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1271, N'4014', N'El RUC del receptor no esta habido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1272, N'4015', N'Si el tipo de documento del receptor no es RUC, debe tener operaciones de exportacion', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1273, N'4016', N'El total valor venta neta de oper. gravadas IGV debe ser mayor a 0.00 o debe existir oper. gravadas onerosas', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1274, N'4017', N'El total valor venta neta de oper. inafectas IGV debe ser mayor a 0.00 o debe existir oper. inafectas onerosas o de export.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1275, N'4018', N'El total valor venta neta de oper. exoneradas IGV debe ser mayor a 0.00 o debe existir oper. exoneradas', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1276, N'4019', N'El calculo del IGV no es correcto', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1277, N'4020', N'El ISC no esta informado correctamente', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1278, N'4021', N'Si se utiliza la leyenda con codigo 2000, el importe de percepcion debe ser mayor a 0.00', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1279, N'4022', N'Si se utiliza la leyenda con código 2001, el total de operaciones exoneradas debe ser mayor a 0.00', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1280, N'4023', N'Si se utiliza la leyenda con código 2002, el total de operaciones exoneradas debe ser mayor a 0.00', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1281, N'4024', N'Si se utiliza la leyenda con código 2003, el total de operaciones exoneradas debe ser mayor a 0.00', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1282, N'4025', N'Si usa la leyenda de Transferencia o Servivicio gratuito, todos los items deben ser  no onerosos', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1283, N'4026', N'No se puede indicar Guia de remision de remitente y Guia de remision de transportista en el mismo documento', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1284, N'4027', N'El importe total no coincide con la sumatoria de los valores de venta mas los tributos mas los cargos', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1285, N'4028', N'El monto total de la nota de credito debe ser menor o igual al monto de la factura', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1286, N'4029', N'El ubigeo indicado en el comprobante no es el mismo que esta registrado para el contribuyente', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1287, N'4030', N'El ubigeo indicado en el comprobante no es el mismo que esta registrado para el contribuyente', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1288, N'4031', N'Debe indicar el nombre comercial', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1289, N'4032', N'Si el código del motivo de emisión de la Nota de Credito es 03, debe existir la descripción del item', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1290, N'4033', N'La fecha de generación de la numeración debe ser menor o igual a la fecha de generación de la comunicación', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1291, N'4034', N'El comprobante fue registrado previamente como baja', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1292, N'4035', N'El comprobante fue registrado previamente como rechazado', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1293, N'4036', N'La fecha de emisión de los rangos debe ser menor o igual a la fecha de generación del resumen', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1294, N'4037', N'El calculo del Total de IGV del Item no es correcto', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1295, N'4038', N'El resumen contiene menos series por tipo de documento que el envío anterior para la misma fecha de emisión', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1296, N'4039', N'No ha consignado información del ubigeo del domicilio fiscal', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1297, N'4040', N'Si el importe de percepcion es mayor a 0.00, debe utilizar una leyenda con codigo 2000', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1298, N'4041', N'El codigo de pais debe ser PE', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1299, N'4042', N'Para tipo de operación se está usando un valor que no existe en el catálogo. Nro. 17.', 0)
GO
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1300, N'4043', N'Para el TransportModeCode, se está usando un valor que no existe en el catálogo Nro. 18.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1301, N'4044', N'PrepaidAmount: Monto total anticipado no coincide con la sumatoria de los montos por documento de anticipo.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1302, N'4045', N'No debe consignar los datos del transportista para la modalidad de transporte 02 – Transporte Privado.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1303, N'4046', N'No debe consignar información adicional en la dirección para los locales anexos.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1304, N'4047', N'sac:SUNATTransaction/cbc:ID debe ser igual a 10 o igual a 11 cuando ingrese información para sustentar el traslado.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1305, N'4048', N'cac:AdditionalDocumentReference/cbc:DocumentTypeCode - Contiene un valor no valido para documentos relacionado.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1306, N'4049', N'El numero de DNI del receptor no existe.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1307, N'4050', N'El numero de RUC del proveedor no existe.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1308, N'4051', N'El RUC del proveedor no esta activo.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1309, N'4052', N'El RUC del proveedor no esta habido.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1310, N'4053', N'Proveedor no debe ser igual al remitente o destinatario.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1311, N'4054', N'La guía no debe contener datos del proveedor.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1312, N'4055', N'El XML no contiene el atributo o no existe información en descripcion del motivo de traslado.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1313, N'4056', N'El XML no contiene el tag o no existe información en el tag SplitConsignmentIndicator.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1314, N'4057', N'GrossWeightMeasure – El dato ingresado no cumple con el formato establecido.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1315, N'4058', N'cbc:TotalPackageQuantity - El dato ingresado no cumple con el formato establecido.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1316, N'4059', N'Numero de bultos o pallets - información válida para importación.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1317, N'4060', N'La guía no debe contener datos del transportista.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1318, N'4061', N'El numero de RUC del transportista no existe.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1319, N'4062', N'El RUC del transportista no esta activo.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1320, N'4063', N'El RUC del transportista no esta habido.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1321, N'4064', N'/DespatchAdvice/cac:Shipment/cac:ShipmentStage/cac:TransportMeans/cbc:RegistrationNationalityID - El dato ingresado no cumple con el formato establecido.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1322, N'4065', N'cac:TransportMeans/cbc:TransportMeansTypeCode - El valor ingresado como tipo de unidad de transporte es incorrecta.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1323, N'4066', N'El numero de DNI del conductor no existe.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1324, N'4067', N'El XML no contiene el tag o no existe informacion del ubigeo del punto de llegada.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1325, N'4068', N'Direccion de punto de lllegada - El dato ingresado no cumple con el formato establecido.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1326, N'4069', N'CityName - El dato ingresado no cumple con el formato establecido.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1327, N'4070', N'District - El dato ingresado no cumple con el formato establecido.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1328, N'4071', N'Numero de Contenedor - El dato ingresado no cumple con el formato establecido.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1329, N'4072', N'Numero de contenedor - información válida para importación.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1330, N'4073', N'TransEquipmentTypeCode - El valor ingresado como tipo de contenedor es incorrecta.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1331, N'4074', N'Numero Precinto - El dato ingresado no cumple con el formato establecido.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1332, N'4075', N'El XML no contiene el tag o no existe informacion del ubigeo del punto de partida.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1333, N'4076', N'Direccion de punto de partida - El dato ingresado no cumple con el formato establecido.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1334, N'4077', N'CityName - El dato ingresado no cumple con el formato establecido.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1335, N'4078', N'District - El dato ingresado no cumple con el formato establecido.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1336, N'4079', N'Código de Puerto o Aeropuerto - El dato ingresado no cumple con el formato establecido.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1337, N'4080', N'Tipo de Puerto o Aeropuerto - El dato ingresado no cumple con el formato establecido.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1338, N'4081', N'El XML No contiene El tag o No existe información del Numero de orden del item.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1339, N'4082', N'Número de Orden del Ítem - El orden del ítem no cumple con el formato establecido.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1340, N'4083', N'Cantidad - El dato ingresado no cumple con el formato establecido.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1341, N'4084', N'Descripción del Ítem - El dato ingresado no cumple con el formato establecido.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1342, N'4085', N'Código del Ítem - El dato ingresado no cumple con el formato establecido.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1343, N'4086', N'El emisor y el cliente son Agentes de percepción de combustible en la fecha de emisión.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1344, N'4087', N'El Comprobante de Pago Electrónico no está Registrado en los Sistemas de la SUNAT.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1345, N'4088', N'El Comprobante de Pago no está autorizado en los Sistemas de la SUNAT.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1346, N'4089', N'La operación con este cliente está excluida del sistema de percepción. Es agente de retención.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1347, N'4090', N'La operación con este cliente está excluida del sistema de percepción. Es entidad exceptuada de la percepción.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1348, N'4091', N'La operación con este proveedor está excluida del sistema de retención. Es agente de percepción, agente de retención o buen contribuyente.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1349, N'4092', N'El nombre comercial del emisor no cumple con el formato establecido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1350, N'4093', N'El codigo de ubigeo del domicilio fiscal del emisor no es válido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1351, N'4094', N'La dirección completa y detallada del domicilio fiscal del emisor no cumple con el formato establecido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1352, N'4095', N'La urbanización del domicilio fiscal del emisor no cumple con el formato establecido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1353, N'4096', N'La provincia del domicilio fiscal del emisor no cumple con el formato establecido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1354, N'4097', N'El departamento del domicilio fiscal del emisor no cumple con el formato establecido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1355, N'4098', N'El distrito del domicilio fiscal del emisor no cumple con el formato establecido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1356, N'4099', N'El nombre comercial del cliente no cumple con el formato establecido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1357, N'4100', N'El ubigeo del cliente no cumple con el formato establecido o no es válido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1358, N'4101', N'La dirección completa y detallada del domicilio fiscal del cliente no cumple con el formato establecido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1359, N'4102', N'La urbanización del domicilio fiscal del cliente no cumple con el formato establecido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1360, N'4103', N'La provincia del domicilio fiscal del cliente no cumple con el formato establecido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1361, N'4104', N'El departamento del domicilio fiscal del cliente no cumple con el formato establecido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1362, N'4105', N'El distrito del domicilio fiscal del cliente no cumple con el formato establecido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1363, N'4106', N'El nombre comercial del proveedor no cumple con el formato establecido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1364, N'4107', N'El ubigeo del proveedor no cumple con el formato establecido o no es válido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1365, N'4108', N'La dirección completa y detallada del domicilio fiscal del proveedor no cumple con el formato establecido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1366, N'4109', N'La urbanización del domicilio fiscal del proveedor no cumple con el formato establecido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1367, N'4110', N'La provincia del domicilio fiscal del proveedor no cumple con el formato establecido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1368, N'4111', N'El departamento del domicilio fiscal del proveedor no cumple con el formato establecido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1369, N'4112', N'El distrito del domicilio fiscal del proveedor no cumple con el formato establecido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1370, N'4120', N'El XML no contiene o no existe informacion en el tag de  Información que sustenta el traslado.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1371, N'4121', N'Para el tipo de operación no se consigna el tag SUNATEmbededDespatchAdvice de Información de sustento de traslado.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1372, N'4122', N'Factura con información que sustenta el traslado, debe registrar leyenda 2008.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1373, N'4123', N'sac:SUNATEmbededDespatchAdvice - Para Factura Electrónica Remitente no se consigna datos en documento de referencia(cac:OrderReference).', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1374, N'4124', N'cac:Shipment - Para Factura Electrónica Remitente debe indicar sujeto que realiza el traslado de bienes (1: Vendendor o 2: Comprador).', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1375, N'4125', N'cac:Shipment - Para Factura Electrónica Remitente debe indicar modalidad de transporte para el sustento de traslado de bienes (cbc:TransportModeCode).', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1376, N'4126', N'cac:Shipment - Debe indicar fecha de inicio de traslado para el  sustento de traslado de bienes (cac:TransitPeriod/cbc:StartDate).', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1377, N'4127', N'cac:Shipment - Para Factura Electrónica Remitente debe indicar el punto de llegada para el sustento de traslado de bienes (cac:DeliveryAddrees).', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1378, N'4128', N'cac:Shipment - Para Factura Electrónica Remitente debe indicar el punto de partida para el sustento de traslado de bienes (cac:OriginAddress).', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1379, N'4129', N'sac:SUNATEmbededDespatchAdvice - Para Factura Electrónica Remitente no se consigna indicador de subcontratación (cbc:MarkAttentionIndicator).', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1380, N'4130', N'sac:SUNATEmbededDespatchAdvice - Para Factura Electrónica Remitente debe consignar datos en documento de referencia (cac:OrderReference).', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1381, N'4131', N'sac:SUNATEmbededDespatchAdvice - Para Factura Electrónica Transportista no se consigna destinatario para el sustento de traslado de bienes (cac:DeliveryCustomerParty).', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1382, N'4132', N'cac:Shipment - Para Factura Electrónica Transportista no se consigna sujeto que realiza el traslado (cbc:HandlingCode).', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1383, N'4133', N'Para Factura Electrónica Transportista no se consigna peso total de la factura para el sustento de traslado de bienes (cbc:GrossWeightMeasure).', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1384, N'4134', N'cac:Shipment - Para Factura Electrónica Transportista no se consigna modalidad de transporte para el sustento de traslado de bienes (cbc:TransportModeCode).', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1385, N'4135', N'cac:Shipment - Para Factura Electrónica Transportista no se consigna punto de llegada para el sustento de traslado de bienes (cac:DeliveryAddress).', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1386, N'4136', N'cac:Shipment - Para Factura Electrónica Transportista no se consigna punto de partida para el sustento de traslado de bienes (cac:OriginAddress).', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1387, N'4137', N'cac:OrderReference - Debe consignar número de  documento de referencia que sustenta el traslado (./cbc:ID).', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1388, N'4138', N'cac:OrderReference - Debe consignar tipo de documento de referencia que sustenta el traslado (./cbc:OrderTypeCode).', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1389, N'4139', N'cac:OrderReference - Tipo de documento de referencia que sustenta el traslado no válido (01 – Factura o 09 – Guía de Remisión).', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1390, N'4140', N'cac:OrderReference - Serie-Numero ingresado en documento de referencia que sustenta el traslado no cumple con el formato establecido.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1391, N'4141', N'cac:OrderReference - Debe consignar RUC emisor del documento de referencia que sustenta el traslado (./cac:DocumentReference/cac:IssuerParty/cac:PartyIdentification/cbc:ID).', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1392, N'4142', N'cac:OrderReference -  RUC emisor del documento de referencia que sustenta el traslado no cumple con el formato establecido.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1393, N'4143', N'cac:OrderReference – RUC Emisor de documento de referencia que sustenta el traslado no existe o se encuentra dado de baja.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1394, N'4144', N'cac:OrderReference – Documento de Referencia ingresado no corresponde a un comprobante electrónico declarado y activo en SUNAT.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1395, N'4145', N'cac:OrderReference – Documento de Referencia ingresado no corresponde comprobante autorizado por SUNAT.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1396, N'4146', N'cac:OrderReference - Nombre o razon social del emisodr de referencia que sustenta el traslado de bienes no cumple con un formato válido.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1397, N'4147', N'cac:DeliveryCustomerParty - Debe consignar numero de documento de identidad del destinatario (cbc:CustomerAssignedAccountID).', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1398, N'4148', N'cac:DeliveryCustomerParty - Debe consignar tipo de documento de identidad del destinatario (cbc:CustomerAssignedAccountID/@schemeID).', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1399, N'4149', N'cac:DeliveryCustomerParty - Tipo de documento de identidad del destinatario no válido (Catálogo N° 06).', 0)
GO
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1400, N'4150', N'cac:DeliveryCustomerParty - Numero de documento de identidad del destinatario no cumple con un formato válido.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1401, N'4151', N'cac:DeliveryCustomerParty - Debe consignar apellidos y nombres, denominación o razón social del destinatario (cac:Party/cac:PartyLegalEntity/cbc:RegistrationName).', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1402, N'4152', N'cac:DeliveryCustomerParty - Nombre o razon social del destinatario no cumple con un formato válido.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1403, N'4153', N'cbc:HandlingCode - Sujeto que realiza el traslado no es valido.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1404, N'4154', N'cbc:GrossWeightMeasure@unitCode: El valor ingresado en la unidad de medida para el peso bruto total no es correcta (KGM).', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1405, N'4155', N'GrossWeightMeasure – El valor ingresado no cumple con el estandar.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1406, N'4156', N'Debe ingresar la totalidad de la información requerida al transportista.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1407, N'4157', N'No existe información en el tag datos de conductores.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1408, N'4158', N'No existe información en el tag datos de vehículos.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1409, N'4159', N'No es necesario consignar los datos del transportista para una operación de Transporte Privado.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1410, N'4160', N'cac:CarrierParty: Debe consignar número de  documento de identidad del transportista.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1411, N'4161', N'cac:CarrierParty: Debe consignar tipo de documento de identidad del transportista.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1412, N'4162', N'cac:CarrierParty: Tipo de documento de identidad del transportista no válido (06 - RUC).', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1413, N'4163', N'cac:CarrierParty: Numero de documento de identidad del transportista no cumple con un formato válido.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1414, N'4164', N'cac:CarrierParty: Debe consignar apellidos y nombres, denominación o razón social del transportista.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1415, N'4165', N'cac:CarrierParty: nombre o razon social del transportista no cumple con un formato válido.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1416, N'4166', N'cac: TransportHandlingUnit: Numero de placa (cbc:ID) no coincide con el numero de placa del vehiculo prinicipal.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1417, N'4167', N'cac:RoadTransport/cbc:LicensePlateID: Numero de placa del vehículo no cumple con el formato válido.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1418, N'4168', N'cac: TransportHandlingUnit: Numero de placa del vehículo principal no existe o no cumple con el formato válido (cbc:ID).', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1419, N'4169', N'cac:TransportEquipment: debe consignar al menos un vehiculo secundario.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1420, N'4170', N'cac:TransportEquipment: Numero de placa del vehículo secundario no existe o no cumple con el formato válido (cbc:ID).', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1421, N'4171', N'cac:DriverPerson: Debe consignar número de  documento de identidad del conductor (cbc:ID).', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1422, N'4172', N'cac:DriverPerson: Debe consignar tipo de documento de identidad del conductor (cbc:ID/@schemeID).', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1423, N'4173', N'cac:DriverPerson: Tipo de documento de identidad del conductor no válido (Catalogo Nro 06).', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1424, N'4174', N'cac:DriverPerson: Numero de documento de identidad del conductor no cumple con el formato válido.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1425, N'4175', N'cac:DeliveryAddress: Debe consignar código de ubigeo de punto de llegada (cbc:ID).', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1426, N'4176', N'El dato ingresado como código de ubigeo de punto de llegada no corresponde a un valor esperado (catalogo nro 13).', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1427, N'4177', N'cac:DeliveryAddress: Debe consignar código de ubigeo válido (Catálogo N° 13).', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1428, N'4178', N'cac:DeliveryAddress: Debe consignar Dirección del punto de llegada (cbc:StreetName).', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1429, N'4179', N'cac:DeliveryAddress: Dirección completa y detallada del punto de llegada no cumple con el formato válido.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1430, N'4180', N'cac:OriginAddress: Debe consignar código de ubigeo de punto de partida (cbc:ID).', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1431, N'4181', N'El dato ingresado como código de ubigeo de punto de partida no corresponde a un valor esperado (catalogo nro 13).', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1432, N'4182', N'cac:OriginAddress: Debe consignar código de ubigeo válido (Catálogo N° 13).', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1433, N'4183', N'cac:OriginAddress: Debe consignar Dirección detallada del punto de partida (cbc:StreetName).', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1434, N'4184', N'cac:OriginAddres: Dirección completa y detallada del punto de partida no cumple con el estandar.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1435, N'4185', N'cac:OrderReference - Serie y numero no se encuentra registrado como baja por cambio de destinatario.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1436, N'4186', N'cbc:Note - El campo observaciones supera la cantidad maxima especificada (250 carácteres).', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1437, N'4187', N'cac:OrderReference - El campo Tipo de documento (descripción) supera la cantidad maxima especificada (50 carácteres).', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1438, N'4188', N'El XML no contiene el atributo o no existe información del nombre o razon social del tercero relacionado.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1439, N'4189', N'El valor ingresado como tipo de documento del nombre o razon social del tercero relacionado es incorrecto.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1440, N'4190', N'El valor ingresado como descripcion de motivo de traslado no cumple con el estandar.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1441, N'4191', N'Para el motivo de traslado, no se consigna información en el numero de DAM.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1442, N'4192', N'Para el motivo de traslado, no se consigna información del manifiesto de carga.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1443, N'4193', N'El valor ingresado como indicador de transbordo programado no cumple con el estandar.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1444, N'4194', N'El XML no contiene el atributo o no existe información en peso bruto total de la guia.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1445, N'4195', N'Numero de bultos o pallets es una información válida solo para importación.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1446, N'4196', N'La fecha de recepción en SUNAT es mayor a 1 hora(s) respecto a la fecha de comprobación por OSE', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1447, N'4197', N'IssueTime - El dato ingresado  no cumple con el patrón hh:mm:ss.sssss', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1448, N'4200', N'Debe corresponder a algún valor válido establecido en el catálogo 13', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1449, N'4201', N'EL monto del ISC se debe detallar a nivel de línea', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1450, N'4207', N'El DNI debe tener 8 caracteres numéricos', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1451, N'4208', N'El dato ingresado como numero de documento de identidad del receptor no cumple con el formato establecido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1452, N'4230', N'el Comprobante no debió ser observado.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1453, N'4231', N'El código de Ubigeo no existe en el listado.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1454, N'4232', N'La sumatoria de los IGV de línea no corresponden al total', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1455, N'4233', N'El dato ingresado en order de compra no cumple con el formato establecido.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1456, N'4234', N'El código de producto no cumple con el formato establecido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1457, N'4235', N'No existe información en el nombre del concepto.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1458, N'4236', N'El dato ingresado como direccion completa y detallada no cumple con el formato establecido.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1459, N'4237', N'La tasa del tributo de la línea no corresponde al valor esperado', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1460, N'4238', N'El dato ingresado como urbanización no cumple con el formato establecido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1461, N'4239', N'El dato ingresado como provincia no cumple con el formato establecido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1462, N'4240', N'El dato ingresado como departamento no cumple con el formato establecido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1463, N'4241', N'El dato ingresado como distrito no cumple con el formato establecido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1464, N'4242', N'El dato ingresado como local anexo no cumple con el formato establecido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1465, N'4243', N'Si se utiliza la leyenda con código 2007, el total de operaciones exoneradas debe ser mayor a 0.00', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1466, N'4244', N'Si se utiliza la leyenda con código 2008, el total de operaciones exoneradas debe ser mayor a 0.00', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1467, N'4245', N'El dato ingresado como tipo de operación no corresponde a un valor esperado (catálogo nro. 51)', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1468, N'4246', N'El comprobante contiene un identificador de pago repetido en los anticipos', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1469, N'4247', N'El comprobante contiene un identificador de pago no relacionado a un documento de anticipo', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1470, N'4248', N'El comprobante contiene mas de un documento de anticipo relacionado al mismo identificador de pago.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1471, N'4249', N'El código de motivo de traslado no existe en el listado (catalogo nro. 20)', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1472, N'4250', N'El dato ingresado como schemeAgencyName es incorrecto.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1473, N'4251', N'El dato ingresado como atributo @listAgencyName es incorrecto.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1474, N'4252', N'El dato ingresado como atributo @listName es incorrecto.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1475, N'4253', N'El dato ingresado como atributo @listURI es incorrecto.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1476, N'4254', N'El dato ingresado como atributo @listID es incorrecto.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1477, N'4255', N'El dato ingresado como atributo @schemeName es incorrecto.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1478, N'4256', N'El dato ingresado como atributo @schemeAgencyName es incorrecto.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1479, N'4257', N'El dato ingresado como atributo @schemeURI es incorrecto.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1480, N'4258', N'El dato ingresado como atributo @unitCodeListID es incorrecto.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1481, N'4259', N'El dato ingresado como atributo @unitCodeListAgencyName es incorrecto.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1482, N'4260', N'El dato ingresado como atributo @name es incorrecto.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1483, N'4261', N'El dato ingresado como atributo @listSchemeURI es incorrecto.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1484, N'4262', N'El XML no contiene el atributo o no existe lugar donde se entrega el bien para venta itinerante', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1485, N'4263', N'Si no es una venta itinerante, no corresponde consignar lugar donde se entrega el bien ', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1486, N'4264', N'El XML no contiene el codigo de leyenda 2007 para el tipo de operación IVAP', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1487, N'4265', N'El XML no contiene el codigo de leyenda 2006 para tipo de operación de detracciones', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1488, N'4266', N'El XML no contiene el codigo de leyenda 2005 para el tipo de operación Venta itinerante', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1489, N'4267', N'El dato ingresado como codigo de producto GS1 no cumple con el formato establecido', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1490, N'4268', N'El dato ingresado como cargo/descuento no es valido a nivel de ítem.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1491, N'4269', N'El dato ingresado como codigo de producto no cumple con el formato establecido.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1492, N'4270', N'El dato ingresado como detalle del viaje no cumple con el formato establecido.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1493, N'4271', N'El dato ingresado como descripcion del tramo no cumple con el formato establecido.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1494, N'4272', N'El dato ingresado como valor refrencia del tramo virtual no cumple con el formato establecido.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1495, N'4273', N'El dato ingresado como configuración vehicular no cumple con el formato establecido.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1496, N'4274', N'El dato ingresado como tipo de carga util es incorrecto.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1497, N'4275', N'El XML no contiene el tag o no existe información del valor de la carga en TM.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1498, N'4276', N'El dato ingresado como valor de la carga en TM cumple con el formato establecido.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1499, N'4277', N'El dato ingresado como unidad de medida de la carga  del vehiculo no corresponde al valor esperado.', 0)
GO
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1500, N'4278', N'El dato ingresado como valor referencial de carga util nominal no cumple con el formato establecido.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1501, N'4279', N'El dato ingresado como codigo de identificación de concepto tributario no es valido (catalogo nro 55)', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1502, N'4280', N'El dato ingresado como valor del concepto de la linea no cumple con el formato establecido.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1503, N'4281', N'El dato ingresado como cantidad del concepto de la linea no cumple con el formato establecido.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1504, N'4282', N'La fecha de ingreso al establecimiento es mayor a la fecha de salida al establecimiento.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1505, N'4283', N'El dato ingresado como atributo @schemeID es incorrecto.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1506, N'4284', N'El cargo/descuento consignado no es permitido para el tipo de comprobante.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1507, N'4285', N'El emisor a la fecha no se encuentra registrado ó habilitado con la condición de Agente de percepción', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1508, N'4286', N'Si ha consignado Transporte Publico, debe consignar Datos del transportista.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1509, N'4287', N'El precio unitario de la operación que está informando difiere de los cálculos realizados en base a la información remitida', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1510, N'4288', N'El valor de venta por ítem difiere de los importes consignados.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1511, N'4289', N'El valor de cargo/descuento por ítem difiere de los importes consignados.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1512, N'4290', N'El cálculo del IGV es Incorrecto', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1513, N'4291', N'El dato ingresado como cargo/descuento no es valido a nivel global.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1514, N'4292', N'La Versión del UBL 2.0 se aceptará solo hasta el 31 de diciembre de 2018', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1515, N'4293', N'El importe total de impuestos por línea no coincide con la sumatoria de los impuestos por línea.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1516, N'4294', N'La base imponible a nivel de línea difiere de la información consignada en el comprobante', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1517, N'4295', N'La sumatoria del total valor de venta - Exportaciones de línea no corresponden al total', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1518, N'4296', N'La sumatoria del total valor de venta - operaciones inafectas de línea no corresponden al total', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1519, N'4297', N'La sumatoria del total valor de venta - operaciones exoneradas de línea no corresponden al total', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1520, N'4298', N'La sumatoria del total valor de venta - operaciones gratuitas de línea no corresponden al total', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1521, N'4299', N'La sumatoria del total valor de venta - operaciones gravadas de línea no corresponden al total', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1522, N'4300', N'La sumatoria del total valor de venta - IVAP de línea no corresponden al total', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1523, N'4301', N'La sumatoria de impuestos globales no corresponde al monto total de impuestos.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1524, N'4302', N'El importe del IVAP no corresponden al determinado por la informacion consignada.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1525, N'4303', N'La sumatoria del total valor de venta - ISC de línea no corresponden al total', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1526, N'4304', N'La sumatoria del total valor de venta - Otros tributos de pago de línea no corresponden al total', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1527, N'4305', N'La sumatoria del total del importe del tributo ISC de línea no corresponden al total', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1528, N'4306', N'La sumatoria del total del importe del tributo Otros tributos de línea no corresponden al total', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1529, N'4307', N'La sumatoria consignados en descuentos globales no corresponden al total.', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1530, N'4308', N'La sumatoria consignados en cargos globales no corresponden al total', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1531, N'4309', N'La sumatoria de valor de venta no corresponde a los importes consignados', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1532, N'4310', N'La sumatoria del Total del valor de venta más los impuestos no concuerda con la base imponible', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1533, N'4311', N'La sumatoria de los IGV de operaciones gratuitas de la línea (codigo tributo 9996) no corresponden al total', 0)
INSERT [dbo].[CatalogoErrorSunat] ([IdCatalogo], [codigoRespuesta], [Descripcion], [Reintentar]) VALUES (1534, N'4312', N'El importe total del comprobante no coincide con el valor calculado', 0)
SET IDENTITY_INSERT [dbo].[CatalogoErrorSunat] OFF
SET IDENTITY_INSERT [dbo].[Configuracion] ON 

INSERT [dbo].[Configuracion] ([Id], [Servicio], [Codigo], [Valor]) VALUES (1, N'SWINSE', N'TempCDR', N'C:\Facturacion\Temporales\CDR')
INSERT [dbo].[Configuracion] ([Id], [Servicio], [Codigo], [Valor]) VALUES (2, N'SWINEC', N'TempENVIO', N'C:\Facturacion\Temporales\XML')
INSERT [dbo].[Configuracion] ([Id], [Servicio], [Codigo], [Valor]) VALUES (3, N'SWINPDF', N'TempPdf', N'C:\Facturacion\Temporales\PDF')
SET IDENTITY_INSERT [dbo].[Configuracion] OFF
SET IDENTITY_INSERT [dbo].[Empresa] ON 

INSERT [dbo].[Empresa] ([IdEmpresa], [TipoDocumentoIdentidad], [NumeroDocumentoIdentidad], [RazonSocial], [NombreComercial], [Direccion], [Departamento], [Provincia], [Distrito], [Urbanizacion], [CodigoUbigeo], [PaginaWeb], [CodigoDomicilioFiscal], [CodigoPais], [ContactoNombre], [ContactoCorreo], [ContactoTelefono]) VALUES (4, N'6', N'20112811096', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'')
SET IDENTITY_INSERT [dbo].[Empresa] OFF
SET IDENTITY_INSERT [dbo].[TipoRespuesta] ON 

INSERT [dbo].[TipoRespuesta] ([IdTipoRespuesta], [Codigo], [Descripcion]) VALUES (1, 0, N'Aceptado')
INSERT [dbo].[TipoRespuesta] ([IdTipoRespuesta], [Codigo], [Descripcion]) VALUES (2, 1, N'Rechazado')
INSERT [dbo].[TipoRespuesta] ([IdTipoRespuesta], [Codigo], [Descripcion]) VALUES (3, 2, N'Excepcion')
INSERT [dbo].[TipoRespuesta] ([IdTipoRespuesta], [Codigo], [Descripcion]) VALUES (4, 3, N'Aceptado con observaciones')
SET IDENTITY_INSERT [dbo].[TipoRespuesta] OFF
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
/****** Object:  StoredProcedure [dbo].[sp_RepresentacionImpresaInsert]    Script Date: 9/02/2019 17:01:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_RepresentacionImpresaInsert]
@IdComprobante bigint,
@NombreRepresentacionImpresa varchar(50),
@Archivo  varbinary(max)
AS

IF not exists(select 1 from RepresentacionImpresa with (nolock) where IdComprobante=@IdComprobante)
BEGIN
	insert into RepresentacionImpresa(IdComprobante,NombreRepresentacionImpresa,Archivo,FechaRegistro)
	VALUES(@IdComprobante,@NombreRepresentacionImpresa,@Archivo,GETDATE())
END
GO
/****** Object:  StoredProcedure [dbo].[sp_RepresentacionImpresaPendiente]    Script Date: 9/02/2019 17:01:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[sp_RepresentacionImpresaPendiente]
AS
declare @Ruta varchar(500)
SET @Ruta=(select Valor from Configuracion where Codigo='TempPdf')
select c.IdComprobante,c.TipoComprobante,pp.ArchivoXML,pp.NombreXML,pp.CodigoQR,@Ruta as Ruta
from Comprobante c with (nolock)
cross apply(select p.ArchivoXML,p.NombreXML,p.CodigoQR from ComprobanteDocumento p with (nolock) where p.IdComprobante=c.IdComprobante) pp
where not exists(select IdComprobante from RepresentacionImpresa r with (nolock) where r.IdComprobante=c.IdComprobante)
GO
/****** Object:  StoredProcedure [dbo].[usp_ComprobantesPendientesDeEnvio]    Script Date: 9/02/2019 17:01:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[usp_ComprobantesPendientesDeEnvio]
as
begin
	select e.NumeroDocumentoIdentidad, c.IdComprobante, c.TipoComprobante, c.SerieNumero from PendienteEnvio p
	inner join Comprobante c on p.IdComprobante = c.IdComprobante
	inner join Empresa e on c.IdEmpresa = e.IdEmpresa
	where 
			TipoDocumento = 'CO' 
		and Estado = 1
	order by Prioridad desc
end

GO
/****** Object:  StoredProcedure [dbo].[usp_InsertarCdrPendiente]    Script Date: 9/02/2019 17:01:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_InsertarCdrPendiente]
	@IdComprobante bigint,
	@Archivo varbinary(max)
as
begin
	set nocount on
	begin transaction
	declare @MensajeRetorno VARCHAR(MAX)

	begin try
		insert into CDRSunatPendiente values (@IdComprobante, @Archivo, GETDATE())
		delete from PendienteEnvio where IdComprobante = @IdComprobante
		commit transaction
	end try
	begin catch
		rollback transaction
		set @MensajeRetorno =  error_message()
		raiserror(@MensajeRetorno, 16, 1) 
	end catch
end

GO
/****** Object:  StoredProcedure [dbo].[usp_InsertarComprobante]    Script Date: 9/02/2019 17:01:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[usp_InsertarComprobante]
(
	@NroDocumentoIdentidadEmisor varchar(30),
	@TipoDocumentoIdentidad varchar(2),
	@NroDocumentoIdentidad varchar(30),
	@RazonSocial varchar(500),
	@TipoComprobante varchar(2),
	@SerieNumero varchar(13),
	@FechaEmison varchar(10),
	@CorreoElectronico varchar(500),
	@TotalImpuesto decimal(12,2),
	@TotalValorVenta decimal(12,2),
	@TotalPrecioVenta decimal(12,2),
	@TotalDescuento decimal(12,2),
	@TotalCargo decimal(12,2),
	@ImporteTotal decimal(12,2),
	@FechaVencimiento varchar(50),
	@HoraEmision varchar(8),
	@Moneda varchar(5),
	@TipoOperacion varchar(4),
	@NombreXML varchar(50),
	@ArchivoXML varbinary(max),
	@CodigoHash varchar(max),
	@CodigoQR varchar(max),	
	@CodigoTributo1001 varchar(4),
	@MontoOperaciones1001 decimal(12,2),
	@MontoTotalImpuesto1001 decimal(12,2),
	@SerieNumeroDocumentoSustento varchar(30) = '',
	@CodigoAnulacionDocumentoSustento varchar(10) = '',
	@MotivoAnulacionDocumentoSustento varchar(500) = '',
	@ComprobanteReferenciaNota dbo.TypeComprobanteReferenciaNota readonly
)
AS
BEGIN
	
	DECLARE @IdEmpresa INT, @MensajeRetorno VARCHAR(MAX), @IdComprobante BIGINT, @FechaRegistro DATETIME
	SELECT @IdEmpresa = IdEmpresa FROM dbo.Empresa WHERE NumeroDocumentoIdentidad = @NroDocumentoIdentidadEmisor
	
	SET @FechaRegistro = GETDATE()

	BEGIN TRANSACTION

	BEGIN TRY
		IF ISNULL(@IdEmpresa, 0) = 0
		BEGIN
			SET @MensajeRetorno = 'La empresa emisora con número de documento de identidad ' + @NroDocumentoIdentidadEmisor + ' no se encuentra registrada.'
			RAISERROR(@MensajeRetorno, 16, 1) 
		END

		--BEGIN TRY
		--	INSERT INTO dbo.ControlRegistro (IdEmpresa, TipoComprobante, SerieNumero, FechaRegistro)
		--	VALUES (@IdEmpresa, @TipoComprobante, @SerieNumero, GETDATE())
		--END TRY
		--BEGIN CATCH
		--	SET @MensajeRetorno = 'El comprobante ' + @SerieNumero + ' se encuentra en proceso de registro.'
		--	RAISERROR(@MensajeRetorno, 16, 1) 
		--END CATCH

		IF EXISTS (SELECT 1 FROM dbo.Comprobante C WITH(NOLOCK) WHERE C.IdEmpresa = @IdEmpresa AND C.TipoComprobante = @TipoComprobante AND C.SerieNumero = @SerieNumero)
		BEGIN
			SET @MensajeRetorno = 'El comprobante ' + @SerieNumero + ' ya se encuentra registrado en la base de datos.'
			RAISERROR(@MensajeRetorno, 16, 1) 
		END

		INSERT INTO [dbo].[Comprobante]
			([IdEmpresa], [TipoDocumentoIdentidad], [NroDocumentoIdentidad], [RazonSocial], [TipoComprobante], [SerieNumero], [FechaEmison]
			,[CorreoElectronico], [TotalImpuesto], [TotalValorVenta], [TotalPrecioVenta], [TotalDescuento], [TotalCargo], [ImporteTotal]
			,[FechaVencimiento], [HoraEmision], [Moneda], [TipoOperacion], [FechaRegistro])
		VALUES
			(@IdEmpresa, @TipoDocumentoIdentidad, @NroDocumentoIdentidad, @RazonSocial, @TipoComprobante, @SerieNumero, @FechaEmison,
			@CorreoElectronico, @TotalImpuesto, @TotalValorVenta, @TotalPrecioVenta, @TotalDescuento, @TotalCargo, @ImporteTotal,
			@FechaVencimiento, @HoraEmision, @Moneda, @TipoOperacion, @FechaRegistro)

		SET @IdComprobante = SCOPE_IDENTITY()

		INSERT INTO [dbo].[ComprobanteDocumento]
			([IdComprobante], [NombreXML], [ArchivoXML], [CodigoHash], [CodigoQR], [FechaRegistro])
		VALUES
			(@IdComprobante, @NombreXML, @ArchivoXML, @CodigoHash, @CodigoQR, @FechaRegistro)
		
		INSERT INTO PendienteEnvio (IdComprobante, Estado, Prioridad, TipoDocumento, FechaRegistro)
		VALUES (@IdComprobante, 1, 1, 'CO', GETDATE())

		INSERT INTO ComprobanteMontos (IdComprobante, CodigoTributo, MontoOperaciones, MontoTotalImpuesto)
		VALUES (@IdComprobante, @CodigoTributo1001, @MontoOperaciones1001, @MontoTotalImpuesto1001) 

		IF @CodigoAnulacionDocumentoSustento <> ''
		BEGIN
			INSERT INTO ComprobanteSustentoNota (IdComprobante, SerieNumero, MotivoAnulacion, CodigoAnulacion)
			VALUES (@IdComprobante, @SerieNumeroDocumentoSustento, @MotivoAnulacionDocumentoSustento, @CodigoAnulacionDocumentoSustento)
		END

		INSERT INTO ComprobanteReferenciaNota (IdComprobante, SerieNumero, TipoComprobante, FechaEmision)
		SELECT @IdComprobante, SerieNumero, TipoComprobante, FechaEmision FROM @ComprobanteReferenciaNota

		-- DELETE FROM dbo.ControlRegistro WHERE IdEmpresa = @IdEmpresa AND TipoComprobante = @TipoComprobante AND SerieNumero = @SerieNumero
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		-- DELETE FROM dbo.ControlRegistro WHERE IdEmpresa = @IdEmpresa AND TipoComprobante = @TipoComprobante AND SerieNumero = @SerieNumero
		ROLLBACK TRANSACTION
		SET @MensajeRetorno =  ERROR_MESSAGE()
		RAISERROR(@MensajeRetorno, 16, 1) 
	END CATCH
END

GO
/****** Object:  StoredProcedure [dbo].[usp_ListaCDRPendiente]    Script Date: 9/02/2019 17:01:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_ListaCDRPendiente]
as
select IdComprobante,Archivo,FechaRegistro
from CDRSunatPendiente with (nolock)

GO
/****** Object:  StoredProcedure [dbo].[usp_ListaConfiguracion]    Script Date: 9/02/2019 17:01:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_ListaConfiguracion] --'TempCDR'
@codigo varchar(10)
as
select codigo,valor from Configuracion with (nolock)
where codigo=case when len(@codigo)>0 then @codigo else codigo end

GO
/****** Object:  StoredProcedure [dbo].[usp_ObtenerArchivoComprobante]    Script Date: 9/02/2019 17:01:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_ObtenerArchivoComprobante]
	@IdComprobante bigint
as
begin
	set nocount on
	select IdComprobante, NombreXML, ArchivoXML from dbo.ComprobanteDocumento
	where IdComprobante = @IdComprobante
end

GO
/****** Object:  StoredProcedure [dbo].[usp_QuitarPendienteEnvio]    Script Date: 9/02/2019 17:01:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_QuitarPendienteEnvio]
	@idComprobante bigint,
	@codigoRespuesta varchar(20)
as
begin
	declare @reintentar int
	select @reintentar = Reintentar from CatalogoErrorSunat where CodigoRespuesta = @codigoRespuesta

	set @reintentar = isnull(@reintentar, 0)
	-- deshabilitamos el reintento
	if @reintentar = 1
	begin 
		update PendienteEnvio set Estado = 0 where IdComprobante = @idComprobante
	end

	select @reintentar Reintentar
end

GO
/****** Object:  StoredProcedure [dbo].[usp_RegistraRespuestaSUNAT]    Script Date: 9/02/2019 17:01:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_RegistraRespuestaSUNAT]
@CodigoSUNAT varchar(50),
@IdComprobante bigint,
@Archivo varbinary(max),
@Descripcion varchar(max),
@FechaSunat varchar(20),
@HoraSunat varchar(20)
as
/*
Del 0100 al 1999 Excepciones
Del 2000 al 3999 Errores que generan rechazo
Del 4000 en adelante Observaciones
*/
declare @temp table(Id bigint)

declare @IdMax bigint
DECLARE @IdCatalogo bigint
DECLARE @Respuesta bigint
DECLARE @TipoRespuesta bigint
DECLARE @IdTipoRespuesta bigint

 

--registrando un nuevo error
IF not exists(select 1 from CatalogoErrorSunat where codigoRespuesta=@CodigoSUNAT)
BEGIN
   INSERT INTO CatalogoErrorSunat(codigoRespuesta,Descripcion,Reintentar) VALUES(@CodigoSUNAT,@Descripcion,0)
END

SET @IdCatalogo=(select IdCatalogo from CatalogoErrorSunat where codigoRespuesta=@CodigoSUNAT)
--Clasificar el tipo de respuesta
SET @Respuesta=convert(bigint,@CodigoSUNAT)

if (@Respuesta=0)  SET @TipoRespuesta=0
if (@Respuesta>=100 and @Respuesta<=1999)  SET @TipoRespuesta=2
if (@Respuesta>=2000 and @Respuesta<=3999)  SET @TipoRespuesta=1
if (@Respuesta>=4000)  SET @TipoRespuesta=3

SET @IdTipoRespuesta=(select IdTipoRespuesta from TipoRespuesta where Codigo=@Respuesta)

--Registrando la ultima respuesta
if not exists(select 1 from ComprobanteRespuesta where IdComprobante=@IdComprobante)
	BEGIN
       insert into ComprobanteRespuesta(IdComprobante,IdCatalogo,DescripcionSUNAT,IdTipoRespuesta,FechaRegistro,FechaSUNAT,HoraSUNAT)
	   VALUES(@IdComprobante,@IdCatalogo,@Descripcion,@IdTipoRespuesta,GETDATE(),@FechaSunat,@HoraSunat)
	END
ELSE
BEGIN
	update comprobanteRespuesta set IdCatalogo=@IdCatalogo,DescripcionSUNAT=@Descripcion,IdTipoRespuesta=@IdTipoRespuesta,FechaRegistro=GETDATE(),FechaSUNAT=@FechaSunat,HoraSUNAT=@HoraSunat
	where IdComprobante=@IdComprobante    
END
--Registrando el historial de respuesta
insert into CDRSunatProcesado(Archivo,FechaRegistro) OUTPUT INSERTED.IdArchivo into @temp(Id)
values(@Archivo,getdate())

SET @IdMax=(select Id from @temp)

insert into ComprobanteRespuestaHistorial(IdArchivo,IdCatalogo,Descripcion,FechaRespuestaSunat,FechaRegistro,HoraRespuestaSunat,IdComprobante)
values(@IdMax,@IdCatalogo,@Descripcion,@FechaSunat,getdate(),@HoraSunat,@IdComprobante)
--Eliminado de la tabla pendientes
delete from CDRSunatPendiente where IdComprobante=@IdComprobante

GO
