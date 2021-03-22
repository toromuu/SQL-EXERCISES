/*
4.1.Insertar varias filas en cada una de las tablas de forma que todas las tablas, particiones y subparticiones contengan alguna fila.
? En la tabla TRADUCCION, la columna numtraduccion ha de ser un número secuencial obtenido automáticamente a partir de una secuencia.
    - Crear la secuencia llamada ABDXX_ID, que comenzando por el cero (0), genere identificadores de 10 en 10, hasta un valor máximo de 1000, y sin ciclos.
? Cargar todas las tablas con datos utilizando sentencias INSERT. Para cada tabla, mostrar:
    - Los comandos INSERT.
    - Otras sentencias que hayan sido necesarias para facilitar la carga correcta de datos.
? Mostrar con diversos SELECT todas las filas insertadas en las tablas
*/

delete from abd05_editorial;
delete from abd05_empleado;
delete from abd05_libro;
delete from abd05_publicacion;
delete from abd05_traduccion;
delete from abd05_traductor;


--EDITORIAL (ideditorial, nombre, fundacion, email, empleado)
 
alter table ABD05_EDITORIAL enable constraint editorial_fk_empleado; -- activamos/desactivamos la fk de empleado
 
insert into ABD05_EDITORIAL (ideditorial, nombre,fundacion,email,empleado)
values (01,'Santillana',TO_DATE('02/10/1972', 'dd/mm/yyyy'),'santillana@gmail.com','48776699E');

insert into ABD05_EDITORIAL (ideditorial, nombre,fundacion,email,empleado)
values (02,'Alfaguara',TO_DATE('23/11/1980', 'dd/mm/yyyy'),'editorial_alfa@alfaguara.com','48888962W');

insert into ABD05_EDITORIAL (ideditorial, nombre,fundacion,email,empleado)
values (03,'Diego Marin',TO_DATE('24/05/1990', 'dd/mm/yyyy'),'diego@marin.com','48123456A');

insert into ABD05_EDITORIAL (ideditorial, nombre,fundacion,email,empleado)
values (04,'SM',TO_DATE('01/01/2000', 'dd/mm/yyyy'),'editorial_sm@sm.com','48987654C');
 
 
--EMPLEADO (dni, nombre, telefono, nacimiento, editorial, sueldo)

insert into abd05_empleado(dni,nombre,telefono,nacimiento,editorial,sueldo)
values('48776699E','Marta Sánchez García',968887766,TO_DATE('30/01/1980', 'dd/mm/yyyy'),01,1000.00);

insert into abd05_empleado(dni,nombre,telefono,nacimiento,editorial,sueldo)
values('48888962W','David Gómez Gómez',961784539,TO_DATE('03/04/1988', 'dd/mm/yyyy'),02,500.00);

insert into abd05_empleado(dni,nombre,telefono,nacimiento,editorial,sueldo)
values('48123456A','Maria Hernández Beltrán',966574838,TO_DATE('30/01/1980', 'dd/mm/yyyy'),03,100.00);

insert into abd05_empleado(dni,nombre,telefono,nacimiento,editorial,sueldo)
values('48987654C','Hugo Vidal Navarro',963896547,TO_DATE('30/01/1980', 'dd/mm/yyyy'),04,750.00);

insert into abd05_empleado(dni,nombre,telefono,nacimiento,editorial,sueldo)
values('48657294R','Alba Toledo Serrano',922675897,TO_DATE('28/02/1977', 'dd/mm/yyyy'),04,200.00);

insert into abd05_empleado(dni,nombre,telefono,nacimiento,editorial,sueldo)
values('48168293Q','Alfred Córdoba Madrid',969707070,TO_DATE('07/07/1970', 'dd/mm/yyyy'),02,300.00);

insert into abd05_empleado(dni,nombre,telefono,nacimiento,editorial,sueldo)
values('48557769Y','Julia Molina Gómez',956467658,TO_DATE('10/11/1984', 'dd/mm/yyyy'),03,450.00);

insert into abd05_empleado(dni,nombre,telefono,nacimiento,editorial,sueldo)
values('48991628H','Luis Jiménez Bueno',978542311,TO_DATE('23/08/1989', 'dd/mm/yyyy'),01,150.00);

insert into abd05_empleado(dni,nombre,telefono,nacimiento,editorial,sueldo)
values('48090909N','Miguel Templado Guerrero',902202122,TO_DATE('22/06/1978', 'dd/mm/yyyy'),04,220.00);

insert into abd05_empleado(dni,nombre,telefono,nacimiento,editorial,sueldo)
values('48881925T','Ana Escudero Latorre',961563854,TO_DATE('27/03/1969', 'dd/mm/yyyy'),02,800.00);

insert into abd05_empleado(dni,nombre,telefono,nacimiento,editorial,sueldo)
values('48174056G','Alfonso López Vázquez',965832924,TO_DATE('30/01/1977', 'dd/mm/yyyy'),01,1000.00);


--LIBRO (idlibro, titulo, genero, idioma, autor)

insert into abd05_libro(idlibro, titulo, genero, idioma, autor)
values (01,'Introducción a la Programación','didáctico','italiano','Carlo Rossi');

insert into abd05_libro(idlibro, titulo, genero, idioma, autor)
values (02,'Lo que el coronavirus se llevó','dramático','francés','Marie Babineaux');

insert into abd05_libro(idlibro, titulo, genero, idioma, autor)
values (03,'Obras de Edgar Alan Poe','lírico','inglés','Homer Smith');

insert into abd05_libro(idlibro, titulo, genero, idioma, autor)
values (04,'El perfume','épico','alemán','Süskind');

insert into abd05_libro(idlibro, titulo, genero, idioma, autor)
values (05,'Cuento de Navidad','dramático','inglés','Charles Dickens');


--PUBLICACION (editorial, traduccion, anyo, formato, isbn, paginas, precio, ilustrada,empleado_editor)

insert into abd05_publicacion(editorial, traduccion, anyo, formato, isbn, paginas, precio, ilustrada,empleado_editor)
values(01,10, TO_DATE('23/01/2020', 'dd/mm/yyyy'),'normal',0234567891234,405,50,0,'48776699E');

insert into abd05_publicacion(editorial, traduccion, anyo, formato, isbn, paginas, precio, ilustrada,empleado_editor)
values(02,20, TO_DATE('22/02/2020', 'dd/mm/yyyy'),'bolsillo',8463917534892,700,25,1,'48168293Q');

insert into abd05_publicacion(editorial, traduccion, anyo, formato, isbn, paginas, precio, ilustrada,empleado_editor)
values(04,30, TO_DATE('18/06/2019', 'dd/mm/yyyy'),'normal',9876543211237,100,20,0,'48090909N');

insert into abd05_publicacion(editorial, traduccion, anyo, formato, isbn, paginas, precio, ilustrada,empleado_editor)
values(03,40, TO_DATE('16/12/2019', 'dd/mm/yyyy'),'normal',8564738275644,399,50,1,'48123456A');

insert into abd05_publicacion(editorial, traduccion, anyo, formato, isbn, paginas, precio, ilustrada,empleado_editor)
values(04,50, TO_DATE('10/10/2019', 'dd/mm/yyyy'),'bolsillo',9563123985675,200,30,1,'48987654C');

insert into abd05_publicacion(editorial, traduccion, anyo, formato, isbn, paginas, precio, ilustrada,empleado_editor)
values(01,60, TO_DATE('30/11/2019', 'dd/mm/yyyy'),'bolsillo',8877669533224,510,50,0,'48174056G');

insert into abd05_publicacion(editorial, traduccion, anyo, formato, isbn, paginas, precio, ilustrada,empleado_editor)
values(02,70, TO_DATE('29/02/2020', 'dd/mm/yyyy'),'normal',166853349744,300,40,0,'48888962W');

insert into abd05_publicacion(editorial, traduccion, anyo, formato, isbn, paginas, precio, ilustrada,empleado_editor)
values(03,80, TO_DATE('23/01/2020', 'dd/mm/yyyy'),'bolsillo',8752945388263,700,25,1,'48557769Y');

insert into abd05_publicacion(editorial, traduccion, anyo, formato, isbn, paginas, precio, ilustrada,empleado_editor)
values(02,50, TO_DATE(SYSDATE, 'dd/mm/yyyy'),'normal',8752945388373,800,25,0,'48557769Y');


--TRADUCCION (numtraduccion, libro, traductor, editorial, titulo_traducido, anyo)

--creamos la secuencia 
create sequence ABD05_ID 
start with 0
increment by 10
minvalue 0 maxvalue 1000
nocycle;

--para disminuir el numero de secuencia:   alter sequence ABD05_ID increment by 10;
--para ver el valor actual de la secuencia...OJO al ejecutarlo se incrementa:   select ABD05_ID.nextval from dual;
 
alter table abd05_traduccion enable constraint traduccion_fk_editorial;
alter table abd05_traduccion enable constraint traduccion_fk_libro;
alter table abd05_traduccion enable constraint traduccion_fk_traductor;
 
insert into abd05_traduccion (numtraduccion,libro,traductor,editorial,titulo_traducido,anyo)
values (ABD05_ID.nextval,01,'48000001A',01,'Introducción a la programación',TO_DATE('23/10/2019', 'dd/mm/yyyy'));

insert into abd05_traduccion (numtraduccion,libro,traductor,editorial,titulo_traducido,anyo)
values (ABD05_ID.nextval,02,'48467135Y',04,'Lo que el coronavirus se llevó',TO_DATE('20/02/2020', 'dd/mm/yyyy'));

insert into abd05_traduccion (numtraduccion,libro,traductor,editorial,titulo_traducido,anyo)
values (ABD05_ID.nextval,05,'48848087W',02,'Cuento de Navidad',TO_DATE('18/05/2019', 'dd/mm/yyyy'));

insert into abd05_traduccion (numtraduccion,libro,traductor,editorial,titulo_traducido,anyo)
values (ABD05_ID.nextval,04,'48017456P',03,'El Perfume',TO_DATE('12/12/2019', 'dd/mm/yyyy'));

insert into abd05_traduccion (numtraduccion,libro,traductor,editorial,titulo_traducido,anyo)
values (ABD05_ID.nextval,03,'48003402B',04,'Obras de Edgar Allan Poe',TO_DATE('10/03/2020', 'dd/mm/yyyy'));

insert into abd05_traduccion (numtraduccion,libro,traductor,editorial,titulo_traducido,anyo)
values (ABD05_ID.nextval,02,'48674928C',03,'Lo que el coronavirus se llevó',TO_DATE('11/11/2019', 'dd/mm/yyyy'));

insert into abd05_traduccion (numtraduccion,libro,traductor,editorial,titulo_traducido,anyo)
values (ABD05_ID.nextval,01,'48738107I',02,'Introducción a la programación',TO_DATE('07/09/2019', 'dd/mm/yyyy'));

insert into abd05_traduccion (numtraduccion,libro,traductor,editorial,titulo_traducido,anyo)
values (ABD05_ID.nextval,04,'48661945R',01,'El Perfume de Süskind',TO_DATE('25/01/2019', 'dd/mm/yyyy'));

insert into abd05_traduccion (numtraduccion,libro,traductor,editorial,titulo_traducido,anyo)
values (ABD05_ID.nextval,04,'48000001A',04,'Il Profumo',TO_DATE('10/10/2019', 'dd/mm/yyyy')); --necesario para el ejercicio 8.7


--TRADUCTOR(dni, nombre, telefono, idioma, tarifa, nivel)

insert into abd05_traductor(dni,nombre,telefono,idioma,tarifa,nivel)
values('48000001A','Daniel Beltrán Parra',961712465,'italiano',50.00,3);

insert into abd05_traductor(dni,nombre,telefono,idioma,tarifa,nivel)
values('48003402B','Eva silva Fuertes',969747634,'inglés',150.00,5);

insert into abd05_traductor(dni,nombre,telefono,idioma,tarifa,nivel)
values('48674928C','Ángela Rubio Megias',967586382,'francés',20.00,2);

insert into abd05_traductor(dni,nombre,telefono,idioma,tarifa,nivel)
values('48661945R','Jose Luis Molina Cabeza',961773265,'alemán',100.00,4);

insert into abd05_traductor(dni,nombre,telefono,idioma,tarifa,nivel)
values('48467135Y','Laura Bustamante Jolie',922553344,'francés',50.00,3);

insert into abd05_traductor(dni,nombre,telefono,idioma,tarifa,nivel)
values('48738107I','Alejandro Ferrerer Nadal',968674257,'italiano',150.00,5);

insert into abd05_traductor(dni,nombre,telefono,idioma,tarifa,nivel)
values('48017456P','Derek Weber',961714612,'alemán',150.00,5);

insert into abd05_traductor(dni,nombre,telefono,idioma,tarifa,nivel)
values('48848087W','Paco Ibáñez Basarte',961712465,'inglés',10.00,1);


--Mostrar los datos introducidos

Select * from abd05_editorial;
Select * from abd05_empleado;
Select * from abd05_libro;
Select * from abd05_publicacion;
Select * from abd05_traduccion;
Select * from abd05_traductor;

