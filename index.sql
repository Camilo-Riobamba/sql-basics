-- Creación de las tablas
CREATE TABLE Users (
    user_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    age INTEGER
);

CREATE TABLE Courses (
    course_id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    level VARCHAR(50) CHECK(level IN ('Principiante', 'Intermedio', 'Avanzado')),
    teacher_id INTEGER REFERENCES Users(user_id)
);

CREATE TABLE CourseVideos (
    video_id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    url TEXT,
    course_id INTEGER REFERENCES Courses(course_id)
);

CREATE TABLE Categories (
    category_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE Roles (
    role_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE CHECK(name IN ('student', 'teacher', 'admin'))
);

-- Definición de relaciones y restricciones
ALTER TABLE Users
ADD role_id INTEGER REFERENCES Roles(role_id);

ALTER TABLE Users
ADD CONSTRAINT chk_age CHECK (age >= 0);

CREATE TABLE UserRoles (
    user_id INTEGER REFERENCES Users(user_id),
    role_id INTEGER REFERENCES Roles(role_id),
    PRIMARY KEY (user_id, role_id)
);

CREATE TABLE CourseCategories (
    course_id INTEGER REFERENCES Courses(course_id),
    category_id INTEGER REFERENCES Categories(category_id),
    PRIMARY KEY (course_id, category_id)
);

-- Inserción de registros de ejemplo
INSERT INTO Roles (name) VALUES
    ('student'),
    ('teacher'),
    ('admin');

INSERT INTO Users (name, email, password, age, role_id) VALUES
    ('Usuario 1', 'usuario1@example.com', 'contraseña1', 25, 1),
    ('Profesor 1', 'profesor1@example.com', 'contraseña2', 30, 2);

INSERT INTO Courses (title, description, level, teacher_id) VALUES
    ('Curso de Matemáticas', 'Aprenda matemáticas básicas', 'Principiante', 2),
    ('Curso de Programación', 'Aprenda a programar en Python', 'Intermedio', 2);

INSERT INTO Categories (name) VALUES
    ('Matemáticas'),
    ('Programación');

INSERT INTO CourseVideos (title, url, course_id) VALUES
    ('Introducción a las matemáticas', 'video1.mp4', 1),
    ('Programación en Python 101', 'video2.mp4', 2);
