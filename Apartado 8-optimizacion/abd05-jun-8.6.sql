/*
8.6.Activar la autotraza para mostrar los planes de ejecución (sin estadísticas) de las sentencias SELECT
que ejecutará en este ejercicio. Quizá deba desactivarla en ocasiones, por ejemplo para ejecutar
otras sentencias de creación de otros elementos del esquema
*/

--set autotrace on explain
set autotrace on explain
select nombre, telefono, nivel
  from ABD05_TRADUCTOR
  where idioma IN ('inglés', 'italiano');

set autotrace on explain
select nombre, telefono, nivel
  FROM (ABD05_TRADUCTOR join ABD05_TRADUCCION on dni=traductor)
  where idioma IN ('inglés', 'italiano')
  and anyo like '%/%/19';

set autotrace on explain
select t.nombre, t.telefono, t.nivel
  from ((ABD05_TRADUCTOR t JOIN ABD05_TRADUCCION tra ON t.dni=tra.traductor)
  join ABD05_LIBRO l ON l.idlibro=tra.libro)
  where t.idioma IN ('inglés', 'italiano')
  and tra.anyo like '%/%/19'
  and l.genero='épico';


