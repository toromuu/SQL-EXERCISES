/*
1.3.Mostrar con un SELECT tres par�metros de inicializaci�n de la base de datos que est�n relacionados
con el tama�o de la SGA (nombre del par�metro, descripci�n y valor). Justificar en qu� afecta
cada uno de ellos al tama�o de la SGA
*/

select name,description,value 
from v$parameter 
where name = 'sga_max_size' OR name = 'sga_target' OR name = 'shared_pool_size'
;


/*
SGA_MAX_SIZE ->Tama�o m�ximo de la SGA
SGA_TARGET->Con valor distinto de cero indica que el tama�o de la SGA se gestionar� autom�ticamente si es cero la gesti�n es manual
SHARED_POOL_SIZE->Tama�o del �rea compartida de la SGA  
*/