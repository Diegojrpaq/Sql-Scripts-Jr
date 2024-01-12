describe mysql.general_log   /*Podemos visualizar el contenido de la tabla General_log que es donde se registra todas las querys ejecutadas y porque usuario*/

set global general_log='on'; /*Con esta linea prendemos el registro del log para empezar a registrar las consultas que se estan realizando*/

set global log_output='table';  /*Con esta linea establecemos que todo se registre en modo de tabla para despues poder consultarlo*/

select * from  mysql.general_log/*hacemos una consulta para ver los registros de la tabla*/


show databases;

describe diario_ventas

select * from diario_ventas order by Fecha_Documento desc ;