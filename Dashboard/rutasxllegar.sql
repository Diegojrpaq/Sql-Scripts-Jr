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
    vr.activo_vehiculo_caja_id as idCaja,
    rp.orden_parada ,
    rp.orden_parada_directa,
    rp.completa,
    rp.ID_DiasOperacion ,
    rp.Text_DiasOperacion ,
    av.clave as Clave_vehiculo,
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
     and rp.orden_parada_directa NOT LIKE';3;%' 
     AND rp.orden_parada_directa LIKE "%;3;%"
order by vr.fecha_registro desc,  rp.orden_parada_directa