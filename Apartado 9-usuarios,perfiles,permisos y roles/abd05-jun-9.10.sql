/*
9.10. Mostrar con SELECT los permisos sobre tablas concedidos a los roles (rol, tabla, privilegio).
*/

select *
from role_tab_privs
where role='ABD05_ROL';