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