use FacturacionElectronicaDB
go

update Empresa set
CodigoDomicilioFiscal = '0002',
CodigoPais = 'PE',
CodigoUbigeo = '150101',
ContactoCorreo = 'amilcar.huaman@outlook.com',
ContactoNombre = 'Amilcar Huamán Adama',
ContactoTelefono  = '943616168',
Departamento = 'LIMA',
Direccion = 'VIA MZA. D1 LOTE. 27 OTR. COMERCIANTES Y ARTESANOS AV. WIESSE 3840 CRUCE CON AV. STA ROSA',
Distrito = 'SAN JUAN DE LURIGANCHO',
NombreComercial = 'ITS DEL PERU S.A.C',
Provincia = 'LIMA',
RazonSocial = 'INSPECCION & TESTING SERVICES DEL PERU S.A.C'
where
NumeroDocumentoIdentidad = '20602034675'
go

if OBJECT_ID('usp_ObtenerEmisor', 'P') is not null
	drop procedure usp_ObtenerEmisor
go
create procedure usp_ObtenerEmisor
	@numeroDocumentoIdentidad varchar(20)
as
begin
	set nocount on

	select 
		CodigoDomicilioFiscal,
		CodigoPais,
		CodigoUbigeo,
		ContactoCorreo,
		ContactoNombre,
		ContactoTelefono,
		Departamento,
		Direccion,
		Distrito,
		NombreComercial,
		NumeroDocumentoIdentidad,
		PaginaWeb,
		Provincia,
		RazonSocial,
		TipoDocumentoIdentidad,
		Urbanizacion
	from empresa
	where NumeroDocumentoIdentidad = @numeroDocumentoIdentidad
end
go
