--drop tablespace abd05 including contents and datafiles cascade constraint      PARA EL APARTADO 2

drop tablespace ABD05_DATOS including contents and datafiles cascade constraint;

/*
CREATE TABLESPACE  ABD05_DATOS 
DATAFILE ABD05_DATOS1.DBF  
  SIZE 512K
  AUTOEXTEND OFF
  EXTENT MANAGEMENT LOCAL
           { AUTOALLOCATE | UNIFORM [ SIZE valor [K|M|G|T] ] }
  SEGMENT SPACE MANAGEMENT { MANUAL | AUTO 
        
*/
--2.1
CREATE TABLESPACE  ABD05_DATOS 
DATAFILE 'ABD05_DATOS1.DBF' 
  SIZE 512K
  AUTOEXTEND OFF
  EXTENT MANAGEMENT LOCAL UNIFORM SIZE 40K  --el tamaño minimo del tablespace gestionado por espacio de segmentos debe tener minimo 5 bloques y un bloque usa 8192 B con lo que se necesitaran 40.960B = 40K
  SEGMENT SPACE MANAGEMENT AUTO ;
  


--2.2
CREATE TABLESPACE  ABD05_INDICES 
DATAFILE 'ABD05_INDICES1.DBF' 
  SIZE 512K
  AUTOEXTEND ON MAXSIZE 1M
  EXTENT MANAGEMENT LOCAL UNIFORM SIZE 32K 
  SEGMENT SPACE MANAGEMENT MANUAL ;

--2.3
select * 
from dba_tablespaces 
where tablespace_name like 'ABD05_%';

--2.4
--select * 
--from dba_data_files 
--where tablespace_name like 'ABD05_%';

select tablespace_name "nombre tablespace", file_name "nombre fichero", 
bytes "tamaño inicial", autoextensible "crecimiento automatico", maxbytes "tamaño maximo"
from dba_data_files 
where tablespace_name like 'ABD05_%';


--2.5

SELECT dt.tablespace_name, dt.max_size-d.bytes AS "espacio libre"
FROM v$datafile d, dba_tablespaces dt, v$tablespace t
WHERE (d.ts#=t.ts#) AND (dt.tablespace_name=t.name) AND (t.name
LIKE 'ABD05_%');

--2.6
ALTER USER ABD05 DEFAULT TABLESPACE ABD05_DATOS;





