update CatalogoErrorSunat set Reintentar = 1 where CodigoRespuesta = '2335'
go

if object_id('dbo.usp_ComprobantesPendientesDeEnvio', 'P') is not null
	drop procedure dbo.usp_ComprobantesPendientesDeEnvio
go
create procedure dbo.usp_ComprobantesPendientesDeEnvio
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
go

if object_id('dbo.usp_ObtenerArchivoComprobante', 'P') is not null
	drop procedure dbo.usp_ObtenerArchivoComprobante
go
create procedure dbo.usp_ObtenerArchivoComprobante
	@IdComprobante bigint
as
begin
	set nocount on
	select IdComprobante, NombreXML, ArchivoXML from dbo.ComprobanteDocumento
	where IdComprobante = @IdComprobante
end
go

if object_id('dbo.usp_InsertarCdrPendiente', 'P') is not null
	drop procedure dbo.usp_InsertarCdrPendiente
go
create procedure dbo.usp_InsertarCdrPendiente
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
go

if object_id('dbo.usp_QuitarPendienteEnvio', 'P') is not null
	drop procedure dbo.usp_QuitarPendienteEnvio
go
create procedure usp_QuitarPendienteEnvio
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
go

update PendienteEnvio set Estado = 1