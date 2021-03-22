--antes del ejercicio 3 
/*
antes de crear las tablas para que no de error ejecutar el comando: 
*/

/*para borrar table y cluster: */
-- drop table ...... purge;
--drop cluster ABD05_LT ;

/* 3.2
Crear las tablas en el tablespace de datos teniendo en cuenta las siguientes indicaciones:
? EDITORIAL ha de estar organizada por índice (tabla IOT).
? EMPLEADO debe contener 3 particiones por hash según la columna dni
? LIBRO y TRADUCCIÓN deben ser almacenadas en un cluster llamado ABDXX_LT
? PUBLICACIÓN ha de estar particionada según el formato en dos particiones, BOLSILLO y
TAPADURA. A su vez, cada una de ellas debe contener con 3 subparticiones, según el número
de páginas: menos de 150 páginas BREVE, entre 150 y 400 página ESTANDAR y más de 400
páginas LARGA.
? TRADUCTOR ha de organizarse en cuatro particiones según el idioma del que sean expertos
(ALEMÁN, FRANCÉS, INGLES, ITALIANO).
*/
alter user ABD05 quota unlimited on ABD05_DATOS;
alter user ABD05 quota unlimited on ABD05_INDICES;
create cluster ABD05_LT (libro number(4));
create index INDICE_ABD05_LT on cluster ABD05_LT; --lo creamos para poder almacenar datos en las tablas de libro y traduccion



--TABLA LIBRO(idlibro, titulo, genero, idioma, autor)
CREATE TABLE ABD05_LIBRO(
  idlibro number(4),
  titulo varchar(30) not null,
  genero varchar(30) not null check (genero in ('lírico', 'épico', 'dramático','didáctico')),
  idioma varchar(30) not null check (idioma in('alemán', 'francés','inglés', 'italiano')),
  autor varchar(30) not null,
  
  constraint libro_pk primary key(idlibro)
)
cluster ABD05_LT(idlibro);

--TABLA TRADUCCION(numtraduccion, libro, traductor, editorial, titulo_traducido, anyo)
CREATE TABLE ABD05_TRADUCCION(
  numtraduccion number(4),
  libro number(4) not null,
  traductor char(9) not null,
  editorial number(4) not null,
  titulo_traducido varchar(30) not null,
  anyo date not null,
  
  constraint traduccion_pk primary key(numtraduccion)
  --constraint traduccion_fk_libro foreign key(libro) references ABD05_LIBRO(idlibro),
  --constraint traduccion_fk_traductor foreign key(traductor) references ABD05_TRADUCTOR(dni),
  --constraint traduccion_fk_editorial foreign key(editorial) references ABD05_LIBRO(ideditorial)
  
)
cluster ABD05_LT(libro);

alter table ABD05_TRADUCCION add constraint traduccion_fk_libro foreign key(libro) references ABD05_LIBRO(idlibro);
alter table ABD05_TRADUCCION add constraint traduccion_fk_traductor foreign key(traductor) references ABD05_TRADUCTOR(dni);
alter table ABD05_TRADUCCION add constraint traduccion_fk_editorial foreign key(editorial) references ABD05_EDITORIAL(ideditorial);


--TABLA EDITORIAL(ideditorial, nombre, fundacion, email, empleado)
CREATE TABLE ABD05_EDITORIAL(
  ideditorial number(4),
  nombre varchar(30) not null,
  fundacion date not null,
  email varchar(30) null,
  empleado char(9) not null,
  
  constraint editorial_pk primary key(ideditorial)
  --constraint editorial_fk foreign key (empleado) references ABD05_EMPLEADO(dni)
  
)
organization index;
alter table ABD05_EDITORIAL add constraint editorial_fk_empleado foreign key (empleado) references ABD05_EMPLEADO(dni);
alter table ABD05_EDITORIAL add unique(empleado); -- para poder crear la tabla publicacion porque sino da error en la publi_fk_empleado


--TABLA EMPLEADO (dni, nombre, telefono, nacimiento, editorial, sueldo)
CREATE TABLE ABD05_EMPLEADO (
  dni        char(9),
  nombre    varchar(30) not null,
  telefono    number(9)    null,
  nacimiento date not null,
  editorial number(4) not null,
  sueldo number(6,2) not null,
  constraint empleado_pk primary key(dni), 
  constraint empleado_fk_editorial foreign key(editorial) references ABD05_EDITORIAL(ideditorial) 
    
)
PARTITION BY HASH (dni)
(  PARTITION p1,
   PARTITION p2,
   PARTITION p3 )
;

--TABLA TRADUCTOR(dni, nombre, telefono, idioma, tarifa, nivel)
CREATE TABLE ABD05_TRADUCTOR(
  dni char(9),
  nombre varchar(30) not null,
  telefono number (9),
  idioma varchar(30) ,
  tarifa number(6,2) not null,
  nivel number(1) default 1 not null check (nivel in (1,2,3,4,5)) ,
  
  constraint traductor_pk primary key(dni),
  constraint traductor_idioma check (idioma in('alemán', 'francés','inglés', 'italiano'))
)
PARTITION BY LIST (idioma)
(
  PARTITION idioma_aleman values('alemán')
);

ALTER TABLE ABD05_TRADUCTOR ADD PARTITION idioma_frances VALUES ('francés');
ALTER TABLE ABD05_TRADUCTOR ADD PARTITION idioma_ingles VALUES ('inglés');
ALTER TABLE ABD05_TRADUCTOR ADD PARTITION idioma_italiano VALUES ('italiano');


--TABLA PUBLICACION (editorial, traduccion, anyo, formato, isbn, paginas, precio, ilustrada,empleado_editor)
CREATE TABLE ABD05_PUBLICACION(
  editorial number(4) not null,
  traduccion number(4)not null,
  anyo date not null,
  formato varchar(30) not null,
  isbn number(13) unique not null,
  paginas number(10) default 1,
  precio number(3,2) not null,
  ilustrada number(1) default 0,
  empleado_editor char(9) not null,
  
  constraint publicacion_pk primary key (editorial, traduccion, anyo, formato),
  constraint publicacion_fk_editorial foreign key(editorial) references ABD05_EDITORIAL(ideditorial),
  constraint publicacion_fk_traduccion foreign key(traduccion) references ABD05_TRADUCCION(numtraduccion),
  constraint publicacion_fk_empleado foreign key(empleado_editor) references ABD05_EMPLEADO(dni),
  constraint publicacion_formato check (formato in ('bolsillo','normal'))
  
)
/*PUBLICACIÓN ha de estar particionada según el formato en dos particiones, BOLSILLO y
TAPADURA. A su vez, cada una de ellas debe contener con 3 subparticiones, según el número
de páginas: menos de 150 páginas BREVE, entre 150 y 400 página ESTANDAR y más de 400
páginas LARGA.*/
PARTITION BY LIST (formato) 
SUBPARTITION BY range(paginas)
  SUBPARTITION TEMPLATE
  (
    SUBPARTITION publi_breve values less than(150),
    SUBPARTITION publi_estandar values less than(400),
    SUBPARTITION publi_larga values less than(maxvalue)
  )
(
  PARTITION publi_bol values ('bolsillo'),
  PARTITION publi_norm values ('normal')
);

alter tablespace ABD05_DATOS add datafile 'ABD05_DATOS2.DBF' size 512k;

/*
3.3. Mostrar con un SELECT los tablespaces donde se ha creado todas las tablas, particiones y
subparticiones (nombre de la tabla, nombre de la partición, nombre de la
subpartición, y nombre del tablespace de la tabla o partición o subpartición).
*/

select tablespace_name "nombre tablespace", table_name nombre , partition_name particion , ' ' subparticion 
from user_tab_partitions
union all
select tablespace_name nombre_tablespace, table_name nombre , partition_name particion , subpartition_name subparticion
from user_tab_subpartitions;

/*
3.4. Mostrar con un SELECT las restricciones de integridad de clave primaria de las tablas creadas
(nombre de la tabla, nombre de la clave primaria, columna que forma parte de la
clave primaria).
*/

select table_name "nombre tabla", constraint_name "nombre de clave primaria", column_name "columna pertenencia pk"
from user_cons_columns 
where constraint_name like '%PK%';

/*
3.5. Mostrar con un SELECT las restricciones de integridad de clave ajena (externa) de las tablas
creadas (nombre de la tabla, nombre de la clave ajena, columna que forma parte de la
clave ajena, y nombre de la clave primaria o clave única a la que apunta).

*/

select con.table_name "nombre tabla", con.constraint_name "nombre clave ajena", col.column_name "columna pertenencia fk", con.r_constraint_name "nombre pk referencia"
from user_constraints con inner join user_cons_columns col 
  on con.r_constraint_name=col.constraint_name;
  

/*
3.6. Mostrar con un SELECT las restricciones de integridad de tipo CHECK de las tablas creadas (nombre
de la tabla, nombre de la restricción, y condición de la restricción).
*/

select table_name "nombre tabla", constraint_name "nombre restriccion", search_condition "condicion de la restriccion" 
from user_constraints 
where constraint_type ='C';
  