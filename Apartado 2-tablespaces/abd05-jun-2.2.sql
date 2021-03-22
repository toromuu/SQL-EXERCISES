/*
2.2.Crear un tablespace permanente para los �ndices llamado ABDXX_INDICES, usando el fichero
�ABDXX_INDICES1.DBF�, 
con un tama�o inicial de 512 KB, que pueda crecer autom�ticamente hasta tama�o m�ximo de 1MB, 
con gesti�n manual del espacio de los segmentos, 
y con un valor por defecto de 32KB para todas las extensiones de todos los objetos que se creen en �l. 

Importante: Si durante la realizaci�n de los ejercicios posteriores de esta pr�ctica el tablespace se llenara, justo en
ese momento, se deber� a�adir al tablespace un segundo fichero �ABDXX_INDICES2.DBF� con las
mismas caracter�sticas de espacio que el primero. 
*/

CREATE TABLESPACE  ABD05_INDICES 
DATAFILE 'ABD05_INDICES1.DBF' 
  SIZE 512K
  AUTOEXTEND ON MAXSIZE 1M
  EXTENT MANAGEMENT LOCAL UNIFORM SIZE 32K 
  SEGMENT SPACE MANAGEMENT MANUAL ;
