/*
8.1.Mostrar el modo de optimizaci�n de consultas de la sesi�n.
*/

select * 
from v$parameter   --V$PARAMETER muestra informaci�n sobre los par�metros de inicializaci�n que est�n actualmente vigentes para la sesi�n
where name like 'optimizer_mode';

