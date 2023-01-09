/*
Países: almacena información sobre los países participantes en el mundial.
Jugadores: almacena información sobre los jugadores que participan en el mundial.
Entrenadores: almacena información sobre los entrenadores de los equipos participantes en el mundial.
Partidos: almacena información sobre los partidos disputados en el mundial.
Goles: almacena información sobre los goles marcados en cada partido.
Sanciones: almacena información sobre las sanciones impuestas a los jugadores durante el mundial.
Mundiales: almacena información sobre cada edición del mundial de fútbol, incluyendo el año en que se realizó y el país ganador.
Participantes: almacena información sobre los países que participaron en cada edición del mundial.
*/
CREATE TABLE Países (
  ID serial PRIMARY KEY,
  Nombre varchar(255) NOT NULL
);

CREATE TABLE Jugadores (
  ID serial PRIMARY KEY,
  Nombre varchar(255) NOT NULL,
  Apellido varchar(255) NOT NULL,
  Edad smallint NOT NULL,
  ID_País integer REFERENCES Países (ID)
);

CREATE TABLE Entrenadores (
  ID serial PRIMARY KEY,
  Nombre varchar(255) NOT NULL,
  Apellido varchar(255) NOT NULL,
  Edad smallint NOT NULL,
  ID_País integer REFERENCES Países (ID)
);

CREATE TABLE Partidos (
  ID serial PRIMARY KEY,
  ID_Equipo_Local integer REFERENCES Países (ID),
  ID_Equipo_Visitante integer REFERENCES Países (ID),
  Fecha date NOT NULL,
  Resultado varchar(5) NOT NULL
);

CREATE TABLE Goles (
  ID serial PRIMARY KEY,
  ID_Partido integer REFERENCES Partidos (ID),
  ID_Jugador integer REFERENCES Jugadores (ID),
  Tiempo smallint NOT NULL
);

CREATE TABLE Sanciones (
  ID serial PRIMARY KEY,
  ID_Partido integer REFERENCES Partidos (ID),
  ID_Jugador integer REFERENCES Jugadores (ID),
  Tipo varchar(255) NOT NULL,
  Tiempo smallint NOT NULL
);

CREATE TABLE Mundiales (
  ID serial PRIMARY KEY,
  Año smallint NOT NULL,
  Ganador integer REFERENCES Países (ID)
);

CREATE TABLE Participantes (
  ID serial PRIMARY KEY,
  ID_Mundial integer REFERENCES Mundiales (ID),
  ID_País integer REFERENCES Países (ID)
);

-- Obtener el nombre de todos los países participantes en el mundial del 2018:
SELECT p.Nombre
FROM Países p
JOIN Participantes pa ON pa.ID_País = p.ID
JOIN Mundiales m ON m.ID = pa.ID_Mundial
WHERE m.Año = 2018;

-- Obtener el nombre de todos los países que han ganado al menos un mundial:
SELECT p.Nombre
FROM Países p
JOIN Mundiales m ON m.Ganador = p.ID
GROUP BY p.Nombre
HAVING COUNT(m.ID) > 0;

--Obtener el nombre del país ganador y el año de todos los mundiales en los que participó el país Argentina:
SELECT p.Nombre, m.Año
FROM Países p
JOIN Mundiales m ON m.Ganador = p.ID
JOIN Participantes pa ON pa.ID_Mundial = m.ID
WHERE pa.ID_País = (SELECT ID FROM Países WHERE Nombre = 'Argentina');

--Obtener el nombre de los países que han participado en todas las ediciones del mundial:
SELECT p.Nombre
FROM Países p
JOIN Participantes pa ON pa.ID_País = p.ID
GROUP BY p.Nombre
HAVING COUNT(DISTINCT pa.ID_Mundial) = (SELECT COUNT(*) FROM Mundiales);

--Obtener el nombre de los países que han ganado al menos un mundial en los últimos 10 años:
SELECT p.Nombre
FROM Países p
JOIN Mundiales m ON m.Ganador = p.ID
WHERE m.Año >= (SELECT MAX(Año) FROM Mundiales) - 10
GROUP BY p.Nombre
HAVING COUNT(m.ID) > 0;

--Obtener el nombre de los países que han participado en al menos 2 mundiales consecutivos:
WITH Países_Mundiales AS (
  SELECT p.Nombre, m.Año, m.ID
  FROM Países p
  JOIN Participantes pa ON pa.ID_País = p.ID
  JOIN Mundiales m ON m.ID = pa.ID_Mundial
)
SELECT Nombre
FROM Países_Mundiales
GROUP BY Nombre, Año
HAVING COUNT(ID) > 1 AND MAX(ID) - MIN(ID) = COUNT(ID) - 1;

--Obtener el nombre de los países que han participado en todas las ediciones del mundial y además han ganado al menos una vez:
SELECT p.Nombre
FROM Países p
JOIN Participantes pa ON pa.ID_País = p.ID
JOIN Mundiales m ON m.ID = pa.ID_Mundial
GROUP BY p.Nombre
HAVING COUNT(DISTINCT pa.ID_Mundial) = (SELECT COUNT(*) FROM Mundiales) AND COUNT(DISTINCT m.Ganador) > 0;

--Obtener el nombre de los países que han participado en al menos 3 mundiales consecutivos, y además han ganado al menos una vez:
WITH Países_Mundiales AS (
  SELECT p.Nombre, m.Año, m.ID
  FROM Países p
  JOIN Participantes pa ON pa.ID_País = p.ID
  JOIN Mundiales m ON m.ID = pa.ID_Mundial
)
SELECT Nombre
FROM Países_Mundiales
GROUP BY Nombre, Año
HAVING COUNT(ID) > 2 AND MAX(ID) - MIN(ID) = COUNT(ID) - 1 AND COUNT(DISTINCT m.Ganador) > 0;


/*
Asientos: almacena información sobre los asientos disponibles en el estadio, incluyendo su ubicación y si están disponibles para la venta.
Sectores: almacena información sobre los distintos sectores del estadio, incluyendo su nombre y capacidad.
Boletos: almacena información sobre los boletos disponibles para cada partido, incluyendo su precio y si han sido vendidos o no.
Clientes: almacena información sobre los clientes que han comprado boletos.
Ventas: almacena información sobre las ventas realizadas, incluyendo la fecha de venta y la información del boleto y del cliente involucrados.
*/
CREATE TABLE Asientos (
  ID serial PRIMARY KEY,
  Fila char(1) NOT NULL,
  Columna smallint NOT NULL,
  ID_Sector integer NOT NULL,
  Disponible boolean NOT NULL
);

CREATE TABLE Sectores (
  ID serial PRIMARY KEY,
  Nombre varchar(255) NOT NULL,
  Capacidad smallint NOT NULL
);

CREATE TABLE Boletos (
  ID serial PRIMARY KEY,
  ID_Asiento integer REFERENCES Asientos (ID),
  ID_Partido integer REFERENCES Partidos (ID),
  Precio numeric(5,2) NOT NULL,
  Vendido boolean NOT NULL
);

CREATE TABLE Clientes (
  ID serial PRIMARY KEY,
  Nombre varchar(255) NOT NULL,
  Apellido varchar(255) NOT NULL,
  Correo varchar(255) NOT NULL,
  Teléfono varchar(255) NOT NULL
);

CREATE TABLE Ventas (
  ID serial PRIMARY KEY,
  ID_Boleto integer REFERENCES Boletos (ID),
  ID_Cliente integer REFERENCES Clientes (ID),
  Fecha_Venta date NOT NULL
);

