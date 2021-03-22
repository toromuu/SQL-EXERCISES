/*
9.11. Conectarse a la base de datos con el usuario ABDXX_TRABAJADOR. Solucione los posibles
problemas que puedan surgir. A continuación…
? Visualizar los roles activos que tiene el usuario en esta sesión (nombre del rol).
? Mostrar los privilegios de objeto y de sistema obtenidos directamente y no a través de roles,
que posee el usuario (nombre del privilegio, tabla [o null, si es de sistema]).
? Obtener con SELECT el nombre de cada editorial, fecha de fundación y el número total de
traducciones que han encargado, en orden alfabético de nombre de editorial. Mostrar lo que
aparece en pantalla tras la ejecución y razonar los resultados.
? Sacar con SELECT el precio de las publicaciones, ordenado por nombre de editorial y dentro
de cada editorial, de más cara a más barata. Mostrar lo que aparece en pantalla tras la
ejecución y razonar los resultados.
? Modificar el precio de una publicación (elija una cualquiera) para incrementar un 20% el
precio actual. Mostrar lo que aparece en pantalla tras la ejecución y razonar los resultados.
? Cambiar el teléfono de un empleado (elija uno cualquiera). Mostrar lo que aparece en
pantalla tras la ejecución y razonar los resultados.
? Modificar el sueldo de un empleado (elija uno que editor de más de 2 publicaciones) para
incrementar un 15% su salario actual. Mostrar lo que aparece en pantalla tras la ejecución y
razonar los resultados.
*/

--Visualizar los roles activos que tiene el usuario en esta sesión (nombre del rol).
select *
from session_roles;



/*
Mostrar los privilegios de objeto y de sistema obtenidos directamente y no a través de roles,
que posee el usuario (nombre del privilegio, tabla [o null, si es de sistema]).
*/
select *
from user_tab_privs;

/*
Obtener con SELECT el nombre de cada editorial, fecha de fundación y el número total de
traducciones que han encargado, en orden alfabético de nombre de editorial. Mostrar lo que
aparece en pantalla tras la ejecución y razonar los resultados.
*/

select nombre,fecha , (
  select count(*) 
  from abd05.abd05_traduccion
  ) as "num traducciones encargadas"
from abd05.abd05_editorial;

select nombre, fundacion , (
  select count(*)
  from abd05.abd05_traduccion
  where editorial=ideditorial
  ) as "num traducciones encargadas"
from abd05.abd05_editorial
order by nombre;

/*
Sacar con SELECT el precio de las publicaciones, ordenado por nombre de editorial y dentro
de cada editorial, de más cara a más barata. Mostrar lo que aparece en pantalla tras la
ejecución y razonar los resultados.
*/
select e.nombre, p.precio
from abd05.abd05_publicacion_trabajador p join abd05.abd05_editorial e on p.editorial=e.ideditorial
order by e.nombre,p.precio
;

/*Muestra el siguiente mensaje
ORA-00904: "P"."PRECIO": identificador no válido
00904. 00000 -  "%s: invalid identifier"
*Cause:    
*Action:
Error en la línea: 62, columna: 18

esto pasa porque el usuario ABD05_TRABAJADOR no tiene permiso para consultar los precios, por lo que estos no se encuentran en la vista abd05.abd05_publicacion_trabajador*/

/*
Modificar el precio de una publicación (elija una cualquiera) para incrementar un 20% el
precio actual. Mostrar lo que aparece en pantalla tras la ejecución y razonar los resultados.
*/
update abd05.abd05_publicacion_trabajador
set precio =precio*1.20
where editorial=1;

/*
Muestra el siguiente error:

Error que empieza en la línea 76 del comando:
update abd05.abd05_publicacion_trabajador
set precio =precio*0.80
where editorial=1
Error en la línea de comandos:77 Columna:12
Informe de error:
Error SQL: ORA-00904: "PRECIO": identificador no válido
00904. 00000 -  "%s: invalid identifier"
*Cause:    
*Action:


esto pasa porque el usuario ABD05_TRABAJADOR no tiene permiso para consultar los precios y por tanto, tampoco modificarlos*/

/*
Cambiar el teléfono de un empleado (elija uno cualquiera). Mostrar lo que aparece en
pantalla tras la ejecución y razonar los resultados.
*/
update abd05.abd05_empleado
set telefono =telefono+1
where dni='48657294R';

/*Muestra: 1 filas actualizadas. Ya que el usuario abd05.abd05_publicacion_trabajador tiene permiso para actualizar los tlfnos de los empleados*/

/*
Modificar el sueldo de un empleado (elija uno que editor de más de 2 publicaciones) para
incrementar un 15% su salario actual. Mostrar lo que aparece en pantalla tras la ejecución y
razonar los resultados.
*/
update abd05.abd05_empleado
set sueldo=sueldo*1.15
where dni =(
  select empleado_editor
  from abd05.abd05_publicacion_trabajador
  having count(*)>=2
  group by empleado_editor
)
;

/*Muestra el siguiente error:

Error que empieza en la línea 114 del comando:
update abd05.abd05_empleado
set sueldo=sueldo*1.15
where dni =(
  select empleado_editor
  from abd05.abd05_publicacion_trabajador
  having count(*)>=2
  group by empleado_editor
)
Error en la línea de comandos:114 Columna:13
Informe de error:
Error SQL: ORA-01031: privilegios insuficientes
01031. 00000 -  "insufficient privileges"
*Cause:    An attempt was made to change the current username or password
           without the appropriate privilege. This error also occurs if
           attempting to install a database without the necessary operating
           system privileges.
           When Trusted Oracle is configure in DBMS MAC, this error may occur
           if the user was granted the necessary privilege at a higher label
           than the current login.
*Action:   Ask the database administrator to perform the operation or grant
           the required privileges.
           For Trusted Oracle users getting this error although granted the
           the appropriate privilege at a higher label, ask the database
           administrator to regrant the privilege at the appropriate label.



Este error se debe a que el usuario ABD05_TRABAJADOR no tiene privilegios update sobre la tabla de empleados
*/




