SELECT
-- transbordos,
id
, referencia, 
-- subtotal, 
UltimaTransaccion,fecha_actualizacion, Ubicacion, origen ,Destino, Dias,subtotal,cliente ,Group_concat(Descripcion) AS Descripcion, notaIncidencia,Tipo
FROM (
SELECT
(SELECT OP.nombre FROM viaje_transacciones TR INNER JOIN viaje_operacion OP ON OP.id = TR.IdTipoOperacion WHERE TR.cotizacion_principal_id = VG.cotizacion_principal_id ORDER BY TR.id DESC LIMIT 1) AS UltimaTransaccion,
CP.id,
VG.referencia,
CASE WHEN CP.quien_paga = 3 THEN Concat('|-CORTESIA-|',CP.guiaoriginal,' ',MD.cantidad_caja,' de ',MD.empaque,' de ',MD.material,' ',MD.volumen,'m') 
ELSE Concat(MD.cantidad_caja,' de ',MD.empaque,' de ',MD.material,' ',MD.volumen,'m.') END AS Descripcion,
CP.subtotal,
VG.fecha_actualizacion,
UB.nombre AS Ubicacion,
ORG.nombre AS Origen,
DS.nombre AS Destino,
(TIMESTAMPDIFF(DAY, VG.fecha_actualizacion,now())) AS 'Dias',
IP.notaIncidencia,
CL.nombre AS cliente,
CASE
	WHEN VG.cotizacion_principal_origen_id <> vg.Viaje_ubicacion_id THEN 'TRANSBORDO'
	ELSE 'VENTA' END AS 'TIPO'	
FROM viaje_guia VG
INNER JOIN cotizacion_principal CP ON CP.id = VG.cotizacion_principal_id
INNER JOIN cotizacion_monto_detalle MD ON MD.cotizacion_principal_id = CP.id
INNER JOIN sucursal_principal UB ON UB.id = VG.sucursal_principal_ubicacion_id 
INNER JOIN destino_principal ORG ON VG.cotizacion_principal_origen_id	= ORG.id
INNER JOIN destino_principal DS ON DS.id = VG.cotizacion_prinicpal_destino_id
INNER JOIN inventario_principal IP ON IP.cotizacion_principal_id = CP.id
INNER JOIN cliente_principal CL ON CL.id = CP.cliente_principal_pago_id
WHERE 
VG.cotizacion_principal_origen_id <> VG.cotizacion_prinicpal_destino_id
AND VG.cotizacion_prinicpal_destino_id <> VG.viaje_ubicacion_id
AND VG.fecha_actualizacion BETWEEN (select DATE_SUB(NOW(),INTERVAL 60 DAY)) AND (select DATE_SUB(NOW(),INTERVAL 2 DAY))
%1
AND VG.referencia NOT LIKE 'MEI-%'
AND VG.llego = 0
AND VG.viaje_operacion_id = 1
AND IP.invnetario_estatus_id = 1
OR 
VG.cotizacion_principal_origen_id <> VG.cotizacion_prinicpal_destino_id
AND VG.cotizacion_principal_origen_id = VG.viaje_ubicacion_id
AND VG.fecha_actualizacion BETWEEN (select DATE_SUB(NOW(),INTERVAL 60 DAY)) AND (select DATE_SUB(NOW(),INTERVAL 1 DAY))
AND VG.sucursal_principal_ubicacion_id  = 18
AND VG.referencia NOT LIKE 'MEI-%'
AND VG.llego = 0
AND VG.viaje_operacion_id in (1,4)
AND IP.invnetario_estatus_id = 1
ORDER BY UBicacion,VG.fecha_actualizacion
)X
GROUP BY UltimaTransaccion,id, referencia,subtotal, fecha_actualizacion, Ubicacion, Destino, Dias, notaIncidencia
ORDER by UBicacion,fecha_actualizacion




select vg.referencia, cp.cotizacion_estatus_id, cp.fecha_registro 
from viaje_guia vg 
inner join cotizacion_principal cp on cp.id = vg.cotizacion_principal_id 
and cp.cotizacion_estatus_id in(4)
inner join inventario_principal ip on ip.cotizacion_principal_id = cp.id
and ip.invnetario_estatus_id = 1
where vg.sucursal_principal_ubicacion_id = 18
and vg.viaje_operacion_id = 1
order by cp.fecha_registro desc

select *
from inventario_principal ip 
order by ip.fecha_regsistro desc

select * 
from inventario_estatus ie 


select * from 
viaje_operacion vo 


set @idRuta = 232;
/*query listo para sucursales va a suplir el stored procedure */
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
cp.cotizacion_principal_peso ,cp.flete,
cp.monto_seguro,
cp.subtotal,
cmd.empaque_id,
cmd.Empaque,
cmd.cantidad_caja,
clip.id as idCliente,
clip.nombre as clienteOrigen
from viaje_guia vg
inner join cotizacion_principal cp on cp.id= vg.cotizacion_principal_id 
inner join cotizacion_monto_detalle cmd on cmd.cotizacion_principal_id = vg.cotizacion_principal_id 
and vg.viaje_operacion_id in (1,19)
and vg.sucursal_principal_ubicacion_id  <> vg.sucursal_destino_id 
and vg.fecha_registro between adddate(current_date(), interval -90 day)  and current_date()
and vg.sucursal_principal_ubicacion_id in (select rcs.sucursal_principal_id 
from ruta_config_sucursal rcs 
where rcs.ruta_principal_id = @idRuta 
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
where rp2.id = @idruta)
and rp.id not like @idRuta
group by id)
and cliente_principal_id > 0)
where referencia not like "mei%"
and clip.id not in (select rcs.cliente_principal_id 
from ruta_config_sucursal rcs    
where rcs.ruta_principal_id = @idRuta 
and rcs.cliente_principal_id <> 0)
and vg.cotizacion_prinicpal_destino_id  in (SELECT dp.id
FROM destino_principal dp  
WHERE FIND_IN_SET(dp.id, REPLACE((select rp.orden_parada
from ruta_principal rp
where rp.id = @idRuta ), ';', ',')))
group by vg.referencia
order by vg.sucursal_principal_ubicacion_id,  vg.fecha_registro

select vg.sucursal_principal_ubicacion_id 
from viaje_guia vg
inner join sucursal_principal sp 
where vg.referencia = "GCR-14492"



