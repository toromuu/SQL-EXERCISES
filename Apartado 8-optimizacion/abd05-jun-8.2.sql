/*
8.2.Borrar todas las estadísticas que puedan existir relacionadas con el esquema ABDXX
[mediante una invocación del procedimiento DBMS_STATS.delete_schema_stats(…);]
*/

execute DBMS_STATS.delete_schema_stats('ABD05');