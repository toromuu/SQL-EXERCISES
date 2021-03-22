/*
9.3.Mostrar con un SELECT las cuotas de espacio en los tablespaces ABDXX_DATOS y ABDXX_INDICES
de ABDXX y ABDXX_TRABAJADOR (usuario, tablespace, bytes, maxbytes). Comentar los datos
obtenidos como resultado.
*/

select username, tablespace_name, bytes, max_bytes
from dba_ts_quotas
where username like '%ABD05%';

--como el usuario ABD05_TRABAJADOR no puede crear objetos no aparece 