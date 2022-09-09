create database GestorAlmacenesTemp;
/*drop database GestorAlmacenesTemp;*/
use GestorAlmacenesTemp;

create table producto(
id_producto char(10) primary key,
codbar_producto varchar(12) not null unique,
descripcion_producto varchar(90) not null,
marca_producto varchar(30) not null,
tipo_producto varchar(30) not null,
isActive boolean not null
);

create table sucursal(
id_sucursal char(3) primary key,
sector_sucursal varchar(30) not null, /*Sur, Centro, Norte*/
isActive boolean not null
);

create table almacen(
id_almacen char(10) primary key,
nombre_almacen varchar(90) not null,
/*desc_almacen varchar(90) not null,*/
direccion_almacen varchar(120) not null,
id_sucursal varchar(10) not null,
isActive boolean not null,
foreign key (id_sucursal) references sucursal(id_sucursal)
);

create table empleado(
id_empleado char(6) primary key,
nombre_empleado varchar(90) not null,
apellido_empleado varchar(90) not null,
correo_empleado varchar(90) not null,
telefono_empleado varchar(90) not null,
id_almacen char(10) not null,
isActive boolean not null,
foreign key (id_almacen) references almacen(id_almacen)
);



create table cargo(
id_cargo char(3) primary key,
nombre_cargo varchar(30) not null,
isActive boolean not null
);

create table usuario(
id_usuario int auto_increment primary key, 
alias_usuario varchar(30) not null unique,
contrasena_usuario varchar(50) not null,
id_empleado char(6) not null,
id_cargo char(3) not null,
foreign key (id_empleado) references empleado(id_empleado),
foreign key (id_cargo) references cargo(id_cargo)  
);


create table acceso(
id_acceso char(5) primary key,
nombre_acceso varchar(60) not null,
isActive boolean not null
);

create table acceso_cargo(
id_acceso char(5),
id_cargo char(3),
isActive boolean not null,
primary key (id_acceso,id_cargo),
foreign key (id_acceso) references acceso(id_acceso),
foreign key (id_cargo) references cargo(id_cargo)
);



create table inventario(
id_inventario char(10) primary key,
precioprod_inventario decimal(10,1) not null,
cantidadprod_inventario int not null,
id_producto char(10) not null,
id_almacen char(10) not null,
isActive boolean not null,
foreign key (id_producto) references producto(id_producto),
foreign key (id_almacen) references almacen(id_almacen)
);


create table solicitud(
id_solicitud char(10) primary key,
estado_solicitud varchar(30) not null check(estado_solicitud="Pendiente" and "Rechazado" and "Aceptado"),
cantidadprod_solicitud int not null,
precioprod_solicitud decimal(10,1) not null,
id_inventario char(10) not null,
isActive boolean not null,
foreign key (id_inventario) references inventario(id_inventario)
);


create table operacion(
id_operacion char(10) not null,
nombre_operacion varchar(30) not null check(nombre_operacion="Ingreso" and nombre_operacion="Salida"),
cantidadprod_operacion int not null,
precioprod_operacion decimal(10,1) not null,
id_solicitud char(10) not null,
isActive boolean not null,
foreign key (id_solicitud) references solicitud(id_solicitud)
);








