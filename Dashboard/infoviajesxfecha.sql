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
cp.cotizacion_principal_peso,
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
and vt.IdTipoOperacion in (17)
inner join (select vr.destino_principal_id as id_destino,
dp.nombre as nom_destino,
vr.id as id_viaje,
vr.nombre as nom_viaje
from viaje_ruta vr  
inner join destino_principal dp on dp.id=destino_principal_id 
where vr.fecha_registro = '20230831' 	
order by dp.nombre, vr.nombre)as viajesxDia on vt.viaje_principal_id =  viajesxDia.id_viaje
group by vt.num_guia, vt.id
order by vt.Fecha_registro





////segundo intento

select 
vr.id as id_viaje
from viaje_ruta vr  
where vr.fecha_registro = '20230831' 	



/*CARGA POR VIAJE SUBIDAS Y BAJADAS relacionada con destinoprincipal*/
select 
vt.viaje_principal_id as id_viaje,
vr.nombre,
vr.fecha_registro,
vt.num_guia,
cp.cotizacion_principal_volumen,
cp.cotizacion_principal_peso,
cp.flete,
cp.monto_seguro,
cp.subtotal
from viaje_transacciones vt  
inner join viaje_ruta vr on vr.id = viaje_principal_id 
inner join cotizacion_principal cp on cp.id = vt.cotizacion_principal_id 
where vt.IdTipoOperacion in (17)
and vr.nombre = 'QRO-MTY'
and vt.viaje_principal_id in 
(select 
vr.id as id_viaje
from viaje_ruta vr  
where vr.fecha_registro = '20230824')
group by vt.num_guia, vt.id
order by vt.viaje_principal_id, vt.Fecha_registro



select 
vt.viaje_principal_id as idViaje,
vr.nombre,
vr.fecha_registro as fechaRegistro,
count(vt.num_guia) as cantidadGuias, 
sum(cp.cotizacion_principal_volumen) as volumenTotal,
sum(cp.cotizacion_principal_peso)as pesoTotal,
sum(cp.flete) as fleteTotal,
sum(cp.monto_seguro) as montoSeguroTotal,
sum(cp.subtotal) as subtotalTotal
from viaje_transacciones vt  
inner join viaje_ruta vr on vr.id = viaje_principal_id 
and vr.fecha_registro = '20230831'
inner join cotizacion_principal cp on cp.id = vt.cotizacion_principal_id 
where vt.IdTipoOperacion in (17)
group by vr.nombre 
order by vt.viaje_principal_id, vt.Fecha_registro


select 
vt.viaje_principal_id as id_viaje,
vr.nombre,
vr.fecha_registro,
vt.id,
vt.num_guia,
vt.Fecha_registro as fecha_transaccion,
cp.cotizacion_principal_volumen,
cp.cotizacion_principal_peso,
cp.flete,
cp.monto_seguro,
cp.subtotal
from viaje_transacciones vt  
inner join viaje_ruta vr on vr.id = viaje_principal_id 
and vr.fecha_registro = '20230824'
inner join cotizacion_principal cp on cp.id = vt.cotizacion_principal_id 
inner join (select 
vt.id as idTransacciones
from viaje_transacciones vt  
inner join viaje_ruta vr on vr.id = viaje_principal_id 
and vr.fecha_registro = '20230824'
inner join cotizacion_principal cp on cp.id = vt.cotizacion_principal_id 
where vt.IdTipoOperacion in (17)
group by vt.num_guia 
order by vt.viaje_principal_id, vt.Fecha_registro) as idLimpios on vt.id = idLimpios.idTransacciones
where vt.IdTipoOperacion in (17)
order by vt.viaje_principal_id, vt.Fecha_registro


select 
vt.viaje_principal_id as idViaje,
vr.nombre,
vr.destino_principal_id as idOrigen,
dp.nombre as Origen,
vr.fecha_registro as fechaRegistro,
count(vt.num_guia) as cantidadGuias, 
sum(cp.cotizacion_principal_volumen) as volumenTotal,
sum(cp.cotizacion_principal_peso)as pesoTotal,
sum(cp.flete) as fleteTotal,
sum(cp.monto_seguro) as montoSeguroTotal,
sum(cp.subtotal) as subtotalTotal
from viaje_transacciones vt  
inner join viaje_ruta vr on vr.id = viaje_principal_id 
and vr.fecha_registro = '20231209'
inner join cotizacion_principal cp on cp.id = vt.cotizacion_principal_id 
inner join (select 
vt.id as idTransacciones,
vr.nombre 
from viaje_transacciones vt  
inner join viaje_ruta vr on vr.id = viaje_principal_id 
and vr.fecha_registro = '20231209'
inner join cotizacion_principal cp on cp.id = vt.cotizacion_principal_id 
where vt.IdTipoOperacion in (17)
group by vt.num_guia, vr.nombre 
order by vt.viaje_principal_id, vt.Fecha_registro)
as idLimpios on vt.id = idLimpios.idTransacciones
inner join destino_principal dp on dp.id=vr.destino_principal_id 
where vt.IdTipoOperacion in (17)
group by vr.nombre 
order by vr.nombre 


select 
vt.id as idTransacciones
from viaje_transacciones vt  
inner join viaje_ruta vr on vr.id = viaje_principal_id 
and vr.fecha_registro = '20230831'
inner join cotizacion_principal cp on cp.id = vt.cotizacion_principal_id 
where vt.IdTipoOperacion in (17)
group by vt.num_guia 
order by vt.viaje_principal_id, vt.Fecha_registro

select 
vt.id as idTransacciones,
vr.id,
vr.nombre,
vt.num_guia 
from viaje_transacciones vt  
inner join viaje_ruta vr on vr.id = viaje_principal_id 
and vr.fecha_registro = '20230831'
inner join cotizacion_principal cp on cp.id = vt.cotizacion_principal_id 
where vt.IdTipoOperacion in (17)
and vr.nombre like '%AGS%'
group by vt.num_guia 
order by vt.viaje_principal_id, vt.Fecha_registro


select * from viaje_ruta vr 

select * 
from viaje_operacion vo 

select *
from ruta_principal rp 