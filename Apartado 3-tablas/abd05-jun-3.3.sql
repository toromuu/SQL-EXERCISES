/*
3.3. Mostrar con un SELECT los tablespaces donde se ha creado todas las tablas, particiones y
subparticiones (nombre de la tabla, nombre de la partici�n, nombre de la
subpartici�n, y nombre del tablespace de la tabla o partici�n o subpartici�n).
*/

select tablespace_name "nombre tablespace", table_name nombre , partition_name particion , ' ' subparticion 
from user_tab_partitions
union all
select tablespace_name nombre_tablespace, table_name nombre , partition_name particion , subpartition_name subparticion
from user_tab_subpartitions;

