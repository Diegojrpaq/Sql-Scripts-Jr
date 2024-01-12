select dp.nombre, sum(cmd.volumen)
from viaje_guia vg
inner join destino_principal dp on dp.id = vg.cotizacion_prinicpal_destino_id 
inner join cotizacion_monto_detalle cmd on cmd.id=vg.cotizacion_principal_id 
where vg.cotizacion_principal_origen_id = 1
and vg.fecha_registro = current_date()
group by dp.nombre

select dp.nombre as 'Destino', sum(cmd.volumen) as 'Mt3_vendido'
from viaje_guia vg
inner join destino_principal dp 
on dp.id = vg.cotizacion_prinicpal_destino_id 
inner join cotizacion_monto_detalle cmd 
on cmd.cotizacion_principal_id = vg.cotizacion_principal_id 
where vg.fecha_registro = current_date() 
and vg.cotizacion_principal_origen_id = 1 
and vg.referencia  not like 'mei%'
group by dp.nombre 


SELECT JSON_ARRAYAGG(JSON_OBJECT('Destino', subquery.nombre_destino, 'Mt3_vendido', volumen_total))
FROM (
    SELECT dp.nombre as nombre_destino, SUM(cmd.volumen) AS volumen_total
    FROM viaje_guia vg
    INNER JOIN destino_principal dp ON dp.id = vg.cotizacion_prinicpal_destino_id
    INNER JOIN cotizacion_monto_detalle cmd ON cmd.cotizacion_principal_id = vg.cotizacion_principal_id
    WHERE vg.fecha_registro = CURRENT_DATE()
    AND vg.cotizacion_principal_origen_id = 1
    AND vg.referencia NOT LIKE 'mei%'
    GROUP BY dp.nombre
) subquery;


select sp.id , sp.nombre, sp.prefijo, sp.destino_principal_id, dp.nombre
from sucursal_principal sp 
inner join destino_principal dp on dp.id=sp.destino_principal_id 
where sp.ubicacion_estatus_id = 1 and dp.ubicacion_estatus_id = 1 
order by sp.destino_principal_id 









select *
from 
(select dp.id as 'destino_id', dp.nombre as 'destino_nombre', sp.id as '',
sp.nombre  as Sucursal, sum(cmd.volumen)
from cotizacion_principal cp 
inner join destino_principal dp on dp.id=cp.origen_id 
inner join sucursal_principal sp on sp.id = cp.sucursal_principal_id 
left join cotizacion_monto_detalle cmd on cmd.cotizacion_principal_id =cp.id
where cp.fecha_registro = current_date() 
and cotizacion_estatus_id in (4)
and  cp.num_guia not like 'mei%'
group by sp.nombre
order by dp.id, sp.id) subquery


select cp.destino cp.sucursal_principal_id, sp.nombre, sum(cmd.volumen) , cp.destino_id , dp.nombre 
from cotizacion_principal cp 
inner join cotizacion_monto_detalle cmd on cmd.cotizacion_principal_id = cp.id 
inner join destino_principal dp on dp.id = cp.destino_id 
inner join sucursal_principal sp on sp.id = cp.sucursal_principal_id 
where cp.fecha_registro = current_date() 
and cotizacion_estatus_id in (4)
and  cp.num_guia not like 'mei%'
group by sp.nombre
order by cp.destino_id , cp.sucursal_principal_id 



select vg.referencia,+
vg.cotizacion_principal_origen_id  as destino_origen,
cp.sucursal_principal_id as sucursal_origen,  
vg.sucursal_destino_id as sucursal_origen,
vg.cotizacion_prinicpal_destino_id as destino_final
from viaje_guia vg 
inner join cotizacion_principal cp on cp.id=vg.cotizacion_principal_id 
where vg.fecha_registro = current_date()
and vg.referencia not like 'mei%'




















SELECT dp.id, dp.nombre, dp.descripcion estado, nvl(Sum(cmd.volumen),0)  total_mt3_destino
FROM destino_principal dp
LEFT JOIN (SELECT vg.* FROM  viaje_guia vg
WHERE vg.fecha_registro = CURRENT_DATE()
AND vg.referencia NOT LIKE 'MEI%') vg ON dp.id = vg.cotizacion_principal_origen_id
LEFT JOIN cotizacion_monto_detalle cmd ON cmd.cotizacion_principal_id = vg.cotizacion_principal_id
where dp.ubicacion_estatus_id = 1
GROUP BY dp.id













select 
cp.origen_id, 
SUM(SUM(cmd.volumen)) OVER(PARTITION BY cp.origen_id) AS volumen_total_por_origen,
cp.sucursal_principal_id, 
SUM(SUM(cmd.volumen)) OVER(PARTITION BY cp.sucursal_principal_id) AS volumen_total_por_sucursal,
cp.destino_id,
sum(cmd.volumen) as volumen_por_destino
from cotizacion_principal cp 
inner join cotizacion_monto_detalle cmd on cmd.cotizacion_principal_id = cp.id 
where cp.fecha_registro = '20230812'
and cp.cotizacion_estatus_id = 4 
and cp.num_guia not like 'mei%'
group by cp.destino_id, cp.sucursal_principal_id 
order by sucursal_principal_id 

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
cp.origen_id, 
dp.nombre,
SUM(SUM(cmd.volumen)) OVER(PARTITION BY cp.origen_id) AS volumen_total_por_origen,
cp.sucursal_principal_id, 
sp.nombre as sucursal_principal ,
SUM(SUM(cmd.volumen)) OVER(PARTITION BY cp.sucursal_principal_id) AS volumen_total_por_sucursal,
cp.destino_id,
dp2.nombre as destino_final,
sum(cmd.volumen) as volumen_por_destino
from cotizacion_principal cp 
inner join cotizacion_monto_detalle cmd on cmd.cotizacion_principal_id = cp.id 
inner join destino_principal dp on dp.id = cp.origen_id 
inner join sucursal_principal  sp on sp.id=cp.sucursal_principal_id 
inner join destino_principal dp2 on dp2.id = cp.destino_id 
where cp.fecha_registro = current_date()
and cp.cotizacion_estatus_id = 4 
and cp.num_guia not like 'mei%'
group by cp.destino_id, cp.sucursal_principal_id 
order by cp.origen_id, cp.sucursal_principal_id  




select JSON_ARRAYAGG(JSON_OBJECT('id',id, 'nombre',nombre)) as Destinos
from destino_principal 
where ubicacion_estatus_id = 1

select cp.num_guia 
from cotizacion_principal cp 
inner join cotizacion_monto_detalle cmd on cmd.cotizacion_principal_id   = cp.id 
and cp.fecha_registro =  "20230819"
and cp.cotizacion_estatus_id = 4
and num_guia not like "mei%"

select count(cp.num_guia) as Conteo_de_guias, cp.origen_id, dp.nombre, dp.id, dp.ubicacion_estatus_id 
from cotizacion_principal cp 
right join destino_principal dp on dp.id=cp.origen_id 
and cp.fecha_registro in ("20230729","20230805","20230812","20230819") 
and cp.cotizacion_estatus_id = 4
and num_guia not like "mei%"
and dp.ubicacion_estatus_id = 1
left join cotizacion_monto_detalle cmd on cmd.cotizacion_principal_id = cp.id 
group by dp.nombre 
order by Conteo_de_guias desc

select cp.num_guia 
from cotizacion_principal cp 
right join cotizacion_monto_detalle cmd on cmd.cotizacion_principal_id = cp.id 
and 







