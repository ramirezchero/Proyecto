USE [FacturacionElectronicaDB]
GO

IF OBJECT_ID('dbo.usp_InsertarComprobante', 'P') IS NOT NULL	
	DROP PROCEDURE dbo.usp_InsertarComprobante
GO
CREATE PROCEDURE dbo.usp_InsertarComprobante
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
	@CodigoQR varchar(max)	
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