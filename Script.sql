select * 
from viaje_ruta vr 
where vr.id = 58499

select * 
from viaje_transbordaclaves vt 


select *
from ruta_config_sucursal rcs 
where ruta_principal_id  = 232


select *
from sucursal_principal sp 

select * from 
cliente_principal cp 
where nombre like "%fleximatic%"

Select 
	cotizacion_principal.num_guia AS Guia,
	destino_principal.nombre As Destino,
	cliente_principal.nombre AS Cliente,
	viaje_guia.cotizacion_principal_id as IdCotizacion,
	cotizacion_principal.cotizacion_principal_volumen AS volumen,
	cotizacion_principal.cotizacion_principal_peso AS peso,
	cotizacion_principal.cotizacion_principal_cantidad_envios AS Piezas,
	cotizacion_principal.con_servicio_express AS express,
	cotizacion_principal.Incidencia As Incidencia,
	viaje_guia.Id AS IdViajeGuia
	from viaje_guia
	INNER JOIN cotizacion_principal ON cotizacion_principal.id = viaje_guia.cotizacion_principal_id
	inner join destino_principal ON viaje_guia.cotizacion_prinicpal_destino_id = destino_principal.id
	LEFT JOIN cliente_principal ON cliente_principal.id = cotizacion_principal.cliente_destino_id
	INNER JOIN inventario_principal on cotizacion_principal.num_guia = inventario_principal.numguia 
	and inventario_principal.invnetario_estatus_id=1
	WHERE viaje_guia.sucursal_principal_ubicacion_id = 5
	AND viaje_guia.viaje_operacion_id = 1
	and cotizacion_principal.num_guia  = "per-87570"
	
	select *
	from viaje_guia vg
	where vg.referencia = "per-87570"
	
	select invnetario_estatus_id 
	from inventario_principal ip 
	
	
	select *
	from ruta_principal rp 
	where ruta_tipo_id = 1
	and ruta_estatus_id = 1
	and nombre  like "%per%"
	
select * from 
viaje_operacion vo 





select * 
from  viaje_guia  cp 
where cp.referencia  = "zap-50295"



select cp.num_guia, cp.cotizacion_estatus_id 
from cotizacion_principal cp 
where cp.num_guia = "ZAP-50238"

select * from viaje_transacciones vt 
where vt.num_guia= "per-87168"

select * 
from cotizacion_estatus ce 