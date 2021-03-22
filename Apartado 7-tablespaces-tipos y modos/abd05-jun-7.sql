/* 7.1
Crear un tablespace ABDXX_NOLOCAL, de 512K, no manejado localmente. Justificar los
resultados.
*/


create tablespace ABD05_NOLOCAL 
datafile 'ABD05_NOLOCAL.DBF'
size 512K
autoextend on maxsize 1M
extent management dictionary
segment space management manual
default storage  
(initial 40K next 80K maxextents 10 pctincrease 0);

/*
7.2. Tablespaces READONLY. Razonar cada resultado obtenido al realizar estas acciones:
          En el tablespace ABDXX_DATOS crear una tabla ABDXX_R de 64KB.
          Insertar una fila en la tabla ABDXX_R.
          Poner el tablespace ABDXX_DATOS en modo READONLY.
          Insertar otra fila en la tabla ABDXX_R.
          Mostrar con un SELECT el contenido de la tabla ABDXX_R.
          Borrar la tabla ABDXX_R.
          Volver a poner el tablespace ABDXX_DATOS en modo READWRITE. 
*/

--En el tablespace ABDXX_DATOS crear una tabla ABDXX_R de 64KB.
create table ABD05_R (
  comentario varchar(30)
)

tablespace ABD05_DATOS
storage (initial 64k);

--Insertar una fila en la tabla ABDXX_R.
insert into ABD05_R values ( 'Hola mundo');

--Poner el tablespace ABDXX_DATOS en modo READONLY.
alter tablespace ABD05_DATOS read only;

--Insertar otra fila en la tabla ABDXX_R.
insert into ABD05_R values ( 'Adios mundo');

--Mostrar con un SELECT el contenido de la tabla ABDXX_R.
select * from abd05_r;

--Borrar la tabla ABDXX_R.
drop table abd05_r purge;

--Volver a poner el tablespace ABDXX_DATOS en modo READWRITE.
alter tablespace ABD05_DATOS read write;

/*
7.3. Tablespaces OFFLINE. Justificar los resultados obtenidos al realizar cada una de estas acciones:
? En el tablespace ABDXX_DATOS crear una tabla ABDXX_O de 32KB.
? Insertar una fila en la tabla ABDXX_O.
? Poner el tablespace ABDXX_DATOS en modo OFFLINE.
? Insertar otra fila en la tabla ABDXX_O.
? Mostrar con un SELECT el contenido de la tabla ABDXX_O.
? Borrar la tabla ABDXX_O.
? Volver a poner ONLINE el tablespace ABDXX_DATOS.
*/

--En el tablespace ABDXX_DATOS crear una tabla ABDXX_O de 32KB.
create table ABD05_O (
  comentario varchar(30)
)

tablespace ABD05_DATOS
storage (initial 32k);

--Insertar una fila en la tabla ABDXX_O.
insert into ABD05_O values ( 'Hola mundo');

--Poner el tablespace ABDXX_DATOS en modo OFFLINE.
alter tablespace ABD05_DATOS offline;

--Insertar otra fila en la tabla ABDXX_O.
insert into ABD05_O values ( 'Adios mundo');

--Mostrar con un SELECT el contenido de la tabla ABDXX_O.
select * from abd05_o;

--Borrar la tabla ABDXX_O.
drop table ABD05_O purge;

--Volver a poner ONLINE el tablespace ABDXX_DATOS.
alter tablespace ABD05_DATOS online;


/*7.4
Tablespaces UNDO. Responder razonadamente a las siguientes cuestiones:
? Mostrar el tablespace de undo activo en este momento.
? Crear un tablespace de undo ABDXX_UNDO de 256KB.
? Crear una tabla ABDXX_U de 64k en el nuevo tablespace ABDXX_UNDO.
? Mostrar con un SELECT el nombre de todos los segmentos de rollback de la base de datos,
indicando el tablespace en el que están y si están online u offline.
? ¿Cómo se podrían poner online los segmentos de rollback del tablespace ABDXX_UNDO?
? Borrar completamente el tablespace ABDXX_UNDO. Comprobar si es necesario borrar la
tabla ABDXX_U (en el caso de existir ésta) y el fichero empleado en la creación del tablespace.

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
indicando el tablespace en el que están y si están online u offline.*/
select segment_name, tablespace_name, status from dba_rollback_segs;

--¿Cómo se podrían poner online los segmentos de rollback del tablespace ABDXX_UNDO?


/*Borrar completamente el tablespace ABDXX_UNDO. Comprobar si es necesario borrar la
tabla ABDXX_U (en el caso de existir ésta) y el fichero empleado en la creación del tablespace.*/
drop tablespace ABD05_UNDO2 including contents and datafiles;
drop table ABD05_U purge;


/*
7.5 Tablespaces TEMPORALES. Justificar los resultados obtenidos tras realizar cada acción:
? Mostrar con un SELECT el nombre del tablespace temporal por defecto del usuario ABDXX.
Anótelo, pues luego deberá recordar cuál era.
? Crear un tablespace temporal ABDXX_TEMPORAL del menor tamaño posible.
? Ponerlo en modo readonly.
? Ponerlo en modo offline. Si tiene éxito, volver a ponerlo online.
? ¿Cómo se podría establecer como el tablespace temporal por defecto de la base de datos?
? Renombrarlo a ABDXX_TEMP1.
? Crear una tabla (no temporal) ABDXX_T en dicho tablespace.
? Asignar al usuario ABDXX el tablespace ABDXX_TEMP1 como su tablespace temporal por
defecto.
? Mostrar de nuevo el nombre del tablespace temporal por defecto del usuario ABDXX.
? Reasignar al usuario ABDXX su tablespace temporal por defecto original
? Borrar por completo de la base de datos el tablespace ABDXX_TEMP1.
*/

--Mostrar con un SELECT el nombre del tablespace temporal por defecto del usuario ABDXX.
--Anótelo, pues luego deberá recordar cuál era.
select username,temporary_tablespace
from dba_users
where username='ABD05';
--ABD_TEMP

--Crear un tablespace temporal ABDXX_TEMPORAL del menor tamaño posible.
CREATE TEMPORARY TABLESPACE ABD05_TEMPORAL
TEMPFILE 'ABD05_TEMPORAL.DBF' 
SIZE 64k
EXTENT MANAGEMENT LOCAL UNIFORM SIZE 40k;

--Ponerlo en modo readonly.
alter tablespace ABD05_TEMPORAL read only;
--los tablespaces temporales no se pueden poner en modo readonly

--Ponerlo en modo offline. Si tiene éxito, volver a ponerlo online.
alter tablespace ABD05_TEMPORAL tempfile offline;
alter tablespace ABD05_TEMPORAL tempfile online;

--¿Cómo se podría establecer como el tablespace temporal por defecto de la base de datos?
-- con la sentencia: alter user ABD05 temporary tablespace ABD05_TEMPORAL;

--Renombrarlo a ABDXX_TEMP1.
alter tablespace ABD05_TEMPORAL rename to ABD05_TEMP1;

--Crear una tabla (no temporal) ABDXX_T en dicho tablespace.
create table ABD05_T (
  comentario varchar(30)
)

tablespace ABD05_TEMP1;

/*Asignar al usuario ABDXX el tablespace ABDXX_TEMP1 como su tablespace temporal por
defecto.*/
alter user ABD05 temporary tablespace ABD05_TEM1;

--Mostrar de nuevo el nombre del tablespace temporal por defecto del usuario ABDXX.
select username,temporary_tablespace
from dba_users
where username='ABD05';

--Reasignar al usuario ABDXX su tablespace temporal por defecto original
alter user ABD05 temporary tablespace ABD_TEMP;

--Borrar por completo de la base de datos el tablespace ABDXX_TEMP1.
drop tablespace ABD05_TEMP1 including contents and datafiles cascade constraint;
drop table ABD05_T  purge;
