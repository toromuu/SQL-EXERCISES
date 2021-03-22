/*5.3
Mostrar con un SELECT las particiones de los índices TRADUCTOR_NIVEL_IDX y
EMPLEADO_SUELDO_IDX (nombre del índice, nombre de la partición y valor máximo de
la partición).
*/

select index_name " nombre índice", partition_name "nombre partición", high_value "valor máximo"
from user_ind_partitions
where index_name ='TRADUCTOR_NIVEL_ID05' or index_name = 'EMPLEADO_SUELDO_ID05' ;