/*
8.1.Mostrar el modo de optimización de consultas de la sesión.
*/

select * 
from v$parameter   --V$PARAMETER muestra información sobre los parámetros de inicialización que están actualmente vigentes para la sesión
where name like 'optimizer_mode';

