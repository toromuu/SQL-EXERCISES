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
