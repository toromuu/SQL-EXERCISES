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