--Al ingresar compras sumamos la cantidad al inventario
create trigger trgrCompraDetalleInsertar on CompraDetalle for insert
as
	declare @cantidadComprada int, @articuloid int
	select @cantidadComprada = cantidad from inserted
	select @articuloid = articuloID from inserted

	update Inventario set Cantidad = Cantidad + @cantidadComprada where ArticuloID = @articuloid
go
--Al anular un compradetalle restamos el inventario
create trigger trgCompraDetalleInsertar on CompraDetalle for delete
as
	declare @cantidadComprada int, @articuloid int
	select @cantidadComprada = cantidad from deleted
	select @articuloid = articuloID from deleted

	update Inventario set Cantidad = Cantidad - @cantidadComprada where ArticuloID = @articuloid
go

--Cuando un medico hace una atencion se suma a Honorarios
create trigger trgrHonorariosAtencion on Atencion for insert
as
	declare @MedicoID int
	select @MedicoID = MedicoID from inserted 

	update HonorarioMedico set Cant_Visitas = Cant_Visitas + 1 where medicoID = @MedicoID
go

--Cuando un medico hace una cirugia se suma a honorarios
create trigger trgrHonorariosCirugia on Cirugia for insert
as
	declare @MedicoID int
	select @MedicoID = MedicoID from inserted 

	update HonorarioMedico set Cant_Operaciones = Cant_Operaciones + 1 where medicoID = @MedicoID
go
--Cuando un medico hace una consulta se suma a honorarios
create trigger trgrHonorariosConsulta on Consulta for insert
as
	declare @MedicoID int
	select @MedicoID = MedicoID from inserted 

	update HonorarioMedico set Cant_Consultas = Cant_Consultas + 1 where medicoID = @MedicoID
go

--Al aplicarse un medicamento se debe actualizar el inventario
create trigger trgrCirugiaMedicamento on Cirugia for insert
as
	declare @insumoid int
	
	update Inventario set Cantidad = Cantidad - 1 where ArticuloID = @insumoid
go

--Al hospitalizar a un paciente se establece una habitacion como ocupada
create trigger trgrHospitalizacionAgregar on Hospitalizacion for insert
as
	declare @habitacion int, @camaid int
	select @habitacion = Habitacionid from inserted
	select @camaid = camaid from inserted 

	update Habitacion set Estado = 'O' where habitacionid = @habitacion and camaid = @camaid
go

--Al agregar una fecha de salida (alta) para el paciente, se habilita la cama nuevamente
create trigger trgrHospitalizacionAlta on Hospitalizacion for update
as
	declare @fechaSalida datetime, @habitacion int, @camaID int
	select @habitacion = habitacionid from Hospitalizacion
	select @camaid = camaid from Hospitalizacion
	select @fechaSalida = fechaSalida from Hospitalizacion
	if @fechaSalida is not null
	begin
		update Habitacion set Estado = 'L' where habitacionID = @habitacion and camaID = @camaID
	end
go

--al pagar el alquiler de un consultorio se genera la fecha del siguiente pago
create trigger trgrAlquilerPago on AlquilerDetalle for insert
as
	declare @fechaSiguiente as datetime, @fechaPago as datetime, @alquilerID int
	select @fechaPago = FechaPago from inserted
	select @fechaSiguiente = dateadd(M, 1, @fechaPago)
	select @alquilerID = Alquilerid from inserted

	update Alquiler set FechaPagoSiguiente = @fechaSiguiente where Alquilerid = @alquilerID
go

--actualizar los totales de la tabla compras
create trigger trgrCompraDetalleTotalesAgregar on CompraDetalle for insert
as
	declare @cantidad as int, @precio as float, @compraid as int, @isv as float
	select @compraid = compraid from inserted
	select @cantidad = cantidad from inserted
	select @precio = precio from inserted
	select @isv = isv from inserted
	update compra set Subtotal = @cantidad * @precio, Impuesto = @cantidad * @precio * @isv, Total = @cantidad * @precio * @isv + @cantidad * @precio
	where compraid = @compraid
go

