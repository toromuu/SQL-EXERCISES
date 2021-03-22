/*
7.4
Tablespaces UNDO. Responder razonadamente a las siguientes cuestiones:
? Mostrar el tablespace de undo activo en este momento.
? Crear un tablespace de undo ABDXX_UNDO de 256KB.
? Crear una tabla ABDXX_U de 64k en el nuevo tablespace ABDXX_UNDO.
? Mostrar con un SELECT el nombre de todos los segmentos de rollback de la base de datos,
indicando el tablespace en el que est�n y si est�n online u offline.
? �C�mo se podr�an poner online los segmentos de rollback del tablespace ABDXX_UNDO?
? Borrar completamente el tablespace ABDXX_UNDO. Comprobar si es necesario borrar la
tabla ABDXX_U (en el caso de existir �sta) y el fichero empleado en la creaci�n del tablespace.

*/

--Mostrar el tablespace de undo activo en este momento.
select * from dba_undo_extents where status ='ACTIVE';

--Crear un tablespace de undo ABDXX_UNDO de 256KB.
create undo tablespace ABD05_UNDO2
datafile 'ABD05_UNDO2.DBF'
size 256k;


--Crear una tabla ABDXX_U de 64k en el nuevo tablespace ABDXX_UNDO.
create table ABD05_U (
  comentario varchar(30)
)

tablespace ABD05_UNDO2
storage (initial 64k);

/*Mostrar con un SELECT el nombre de todos los segmentos de rollback de la base de datos,
indicando el tablespace en el que est�n y si est�n online u offline.*/
select segment_name, tablespace_name, status from dba_rollback_segs;

--�C�mo se podr�an poner online los segmentos de rollback del tablespace ABDXX_UNDO?


/*Borrar completamente el tablespace ABDXX_UNDO. Comprobar si es necesario borrar la
tabla ABDXX_U (en el caso de existir �sta) y el fichero empleado en la creaci�n del tablespace.*/
drop tablespace ABD05_UNDO2 including contents and datafiles;
drop table ABD05_U purge;
