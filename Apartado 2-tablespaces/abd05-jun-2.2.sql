/*
2.2.Crear un tablespace permanente para los índices llamado ABDXX_INDICES, usando el fichero
‘ABDXX_INDICES1.DBF’, 
con un tamaño inicial de 512 KB, que pueda crecer automáticamente hasta tamaño máximo de 1MB, 
con gestión manual del espacio de los segmentos, 
y con un valor por defecto de 32KB para todas las extensiones de todos los objetos que se creen en él. 

Importante: Si durante la realización de los ejercicios posteriores de esta práctica el tablespace se llenara, justo en
ese momento, se deberá añadir al tablespace un segundo fichero ‘ABDXX_INDICES2.DBF’ con las
mismas características de espacio que el primero. 
*/

CREATE TABLESPACE  ABD05_INDICES 
DATAFILE 'ABD05_INDICES1.DBF' 
  SIZE 512K
  AUTOEXTEND ON MAXSIZE 1M
  EXTENT MANAGEMENT LOCAL UNIFORM SIZE 32K 
  SEGMENT SPACE MANAGEMENT MANUAL ;
