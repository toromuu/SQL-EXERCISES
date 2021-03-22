/*
8.7.Optimizar consultas. Para ello: 
  a) ejecutar cada consulta, 
  b) mostrar y observar su plan de ejecución, 
  c) crear los índices necesarios para optimizarla, 
  d) volver a mostrar el plan optimizado de la consulta, y 
  e) justificar los resultados.
*/

alter session set optimizer_index_cost_adj=100; --valor por defecto

/*
 Mejorar el rendimiento de la siguiente consulta, que muestra traductores que traducen del
inglés o del italiano.
SELECT nombre, telefono, nivel
FROM ABDXX_TRADUCTOR
WHERE idioma IN ('INGLÉS', 'ITALIANO');
*/
--a)
explain plan for
  select nombre, telefono, nivel
  from ABD05_TRADUCTOR
  where idioma IN ('inglés', 'italiano');
--b)
SELECT * FROM TABLE(dbms_xplan.display);
--c)
create index TRADUCTOR_IDIOMA on ABD05_TRADUCTOR(idioma)
tablespace ABD05_INDICES;

--d)
explain plan for
  select nombre, telefono, nivel
  from ABD05_TRADUCTOR
  where idioma IN ('inglés', 'italiano');
SELECT * FROM TABLE(dbms_xplan.display);
--e)
/*
Como la tabla de traductor contiene pocas filas, aun creando el índice, tarda menos si recorre toda la tabla que si tiene que acceder al índice
y recorrer el índice buscando los datos
*/
alter session set optimizer_index_cost_adj=50;  --reduzco el costo de los indices a la mitad para que sea menor que el de la tabla 
                                                --y reducir asi el coste de la cpu
/*
Optimizar la siguiente consulta que muestra traductores que traducen del inglés o del italiano
y que han hecho traducciones en 2019.
SELECT nombre, telefono, nivel
FROM (ABDXX_TRADUCTOR JOIN ABDXX_TRADUCCION ON dni=traductor)
WHERE idioma IN ('INGLÉS', 'ITALIANO')
 AND anyo= 2019;
*/
--a)
explain plan for
  select nombre, telefono, nivel
  FROM (ABD05_TRADUCTOR join ABD05_TRADUCCION on dni=traductor)
  where idioma IN ('inglés', 'italiano')
  and EXTRACT(year FROM anyo) = '2019';
  
--b)
SELECT * FROM TABLE(dbms_xplan.display);
--c)
create index TRADUCCION_ANYO on ABD05_TRADUCCION(EXTRACT(year FROM anyo)) ;
--d)
explain plan for
  select nombre, telefono, nivel
  FROM (ABD05_TRADUCTOR join ABD05_TRADUCCION on dni=traductor)
  where idioma IN ('inglés', 'italiano')
  and EXTRACT(year FROM anyo) = '2019';
SELECT * FROM TABLE(dbms_xplan.display);
--e)
/*
Al igual que en el apartado anterior, sino se altera el costo, el optimizador considera que es mejor recorrer toda la tabla antes que recorrer el índice.
*/


/*
? Mejorar el rendimiento de esta consulta que muestra los traductores que traducen del inglés
o del italiano y que han realizado traducciones en 2019 de libros de género épico. Para ello,
transforme en primer lugar el JOIN con LIBRO en una subconsulta. Después intente
optimizarla aún más, si ello es posible, mediante la creación de algún índice.
SELECT t.nombre, t.telefono, t.nivel
FROM ((ABDXX_TRADUCTOR t JOIN ABDXX_TRADUCCION tra ON t.dni=tra.traductor)
 JOIN ABDXX_LIBRO l ON l.idlibro=tra.libro)
WHERE t.idioma IN ('INGLÉS', 'ITALIANO')
 AND tra.anyo= 2019
 AND l.genero='épico';
*/
--a)
explain plan for
  /*
  select t.nombre, t.telefono, t.nivel
  from ((ABD05_TRADUCTOR t JOIN ABD05_TRADUCCION tra ON t.dni=tra.traductor)
  join ABD05_LIBRO l ON l.idlibro=tra.libro)
  where t.idioma IN ('inglés', 'italiano')
  and EXTRACT(year FROM anyo) = '2019'
  and l.genero='épico';
  */
  select nombre, telefono, nivel
  from(
    (select *
    from ABD05_TRADUCTOR t JOIN ABD05_TRADUCCION tra ON t.dni=tra.traductor
    where t.idioma IN ('inglés', 'italiano')
    and EXTRACT(year FROM anyo) = '2019')
  join ABD05_LIBRO l ON l.idlibro=libro
  )
  where l.genero='épico';
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
    where t.idioma IN ('inglés', 'italiano')
    and EXTRACT(year FROM anyo) = '2019')
  join ABD05_LIBRO l ON l.idlibro=libro
  )
  where l.genero='épico';
SELECT * FROM TABLE(dbms_xplan.display);
--e)
/*
El optimizador transforma la subconsulta en un join equivalente por eso aparece en la explicacion de ambos planes: access("L"."IDLIBRO"="TRA"."LIBRO")
a pesar de que nosotros nunca comparamos directamente libro y traduccion.

Al igual que pasa en los apartados anteriores, al ser las tablas tan pequeñas,
si no se reduce el costo de los indices a la mitad, el optimizador considera que es mas rapido
comparar todas las tablas antes que recorrer los indice primero para ver si existen registros que cumplan las condiciones.
*/



