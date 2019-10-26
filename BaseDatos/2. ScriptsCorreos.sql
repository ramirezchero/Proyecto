use FacturacionElectronicaDB
go

if object_id('ComprobanteCorreo', 'U') is not null
	drop table ComprobanteCorreo
go
create table ComprobanteCorreo
(
	IdComprobante bigint not null,
	De varchar(1000),
	Para varchar(1000),
	Asunto varchar(2000),
	FechaRegistro datetime,
	FechaEnvio datetime,
	Estado smallint, -- 0: Pendiente, 1: En proceso, 2: Enviado, 3: Error
	MensajeProceso varchar(2000),
	constraint PK_ComprobanteCorreo primary key (IdComprobante),
	constraint FK_ComprobanteCorreo_Comprobante foreign key (IdComprobante) references Comprobante(IdComprobante)  
)
go

if object_id('usp_RegistrarComprobanteCorreo', 'P') is not null
	drop procedure usp_RegistrarComprobanteCorreo
go
create procedure usp_RegistrarComprobanteCorreo
	@IdComprobante bigint,
	@De varchar(1000),
	@Para varchar(1000),
	@Asunto varchar(2000)
as
begin
	insert into ComprobanteCorreo (IdComprobante, De, Para, FechaRegistro, Estado, Asunto)
	values (@IdComprobante, @De, @Para, GETDATE(), 0, @Asunto)
end
go

if object_id('usp_ActualizarEstadoComprobanteCorreo', 'P') is not null
	drop procedure usp_ActualizarEstadoComprobanteCorreo
go
create procedure usp_ActualizarEstadoComprobanteCorreo
	@IdComprobante bigint,
	@Estado smallint,
	@MensajeProceso varchar(2000)
as
begin
	update ComprobanteCorreo set Estado = @Estado where IdComprobante = @IdComprobante

	if @Estado = 2
		update ComprobanteCorreo set FechaEnvio = GETDATE(), MensajeProceso = @MensajeProceso 
		where IdComprobante = @IdComprobante

	if @Estado = 3
		update ComprobanteCorreo set MensajeProceso = @MensajeProceso 
		where IdComprobante = @IdComprobante
end
go

if object_id('usp_ObtenerPDFyXMLporComprobante', 'P') is not null
	drop procedure usp_ObtenerPDFyXMLporComprobante
go
create procedure usp_ObtenerPDFyXMLporComprobante
	@IdComprobante bigint
as
begin
	select cd.IdComprobante, c.TipoComprobante, c.SerieNumero,
		   cd.NombreXML, cd.ArchivoXML,
		   ri.NombreRepresentacionImpresa NombrePDF, ri.Archivo ArchivoPDF, c.FechaEmison, e.RazonSocial
	from Comprobante c
	inner join ComprobanteDocumento cd on c.IdComprobante = cd.IdComprobante
	inner join RepresentacionImpresa ri on cd.IdComprobante = ri.IdComprobante
	inner join Empresa e on e.IdEmpresa = c.IdEmpresa
	where cd.IdComprobante = @IdComprobante
end
go

if object_id('usp_ListarComprobantesEnvioCorreo', 'P') is not null
	drop procedure usp_ListarComprobantesEnvioCorreo
go
create procedure usp_ListarComprobantesEnvioCorreo
as
begin
	select e.NumeroDocumentoIdentidad, c.IdComprobante, TipoComprobante, SerieNumero, c.CorreoElectronico
	from Comprobante c 
	inner join RepresentacionImpresa ri on c.IdComprobante = ri.IdComprobante
	inner join Empresa e on c.IdEmpresa = e.IdEmpresa
	where not exists (select 1 from ComprobanteCorreo where IdComprobante = c.IdComprobante)
end
go

if object_id('usp_ListarCorreosPendientes', 'P') is not null
	drop procedure usp_ListarCorreosPendientes
go
create procedure usp_ListarCorreosPendientes
as
begin
	select top 10 IdComprobante, De, Para, Asunto from ComprobanteCorreo where Estado = 0
end
go

if not exists(select 1 from Configuracion where Servicio = 'SWINECO')
	insert into Configuracion values ('SWINECO', 'TempCorreo', 'C:\Facturacion\Temporales\Correo')

alter table RepresentacionImpresa
	add constraint PK_RepresentacionImpresa primary key (IdComprobante)
go