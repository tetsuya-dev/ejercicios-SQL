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