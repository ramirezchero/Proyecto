/*
select * from CatalogoErrorSunat
select * from TipoRespuesta

select * from CDRSunatPendiente
*/
--select * from [dbo].[Configuracion]

--insert into Configuracion(servicio,codigo,valor) values('SWINSE','TempCDR','C:\Facturacion\Temporales\CDR')
--alter procedure guardar
--@IdComprobante bigint,
--@Archivo varbinary(max)
--as
--declare @temp2 table(Id bigint)
--insert into Comprobante(IdEmpresa,TipoDocumentoIdentidad,NroDocumentoIdentidad,RazonSocial,TipoComprobante,SerieNumero,FechaEmison,CorreoElectronico,TotalImpuesto,TotalValorVenta,TotalPrecioVenta,TotalDescuento,TotalCargo,ImporteTotal,FechaVencimiento,HoraEmision,Moneda,TipoOperacion,FechaRegistro)
--OUTPUT INSERTED.IdComprobante into @temp2(Id)
--values(4,6,'20000000000','','','','','',0,0,0,0,0,0,'','','','',getdate())
--declare @idcomprobante2 bigint
--SET @idcomprobante2=(select id from @temp2)
--SET @IdComprobante=@idcomprobante2


--insert into CDRSunatPendiente(IdComprobante,Archivo,FechaRegistro)
--values(@IdComprobante,@Archivo,getdate())
--go


--delete from CDRSunatPendiente
----delete from Comprobante
--select * from Comprobante where IdComprobante<>15
--select * from CDRSunatPendiente where IdComprobante<>15

/*

delete from ComprobanteRespuestaHistorial
delete from ComprobanteRespuesta
delete from CDRSunatPendiente 
DELETE FROM CDRSunatProcesado
DELETE FROM ComprobanteRespuestaHistorial
delete from Comprobante 


SELECT * FROM [dbo].[CDRSunatProcesado]
select * from ComprobanteRespuestaHistorial order by IdComprobante ASC
select * from ComprobanteRespuesta
select * from CDRSunatPendiente 
select *  from Comprobante 
*/
--F001-39045

if exists(select 1 from sysobjects where name='usp_ListaCDRPendiente' and type='P') BEGIN
   drop procedure usp_ListaCDRPendiente
END
go
create procedure usp_ListaCDRPendiente
as
select IdComprobante,Archivo,FechaRegistro
from CDRSunatPendiente with (nolock)
go
-----
if exists(select 1 from sysobjects where name='usp_ListaConfiguracion' and type='P') BEGIN
   drop procedure usp_ListaConfiguracion
END
go
create procedure usp_ListaConfiguracion --'TempCDR'
@codigo varchar(10)
as
select codigo,valor from Configuracion with (nolock)
where codigo=case when len(@codigo)>0 then @codigo else codigo end
go
------
if exists(select 1 from sysobjects where name='usp_RegistraRespuestaSUNAT' and type='P') BEGIN
   drop procedure usp_RegistraRespuestaSUNAT
END
go
create procedure usp_RegistraRespuestaSUNAT
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
go
