--1.1.Mostrar con un SELECT el tama�o total en MB de la SGA (tama�o)

select sum(value)/(1024*1024) as tam_MB 
from v$sga
;
