/*
1.6.Mostrar con un SELECT los tablespaces de rollback (undo) que están definidos en la base de datos
(nombre del tablespace, tipo de contenido).
*/

select tablespace_name, contents from dba_tablespaces where contents='UNDO'
;