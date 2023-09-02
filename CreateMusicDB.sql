SET intervalstyle = 'sql_standard';

create table IF NOT EXISTS Genres(
    id SERIAL PRIMARY KEY,
    genre_name VARCHAR(40) NOT NULL
);

CREATE TABLE IF NOT EXISTS Musicians(
    id SERIAL PRIMARY KEY,
    name_pseudonym VARCHAR(40) NOT NULL
);

CREATE TABLE IF NOT EXISTS Albums(
    id SERIAL PRIMARY KEY,
    album_name VARCHAR(40) NOT NULL,
    release_date DATE NOT NULL
);

CREATE TABLE IF NOT EXISTS Tracks(
    id SERIAL PRIMARY KEY,
    track_name VARCHAR(40) NOT null,
    album INTEGER REFERENCES Albums(id),
    track_length interval not null
);

CREATE TABLE IF NOT EXISTS Compilations(
    id SERIAL PRIMARY KEY,
    compilation_name VARCHAR(40) NOT NULL,
    release_year DATE NOT NULL
);

CREATE TABLE IF NOT EXISTS G_M(
    genre INTEGER REFERENCES Genres(id),
    musician INTEGER REFERENCES Musicians(id)
);

CREATE TABLE IF NOT EXISTS M_A(
    album INTEGER REFERENCES Albums(id),
    musician INTEGER REFERENCES Musicians(id)
);

CREATE TABLE IF NOT EXISTS T_C(
    compilation INTEGER REFERENCES Compilations(id),
    track INTEGER REFERENCES Tracks(id)
);
