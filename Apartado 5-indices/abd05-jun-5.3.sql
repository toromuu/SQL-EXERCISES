/*5.3
Mostrar con un SELECT las particiones de los �ndices TRADUCTOR_NIVEL_IDX y
EMPLEADO_SUELDO_IDX (nombre del �ndice, nombre de la partici�n y valor m�ximo de
la partici�n).
*/

select index_name " nombre �ndice", partition_name "nombre partici�n", high_value "valor m�ximo"
from user_ind_partitions
where index_name ='TRADUCTOR_NIVEL_ID05' or index_name = 'EMPLEADO_SUELDO_ID05' ;