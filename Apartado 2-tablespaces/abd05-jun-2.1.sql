/*
2.1.Crear un tablespace permanente llamado ABDXX_DATOS, 
usando el fichero ‘ABDXX_DATOS1.DBF’,
con un tamaño inicial de 512KB y sin posibilidad de crecer, 
con extensiones del menor tamaño posible (justificar dicho tamaño) manejadas localmente, 
y con gestión automática del espacio de los segmentos. 

Importante: Si durante la realización de la práctica el tablespace se llenara, justo en
ese momento(no ahora), se deberá añadir al tablespace un segundo fichero ‘ABDXX_DATOS2.DBF’
con iguales características de espacio que el primero.
*/

CREATE TABLESPACE  ABD05_DATOS 
DATAFILE 'ABD05_DATOS1.DBF' 
  SIZE 512K
  AUTOEXTEND OFF
  EXTENT MANAGEMENT LOCAL UNIFORM SIZE 40K  --el tamaño minimo del tablespace gestionado por espacio de segmentos debe tener minimo 5 bloques y un bloque usa 8192 B con lo que se necesitaran 40.960B = 40K
  SEGMENT SPACE MANAGEMENT AUTO ;
