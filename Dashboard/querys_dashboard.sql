/*en este archivo organizaremos los querys finales para el dash board que forman fragmentos del json divididos por destino */

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
			order by vr.fecha_registro desc, Destino_origen desc
			/*and vr.destino_principal_id = 1/*Este dato se tiene que sustituir con el id del destino*/
		



/*catalogo de guias.- este query crea el catalogo de guias diarias por destino */

	select vg.referencia as num_guia,
	vg.fecha_registro,
	vg.cotizacion_principal_origen_id as id_Origen,
    dp.nombre  as Origen,
    vg.cotizacion_prinicpal_destino_id as id_destino, 
    dp2.nombre as Destino, vg.cotizacion_principal_id,  
    vg.viaje_ruta_id, vg.viaje_ubicacion_id as id_ubicacion,
    dp3.nombre as Ubicacion , 
    vg.viaje_ubicacion_id, 
    vg.sucursal_principal_ubicacion_id as id_sucursal_origen, 
    sp.nombre as Sucursal_origen, 
	vg.sucursal_destino_id as sucursal_destino_id,
	sp2.nombre as sucursal_destino
            from viaje_guia vg 
            inner join destino_principal dp on dp.id=vg.cotizacion_principal_origen_id  
            inner join destino_principal dp2 on dp2.id=vg.cotizacion_prinicpal_destino_id 
            inner join destino_principal dp3 on dp3.id=vg.viaje_ubicacion_id 
            inner join sucursal_principal sp on sp.id=vg.sucursal_principal_ubicacion_id 
            inner join sucursal_principal sp2 on sp2.id=vg.sucursal_destino_id 
            where vg.fecha_registro =  current_date()  and vg.cotizacion_principal_origen_id  = 1
            order by sp.nombre, sp2.nombre 
            
            
            select *
            from destino_principal dp 
            where id in (7, 8, 10, 11, 12, 13, 15, 16, 19)
/*Catalogo de viajes activos por llegar a cada destino*/
            
    select
    vr.id,
    vr.nombre,
    vr.fecha_registro,
    dp.nombre as Destino_origen,
    rp.destino_principal_origenid as id_Destino_origen,
    dp2.nombre as Destino_termino,
    dp2.id as id_Destino_termino, 
    dp3.nombre as Ubicacion_actual,
    vr.IdUbicacionActual,
    rp.orden_parada ,
    rp.orden_parada_directa,
    rp.completa,
    rp.ID_DiasOperacion ,
    rp.Text_DiasOperacion ,
    av.clave as "Clave vehiculo",
    av.Peso_carga_max,
    av.Volumen_carga_max
from viaje_ruta vr
    inner join destino_principal dp on dp.id = vr.destino_principal_id
    inner join ruta_principal rp on rp.id = vr.ruta_principal_id
    inner join destino_principal dp2 on dp2.id = rp.destino_principal_destinoid 
    inner join activo_vehiculo av on av.id = vr.activo_vehiculo_id
    inner join destino_principal dp3 on dp3.id= vr.IdUbicacionActual 
    /*hacemos un inner para saber el peso maximo y el volumen maximio*/
where
    vr.viaje_estatus_id = 1
    /*confirmamos que el viaje este activo*/
    /*and vr.fecha_registro between adddate(
        current_date(),
        interval -30 day
    )
    and current_date()*/
    /*el viaje esta de la fecha actual a 30 dias atras*/
    and vr.viaje_tipo_id = 2
    /*viaje foreneo*/ 
     /*and rp.orden_parada_directa NOT LIKE';3;%' 
     AND rp.orden_parada_directa LIKE "%;3;%"*/
order by vr.fecha_registro desc,  rp.orden_parada_directa




select vg.referencia, vg.cotizacion_principal_id, cp.num_guia , cmd.volumen 
from viaje_guia vg 
inner join cotizacion_principal cp on cp.id = vg.cotizacion_principal_id 
and vg.viaje_ruta_id = "54290"
inner join cotizacion_monto_detalle cmd on cmd.cotizacion_principal_id = cp.id
group by referencia 


select *
from viaje_transacciones vt    
where vt.num_guia like  "ZAP-47079"
order by Fecha_registro desc

select 
cp.origen_id,
cp.sucursal_principal_id,
cp.num_guia,
cp.destino_id,
sum(cmd.volumen) 
from cotizacion_principal cp
inner join cotizacion_monto_detalle cmd on cp.id = cmd.cotizacion_principal_id 
where cp.fecha_registro = current_date() 
and cp.num_guia not like "mei%"
and cp.cotizacion_estatus_id = 4
group by cp.sucursal_principal_id 
order by cp.origen_id, cp.sucursal_principal_id 

select
vr.id,
vr.nombre,
vr.fecha_registro,
dp.nombre as Destino_origen,
rp.destino_principal_origenid as  "Origen_desde_ruta",
current_date() as fecha_actual,
current_time() as hora_server,
av.clave as "Clave vehiculo",
av.Peso_carga_max,
av.Volumen_carga_max ,
vg.cotizacion_prinicpal_destino_id,
sum(cmd.volumen)
from viaje_ruta vr 
inner join destino_principal dp on dp.id = vr.destino_principal_id
inner join ruta_principal rp on rp.id = vr.ruta_principal_id 
inner join activo_vehiculo av on av.id = vr.activo_vehiculo_id /*hacemos un inner para saber el peso maximo y el volumen maximio*/
/*inner join sucursal_principal sp  on sp.id  = rp.su*/
inner join viaje_guia vg on vg.viaje_ruta_id = vr.id
inner join cotizacion_monto_detalle cmd on cmd.cotizacion_principal_id = vg.cotizacion_principal_id 
where vr.viaje_estatus_id = 1 /*confirmamos que el viaje este activo*/
and vr.fecha_registro  between adddate(current_date(), interval -30 day)  and current_date()
/*and vr.destino_principal_id = 1/*Este dato se tiene que sustituir con el id del destino*/
and vr.viaje_tipo_id = 2/*viaje foreneo*/
group by vr.id,vg.cotizacion_prinicpal_destino_id 
order by vr.id desc, vr.fecha_registro desc, Destino_origen
		

select
    rp.destino_principal_origenid AS "Origen_desde_ruta",
    vr.id,
    vr.nombre,
    vr.fecha_registro,
    av.clave AS "Clave vehiculo",
    av.Peso_carga_max,
    av.Volumen_carga_max,
    vg.cotizacion_prinicpal_destino_id,
    dp.nombre, 
    nvl(Sum(cmd.volumen),0)
FROM viaje_ruta vr
INNER JOIN ruta_principal rp ON rp.id = vr.ruta_principal_id
INNER JOIN activo_vehiculo av ON av.id = vr.activo_vehiculo_id
LEFT JOIN viaje_guia vg ON vg.viaje_ruta_id = vr.id
LEFT JOIN cotizacion_monto_detalle cmd ON cmd.cotizacion_principal_id = vg.cotizacion_principal_id
left join destino_principal dp on vg.cotizacion_prinicpal_destino_id = dp.id
WHERE vr.viaje_estatus_id = 1
AND vr.fecha_registro BETWEEN ADDDATE(CURRENT_DATE(), INTERVAL -30 DAY) AND CURRENT_DATE()
AND vr.viaje_tipo_id = 2
GROUP BY vr.id, vg.cotizacion_prinicpal_destino_id
ORDER by  rp.destino_principal_origenid,  vr.id DESC, vr.fecha_registro desc, vg.cotizacion_prinicpal_destino_id 







select
    rp.destino_principal_origenid AS "Origen_desde_ruta",
    vr.id,
    vr.nombre,
    vr.fecha_registro,
    av.clave AS "Clave_vehiculo",
    av.Peso_carga_max,
    av.Volumen_carga_max,
    vg.cotizacion_prinicpal_destino_id,
    dp.nombre as nombre_destino, 
    nvl(Sum(cmd.volumen),0) as volumen
FROM viaje_ruta vr
INNER JOIN ruta_principal rp ON rp.id = vr.ruta_principal_id
INNER JOIN activo_vehiculo av ON av.id = vr.activo_vehiculo_id
LEFT JOIN viaje_guia vg ON vg.viaje_ruta_id = vr.id
LEFT JOIN cotizacion_monto_detalle cmd ON cmd.cotizacion_principal_id = vg.cotizacion_principal_id
left join destino_principal dp on vg.cotizacion_prinicpal_destino_id = dp.id
WHERE vr.viaje_estatus_id = 1
AND vr.fecha_registro BETWEEN ADDDATE(CURRENT_DATE(), INTERVAL -30 DAY) AND CURRENT_DATE()
AND vr.viaje_tipo_id = 2
GROUP BY vr.id, vg.cotizacion_prinicpal_destino_id
ORDER by  rp.destino_principal_origenid,  vr.id DESC, vr.fecha_registro desc, vg.cotizacion_prinicpal_destino_id 

select
vr.id,
vr.nombre,
vr.fecha_registro,
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
			/*and vr.destino_principal_id = 1/*Este dato se tiene que sustituir con el id del destino*/
			and vr.viaje_tipo_id = 2/*viaje foreneo*/
			order by vr.fecha_registro desc, Destino_origen
		

			
			select * 
			from viaje_transacciones vt 
			where num_guia = "MTH-17805"

			
			select * from destino_principal dp 
			
			select * from empleado_principal ep 
			 where  ep.empleado_estatus_id like 1 and ep.nombre like "%diego%"
			
			select ep.id, ep.nombre, ep.empleado_tipo_id, ep.empleado_estatus_id
            from empleado_principal ep
            where  ep.empleado_estatus_id like 1 and ep.nombre like "%diego%"
			
			select ep.id, ep.nombre, ep.empleado_tipo_id, ep.empleado_estatus_id, ep2.descripcion 
            from empleado_principal ep
            inner join empleado_puesto ep2 on ep2.id=ep.idpuesto
            where  ep.empleado_estatus_id like 1

			
			select av.clave, av.Peso_carga_max , av.Volumen_carga_max, av.activo_uso_id 
			from activo_vehiculo av
			where activo_estatus_id = "1"
			and clave like "%c%"
			and clave not like "%cr%"
			and activo_uso_id =5
			
			select * from parameters p 
			
			INSERT INTO parameters (Llave, Valor) VALUES ('dsDescuentoCarga', 0.20);

		
		select * from viaje_ruta vr 
		
		
		select * from activo_vehiculo av  
		where av.id = 236
		