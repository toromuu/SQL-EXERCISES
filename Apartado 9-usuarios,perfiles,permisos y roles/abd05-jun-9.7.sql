/*
9.7.Mostrar con SELECT el perfil creado en la base de datos y qu� l�mites de recursos fija (nombre del
perfil, nombre del recurso limitado, tipo del recurso, y l�mite).
*/

select *
from DBA_PROFILES
where profile like '%ABD05%';