/*Con este query podemos consultar las guias en piso, se contemplan 3 estatus para el piso 1, 19 , 24
 * se implementa en los KPIs el dia 01/02/2024, los inner que tenemos demas es para visualizar los compos que estan comentados
 * */

select 
vg.referencia,
(SELECT op.nombre 
FROM viaje_transacciones tr 
INNER JOIN viaje_operacion op ON op.id = tr.IdTipoOperacion 
WHERE tr.cotizacion_principal_id = vg.cotizacion_principal_id 
ORDER BY TR.id DESC LIMIT 1) AS UltimaTransaccion,
um.fechaUltMov,
vg.viaje_operacion_id,
dp.nombre as ubicacionDestino,
 cp.sucursal_principal_id, 
 sp.nombre as sucursal_principal, 
 vg.fecha_registro,
 vg.sucursal_principal_ubicacion_id as sucursal_ubicacion_id,
 sp2.nombre as sucursal_ubicacion,
 vg.sucursal_destino_id ,
 sp3.nombre as sucursal_destino,
 cp.origen_id,
dp2.nombre as Origen,
 cp.destino_id,
dp3.nombre as Destino,
(TIMESTAMPDIFF(DAY, um.fechaUltMov,now())) AS 'Dias',
 vg.viaje_ubicacion_id as idUbicacionDestino,
-- cp.cotizacion_principal_volumen,
-- cp.cotizacion_principal_peso ,
-- cp.flete,
-- cp.monto_seguro,
 cp.subtotal,
-- cmd.empaque_id,
-- cmd.Empaque,
-- sum(cmd.cantidad_caja) as cantidad_caja,
-- clip.id as idCliente,
 clip.nombre as clienteOrigen,
 ip.llego,
 ip.entrego,
 ip.invnetario_estatus_id,
 Group_concat(
 CASE WHEN cp.quien_paga = 3 THEN Concat('|-CORTESIA-|',cp.guiaoriginal,' ',cmd.cantidad_caja,' de ',cmd.empaque,' de ',cmd.material,' ',cmd.volumen,'m') 
ELSE Concat(cmd.cantidad_caja,' de ',cmd.empaque,' de ',cmd.material,' ',cmd.volumen,'m.') END) AS Descripcion,
ip.notaIncidencia,
(CASE
	WHEN vg.cotizacion_principal_origen_id <> vg.Viaje_ubicacion_id THEN 'TRANSBORDO'
	ELSE 'VENTA' END) as TIPO
from viaje_guia vg
inner join cotizacion_principal cp on cp.id= vg.cotizacion_principal_id 
inner join cotizacion_monto_detalle cmd on cmd.cotizacion_principal_id = vg.cotizacion_principal_id 
and vg.viaje_operacion_id in (1,19,24)
and vg.sucursal_principal_ubicacion_id  <> vg.sucursal_destino_id 
and vg.fecha_registro between adddate(current_date(), interval -90 day)  and current_date()
and vg.llego = 0
inner join sucursal_principal sp on sp.id = cp.sucursal_principal_id 
inner join sucursal_principal sp2 on sp2.id = vg.sucursal_principal_ubicacion_id 
inner join sucursal_principal sp3 on sp3.id = vg.sucursal_destino_id 
inner join inventario_principal ip on ip.cotizacion_principal_id = vg.cotizacion_principal_id 
and (ip.llego = 0 or ip.entrego = 0)
inner join destino_principal dp on dp.id = vg.viaje_ubicacion_id  
inner join destino_principal dp2 on dp2.id = cp.origen_id 
inner join destino_principal dp3 on dp3.id = cp.destino_id  
inner join cliente_principal clip on clip.id = cp.cliente_principal_origen_id  
	left  join (
	 select vt.cotizacion_principal_id, max(vt.Fecha_registro) as fechaUltMov
	 from viaje_transacciones vt 
     group by vt.cotizacion_principal_id
)um -- ultimo movimiento
on vg.cotizacion_principal_id = um.cotizacion_principal_id 
where vg.referencia not like "mei%"
group by vg.referencia
order by vg.sucursal_principal_ubicacion_id,  vg.fecha_registro;
