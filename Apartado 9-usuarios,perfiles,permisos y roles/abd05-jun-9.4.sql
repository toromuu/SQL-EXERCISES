/*
9.4.Permitir que el usuario ABDXX_TRABAJADOR pueda ocupar hasta 1M de espacio en el tablespace
ABDXX_DATOS. Y volver a mostrar las cuotas para ambos usuarios
*/

alter user ABD05_TRABAJADOR quota 1M on ABD04_DATOS;

select username, tablespace_name, bytes, max_bytes
from dba_ts_quotas
where username like '%ABD05%';
