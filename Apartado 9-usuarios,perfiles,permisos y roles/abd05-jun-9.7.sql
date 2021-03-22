/*
9.7.Mostrar con SELECT el perfil creado en la base de datos y qué límites de recursos fija (nombre del
perfil, nombre del recurso limitado, tipo del recurso, y límite).
*/

select *
from DBA_PROFILES
where profile like '%ABD05%';