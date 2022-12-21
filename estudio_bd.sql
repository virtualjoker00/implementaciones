-- repaso bases de datos

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

