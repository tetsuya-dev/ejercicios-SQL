drop database if exists ejercicios;
create database ejercicios;
use ejercicios;

create table empleados(
	DNI varchar(9),
	nombre varchar(30) not null,
	apellidos varchar(60) not null,
	email varchar(60),
	telefono int not null,
	sueldos decimal(10,2) not null,
	puesto varchar(30) not null
);

create table libros(
	ISBN int,
	titulo varchar(60) not null,
	tipo varchar(30) not null,
	autor varchar(90),
	precio decimal(8,2) not null
);

create table facturas(
	CODIGO int,
	destinatario varchar(90) not null,
	cuenta int not null,
	importe decimal(10,2) not null,
	fecha_hora datetime not null unique
);

create table facturas2(
	codigo int,
    destinatario varchar(20),
    cuenta bigint,
    importe decimal(5,4),
    fecha datetime,
    pagado boolean
);

create table facturas3(
	codigo int primary key,
    destinatario varchar(20),
    cuenta bigint,
    importe decimal(5,4),
    fecha datetime,
    pagado boolean
);

create table personas(
	DNI varchar(9) primary key,
    NSS varchar(9) unique,
    nombre varchar(20) not null,
    apellido1 varchar(20) not null,
    CP int,
    fecha_nacimiento date,
    soltero boolean,
    dia varchar(8)
);

----------------------------------------------------------------
-- 3.5 Modificación de tablas
----------------------------------------------------------------

-- 3.5.1 Cambia el nombre del atributo “importe” del ej. 3.2.1 por “importe_total”
alter table facturas change column importe importe_total decimal(5,4);

-- 3.5.2 Cambia el nombre de la tabla FACTURAS por FACTUR
alter table facturas rename to factur;

-- 3.5.3 Cambia el nombre del atributo “cuenta” del ej. 3.2.2 por “cuenta_destinatario”
alter table factur change column cuenta cuenta_destinatario int not null;

-- 3.5.4 Añade una columna a la tabla libros llamada editorial que sea un varchar(30)
alter table libros add column editorial varchar(30);

-- 3.5.5 Elimina la columna email de la tabla EMPLEADOS
alter table empleados drop column email;

-- 3.5.6 Añade a libros una clave primaria la cual tiene que ser ISBN
alter table libros add primary key (ISBN);

-- 3.5.7 Añade a empleados una clave primaria que sea la unión de DNI y nombre
alter table empleados add primary key (DNI, nombre);

-- 3.5.8 Borra la clave primaria antes creada y crea como clave primaria solo DNI y como clave candidata nombre
alter table empleados drop primary key;
alter table empleados add primary key (DNI);
alter table empleados add unique (nombre);

-- 3.5.9 Muestra todas las tablas que tienes en la BD de ejercicio
show tables from ejercicios;

-- 3.5.10 Describe cada uno de los campos de los que está formada la tabla EMPLEADOS
select * from empleados;
select DNI as Identificador, nombre as Nom, apellidos from empleados;














