/*Consulta para sacra la fecha maxima y minima de posibles en el calendario*/
select 
min(date(Fecha_registro)) as fecha_minima,
max(date(Fecha_registro)) as fecha_maxima
from viaje_ruta vr 

/*Query para seleccionar Destinos con viajes seleccionados*/
select vr.destino_principal_id as id_destino,
dp.nombre as nom_destino,
vr.id as id_viaje,
vr.nombre as nom_viaje
from viaje_ruta vr  
inner join destino_principal dp on dp.id=destino_principal_id 
where vr.fecha_registro = '20230831' 	
order by dp.nombre, vr.nombre


/*CARGA POR VIAJE SUBIDAS Y BAJADAS relacionada con destinoprincipal*/
select 
vt.viaje_principal_id as id_viaje,
vr.nombre,
vr.fecha_registro,
vr.activo_vehiculo_id,
av.clave,
av.Peso_carga_max ,
av.Volumen_carga_max ,
vr.activo_vehiculo_caja_id as idCaja,
vt.num_guia,
vt.IdTipoOperacion,
vt.Ubicacion as ubicacion_transaccion,
vt.Fecha_registro as fecha_de_transaccion,
dp.nombre as origen_cotizacion,
dp2.nombre as destino_cotizacion,
vt.destino as detino_en_ruta,
dp3.nombre as ubicacion_transaccion,
cp.cotizacion_principal_volumen,
cp.cotizacion_principal_peso ,
cp.flete,
cp.monto_seguro,
cp.subtotal
from viaje_transacciones vt  
inner join destino_principal dp on dp.id = carta_porte_origen_id 
inner join destino_principal dp2 on dp2.id=carta_porte_destino_id 
inner join destino_principal dp3 on dp3.id=vt.Viaje_ubicacion_id
inner join viaje_ruta vr on vr.id = viaje_principal_id 
inner join activo_vehiculo av on av.id = vr.activo_vehiculo_id 
inner join cotizacion_principal cp on cp.id = vt.cotizacion_principal_id 
and vt.IdTipoOperacion in (17, 18)
where vt.viaje_principal_id = 20626
group by vt.num_guia, vt.id
order by vt.Fecha_registro

/*CARGA volumen y peso de cada guia  POR VIAJE SUBIDAS Y BAJADAS unida con monto detalle */
select 
vt.viaje_principal_id as id_viaje,
vr.nombre,
date_format(vr.fecha_registro, '%d-%m-%Y') as fecha_registro  ,
vr.activo_vehiculo_id,
av.clave,
av.Peso_carga_max ,
av.Volumen_carga_max ,
vr.activo_vehiculo_caja_id as idCaja,
vt.num_guia,
vt.IdTipoOperacion,
vt.Ubicacion as ubicacion_transaccion,
date_format(vt.Fecha_registro, '%d-%m-%Y %h:%i:%s')  as fecha_de_transaccion,
vt.carta_porte_origen_id as origen_cotizacion_id,
dp.nombre as origen_cotizacion,
vt.carta_porte_destino_id as destino_cotizacion_id,
dp2.nombre as destino_cotizacion,
vt.Viaje_ubicacion_id  as ubicacion_transaccion_id,
cp.cotizacion_principal_volumen,
cp.cotizacion_principal_peso ,
cp.flete,
cp.monto_seguro,
cp.subtotal,
cmd.empaque_id,
cmd.Empaque,
cmd.cantidad_caja 
from viaje_transacciones vt 
inner join destino_principal dp on dp.id = carta_porte_origen_id 
inner join destino_principal dp2 on dp2.id=carta_porte_destino_id 
inner join viaje_ruta vr on vr.id = viaje_principal_id 
inner join activo_vehiculo av on av.id = vr.activo_vehiculo_id 
inner join cotizacion_principal cp on cp.id = vt.cotizacion_principal_id 
inner join cotizacion_monto_detalle cmd on cmd.cotizacion_principal_id = cp.id
and vt.IdTipoOperacion in (17, 18)
where vt.viaje_principal_id =  56939
group by vt.num_guia, vt.id
order by vt.Fecha_registro


/*lista de destinos que recorrio cada ruta*/
select vb.viaje_origen_id ,
dp.nombre 
from viaje_bitacora vb
inner join destino_principal dp on dp.id = vb.viaje_origen_id 
where vb.viaje_ruta_id = 56188

/*info bitacora*/
select 
vb.viaje_origen_id  as origen_id,
dp.nombre as Origen_salida,
vb.viaje_destino_id as destino_id,
dp2.nombre as Destino_llegada,
vb.KMSalida,
vb.KMLlegada ,
date_format(vb.FechaSalida , '%d-%m-%Y') as FechaSalida  ,
time_format(vb.HoraSalida, '%h:%i:%s') as HoraSalida  ,
date_format(vb.FechaLlegada, '%d-%m-%Y') as FechaLlegada  ,
time_format(vb.HoraLlegada, '%h:%i:%s') as HoraLlegada ,
vb.SelloPosterior,
vb.SelloLateral 
from viaje_bitacora vb
inner join destino_principal dp on dp.id = vb.viaje_origen_id 
inner join destino_principal dp2 on dp2.id = vb.viaje_destino_id 
where vb.viaje_ruta_id = 56743

/*activo*/
select 
vt.Ubicacion as ubicacion_transaccion
from viaje_transacciones vt  
inner join viaje_ruta vr on vr.id = viaje_principal_id 
inner join cotizacion_principal cp on cp.id = vt.cotizacion_principal_id 
inner join ruta_principal rp on rp.id = vr.ruta_principal_id 
where vt.viaje_principal_id = 31857
and vt.IdTipoOperacion in (17)
group by vt.Ubicacion
order by vt.Fecha_registro

/*encontar Caja volumenes*/
select av.clave, av.Volumen_carga_max, av.Peso_carga_max 
from activo_vehiculo av 
where av.id = 36



select *
from viaje_transacciones  vt
where  vt.num_guia ="PER-85938"

select *
from viaje_transacciones vt  
where vt.Viaje_ruta_id = 56188

select *
from viaje_transacciones vt  
where vt.Viaje_ruta_id = 56230

select * from viaje_ruta vr 
where id = 56188

select *
from ruta_principal rp 
where rp.id=239

select 
vt.viaje_principal_id, 
vr.nombre,
vr.fecha_registro,
vt.num_guia,
vt.Fecha_registro,
vt.origen,
vt.destino,
vt.ubicacion,
vt.Otros 
from viaje_transacciones vt 
inner join viaje_ruta vr on vr.id=vt.viaje_principal_id 
and vt.viaje_principal_id = 53216
group by num_guia 
order by num_guia desc



select 
vt.referencia,
vt.IdTipoOperacion, 
vt.num_guia,
vt.viaje_principal_id,
vt.Fecha_registro
from viaje_transacciones vt 
where vt.viaje_principal_id = 55686
order by num_guia desc

select *
from viaje_transacciones vt 
order by  vt.Fecha_registro  desc



select * 
from viaje_ruta vr  
where vr.id = 55886


select *
from viaje_operacion vo 

select * 
from viaje_ruta vt
order by vt.fecha_registro  desc

select *
from viaje_ruta
where id= 56167


/*lista de destinos visitados*/
select 
vt.Ubicacion as ubicacion_transaccion
from viaje_transacciones vt  
inner join destino_principal dp on dp.id = carta_porte_origen_id 
inner join destino_principal dp2 on dp2.id=carta_porte_destino_id 
inner join destino_principal dp3 on dp3.id=vt.Viaje_ubicacion_id
inner join viaje_ruta vr on vr.id = viaje_principal_id 
inner join cotizacion_principal cp on cp.id = vt.cotizacion_principal_id 
inner join ruta_principal rp on rp.id = vr.ruta_principal_id 
where vt.viaje_principal_id = 31857
and vt.IdTipoOperacion in (17, 18)
group by vt.Ubicacion
order by vt.Fecha_registro





select *
from viaje_bitacora vb 
where vb.viaje_ruta_id = 31857



CALL sp_HistoricoRutas(117, '20220831', '20220831');


select * 
from activo_vehiculo av 
where clave like 'R%'

select *
from viaje_ruta vr 
where fecha_registro = "20231013"
and vr.destino_principal_id = 20


select *
from viaje_transacciones vt 

select *
from viaje_bitacora vb 



select 
vt.num_guia 
from viaje_transacciones vt  
inner join 
where  vt.IdTipoOperacion in (17, 18)
and vt.viaje_principal_id = 56210
group by vt.num_guia
order by vt.Fecha_registro



select * from sucursal_principal sp 



/*CARGA volumen y peso de cada guia  POR VIAJE SUBIDAS Y BAJADAS unida sin monto detalle */
select 
vt.viaje_principal_id as id_viaje,
vr.nombre,
date_format(vr.fecha_registro, '%d-%m-%Y') as fecha_registro  ,
vr.activo_vehiculo_id,
av.clave,
av.Peso_carga_max ,
av.Volumen_carga_max ,
vr.activo_vehiculo_caja_id as idCaja,
vt.num_guia,
vt.IdTipoOperacion,
vt.Ubicacion as ubicacion_transaccion,
date_format(vt.Fecha_registro, '%d-%m-%Y %h:%i:%s')  as fecha_de_transaccion,
vt.carta_porte_origen_id as origen_cotizacion_id,
dp.nombre as origen_cotizacion,
vt.carta_porte_destino_id as destino_cotizacion_id,
dp2.nombre as destino_cotizacion,
vt.Viaje_ubicacion_id  as ubicacion_transaccion_id,
cp.cotizacion_principal_volumen,
cp.cotizacion_principal_peso ,
cp.flete,
cp.monto_seguro,
cp.subtotal
from viaje_transacciones vt 
inner join destino_principal dp on dp.id = carta_porte_origen_id 
inner join destino_principal dp2 on dp2.id=carta_porte_destino_id 
inner join viaje_ruta vr on vr.id = viaje_principal_id 
inner join activo_vehiculo av on av.id = vr.activo_vehiculo_id 
inner join cotizacion_principal cp on cp.id = vt.cotizacion_principal_id 
and vt.IdTipoOperacion in (17, 18)
where vt.viaje_principal_id =  56939
group by vt.num_guia, vt.IdTipoOperacion 
order by vt.Fecha_registro

/*version corregida al dia 07122023 carga volumen y peso de acada guis con moto detalle*/
select 
vt.viaje_principal_id as id_viaje,
vr.nombre,
date_format(vr.fecha_registro, '%d-%m-%Y') as fecha_registro  ,
vr.activo_vehiculo_id,
av.clave,
av.Peso_carga_max ,
av.Volumen_carga_max ,
vr.activo_vehiculo_caja_id as idCaja,
vt.num_guia,
vt.IdTipoOperacion,
vt.Ubicacion as ubicacion_transaccion,
date_format(vt.Fecha_registro, '%d-%m-%Y %h:%i:%s')  as fecha_de_transaccion,
vt.carta_porte_origen_id as origen_cotizacion_id,
dp.nombre as origen_cotizacion,
vt.carta_porte_destino_id as destino_cotizacion_id,
dp2.nombre as destino_cotizacion,
vt.Viaje_ubicacion_id  as ubicacion_transaccion_id,
cp.cotizacion_principal_volumen,
cp.cotizacion_principal_peso ,
cp.flete,
cp.monto_seguro,
cp.subtotal,
cmd.empaque_id,
cmd.Empaque,
cmd.cantidad_caja 
from viaje_transacciones vt 
inner join destino_principal dp on dp.id = carta_porte_origen_id 
inner join destino_principal dp2 on dp2.id=carta_porte_destino_id 
inner join viaje_ruta vr on vr.id = viaje_principal_id 
inner join activo_vehiculo av on av.id = vr.activo_vehiculo_id 
inner join cotizacion_principal cp on cp.id = vt.cotizacion_principal_id 
inner join cotizacion_monto_detalle cmd on cmd.cotizacion_principal_id = cp.id
and vt.IdTipoOperacion in (17, 18)
where vt.viaje_principal_id = 52921
group by vt.num_guia, vt.IdTipoOperacion 
order by vt.Fecha_registro




/*version unida con clientes para el camion volcado al dia 15122023 carga volumen y peso de acada guis con moto detalle*/
select 
vt.viaje_principal_id as id_viaje,
vr.nombre,
date_format(vr.fecha_registro, '%d-%m-%Y') as fecha_registro  ,
vr.activo_vehiculo_id,
av.clave,
av.Peso_carga_max ,
av.Volumen_carga_max ,
vr.activo_vehiculo_caja_id as idCaja,
vt.num_guia,
cp.cliente_principal_origen_id as idClienteOrigen,
clip.nombre as clienteOrigen,
cp.cliente_destino_id as idClienteDestino,
clip2.nombre as clienteDestino,
vt.IdTipoOperacion,
vt.Ubicacion as ubicacion_transaccion,
date_format(vt.Fecha_registro, '%d-%m-%Y %h:%i:%s')  as fecha_de_transaccion,
vt.carta_porte_origen_id as origen_cotizacion_id,
dp.nombre as origen_cotizacion,
vt.carta_porte_destino_id as destino_cotizacion_id,
dp2.nombre as destino_cotizacion,
vt.Viaje_ubicacion_id  as ubicacion_transaccion_id,
cp.cotizacion_principal_volumen,
cp.cotizacion_principal_peso ,
cp.flete,
cp.monto_seguro,
cp.subtotal,
cmd.empaque_id,
cmd.Empaque,
cmd.cantidad_caja 
from viaje_transacciones vt 
inner join destino_principal dp on dp.id = carta_porte_origen_id 
inner join destino_principal dp2 on dp2.id=carta_porte_destino_id 
inner join viaje_ruta vr on vr.id = viaje_principal_id 
inner join activo_vehiculo av on av.id = vr.activo_vehiculo_id 
inner join cotizacion_principal cp on cp.id = vt.cotizacion_principal_id 
inner join cotizacion_monto_detalle cmd on cmd.cotizacion_principal_id = cp.id
and vt.IdTipoOperacion in (17)
inner join cliente_principal clip on clip.id = cp.cliente_principal_origen_id 
inner join cliente_principal clip2 on clip2.id = cp.cliente_destino_id 
where vt.viaje_principal_id = 57407
group by vt.num_guia, vt.IdTipoOperacion 
order by vt.Fecha_registro



/*modificacion de query para carga sumando el monto detalle cambio : 23/01/2024*/
select 
vt.viaje_principal_id as id_viaje,
vr.nombre,
date_format(vr.fecha_registro, '%d-%m-%Y') as fecha_registro  ,
vr.activo_vehiculo_id,
av.clave,
av.Peso_carga_max ,
av.Volumen_carga_max ,
vr.activo_vehiculo_caja_id as idCaja,
vt.num_guia,
vt.IdTipoOperacion,
vt.Ubicacion as ubicacion_transaccion,
date_format(vt.Fecha_registro, '%d-%m-%Y %h:%i:%s')  as fecha_de_transaccion,
vt.carta_porte_origen_id as origen_cotizacion_id,
dp.nombre as origen_cotizacion,
vt.carta_porte_destino_id as destino_cotizacion_id,
dp2.nombre as destino_cotizacion,
vt.Viaje_ubicacion_id  as ubicacion_transaccion_id,
cp.cotizacion_principal_volumen,
cp.cotizacion_principal_peso ,
cp.flete,
cp.monto_seguro,
cp.subtotal,
cmd.empaque_id,
cmd.Empaque,
sum(cmd.cantidad_caja) as cantidad_caja
from viaje_transacciones vt 
inner join destino_principal dp on dp.id = carta_porte_origen_id 
inner join destino_principal dp2 on dp2.id=carta_porte_destino_id 
inner join viaje_ruta vr on vr.id = viaje_principal_id 
inner join activo_vehiculo av on av.id = vr.activo_vehiculo_id 
inner join cotizacion_principal cp on cp.id = vt.cotizacion_principal_id 
inner join cotizacion_monto_detalle cmd on cmd.cotizacion_principal_id = cp.id
and vt.IdTipoOperacion in (17, 18)
where vt.viaje_principal_id = @idViaje
group by vt.num_guia, vt.IdTipoOperacion
order by vt.Fecha_registro
