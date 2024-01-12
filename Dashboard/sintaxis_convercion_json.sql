 select JSON_OBJECT('id',id, 'nombre',nombre, 'estado',descripcion)
 from destino_principal
 
 select JSON_ARRAYAGG(JSON_OBJECT('id',id, 'nombre',nombre, 'estado',descripcion))
 from destino_principal