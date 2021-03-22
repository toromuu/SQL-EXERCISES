/*
3.6. Mostrar con un SELECT las restricciones de integridad de tipo CHECK de las tablas creadas (nombre
de la tabla, nombre de la restricción, y condición de la restricción).
*/

select table_name "nombre tabla", constraint_name "nombre restriccion", search_condition "condicion de la restriccion" 
from user_constraints 
where constraint_type ='C';