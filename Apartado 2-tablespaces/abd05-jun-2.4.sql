/*
2.4.Mostrar con un SELECT los ficheros de los dos tablespaces creados (nombre del tablespace,
nombre del fichero, tamaño inicial, si/no puede crecer automáticamente, y tamaño
máximo).
*/

select tablespace_name "nombre tablespace", file_name "nombre fichero", bytes "tamaño inicial", autoextensible "crecimiento automatico", maxbytes "tamaño maximo"
from dba_data_files 
where tablespace_name like 'ABD05_%';

