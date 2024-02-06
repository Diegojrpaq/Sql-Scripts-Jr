/*en nextpack aveces atora o desaparece las guias para desembarcar */
/*Necesitamos la 
 * --num viaje 
 * --clave de desmbarque 
 * --verificar si el viaje tiene guias o no tiene guias
 * 
 * 1.- para desembarcar todas las guias es pasar las claves de desembarque 
 * de ese viaje para verificar que se desembarque por sistema 
 * 
 * 2.- en caso de que aun queden guias embarcadas es porque la guia cambio de viaje operacion
 * hacia entrada al inventario pero el campo de viaje guia no lo cambia a cero y el desembarque solo 
 * busca las guias 23 hasta no corregir ese error no podremos visualizar las guias aun en viaje 
 * pero con estatus de recepcion de mercancia 
 * 
 * 
 * 3.- la consulta del inventario principal nos deja consultar el estatus de esas guias 
 * guias que ya llegaron o que se entregaron en inventario y que tienen un estatus diferente al 23 
 * se harcodea cambiando el viaje_ruta_id a 0 para liberar esas guias
 * */
set @idrutA = "59003"

/*este query nos da las claves de desembarque */
select *
from  viaje_clave vc 
where vc.viaje_ruta_id= @idruta

/*inactivamos el 59026*/



/*verificacion de guias para poder desembarcar forzado debemos verificar el estatus de las guias 
 * y sino mandar investigar el estatus con el departamento correspondiente*/

/*nos da las guias aun embarcadas en ese viaje su estatus y llego o entrego */
select ip.numguia,
vg.viaje_ruta_id, 
vg.viaje_operacion_id,
vg.viaje_clave_temp,
vo.nombre,
ip.llego ,
ip.entrego ,
ip.invnetario_estatus_id 
from inventario_principal ip 
inner join viaje_guia vg on vg.cotizacion_principal_id = ip.cotizacion_principal_id 
inner join viaje_operacion vo on vo.id = vg.viaje_operacion_id 
where ip.numguia in (select vg.referencia 
from viaje_guia vg
where vg.viaje_ruta_id = @idruta)



