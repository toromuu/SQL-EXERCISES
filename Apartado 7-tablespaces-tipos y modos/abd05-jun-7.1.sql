/*
7.1
Crear un tablespace ABDXX_NOLOCAL, de 512K, no manejado localmente. Justificar los
resultados.
*/


create tablespace ABD05_NOLOCAL 
datafile 'ABD05_NOLOCAL.DBF'
size 512K
autoextend on maxsize 1M
extent management dictionary
segment space management manual
default storage  
(initial 40K next 80K maxextents 10 pctincrease 0);

