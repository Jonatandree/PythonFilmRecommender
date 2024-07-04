-----------------borrar---------------------
drop table Calificación;
drop table Película;
drop table Usuario;
drop table País;
drop table Director;
drop table Género;

--------------------DDL--------------------------

CREATE TABLE Director (
    ID_director SERIAL PRIMARY KEY ,
    Nombre_director VARCHAR(255) NOT NULL
    
);

CREATE TABLE Género (
    ID_género SERIAL PRIMARY KEY,
    Nombre_género VARCHAR(50) NOT NULL
);

CREATE TABLE País (
    ID_pais SERIAL PRIMARY KEY ,
    Nombre_pais VARCHAR(255) NOT NULL
    
);

CREATE TABLE Usuario (
    ID_usuario SERIAL PRIMARY KEY ,
    Nombre VARCHAR(255) NOT NULL,
    Apellido VARCHAR(255) NOT NULL
);

CREATE TABLE Película (
    ID_película SERIAL PRIMARY KEY ,
    Título VARCHAR(255) NOT NULL,
    ID_género INT NOT NULL,
    ID_director INT NOT NULL,
    ID_pais INT NOT NULL,
    FOREIGN KEY (ID_género) REFERENCES Género(ID_género),
    FOREIGN KEY (ID_director) REFERENCES Director(ID_director),
    FOREIGN KEY (ID_pais) REFERENCES País(ID_pais)
);

CREATE TABLE Calificación (
    ID_usuario INT NOT NULL,
    ID_película INT NOT NULL,
    Calificación INT NOT NULL CHECK (Calificación >= 1 AND Calificación <= 5),
    PRIMARY KEY (ID_usuario, ID_película), -- Clave primaria compuesta
    FOREIGN KEY (ID_usuario) REFERENCES Usuario(ID_usuario),
    FOREIGN KEY (ID_película) REFERENCES Película(ID_película)
);

-------------------------------------------------
SELECT*fROM Calificación;
SELECT*fROM  Película;
SELECT*fROM  Usuario;
SELECT*fROM  País;
SELECT*fROM  Director;
SELECT*fROM  Género;




--------------------DML--------------------------
-- Inserciones para la tabla Director
INSERT INTO Director (Nombre_director) VALUES ('Steven Spielberg');
INSERT INTO Director (Nombre_director) VALUES ('Martin Scorsese');
INSERT INTO Director (Nombre_director) VALUES ('Quentin Tarantino');
INSERT INTO Director (Nombre_director) VALUES ('Christopher Nolan');
INSERT INTO Director (Nombre_director) VALUES ('Alfred Hitchcock');
INSERT INTO Director (Nombre_director) VALUES ('Greta Gerwig');
INSERT INTO Director (Nombre_director) VALUES ('Sofia Coppola');
INSERT INTO Director (Nombre_director) VALUES ('Guillermo del Toro');
INSERT INTO Director (Nombre_director) VALUES ('James Cameron');
INSERT INTO Director (Nombre_director) VALUES ('Peter Jackson');
INSERT INTO Director (Nombre_director) VALUES ('Ridley Scott');
INSERT INTO Director (Nombre_director) VALUES ('Francis Ford Coppola');
INSERT INTO Director (Nombre_director) VALUES ('Stanley Kubrick');
INSERT INTO Director (Nombre_director) VALUES ('David Fincher');
INSERT INTO Director (Nombre_director) VALUES ('Wes Anderson');
INSERT INTO Director (Nombre_director) VALUES ('Paul Thomas Anderson');
INSERT INTO Director (Nombre_director) VALUES ('Denis Villeneuve');
INSERT INTO Director (Nombre_director) VALUES ('Bong Joon-ho');
INSERT INTO Director (Nombre_director) VALUES ('Alejandro González Iñárritu');
INSERT INTO Director (Nombre_director) VALUES ('Spike Lee');
INSERT INTO Director (Nombre_director) VALUES ('Sergio Leone');
INSERT INTO Director (Nombre_director) VALUES ('Akira Kurosawa');
INSERT INTO Director (Nombre_director) VALUES ('Hayao Miyazaki');
INSERT INTO Director (Nombre_director) VALUES ('Clint Eastwood');
INSERT INTO Director (Nombre_director) VALUES ('Tim Burton');
INSERT INTO Director (Nombre_director) VALUES ('Ang Lee');
INSERT INTO Director (Nombre_director) VALUES ('George Lucas');
INSERT INTO Director (Nombre_director) VALUES ('Roman Polanski');
INSERT INTO Director (Nombre_director) VALUES ('Pedro Almodóvar');
INSERT INTO Director (Nombre_director) VALUES ('Jean-Luc Godard');--30
-- Inserciones para la tabla Género
INSERT INTO Género (Nombre_género) VALUES ('Acción');
INSERT INTO Género (Nombre_género) VALUES ('Aventura');
INSERT INTO Género (Nombre_género) VALUES ('Comedia');
INSERT INTO Género (Nombre_género) VALUES ('Drama');
INSERT INTO Género (Nombre_género) VALUES ('Fantasía');
INSERT INTO Género (Nombre_género) VALUES ('Ciencia Ficción');
INSERT INTO Género (Nombre_género) VALUES ('Suspense');
INSERT INTO Género (Nombre_género) VALUES ('Horror');
INSERT INTO Género (Nombre_género) VALUES ('Misterio');
INSERT INTO Género (Nombre_género) VALUES ('Romance');
INSERT INTO Género (Nombre_género) VALUES ('Animación');
INSERT INTO Género (Nombre_género) VALUES ('Documental');
INSERT INTO Género (Nombre_género) VALUES ('Musical');
INSERT INTO Género (Nombre_género) VALUES ('Western');
INSERT INTO Género (Nombre_género) VALUES ('Bélico');
INSERT INTO Género (Nombre_género) VALUES ('Histórico');
INSERT INTO Género (Nombre_género) VALUES ('Biográfico');
INSERT INTO Género (Nombre_género) VALUES ('Crimen');
INSERT INTO Género (Nombre_género) VALUES ('Deporte');
INSERT INTO Género (Nombre_género) VALUES ('Familia');--20
-- Inserciones para la tabla País
INSERT INTO País (Nombre_pais) VALUES ('Estados Unidos');
INSERT INTO País (Nombre_pais) VALUES ('España');
INSERT INTO País (Nombre_pais) VALUES ('Francia');
INSERT INTO País (Nombre_pais) VALUES ('Italia');
INSERT INTO País (Nombre_pais) VALUES ('Alemania');
INSERT INTO País (Nombre_pais) VALUES ('Japón');
INSERT INTO País (Nombre_pais) VALUES ('Honduras');--7
-- Inserciones para la tabla Usuario (Opcional)
INSERT INTO Usuario (Nombre, Apellido) VALUES ('Juan', 'Pérez');
INSERT INTO Usuario (Nombre, Apellido) VALUES ('María', 'López');
INSERT INTO Usuario (Nombre, Apellido) VALUES ('Pedro', 'García');
INSERT INTO Usuario (Nombre, Apellido) VALUES ('Ana', 'Martínez');
INSERT INTO Usuario (Nombre, Apellido) VALUES ('Luis', 'Rodríguez');
INSERT INTO Usuario (Nombre, Apellido) VALUES ('Andree', 'Vasquez');
-- Inserciones para la tabla Película
INSERT INTO Película (Título, ID_género, ID_director, ID_pais) VALUES ('Jurassic Park', 5, 1, 3);--1 id
INSERT INTO Película (Título, ID_género, ID_director, ID_pais) VALUES ('Inception', 11, 4, 2);
INSERT INTO Película (Título, ID_género, ID_director, ID_pais) VALUES ('Pulp Fiction', 8, 3, 4);
INSERT INTO Película (Título, ID_género, ID_director, ID_pais) VALUES ('The Godfather', 10, 12, 1);
INSERT INTO Película (Título, ID_género, ID_director, ID_pais) VALUES ('The Dark Knight', 2, 4, 5);
INSERT INTO Película (Título, ID_género, ID_director, ID_pais) VALUES ('Schindlers List', 6, 1, 2);--6 id 
INSERT INTO Película (Título, ID_género, ID_director, ID_pais) VALUES ('Interstellar', 14, 4, 3);
INSERT INTO Película (Título, ID_género, ID_director, ID_pais) VALUES ('Parasite', 9, 18, 6);
INSERT INTO Película (Título, ID_género, ID_director, ID_pais) VALUES ('La La Land', 13, 5, 7);
INSERT INTO Película (Título, ID_género, ID_director, ID_pais) VALUES ('The Shape of Water', 7, 8, 1);
INSERT INTO Película (Título, ID_género, ID_director, ID_pais) VALUES ('Avatar', 1, 9, 4);
INSERT INTO Película (Título, ID_género, ID_director, ID_pais) VALUES ('The Matrix', 2, 10, 3);
INSERT INTO Película (Título, ID_género, ID_director, ID_pais) VALUES ('Gladiator', 12, 11, 2);
INSERT INTO Película (Título, ID_género, ID_director, ID_pais) VALUES ('Braveheart', 16, 12, 5);
INSERT INTO Película (Título, ID_género, ID_director, ID_pais) VALUES ('Forrest Gump', 3, 13, 6);
INSERT INTO Película (Título, ID_género, ID_director, ID_pais) VALUES ('The Lion King', 18, 14, 7);
INSERT INTO Película (Título, ID_género, ID_director, ID_pais) VALUES ('The Avengers', 1, 15, 1);
INSERT INTO Película (Título, ID_género, ID_director, ID_pais) VALUES ('Titanic', 9, 16, 2);
INSERT INTO Película (Título, ID_género, ID_director, ID_pais) VALUES ('Star Wars', 6, 17, 3);
INSERT INTO Película (Título, ID_género, ID_director, ID_pais) VALUES ('Jaws', 5, 1, 4);--20
INSERT INTO Película (Título, ID_género, ID_director, ID_pais) VALUES ('The Silence of the Lambs', 8, 19, 5);
INSERT INTO Película (Título, ID_género, ID_director, ID_pais) VALUES ('Goodfellas', 18, 2, 6);
INSERT INTO Película (Título, ID_género, ID_director, ID_pais) VALUES ('Fight Club', 12, 20, 7);
INSERT INTO Película (Título, ID_género, ID_director, ID_pais) VALUES ('Toy Story', 13, 21, 1);
INSERT INTO Película (Título, ID_género, ID_director, ID_pais) VALUES ('Up', 14, 22, 2);
INSERT INTO Película (Título, ID_género, ID_director, ID_pais) VALUES ('Finding Nemo', 1, 23, 3);
INSERT INTO Película (Título, ID_género, ID_director, ID_pais) VALUES ('Ratatouille', 16, 24, 4);
INSERT INTO Película (Título, ID_género, ID_director, ID_pais) VALUES ('The Incredibles', 10, 25, 5);
INSERT INTO Película (Título, ID_género, ID_director, ID_pais) VALUES ('Inside Out', 15, 26, 6);
INSERT INTO Película (Título, ID_género, ID_director, ID_pais) VALUES ('Coco', 17, 27, 7);
INSERT INTO Película (Título, ID_género, ID_director, ID_pais) VALUES ('WALL-E', 8, 28, 1);
INSERT INTO Película (Título, ID_género, ID_director, ID_pais) VALUES ('Shrek', 11, 29, 2);
INSERT INTO Película (Título, ID_género, ID_director, ID_pais) VALUES ('Frozen', 12, 30, 3);
INSERT INTO Película (Título, ID_género, ID_director, ID_pais) VALUES ('Moana', 4, 2, 4);
INSERT INTO Película (Título, ID_género, ID_director, ID_pais) VALUES ('The Little Mermaid', 13, 3, 5);
INSERT INTO Película (Título, ID_género, ID_director, ID_pais) VALUES ('Beauty and the Beast', 15, 4, 6);
INSERT INTO Película (Título, ID_género, ID_director, ID_pais) VALUES ('Aladdin', 17, 5, 7);
INSERT INTO Película (Título, ID_género, ID_director, ID_pais) VALUES ('Cinderella', 14, 6, 1);
INSERT INTO Película (Título, ID_género, ID_director, ID_pais) VALUES ('Mulan', 18, 7, 2);
INSERT INTO Película (Título, ID_género, ID_director, ID_pais) VALUES ('Tangled', 9, 8, 3);
INSERT INTO Película (Título, ID_género, ID_director, ID_pais) VALUES ('Zootopia', 2, 9, 4);
INSERT INTO Película (Título, ID_género, ID_director, ID_pais) VALUES ('The Lion King II', 1, 10, 5);
INSERT INTO Película (Título, ID_género, ID_director, ID_pais) VALUES ('Toy Story 2', 7, 11, 6);
INSERT INTO Película (Título, ID_género, ID_director, ID_pais) VALUES ('The Jungle Book', 16, 12, 7);
INSERT INTO Película (Título, ID_género, ID_director, ID_pais) VALUES ('Peter Pan', 13, 13, 1);
INSERT INTO Película (Título, ID_género, ID_director, ID_pais) VALUES ('Snow White', 8, 14, 2);
INSERT INTO Película (Título, ID_género, ID_director, ID_pais) VALUES ('Sleeping Beauty', 6, 15, 3);
INSERT INTO Película (Título, ID_género, ID_director, ID_pais) VALUES ('The Hunchback of Notre Dame', 19, 16, 4);
INSERT INTO Película (Título, ID_género, ID_director, ID_pais) VALUES ('Hercules', 4, 17, 5);

-- Inserciones para la tabla Calificación
INSERT INTO Calificación (ID_usuario, ID_película, Calificación) VALUES (1, 7, 3);
INSERT INTO Calificación (ID_usuario, ID_película, Calificación) VALUES (2, 8, 4);
INSERT INTO Calificación (ID_usuario, ID_película, Calificación) VALUES (3, 9, 1);
INSERT INTO Calificación (ID_usuario, ID_película, Calificación) VALUES (4, 10, 5);
INSERT INTO Calificación (ID_usuario, ID_película, Calificación) VALUES (5, 11, 2);
INSERT INTO Calificación (ID_usuario, ID_película, Calificación) VALUES (6, 12, 4);
INSERT INTO Calificación (ID_usuario, ID_película, Calificación) VALUES (1, 13, 3);
INSERT INTO Calificación (ID_usuario, ID_película, Calificación) VALUES (2, 14, 5);
INSERT INTO Calificación (ID_usuario, ID_película, Calificación) VALUES (3, 15, 1);
INSERT INTO Calificación (ID_usuario, ID_película, Calificación) VALUES (4, 16, 2);
INSERT INTO Calificación (ID_usuario, ID_película, Calificación) VALUES (5, 17, 4);
INSERT INTO Calificación (ID_usuario, ID_película, Calificación) VALUES (6, 18, 3);
INSERT INTO Calificación (ID_usuario, ID_película, Calificación) VALUES (1, 19, 5);
INSERT INTO Calificación (ID_usuario, ID_película, Calificación) VALUES (2, 20, 4);
INSERT INTO Calificación (ID_usuario, ID_película, Calificación) VALUES (3, 21, 2);
INSERT INTO Calificación (ID_usuario, ID_película, Calificación) VALUES (4, 22, 1);
INSERT INTO Calificación (ID_usuario, ID_película, Calificación) VALUES (5, 23, 3);
INSERT INTO Calificación (ID_usuario, ID_película, Calificación) VALUES (6, 24, 5);
INSERT INTO Calificación (ID_usuario, ID_película, Calificación) VALUES (1, 25, 4);
INSERT INTO Calificación (ID_usuario, ID_película, Calificación) VALUES (2, 26, 2);
INSERT INTO Calificación (ID_usuario, ID_película, Calificación) VALUES (3, 27, 1);
INSERT INTO Calificación (ID_usuario, ID_película, Calificación) VALUES (4, 28, 3);
INSERT INTO Calificación (ID_usuario, ID_película, Calificación) VALUES (5, 29, 5);
INSERT INTO Calificación (ID_usuario, ID_película, Calificación) VALUES (6, 30, 4);
INSERT INTO Calificación (ID_usuario, ID_película, Calificación) VALUES (1, 31, 2);
INSERT INTO Calificación (ID_usuario, ID_película, Calificación) VALUES (2, 32, 3);
INSERT INTO Calificación (ID_usuario, ID_película, Calificación) VALUES (3, 33, 5);
INSERT INTO Calificación (ID_usuario, ID_película, Calificación) VALUES (4, 34, 1);
INSERT INTO Calificación (ID_usuario, ID_película, Calificación) VALUES (5, 35, 4);
INSERT INTO Calificación (ID_usuario, ID_película, Calificación) VALUES (6, 36, 2);
INSERT INTO Calificación (ID_usuario, ID_película, Calificación) VALUES (1, 37, 3);
INSERT INTO Calificación (ID_usuario, ID_película, Calificación) VALUES (2, 38, 5);
INSERT INTO Calificación (ID_usuario, ID_película, Calificación) VALUES (3, 39, 4);
INSERT INTO Calificación (ID_usuario, ID_película, Calificación) VALUES (4, 40, 2);
INSERT INTO Calificación (ID_usuario, ID_película, Calificación) VALUES (5, 41, 1);
INSERT INTO Calificación (ID_usuario, ID_película, Calificación) VALUES (6, 42, 3);
INSERT INTO Calificación (ID_usuario, ID_película, Calificación) VALUES (1, 43, 4);
INSERT INTO Calificación (ID_usuario, ID_película, Calificación) VALUES (2, 44, 5);
INSERT INTO Calificación (ID_usuario, ID_película, Calificación) VALUES (3, 45, 2);
INSERT INTO Calificación (ID_usuario, ID_película, Calificación) VALUES (4, 46, 3);
INSERT INTO Calificación (ID_usuario, ID_película, Calificación) VALUES (5, 47, 1);
INSERT INTO Calificación (ID_usuario, ID_película, Calificación) VALUES (6, 48, 4);
INSERT INTO Calificación (ID_usuario, ID_película, Calificación) VALUES (1, 49, 5);









