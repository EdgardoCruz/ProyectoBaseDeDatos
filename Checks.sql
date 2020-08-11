--La columna de estado solo puede tener los valores L: Libre o O: Ocupado
alter table habitacion add constraint chkHabitacionEstado check
(
	Estado = 'O' or Estado = 'L'
)
--El paciente solo puede ser hombre o mujer
alter table paciente add constraint chkPacienteSexo check
(
	Sexo = 'F' or Sexo = 'M'
)