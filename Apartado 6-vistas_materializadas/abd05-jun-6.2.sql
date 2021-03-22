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