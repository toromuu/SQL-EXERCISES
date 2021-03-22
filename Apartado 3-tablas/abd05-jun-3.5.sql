/*
3.5. Mostrar con un SELECT las restricciones de integridad de clave ajena (externa) de las tablas
creadas (nombre de la tabla, nombre de la clave ajena, columna que forma parte de la
clave ajena, y nombre de la clave primaria o clave única a la que apunta).

*/

select con.table_name "nombre tabla", con.constraint_name "nombre clave ajena", col.column_name "columna pertenencia fk", con.r_constraint_name "nombre pk referencia"
from user_constraints con inner join user_cons_columns col 
  on con.r_constraint_name=col.constraint_name;
  
  