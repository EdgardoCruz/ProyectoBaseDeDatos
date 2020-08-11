--Pasar los valores a Historial Honorario y resetear los valores en la tabla honorarios Medicos
create procedure spHistorialHonorarioAgregar
as
	insert into HistorialHonorario
	select HonorarioMedicoID,  cast(month(getDate()) as varchar) + ' de ' + cast(year(getDate()) as varchar), Cant_Consultas, Cant_Visitas, Cant_Operaciones
	from HonorarioMedico

	update HonorarioMedico set Cant_Consultas = 0, Cant_Visitas = 0, Cant_Operaciones = 0
go


