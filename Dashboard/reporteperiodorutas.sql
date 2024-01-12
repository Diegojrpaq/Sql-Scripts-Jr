select * 
from cotizacion_principal cp 
where 



select * 
from ruta_principal rp 
where ruta_estatus_id = 1


select * 
from ruta_principal rp
where rp.id = 284





select *
from viaje_transacciones vt 
where vt.Viaje_ruta_id in (select vr.id
from viaje_ruta vr 
where vr.ruta_principal_id = 284
and fecha_registro between '20231001' and '20231215'
order by fecha_registro desc)
and vt.IdTipoOperacion = 17
group by num_guia


select vt.id, 
date_format(vt.Fecha_registro, '%d')  as dia,
date_format(vt.Fecha_registro, '%m')  as mes,
date_format(vt.Fecha_registro, '%Y')  as año,
date_format(vt.Fecha_registro, '%h:%i:%s')  as horaEmbarque,
date_format(cp.fecha_registro, '%d-%m-%Y')  as fecha_registro,
vt.Viaje_ruta_id,
vt.num_guia as numGuia,
cp.origen_id as idOrigen,
dp.nombre as origen,
cp.destino_id as idDestino,
dp2.nombre as destino,
cp.cotizacion_principal_volumen as volumen,
cp.cotizacion_principal_peso as peso,
cp.flete ,
cp.monto_seguro ,
cp.subtotal, 
clip.id as idCliente,
clip.nombre as clienteNombre
from viaje_transacciones vt 
inner join cotizacion_principal cp on cp.id = vt.cotizacion_principal_id 
inner join destino_principal dp on dp.id = cp.origen_id
inner join destino_principal dp2 on dp2.id = cp.destino_id 
inner join cliente_principal clip on clip.id = cp.cliente_principal_origen_id 
where vt.Viaje_ruta_id in (select vr.id
from viaje_ruta vr 
where vr.ruta_principal_id = 4
and vt.fecha_registro between '20231001' and '20231005'
order by vt.fecha_registro desc)
and vt.IdTipoOperacion = 17
group by vt.num_guia

/*Con este query seleccionamos todas las rutas activas y foraneas */
select 
rp.id,
rp.nombre,
date_format(rp.fecha_registro, '%d-%m-%Y')  as fecha_registro,
date_format(rp.fecha_actualizacion , '%d-%m-%Y')  as fecha_actualizacion,
rp.destino_principal_origenid as idOrigen,
dp.nombre as Origen,
rp.destino_principal_destinoid as idDestino,
dp2.nombre as Destino
from ruta_principal rp 
inner join destino_principal dp on dp.id = rp.destino_principal_origenid
inner join destino_principal dp2 on dp2.id = rp.destino_principal_destinoid 
where rp.ruta_estatus_id = 1 and rp.ruta_tipo_id = 2
order by rp.id


/*Con este query seleccionamos todas las rutas activas y foraneas */
select 
rp.id,
rp.nombre,
date_format(rp.fecha_registro, '%d-%m-%Y')  as fecha_registro,
date_format(rp.fecha_actualizacion , '%d-%m-%Y')  as fecha_actualizacion,
rp.destino_principal_origenid as idOrigen,
dp.nombre as Origen,
rp.destino_principal_destinoid as idDestino,
dp2.nombre as Destino
from ruta_principal rp 
inner join destino_principal dp on dp.id = rp.destino_principal_origenid
inner join destino_principal dp2 on dp2.id = rp.destino_principal_destinoid 
where rp.ruta_estatus_id = 1 and rp.ruta_tipo_id = 2
order by rp.fecha_actualizacion 




select vt.id, 
date_format(vr.fecha_registro, '%d-%m-%Y')  as fecha_registro,
vt.Viaje_ruta_id,
sum(cp.cotizacion_principal_volumen) as volumen,
sum(cp.cotizacion_principal_peso)  as peso,
cp.flete ,
cp.monto_seguro ,
cp.subtotal, 
clip.id as idCliente,
clip.nombre as clienteNombre
from viaje_transacciones vt 
inner join cotizacion_principal cp on cp.id = vt.cotizacion_principal_id 
inner join cliente_principal clip on clip.id = cp.cliente_principal_origen_id 
inner join viaje_ruta vr on vr.id = vt.Viaje_ruta_id  
where vt.Viaje_ruta_id in (
select vr.id
from viaje_ruta vr 
where vr.ruta_principal_id = 4
and vr.fecha_registro between '20231001' and '20231005'
order by vr.fecha_registro desc
)
and vt.IdTipoOperacion = 17
group by Viaje_ruta_id


select * 
from viaje_ruta vr 
inner join (select *
from viaje_transacciones vt 
where vt.IdTipoOperacion =17
group by vt.num_guia ) as cargaXViaje on cargaXViaje.Viaje_ruta_id = vr.id 
and vr.fecha_registro between '20231001' and '20231030' 
and vr.ruta_principal_id = @idruta






set @idRuta = 4;
set @fechaInicio = 20231011;
set @fechaFin = 20231112;
/*Consulta oficial que suma por periodos las rutas para su evaluacion 
 * necesita de los parametros previamente declarados 
*/
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
and vr.fecha_registro between  @fechaInicio and @fechaFin
inner join cotizacion_principal cp on cp.id = vt.cotizacion_principal_id 
inner join (select 
vt.id as idTransacciones,
vr.nombre 
from viaje_transacciones vt  
inner join viaje_ruta vr on vr.id = viaje_principal_id 
and vr.fecha_registro between  @fechaInicio and @fechaFin
and vr.ruta_principal_id = @idRuta
inner join cotizacion_principal cp on cp.id = vt.cotizacion_principal_id 
where vt.IdTipoOperacion in (17)
group by vt.num_guia, vr.nombre 
order by vt.viaje_principal_id, vt.Fecha_registro)
as idLimpios on vt.id = idLimpios.idTransacciones
inner join destino_principal dp on dp.id=vr.destino_principal_id 
where vt.IdTipoOperacion in (17)
group by idViaje

