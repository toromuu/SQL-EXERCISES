/*1.2.Mostrar el tamaño del bloque de la base de datos, el nombre de la base de datos, y el nombre de la
instancia a la que se está conectado.*/

select name,value 
from v$parameter 
where name = 'db_block_size' OR name = 'db_name' OR name = 'instance_name'
;