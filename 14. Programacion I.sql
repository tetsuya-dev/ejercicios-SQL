-- --------------------------------------------------------------
-- 14.1 Procedimientos sin parámetros
-- --------------------------------------------------------------

-- 14.1.1 Escribe un procedimiento denominado “holaMundo” que no tenga ningún parámetro de entrada ni de salida y que muestre el texto ¡Hola mundo!
drop procedure if exists holaMundo;
delimiter $$
create procedure holaMundo()
begin
	select "¡Hola mundo!";
end$$$
delimiter ;

call holaMundo();

-- 14.1.2 Escribe un procedimiento denominado ‘muestraFecha’ que muestre la fecha actual con un mensaje de este tipo.
-- Ejemplo:  "Hoy es día XX del mes de XXXXXX del año XXXX"
drop procedure if exists muestraFecha;
delimiter $$
create procedure muestraFecha()
begin
    declare dia, anho int;
    declare mes varchar(25);
    declare mensaje longtext default "";
    
    set dia = day(curdate());
    set anho = year(curdate());
    set mes = monthname(curdate());
    
    set mensaje = concat("Hoy es día ", dia, " del mes de ", mes, " del año ", anho);
    
    select mensaje;
end$$
delimiter ;
call muestraFecha();

-- 14.1.3 Escribe un procedimiento denominado ‘listaEquipos’ que muestre la lista de equipos y el número de jugadores que hay en cada uno.
drop procedure if exists listaEquipos;
delimiter $$
create procedure listaEquipos()
begin
	declare nombreEquipo varchar(30);
    declare numJugadores int;
    
    set numJugadores = (select count(*) from jugadores group by equipo);
    set nombreEquipo = (select equipo from jugadores);
end$$
delimiter ;

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

call modificaSalario(110);





-- --------------------------------------------------------------
-- 14.7 Estructuras de control iterativas no anidadas
-- --------------------------------------------------------------

-- 14.7.1 Crea un procedimiento llamado “secuenciaNumeros” que, dado un número como parámetro, muestre todo el intervalo de números desde el 1 hasta el número de la siguiente manera:=
--    Ejecución: CALL secuenciaNumeros (11);
--    Respuesta por pantalla: ‘Los números del intervalo desde 1 hasta 11 son 1 2 3 4 5 6 7 8 9 10 11.’
--    Ojo: Debe comprobar que el número es positivo.
drop procedure if exists secuenciaNumeros;
delimiter $$
create procedure secuenciaNumeros(in n int)
begin
	declare num int;
    declare t varchar(100);
    set num = 1;
    set t = "";
	while (num <= n) do
		set t = concat(t, num, " ");
        set num = num + 1;
    end while;
    select t;
end$$
delimiter ;
call secuenciaNumeros(11);


-- 14.7.2 Crea un procedimiento llamado “secuenciaNumeros2” que, dado dos números como parámetro, muestre todo el intervalo de números desde el primer parámetro hasta el segundo parámetro de la siguiente manera:
--     Ejecución: CALL secuenciaNumeros2 (3,9);
--     Respuesta por pantalla: ‘Los números del intervalo desde 3 hasta 9 son 3 4 5 6 7 8 9’;
--     Ojo: Debe comprobar que los números son positivos y el segundo mayor que el primero.
drop procedure if exists secuenciaNumeros2;
delimiter $$
create procedure secuenciaNumeros2(in n int, in n2 int)
begin
	declare num int;
    declare t varchar(100);
    set t = "";
	while (n <= n2) do
		set t = concat(t, n, " ");
        set n = n + 1;
    end while;
    select t;
end$$
delimiter ;
call secuenciaNumeros2(4, 10);

-- 14.7.3 Crea un procedimiento llamado “secuenciaNumeros3” que amplíe la funcionalidad del anterior ejercicio usando comas entre los números:
--    Ejecución: CALL secuenciaNumeros3 (3,9)
--    Respuesta por pantalla: ‘Los números del intervalo desde 3 hasta 9 son 3, 4, 5, 6, 7, 8, 9.’
--    ¡Ojo que tras el último número no hay coma!
--    Ojo: Debe comprobar que los números son positivos y el segundo mayor que el primero.
drop procedure if exists secuenciaNumeros3;
delimiter $$
create procedure secuenciaNumeros3(in n int, in n2 int)
begin
	declare num int;
    declare t varchar(100);
    set t = "";
	while (n <= n2) do
		if (n = n2) then
			set t = concat(t, n, ". ");
		else
			set t = concat(t, n, ", ");
        end if;
        set n = n + 1;
    end while;
    select t;
end$$
delimiter ;
call secuenciaNumeros3(3, 11);

-- 14.7.4 Crea un procedimiento llamado “tablaMultiplicar” que recibirá un número entero entre 1 y 9 para que haga lo siguiente:
--     Borre si existe y después cree una tabla llamada TablaMul con 3 columnas de tipo número entero.
-- 		CREATE TABLE TablaMul(
-- 		numero INT,
-- 		multiplicador INT,
-- 		resultado INT);	
-- a. En la primera el número recibido como parámetro.
-- b. En la segunda cada número del 1 al 9 según la fila.
-- c. En la tercera el resultado de multiplicar las columnas anteriores
--     Inserta la tabla de multiplicar del número proporcionado en la tabla creada y después muéstrala por pantalla.
drop procedure if exists tablaMultiplicar;
delimiter $$
create procedure tablaMultiplicar(in n int)
begin
	declare mul int;
    set mul = 1;
	
	drop table if exists TablaMul;
	CREATE TABLE TablaMul(
		numero INT,
		multiplicador INT,
		resultado INT)
        ;	
	while (mul <= 9) do
		insert into TablaMul (numero, multiplicador, resultado) values(n, mul, n * mul);
		set mul = mul + 1;
	end while;
    select * from TablaMul;
end$$
delimiter ;
call tablaMultiplicar(3);


-- 14.7.6 Crear un procedimiento llamado “invertirCadena” que, dado un parámetro de cadena de caracteres, almacene en una variable esa cadena “al revés”, es decir, con el orden de sus caracteres invertido. 
-- Después, muestra el valor de la variable (la cadena invertida).
--    Ojo: Solo puedes usar las siguientes funciones: CONCAT(), SUBSTRING(cadena, posición, numCaracteres) y CHAR_LENGTH().
drop procedure if exists invertirCadena;
delimiter $$
create procedure invertirCadena(in texto varchar(100))
begin
	declare invertido varchar(100);
    declare c varchar(1);
    declare n, largo int;
    set invertido = "";
    set c = "";
    set n = 0;
    set largo = char_length(texto);
    while (n < largo) do
		set c = substring(texto, largo - n, 1);
        set invertido = concat(invertido, c);
        set n = n + 1;
    end while;
    select invertido;
end$$
delimiter ;
call invertirCadena("hola");


-- 14.7.7 Crear un procedimiento llamado “creaVacaciones” que reciba como parámetro un año (tipo YEAR) y que inserte en una tabla todas las fechas de los fines de semana y del mes de agosto.
--     El procedimiento borra la tabla si es que existe y crea la siguiente tabla:
-- 	CREATE TABLE Vacaciones(
-- 	Dia_Vac DATE UNIQUE NOT NULL)
--     ;
--     Vamos recorriendo todas las fechas del año proporcionado para incluir todas las que pertenezcan a fin de semana o a agosto.
--     Para terminar: El procedimiento mostrará todas las fechas de la tabla incluyendo una columna con el nombre del día de la semana.
--         Pista 1: Las fechas también se pueden construir como cadenas y se les puede aplicar CONCAT().
--         Pista 2: La función DATE_ADD (fecha, INTERVAL numDias DAY) incrementa una fecha un número determinado de días y luego devuelve la fecha.
drop procedure if exists creaVacaciones;
delimiter $$
create procedure creaVacaciones(in anio year)
begin
    declare fecha_actual date;
    declare fecha_fin date;
    
    set fecha_actual = concat(anio, '-01-01');
    set fecha_fin = concat(anio, '-12-31');

    drop table if exists Vacaciones;
    create table Vacaciones(
        Dia_Vac date unique not null
    );

    while (fecha_actual <= fecha_fin) do
        if (month(fecha_actual) = 8 OR dayofweek(fecha_actual) IN (1, 7)) then
            insert ignore into Vacaciones (Dia_Vac) values (fecha_actual);
        end if;
        set fecha_actual = date_add(fecha_actual, interval 1 day);
    end while;
    select Dia_Vac, dayname(Dia_Vac) as Nombre_Dia 
    from Vacaciones
    order by Dia_Vac;

end$$
delimiter ;

call creaVacaciones(2024);


-- 14.7.8 Crear un procedimiento llamado “cuentaPalabras” que, dado un parámetro de cadena de caracteres, cuente el número de palabras que contiene.
--     Una palabra está delimitada por un espacio, un inicio de cadena o un fin de cadena.
--     Ojo: Solo puedes usar las siguientes funciones: CONCAT(), SUBSTRING(cadena, posición, numCaracteres) y CHAR_LENGTH().
--         Pista: Para obtener el carácter número 5 de la cadena str tienes que ejecutar SUBSTRING(str , 5 , 1).
--         Equivale a “dame un carácter en la posición 5 de la cadena str.
drop procedure if exists cuentaPalabras;
delimiter $$
create procedure cuentaPalabras(in texto varchar(500))
begin
	declare contador, largo, n int;
    declare c varchar(1);
    set contador = 1;
    set largo = char_length(texto);
    set n = 0;
    while (n < largo) do
		set c = substring(texto, n, 1);
        if (c like " ") then
			set contador = contador + 1;
        end if;
        set n = n + 1;
    end while;
    select contador;
end$$
delimiter ;
call cuentaPalabras("hola como estas amigo");


-- --------------------------------------------------------------
-- 14.8 Estructuras de control iterativas anidadas
-- --------------------------------------------------------------

-- 14.8.1 Crear un procedimiento llamado “numerosFactoriales” que, dado un parámetro ‘limite’, muestre el resultado de todos factoriales hasta el límite dado por el parámetro.
--     Ejecución: CALL numerosFactoriales (7);
--     Respuesta por pantalla:
-- 1! = 1
-- 2! = 2
-- 3! = 6
-- 4! = 24
-- 5! = 120
-- 6! = 720
-- 7! = 5040
drop procedure if exists numerosFactoriales;
delimiter $$
create procedure numerosFactoriales(in limite int)
begin
    declare n int default 1;
    declare resultado bigint default 1; 
    declare salida text default "";
    while (n <= limite) do
        set resultado = resultado * n;
        set salida = concat(salida, n, "! = ", resultado, "\n");
        set n = n + 1;
    end while;

    select salida ;
end$$
delimiter ;

call numerosFactoriales(7);


-- 14.8.2 Crear un procedimiento llamado “numerosPrimos” que, dado un parámetro ‘cantidad’, muestre n-primeros números primos.
--     Ejecución: CALL numerosPrimos (20); Mostrará los 20 primeros números primos.
--     Respuesta por pantalla:
-- Los 20 primeros números primos son: 2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67 y 71.
drop procedure if exists numerosPrimos;
delimiter $$
create procedure numerosPrimos(in limite int)
begin
    declare n int default 2;      
    declare divisor int;
    declare es_primo boolean;
    declare resul varchar(500) default "";

    while (n <= limite) do
        set es_primo = true;
        set divisor = 2;
        
        while (divisor <= n / 2) do
            if (n % divisor = 0) then
                set es_primo = false;
            end if;
            set divisor = divisor + 1;
        end while;
        if (es_primo) then
            set resul = concat(resul, n, " ");
        end if;
        set n = n + 1;
    end while;

    select resul ;
end$$
delimiter ;

call numerosPrimos(20);


-- 14.8.3 Crear un procedimiento “creaRampa” Dado como parámetro un número que debe ser menor que 30 construye la siguiente estructura del ejemplo hasta el límite que marque el parámetro.
--     Por ejemplo, para el parámetro 7 se mostrará por pantalla.
-- 1
-- 22
-- 333
-- 4444
-- 55555
-- 666666
-- 7777777
--     Recuerda que para hacer un salto de línea se debe usar el “\n”.
drop procedure if exists creaRampa;
delimiter $$
create procedure creaRampa(in limite int)
begin
    declare i int default 1;
    declare rampa text default "";
    if (limite < 30) then
        while (i <= limite) do
            set rampa = concat(rampa, repeat(i, i), '\n');
            set i = i + 1;
        end while;
        select rampa;
    else
        select "Error: El número debe ser menor a 30";
    end if;
end$$
delimiter ;

call creaRampa(7);


-- 14.8.4 Crear un procedimiento “creaFlecha” Dado como parámetro un número que debe ser menor que 30 construye la siguiente estructura del ejemplo hasta el límite que marque el parámetro.
--     Por ejemplo, para el parámetro 7 se mostrará por pantalla.
-- 1
-- 22
-- 333
-- 4444
-- 55555
-- 666666
-- 7777777
-- 666666
-- 55555
-- 4444
-- 333
-- 22
-- 1
--     Recuerda que para hacer un salto de línea se debe usar el “\n”.

drop procedure if exists creaFlecha;
delimiter $$
create procedure creaFlecha(in limite int)
begin
    declare i int;
    declare flecha text default '';
    if (limite < 30) then
        set i = 1;
        while (i <= limite) do
            set flecha = concat(flecha, repeat(i, i), '\n');
            set i = i + 1;
        end while;
        set i = limite - 1;
        while (i >= 1) do
            set flecha = concat(flecha, repeat(i, i), '\n');
            set i = i - 1;
        end while;
        select flecha;
    else
        select "Error: El número debe ser menor a 30" ;
    end if;
end$$
delimiter ;

call creaFlecha(7);
