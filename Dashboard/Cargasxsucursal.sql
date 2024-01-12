select cp.origen_id as 'destino_id', 
cp.sucursal_principal_id as id, 
sp.nombre  as nombre,
sp.prefijo,
sum(cmd.volumen) as total_mt3_sucursal
from cotizacion_principal cp 
inner join sucursal_principal sp on sp.id = cp.sucursal_principal_id 
left join cotizacion_monto_detalle cmd on cmd.cotizacion_principal_id =cp.id
where cp.fecha_registro = current_date() 
and cotizacion_estatus_id in (4)
and  cp.num_guia not like 'mei%'
group by cp.sucursal_principal_id 
order by cp.origen_id, sp.id






select vg.cotizacion_principal_origen_id ,
dp.nombre as 'Destino', Sum(cmd.volumen) as 'Mt3_vendido'
from viaje_guia vg
inner join destino_principal dp 
on dp.id = vg.cotizacion_prinicpal_destino_id 
inner join cotizacion_monto_detalle cmd 
on cmd.cotizacion_principal_id = vg.cotizacion_principal_id 
where vg.fecha_registro = current_date() 
and vg.referencia  not like 'mei%'
group by dp.id, vg.cotizacion_principal_origen_id  
order by vg.cotizacion_principal_origen_id 


/*saca los metros cubicos vendidos de cada sucursal separados por destino a donde van*/
select cp.origen_id,
dp2.nombre,
cp.sucursal_principal_id,
sp.nombre, 
cp.destino_id,
dp.nombre,
sum(cmd.volumen),
sum(cmd.peso)
from cotizacion_principal cp 
inner join destino_principal dp2 on dp2.id=cp.origen_id 
inner join cotizacion_monto_detalle cmd on cmd.cotizacion_principal_id = cp.id 
inner join sucursal_principal sp on sp.id= cp.sucursal_principal_id 
inner join destino_principal dp on dp.id= cp.destino_id 
where cp.fecha_registro = current_date()
and cp.cotizacion_estatus_id = 4
and cp.num_guia not like "mei%"
group by cp.destino_id , cp.sucursal_principal_id 
order by  cp.origen_id, cp.sucursal_principal_id, dp.nombre 

/*este es el mismo sin nombre de sucursal con un inner menos*/
select cp.origen_id,
cp.sucursal_principal_id,
cp.destino_id,
dp.nombre destino_final,
sum(cmd.volumen) as Volumen_por_destino
from cotizacion_principal cp 
inner join cotizacion_monto_detalle cmd on cmd.cotizacion_principal_id = cp.id 
inner join destino_principal dp on dp.id= cp.destino_id 
where cp.fecha_registro = current_date()
and cp.cotizacion_estatus_id = 4
and cp.num_guia not like "mei%"
group by cp.destino_id , cp.sucursal_principal_id 
order by cp.origen_id, cp.sucursal_principal_id, cp.destino_id 









select cp.origen_id,
dp.nombre,
cp.sucursal_principal_id,
sp.nombre, 
sub.vol,
cp.destino_id,
dp2.nombre,
sum(cmd.volumen)
from cotizacion_principal cp 
inner join destino_principal dp on dp.id = cp.origen_id 
inner join cotizacion_monto_detalle cmd on cmd.cotizacion_principal_id = cp.id 
inner join sucursal_principal sp on sp.id= cp.sucursal_principal_id 
inner join destino_principal dp2 on dp2.id= cp.destino_id 
inner join (select subquery.sucursal_principal_id id, sum(subquery.vol) vol
from (select 
cp.sucursal_principal_id,
sum(cmd.volumen) as vol
from cotizacion_principal cp 
inner join destino_principal dp on dp.id = cp.origen_id 
inner join cotizacion_monto_detalle cmd on cmd.cotizacion_principal_id = cp.id 
inner join sucursal_principal sp on sp.id= cp.sucursal_principal_id 
inner join destino_principal dp2 on dp2.id= cp.destino_id 
where cp.fecha_registro = current_date()
and cp.cotizacion_estatus_id = 4
and cp.num_guia not like "mei%"
group by cp.destino_id , cp.sucursal_principal_id 
order by cp.origen_id, cp.sucursal_principal_id )subquery
group by subquery.sucursal_principal_id) sub on sub.id = cp.sucursal_principal_id 
where cp.fecha_registro = current_date()
and cp.cotizacion_estatus_id = 4
and cp.num_guia not like "mei%"
group by cp.destino_id , cp.sucursal_principal_id 
order by cp.origen_id, cp.sucursal_principal_id 





select cp.origen_id,
cp.sucursal_principal_id,
cp.destino_id,
dp.nombre as destino_final,
sum(cmd.volumen)
from cotizacion_principal cp 
inner join cotizacion_monto_detalle cmd on cmd.cotizacion_principal_id = cp.id 
inner join destino_principal dp on dp.id= cp.destino_id 
inner join (
select count(*) total, volxdes.sucursal_principal_id as id 
from 
(select
cp.sucursal_principal_id
from cotizacion_principal cp  
where cp.fecha_registro = current_date()
and cp.cotizacion_estatus_id = 4
and cp.num_guia not like "mei%"
group by cp.destino_id , cp.sucursal_principal_id 
order by cp.origen_id, cp.sucursal_principal_id
) volxdes
group by volxdes.sucursal_principal_id
)count_rec on count_rec.id = cp.sucursal_principal_id 
where cp.fecha_registro = current_date()
and cp.cotizacion_estatus_id = 4
and cp.num_guia not like "mei%"
group by cp.destino_id , cp.sucursal_principal_id 
order by cp.origen_id, count_rec.total desc , cp.sucursal_principal_id, dp.nombre




select cp.origen_id,
cp.sucursal_principal_id,
cp.destino_id,
dp.nombre destino_final,
sum(cmd.volumen) as Volumen_por_destino
from cotizacion_principal cp 
inner join cotizacion_monto_detalle cmd on cmd.cotizacion_principal_id = cp.id 
inner join destino_principal dp on dp.id= cp.destino_id 
where cp.fecha_registro = current_date()
and cp.cotizacion_estatus_id = 4
and cp.num_guia not like "mei%"
and cp.origen_id = 1
group by cp.destino_id , cp.sucursal_principal_id 
order by cp.origen_id, cp.sucursal_principal_id, cp.destino_id

