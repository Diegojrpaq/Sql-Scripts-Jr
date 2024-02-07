set @IdRuta= 4;

select 
vg.referencia,
cp.sucursal_principal_id, 
sp.nombre as sucursal_principal, 
vg.fecha_registro, 
vg.sucursal_principal_ubicacion_id as sucursal_ubicacion_id,
sp2.nombre as sucursal_ubicacion,
vg.sucursal_destino_id ,
sp3.nombre as sucursal_destino,
cp.origen_id,
dp2.nombre as destino_origen,
cp.destino_id,
dp2.nombre as destino_final,
cp.cotizacion_principal_volumen,
cp.cotizacion_principal_peso ,
cp.flete,
cp.monto_seguro,
cp.subtotal,
cmd.empaque_id,
cmd.Empaque,
sum(cmd.cantidad_caja) as cantidad_caja,
clip.id as idCliente,
clip.nombre as clienteOrigen
from viaje_guia vg
inner join cotizacion_principal cp on cp.id= vg.cotizacion_principal_id 
inner join cotizacion_monto_detalle cmd on cmd.cotizacion_principal_id = vg.cotizacion_principal_id 
and vg.viaje_operacion_id in (1,19,24)
and vg.sucursal_principal_ubicacion_id  <> vg.sucursal_destino_id 
and vg.fecha_registro between adddate(current_date(), interval -90 day)  and current_date()
and vg.sucursal_principal_ubicacion_id in (select rcs.sucursal_principal_id 
from ruta_config_sucursal rcs 
where rcs.ruta_principal_id = @IdRuta 
and rcs.sucursal_principal_id <> 0
and rcs.cliente_principal_id = 0)
and vg.llego = 0
inner join sucursal_principal sp on sp.id = cp.sucursal_principal_id 
inner join sucursal_principal sp2 on sp2.id = vg.sucursal_principal_ubicacion_id 
inner join sucursal_principal sp3 on sp3.id = vg.sucursal_destino_id 
inner join inventario_principal ip on ip.cotizacion_principal_id = vg.cotizacion_principal_id 
inner join destino_principal dp2 on dp2.id = cp.origen_id 
inner join destino_principal dp3 on dp3.id = cp.destino_id  
and (ip.llego = 0 or ip.entrego = 0)
inner join cliente_principal clip on clip.id = cp.cliente_principal_origen_id  
and clip.id not in(/*query de los ids de clientes que tiene que descartar una ruta*/
select rcs.cliente_principal_id 
from ruta_config_sucursal rcs 
where rcs.ruta_principal_id in (
/*ids de las rutas configuradas que comparten origen*/
select rp.id
from ruta_principal rp 
inner join ruta_config_sucursal rcs on rcs.ruta_principal_id = rp.id
where rp.destino_principal_origenid = 
/*aqui mandamos consultar el origen de una ruta*/
(select rp2.destino_principal_origenid  
from ruta_principal rp2
where rp2.id = @IdRuta)
and rp.id not like @IdRuta
group by id)
and cliente_principal_id > 0
group by rcs.cliente_principal_id)
where vg.referencia not like "mei%"
and clip.id not in (select rcs.cliente_principal_id 
from ruta_config_sucursal rcs    
where rcs.ruta_principal_id = @IdRuta 
and rcs.cliente_principal_id <> 0
group by rcs.cliente_principal_id)
and vg.cotizacion_prinicpal_destino_id  in (SELECT dp.id
FROM destino_principal dp  
WHERE FIND_IN_SET(dp.id, REPLACE((select rp.orden_parada
from ruta_principal rp
where rp.id = @IdRuta ), ';', ',')))
group by vg.referencia
order by vg.sucursal_principal_ubicacion_id,  vg.fecha_registro;
