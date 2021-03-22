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

