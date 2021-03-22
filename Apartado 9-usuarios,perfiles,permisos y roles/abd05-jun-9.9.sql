/*
9.9.Crear el rol necesario (obligatorio: el nombre del rol ha de empezar con el prefijo ABDXX_ y
terminar con el sufijo _ROL), conceder los privilegios adecuados sobre elementos del esquema a
dicho rol, y asignar el rol al usuario creado, de forma que se cumplan los siguientes requisitos:
? ABDXX_TRABAJADOR puede consultar todas las columnas de todas tablas, salvo la columna
precio de las publicaciones. Puede insertar nuevos libros y actualizar el teléfono de los
empleados. No puede insertar, modificar ni borrar datos de ninguna otra tabla.
*/

select * from dba_roles where role like '%ABD%';

create role ABD05_ROL;
grant create session to ABD05_ROL; --para que pueda iniciar sesion en la base de datos

grant select on ABD05_EDITORIAL to ABD05_ROL;
grant select on ABD05_EMPLEADO to ABD05_ROL;
grant select on ABD05_LIBRO to ABD05_ROL;
grant select on ABD05_TRADUCCION to ABD05_ROL;
grant select on ABD05_TRADUCTOR to ABD05_ROL;

create view ABD05_PUBLICACION_TRABAJADOR as
select editorial, traduccion,anyo,formato,isbn,paginas,ilustrada, empleado_editor
from abd05_publicacion;
grant select on ABD05_PUBLICACION_TRABAJADOR to ABD05_ROL;

grant insert on ABD05_LIBRO to ABD05_ROL;
grant update(telefono) on ABD05_EMPLEADO to ABD05_ROL;

grant ABD05_ROL to ABD05_TRABAJADOR;
alter user ABD05_TRABAJADOR default role ABD05_ROL;