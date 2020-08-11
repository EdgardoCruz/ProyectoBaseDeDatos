--Funcion para obtener tabla de habitaciones segun su estado
create function dbo.FiltrarHabitaciones(@Estado char) returns @tablaFiltrada 
table(HabitacionID int, CamaID int, TipoHabitacion varchar(30), Estado char)
as
	begin
		insert into @tablaFiltrada
		select h.habitacionID, camaid, Descripcion, estado
		from Habitacion h inner join 
		(select tipoHabitacionID,  Descripcion from TipoHabitacion) th
		on h.TipoHabitacionID = th.TipoHabitacionID
		where estado = @estado or @Estado = 0
		return
	end
go


--Funcion para visualizar las hospitalizaciones en curso
create function dbo.FiltrarHospitalizacionEnCurso(@nombre varchar(30)) returns @tabla
table(Paciente varchar(30), HabitacionID int, CamaID int, FechaEntrada datetime)
as
	begin
		insert into @tabla
		select p.Nombre, HabitacionID, CamaID, FechaEntrada
		from (select pacienteid, nombres + ' ' + apellidos as Nombre from paciente) p
		inner join Hospitalizacion H
		on p.PacienteID = h.PacienteID
		where FechaSalida is null and (nombre like '%'+@nombre+'%' or @nombre = 0)

		return
	end
go
