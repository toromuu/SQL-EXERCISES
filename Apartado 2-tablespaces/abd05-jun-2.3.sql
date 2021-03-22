/*
2.3.Mostrar con un SELECT los dos tablespaces creados (nombre del tablespace, tipo de
contenido, tama�o de bloque, tama�o de la extensi�n inicial, tama�o de la extensi�n
siguiente, porcentaje de incremento de las siguientes extensiones, forma de manejo
de las extensiones, y forma de manejo del espacio de los segmentos).

*/

select tablespace_name "nombre tablaspace",contents "tipo de contenido", block_size "tama�o de bloque", initial_extent "tam extensi�n inicial", 
next_extent "tam extensi�n siguiente", pct_increase "porcentaje de incremento", extent_management "manejo extensiones siguientes", segment_space_management "manejo espacio de segmentos"
from dba_tablespaces 
where tablespace_name like 'ABD05%';

select *
from dba_tablespaces 
where tablespace_name like 'ABD05%';