show tables

describe ruta_principal /*de aqui parte la tabla de registro de rutas aqui se manifiesta los datos de una ruta donde se le pueden asignar los viajes y se conecta con viaje_ruta*/

describe viaje_ruta /*aqui se relacionan los viajes con las rutas y anexa datos como los activos asignados a ruta o el empledo que a*/

describe activo_vehiculo/*resgitra todo lo que tiene que ver con el vehiculo*/

describe ruta_estatus 

describe activo

select rp.id, rp.nombre, rp.fecha_registro, rp.descripcion, rp.ruta_estatus_id, rp.destino_principal_origenid, dp.nombre, rt.nombre
from ruta_principal rp 
inner join destino_principal dp on dp.id = rp.destino_principal_destinoid 
inner join ruta_tipo rt on rt.id= rp.ruta_tipo_id 
where ruta_estatus_id = 1 and ruta_tipo_id = 2 and destino_principal_origenid = 1 


select * from ruta_estatus 

select * from viaje_ruta where viaje_tipo_id = 1 and viaje_estatus_id = 1 and activo_vehiculo_id = 58   order by fecha_registro desc limit 100

select * from activo_vehiculo where clave = 'cr-59'

select * from viaje_transacciones order by Fecha_registro desc  limit 10

select * from activo_tipo

select * from cxc_principal limit 20

select * from cotizacion_principal order by fecha_registro desc limit 20

select * from viaje_guia  order by fecha_registro desc limit 10

select nombre, descripcion, fecha_registro , ruta_estatus_id 

select *
from ruta_principal rp
where ruta_estatus_id = 1

select * from activo_vehiculo where clave in ('c30','jr38')

select * from activo_vehiculo where clave = 'c30' or clave ='jr38'

select num_guia  from cotizacion_principal  order by fecha_registro desc
limit 10

select * from viaje_guia order by fecha_registro desc limit 10


select * from sucursal_principal sp 


select * from sucursal_principal 

select dc. from destino_principal dc 


select num_guia, serie, folio, claverastreo 
from cotizacion_principal cp
order by fecha_registro
limit 1000



select * from cliente_estatus_id


select * from viaje_guia where referencia="PER-80281" or referencia ="PER-80724"

select * from viaje_guia where referencia in ("PER-80724", "PER-80281")

select * 
from activo_vehiculo 
where clave ="cr-42"


/*
 * 
 * datas que se van a necesitar
 * 
 * -Sucursales con su info:
 * --total venta x dia 
 * --total de guias x dia 
 * --
 * 
 * -viajes Activos con su info:
 * --nombre
 * --
 * */

select * 
from cotizacion_principal cp


where cp.fecha_registro="20230602"


select cp.id, cp.num_guia, sp.nombre as Sucursal,  dp.nombre as Origen, dp2.nombre as Destino , cp.cliente_destino_id, ce.nombre, cp.fecha_registro 
from cotizacion_principal cp
inner join cotizacion_estatus ce on ce.id = cp.cotizacion_estatus_id  
inner join destino_principal dp on dp.ID=cp.origen_id 
inner join destino_principal dp2 on dp2.id = cp.destino_id
inner join sucursal_principal sp on sp.id = cp.sucursal_principal_id 
where cp.fecha_registro="20230602"


select * from viaje_guia vg 
inner join sucursal_principal sp on sp.id = vg.sucursal_principal_ubicacion_id 
where referencia="col-812"

select * from sucursal_principal sp  where id=60

select * 
from viaje_transacciones vt 
order by Fecha_registro desc



select * from destino_principal dp 

select * from region_principal




select * from inventario_principal ip where fecha_venta = current_date() and destino_principal_origenid = 1





select sc.id, sc.nombre as sucursal, sc.prefijo, dp.descripcion as estado , dp.nombre as ciudad  from sucursal_principal sc 
inner join destino_principal dp on dp.id = sc.destino_principal_id 
where sc.ubicacion_estatus_id = 1


select cp.id, cp.cotizacion_principal_cantidad_envios, cp.cotizacion_principal_peso ,
cp.cotizacion_principal_volumen, cp.fecha_registro , cp.cotizacion_tipo_id , ct.nombre as cotizacio_tipo,ct.descripcion , ct.interna 
from cotizacion_principal cp 
inner join cotizacion_tipo ct on ct.id = cp.cotizacion_tipo_id 
where cp.fecha_registro = current_date() and cp.cotizacion_estatus_id = 4/*solo debemos elegir el status de cxc*/
order by fecha_registro desc



select num_guia , cotizacion_estatus_id  from cotizacion_principal where cotizacion_estatus_id in("2","3") and origen_id = 1 limit 200



select count(*) from cotizacion_principal where fecha_registro = current_date() 

select * from inventario_estatus ie 


select * from viaje_ruta


select * from viaje_transacciones where num_guia = 'gts-5160'


select * 
from viaje_transacciones 
where num_guia = 'PER-81243'

select id, nombre from destino_principal 
order by id 

select rp.id, rp.nombre, rp.fecha_registro, rp.descripcion, dp.nombre as Origen, dp2.nombre as destino, rp.orden_parada, rp.completa, rp.Text_DiasOperacion 
from ruta_principal rp 
inner join destino_principal dp on dp.id=rp.destino_principal_origenid
inner join destino_principal dp2 on dp2.id =rp.destino_principal_destinoid 
where rp.ruta_estatus_id =1 and rp.ruta_tipo_id = 2 and dp.id=1