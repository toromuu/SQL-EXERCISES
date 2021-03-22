/*
8.6.Activar la autotraza para mostrar los planes de ejecuci�n (sin estad�sticas) de las sentencias SELECT
que ejecutar� en este ejercicio. Quiz� deba desactivarla en ocasiones, por ejemplo para ejecutar
otras sentencias de creaci�n de otros elementos del esquema
*/

--set autotrace on explain
set autotrace on explain
select nombre, telefono, nivel
  from ABD05_TRADUCTOR
  where idioma IN ('ingl�s', 'italiano');

set autotrace on explain
select nombre, telefono, nivel
  FROM (ABD05_TRADUCTOR join ABD05_TRADUCCION on dni=traductor)
  where idioma IN ('ingl�s', 'italiano')
  and anyo like '%/%/19';

set autotrace on explain
select t.nombre, t.telefono, t.nivel
  from ((ABD05_TRADUCTOR t JOIN ABD05_TRADUCCION tra ON t.dni=tra.traductor)
  join ABD05_LIBRO l ON l.idlibro=tra.libro)
  where t.idioma IN ('ingl�s', 'italiano')
  and tra.anyo like '%/%/19'
  and l.genero='�pico';


