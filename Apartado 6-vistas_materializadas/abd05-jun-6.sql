/*6.1
Crear una vista materializada llamada ABDXX_VM_CR que para cada editorial muestre cuántas
publicaciones tiene ilustradas (la vista ha de tener las columnas: editorial, num_ilustrados), con
carga inmediata y refresco rápido (incremental) al hacer COMMIT.
    ?   Crear la vista.
    ?   Mostrar con un SELECT el contenido de la vista.
    ?   Si es necesario, refrescar los datos de la vista.
    ?   Volver a mostrar con un SELECT el contenido de la vista.
    ?   Insertar una fila correspondiente a una publicación en ilustrada para cierta editorial.
    ?   Si es necesario, volver a refrescar los datos de la vista.
    ?   Volver a mostrar con un SELECT el contenido de la vista.
    ?   Borrar la fila insertada anteriormente.
    ?   Si es necesario, volver a refrescar los datos de la vista.
    ?   Volver a mostrar con un SELECT el contenido de la vista
*/
drop materialized view log on abd05_publicacion;
drop materialized view ABD05_VM_CR;

--al ser refresh fast necesita un materialized view log (mvlog) para registrar los cambios hechos en las tablas maestras
create materialized view log
on abd05_publicacion
with primary key, rowid, sequence(ilustrada)
including new values;


create materialized view  ABD05_VM_CR
build immediate 
refresh fast on commit
as select publi.editorial, count(publi.ilustrada) as "num_ilustrados"
from abd05_publicacion publi 
where publi.ilustrada=1
group by publi.editorial;

select * from abd05_vm_cr;

insert into abd05_publicacion(editorial, traduccion, anyo, formato, isbn, paginas, precio, ilustrada,empleado_editor)
values(01,10, TO_DATE('23/03/2020', 'dd/mm/yyyy'),'normal',0237867891234,405,25,1,'48776699E');
commit;
select * from abd05_vm_cr;


delete from abd05_publicacion
where editorial=1 and traduccion=10 and ilustrada=1;
commit;
select * from abd05_vm_cr;



/*6.2
Borrar la vista y repetir el ejercicio creando la misma vista materializada pero con carga diferida y
refresco completo bajo demanda.
*/

drop materialized view log on abd05_publicacion;
drop materialized view ABD05_VM_CR;

create materialized view  ABD05_VM_CR
build deferred
refresh complete on demand 
as select publi.editorial, count(publi.ilustrada) as "num_ilustrados"
from abd05_publicacion publi 
where publi.ilustrada=1
group by publi.editorial;

select * from abd05_vm_cr;
execute dbms_mview.refresh('ABD05_VM_CR');
select * from abd05_vm_cr;

insert into abd05_publicacion(editorial, traduccion, anyo, formato, isbn, paginas, precio, ilustrada,empleado_editor)
values(01,10, TO_DATE('23/03/2020', 'dd/mm/yyyy'),'normal',0237867891234,405,25,1,'48776699E');
execute dbms_mview.refresh('ABD05_VM_CR');
select * from abd05_vm_cr;

delete from abd05_publicacion
where editorial=1 and traduccion=10 and ilustrada=1;
execute dbms_mview.refresh('ABD05_VM_CR');
select * from abd05_vm_cr;




/*6.3
.Borrar la vista y repetir el ejercicio completo, creando la misma vista materializada pero con carga
inmediata y refresco completo al hacer commit
*/

drop materialized view ABD05_VM_CR;

create materialized view  ABD05_VM_CR
build immediate 
refresh complete on commit
as select publi.editorial, count(publi.ilustrada) as "num_ilustrados"
from abd05_publicacion publi 
where publi.ilustrada=1
group by publi.editorial;

select * from abd05_vm_cr;

insert into abd05_publicacion(editorial, traduccion, anyo, formato, isbn, paginas, precio, ilustrada,empleado_editor)
values(01,10, TO_DATE('23/03/2020', 'dd/mm/yyyy'),'normal',0237867891234,405,25,1,'48776699E');
commit;
select * from abd05_vm_cr;

delete from abd05_publicacion
where editorial=1 and traduccion=10 and ilustrada=1;
commit;
select * from abd05_vm_cr;
