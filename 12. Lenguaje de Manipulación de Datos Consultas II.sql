----------------------------------------------------------------
-- 12.0 Repaso Consultas
----------------------------------------------------------------

-- 12.0.1 ¿Cuál es la tarifa semanal de cada electricista? (Suponemos la jornada semanal de 8 horas de lunes a viernes y tenemos el campo de tarifa/hora).
-- Debemos de ordenar el resultado por el nombre del trabajador como se ve en el ejemplo.
select nom_trabajador as "Nombre", round(tarifa_hr*40, 2) as "Tarifa semanal" from trabajador order by nom_trabajador;

-- 12.0.2 Muestra el número de trabajadores que hay por cada uno de los oficios ordenado de mayor a menor. Tabla “oficio”.
select oficio, count(*) as "N. Trabajadores" from trabajador group by oficio;

-- 12.0.3 Por cada código de supervisor muestra la tarifa por horas más alta que se le paga a un trabajador de ese supervisor. Tabla “trabajador”.
select id_supv, max(tarifa_hr) as "Tarifa mas alta" from trabajador group by id_supv;

-- 12.0.4 Para cada tipo de edificio, muestra cuál es el nivel de calidad medio para los edificios de categoría 1. Tabla “edificio”.
select tipo, avg(nivel_calidad) from edificio group by tipo;

-- 12.0.5 Para cada supervisor que dirige a más de un trabajador ¿Cuál es la tarifa por horas más alta que se le paga a un trabajador de ese supervisor? Tabla “trabajador”.
select id_supv, max(tarifa_hr) from trabajador group by id_supv;

-- 12.0.6 Para cada tipo de edificio, ¿cuál es el nivel de calidad medio para los edificios de categoría 1? Solo hay que visualizar los tipos de edificio cuyo nivel de calidad máximo sea igual o superior a 3. Tabla “edificio”.
select tipo, avg(nivel_calidad) from edificio group by tipo, categoria having avg(nivel_calidad) >= 3;

-- 12.0.7 Obtener una lista de todos los productos indicando para cada uno su idfab, idproducto, descripción, precio y precio con I.V.A. incluido (es el precio anterior aumentado en un 16%). Tabla “productos”.
select *, precio*1.16 as importe from productos;

-- 12.0.8 De cada pedido queremos saber su número de pedido, fab, producto, cantidad, precio unitario (importe entre cantidad) e importe. Tabla “pedidos”.
select numpedido, fab, producto, cant, importe/cant, importe from pedidos;

-- 12.0.9 Listar las cuatro líneas de pedido más caras (las de mayor importe). Tabla “pedidos”.
select * from pedidos order by importe desc limit 4;

-- 12.0.10 Listar toda la información de los pedidos de marzo. Tabla “pedidos”.
select * from pedidos where month(fechapedido) = 3;

-- 12.0.11 Listar los números de los empleados que tienen una oficina asignada. Tabla “empleados”.
select numemp from empleados where oficina is not null;

-- 12.0.12 ¿Cuál es la cuota media y las ventas medias de todos los empleados? Tabla “empleados”.
select round(avg(cuota), 2) as "Cuota media", round(avg(ventas), 2) as "Ventas medias" from empleados;

-- 12.0.13 Hallar el importe medio de pedidos, el importe total de pedidos y el precio medio de venta (el precio de venta es el precio unitario en cada pedido). Tabla “pedidos”.
select round(avg(importe), 2) as "Importe medio", round(sum(importe), 2) as "Importe total", round(avg(importe/cant), 2) as "Precio medio venta" from pedidos;

-- 12.0.14 Hallar en qué fecha se realizó el primer pedido (suponiendo que en la tabla de pedidos tenemos todos los pedidos realizados hasta la fecha). Tabla “pedidos”.
select fechapedido from pedidos order by fechapedido asc limit 1;

-- 12.0.15 Listar de cada empleado su nombre, no de días que lleva trabajando en la empresa y su año de nacimiento (suponiendo que este año ya ha cumplido años). Tabla “empleados”.
select * from empleados;
select nombre, timestampdiff(day,  contrato, now()) as "Dias trabajados", year(now()) - edad from empleados;


----------------------------------------------------------------
-- 12.1 Consultas INNER JOIN
----------------------------------------------------------------

-- 12.1.1 Devuelve un listado con los nombres de los fabricantes que tienen 2 o más productos.
select fabricante.nombre from fabricante join producto on fabricante.codigo = producto.codigo_fabricante group by fabricante.codigo having count(producto.codigo) > 2;  -- hecha por mi
select fabricante.nombre from fabricante join producto on fabricante.codigo = producto.codigo_fabricante group by fabricante.codigo, fabricante.nombre having count(*) >= 2;

-- 12.1.2 Muestra el nombre de cada fabricante, junto con el precio máximo, precio mínimo, 
-- precio medio y el número total de productos de los fabricantes que tienen un precio medio superior a 200€. Es necesario mostrar el nombre del fabricante.
select fabricante.nombre, max(producto.precio), min(producto.precio), avg(producto.precio), count(producto.nombre) from fabricante join producto on fabricante.codigo = producto.codigo_fabricante group by fabricante.nombre having avg(producto.precio) > 200;

-- 12.1.3 Indica los nombres de los trabajadores que sean asignados a edificios que sean oficinas. Ordénalos en orden alfabético decreciente.
select trabajador.nom_trabajador from trabajador join asignacion on trabajador.id_trabajador = asignacion.id_trabajador join edificio on edificio.id_edificio = asignacion.id_edificio where edificio.tipo = "oficina" order by nom_trabajador desc;

-- 12.1.4 Mostrar los trabajadores asignados a edificios mostrando el nombre del trabajador, el número de edificios que tiene asignados y la calidad media de los edificios que tiene asignados.
-- De ellos muestra solo los que tienen asignados al menos 3 edificios. Ordenarlo por el número de edificios en ascendente y, en segundo nivel, por la calidad media en ascendente.
select t.nom_trabajador, count(e.id_edificio) from trabajador t join asignacion a on t.id_trabajador = a.id_trabajador join edificio e on e.id_edificio = a.id_edificio group by t.nom_trabajador having count(e.id_edificio) >= 3;

-- 12.1.5 Calcula cuál es el máximo valor de los pedidos realizados cada día para cada uno de los clientes, teniendo en cuenta que sólo queremos mostrar aquellos pedidos que superen la cantidad de 2000 €.
select pedido.total, pedido.id, cliente.nombre from pedido join cliente on pedido.id_cliente = cliente.id group by pedido.id having pedido.total > 2000 ;
select cliente.nombre, pedido.fecha, max(pedido.total) as maximo_total from pedido join cliente on pedido.id_cliente = cliente.id where pedido.total > 2000 group by cliente.id, cliente.nombre, pedido.fecha;











