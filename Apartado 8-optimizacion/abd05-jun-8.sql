/*
8.1.Mostrar el modo de optimizaci�n de consultas de la sesi�n.
*/

select * 
from v$parameter   --V$PARAMETER muestra informaci�n sobre los par�metros de inicializaci�n que est�n actualmente vigentes para la sesi�n
where name like 'optimizer_mode';

/*
8.2.Borrar todas las estad�sticas que puedan existir relacionadas con el esquema ABDXX
[mediante una invocaci�n del procedimiento DBMS_STATS.delete_schema_stats(�);]
*/

execute DBMS_STATS.delete_schema_stats('ABD05');

/*
8.3.Computar las estad�sticas de todos los elementos (objetos) del esquema ABDXX
[invocaci�n del procedimiento DBMS_UTILITY.analyze_schema(�);].
*/

execute DBMS_UTILITY.analyze_schema('ABD05','COMPUTE');

/*8.4
Mostrar con tres SELECT las estad�sticas de las tablas, las estad�sticas de las columnas de las tablas,
y las estad�sticas de los �ndices.
*/

select * 
from user_tab_statistics;

select *
from user_tab_col_statistics;

select *
from user_ind_statistics;

/*
8.5.Mostrar con un SELECT los �ndices definidos sobre las tablas TRADUCCION, TRADUCTOR y LIBRO
(nombre de la tabla, nombre del �ndice, tipo de �ndice).
*/

select table_name "nombre de la tabla", index_name "nombre del �ndice", index_type "tipo de �ndice"
from user_indexes
where table_name like '%TRADUCCION%' or table_name like '%TRADUCTOR%' or table_name like '%LIBRO%'

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

/*
8.7.Optimizar consultas. Para ello: 
  a) ejecutar cada consulta, 
  b) mostrar y observar su plan de ejecuci�n, 
  c) crear los �ndices necesarios para optimizarla, 
  d) volver a mostrar el plan optimizado de la consulta, y 
  e) justificar los resultados.
*/

alter session set optimizer_index_cost_adj=100; --valor por defecto

/*
 Mejorar el rendimiento de la siguiente consulta, que muestra traductores que traducen del
ingl�s o del italiano.
SELECT nombre, telefono, nivel
FROM ABDXX_TRADUCTOR
WHERE idioma IN ('INGL�S', 'ITALIANO');
*/
--a)
explain plan for
  select nombre, telefono, nivel
  from ABD05_TRADUCTOR
  where idioma IN ('ingl�s', 'italiano');
--b)
SELECT * FROM TABLE(dbms_xplan.display);
--c)
create index TRADUCTOR_IDIOMA on ABD05_TRADUCTOR(idioma)
tablespace ABD05_INDICES;

--d)
explain plan for
  select nombre, telefono, nivel
  from ABD05_TRADUCTOR
  where idioma IN ('ingl�s', 'italiano');
SELECT * FROM TABLE(dbms_xplan.display);
--e)
/*
Como la tabla de traductor contiene pocas filas, aun creando el �ndice, tarda menos si recorre toda la tabla que si tiene que acceder al �ndice
y recorrer el �ndice buscando los datos
*/
alter session set optimizer_index_cost_adj=50;  --reduzco el costo de los indices a la mitad para que sea menor que el de la tabla 
                                                --y reducir asi el coste de la cpu
/*
Optimizar la siguiente consulta que muestra traductores que traducen del ingl�s o del italiano
y que han hecho traducciones en 2019.
SELECT nombre, telefono, nivel
FROM (ABDXX_TRADUCTOR JOIN ABDXX_TRADUCCION ON dni=traductor)
WHERE idioma IN ('INGL�S', 'ITALIANO')
 AND anyo= 2019;
*/
--a)
explain plan for
  select nombre, telefono, nivel
  FROM (ABD05_TRADUCTOR join ABD05_TRADUCCION on dni=traductor)
  where idioma IN ('ingl�s', 'italiano')
  and EXTRACT(year FROM anyo) = '2019';
  
--b)
SELECT * FROM TABLE(dbms_xplan.display);
--c)
create index TRADUCCION_ANYO on ABD05_TRADUCCION(EXTRACT(year FROM anyo)) ;
--d)
explain plan for
  select nombre, telefono, nivel
  FROM (ABD05_TRADUCTOR join ABD05_TRADUCCION on dni=traductor)
  where idioma IN ('ingl�s', 'italiano')
  and EXTRACT(year FROM anyo) = '2019';
SELECT * FROM TABLE(dbms_xplan.display);
--e)
/*
Al igual que en el apartado anterior, sino se altera el costo, el optimizador considera que es mejor recorrer toda la tabla antes que recorrer el �ndice.
*/


/*
? Mejorar el rendimiento de esta consulta que muestra los traductores que traducen del ingl�s
o del italiano y que han realizado traducciones en 2019 de libros de g�nero �pico. Para ello,
transforme en primer lugar el JOIN con LIBRO en una subconsulta. Despu�s intente
optimizarla a�n m�s, si ello es posible, mediante la creaci�n de alg�n �ndice.
SELECT t.nombre, t.telefono, t.nivel
FROM ((ABDXX_TRADUCTOR t JOIN ABDXX_TRADUCCION tra ON t.dni=tra.traductor)
 JOIN ABDXX_LIBRO l ON l.idlibro=tra.libro)
WHERE t.idioma IN ('INGL�S', 'ITALIANO')
 AND tra.anyo= 2019
 AND l.genero='�pico';
*/
--a)
explain plan for
  /*
  select t.nombre, t.telefono, t.nivel
  from ((ABD05_TRADUCTOR t JOIN ABD05_TRADUCCION tra ON t.dni=tra.traductor)
  join ABD05_LIBRO l ON l.idlibro=tra.libro)
  where t.idioma IN ('ingl�s', 'italiano')
  and EXTRACT(year FROM anyo) = '2019'
  and l.genero='�pico';
  */
  select nombre, telefono, nivel
  from(
    (select *
    from ABD05_TRADUCTOR t JOIN ABD05_TRADUCCION tra ON t.dni=tra.traductor
    where t.idioma IN ('ingl�s', 'italiano')
    and EXTRACT(year FROM anyo) = '2019')
  join ABD05_LIBRO l ON l.idlibro=libro
  )
  where l.genero='�pico';
--b)
SELECT * FROM TABLE(dbms_xplan.display);
--c)
create index LIBRO_GENERO on ABD05_Libro(genero)
tablespace ABD05_INDICES;
--d)
explain plan for
  select nombre, telefono, nivel
  from(
    (select *
    from ABD05_TRADUCTOR t JOIN ABD05_TRADUCCION tra ON t.dni=tra.traductor
    where t.idioma IN ('ingl�s', 'italiano')
    and EXTRACT(year FROM anyo) = '2019')
  join ABD05_LIBRO l ON l.idlibro=libro
  )
  where l.genero='�pico';
SELECT * FROM TABLE(dbms_xplan.display);
--e)
/*
El optimizador transforma la subconsulta en un join equivalente por eso aparece en la explicacion de ambos planes: access("L"."IDLIBRO"="TRA"."LIBRO")
a pesar de que nosotros nunca comparamos directamente libro y traduccion.

Al igual que pasa en los apartados anteriores, al ser las tablas tan peque�as,
si no se reduce el costo de los indices a la mitad, el optimizador considera que es mas rapido
comparar todas las tablas antes que recorrer los indice primero para ver si existen registros que cumplan las condiciones.
*/


/*
8.8.Desactivar la autotraza.
*/

set autotrace off;


/*
8.9.Borrar los �ndices creados en este ejercicio.
*/

drop index TRADUCTOR_IDIOMA;
drop index TRADUCCION_ANYO;
drop index LIBRO_GENERO;




/*
8.10.Volver a mostrar con un SELECT los �ndices definidos sobre las tablas TRADUCCION, TRADUCTOR y
LIBRO (nombre de la tabla, nombre del �ndice, tipo de �ndice).
*/

select table_name "nombre de la tabla", index_name "nombre del �ndice", index_type "tipo de �ndice"
from user_indexes
where table_name like '%TRADUCCION%' or table_name like '%TRADUCTOR%' or table_name like '%LIBRO%';