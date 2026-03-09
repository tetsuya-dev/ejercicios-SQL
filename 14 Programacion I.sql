-- --------------------------------------------------------------
-- 14.3 Variables
-- --------------------------------------------------------------

-- 14.3.1 Reescribe el procedimiento “cuantosJugadores” (14.2.8) usando dos variables locales: en una almacenarás el 
-- número de jugadores solicitado (con SET) y en la otra almacenarás el mensaje de salida (con SET). Después mostrarás el valor de la variable “mensaje”.
drop procedure cuantosJugadores;
delimiter $$
create procedure cuantosJugadores(nombre varchar(50))
begin
select count(*) from jugadores where equipo = nombre into @numJugadores;
set @mensaje = concat("El equipo ",nombre," tiene ", @numJugadores, " jugadores");
select @mensaje;
end$$
delimiter ;
call cuantosJugadores("Real Madrid");


-- 14.3.2 Reescribe el procedimiento “holaNombre” (14.2.6) usando una variable local donde almacenarás el mensaje de salida para después mostrar el valor de esta variable.
drop procedure holaNombre;
delimiter $$
create procedure holaNombre(nombre varchar(20))
begin
set @holaNombre = concat("¡Hola ",nombre,"!");
select @holaNombre;
end$$
delimiter ;
call holaNombre("Raul");

-- 14.3.3 Reescribe el procedimiento “muestraFechaDada” usando 4 variables locales: en 3 almacenarás, respectivamente, el día, mes y año de la fecha proporcionada 
-- y en la otra almacenarás el mensaje de salida. Después mostrarás el valor de la variable “mensaje”.
drop procedure muestraFechaDada;
delimiter $$
create procedure muestraFechaDada(fecha date)
begin
declare dia, mes, anho, mensaje varchar(200);

set dia = day(fecha);
set mes = monthname(fecha);
set anho = year(fecha);
set mensaje = concat("Today is ", dia, " of ", mes, " ", anho);
select mensaje;
end$$
delimiter ;
call muestraFechaDada("2020-05-09");


-- 14.3.4 Reescribe el procedimiento infoPagos usando 5 variables locales: en 4 almacenarás, respectivamente, el máximo, mínimo, 
-- media y total de los pagos (con SELECT INTO) y en la otra almacenarás el mensaje de salida (con SET). HAY QUE TERMINARLO
drop procedure infoPagos;
delimiter $$
create procedure infoPagos(tipo varchar(20))
begin

end$$
delimiter ;
call infoPagos();



-- --------------------------------------------------------------
-- 14.4 Funciones
-- --------------------------------------------------------------

-- 14.4.1 Crea una función ‘fn_diferenciaSalario’ que reciba un código de empleado y que calcule la diferencia de salario de un empleado con el salario medio de toda la empresa (redondeado a dos decimales).
drop function fn_diferenciaSalario;
delimiter $$
create function fn_diferenciaSalario(codigo int) returns double deterministic
begin

declare salarioEmpleado, salarioMedio, diferenciaSalarial double;
select salario from empleados where cod_empleado = codigo into salarioEmpleado; 
select avg(salario) from empleados into salarioMedio; 
set diferenciaSalarial = round(salarioEmpleado - salarioMedio, 2);
return diferenciaSalarial;

end$$
delimiter ;
select fn_diferenciaSalario(150);

-- 14.4.2 Escribe una función llamada “fn_numPedidosPorEstado” que reciba como parámetro un estado de pedido y devuelva cuántos pedidos de ese estado se tiene.
drop function fn_numPedidosPorEstado;
delimiter $$
create function fn_numPedidosPorEstado(estado varchar(50)) returns int deterministic
begin

end$$
delimiter ;

-- --------------------------------------------------------------
-- 14.5 Estructuras de control condicionales simples
-- --------------------------------------------------------------

-- 14.5.3.1 Modifica el procedimiento “esPositivo” (14.5.2.1) haciendo uso de la estructura de control CASE. Llámalo “esPositivoCase”.
drop procedure esPositivoCase;
delimiter $$
create procedure esPositivoCase(numero int)
begin
	case
		when (numero < 0) then
			select "El numero es negativo";
        when (numero > 0) then
			select "El numero es positivo";
		else
        select "El numero es 0";
	end case;

end$$
delimiter ;
call esPositivoCase(1);

-- 14.5.3.2 Modifica el procedimiento “dameNota2” (14.5.2.2) haciendo uso de la estructura de control CASE. Llámalo “esPositivoCase”.
drop procedure dameNota2;
delimiter $$
create procedure dameNota2(num int)
begin
	case 
		when (num >= 0 and num < 5) then
			select "Insuficiente";
		when (num >= 5 and num < 6) then
			select "Aprobado";
		when (num >= 6 and num < 7) then
			select "Bien";
		when (num >= 7 and num < 9) then
			select "Notable";
		when (num >= 9 and num <= 10) then
			select "Sobresaliente";
		else 
			select "Nota no valida";
    end case;
end$$
delimiter ;
call dameNota2(1);


-- 14.5.3.3 Escribe un procedimiento llamado “díaSemana” que reciba como parámetro de entrada un valor numérico que represente un día 
-- de la semana y que escriba por pantalla una cadena de caracteres con el nombre del día de la semana correspondiente. Usa CASE.
drop procedure diaSemana;
delimiter $$
create procedure diaSemana(num int)
begin
	case
		when (num = 1) then
			select "Lunes";
		when (num = 2) then
			select "Martes";
		when (num = 3) then
			select "Miercoles";
		when (num = 4) then
			select "Jueves";
		when (num = 5) then
			select "Viernes";
           when (num = 6) then
			select "Sabado";
		when (num = 7) then
			select "Domingo";
    end case;
end$$
delimiter ;
call diaSemana(7);


-- 14.6.1 Implementar un script llamado `tarifaHotel ́ que calcule (y muestre) el precio de una habitación de un hotel en base a la temporada (ALTA, MEDIA o BAJA), 
-- el número de noches y el tipo de habitación (EXTERIOR o INTERIOR). El procedimiento usará 3 parámetros: la temporada, el no de noches y el tipo de habitación. 
-- El precio BASE por noche de una habitación EXTERIOR es de 80 € y el de la interior es de 60 €. En temporada ALTA se aplica un incremento del 20% al precio base 
-- y en la BAJA un descuento del 10%. Se mostrará la información en la pantalla de la siguiente manera:
drop procedure if exists tarifaHotel;
delimiter $$
create procedure tarifaHotel(temp varchar(20), num int, tipo varchar(30))
begin
    declare precio_base decimal(10,2);
    declare precio_final decimal(10,2);
    declare total decimal(10,2);

    if upper(tipo) = 'EXTERIOR' then
        set precio_base = 80;
    else
        set precio_base = 60;
    end if;

    case upper(temp)
        when 'ALTA' then set precio_final = precio_base * 1.20;
        when 'BAJA' then set precio_final = precio_base * 0.90;
        else set precio_final = precio_base;
    end case;

    set total = precio_final * num;


    select concat('Temporada: ', upper(temp)) as Detalle;
    select concat('Habitación: ', upper(tipo)) as Detalle;
    select concat('Noches: ', num) as Detalle;
    select concat('Precio Total: ', total, ' €') as Resultado;
end$$
delimiter ;
call tarifaHotel('ALTA', 3, 'EXTERIOR');


-- 14.6.2 Implementar un procedimiento llamado `cursosProfesor ́ en la base de datos bdFormacion que, dado un nombre de profesor 
-- (cuyo valor recibiremos como parámetro), muestre su código de profesor y la cantidad de cursos que ha impartido.
    -- El nombre del profesor tan solo debe contener el valor parámetro, no tiene por qué ser idéntico.
--     Si el profesor no existe o hay varios profesores con el mismo nombre se mostrarán mensajes diferentes.
--     El mensaje relativo a los cursos impartidos debe ser distinto si no ha impartido ningún curso, si sólo ha impartido uno o si han sido varios los cursos impartidos.
--  	Ayuda: campotabla LIKE CONCAT('%', nombreParámetro, '%');
drop procedure if exists cursosProfesor;
delimiter $$
create procedure cursosProfesor(p_nombre varchar(25))
begin
    declare v_numProfes int;
    declare v_codp varchar(10);
    declare v_numCursos int;

    select count(*) into v_numProfes from profesores where nomp like concat('%', p_nombre, '%');

    if v_numProfes = 0 then
        select 'El profesor no existe' as Error;
    elseif v_numProfes > 1 then
        select 'Existe más de un profesor con el mismo nombre' as Error;
    else
        -- Solo hay uno, obtenemos su código y contamos sus cursos
        select codp into v_codp from profesores where nomp like concat('%', p_nombre, '%');
        select count(*) into v_numCursos from cursillos where codp = v_codp;

        -- Mensajes personalizados según cantidad de cursos
        if v_numCursos = 0 then
            select v_codp as Codigo, 'No ha impartido ningún curso' as Mensaje;
        elseif v_numCursos = 1 then
            select v_codp as Codigo, 'Ha impartido sólo un curso' as Mensaje;
        else
            select v_codp as Codigo, concat('Ha impartido ', v_numCursos, ' cursos') as Mensaje;
        end if;
    end if;
end$$
delimiter ;
call cursosProfesor("Luis Dorado");


-- 14.6.3 Implementar una función llamada `alumnosProfesor ́ en la base de datos bdFormacion que, dada por parámetro una cadena de caracteres, devuelva lo siguiente:
--    -1 si no hay ningún profesor cuyo nombre contenga esa cadena.
--    -2 si hay varios profesores cuyo nombre contiene esa cadena.
--    Si solo un profesor contiene esa cadena, el número de alumnos que tiene ese profesor (no de alumnos adscritos a cursos que imparte el profesor).
-- Ayuda: campotabla LIKE CONCAT('%', nombreParámetro, '%');
drop function alumnosProfesor;
delimiter $$
create function alumnosProfesor(nombre varchar(25)) returns int deterministic
begin
declare profe, alumnos int;
set profe = (select count(*) from profesores where nomp like "%nombre%");
	case 
		when (profe = 0) then
			return -1;
		when (profe > 1) then
			return -2;
		when (profe = 1) then
			set alumnos = (select count(*) from cursillos join profesores on cursillos.CODP = profesores.CODP join alumnoscursillos cc on cursillos.CODCUR = cc.CODCUR where cursillos.CODP = profesores.CODP and profesores.NOMP like "%nombre%");
			return alumnos;
		end case;
	
end$$
delimiter ;
select alumnosProfesor("luis");


-- 14.6.4 Crea un procedimiento llamado “modificaSalario” que reciba un código de empleado y modifique su salario.
--    Si el empleado tiene oficio "PRESIDENTE", baja un 50% su salario.
--    Si el empleado tiene oficio "JEFESECTOR", baja un 10% su salario.
--    Si tiene oficio "VENDEDOR” sube un 10% su salario.
--   Si el empleado tiene oficio "EMPLEADO" aumenta un 20% su salario.
--    Si el código de empleado no existe muestra un error y sino muestra el nuevo salario.
--    Cualquier otro dejará el sueldo igual.
--    Usa la construcción CASE y la estructura IF.
--    Después usa IF EXISTS (SELECT * FROM ...) THEN ... para comprobar si existe el empleado.
--    Usa la construcción IF param_empleado NOT IN (SELECT ...) THEN ... para comprobar si existe el empleado.
drop procedure modificaSalario;
delimiter $$
CREATE PROCEDURE modificaSalario(IN idEmpleado INT)
BEGIN 
    DECLARE v_oficio VARCHAR(25);
    DECLARE v_existe INT DEFAULT 0;

    SELECT COUNT(*), oficio INTO v_existe, v_oficio 
    FROM empleados 
    WHERE cod_empleado = idEmpleado;

    IF v_existe = 0 THEN
        SELECT "Error: El ID de empleado no existe" AS Mensaje;
    ELSE
        CASE v_oficio
            WHEN 'PRESIDENTE' THEN
                UPDATE empleados SET salario = salario * 0.5 WHERE cod_empleado = idEmpleado;
            WHEN 'JEFESECTOR' THEN
                UPDATE empleados SET salario = salario * 0.9 WHERE cod_empleado = idEmpleado;
            WHEN 'VENDEDOR' THEN
                UPDATE empleados SET salario = salario * 1.1 WHERE cod_empleado = idEmpleado;
            WHEN 'EMPLEADO' THEN
                UPDATE empleados SET salario = salario * 1.2 WHERE cod_empleado = idEmpleado;
            ELSE
                SELECT "No se realizaron cambios: Oficio no contemplado" AS Mensaje;
        END CASE;

        -- Mostrar resultado final
        SELECT nombre, salario, oficio FROM empleados WHERE cod_empleado = idEmpleado;
    END IF;
END$$

DELIMITER ;

call modificaSalario(110)
