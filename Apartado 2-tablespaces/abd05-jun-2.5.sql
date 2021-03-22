/*
2.5.Mostrar con un SELECT el espacio libre de los dos tablespaces creados (nombre del tablespace,
espacio libre). Justificar el resultado.

*/

select dt.tablespace_name "nombre tablespace", dt.max_size-d.bytes  "espacio libre"
from v$datafile d, dba_tablespaces dt, v$tablespace t
where (d.ts#=t.ts#) and (dt.tablespace_name=t.name) and (t.name LIKE 'ABD05_%');