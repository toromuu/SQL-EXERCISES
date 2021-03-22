/*8.4
Mostrar con tres SELECT las estadísticas de las tablas, las estadísticas de las columnas de las tablas,
y las estadísticas de los índices.
*/

select * 
from user_tab_statistics;

select *
from user_tab_col_statistics;

select *
from user_ind_statistics;