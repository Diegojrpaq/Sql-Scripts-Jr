select * 
from historico_escaneo 


select *
from viaje_transacciones vt 
where vt.num_guia = "cdg-10"
-- and IdTipoOperacion = 23

select *
from viaje_guia vg 
where vg.cotizacion_principal_origen_id = 32
and vg.cotizacion_prinicpal_destino_id = 18

select * 
from viaje_guia
where 