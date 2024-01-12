SELECT  
viaje_ruta.id AS IDViaje,
activo_vehiculo.id AS IdVehiculo,
activo_vehiculo.clave,
activo_vehiculo.Kilometros_Actual,
destino_principal.nombre
FROM viaje_ruta INNER JOIN activo_vehiculo ON  activo_vehiculo.id = viaje_ruta.activo_vehiculo_id
INNER JOIN destino_principal ON destino_principal.id = viaje_ruta.destino_principal_id
WHERE
activo_vehiculo.clave= 'JR11'
AND viaje_ruta.viaje_estatus_id = 1

describe viaje_ruta 

select * from viaje_ruta where viaje_estatus_id =1;

describe log_error 

select count(*) from log_error 


select * from log_error


select count(*)   from cxc_principal where fecha_registro = '20230519' 




