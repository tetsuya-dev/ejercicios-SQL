-- --------------------------------------------------------------
-- 15.1 Control de errores
-- --------------------------------------------------------------

-- 15.1.1 Crea una base de datos llamada test que contenga una tabla llamada alumno.
-- La tabla debe tener cuatro columnas:
--    id: entero sin signo (clave primaria).
--     nombre: cadena de 50caracteres.
--     apellido1: cadena de 50 caracteres.
--     apellido2: cadena de 50 caracteres.
-- Una vez creada la base de datos y la tabla, crea una función llamada "pr_insertar_alumno" con las siguientes características:
--     Recibe cuatro parámetros (id, nombre, apellido1, apellido2) y los inserta en la tabla alumno.
--     Devuelve el mensaje "la operación se ha realizado con éxito" si se ha insertado correctamente.
--     Devuelve el mensaje "Error: La clave primaria ya existe" si el ID está repetido en la tabla.
--     Devuelve el mensaje "Error: La tabla no existe" si no se encuentra la tabla.
--     Como se trabaja con dos errores diferentes, tiene que haber dos manejadores diferentes: 
--         Para el error: 1062 (infracción de clave primaria).
--         Para el error: 1146 (tabla no existente).
create database if not exists test;
use test;

create table if not exists alumno (
    id int unsigned primary key,
    nombre varchar(50),
    apellido1 varchar(50),
    apellido2 varchar(50)
);

delimiter $$

create function pr_insertar_alumno(p_id int unsigned, p_nombre varchar(50), p_apellido1 varchar(50), p_apellido2 varchar(50)) returns varchar(100) deterministic
begin
    declare continue handler for 1062 return 'error: la clave primaria ya existe';
    declare continue handler for 1146 return 'error: la tabla no existe';

    insert into alumno (id, nombre, apellido1, apellido2)  values (p_id, p_nombre, p_apellido1, p_apellido2);

    return 'la operación se ha realizado con éxito';
end$$
delimiter ;

select pr_insertar_alumno(1, "Pedro", "Sanchez", "Castejon");


-- 15.1.2 Realiza un procedimiento llamado “pr_borra_tabla” que intente eliminar la tabla pruebaUniversidad (esta tabla no existe).
--     Esto debe provocar un error 1051 o SQLSTATE '42S02' que debemos tratar saliendo del procedimiento y mostrando el siguiente mensaje:
-- "Has intentado eliminar una tabla que no existe y yo NOMBRE_ALUMNO APELLIDO_ALUMNO he evitado que lo hicieras."
--     Sustituye NOMBRE_ALUMNO APELLIDO_ALUMNO por tu nombre.
--     Si la tabla existiera debería eliminarla y, después, mostrar un mensaje en el que se indique lo siguiente: "Tabla eliminada con éxito"

drop procedure if exists pr_borra_tabla;
delimiter $$
create procedure pr_borra_tabla()
begin
    declare exit handler for 1051 
		begin 
			select 'Has intentado eliminar una tabla que no existe y yo Raul Sanchez he evitado que lo hicieras.' as Mensaje;
		end;

    drop table pruebaUniversidad;

    select 'Tabla eliminada con éxito' as Mensaje;
end$$
delimiter ;

call pr_borra_tabla();


-- 15.1.3 Realiza un procedimiento llamado “pr_inserta_profesor” que permita añadir un nuevo profesor en la tabla profesor. Para ello, hay que incluir su identificador de profesor 
--     y su identificador de departamento.
--     Si el profesor que se intentara insertar en la tabla ya estuviera en dicha tabla, debe generarse un error 1062 o SQLSTATE 'S1009' o '23000' 
--     que debe tratarse saliendo del procedimiento y mostrando el siguiente mensaje: "Has intentado insertar un profesor cuyo número ya existe"
--     Si el número de departamento pasado como parámetro no existiera, debería generarse un error 1452 o SQLSTATE '23000' que deba tratarse saliendo del procedimiento
--     y mostrando el siguiente mensaje: "La clave ajena que has probado no existe en la tabla departamentos"
--     Si la inserción es correcta, debe realizarse y, después, mostrarse el siguiente mensaje: "Inserción realizada con éxito".

drop procedure if exists pr_inserta_profesor;
delimiter $$
create procedure pr_inserta_profesor(id_profe int, id_depart int) -- SIN TERMINAR
begin
	insert into profesor values(id_profe, id_depart);
end$$
delimiter ;



-- --------------------------------------------------------------
-- 15.2 Cursores
-- --------------------------------------------------------------

-- 15.2.9 Crear un procedimiento llamado ‘insertaPedido’ que recibirá dos parámetros: un identificador de fabricante y un código postal. Para cada una de las tiendas 
-- que tengan el código postal especificado, inserta un pedido de una unidad de cada uno de los artículos del fabricante especificado.

drop procedure if exists insertarPedido;
delimiter $$
create procedure insertapedido(in p_id_fabricante int, in p_codpostal int)
begin
    declare v_nif_tienda varchar(10);
    declare fin_tiendas int default 0;
    declare v_id_articulo int;
    declare fin_articulos int default 0;

    declare cur_tiendas cursor for 
        select nif from tiendas where codpostal = p_codpostal;
        
    declare continue handler for not found set fin_tiendas = 1;

    open cur_tiendas;
    fetch cur_tiendas into v_nif_tienda;
    
    while fin_tiendas = 0 do
        begin
            declare cur_articulos cursor for 
                select id from articulos where id_fabricante = p_id_fabricante;
            declare continue handler for not found set fin_articulos = 1;
            set fin_articulos = 0; 
            open cur_articulos;
            fetch cur_articulos into v_id_articulo;
            while fin_articulos = 0 do
                insert into pedidos (nif_tienda, id_articulo, fecha_pedido, unidades_pedidas)
                values (v_nif_tienda, v_id_articulo, curdate(), 1);
                
                fetch cur_articulos into v_id_articulo;
            end while;
            close cur_articulos;
        end;
        fetch cur_tiendas into v_nif_tienda;
    end while;
    close cur_tiendas;
end$$

delimiter ;

call insertapedido(20, 19209);


-- 15.2.13 Crear un procedimiento llamado ‘datosProfesores’ que muestre para cada profesor su código, nombre, salario y la cantidad de cursillos impartidos de la manera que se muestra en el ejemplo.
--     OJO: si un profesor no imparte ningún curso, debe aparecer con 0 cursos.
drop procedure if exists datosprofesores;
delimiter $$
create procedure datosprofesores()
begin
    declare v_codp varchar(2);
    declare v_nomp varchar(25);
    declare v_salario decimal(10,2);
    declare v_num_cursillos int;
    declare fin int default 0;
    -- variable para acumular todo el texto
    declare resultado longtext default '';

    declare cur_profes cursor for 
        select codp, nomp, salario from profesores;
    declare continue handler for not found set fin = 1;

    open cur_profes;
    fetch cur_profes into v_codp, v_nomp, v_salario;

    while fin = 0 do
        -- contar cursillos del profesor actual
        select count(*) into v_num_cursillos from cursillos where codp = v_codp;
        
        -- acumulamos la línea en la variable resultado
        set resultado = concat(resultado, 'profesor: ', v_codp, ' - ', v_nomp, ' | salario: ', v_salario, ' | cursillos: ', v_num_cursillos, '\n');
        
        fetch cur_profes into v_codp, v_nomp, v_salario;
    end while;

    close cur_profes;

    -- un solo select al final con todo el informe
    select resultado as 'informe general de profesores';
end$$

delimiter ;

call datosprofesores();

-- 15.2.14 Ampliar el ejercicio anterior y nombrarlo como ‘datosProfesores2’ para que para que debajo de cada línea de profesor, en un segundo nivel tabulado (con espacios), 
-- aparezca el código, nombre del curso y las horas del curso o cursos que imparte.
drop procedure if exists datosprofesores2;
delimiter $$
create procedure datosprofesores2()
begin
    declare v_codp varchar(2);
    declare v_nomp varchar(25);
    declare fin_p int default 0;
    -- Variable para acumular todo el texto
    declare resultado longtext default '';

    declare cur_p cursor for select codp, nomp from profesores;
    declare continue handler for not found set fin_p = 1;

    open cur_p;
    fetch cur_p into v_codp, v_nomp;

    while fin_p = 0 do
        set resultado = concat(resultado, 'profesor: ', v_codp, ' - ', v_nomp, '\n');

        begin
            declare v_codcur varchar(2);
            declare v_nomcur varchar(25);
            declare v_horas int;
            declare fin_c int default 0;
            declare cur_c cursor for 
                select codcur, nomcur, numhoras from cursillos where codp = v_codp;
            declare continue handler for not found set fin_c = 1;

            open cur_c;
            fetch cur_c into v_codcur, v_nomcur, v_horas;
            
            while fin_c = 0 do
                -- Segundo nivel con espacios de tabulación
                set resultado = concat(resultado, '    ', v_codcur, ' - ', v_nomcur, ' (', v_horas, ' horas)\n');
                fetch cur_c into v_codcur, v_nomcur, v_horas;
            end while;
            
            close cur_c;
        end;

        fetch cur_p into v_codp, v_nomp;
    end while;

    close cur_p;

    -- Mostrar todo el informe en una sola ventana
    select resultado as 'informe de profesores y cursos';
end$$

delimiter ;

call datosprofesores2();

-- 15.2.15 Ampliar el ejercicio anterior y nombrarlo como ‘datosProfesores3’ para que para que debajo de cada línea de cursillo, en un tercer nivel tabulado (con espacios), 
-- aparezca el nombre de los alumnos que lo cursan así como la calificación que han obtenido.
drop procedure if exists datosprofesores3;
delimiter $$
create procedure datosprofesores3()
begin
    declare v_codp varchar(2);
    declare v_nomp varchar(25);
    declare fin_p int default 0;
    -- variable para acumular todo el texto
    declare resultado longtext default '';

    declare cur_p cursor for select codp, nomp from profesores;
    declare continue handler for not found set fin_p = 1;

    open cur_p;
    fetch cur_p into v_codp, v_nomp;
    while fin_p = 0 do
        set resultado = concat(resultado, 'profesor: ', v_codp, ' - ', v_nomp, '\n');

        begin
            declare v_codcur varchar(2);
            declare v_nomcur varchar(25);
            declare fin_c int default 0;
            declare cur_c cursor for select codcur, nomcur from cursillos where codp = v_codp;
            declare continue handler for not found set fin_c = 1;

            open cur_c;
            fetch cur_c into v_codcur, v_nomcur;
            while fin_c = 0 do
                set resultado = concat(resultado, '    cursillo: ', v_nomcur, '\n');

                begin
                    declare v_nomal varchar(25);
                    declare v_nota decimal(3,1);
                    declare fin_a int default 0;
                    declare cur_a cursor for 
                        select a.nomal, ac.nota 
                        from alumnos a join alumnoscursillos ac on a.codal = ac.codal
                        where ac.codcur = v_codcur;
                    declare continue handler for not found set fin_a = 1;

                    open cur_a;
                    fetch cur_a into v_nomal, v_nota;
                    while fin_a = 0 do
                        set resultado = concat(resultado, '        alumno: ', v_nomal, ' - nota: ', v_nota, '\n');
                        fetch cur_a into v_nomal, v_nota;
                    end while;
                    close cur_a;
                end;

                fetch cur_c into v_codcur, v_nomcur;
            end while;
            close cur_c;
        end;
        fetch cur_p into v_codp, v_nomp;
    end while;
    close cur_p;

    -- un solo select al final con todo el contenido
    select resultado as 'informe de profesores';
end$$
delimiter ;

call datosprofesores3();


-- --------------------------------------------------------------
-- 15.3 Triggers
-- --------------------------------------------------------------

-- 15.3.1 Crea un trigger llamado “tr_artista_insert” que si se intenta dar de alta un nuevo artista y se envía un nif_jefe que no exista, se cambie su valor por null.

drop trigger if exists tr_artista_insert;
delimiter $$
create trigger tr_artista_insert before insert on artistas for each row
begin
	if new.nif_jefe is not null then
		if not exists (select 1 from artistas where nif = new.nif_jefe) then
			set new.nif_jefe = null;
		end if;
	end if;
end$$
delimiter ;


-- 15.3.2 Crea unos triggers llamados “tr_ganacias_atracciones_insert”, “tr_ganacias_atracciones_update” y “tr_ganacias_atracciones_delete” que comprueben que se cumplen las siguientes restricciones:
--     El campo ganancias de la tabla ATRACCIONES se actualice cuando se añadan, borren o modifiquen datos en la tabla ATRACCION_DIA.
--     Si al añadir una celebración nueva (ATRACCION_DIA) la fecha_inicio en ATRACCIONES es NULL, haremos que se inserte con la fecha actual.
--     Nota: Debéis de tener en cuenta que tanto la fecha como las ganancias en ATRACCIONES pueden tener valores nulos. Dad un valor a esas columnas cuando sean null 
--     (recordar que si operamos matemáticamente o concatenamos una columna con valor null siempre devolverá null).

drop trigger if exists tr_ganacias_atracciones_insert;
delimiter $$
create trigger tr_ganacias_atracciones_insert before insert on atraccion_dia for each row
begin
	if new.fecha_inicio = null then
		set new.fecha_inicio = current_date();
    end if;
end$$
delimiter ;

drop trigger if exists tr_ganacias_atracciones_update;
delimiter $$
create trigger tr_ganacias_atracciones_update before update on atraccion_dia for each row
begin
	
end$$
delimiter ;

drop trigger if exists tr_ganacias_atracciones_delete;
delimiter $$
create trigger tr_ganacias_atracciones_delete before delete on atraccion_dia for each row
begin
	
end$$
delimiter ;
select * from atraccion_dia;