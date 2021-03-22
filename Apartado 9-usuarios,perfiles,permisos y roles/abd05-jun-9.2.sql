/*
9.2.Mostrar con un SELECT los tablespaces por defecto y temporal de ABDXX y ABDXX_TRABAJADOR
(usuario, nombre de su tablespace por defecto, nombre de su tablespace temporal).
*/

select username, default_tablespace, temporary_tablespace
from dba_users
where username like '%ABD05%';