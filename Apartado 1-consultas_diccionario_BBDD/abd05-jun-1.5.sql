/*
1.5.Mostrar con una sola sentencia SELECT 
a) los ficheros de datos y los tablespaces a los que están
asociados, 
b) los ficheros de control, y 
c) los ficheros de redo de la base de datos. 

La primera columna indicará el tipo de fichero (tipo de fichero –DATAFILE|CONTROLFILE|REDOFILE-,
nombre del fichero, y nombre del tablespace si es un fichero de datos).
*/

select 'DATAFILE' tipo, v$datafile.name nombre, v$tablespace.name tablaspace from v$datafile inner join v$tablespace on v$tablespace.TS#= v$datafile.TS#
 union all
select 'CONTROLFILE' tipo, name nombre, null  from v$controlfile
 union all
select 'REDOFILE' tipo, member nombre, null  from v$logfile
;