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
