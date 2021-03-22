/*5.4
Visualizar con un SELECT las particiones y subparticiones del índice PUBLICACION_ANYO_IDX
(nombre del índice, nombre de la partición, nombre de la subpartición y valor
máximo de la (ojo!) partición).
*/

select p.index_name "nombre índice", p.partition_name "nombre partición", s.subpartition_name "nombre subpartición", p.high_value "valor máximo"
from user_ind_partitions p inner join 
(select distinct partition_name,subpartition_name from  user_ind_subpartitions ) s on p.partition_name= s.partition_name
where p.index_name ='PUBLICACION_ANYO_ID05';





