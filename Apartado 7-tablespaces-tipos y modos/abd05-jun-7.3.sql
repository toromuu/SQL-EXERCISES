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
