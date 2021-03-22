/*
5.2.Crear índices en el tablespace ABDXX_INDICES.
? En PUBLICACION, un índice llamado PUBLICACION_ILUSTRADA_IDX, de tipo mapa de bits
(bitmap) sobre la columna ilustrada.
? En TRADUCTOR, crear un índice llamado TRADUCTOR_NIVEL_IDX sobre la columna nivel, de
tipo particionado local.
? En EMPLEADO, un índice llamado EMPLEADO_EDITORIAL_IDX, de tipo no particionado (a
pesar de que la tabla sí lo esté) con base en la columna editorial.
? En PUBLICACION, un índice llamado PUBLICACION_ANYO_IDX, de tipo particionado local
sobre la columna anyo.
? En EMPLEADO, un índice llamado EMPLEADO_SUELDO_IDX, sobre la columna sueldo. El
índice ha de ser de tipo particionado global con cuatro particiones (empleados BECARIOS con
salario inferior a 700€, empleados a PRUEBA que cobran menos de 950€, y empleados de
PLANTILLA, que cobran menos de 1500€ y DIRECTIVOS, que cobran más de 1500€)
*/

create bitmap index PUBLICACION_ILUSTRADA_ID05
on ABD05_PUBLICACION (ilustrada)
local tablespace ABD05_INDICES;

create index TRADUCTOR_NIVEL_ID05
on abd05_traductor (nivel)
local tablespace abd05_indices;

create index EMPLEADO_EDITORIAL_ID05
on abd05_empleado (editorial)
tablespace abd05_indices;

create index PUBLICACION_ANYO_ID05
on abd05_publicacion (anyo)
local tablespace abd05_indices;
-- al intentar crearlo me dice que no queda memoria asi que creo abd05_indices2
alter tablespace ABD05_INDICES add datafile 'ABD05_INDICES2.DBF' size 512k;

create index EMPLEADO_SUELDO_ID05
on abd05_empleado (sueldo)
global partition by range (sueldo)
(partition BECARIO values less than (700) tablespace ABD05_INDICES,
partition PRUEBA values less than (900) tablespace ABD05_INDICES,
partition PLANTILLA values less than (1500) tablespace ABD05_INDICES,
partition DIRECTIVO values less than (MAXVALUE) tablespace ABD05_INDICES);



