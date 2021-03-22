/*
5.1.Mover �ndices a otro tablespace.
 1_Mostrar con un SELECT el tablespace en el que se ha creado cada uno de los �ndices de ejercicios anteriores (nombre de la tabla, del �ndice y del tablespace del �ndice).
 2_Mover dichos �ndices (todos) al tablespace ABDXX_INDICES.
 3_Mostrar con el mismo SELECT que, efectivamente, los �ndices han cambiado de tablespace.

*/


--Mostrar con un SELECT el tablespace en el que se ha creado cada uno de los �ndices de ejercicios anteriores (nombre de la tabla, del �ndice y del tablespace del �ndice).
select table_name , index_name , tablespace_name
from user_indexes;


--Mover dichos �ndices (todos) al tablespace ABDXX_INDICES.
alter index TRADUCTOR_PK rebuild tablespace ABD05_INDICES;
alter index TRADUCCION_PK rebuild tablespace ABD05_INDICES;
alter index PUBLICACION_PK rebuild tablespace ABD05_INDICES;
alter index INDICE_ABD05_LT rebuild tablespace ABD05_INDICES;
alter index LIBRO_PK rebuild tablespace ABD05_INDICES;
alter index SYS_C00326971 rebuild tablespace ABD05_INDICES;
alter index EMPLEADO_PK rebuild tablespace ABD05_INDICES; 
alter index SYS_C00326961 rebuild tablespace ABD05_INDICES;

--Al ser una IOT y no te  deja hacer el rebuilt, por lo que se tiene que hacer un MOVE de la tabla entera.
ALTER TABLE ABD05_EDITORIAL MOVE TABLESPACE ABD05_INDICES;


--Mostrar con el mismo SELECT que, efectivamente, los �ndices han cambiado de tablespace.
select table_name , index_name , tablespace_name
from user_indexes;

/*
5.2.Crear �ndices en el tablespace ABDXX_INDICES.
? En PUBLICACION, un �ndice llamado PUBLICACION_ILUSTRADA_IDX, de tipo mapa de bits
(bitmap) sobre la columna ilustrada.
? En TRADUCTOR, crear un �ndice llamado TRADUCTOR_NIVEL_IDX sobre la columna nivel, de
tipo particionado local.
? En EMPLEADO, un �ndice llamado EMPLEADO_EDITORIAL_IDX, de tipo no particionado (a
pesar de que la tabla s� lo est�) con base en la columna editorial.
? En PUBLICACION, un �ndice llamado PUBLICACION_ANYO_IDX, de tipo particionado local
sobre la columna anyo.
? En EMPLEADO, un �ndice llamado EMPLEADO_SUELDO_IDX, sobre la columna sueldo. El
�ndice ha de ser de tipo particionado global con cuatro particiones (empleados BECARIOS con
salario inferior a 700�, empleados a PRUEBA que cobran menos de 950�, y empleados de
PLANTILLA, que cobran menos de 1500� y DIRECTIVOS, que cobran m�s de 1500�)
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


/*5.3
Mostrar con un SELECT las particiones de los �ndices TRADUCTOR_NIVEL_IDX y
EMPLEADO_SUELDO_IDX (nombre del �ndice, nombre de la partici�n y valor m�ximo de
la partici�n).
*/

select index_name " nombre �ndice", partition_name "nombre partici�n", high_value "valor m�ximo"
from user_ind_partitions
where index_name ='TRADUCTOR_NIVEL_ID05' or index_name = 'EMPLEADO_SUELDO_ID05' ;


/*5.4
Visualizar con un SELECT las particiones y subparticiones del �ndice PUBLICACION_ANYO_IDX
(nombre del �ndice, nombre de la partici�n, nombre de la subpartici�n y valor
m�ximo de la (ojo!) partici�n).
*/

select p.index_name "nombre �ndice", p.partition_name "nombre partici�n", s.subpartition_name "nombre subpartici�n", p.high_value "valor m�ximo"
from user_ind_partitions p inner join 
(select distinct partition_name,subpartition_name from  user_ind_subpartitions ) s on p.partition_name= s.partition_name
where p.index_name ='PUBLICACION_ANYO_ID05';




