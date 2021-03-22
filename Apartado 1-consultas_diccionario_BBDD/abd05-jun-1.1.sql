--1.1.Mostrar con un SELECT el tamaño total en MB de la SGA (tamaño)

select sum(value)/(1024*1024) as tam_MB 
from v$sga
;
