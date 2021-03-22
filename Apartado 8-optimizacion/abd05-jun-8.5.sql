/*
8.5.Mostrar con un SELECT los índices definidos sobre las tablas TRADUCCION, TRADUCTOR y LIBRO
(nombre de la tabla, nombre del índice, tipo de índice).
*/

select table_name "nombre de la tabla", index_name "nombre del índice", index_type "tipo de índice"
from user_indexes
where table_name like '%TRADUCCION%' or table_name like '%TRADUCTOR%' or table_name like '%LIBRO%'