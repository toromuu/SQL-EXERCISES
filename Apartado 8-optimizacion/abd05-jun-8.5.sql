/*
8.5.Mostrar con un SELECT los �ndices definidos sobre las tablas TRADUCCION, TRADUCTOR y LIBRO
(nombre de la tabla, nombre del �ndice, tipo de �ndice).
*/

select table_name "nombre de la tabla", index_name "nombre del �ndice", index_type "tipo de �ndice"
from user_indexes
where table_name like '%TRADUCCION%' or table_name like '%TRADUCTOR%' or table_name like '%LIBRO%'