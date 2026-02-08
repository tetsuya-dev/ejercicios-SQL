----------------------------------------------------------------
-- 4.1 Cláusulas SELECT y FROM: Consultas básicas
----------------------------------------------------------------

-- 4.1.1.1 Selecciona todos los datos de la tabla Empleados
select * from empleados;

-- 4.1.1.2 Selecciona todos los datos de la tabla Libros
select * from libros;

-- 4.1.1.3 Selecciona todos los datos de la tabla Facturas
select * from facturas;

-- 4.1.1.4 Selecciona todos los datos de la tabla Facturas pero en orden inverso
select fecha_hora, importe, cuenta, destinatario, codigo from facturas;

-- 4.1.1.5 Selecciona únicamente las columnas nombre, apellidos y puesto de la tabla Empleados
select nombre, apellidos, puesto from empleados;

-- 4.1.1.6 Selecciona únicamente las columnas título y precio de la tabla Libros. El nombre de la columna de precios será "Precio de venta"
select titulo, precio as "Precio de venta" from libros;

-- 4.1.1.7 Selecciona únicamente las columnas destinatario, importe y fecha_hora de la tabla Facturas. El nombre de la columna con el día y la hora será "Momento de la compra"
select destinatario, importe, fecha_hora as "Momento de la compra" from facturas;


----------------------------------------------------------------
-- 4.2 Cálculos y operadores aritméticos BD
----------------------------------------------------------------

-- 4.2.1.1 Selecciona los campos nombre, apellidos, sueldo y sueldo multiplicado por 1,2 (Llámalo “Subida de sueldo”) de la tabla empleados
select nombre, apellidos, sueldo, sueldo*1.2 as "Subida de sueldo" from empleados;

-- 4.2.1.2 Selecciona los campos título, precio y precio multiplicado por 0.75 de la tabla libros. Llama a este último “Precio con descuento”
select titulo, precio, precio*0.75 as "Precio con descuento" from libros;

-- 4.2.1.3 Selecciona los campos destinatario, importe e importe más 2.99 de la tabla facturas. Llama a este último “Precio con gastos”
select destinatario, importe, importe+2.99 as "Precios con gastos" from facturas;

-- 4.2.1.4 Selecciona los campos nombre, apellidos, el sueldo (llamado "Sueldo actual"), el 20% del sueldo (llamado "Incremento") y la suma de ambas columnas (Llámalo “Sueldo final”) de la tabla empleados
select nombre, apellidos, sueldo as "Sueldo actual", sueldo*0.2 as "Incremento", sueldo*1.2 as "Sueldo final" from empleados;


----------------------------------------------------------------
-- 4.3 Cláusula WHERE: Evaluación de condiciones
----------------------------------------------------------------

-- 4.3.1.1 Selecciona todos los campos de la tabla empleados cuyo sueldo sea mayor que 2000
select * from empleados where sueldo > 2000;

-- 4.3.1.2 Selecciona todos los campos de la tabla empleados cuyo puesto sea “encargado”
select * from empleados where puesto like "encargado";
select * from empleados where puesto = "encargado";

-- 4.3.1.3 Selecciona todos los campos de la tabla facturas cuyo importe sea mayor o igual que 100
select * from facturas where importe >= 100;

-- 4.3.1.4 Selecciona todos los campos de la tabla libros cuyo tipo sea distinto de “divulgación”
select * from libros where tipo <> "divulgación";

-- 4.3.1.5 Selecciona todos los campos de la tabla empleados cuyo nombre sea distinto de “Luis”. Investiga otra versión sin usar “<>”
select * from empleados where nombre <> "Luis";
select * from empleados where nombre != "Luis";

-- 4.3.2.1 Selecciona todos los campos de la tabla empleados cuyo sueldo sea menor de 2000 y cuyo nombre sea “David”
select * from empleados where sueldo < 2000 and nombre like "David";
select * from empleados where sueldo < 2000 and nombre = "David";

-- 4.3.2.2 Selecciona todos los campos de la tabla libros cuyo precio sea mayor que 20 o cuyo autor sea anónimo
select * from libros where precio > 20 or autor like "anonimo";

-- 4.3.2.3 Selecciona todos los campos de la tabla facturas cuyo importe NO sea menor que 100
select * from facturas where importe > 100;

-- 4.3.2.4 Selecciona todos los campos de la tabla empleados cuyo teléfono sea mayor que 948000000 y cuyo nombre NO sea “Juan”
select * from empleados where telefono > 948000000 and nombre <> "Juan";
select * from empleados where telefono > 948000000 and nombre != "Juan";

-- 4.3.2.5 Selecciona todos los campos de la tabla empleados cuyo sueldo sea menor que 2000 o cuyo sueldo sea mayor que 5000
select * from empleados where sueldo < 2000 or sueldo > 5000;

-- 4.3.2.6 Selecciona todos los campos de la tabla empleados cuyo sueldo sea menor que 2000 y cuyo sueldo sea mayor que 5000
select * from empleados where sueldo < 2000 and sueldo > 5000;

-- 4.3.2.7 Selecciona todos los campos de la tabla empleados cuyo puesto sea “operario” o “supervisor”
select * from empleados where puesto like "operario" or puesto like "supervisor";
select * from empleados where puesto = "operario" or puesto = "supervisor";

-- 4.3.2.8 Selecciona todos los campos de la tabla facturas cuyo importe sea mayor que 50 y que no sea mayor que 200
select * from facturas where importe > 50 and importe < 200;
select * from facturas where importe between 50 and 200;

-- 4.3.2.9 Selecciona todos los campos de la tabla libros cuyo precio sea mayor que 30 o menor que 15
select * from libros where precio > 30 or precio < 15;

-- 4.3.3.1 Selecciona todos los campos de la tabla empleados cuyo teléfono esté entre 948000000 y 980000000
select * from empleados where telefono between 948000000 and 980000000;

-- 4.3.3.2 Selecciona todos los campos de la tabla libros cuyo precio esté entre 15 y 30
select * from libros where precio between 15 and 30;

-- 4.3.3.3 Selecciona todos los campos de la tabla libros cuyo ISBN no esté entre 431501467 y 705940145
select * from libros where ISBN not between 431501467 and 705940145;

-- 4.3.3.4 Selecciona todos los campos de la tabla facturas cuyo importe no esté entre 50 y 200
select * from facturas where importe not between 50 and 200;

-- 4.3.3.5 Selecciona todos los campos de la tabla empleados cuyo puesto sea “operario” o “supervisor”. Utiliza IN.
select * from empleados where puesto in ("operario", "supervisor");

-- 4.3.3.6 Selecciona todos los campos de la tabla libros cuyo tipo sea distinto de “divulgación” o "escolar". Utiliza IN.
select * from libros where tipo not in ("divulgacion", "escolar");

-- 4.3.4.1 Selecciona todos los campos de la tabla empleados cuyos apellidos acaben por la cadena “ez”.
select * from empleados where apellidos like "%ez";

-- 4.3.4.2 Selecciona todos los campos de la tabla empleados cuyos apellidos contengan la cadena “ez”
select * from empleados where apellidos like "%ez%";

-- 4.3.4.3 Selecciona todos los campos de la tabla empleados cuyo nombre acabe por el carácter “a”
select * from empleados where nombre like "%a";

-- 4.3.4.4 Selecciona todos los campos de la tabla Facturas cuyo destinatario sea “Alan ” y que después haya un espacio y luego cualquier otro conjunto de caracteres.
select * from facturas where destinatario like "Alan %";

-- 4.3.4.5 Selecciona todos los campos de la tabla facturas cuyo destinatario comience por un conjunto de caracteres cualquiera, que luego haya un espacio, después un carácter cualquiera y luego la cadena de caracteres “eumann”.
select * from facturas where destinatario like "% %eumann";

-- 4.3.4.6 Selecciona todos los campos de la tabla libros cuyo título comience por la cadena de caracteres “El “(ojo al espacio después), luego haya un conjunto de caracteres cualquiera,
-- luego le siga la cadena de caracteres “ de “ (espacio antes y después), tras esto haya un carácter cualquiera, la cadena de caracteres “or”, otro carácter cualquiera y termine con la cadena de caracteres “es”.
select * from libros where titulo like "El % de %" or "%es";

-- 4.3.4.7 Selecciona todos los campos de la tabla libros cuyo título comience por la cadena de caracteres “La”
select * from libros where titulo like "La%";


-- 4.3.5.1 Selecciona todos los campos de la tabla empleados cuyo email sea nulo
select * from empleados where email is null;

-- 4.3.5.2 Selecciona todos los campos de la tabla libros cuyo autor sea nulo
select * from libros where autor is null;

-- 4.3.5.3 Selecciona todos los campos de la tabla empleados cuyo email no sea nulo
select * from empleados where email is not null;

-- 4.3.5.4 Selecciona todos los campos de la tabla libros cuyo autor no sea nulo
select * from libros where autor is not null;


----------------------------------------------------------------
-- 4.4 Precedencia de operadores (Aritméticos y lógicos)
----------------------------------------------------------------

-- 4.4.1.1 Seleccionar empleados cuyo sueldo sea mayor de 1300 pero menor de 1600 y que no tengan un correo electrónico registrado.
select * from empleados where sueldo between 1300 and 1600 and email is null;

-- 4.4.1.2 Seleccionar empleados que sean operarios o encargados y cuyo sueldo sea mayor o igual a 1300.
select * from empleados where (puesto like '%operario%' or puesto like '%encargado%') and sueldo >= 1300;

-- 4.4.1.3 Seleccionar empleados que no sean profesores ni actores y que tengan un sueldo mayor a 1400 o un teléfono que empiece con 948.
select * from empleados where puesto not in ("profesor", "actor") and sueldo > 1400 or telefono like "948%";

-- 4.4.1.4 Seleccionar empleados cuyo sueldo sea menor o igual a 1400 o que trabajen como supervisores, pero excluyendo aquellos cuyo nombre comience con 'M'.
select * from empleados where sueldo <= 1400 or puesto like "supervisor" and nombre not like "M%";

-- 4.4.1.5 Seleccionar empleados cuyo sueldo sea mayor que 2000 o cuyo puesto sea "encargado" y, además, el teléfono no comience con "948" o el email no esté registrado.
select * from empleados where sueldo > 2000 or puesto like "encargado" and telefono not like "948%" or email is not null;

-- 4.4.1.6 Seleccionar empleados que sean "supervisor" o "operario", pero que tengan un sueldo inferior a 1800, y además que no tengan registrado un email, o bien que el teléfono comience con "979".
select * from empleados where puesto in ('supervisor', 'operario') and sueldo < 1800 and (email is null or telefono like '979%');


----------------------------------------------------------------
-- 4.5 Ordenación en los resultados
----------------------------------------------------------------

-- 4.5.1.1 Selección del nombre, apellido y año de nacimiento de todas las personas. Ordénalos por el año de nacimiento descendentemente y por apellido ascendentemente.
select nombre, apellido, año_nacimiento from personas order by año_nacimiento desc, apellido asc;

-- 4.5.1.2 Selecciona el apellido, nombre y sede de las personas que trabajan en la sede AB y que actualmente estén trabajando. Ordena el resultado por apellido y nombre ascendentes.
select apellido, nombre, sede_trabaja from personas where sede_trabaja = "AB" and puesto <> "jubilado" order by apellido, nombre asc;

-- 4.5.1.3 Selecciona el NIF y NOMBRE de la tabla PERSONAS cuyo año de nacimiento sea mayor o igual a 1978 y el salario mayor a 950 ordénalos por orden de apellido y nombre de manera descendente.
select nif, nombre from personas where año_nacimiento >= 1978 and salario > 950 order by apellido, nombre desc;


----------------------------------------------------------------
-- 4.6 Limitación de resultados
----------------------------------------------------------------

-- 4.6.1.1 Ordena las personas por el sueldo de menor a mayor y muestra las cuatro primeras ordenadas por edad descendente.
select * from personas order by salario asc, año_nacimiento asc limit 4;

-- 4.6.1.2 Repite la consulta anterior, pero mostrando solo la segunda fila.
select * from personas order by salario asc, año_nacimiento asc limit 1 offset 1; 

-- 4.6.1.3 Repite la consulta anterior, pero mostrando solo las filas 3 y 4.
select * from personas order by salario asc, año_nacimiento asc limit 2 offset 2;

-- 4.6.1.4 De las personas cuyo apellido empieza por la letra A muestra dos de las que tengan mayor antigüedad.
select * from personas where apellido like "a%" order by fecha_alta limit 2;


----------------------------------------------------------------
-- 4.7 Funciones sobre filas
----------------------------------------------------------------

-- 4.7.1.1 Selecciona los campos de la tabla empleados para que se muestren los resultados de la siguiente manera:
select concat(nombre, " ", apellidos) as "Nombre completo" from empleados;

-- 4.7.1.2 Selecciona los campos de la tabla libros para que se muestren los resultados de la siguiente manera:
select concat(titulo, ": ", precio) as "Titulo y precio" from libros;

-- 4.7.1.3 Selecciona los campos de la tabla facturas para que se muestren los resultados de la siguiente manera:
select concat(destinatario, ": ", importe) as "Cliente e importe" from facturas;

-- 4.7.1.4 Selecciona el nombre y apellidos de la tabla empleados de la siguiente manera:
select concat(upper(apellidos), ", ", lower(nombre)) as "Nombre completo" from empleados;

-- 4.7.1.5 Muestra información sobre los libros cuyo autor no es nulo de la siguiente manera:
select concat("Libro: ", titulo, "(", upper(tipo), ")") as "Libro" from libros;

-- 4.7.1.6 Muestra la longitud de la cadena de caracteres del campo nombre.
select nombre, char_length(nombre) as "Tamano del nombre" from empleados;

-- 4.7.1.7 Muestra los tres primeros caracteres de cada apellido.
select apellidos, substring(apellidos, 1, 3 ) as "Primeras 3 letras" from empleados;

-- 4.7.1.8 Muestra los tres primeros caracteres de cada apellido. (Con puntos suspensivos)
select apellidos, concat(substring(apellidos, 1, 3), "...") as "Primeras 3 letras" from empleados;

-- 4.7.1.9 Muestra los dos últimos caracteres de cada apellido.
select apellidos, right(apellidos, 2) as "Ultimas 2 letras" from empleados;

-- 4.7.1.10 Muestra los dos últimos caracteres de cada apellido. (Con guión)
select apellidos, concat("-", right(apellidos, 2)) as "Ultimas 2 letras" from empleados;

-- 4.7.1.11 Muestra el nombre completo de cada persona de la siguiente manera:
select concat(substring(nombre, 1, 1), ".", apellidos) as "Nombre" from empleados;

-- 4.7.2.1 Selecciona los campos nombre, apellidos y sueldo, redondeando este último a 1 decimal, de la tabla empleados.
select nombre, apellidos, round(sueldo, 1) from empleados;

-- 4.7.2.2 Selecciona los campos título y precio, redondeado este último sin decimales, de la tabla libros.
select titulo, round(precio) from libros;

-- 4.7.2.3 Selecciona los campos destinatario e importe, redondeado este último a 1 decimal, de la tabla facturas. (Añade el símbolo de €)
select destinatario, concat(round(importe, 1), " $") from facturas;

-- 4.7.3.1 Selecciona el destinatario y el día del mes de la tabla facturas.
select destinatario, dayofmonth(fecha_hora) from facturas;

-- 4.7.3.2 Selecciona el destinatario y el día de la semana (numérico) de la tabla facturas.
select destinatario, dayofweek(fecha_hora) from facturas;

-- 4.7.3.3 Selecciona el destinatario y el mes (numérico) de la tabla facturas.
select destinatario, month(fecha_hora) from facturas;

-- 4.7.3.4 Selecciona el destinatario y el año de la tabla facturas.
select destinatario, year(fecha_hora) from facturas;

-- 4.7.3.5 Selecciona el destinatario y la hora de la tabla facturas.
select destinatario, time(fecha_hora) from facturas;

-- 4.7.3.6 Selecciona el destinatario y los minutos de la tabla factura.
select destinatario, minute(fecha_hora) from facturas;

-- 4.7.3.7 Selecciona el destinatario y la fecha actual de la tabla facturas.
select destinatario, current_date from facturas;

-- 4.7.3.8 Selecciona el destinatario y el momento actual de la tabla facturas.
select destinatario, now() from facturas;

-- 4.7.3.9 Selecciona los campos destinatario, fecha_hora, y la diferencia entre el momento actual y el campo fecha_hora de la tabla facturas.
select destinatario, fecha_hora, concat("Hace ", datediff(now(), fecha_hora), " dias") as "Retraso" from facturas;

-- 4.7.3.10 Selecciona el día de la fecha de alta de las personas de la tabla personas.
select day(fecha_alta) from personas;

-- 4.7.3.11 Lleva a cabo una consulta que muestre el nombre del día en que se les dio de alta a las personas de la tabla personas.
select dayname(fecha_alta) from personas;

-- 4.7.3.12 Lleva a cabo una consulta que muestre el nombre del día en que se les dio de alta y el nombre de esa persona.
select nombre, dayname(fecha_alta) from personas;

-- 4.7.3.13 Lleva a cabo una consulta en la que se muestre el nombre del mes el que fueron dados de baja los empleados que pertenecían a la sede AB.
select nombre, monthname(fecha_alta) from personas where puesto like "jubilado" and SEDE_TRABAJA = "AB";

-- 4.7.3.14 Lleva a cabo una consulta en la que se muestre los meses que han pasado entre la fecha de alta y la fecha actual 
-- y el nombre de cada de las personas de ellas. Solo tienes que tener en cuenta aquellas que sigan trabajando en la actualidad.
select nombre, timestampdiff(month, fecha_alta, now()) as antiguedad from personas where puesto not like 'jubilado';

-- 4.7.3.15 Indica la fecha (el nombre del mes y día), nombre en que se dieron de baja aquellas personas que están jubiladas. Atentos al encabezado de la tabla resultado.
select nombre, monthname(fecha_baja), dayname(fecha_baja) from personas where puesto like "jubilado";

-- 4.7.3.16 Indica el nombre y los años de antigüedad (años de alta) a día de hoy. Atentos al encabezado de la tabla resultado.
select nombre, timestampdiff(year, fecha_alta, now()) as "Antiguedad (anos de alta)" from personas;

-- 4.7.3.17 Indica el nombre y los años de antigüedad (años de alta) que tenían las personas el día 1/06/2020.
select nombre, timestampdiff(year, fecha_alta, "2020-06-01") as "Antiguedad (anos de alta)" from personas;

-- 4.7.3.18 Muestra el nombre del mes (sin que se repitan) en el que los empleados cuyo puesto es ‘JUBILADO’ y la sede en la que trabaja es la AC fueron dados de alta.
select distinct monthname(fecha_alta) as mes from personas where puesto = 'jubilado' and SEDE_TRABAJA = 'ac';

-- 4.7.3.19 Muestra el nombre del día en el que se dieron de baja los empleados que nacieron después del año 1979.
select dayname(fecha_baja) from personas where año_nacimiento > 1979;

-- 4.7.3.20 Muestra la fecha con el formato ‘El día de mes del año’ de la fecha en la que se dieron de baja las personas.
select nombre, concat('el ', day(fecha_baja), ' de ', monthname(fecha_baja), ' del ', year(fecha_baja)) as fecha_formateada from personas;

-- 4.7.4.1 Muestra los campos DNI, Nombre, Apellidos y Email de todos los empleados. En caso de no contener ningún valor en el mail se mostrará ‘No Disponible’.
select DNI, nombre, apellidos, coalesce(email, "No disponible") from empleados;

-- 4.7.4.2 Muestra el título y el autor de todos los libros cuyo título empieza por “L”. En caso de tratarse de un libro con autor nulo, muestra “Autor anónimo”.
select titulo, coalesce(autor, "Autor anonimo") from libros where titulo like "L%";

-- 4.7.5.1 Muestra el nombre completo en mayúsculas en una sola columna como en el ejemplo. Usa la tabla empleados.
select upper(concat(nombre, " ", apellidos)) as "Nombre en mayusculas" from empleados;


----------------------------------------------------------------
-- 4.8 Funciones de agregado
----------------------------------------------------------------

-- 4.8.1.1 Muestra la suma de los salarios de las personas que están en la sede AC.
select sede_trabaja, sum(salario) from personas where SEDE_TRABAJA = "AC";

-- 4.8.1.2 Muestra la media de los salarios de las personas que están en la sede AC y son operarios.
select sede_trabaja, puesto, round(avg(salario), 1) from personas where puesto = "operario" and SEDE_TRABAJA = "AC" group by SEDE_TRABAJA, puesto;

-- 4.8.1.3 Cuenta el número de personas que están jubiladas (consta en el campo puesto).
select puesto, count(*) as "N. Personas" from personas where puesto = "jubilado";

-- 4.8.1.4 Muestra el mayor año de nacimiento de los jubilados de la sede AC.
select sede_trabaja, puesto, año_nacimiento from personas where puesto = "jubilado" order by año_nacimiento limit 1;


----------------------------------------------------------------
-- 4.9 Group By
----------------------------------------------------------------

-- 4.9.1.1 Muestra el número de empleados que hay por cada una de las sedes.
select SEDE_TRABAJA, count(*) from personas group by SEDE_TRABAJA;

-- 4.9.1.2 Seleccionar la suma de sueldos por puesto, independiente de la sede.
select puesto, sum(salario) from personas group by puesto;

-- 4.9.1.3 Seleccionar la suma de sueldos por puesto y por sede.
select SEDE_TRABAJA, puesto, sum(salario) from personas group by SEDE_TRABAJA, puesto;

-- 4.9.1.4 Seleccionar cuántas personas hay por cada puesto y sede.
select puesto, SEDE_TRABAJA, count(*) from personas group by puesto, SEDE_TRABAJA;

-- 4.9.1.5 Seleccionar la cantidad de personas clasificadas por año de nacimiento.
select AñO_NACIMIENTO, count(*) from personas group by AñO_NACIMIENTO;

-- 4.9.1.6 Seleccionar la sede que tiene una media de año de nacimiento más joven. (suponiendo que solo fuera una)
select sede_trabaja, round(avg(AñO_NACIMIENTO)) as media_anio from personas group by sede_trabaja order by media_anio desc limit 1; 

-- 4.9.1.7 Nº de altas en cada año.
select year(FECHA_ALTA), count(*) from personas group by FECHA_ALTA;

-- 4.9.1.8 Nº de altas por año, de aquellas personas nacidas después de 1980.
select year(FECHA_ALTA), count(*) from personas where AñO_NACIMIENTO > 1980 group by FECHA_ALTA;

-- 4.9.1.9 Cuenta los tipos de puestos de trabajo que existen en cada una de las sedes.
select SEDE_TRABAJA, count(distinct puesto) from personas group by SEDE_TRABAJA;

-- 4.9.1.10 Visualizar de cada ofipuestocio todos los datos que puedas (conteo, mínimo, media, máximo, sumatorio) y proporciónale alias a cada columna.
-- esta me la salto que es una mezcla de todo

-- 4.9.1.11 Visualizar de cada oficio todos los datos que puedas (conteo, mínimo, media, máximo, sumatorio) y proporciónale alias a cada columna.
select oficio, count(*), min(salario), avg(salario), max(salario), sum(salario) from trabajadores group by oficio;

-- 4.9.1.12 Visualizar cuántos trabajadores por departamento y oficio. Usa alias para la columna agregada. Ordénalo por departamento y luego por oficio.
select dept_no, oficio, count(*) from trabajadores group by oficio, dept_no order by dept_no, oficio;

-- 4.9.1.13 Selecciona uno de los departamentos que más trabajadores tiene y su número de trabajadores. Usa LIMIT. 
select dept_no, count(*) from trabajadores group by dept_no order by count(*) desc limit 1;

-- 4.9.1.14 Selecciona el oficio que más trabajadores tiene. Usa LIMIT. 
select oficio, count(*) from trabajadores group by oficio order by count(*) desc limit 1; 

-- 4.9.1.15 Resumir los trabajadores (cuántos y salario medio) por año de fecha de alta en la empresa. Ordenar por fecha descendente.
select count(*), avg(salario), year(fecha_alt) as ano from trabajadores group by ano order by ano desc;

-- 4.9.1.16 Departamento(s) con mayor número de trabajadores que sean EMPLEADO y su nº de trabajadores.
select dept_no, count(*) from trabajadores where oficio = "empleado" group by dept_no order by count(*) desc limit 1;

-- 4.10.1.1 Muestra las sedes que tengan más de tres empleados trabajando para ellas.
select sede_trabaja, count(*) from personas group by sede_trabaja;

-- 4.10.1.2 Muestra aquellos puestos de trabajo cuya suma de todos los empleados supere los 5000 €.
select puesto, sum(salario) from personas group by puesto order by sum(salario) desc limit 1;

-- 4.10.1.3 Muestra aquellos puestos de trabajo que contengan una 'A' en su nombre, y que la suma total de los salarios de las personas de ese puesto sea mayor de 5000 €.
select puesto, sum(salario) from personas where puesto like "%a%" group by puesto order by sum(salario) desc limit 1;
select puesto, sum(salario) from personas where nombre like "%a%" group by puesto order by sum(salario) desc limit 1;

-- 4.10.1.4 Muestra los puestos de trabajo que tengan una media de sueltos entre 800 y 1200.
select puesto, avg(salario) from personas where avg(salario) between 800 and 1200 group by puesto; -- mal hecha
select puesto, avg(salario) from personas group by puesto having avg(salario) between 800 and 1200;

-- 4.10.1.5 Selecciona cada año en el que haya habido altas y el número de personas que se han dado de alta. Muestra solo los años en los que se hayan dado de alta 3 o más personas nacidas después de 1980.
select year(fecha_alta), count(*) from personas where year(fecha_alta) > 1980 group by year(fecha_alta) having count(*) > 3;

-- 4.10.1.6 Muestra aquellos cargos que tengan más de 1 empleado
select puesto

-- 4.10.1.8 Seleccionar la extensiones telefónicas que estén asignadas a más de un empleado, indicando a cuántos empleados está asignado cada uno.




----------------------------------------------------------------
-- 4.10 Having
----------------------------------------------------------------











