/*Catalogo de viajes activos.- */
select
vr.id,
vr.nombre,
vr.fecha_registro,
vr.activo_vehiculo_id ,
vr.activo_vehiculo_caja_id,
dp.nombre as Destino_origen,
rp.destino_principal_origenid as  "Origen_desde_ruta",
av.clave as "Clave vehiculo",
av.Peso_carga_max,
av.Volumen_carga_max   
			from viaje_ruta vr 
			inner join destino_principal dp on dp.id = vr.destino_principal_id
			inner join ruta_principal rp on rp.id = vr.ruta_principal_id 
			inner join activo_vehiculo av on av.id = vr.activo_vehiculo_id /*hacemos un inner para saber el peso maximo y el volumen maximio*/
			/*inner join sucursal_principal sp  on sp.id  = rp.su*/
			where vr.viaje_estatus_id = 1 /*confirmamos que el viaje este activo*/
			and vr.fecha_registro  between adddate(current_date(), interval -30 day)  and current_date()
			and vr.viaje_tipo_id = 2/*viaje foreneo*/
			and vr.destino_principal_id = 3/*Este dato se tiene que sustituir con el id del destino*/
		    order by vr.fecha_registro desc, Destino_origen desc
		    
/*Catalogo de viajes activos.- */
select
vr.id,
vr.nombre,
vr.fecha_registro,
vr.activo_vehiculo_caja_id as idCaja,
av.clave as "Clave_vehiculo",
av.Peso_carga_max,
av.Volumen_carga_max   
			from viaje_ruta vr 
			inner join activo_vehiculo av on av.id = vr.activo_vehiculo_id /*hacemos un inner para saber el peso maximo y el volumen maximio*/
			/*inner join sucursal_principal sp  on sp.id  = rp.su*/
			where vr.viaje_estatus_id = 1 /*confirmamos que el viaje este activo*/
			and vr.fecha_registro  between adddate(current_date(), interval -30 day)  and current_date()
			and vr.viaje_tipo_id = 2/*viaje foreneo*/
			and vr.destino_principal_id = 1/*Este dato se tiene que sustituir con el id del destino*/
		   /* and vr.activo_vehiculo_caja_id not in("-1","0") */
			order by vr.fecha_registro desc
		    
		    
		  
		    
select vg.viaje_ruta_id,
vg.cotizacion_principal_origen_id,
sum(cmd.volumen) as volumen
from viaje_guia vg 
inner join cotizacion_monto_detalle cmd on cmd.cotizacion_principal_id = vg.cotizacion_principal_id 
and vg.viaje_ruta_id in  (select
vr.id
from viaje_ruta vr 
where vr.viaje_estatus_id = 1 /*confirmamos que el viaje este activo*/
and vr.fecha_registro  between adddate(current_date(), interval -30 day)  and current_date()
and vr.viaje_tipo_id = 2/*viaje foreneo*/
and vr.destino_principal_id = 1/*Este dato se tiene que sustituir con el id del destino*/
order by vr.fecha_registro desc) 
group by vg.viaje_ruta_id, vg.cotizacion_principal_origen_id 
order by vg.viaje_ruta_id, vg.cotizacion_principal_origen_id 

select av.clave, av.Volumen_carga_max, av.Peso_carga_max 
from activo_vehiculo av 
where av.id  = 33



select 
vg.cotizacion_prinicpal_destino_id  as idDestino, 
dp.nombre as destinoEntrega
from viaje_guia vg 
inner join destino_principal dp on dp.id = vg.cotizacion_prinicpal_destino_id 
where vg.viaje_ruta_id in (select
vr.id
from viaje_ruta vr 
where vr.viaje_estatus_id = 1 /*confirmamos que el viaje este activo*/
and vr.fecha_registro  between adddate(current_date(), interval -30 day)  and current_date()
and vr.viaje_tipo_id = 2/*viaje foreneo*/
and vr.destino_principal_id = 1/*Este dato se tiene que sustituir con el id del destino*/
order by vr.fecha_registro desc)
group by vg.cotizacion_prinicpal_destino_id 
order by vg.cotizacion_prinicpal_destino_id 


select vg.referencia, 
dp.nombre as Origen,
dp2.nombre as Destino,
sum(cmd.volumen) as volumen_guia,
cp.cotizacion_principal_volumen,
sum(cmd.peso) as peso_guia,
cp.cotizacion_principal_peso ,
cp.flete,
cp.monto_seguro,
cp.subtotal
from viaje_guia vg
inner join destino_principal dp on dp.id = vg.cotizacion_principal_origen_id 
inner join destino_principal dp2 on dp2.id = vg.cotizacion_prinicpal_destino_id 
inner join cotizacion_monto_detalle cmd on cmd.cotizacion_principal_id = vg.cotizacion_principal_id
inner join cotizacion_principal cp on cp.id = vg.cotizacion_principal_id 
and vg.viaje_ruta_id = "54289"
group by vg.referencia 
order by dp.nombre
 
select * 
from servicio_principal sp 

select * 
from viaje_guia vg  

select * 
from cotizacion_principal
order by fecha_registro desc
limit 10

select 
cp.origen_id as destino_origen_id,
cp.sucursal_principal_id, 
sp.nombre as sucursal_origen,
sp.prefijo,
SUM(SUM(cmd.volumen)) OVER(PARTITION BY cp.sucursal_principal_id) AS volumen_total_sucursal,
cp.destino_id,
dp.nombre as destino_final,
sum(cmd.volumen) as volumen_por_destino
from cotizacion_principal cp 
inner join cotizacion_monto_detalle cmd on cmd.cotizacion_principal_id = cp.id 
inner join sucursal_principal sp on sp.id = cp.sucursal_principal_id 
inner join destino_principal dp on dp.id =cp.destino_id 
where cp.fecha_registro = current_date()
and cp.cotizacion_estatus_id = 4 
and cp.num_guia not like 'mei%' 
group by cp.destino_id, cp.sucursal_principal_id 
order by cp.origen_id, cp.sucursal_principal_id , dp.nombre 


select
vr.id,
vr.nombre,
vr.fecha_registro,
vr.activo_vehiculo_caja_id as idCaja,
av.clave as "Clave_vehiculo",
av.Peso_carga_max,
av.Volumen_carga_max   
from viaje_ruta vr 
inner join activo_vehiculo av on av.id = vr.activo_vehiculo_id /*hacemos un inner para saber el peso maximo y el volumen maximio*/
/*inner join sucursal_principal sp  on sp.id  = rp.su*/
where vr.viaje_estatus_id = 1 /*confirmamos que el viaje este activo*/
and vr.fecha_registro  between adddate(current_date(), interval -30 day)  and current_date()
and vr.viaje_tipo_id = 2/*viaje foreneo*/
and vr.destino_principal_id = 1/*Este dato se tiene que sustituir con el id del destino*/
order by vr.fecha_registro desc

		    
		    
		    
		    
		    
		    
		    
		    
		    
select rc.ruta_principal_id, rp.nombre 
from ruta_config_sucursal rc
inner join ruta_principal rp on  rp.id = rc.ruta_principal_id 
and origen_principal_id = 1
group by rc.ruta_principal_id 
		    
		    
select vg.referencia, 
dp.id as idOrigen,
dp.nombre as Origen,
dp2.id as idDestino,
dp2.nombre as Destino,
vg.cotizacion_prinicpal_destino_id,
cp.cotizacion_principal_volumen,
cp.cotizacion_principal_peso ,
cp.flete,
cp.monto_seguro,
cp.subtotal
from viaje_guia vg
inner join destino_principal dp on dp.id = vg.cotizacion_principal_origen_id 
inner join destino_principal dp2 on dp2.id = vg.cotizacion_prinicpal_destino_id 
inner join cotizacion_principal cp on cp.id = vg.cotizacion_principal_id 
and vg.viaje_ruta_id in (
select
vr.id
from viaje_ruta vr 
where vr.viaje_estatus_id = 1 /*confirmamos que el viaje este activo*/
and vr.fecha_registro  between adddate(current_date(), interval -30 day)  and current_date()
and vr.viaje_tipo_id = 2/*viaje foreneo*/
and vr.destino_principal_id = 1/*Este dato se tiene que sustituir con el id del destino*/
order by vr.fecha_registro desc
)
group by idDestino
order by idDestino	   

		    
		    
		    
		    