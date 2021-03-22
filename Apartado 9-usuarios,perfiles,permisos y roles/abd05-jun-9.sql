/*
9.1.Conectados como usuario ABDXX, crear un nuevo usuario ABDXX_TRABAJADOR autentificado por
la base de datos, con las siguientes especificaciones:
? Su clave inicial es TR484J4D0R. 
No podrá crear objetos en ningún tablespace. 
Su tablespace por defecto debe ser ABDXX_DATOS, y su tablespace temporal por defecto ha de ser uno de
los tablespaces temporales ya definidos en la base de datos.
*/

select * from dba_tablespaces where contents = 'TEMPORARY';

/*
CREATE USER usuario
IDENTIFIED { BY contraseña
| EXTERNALLY
| GLOBALLY AS ‘nombre_externo’ }
[ DEFAULT TABLESPACE tablespace ]
[ TEMPORARY TABLESPACE tablespace_temporal ]
[ QUOTA { entero [ K | M ] | UNLIMITED } ON tablespace ]+
[ PROFILE perfil ]
[ PASSWORD EXPIRE ]
[ ACCOUNT { LOCK | UNLOCK } ] ;
*/
create user ABD05_TRABAJADOR
identified by TR484J4D0R
default tablespace ABD05_DATOS
temporary tablespace ABD_TEMP;

/*
9.2.Mostrar con un SELECT los tablespaces por defecto y temporal de ABDXX y ABDXX_TRABAJADOR
(usuario, nombre de su tablespace por defecto, nombre de su tablespace temporal).
*/

select username, default_tablespace, temporary_tablespace
from dba_users
where username like '%ABD05%';


/*
9.3.Mostrar con un SELECT las cuotas de espacio en los tablespaces ABDXX_DATOS y ABDXX_INDICES
de ABDXX y ABDXX_TRABAJADOR (usuario, tablespace, bytes, maxbytes). Comentar los datos
obtenidos como resultado.
*/

select username, tablespace_name, bytes, max_bytes
from dba_ts_quotas
where username like '%ABD05%';

--como el usuario ABD05_TRABAJADOR no puede crear objetos no aparece 

/*
9.4.Permitir que el usuario ABDXX_TRABAJADOR pueda ocupar hasta 1M de espacio en el tablespace
ABDXX_DATOS. Y volver a mostrar las cuotas para ambos usuarios
*/

alter user ABD05_TRABAJADOR quota 1M on ABD04_DATOS;

select username, tablespace_name, bytes, max_bytes
from dba_ts_quotas
where username like '%ABD05%';

/*
9.5.Crear un perfil denominado ABDXX_TRABAJADOR_PERFIL que garantice estas especificaciones:
? La contraseña de ABDXX_TRABAJADOR expira a los 20 días.
? ABDXX_TRABAJADOR no puede tener abierta simultáneamente más de 1 sesión.
? ABDXX_TRABAJADOR tiene limitado a 10 minutos el tiempo de inactividad de sus sesiones
(pasado ese tiempo se cerrará automáticamente la sesión).
? La cuenta se bloqueará durante 5 días en el caso de superar los 3 intentos consecutivos
fallidos de conexión.
*/

/*
CREATE PROFILE perfil LIMIT
[ parametro_recurso ]+ [ parametro_contraseña ]+;
parametro_recurso::=
SESSIONS_PER_USER vr
| CPU_PER_SESSION vr
| CPU_PER_CALL vr
| CONNECT_TIME vr
| IDLE_TIME vr
| LOGICAL_READS_PER_SESSION vr
| LOGICAL_READS_PER_CALL vr
| PRIVATE_SGA { entero [K|M] | UNLIMITED | DEFAULT }
| COMPOSITE_LIMIT vr
vr::= { entero | UNLIMITED | DEFAULT }
*/

CREATE PROFILE ABD05_TRABAJADOR_PERFIL LIMIT
SESSIONS_PER_USER 1
IDLE_TIME 10
FAILED_LOGIN_ATTEMPTS 3
PASSWORD_LIFE_TIME 20
PASSWORD_LOCK_TIME 5
;

/*
9.6.Asignar el perfil al usuario creado.
*/

alter user ABD05_TRABAJADOR profile ABD05_TRABAJADOR_PERFIL;

/*
9.7.Mostrar con SELECT el perfil creado en la base de datos y qué límites de recursos fija (nombre del
perfil, nombre del recurso limitado, tipo del recurso, y límite).
*/

select *
from DBA_PROFILES
where profile like '%ABD05%';

/*
9.8.Conceder a ABDXX_TRABAJADOR el permiso para consultar la tabla EDITORIAL.
*/

grant select on ABD05_EDITORIAL to ABD05_TRABAJADOR;

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

/*
9.10. Mostrar con SELECT los permisos sobre tablas concedidos a los roles (rol, tabla, privilegio).
*/

select *
from role_tab_privs
where role='ABD05_ROL';

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
/*
select nombre,fecha , (
  select count(*) 
  from abd05.abd05_traduccion
  ) as "num traducciones encargadas"
from abd05.abd05_editorial;*/

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




