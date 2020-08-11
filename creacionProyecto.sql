--Creamos la base de datos para el proyecto
create database ProyectoBD
on(
	Name = ProyectoBDDat,
	FileName = "c:\ProyectoBD\ProyectoBDDat.mdf", 
	Size = 10 MB,
	Filegrowth = 5MB 
		)
log on(
	Name = ProyectoBDLog,
	FileName = "c:\ProyectoBD\ProyectoBDDat.ldf", 
	Size = 2 MB,
	Filegrowth = 1MB

		)
use ProyectoBD

--Queries de creacion de las tablas
create table Consultorio
(
	ConsultorioID int IDENTITY(1,1),
	Estado	char,
	MedicoID int,

	constraint pkConsultorio primary key (ConsultorioID)
)

create table TipoHabitacion
(
	TipoHabitacionID int IDENTITY(1,1),
	Descripcion varchar(30),
	Valor float,

	constraint pkCategoria primary key (TipoHabitacionID)
)

create table Habitacion
(
	HabitacionID int,
	TipoHabitacionID int,
	Estado char,
	CamaID int,

	constraint pkHabitaciones primary key (HabitacionID, CamaID),
	constraint fkHabitacionesTipo foreign key (TipoHabitacionID) REFERENCES TipoHabitacion (TipoHabitacionID)
)


create table Quirofano
(
	QuirofanoID int IDENTITY(1,1),
	Descripcion varchar(30),

	constraint pkQuirofano primary key (QuirofanoID)
)

create table EspecialidadMedica
(
	EspecialidadMedicaID int IDENTITY(1,1),
	Descripcion varchar(30),

	constraint pkEspecialidadMedica primary key (EspecialidadMedicaID)
)

create table Medico
(
	MedicoID int IDENTITY(1,1),
	TipoMedico char,
	EspecialidadMedicaID int,

	constraint pkMedico primary key (MedicoID),
	constraint fkEspecialidadMedica foreign key (EspecialidadMedicaID) references especialidadMedica (EspecialidadMedicaID)
)


create table Paciente
(
	PacienteID int IDENTITY(1,1),
	Nombres varchar(50),
	Apellidos varchar(50),
	FechaNacimiento datetime,
	Correo varchar(30),
	Seguro varchar(15),
	Sexo char,

	constraint pkPaciente primary key (PacienteID)
)

create table Consulta
(
	ConsultaID int IDENTITY(1,1),
	PacienteID int,
	MedicoID int,
	Valor float,

	constraint pkConsulta primary key (ConsultaID),
	constraint fkConsultaPaciente foreign key (PacienteID) REFERENCES Paciente (PacienteID),
	constraint fkConsultaMedico foreign key (MedicoID) REFERENCES Medico (MedicoID)
)

create table Cirugia
(
	CirugiaID int IDENTITY(1,1),
	PacienteID int,
	MedicoID int,
	QuirofanoID int,
	Fecha datetime,
	Valor float,

	constraint pkCirugia primary key (CirugiaID),
	constraint fkCirugiaPaciente foreign key (PacienteID) REFERENCES Paciente (PacienteID),
	constraint fkCirugiaMedico foreign key (MedicoID) REFERENCES Medico (MedicoID),
	constraint fkCirugiaQuirofano foreign key (QuirofanoID) REFERENCES Quirofano (QuirofanoID)
)

create table Emergencia
(
	EmergenciaID int IDENTITY(1,1),
	PacienteID int,
	ConsultaID int,

	constraint pkEmergencia primary key (EmergenciaID),
	constraint fkEmergenciaPaciente foreign key (PacienteID) REFERENCES Paciente (PacienteID),
	constraint fkEmergenciaConsulta foreign key (ConsultaID) REFERENCES Consulta (ConsultaID)
)

create table Hospitalizacion
(
	HospitalizacionID int IDENTITY(1,1),
	PacienteID int,
	FechaEntrada datetime,
	FechaSalida datetime,

	constraint pkHospitalizacion primary key (HospitalizacionID)
)

create table TipoAtencion
(
	TipoAtencionID int IDENTITY(1,1),
	Descripcion varchar(30),
	Valor float,

	constraint pkTipoAtencion primary key (TipoAtencionID)
)
create table Atencion
(
	AtencionID int IDENTITY(1,1),
	Descripcion varchar(30),
	TipoAtencionID int,
	MedicoID int,
	Valor float,

	constraint pkAtencion primary key (AtencionID),
	constraint fkAtencionMedico foreign key (MedicoID) REFERENCES Medico (MedicoID),
	constraint fkTipoAtencion foreign key (TipoAtencionID) REFERENCES TipoAtencion (TipoAtencionID)
)



create table HospitalizacionDetalle
(
	HospitalizacionDetalleID int IDENTITY(1,1),
	HospitalizacioniD int,
	HabitacionID int,
	CamaID int,
	AtencionID int,
	InsumoID int,
	FechaHospitalizacionID datetime,

	constraint pkHospitalizacionDetalle primary key (HospitalizacionDetalleID),
	constraint fkHospitalizacionDetalleHospitalizacion foreign key (HospitalizacionID) REFERENCES Hospitalizacion (HospitalizacionID),
	constraint fkHospitalizacionDetalleHabitacion foreign key (HabitacionID, CamaID) REFERENCES Habitacion (HabitacionID, CamaID),
	constraint fkHospitalizacionDetalleAtencion foreign key (AtencionID) REFERENCES Atencion (AtencionID),
)

create table HonorarioMedico
(
	HonorarioMedicoID int IDENTITY(1,1),
	MedicoID int,
	Cant_Consultas int,
	Cant_Visitas int,
	Cant_Operaciones int

	constraint pkHonorarioMedico primary key (HonorarioMedicoID),
	constraint fkHonorarioMedico foreign key (MedicoID) REFERENCES Medico (MedicoID)
)

create table HistorialHonorario
(
	HistorialHonorarioID int IDENTITY(1,1),
	HonorarioMedicoID int,
	Fecha datetime,
	Cantidad_Consultas int,
	Cantidad_Visitas int,
	Cantidad_Operaciones int,

	constraint pkHistorialHonorario primary key (HistorialHonorarioID),
	constraint fkHistorialHonorario foreign key (HonorarioMedicoID) REFERENCES HonorarioMedico (HonorarioMedicoID)
)

create table TipoArticulo
(
	TipoArticuloID int IDENTITY(1,1),
	Descripcion varchar (30),

	constraint pkTipoArticulo primary key (TipoArticuloID)
)
create table Inventario
(
	ArticuloID int IDENTITY(1,1),
	Descripcion varchar(30),
	TipoArticuloID int,
	Cantidad int

	constraint pkInventarioCamas primary key (ArticuloID)
	constraint fkArticuloTipo foreign key (TipoArticuloID) REFERENCES TipoArticulo (TipoArticuloID)
)

create table Insumo
(
	InsumoID int IDENTITY(1,1),
	Descripcion varchar(30),
	Cantidad int,
	Valor float

	constraint pkInsumo primary key (InsumoID)
)

create table CirugiaDetalle
(
	CirugiaDetalleID int IDENTITY(1,1),
	CirugiaID int,
	InsumoID int,
	CantidadInsumo int,

	constraint pkCirugiaDetalle primary key (CirugiaDetalleID),
	constraint fkCirugiaDetalleCirugia foreign key (CirugiaID) REFERENCES Cirugia (CirugiaID),
	constraint fkCirugiaDetalleInsumo foreign key (InsumoID) REFERENCES Insumo (InsumoID)
)

create table Alquiler
(
	AlquilerID int IDENTITY(1,1),
	ConsultorioID int,
	MedicoID int,
	FechaPagoSiguiente datetime,

	constraint pkAlquiler primary key (AlquilerID),
	constraint fkAlquilerConsultorio foreign key (ConsultorioID) REFERENCES Consultorio (ConsultorioID),
	constraint fkAlquilerMedico foreign key (MedicoID) REFERENCES Medico (MedicoID)
)

create table AlquilerDetalle
(
	AlquilerDetalleID int IDENTITY(1,1),
	AlquilerID int,
	Valor float,
	FechaPago datetime,

	constraint pkAlquilerDetalle primary key (AlquilerDetalleID),
	constraint fkAlquilerDetalleAlquiler foreign key (AlquilerID) REFERENCES Alquiler (AlquilerID)
)

create table Factura
(
	FacturaID int IDENTITY(1,1),
	PacienteID int,
	Estado char,
	Tipo char,
	Fecha datetime,
	Subtotal float,
	Impuesto float,
	Total float,

	constraint pkFactura primary key (FacturaID),
	constraint fkFacturaPaciente foreign key (PacienteID) REFERENCES Paciente (PacienteID)
)

create table FacturaDetalle
(
	FacturaDetalleID int IDENTITY(1,1),
	FacturaID int,
	AtencionID int,
	HabitacionID int,
	CamaID int, 

	constraint pkFacturaDetalle primary key (FacturaDetalleID),
	constraint fkFacturaDetalleFactura foreign key (FacturaID) REFERENCES Factura (FacturaID),
	constraint fkFacturaDetalleAtencion foreign key (AtencionID) REFERENCES Atencion (AtencionID),
	constraint fkFacturaDetalleHabitacion foreign key (HabitacionID, CamaID) REFERENCES Habitacion (HabitacionID, CamaID) 
)

create table Compra
(
	CompraID int identity(1,1),
	ProveedorID int,
	Estado char,
	Fecha datetime,
	Subtotal float,
	Impuesto float,
	Total float,

	constraint pkCompra primary key (CompraID),
)

create table CompraDetalle
(
	CompraDetalleID int identity(1,1),
	CompraID int,
	ArticuloID int,
	Cantidad int,
	Precio float,
	ISV float,

	constraint pkCompraDetalle primary key (CompraDetalleID),
	constraint fkCompraDetalleCompra foreign key (CompraID) REFERENCES Compra (CompraID)
)
