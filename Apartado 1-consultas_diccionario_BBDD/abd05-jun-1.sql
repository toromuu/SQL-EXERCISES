--1.1
select sum(value)/(1024*1024) as tam_MB from v$sga;

/*1.2
show parameters db_block_size
show parameter db_name
show parameter instance_name
;*/

select name,value 
from v$parameter 
where name = 'db_block_size' 
	OR name = 'db_name' 
	OR name = 'instance_name';

--1.3
--select * from v$parameter;  para ver toda la tabla de parametros

select name,description,value 
from v$parameter 
where name = 'sga_max_size' 
	OR name = 'sga_target' 
	OR name = 'shared_pool_size';

/*
SGA_MAX_SIZE ->Tamaño máximo de la SGA
SGA_TARGET->Con valor distinto de cero indica que el tamaño de la SGA se gestionará automáticamente si es cero la gestión es manual
SHARED_POOL_SIZE->Tamaño del área compartida de la SGA  */

--1.4
 Select * from
(   Select    SQL_FULLTEXT SENTENCIA,
               FIRST_LOAD_TIME fecha_hora
               
   From V$sqlarea a
   Order by a.FIRST_LOAD_TIME desc)
Where rownum <= 3;

--1.5
select 'DATAFILE' tipo, v$datafile.name nombre, v$tablespace.name tablaspace from v$datafile inner join v$tablespace on v$tablespace.TS#= v$datafile.TS#
 union all
select 'CONTROLFILE' tipo, name nombre, null  from v$controlfile
 union all
select 'REDOFILE' tipo, member nombre, null  from v$logfile
;

--1.6
select tablespace_name, contents from dba_tablespaces 
where contents='UNDO';
--select v$tablespace.name nombre_tablespace, type from v$tablespace join v$parameter on v$parameter.value=v$tablespace.name ;

