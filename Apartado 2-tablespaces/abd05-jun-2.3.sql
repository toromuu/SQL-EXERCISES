/*
2.3.Mostrar con un SELECT los dos tablespaces creados (nombre del tablespace, tipo de
contenido, tamaño de bloque, tamaño de la extensión inicial, tamaño de la extensión
siguiente, porcentaje de incremento de las siguientes extensiones, forma de manejo
de las extensiones, y forma de manejo del espacio de los segmentos).

*/

select tablespace_name "nombre tablaspace",contents "tipo de contenido", block_size "tamaño de bloque", initial_extent "tam extensión inicial", 
next_extent "tam extensión siguiente", pct_increase "porcentaje de incremento", extent_management "manejo extensiones siguientes", segment_space_management "manejo espacio de segmentos"
from dba_tablespaces 
where tablespace_name like 'ABD05%';

select *
from dba_tablespaces 
where tablespace_name like 'ABD05%';