-- repaso bases de datos

-- POSTGRESQL EJEMPLO (porque no tiene auto increment)

CREATE TABLE usuarios (
    id serial PRIMARY KEY,
    nombre varchar(255),
    email varchar(255),
    password varchar(255),
    fecha_nacimiento date,
    fecha_creacion date,
    fecha_modificacion date
);

-- tabla con todos los tipos de datos en postgresql

CREATE TABLE tipos_datos (
    id serial PRIMARY KEY,
    nombre varchar(255),
    email varchar(255),
    password varchar(255),
    fecha_nacimiento date,
    fecha_creacion date,
    fecha_modificacion date,
    numero_entero int,
    numero_entero_grande bigint,
    numero_decimal decimal,
    numero_decimal_grande numeric,
    numero_decimal_grande2 decimal(10,2)
);
   




-- 1. Crear una tabla llamada "usuarios" con los siguientes campos:
-- id (entero, autoincremental, clave primaria)
-- nombre (cadena de texto)
-- email (cadena de texto)
-- password (cadena de texto)
-- fecha_nacimiento (fecha)
-- fecha_creacion (fecha)
-- fecha_modificacion (fecha)

CREATE TABLE usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255),
    email VARCHAR(255),
    password VARCHAR(255),
    fecha_nacimiento DATE,
    fecha_creacion DATE,
    fecha_modificacion DATE
);

-- 2. Crear una tabla llamada "posts" con los siguientes campos:
-- id (entero, autoincremental, clave primaria)
-- titulo (cadena de texto)
-- contenido (cadena de texto)
-- fecha_creacion (fecha)
-- fecha_modificacion (fecha)
-- usuario_id (entero, clave foránea)

CREATE TABLE posts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(255),
    contenido VARCHAR(255),
    fecha_creacion DATE,
    fecha_modificacion DATE,
    usuario_id INT,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
);

-- 3. Crear una tabla llamada "comentarios" con los siguientes campos:
-- id (entero, autoincremental, clave primaria)
-- contenido (cadena de texto)
-- fecha_creacion (fecha)
-- fecha_modificacion (fecha)
-- usuario_id (entero, clave foránea)
-- post_id (entero, clave foránea)

CREATE TABLE comentarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    contenido VARCHAR(255),
    fecha_creacion DATE,
    fecha_modificacion DATE,
    usuario_id INT,
    post_id INT,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id),
    FOREIGN KEY (post_id) REFERENCES posts(id)
);

-- 4. Crear una tabla llamada "categorias" con los siguientes campos:
-- id (entero, autoincremental, clave primaria)
-- nombre (cadena de texto)
-- fecha_creacion (fecha)
-- fecha_modificacion (fecha)

CREATE TABLE categorias (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255),
    fecha_creacion DATE,
    fecha_modificacion DATE
);

-- 5. Crear una tabla llamada "post_categoria" con los siguientes campos:
-- id (entero, autoincremental, clave primaria)
-- post_id (entero, clave foránea)
-- categoria_id (entero, clave foránea)

CREATE TABLE post_categoria (
    id INT AUTO_INCREMENT PRIMARY KEY,
    post_id INT,
    categoria_id INT,
    FOREIGN KEY (post_id) REFERENCES posts(id),
    FOREIGN KEY (categoria_id) REFERENCES categorias(id)
);

-- 6. Crear una tabla llamada "etiquetas" con los siguientes campos:
-- id (entero, autoincremental, clave primaria)
-- nombre (cadena de texto)
-- fecha_creacion (fecha)
-- fecha_modificacion (fecha)

CREATE TABLE etiquetas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255),
    fecha_creacion DATE,
    fecha_modificacion DATE
);

-- 7. Crear una tabla llamada "post_etiqueta" con los siguientes campos:
-- id (entero, autoincremental, clave primaria)
-- post_id (entero, clave foránea)
-- etiqueta_id (entero, clave foránea)

CREATE TABLE post_etiqueta (
    id INT AUTO_INCREMENT PRIMARY KEY,
    post_id INT,
    etiqueta_id INT,
    FOREIGN KEY (post_id) REFERENCES posts(id),
    FOREIGN KEY (etiqueta_id) REFERENCES etiquetas(id)
);

-- 8. Crear una tabla llamada "usuarios_etiquetas" con los siguientes campos:
-- id (entero, autoincremental, clave primaria)
-- usuario_id (entero, clave foránea)
-- etiqueta_id (entero, clave foránea)

CREATE TABLE usuarios_etiquetas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT,
    etiqueta_id INT,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id),
    FOREIGN KEY (etiqueta_id) REFERENCES etiquetas(id)
);

-- 9. Crear una tabla llamada "usuarios_categorias" con los siguientes campos:
-- id (entero, autoincremental, clave primaria)
-- usuario_id (entero, clave foránea)
-- categoria_id (entero, clave foránea)

CREATE TABLE usuarios_categorias (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT,
    categoria_id INT,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id),
    FOREIGN KEY (categoria_id) REFERENCES categorias(id)
);

-- 10. Crear una tabla llamada "usuarios_posts" con los siguientes campos:
-- id (entero, autoincremental, clave primaria)
-- usuario_id (entero, clave foránea)
-- post_id (entero, clave foránea)

CREATE TABLE usuarios_posts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT,
    post_id INT,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id),
    FOREIGN KEY (post_id) REFERENCES posts(id)
);

-- 11. Crear una tabla llamada "usuarios_comentarios" con los siguientes campos:
-- id (entero, autoincremental, clave primaria)
-- usuario_id (entero, clave foránea)
-- comentario_id (entero, clave foránea)

CREATE TABLE usuarios_comentarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT,
    comentario_id INT,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id),
    FOREIGN KEY (comentario_id) REFERENCES comentarios(id)
);

-- 12. Crear una tabla llamada "usuarios_usuarios" con los siguientes campos:
-- id (entero, autoincremental, clave primaria)
-- usuario_id (entero, clave foránea)
-- usuario_id (entero, clave foránea)
-- NOTA: Esta tabla se utiliza para guardar los usuarios que siguen a otros usuarios

CREATE TABLE usuarios_usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT,
    usuario_id INT,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id),
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
);

-- 13. Crear una tabla llamada "usuarios_roles" con los siguientes campos:
-- id (entero, autoincremental, clave primaria)
-- usuario_id (entero, clave foránea)
-- rol_id (entero, clave foránea)

CREATE TABLE usuarios_roles (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT,
    rol_id INT,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id),
    FOREIGN KEY (rol_id) REFERENCES roles(id)
);

-- 14. Crear una tabla llamada "roles_permisos" con los siguientes campos:
-- id (entero, autoincremental, clave primaria)
-- rol_id (entero, clave foránea)
-- permiso_id (entero, clave foránea)

CREATE TABLE roles_permisos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    rol_id INT,
    permiso_id INT,
    FOREIGN KEY (rol_id) REFERENCES roles(id),
    FOREIGN KEY (permiso_id) REFERENCES permisos(id)
);

-- 15. Crear una tabla llamada "usuarios_permisos" con los siguientes campos:
-- id (entero, autoincremental, clave primaria)
-- usuario_id (entero, clave foránea)
-- permiso_id (entero, clave foránea)

CREATE TABLE usuarios_permisos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT,
    permiso_id INT,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id),
    FOREIGN KEY (permiso_id) REFERENCES permisos(id)
);

-- 16. Crear una tabla llamada "usuarios_mensajes" con los siguientes campos:
-- id (entero, autoincremental, clave primaria)
-- usuario_id (entero, clave foránea)
-- mensaje_id (entero, clave foránea)

CREATE TABLE usuarios_mensajes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT,
    mensaje_id INT,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id),
    FOREIGN KEY (mensaje_id) REFERENCES mensajes(id)
);

-- CONSULTAS
-- 1. Obtener todos los usuarios

SELECT * FROM usuarios;

-- 2. Obtener todos los usuarios que sean administradores

SELECT * FROM usuarios WHERE rol_id = 1;

-- 3. Obtener todos los usuarios que no sean administradores

SELECT * FROM usuarios WHERE rol_id != 1;

-- 4. Obtener todos los usuarios que sean administradores o moderadores

SELECT * FROM usuarios WHERE rol_id = 1 OR rol_id = 2;

-- 5. Obtener todos los usuarios que sean administradores y moderadores

SELECT * FROM usuarios WHERE rol_id = 1 AND rol_id = 2;

-- 6. Obtener todos los usuarios que sean administradores o moderadores y que su nombre empiece con "a"

SELECT * FROM usuarios WHERE (rol_id = 1 OR rol_id = 2) AND nombre LIKE "a%";

-- 7. Obtener todos los usuarios que sean administradores o moderadores y que su nombre empiece con "a" o "A"

SELECT * FROM usuarios WHERE (rol_id = 1 OR rol_id = 2) AND (nombre LIKE "a%" OR nombre LIKE "A%");

-- 8. Obtener todos los usuarios que sean administradores o moderadores y que su nombre empiece con "a" o "A" y que su apellido termine con "z" o "Z"

SELECT * FROM usuarios WHERE (rol_id = 1 OR rol_id = 2) AND (nombre LIKE "a%" OR nombre LIKE "A%") AND (apellido LIKE "%z" OR apellido LIKE "%Z");

-- 9. Obtener todos los usuarios que sean administradores o moderadores y que su nombre empiece con "a" o "A" y que su apellido termine con "z" o "Z" y que su email contenga "gmail"

SELECT * FROM usuarios WHERE (rol_id = 1 OR rol_id = 2) AND (nombre LIKE "a%" OR nombre LIKE "A%") AND (apellido LIKE "%z" OR apellido LIKE "%Z") AND email LIKE "%gmail%";

-- 10. Obtener todos los usuarios que sean administradores o moderadores y que su nombre empiece con "a" o "A" y que su apellido termine con "z" o "Z" y que su email contenga "gmail" y que su fecha de nacimiento sea mayor a 1990-01-01

SELECT * FROM usuarios WHERE (rol_id = 1 OR rol_id = 2) AND (nombre LIKE "a%" OR nombre LIKE "A%") AND (apellido LIKE "%z" OR apellido LIKE "%Z") AND email LIKE "%gmail%" AND fecha_nacimiento > "1990-01-01";

-- 11. Contar todos los usuarios que sean administradores o moderadores y que su nombre empiece con "a" o "A" y que su apellido termine con "z" o "Z" y que su email contenga "gmail" y que su fecha de nacimiento sea mayor a 1990-01-01

SELECT COUNT(*) FROM usuarios WHERE (rol_id = 1 OR rol_id = 2) AND (nombre LIKE "a%" OR nombre LIKE "A%") AND (apellido LIKE "%z" OR apellido LIKE "%Z") AND email LIKE "%gmail%" AND fecha_nacimiento > "1990-01-01";

-- 12. Obtener el usuario con mayor cantidad de mensajes

SELECT usuarios.id, usuarios.nombre, usuarios.apellido, COUNT(usuarios_mensajes.id) AS cantidad_mensajes FROM usuarios LEFT JOIN usuarios_mensajes ON usuarios.id = usuarios_mensajes.usuario_id GROUP BY usuarios.id ORDER BY cantidad_mensajes DESC LIMIT 1;

-- 13. Obtener el usuario con mayor cantidad de mensajes que no sean borradores

SELECT usuarios.id, usuarios.nombre, usuarios.apellido, COUNT(usuarios_mensajes.id) AS cantidad_mensajes FROM usuarios LEFT JOIN usuarios_mensajes ON usuarios.id = usuarios_mensajes.usuario_id WHERE usuarios_mensajes.id IS NOT NULL GROUP BY usuarios.id ORDER BY cantidad_mensajes DESC LIMIT 1;

-- 14. Obtener los ultimos 10 mensajes ordenados por fecha de creación descendente (del más nuevo al más viejo) del usuario con id 1

SELECT * FROM mensajes WHERE usuario_id = 1 ORDER BY fecha_creacion DESC LIMIT 10;

-- 15. Obtener las 10 primeras publicaciones ordenadas por fecha de creación ascendente (del más viejo al más nuevo)

SELECT * FROM mensajes ORDER BY fecha_creacion ASC LIMIT 10;

-- 16. Obtener los 5 usuarios con mas cantidad de publicaciones del año 2019

SELECT usuarios.id, usuarios.nombre, usuarios.apellido, COUNT(usuarios_mensajes.id) AS cantidad_mensajes FROM usuarios LEFT JOIN usuarios_mensajes ON usuarios.id = usuarios_mensajes.usuario_id WHERE usuarios_mensajes.id IS NOT NULL AND YEAR(mensajes.fecha_creacion) = 2019 GROUP BY usuarios.id ORDER BY cantidad_mensajes DESC LIMIT 5;

------------------------------------------------------------------------------------------------------
-- Show patient_id, attending_doctor_id, and diagnosis for admissions that match one of the two criteria:
-- 1. patient_id is an odd number and attending_doctor_id is either 1, 5, or 19.
-- 2. attending_doctor_id contains a 2 and the length of patient_id is 3 characters

SELECT patient_id, attending_doctor_id, diagnosis 
FROM admissions 
WHERE (patient_id % 2 = 1 AND attending_doctor_id IN (1, 5, 19)) OR (attending_doctor_id LIKE "%2%" AND LENGTH(patient_id) = 3);

-- Display the total amount of patients for each province. Order by descending

SELECT province_name, COUNT(*) AS total_count FROM patients GROUP BY province_name ORDER BY total_count DESC;

-- Show the difference between the largest weight and smallest weight for patients with the last name 'Maroni'

SELECT MAX(weight) - MIN(weight) AS weight_difference FROM patients WHERE last_name = "Maroni";

-- Each admission costs $50 for patients without insurance, and $10 for patients with insurance. All patients with an even 
-- patient_id have insurance.
-- Give each patient a 'Yes' if they have insurance, and a 'No' if they don't have insurance. Add up the admission_total cost 
-- for each has_insurance group

SELECT CASE WHEN patient_id % 2 = 0 THEN "Yes" ELSE "No" END AS has_insurance, 
SUM(CASE WHEN patient_id % 2 = 0 THEN 10 ELSE 50 END) AS admission_total 
FROM admissions GROUP BY has_insurance;

-- Show the average weight for each province. Order by descending

SELECT province_name, AVG(weight) AS average_weight FROM patients GROUP BY province_name ORDER BY average_weight DESC;

------------------------------------------------------------------------------------------------------

-- Campeonato mundial de futbol, incluye paises, jugadores, partidos, goles, ediciones, ganadores, etc.

-- Tablas de la base de datos

CREATE TABLE paises (
    id INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE jugadores (
    id INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    pais_id INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (pais_id) REFERENCES paises(id)
);

CREATE TABLE partidos (
    id INT NOT NULL AUTO_INCREMENT,
    pais1_id INT NOT NULL,
    pais2_id INT NOT NULL,
    minutos INT NOT NULL,
    fecha DATE NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (pais1_id) REFERENCES paises(id),
    FOREIGN KEY (pais2_id) REFERENCES paises(id)
);

CREATE TABLE goles (
    id INT NOT NULL AUTO_INCREMENT,
    partido_id INT NOT NULL,
    jugador_id INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (partido_id) REFERENCES partidos(id),
    FOREIGN KEY (jugador_id) REFERENCES jugadores(id)
);

CREATE TABLE ediciones (
    id INT NOT NULL AUTO_INCREMENT,
    anio INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (pais_id) REFERENCES paises(id)
);

CREATE TABLE partidos_ediciones (
    id INT NOT NULL AUTO_INCREMENT,
    partido_id INT NOT NULL,
    edicion_id INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (partido_id) REFERENCES partidos(id),
    FOREIGN KEY (edicion_id) REFERENCES ediciones(id)
);

CREATE TABLE ganadores (
    id INT NOT NULL AUTO_INCREMENT,
    edicion_id INT NOT NULL,
    pais_id INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (edicion_id) REFERENCES ediciones(id),
    FOREIGN KEY (pais_id) REFERENCES paises(id)
);

-- 1. Obtener el nombre de los jugadores que hayan marcado al menos 3 goles

SELECT jugadores.nombre, jugadores.apellido, COUNT(goles.id) AS cantidad_goles 
FROM jugadores 
INNER JOIN goles ON jugadores.id = goles.jugador_id
GROUP BY jugadores.id
HAVING COUNT(goles.id) >= 3;

-- 2. Obtener el nombre de los jugadores que hayan marcado al menos 3 goles en la edición 2018

SELECT jugadores.nombre, jugadores.apellido, COUNT(goles.id) AS cantidad_goles
FROM jugadores
INNER JOIN goles ON jugadores.id = goles.jugador_id
INNER JOIN partidos_ediciones ON goles.partido_id = partidos_ediciones.partido_id
INNER JOIN ediciones ON partidos_ediciones.edicion_id = ediciones.id
WHERE ediciones.anio = 2018

-- 3. Obtener el nombre de los jugadores que hayan marcado al menos 3 goles en la edición 2018 y que su apellido sea 'Messi'

SELECT jugadores.nombre, jugadores.apellido, COUNT(goles.id) AS cantidad_goles
FROM jugadores
INNER JOIN goles ON jugadores.id = goles.jugador_id
INNER JOIN partidos_ediciones ON goles.partido_id = partidos_ediciones.partido_id
INNER JOIN ediciones ON partidos_ediciones.edicion_id = ediciones.id
WHERE ediciones.anio = 2018 AND jugadores.apellido = 'Messi'

-- 4. Obtener el nombre de los jugadores que hayan marcado al menos 3 goles en la edición 2018 y que su apellido sea 'Messi' o 'Ronaldo'

SELECT jugadores.nombre, jugadores.apellido, COUNT(goles.id) AS cantidad_goles
FROM jugadores
INNER JOIN goles ON jugadores.id = goles.jugador_id
INNER JOIN partidos_ediciones ON goles.partido_id = partidos_ediciones.partido_id
INNER JOIN ediciones ON partidos_ediciones.edicion_id = ediciones.id
WHERE ediciones.anio = 2018 AND jugadores.apellido IN ('Messi', 'Ronaldo')

-- 5. Obtener el nombre de los jugadores que hayan marcado al menos 3 goles en la edición 2018 y que su apellido sea 'Messi' o 'Ronaldo' y que su nombre sea 'Lionel' o 'Cristiano'

SELECT jugadores.nombre, jugadores.apellido, COUNT(goles.id) AS cantidad_goles
FROM jugadores
INNER JOIN goles ON jugadores.id = goles.jugador_id
INNER JOIN partidos_ediciones ON goles.partido_id = partidos_ediciones.partido_id
INNER JOIN ediciones ON partidos_ediciones.edicion_id = ediciones.id
WHERE ediciones.anio = 2018 AND jugadores.apellido IN ('Messi', 'Ronaldo') AND jugadores.nombre IN ('Lionel', 'Cristiano')

-- 6. Obtener el nombre de los paises que hayan ganado al menos 3 ediciones

SELECT paises.nombre, COUNT(ganadores.id) AS cantidad_ganadores
FROM paises
INNER JOIN ganadores ON paises.id = ganadores.pais_id
GROUP BY paises.id
HAVING COUNT(ganadores.id) >= 3

-- 8. Obtener el pais que haya hecho la menor cantidad de goles en la edición 2018

SELECT paises.nombre, COUNT(goles.id) AS cantidad_goles
FROM paises
INNER JOIN jugadores ON paises.id = jugadores.pais_id
INNER JOIN goles ON jugadores.id = goles.jugador_id
INNER JOIN partidos_ediciones ON goles.partido_id = partidos_ediciones.partido_id
INNER JOIN ediciones ON partidos_ediciones.edicion_id = ediciones.id
WHERE ediciones.anio = 2018
GROUP BY paises.id
ORDER BY cantidad_goles ASC
LIMIT 1

-- 9. El jugador que haya estado mas tiempo en los partidos de la edición 2018

SELECT jugadores.nombre, jugadores.apellido, SUM(partidos.minutos) AS minutos_jugados
FROM jugadores
INNER JOIN partidos_jugadores ON jugadores.id = partidos_jugadores.jugador_id
INNER JOIN partidos ON partidos_jugadores.partido_id = partidos.id
INNER JOIN partidos_ediciones ON partidos.id = partidos_ediciones.partido_id
INNER JOIN ediciones ON partidos_ediciones.edicion_id = ediciones.id
WHERE ediciones.anio = 2018

-- 10. La edicion que haya tenido mas goles en total y la cantidad de goles 

SELECT ediciones.anio, COUNT(goles.id) AS cantidad_goles
FROM ediciones
INNER JOIN partidos_ediciones ON ediciones.id = partidos_ediciones.edicion_id
INNER JOIN partidos ON partidos_ediciones.partido_id = partidos.id
INNER JOIN goles ON partidos.id = goles.partido_id
GROUP BY ediciones.id
ORDER BY cantidad_goles DESC
LIMIT 1

-- 11. La edicion que haya tenido mas goles en total, la cantidad de goles y el pais que la haya ganado

SELECT ediciones.anio, COUNT(goles.id) AS cantidad_goles, paises.nombre AS pais_ganador
FROM ediciones
INNER JOIN partidos_ediciones ON ediciones.id = partidos_ediciones.edicion_id
INNER JOIN partidos ON partidos_ediciones.partido_id = partidos.id
INNER JOIN goles ON partidos.id = goles.partido_id
INNER JOIN ganadores ON ediciones.id = ganadores.edicion_id
INNER JOIN paises ON ganadores.pais_id = paises.id
GROUP BY ediciones.id
ORDER BY cantidad_goles DESC
LIMIT 1

-- 12. La edicion que haya tenido mas goles en total, la cantidad de goles y el pais que la haya ganado y el jugador que haya marcado mas goles

SELECT ediciones.anio, COUNT(goles.id) AS cantidad_goles, paises.nombre AS pais_ganador, jugadores.nombre, jugadores.apellido
FROM ediciones
INNER JOIN partidos_ediciones ON ediciones.id = partidos_ediciones.edicion_id
INNER JOIN partidos ON partidos_ediciones.partido_id = partidos.id
INNER JOIN goles ON partidos.id = goles.partido_id
INNER JOIN ganadores ON ediciones.id = ganadores.edicion_id
INNER JOIN paises ON ganadores.pais_id = paises.id
INNER JOIN jugadores ON goles.jugador_id = jugadores.id
GROUP BY ediciones.id
ORDER BY cantidad_goles DESC
LIMIT 1

-- 13. de las personas que participaron en la edicion 2022, que jugador ha participado en mas ediciones y cuantas,  
-- mostrar su nombre y apellido y el pais de cada edicion en la que participo

SELECT jugadores.nombre, jugadores.apellido, COUNT(ediciones.id) AS cantidad_ediciones, paises.nombre AS pais
FROM jugadores
INNER JOIN partidos_jugadores ON jugadores.id = partidos_jugadores.jugador_id
INNER JOIN partidos ON partidos_jugadores.partido_id = partidos.id
INNER JOIN partidos_ediciones ON partidos.id = partidos_ediciones.partido_id
INNER JOIN ediciones ON partidos_ediciones.edicion_id = ediciones.id
INNER JOIN paises ON jugadores.pais_id = paises.id
WHERE ediciones.anio = 2022
GROUP BY jugadores.id
ORDER BY cantidad_ediciones DESC
LIMIT 1

-- 14. el año del partido que haya tenido mas goles y la cantidad de goles que tuvo

SELECT ediciones.anio, COUNT(goles.id) AS cantidad_goles
FROM ediciones
INNER JOIN partidos_ediciones ON ediciones.id = partidos_ediciones.edicion_id
INNER JOIN partidos ON partidos_ediciones.partido_id = partidos.id
INNER JOIN goles ON partidos.id = goles.partido_id
GROUP BY ediciones.id
ORDER BY cantidad_goles DESC
LIMIT 1

