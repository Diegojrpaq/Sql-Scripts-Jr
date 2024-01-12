set @ParamIdRuta = 288


/*busqueda de guias para embarcar por sucursal con filtro de destinos finales*/
select vg.id, 
vg.referencia,
cp.sucursal_principal_id, 
sp.nombre, 
vg.fecha_registro, 
vg.sucursal_principal_ubicacion_id,
sp2.nombre as sucursal_ubicacion,
vg.sucursal_destino_id ,
sp3.nombre as sucursal_destino,
vg.llego,
ip.llego as llego_inventario,
ip.entrego as entrego_inventario
from viaje_guia vg
inner join cotizacion_principal cp on cp.id= vg.cotizacion_principal_id 
and vg.sucursal_principal_ubicacion_id  <> vg.sucursal_destino_id 
and vg.fecha_registro between adddate(current_date(), interval -90 day)  and current_date()
and vg.sucursal_principal_ubicacion_id in (select rcs.sucursal_principal_id 
from ruta_config_sucursal rcs 
where rcs.ruta_principal_id = @ParamIdRuta )
and vg.llego = 0
inner join sucursal_principal sp on sp.id = cp.sucursal_principal_id 
inner join sucursal_principal sp2 on sp2.id = vg.sucursal_principal_ubicacion_id 
inner join sucursal_principal sp3 on sp3.id = vg.sucursal_destino_id 
inner join inventario_principal ip on ip.cotizacion_principal_id = vg.cotizacion_principal_id 
and (ip.llego = 0 or ip.entrego = 0)
where referencia not like "mei%"
and vg.cotizacion_prinicpal_destino_id  in (SELECT dp.id
FROM destino_principal dp  
WHERE FIND_IN_SET(dp.id, REPLACE((select rp.orden_parada
from ruta_principal rp
where rp.id = @ParamIdRuta ), ';', ',')))
order by vg.sucursal_principal_ubicacion_id,  vg.fecha_registro 



/*busqueda de guias para embarcar sin filtro de destino final */

select vg.id, 
vg.referencia,
cp.sucursal_principal_id, 
sp.nombre, 
vg.fecha_registro, 
vg.sucursal_principal_ubicacion_id,
sp2.nombre as sucursal_ubicacion,
vg.sucursal_destino_id ,
sp3.nombre as sucursal_destino,
vg.llego,
ip.llego as llego_inventario,
ip.entrego as entrego_inventario
from viaje_guia vg
inner join cotizacion_principal cp on cp.id= vg.cotizacion_principal_id 
and vg.sucursal_principal_ubicacion_id  <> vg.sucursal_destino_id 
and vg.fecha_registro between adddate(current_date(), interval -90 day)  and current_date()
and vg.sucursal_principal_ubicacion_id in (select rcs.sucursal_principal_id 
from ruta_config_sucursal rcs 
where rcs.ruta_principal_id = @ParamIdRuta )
and vg.llego = 0
inner join sucursal_principal sp on sp.id = cp.sucursal_principal_id 
inner join sucursal_principal sp2 on sp2.id = vg.sucursal_principal_ubicacion_id 
inner join sucursal_principal sp3 on sp3.id = vg.sucursal_destino_id 
inner join inventario_principal ip on ip.cotizacion_principal_id = vg.cotizacion_principal_id 
and (ip.llego = 0 or ip.entrego = 0)
where referencia not like "mei%"
order by vg.sucursal_principal_ubicacion_id,  vg.fecha_registro 

/*busqueda de guias para embarcar por sucursal con filtro de destinos finales modificada para webdev*/

select 
vg.referencia,
cp.sucursal_principal_id, 
sp.nombre as sucursal_principal, 
vg.viaje_operacion_id,
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
cp.subtotal
from viaje_guia vg
inner join cotizacion_principal cp on cp.id= vg.cotizacion_principal_id 
and vg.sucursal_principal_ubicacion_id  <> vg.sucursal_destino_id 
and vg.fecha_registro between adddate(current_date(), interval -90 day)  and current_date()
and vg.sucursal_principal_ubicacion_id in (select rcs.sucursal_principal_id 
from ruta_config_sucursal rcs 
where rcs.ruta_principal_id = @ParamIdRuta )
and vg.llego = 0
inner join sucursal_principal sp on sp.id = cp.sucursal_principal_id 
inner join sucursal_principal sp2 on sp2.id = vg.sucursal_principal_ubicacion_id 
inner join sucursal_principal sp3 on sp3.id = vg.sucursal_destino_id 
inner join inventario_principal ip on ip.cotizacion_principal_id = vg.cotizacion_principal_id 
inner join destino_principal dp2 on dp2.id = cp.origen_id 
inner join destino_principal dp3 on dp3.id = cp.destino_id  
and (ip.llego = 0 or ip.entrego = 0)
where vg.referencia not like "mei%"
and vg.cotizacion_prinicpal_destino_id  in 
(SELECT dp.id
FROM destino_principal dp  
WHERE FIND_IN_SET(dp.id, REPLACE((select rp.orden_parada
from ruta_principal rp
where rp.id = @ParamIdRuta ), ';', ',')))
order by vg.sucursal_principal_ubicacion_id,  vg.fecha_registro 





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
cp.subtotal
from viaje_guia vg
inner join cotizacion_principal cp on cp.id= vg.cotizacion_principal_id 
and vg.viaje_operacion_id in (1,19)
and vg.sucursal_principal_ubicacion_id  <> vg.sucursal_destino_id 
and vg.fecha_registro between adddate(current_date(), interval -90 day)  and current_date()
and vg.sucursal_principal_ubicacion_id in (select rcs.sucursal_principal_id 
from ruta_config_sucursal rcs 
where rcs.ruta_principal_id = ?)
and vg.llego = 0
inner join sucursal_principal sp on sp.id = cp.sucursal_principal_id 
inner join sucursal_principal sp2 on sp2.id = vg.sucursal_principal_ubicacion_id 
inner join sucursal_principal sp3 on sp3.id = vg.sucursal_destino_id 
inner join inventario_principal ip on ip.cotizacion_principal_id = vg.cotizacion_principal_id 
inner join destino_principal dp2 on dp2.id = cp.origen_id 
inner join destino_principal dp3 on dp3.id = cp.destino_id  
and (ip.llego = 0 or ip.entrego = 0)
where vg.referencia not like "mei%"
and vg.cotizacion_prinicpal_destino_id  in 
(SELECT dp.id
FROM destino_principal dp  
WHERE FIND_IN_SET(dp.id, REPLACE((select rp.orden_parada
from ruta_principal rp
where rp.id = ?), ';', ',')))
order by vg.sucursal_principal_ubicacion_id,  vg.fecha_registro 


/*consulta de carga viaje */
select vg.referencia, 
cp.sucursal_principal_id , 
sp.nombre as sucursal_principal,
vg.sucursal_destino_id,
sp2.nombre as sucursal_destino ,
vg.fecha_registro ,
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
and vg.viaje_ruta_id = 55633
inner join sucursal_principal sp on sp.id = cp.sucursal_principal_id 
inner join sucursal_principal sp2 on sp2.id = cp.sucursal_principal_destino_id  
group by vg.referencia 
order by dp.nombre

/*Consulta de carga viaje unida con la especificacion de empaque */
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
cmd.cantidad_caja 
from viaje_guia vg
inner join cotizacion_principal cp on cp.id= vg.cotizacion_principal_id 
inner join cotizacion_monto_detalle cmd on cmd.cotizacion_principal_id = vg.cotizacion_principal_id 
and vg.viaje_operacion_id in (1,19)
and vg.sucursal_principal_ubicacion_id  <> vg.sucursal_destino_id 
and vg.fecha_registro between adddate(current_date(), interval -90 day)  and current_date()
and vg.sucursal_principal_ubicacion_id in (select rcs.sucursal_principal_id 
from ruta_config_sucursal rcs 
where rcs.ruta_principal_id = ? )
and vg.llego = 0
inner join sucursal_principal sp on sp.id = cp.sucursal_principal_id 
inner join sucursal_principal sp2 on sp2.id = vg.sucursal_principal_ubicacion_id 
inner join sucursal_principal sp3 on sp3.id = vg.sucursal_destino_id 
inner join inventario_principal ip on ip.cotizacion_principal_id = vg.cotizacion_principal_id 
inner join destino_principal dp2 on dp2.id = cp.origen_id 
inner join destino_principal dp3 on dp3.id = cp.destino_id  
and (ip.llego = 0 or ip.entrego = 0)
where referencia not like "mei%"
and vg.cotizacion_prinicpal_destino_id  in (SELECT dp.id
FROM destino_principal dp  
WHERE FIND_IN_SET(dp.id, REPLACE((select rp.orden_parada
from ruta_principal rp
where rp.id = ? ), ';', ',')))
order by vg.sucursal_principal_ubicacion_id,  vg.fecha_registro 


/*INFOMACION DE LA RUTA UNIDA CON VIAJE Y ACTIVO*/

select 
rp.id, 
rp.nombre,
rp.Sucursal_Principal_origenID as sucursal_origen,
rp.Sucursal_Principal_DestinoID  as Sucursal_final,
vr.id as id_viaje_act,
vr.nombre as nombre_viaje_act,
vr.fecha_registro fecha_registro_viaje_act,
vr.activo_vehiculo_caja_id as idCaja,
av.clave as Clave_vehiculo,
av.Peso_carga_max,
av.Volumen_carga_max 
from ruta_principal rp 
left join viaje_ruta vr on vr.ruta_principal_id = rp.id 
and vr.viaje_estatus_id = 1
and vr.IdUbicacionActual = destino_principal_origenid 
left join activo_vehiculo av on av.id = vr.activo_vehiculo_id
where rp.id = 4


/*busqueda de cargas de caja*/
select av.clave, av.Volumen_carga_max, av.Peso_carga_max 
from activo_vehiculo av 
where av.id  = 17

/*sucursales disponibles para cada ruta*/
select rcs.sucursal_principal_id,
sp.nombre
from ruta_config_sucursal rcs 
inner join sucursal_principal sp on sp.id= rcs.sucursal_principal_id 
where rcs.ruta_principal_id = @ParamIdRuta 

/*cunsulta de carga embarcada en un viaje*/
select vg.referencia, 
cp.sucursal_principal_id as id_sucursal, 
sp.nombre as nombre_sucursal,
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
and vg.viaje_ruta_id = 55935
inner join sucursal_principal sp on sp.id = cp.sucursal_principal_id 
group by vg.referencia 
order by dp.nombre	





select * 
from viaje_ruta vg 
where vg.destino_principal_id= vg.IdUbicacionActual  
and vg.viaje_estatus_id = 1


select * 
from ruta_principal

select *
from ruta_config_sucursal rcs 

select rcs.sucursal_principal_id, sp.nombre, rcs.ruta_principal_id, rp.nombre
from ruta_config_sucursal rcs
inner join sucursal_principal sp on sp.id = rcs.sucursal_principal_id 
inner join ruta_principal rp on rp.id = rcs.ruta_principal_id 
where rcs.origen_principal_id 

select rcs.sucursal_principal_id 
from ruta_config_sucursal rcs 
where rcs.ruta_principal_id = 4 



select rp.id as id_ruta, rp.nombre, rutas.id_sucursal, rp.completa, rp.orden_parada, orden_parada_directa 
from ruta_principal rp
right join (SELECT 
rc.ruta_principal_id as id, 
rc.sucursal_principal_id as id_sucursal
FROM ruta_config_sucursal rc
INNER JOIN ruta_principal rp ON  rp.id = rc.ruta_principal_id 
AND origen_principal_id = 1
)as rutas on rutas.id = rp.id 


select rp.orden_parada
from ruta_principal rp
where rp.id = 4

//Destinos finales que se consultaran por sucursal

SELECT dp.id
FROM destino_principal dp  
WHERE FIND_IN_SET(dp.id, REPLACE((select rp.orden_parada
from ruta_principal rp
where rp.id = 4), ';', ','))

select rcs.sucursal_principal_id, sp.nombre, vg.referencia, vg.fecha_registro
from ruta_config_sucursal rcs 
inner join sucursal_principal sp 
on sp.id= rcs.sucursal_principal_id 
and rcs.ruta_principal_id = 4
inner join viaje_guia vg on vg.sucursal_destino_id = rcs.sucursal_principal_id 
and vg.fecha_registro = current_date() 



 select vg.referencia,
 sp.nombre,
 vg.fecha_registro,
 vg.viaje_operacion_id, 
 vg.viaje_estatus_id,
 vg.viaje_ubicacion_id,
 vg.sucursal_principal_ubicacion_id
 from viaje_guia vg 
 inner join cotizacion_principal cp on cp.id = vg.cotizacion_principal_id 
 and vg.fecha_registro in ('20231010')
 inner join sucursal_principal sp on sp.id= vg.sucursal_principal_ubicacion_id 
 order by referencia 
 
 select *
 from viaje_guia vg
 where referencia not like ("mei%")
 and vg.fecha_registro  between adddate(current_date(), interval -30 day)  and current_date()
 and vg.sucursal_principal_ubicacion_id  <> vg.sucursal_destino_id 
 
 SET @ParamSucursal=1;
SELECT
-- transbordos,
id
, referencia, 
-- subtotal, 
UltimaTransaccion,fecha_actualizacion, Ubicacion, origen ,Destino, Dias,subtotal,cliente ,Group_concat(Descripcion) AS Descripcion, notaIncidencia,Tipo
FROM (
SELECT
(SELECT OP.nombre FROM viaje_transacciones TR INNER JOIN viaje_operacion OP ON OP.id = TR.IdTipoOperacion and TR.cotizacion_principal_id = VG.cotizacion_principal_id ORDER BY TR.id DESC LIMIT 1) AS UltimaTransaccion,
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
INNER JOIN destino_principal UB ON UB.id = VG.viaje_ubicacion_id
INNER JOIN destino_principal ORG ON VG.cotizacion_principal_origen_id	= ORG.id
INNER JOIN destino_principal DS ON DS.id = VG.cotizacion_prinicpal_destino_id
INNER JOIN inventario_principal IP ON IP.cotizacion_principal_id = CP.id
INNER JOIN cliente_principal CL ON CL.id = CP.cliente_principal_pago_id
WHERE 
VG.cotizacion_principal_origen_id <> VG.cotizacion_prinicpal_destino_id
AND VG.cotizacion_prinicpal_destino_id <> VG.viaje_ubicacion_id
AND VG.fecha_actualizacion BETWEEN (select DATE_SUB(NOW(),INTERVAL 60 DAY)) AND (select DATE_SUB(NOW(),INTERVAL 2 DAY))
AND VG.viaje_ubicacion_id = @ParamSucursal
AND VG.referencia NOT LIKE 'MEI-%'
AND VG.llego = 0
AND VG.viaje_operacion_id = 1
AND IP.invnetario_estatus_id = 1
OR 
VG.cotizacion_principal_origen_id <> VG.cotizacion_prinicpal_destino_id
AND VG.cotizacion_principal_origen_id = VG.viaje_ubicacion_id
AND VG.fecha_actualizacion BETWEEN (select DATE_SUB(NOW(),INTERVAL 60 DAY)) AND (select DATE_SUB(NOW(),INTERVAL 1 DAY))
AND VG.viaje_ubicacion_id = @ParamSucursal
AND VG.referencia NOT LIKE 'MEI-%'
AND VG.llego = 0
AND VG.viaje_operacion_id = 1
AND IP.invnetario_estatus_id = 1
ORDER BY UBicacion,VG.fecha_actualizacion
)X
GROUP BY UltimaTransaccion,id, referencia,subtotal, fecha_actualizacion, Ubicacion, Destino, Dias, notaIncidencia
ORDER by UBicacion,fecha_actualizacion
 
 



SELECT vo.nombre 
FROM viaje_transacciones vt
INNER JOIN viaje_operacion vo ON vo.id = vt.IdTipoOperacion 
inner join viaje_guia vg on vg.cotizacion_principal_id  = vt.cotizacion_principal_id 
where vg.referencia = ""
ORDER BY vt.id 

SET @Paramguia =  'TOL-50125';



select vg.referencia, 
sp.id
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
and cp.sucursal_principal_id = 1
group by vg.referencia 
order by dp.nombre





select * 
from inventario_principal ip 
order by fecha_regsistro desc




select 
rp.id, 
rp.nombre,
rp.Sucursal_Principal_origenID as sucursal_origen,
rp.Sucursal_Principal_DestinoID  as Sucursal_final,
vr.id as id_viaje_act,
vr.nombre as nombre_viaje_act,
vr.fecha_registro fecha_registro_viaje_act,
vr.activo_vehiculo_caja_id as idCaja,
av.clave as Clave_vehiculo,
av.Peso_carga_max,
av.Volumen_carga_max 
from ruta_principal rp 
left join viaje_ruta vr on vr.ruta_principal_id = rp.id 
and vr.viaje_estatus_id = 1
left join activo_vehiculo av on av.id = vr.activo_vehiculo_id
where rp.id = 4



select *
from viaje_ruta
where id= 55211

select * 
from viaje_transacciones vt 
where viaje_principal_id = 55211

select *
from viaje_bitacora vb 
where viaje_ruta_id = 55211

/*consulta de sucursal*/
select * 
from sucursal_principal sp 

/*consulta de rutas*/
select *
from ruta_principal
where ruta_estatus_id = 1


/*consulta para insertar*/
select rcs.id,
rcs.sucursal_principal_id,
sp.nombre as nombre_sucursal_other,
rcs.cliente_principal_id ,
rcs.ruta_principal_id,
rcs.ruta_status_id,
rcs.Fecha_alta ,
rcs.fecha_modificacion ,
rcs.empleado_actualiza_id ,
rcs.empleado_alta_id,
rcs.origen_principal_id 
from ruta_config_sucursal rcs
inner join sucursal_principal sp on sp.id = rcs.sucursal_principal_id 
where ruta_principal_id= 4


/*insertar */
INSERT into ruta_config_sucursal
(
sucursal_principal_id,
cliente_principal_id,
ruta_principal_id,
ruta_status_id, 
Fecha_alta,
fecha_modificacion,
empleado_actualiza_id,
empleado_alta_id,
origen_principal_id
)
VALUES(
0/*id sucursal*/, 
46/*id cliente*/, 
4/*id de la ruta*/, 
1,/*ruta_status*/
current_date(),/*fecha_alta*/
current_date(),/*fechamodificacion*/
1,/*empleado actualiza*/ 
1,/*empleado_alta*/
1/*id_destino_origen*/);


/*delete*/
DELETE from ruta_config_sucursal
WHERE id=75;

/*update*/
update ruta_config_sucursal
SET 
sucursal_principal_id=0,
cliente_principal_id=0, 
ruta_principal_id=0, 
ruta_status_id=0,  
fecha_modificacion=current_date() ,
empleado_actualiza_id=0, 
empleado_alta_id=0, 
origen_principal_id=0
WHERE id=0;



select *
from sucursal_principal sp 

select * 
from ruta_principal rp 
where rp.ruta_estatus_id = 1 
and rp.ruta_tipo_id = 2

select * 
from sucursal_principal sp 
where sp.destino_principal_id = 3


select rp.id,
rp.nombre, 
rp.Sucursal_Principal_origenID, 
rp.Sucursal_Principal_DestinoID 
from ruta_principal rp 
where rp.id in (select rcs.ruta_principal_id 
from ruta_config_sucursal rcs 
group by rcs.ruta_principal_id )



select *
from empleado_principal ep 
left join login_principal lp on lp.id = ep.login_principal_id 
where ep.id = 1561

select *
from login_principal lp 

select * 
from cliente_principal cp



/*----------------------------------------------------------------------NUEVA SECCION DE QUERYS PARA PLANEACION VERSION 21122023----------------------------------------------------------------------------*/
/*A PARTIR DE ESTA SECCION SE SOLICITO MODIFICAR LOS QUERYS DE PLANEACION PARA HACER EL AGREGADO Y EL DESAGREGADOS DE CLIENTES CONFIGURADOS SE PROCEDIO A TRABAJAR CON LOS IDS DE LOS CLIENTES 
 * PARA UNA VERSION ANTERIOR HACER EL BORRADO DEL INNER CON LA TABLA DE CLIENTES.*/


set @idRuta = 232;
/*QUERY FINAL DE ESTA VERSION PARA MOSTRAR LA CARGA DE UNA RUTA A CON FORME A PLANEACION QUITANDO LOS CLIENTES CONFIGURADOS EN OTRAS RUTAS*/
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
and rcs.cliente_principal_id = 0
and rcs.sucursal_principal_id <>0)
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


select * 
from ruta_config_sucursal rcs
where rcs.ruta_principal_id = 232


/*148608 - gode*/
/*119 - Radial Llantas*/


select rcs.sucursal_principal_id,
sp.nombre
from ruta_config_sucursal rcs 
inner join sucursal_principal sp on sp.id= rcs.sucursal_principal_id 
where rcs.ruta_principal_id = 4


select * 
from viaje_guia vg
where vg.viaje_ruta_id = 57188

select * 
from viaje_transacciones


select 
dp.nombre,
vr.*
from viaje_ruta vr 
inner join destino_principal dp on dp.id = IdUbicacionActual 
where vr.id = '57584'

/*AQUI ABAJO ESTAN LOS QUERYS DE POCO A POCO COMO SE FORMULO EL DESCUENTO DE CLIENTES*/
/*LA LOGICA DICTA QUE EN EL PRIMER SUBQUERY SE SACA EL DESTINO ORIGEN DE UNA RUTA EN ESPECIFICO */
/*DESPUES SE PROCEDE A ENCONTRAR TODAS LAS RUTAS CON EL MISMO ORIGEN CONFIGURADAS EN LA TABLA RUTA_CONFIG_SUC Y UNA VEZ QUE SE TIENEN LOS IDS */
/*SE CONSULTAN CUALES CLIENTES ESTAN CONFIGURADOS PARA EMBARCAR EN ESA RUTA Y SE METEN EN UN NOY IN DE LOS IDS DE CLIENTES Y SE ELIMINAN ESAS GUIAS*/

select * 
from ruta_principal rp 


/*ids de las rutas configuradas que comparten origen*/
select rp.id
from ruta_principal rp 
inner join ruta_config_sucursal rcs on rcs.ruta_principal_id = rp.id
where rp.destino_principal_origenid = 
/*aqui mandamos consultar el origen de una ruta*/
(select rp2.destino_principal_origenid  
from ruta_principal rp2
where rp2.id = @idruta )
and rp.id not like @idRuta
group by id

select * 
from ruta_config_sucursal rcs 


/*este query manda llamar la planeacion de la carga*/
CALL nextpack.sp_PlaneacionCargaPorRuta(4)


/*query de los ids de clientes que tiene que descartar una ruta*/
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
and cliente_principal_id > 0



/*RESPALDO DEL QUERY ANTES DE METER EL CAMBIO DE CLIENTES */
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
where rcs.ruta_principal_id = @idRuta )
and vg.llego = 0
inner join sucursal_principal sp on sp.id = cp.sucursal_principal_id 
inner join sucursal_principal sp2 on sp2.id = vg.sucursal_principal_ubicacion_id 
inner join sucursal_principal sp3 on sp3.id = vg.sucursal_destino_id 
inner join inventario_principal ip on ip.cotizacion_principal_id = vg.cotizacion_principal_id 
inner join destino_principal dp2 on dp2.id = cp.origen_id 
inner join destino_principal dp3 on dp3.id = cp.destino_id  
and (ip.llego = 0 or ip.entrego = 0)
inner join cliente_principal clip on clip.id = cp.cliente_principal_origen_id  
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

select vg.referencia,
vg.fecha_registro, 
cp.cliente_principal_origen_id, 
cp2.nombre,
cp.origen_id,
dp.nombre as origen,
cp.destino_id ,
dp2.nombre as destino
from viaje_guia vg
inner join cotizacion_principal cp on cp.id = vg.cotizacion_principal_id
and cp.cliente_principal_origen_id = 46 
inner join cliente_principal cp2 on cp2.id = cp.cliente_principal_origen_id 
inner join destino_principal dp on dp.id = cp.origen_id 
inner join destino_principal dp2 on dp2.id = cp.destino_id 
where vg.fecha_registro = '20240109'
order by vg.fecha_registro desc

select *
from ruta_config_sucursal rcs 

select* from sucursal_principal sp 


/*query que consulta las guias de los clientes por ruta*/
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
and sucursal_principal_id <> 0)
and vg.llego = 0
inner join sucursal_principal sp on sp.id = cp.sucursal_principal_id 
inner join sucursal_principal sp2 on sp2.id = vg.sucursal_principal_ubicacion_id 
inner join sucursal_principal sp3 on sp3.id = vg.sucursal_destino_id 
inner join inventario_principal ip on ip.cotizacion_principal_id = vg.cotizacion_principal_id 
inner join destino_principal dp2 on dp2.id = cp.origen_id 
inner join destino_principal dp3 on dp3.id = cp.destino_id  
and (ip.llego = 0 or ip.entrego = 0)
inner join cliente_principal clip on clip.id = cp.cliente_principal_origen_id  
where referencia not like "mei%"
and clip.id in (select rcs.cliente_principal_id 
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
where rcs.ruta_principal_id = @idRuta )
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

/*reservando nuevo querys para permitir vizualisar los clientes 11/01/2024*/



{ CALL nextpack.sp_PlaneacionCargaPorRuta(:IdRuta) }

select * 
from ruta_config_sucursal rcs
where rcs.cliente_principal_id <> 0


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



/*query que consulta las guias de los clientes por ruta*/
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
and rcs.cliente_principal_id <> 0
group by rcs.sucursal_principal_id)
and vg.llego = 0
inner join sucursal_principal sp on sp.id = cp.sucursal_principal_id 
inner join sucursal_principal sp2 on sp2.id = vg.sucursal_principal_ubicacion_id 
inner join sucursal_principal sp3 on sp3.id = vg.sucursal_destino_id 
inner join inventario_principal ip on ip.cotizacion_principal_id = vg.cotizacion_principal_id 
inner join destino_principal dp2 on dp2.id = cp.origen_id 
inner join destino_principal dp3 on dp3.id = cp.destino_id  
and (ip.llego = 0 or ip.entrego = 0)
inner join cliente_principal clip on clip.id = cp.cliente_principal_origen_id  
where referencia not like "mei%"
and clip.id in (select rcs.cliente_principal_id 
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



select rcs.cliente_principal_id as id,
cp.nombre
from ruta_config_sucursal rcs 
inner join cliente_principal cp on cp.id= rcs.cliente_principal_id  
where rcs.ruta_principal_id = @idRuta
and rcs.sucursal_principal_id <> 0

select rcs.sucursal_principal_id,
sp.nombre
from ruta_config_sucursal rcs 
inner join sucursal_principal sp on sp.id= rcs.sucursal_principal_id 
where rcs.ruta_principal_id = @idRuta
and rcs.cliente_principal_id = 0
