SET intervalstyle = 'sql_standard';

insert into Genres (genre_name) values 
	('Rock'),
	('Electronic'),
	('Classical'),
	('Random')
;

insert into Musicians (name_pseudonym) values 
	('Led Zeppelin'),
	('Rolling Stones'),
	('Daft Punk'),
	('Vivaldi'),
	('Task3')
;

insert into Albums (album_name,release_date) values 
	('Led Zeppelin 4','1971-01-01'),
	('Physical Graffiti','1975-01-01'),
	('Four Seasons','1725-01-01'),
	('Random Access Memories','2020-01-01'),
	('Task3','2019-01-01')
;

insert into Tracks (track_name, track_length, album) values 
	('Stairway to Heaven','2 minutes 1 second', (select id from Albums where album_name = 'Led Zeppelin 4')),
	('Kashmir','2 minutes 2 second', (select id from Albums where album_name = 'Physical Graffiti')),
	('Get Lucky','2 minutes 3 second', (select id from Albums where album_name = 'Random Access Memories')),
	('Winter','4 minutes 4 second', (select id from Albums where album_name = 'Four Seasons')),
	('Spring','2 minutes 5 second', (select id from Albums where album_name = 'Four Seasons')),
	('Summer','3 minutes 6 second', (select id from Albums where album_name = 'Four Seasons')),
	('Task3.1', '42 minutes', (select id from Albums where album_name = 'Task3')),
	('Task3.2', '6 minutes 9 seconds', (select id from Albums where album_name = 'Task3')),
	('Task3.3', '2 minutes 1 second', (select id from Albums where album_name = 'Task3'))
;

insert into Compilations (compilation_name, release_year) values 
	('Playlist 1','2016-01-01'),
	('Playlist 2','2017-01-01'),
	('Playlist 3','2018-01-01'),
	('Playlist 4','2019-01-01'),
	('Task3', '2021-01-01')
;

insert into G_M (genre, musician) values 
	((select id from Genres where genre_name = 'Rock'),(select id from Musicians where name_pseudonym = 'Led Zeppelin')),
	((select id from Genres where genre_name = 'Rock'),(select id from Musicians where name_pseudonym = 'Rolling Stones')),
	((select id from Genres where genre_name = 'Electronic'),(select id from Musicians where name_pseudonym = 'Daft Punk')),
	((select id from Genres where genre_name = 'Classical'),(select id from Musicians where name_pseudonym = 'Vivaldi')),
	((select id from Genres where genre_name = 'Random'),(select id from Musicians where name_pseudonym = 'Task3')),
	((select id from Genres where genre_name = 'Rock'),(select id from Musicians where name_pseudonym = 'Task3'))
;

insert into M_A (album, musician) values
	((select id from Albums where album_name = 'Led Zeppelin 4'),(select id from Musicians where name_pseudonym = 'Led Zeppelin')),
	((select id from Albums where album_name = 'Physical Graffiti'),(select id from Musicians where name_pseudonym = 'Led Zeppelin')),
	((select id from Albums where album_name = 'Four Seasons'),(select id from Musicians where name_pseudonym = 'Vivaldi')),
	((select id from Albums where album_name = 'Random Access Memories'),(select id from Musicians where name_pseudonym = 'Daft Punk')),
	((select id from Albums where album_name = 'Task3'),(select id from Musicians where name_pseudonym = 'Task3'))
;

insert into T_C(compilation, track) values
	((select id from Compilations where compilation_name = 'Playlist 1'),(select id from Tracks where track_name = 'Get Lucky')),
	((select id from Compilations where compilation_name = 'Playlist 2'),(select id from Tracks where track_name = 'Stairway to Heaven')),
	((select id from Compilations where compilation_name = 'Playlist 2'),(select id from Tracks where track_name = 'Kashmir')),
	((select id from Compilations where compilation_name = 'Playlist 3'),(select id from Tracks where track_name = 'Winter')),
	((select id from Compilations where compilation_name = 'Playlist 3'),(select id from Tracks where track_name = 'Spring')),
	((select id from Compilations where compilation_name = 'Playlist 3'),(select id from Tracks where track_name = 'Summer')),
	((select id from Compilations where compilation_name = 'Playlist 4'),(select id from Tracks where track_name = 'Spring')),
	((select id from Compilations where compilation_name = 'Playlist 4'),(select id from Tracks where track_name = 'Stairway to Heaven')),
	((select id from Compilations where compilation_name = 'Playlist 4'),(select id from Tracks where track_name = 'Get Lucky')),
	((select id from Compilations where compilation_name = 'Task3'),(select id from Tracks where track_name = 'Task3.1'))
;
