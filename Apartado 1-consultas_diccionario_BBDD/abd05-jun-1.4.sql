/*
1.4.Mostrar con un SELECT las 3 �ltimas sentencias SQL cargadas en la shared-pool (texto de la
sentencia, fecha y hora en que se carg�).
*/

Select * from
(   Select    SQL_FULLTEXT SENTENCIA,
               FIRST_LOAD_TIME fecha_hora
               
   From V$sqlarea a
   Order by a.FIRST_LOAD_TIME desc)
Where rownum <= 3
;