/*
1.3.Mostrar con un SELECT tres parámetros de inicialización de la base de datos que estén relacionados
con el tamaño de la SGA (nombre del parámetro, descripción y valor). Justificar en qué afecta
cada uno de ellos al tamaño de la SGA
*/

select name,description,value 
from v$parameter 
where name = 'sga_max_size' OR name = 'sga_target' OR name = 'shared_pool_size'
;


/*
SGA_MAX_SIZE ->Tamaño máximo de la SGA
SGA_TARGET->Con valor distinto de cero indica que el tamaño de la SGA se gestionará automáticamente si es cero la gestión es manual
SHARED_POOL_SIZE->Tamaño del área compartida de la SGA  
*/