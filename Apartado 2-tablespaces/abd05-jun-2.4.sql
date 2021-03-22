/*
2.4.Mostrar con un SELECT los ficheros de los dos tablespaces creados (nombre del tablespace,
nombre del fichero, tama�o inicial, si/no puede crecer autom�ticamente, y tama�o
m�ximo).
*/

select tablespace_name "nombre tablespace", file_name "nombre fichero", bytes "tama�o inicial", autoextensible "crecimiento automatico", maxbytes "tama�o maximo"
from dba_data_files 
where tablespace_name like 'ABD05_%';

