/*
8.2.Borrar todas las estad�sticas que puedan existir relacionadas con el esquema ABDXX
[mediante una invocaci�n del procedimiento DBMS_STATS.delete_schema_stats(�);]
*/

execute DBMS_STATS.delete_schema_stats('ABD05');