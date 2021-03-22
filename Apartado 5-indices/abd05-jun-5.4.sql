/*5.4
Visualizar con un SELECT las particiones y subparticiones del �ndice PUBLICACION_ANYO_IDX
(nombre del �ndice, nombre de la partici�n, nombre de la subpartici�n y valor
m�ximo de la (ojo!) partici�n).
*/

select p.index_name "nombre �ndice", p.partition_name "nombre partici�n", s.subpartition_name "nombre subpartici�n", p.high_value "valor m�ximo"
from user_ind_partitions p inner join 
(select distinct partition_name,subpartition_name from  user_ind_subpartitions ) s on p.partition_name= s.partition_name
where p.index_name ='PUBLICACION_ANYO_ID05';





