--Task 2
--1.Название и продолжительность самого длительного трека.
select track_name, track_length from tracks where track_length = (select max(track_length) from tracks);

--2.Название треков, продолжительность которых не менее 3,5 минут.
select track_name, track_length from tracks where track_length >= '3 minutes 5 seconds' ;

--3.Названия сборников, вышедших в период с 2018 по 2020 год включительно.
select compilation_name,release_year from Compilations where release_year between '2017-12-31' and '2020-01-02';

--4.Исполнители, чьё имя состоит из одного слова.
select name_pseudonym from Musicians where name_pseudonym not like '% %'

--5.Название треков, которые содержат слово «мой» или «my».
select track_name from tracks where (track_name like '%my%') or (track_name like '%мой%')

--Task3
--1.Количество исполнителей в каждом жанре.
select genre,count(musician) from G_m group by genre;

--2.Количество треков, вошедших в альбомы 2019–2020 годов.
select albums.release_date, count(tracks.id) from albums join tracks on albums.id = tracks.album  where albums.release_date between '2018-12-31' and '2020-01-02' group by albums.release_date;
--в строке выше то же самое, но с  указанием года выпуска
select count(id) from tracks where album in (select id from albums where release_date between '2018-12-31' and '2020-01-02');

--3.Средняя продолжительность треков по каждому альбому.
select album,avg(track_length) from tracks where album in (select id from albums) group by album order by album;


--4.Все исполнители, которые не выпустили альбомы в 2020 году.
--select album_name from albums where release_date not between '2019-12-31' and '2021-01-01';
--select musician from M_A where album in (select id from albums where release_date not between '2019-12-31' and '2021-01-01');
--select id,name_pseudonym from musicians where id in (select musician from M_A where album in (select id from albums where release_date not between '2019-12-31' and '2021-01-01'));
--select id from musicians except (select musician from M_A where album in (select id from albums where release_date not between '2019-12-31' and '2021-01-01'));
--через вложенные запросы
select id,name_pseudonym from musicians where id not in (select id from musicians except (select musician from M_A where album in (select id from albums where release_date not between '2019-12-31' and '2021-01-01')));


--5.Названия сборников, в которых присутствует конкретный исполнитель (выберите его сами).// Выбрал 'Led Zeppelin'
--select name_pseudonym from musicians where name_pseudonym = 'Led Zeppelin';
--select album from M_A where musician = (select id from musicians where name_pseudonym = 'Led Zeppelin');
--select album_name from albums where id in (select album from M_A where musician = (select id from musicians where name_pseudonym = 'Led Zeppelin'));
--select track_name from tracks where id in (select id from albums where id in (select album from M_A where musician = (select id from musicians where name_pseudonym = 'Led Zeppelin')));
--select compilation from t_c where track in (select id from tracks where id in (select id from albums where id in (select album from M_A where musician = (select id from musicians where name_pseudonym = 'Led Zeppelin')))) group by compilation;
--реализация через вложенные запросы
select compilation_name from Compilations where id in (select compilation from t_c where track in (select id from tracks where id in (select id from albums where id in (select album from M_A where musician = (select id from musicians where name_pseudonym = 'Led Zeppelin')))) group by compilation);
--реализация через обьединение таблиц
select compilation_name from compilations c 
join T_C tc on tc.compilation = c.id
join tracks t on t.id = tc.track
join albums a on a.id = t.album
join m_a ma  on ma.album = a.id
join musicians m on m.id = ma.musician
where name_pseudonym  = 'Led Zeppelin'
group by c.id;



--Task4
--1.Названия альбомов, в которых присутствуют исполнители более чем одного жанра.
--select musician from g_m group by musician having count(genre) > 1;
--select name_pseudonym from musicians where id in (select musician from g_m group by musician having count(genre) > 1);
--select album from m_a where musician in (select id from musicians where id in (select musician from g_m group by musician having count(genre) > 1));
select album_name from albums where id in (select album from m_a where musician in (select id from musicians where id in (select musician from g_m group by musician having count(genre) > 1)));
--реализация через обьединение таблиц
select album_name  from albums a
join m_a ma on a.id = ma.musician 
join musicians m on m.id = ma.musician
join g_m gm on gm.musician = m.id
group by album_name, m.id
having m.id in (select musician from g_m group by musician having count(genre) > 1);
--важный урок: если использовать внешние ключи с таким же названием как и первичный ключ таблицы то можно было бы использовать обьединение при помощи using(и скорее всего еще массу функционала о котором я не знаю)



--2.Наименования треков, которые не входят в сборники.
--select track from T_C;
select track_name from tracks where id not in (select track from T_C);
--реализация через обьединение таблиц
SELECT track_name 
FROM tracks t 
LEFT JOIN T_C c 
ON t.id = c.track  
WHERE c.track IS null;

--3.Исполнитель или исполнители, написавшие самый короткий по продолжительности трек, — теоретически таких треков может быть несколько.
--select min(track_length) from tracks;
--select track_name from tracks where track_length = (select min(track_length) from tracks);
--album
--select id from albums where id in (select album from tracks where track_length = (select min(track_length) from tracks));
select musician from m_a where album in (select id from albums where id in (select album from tracks where track_length = (select min(track_length) from tracks)));
--то же самое, но с именем
select name_pseudonym  from musicians where id in (select musician from m_a where album in (select id from albums where id in (select album from tracks where track_length = (select min(track_length) from tracks)))); 
--реализация через обьединение таблиц
select name_pseudonym from musicians m
join m_a ma on m.id = ma.musician 
join albums a on ma.album = a.id 
join tracks t on a.id = t.album
where track_length = (select min(track_length) from tracks);

--4.Названия альбомов, содержащих наименьшее количество треков.
--select album,count(*) from tracks group by album;
--select min(count) from (select count(*) from tracks group by album) t;
--нашел min count
--осталось найти id альбома с min count
--select album from (select album,count(*) from tracks group by album) t where count = (select min(count) from (select count(*) from tracks group by album) t);
select album_name from albums 
where id in 
(
	select album from 
	(
		select album,count(*) from tracks 
		group by album
	) t 
	where count = 
	(
		select min(count) from 
		(
			select count(*) from tracks group by album
		) t
	)
);
--реализация через обьединение таблиц
select a.album_name,count(*) from albums a
join tracks t on t.album = a.id
group by album_name
having count(*) = (select min(count) from (select count(*) from tracks group by album) t)
order by count;
--поиск min count
select min(MyCount) from
(
	select album_name,count(*) as MyCount 
	from albums a join tracks t on t.album = a.id 
	group by album_name
) as MyAggregate;
--список треков в каждом альбоме 
select album_name,count(*) as MyCount from albums a 
join tracks t on t.album = a.id 
group by album_name;
--складываем 2 последних запроса:
select album_name,count(*) as MyCount from albums a 
join tracks t on t.album = a.id
group by album_name
having count(*) = 
(
	select min(MyCount) from
	(
		select album_name,count(*) as MyCount
		from albums a join tracks t on t.album = a.id 
		group by album_name
	) as MyAggregate
);
--если честно, то я вообще не представляю как можно решить 14 задание без подзапросов
--min из count трековв альбоме мы сможем найти только через комбинацию из подзапроса и аггрегатной функции
--можно ли решить последнее задание без применения подзапросов?


