select
ruta_principal_id,
rp.nombre,
rcs.sucursal_principal_id,
sp.nombre,
rp.orden_parada,
rp.orden_parada_directa ,
rp.completa 
from ruta_config_sucursal rcs 
inner join ruta_principal rp
on rp.id = rcs.ruta_principal_id 
inner join sucursal_principal sp
on sp.id = rcs.sucursal_principal_id 
where origen_principal_id = 1


select
rcs.ruta_principal_id,
rp.nombre
from ruta_config_sucursal rcs 
inner join ruta_principal rp
on rp.id = rcs.ruta_principal_id 
and rcs.origen_principal_id = 1 
group by rp.nombre 

select * 
from viaje_guia vg 
inner join cotizacion_principal cp on cp.id = vg.cotizacion_principal_id 
inner join ruta_config_sucursal rcs on rcs.sucursal_principal_id = cp.sucursal_principal_origen_id 
where  cotizacion_principal_origen_id in (
SELECT sp.id 
FROM destino_principal sp 
WHERE FIND_IN_SET(sp.id, REPLACE((select rp.orden_parada  
from ruta_principal rp 
where rp.id =284), ';', ','))
)



SELECT sp.id, sp.nombre 
FROM sucursal_principal sp 
WHERE FIND_IN_SET(sp.id, REPLACE((select rp.orden_parada  
from ruta_principal rp 
where rp.id =284), ';', ','))

select rp.orden_parada  
from ruta_principal rp 
where rp.id =4 


select * 
from ruta_principal rp 
where destino_principal_origenid = 1
and ruta_estatus_id = 1
and ruta_tipo_id =  


select *
from viaje_guia vg 