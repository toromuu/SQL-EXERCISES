/*
3.4. Mostrar con un SELECT las restricciones de integridad de clave primaria de las tablas creadas
(nombre de la tabla, nombre de la clave primaria, columna que forma parte de la
clave primaria).
*/

select table_name "nombre tabla", constraint_name "nombre de clave primaria", column_name "columna pertenencia pk"
from user_cons_columns 
where constraint_name like '%PK%';

