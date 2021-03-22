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
