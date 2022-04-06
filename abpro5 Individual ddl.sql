#Parte 1: Crear entorno de trabajo 
#Crear una base de datos 
#Crear un usuario con todos los privilegios para trabajar con la base de datos recién creada. 
#Parte 2: Crear tres tablas. 
#La primera almacena a los usuarios de la aplicación
# (id_usuario, nombre, apellido, contraseña, zona horaria # (por defecto UTC-3), género y teléfono de contacto). 
#La segunda tabla almacena información relacionada a la fecha-hora de ingreso
# de los usuarios a la #plataforma (id_ingreso, id_usuario y la fecha-hora de 
# (por defecto la fecha-hora actual)). 
#La tercera tabla almacena información sobre la cantidad de veces que los usuarios han visitado la aplicación.
#Piense en una estructura de columnas que permita entregar esta información y cree la tabla. 
#Parte 3: Creación de registros. 
#Para cada tabla cree 8 registros. 
#Parte 4: Elimine una de las tablas creadas. 
#Justifique cada tipo de dato utilizado en la creación de las tablas. 

CREATE USER 'admin_pod1' IDENTIFIED BY 'POD';
GRANT INSERT, UPDATE , DELETE, SELECT, CREATE ON ingresos_usuarios.* TO 'admin_pod1'
WITH GRANT OPTION;
FLUSH PRIVILEGES;

CREATE DATABASE ingresos_usuarios;
USE ingresos_usuarios;

SET TIME_ZONE='-03:00';
 
CREATE TABLE usuarios (
    id_usuario INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(20) NOT NULL,
    apellido VARCHAR(20) NOT NULL,
    contraseña VARCHAR(6) NOT NULL,
    zona_horaria VARCHAR(50) NOT NULL,
    genero VARCHAR(1) NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    PRIMARY KEY (id_usuario)
);

CREATE TABLE ingreso_plataforma (
    id_regIngreso INT NOT NULL AUTO_INCREMENT,
    id_usuario INT NOT NULL,
    fec_horaIngreso DATETIME NOT NULL,
    PRIMARY KEY (id_regIngreso),
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);

INSERT INTO usuarios (nombre, apellido, contraseña, zona_horaria, genero, telefono) VALUES
('Joe', 'Arellano', 'abcd', @@SESSION.time_zone, 'M', '225588'),
('Ian', 'Salas', 'abcd', @@SESSION.time_zone, 'M', '225588'),
('Piero', 'Leiva', 'abcd', @@SESSION.time_zone, 'M', '225588'),
('Jim', 'Lizama','abcd', @@SESSION.time_zone, 'M', '225588'),
('Ana', 'Prieto', 'abcd', @@SESSION.time_zone, 'F', '225588'),
('Eli', 'Astudillo', 'abcd', @@SESSION.time_zone, 'F', '225588'),
('Teo', 'Toro', 'abcd', @@SESSION.time_zone, 'M', '225588'),
('Fey', 'Briones', 'abcd', @@SESSION.time_zone, 'F', '225588');

INSERT INTO ingreso_plataforma(id_usuario, fec_horaIngreso) VALUES
(2,NOW()),
(3,NOW()),
(4,NOW()),
(5,NOW()),
(6,NOW()),
(7,NOW()),
(8,NOW());

#create table cantidadIngresos
#select id_usuario as Usuario, count(*) as cantidad
#from ingreso_plataforma
#group by id_usuario;

create table cantidadIngresos
  select id_usuario as Usuario, count(*) as cantidad
  from ingreso_plataforma
  group by id_usuario;
  
DROP TABLE cantidadIngresos;

