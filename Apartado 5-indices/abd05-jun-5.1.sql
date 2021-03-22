/*
5.1.Mover índices a otro tablespace.
 1_Mostrar con un SELECT el tablespace en el que se ha creado cada uno de los índices de ejercicios anteriores (nombre de la tabla, del índice y del tablespace del índice).
 2_Mover dichos índices (todos) al tablespace ABDXX_INDICES.
 3_Mostrar con el mismo SELECT que, efectivamente, los índices han cambiado de tablespace.

*/


--Mostrar con un SELECT el tablespace en el que se ha creado cada uno de los índices de ejercicios anteriores (nombre de la tabla, del índice y del tablespace del índice).
select table_name , index_name , tablespace_name
from user_indexes;


--Mover dichos índices (todos) al tablespace ABDXX_INDICES.
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


--Mostrar con el mismo SELECT que, efectivamente, los índices han cambiado de tablespace.
select table_name , index_name , tablespace_name
from user_indexes;
