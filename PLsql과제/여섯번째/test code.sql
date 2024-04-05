insert into movie(title, year) values ('B',2019);
insert into movie(title, year) values ('C',2019);
insert into movie(title, year) values ('D',2019);
insert into movie(title, year) values ('E',2019);
insert into movie(title, year) values ('F',2019);
insert into movieexec(name) values('AA');
insert into movieprod(title, year, producer) values ('star wars',1977,'이재홍');/*title year는잇 이름은 없*/
commit;
insert into movieprod(title, year, producer) values ('stars',2019,'박수연');/*title year는없 이름은 없*/
commit;
insert into movieprod(title, year, producer) values ('starsㅁㄴㅇㄹ',2019,'조아라');/*title year는없 이름은 없*/
commit;
insert into movieprod(title, year, producer) values ('starsa',2019,'sharky');/*title year는없 이름은 잇*/
commit;
insert into movieprod(title, year, producer) values ('starsㅁㄴㅇa',2019,'sharky');/*title year는없 이름은 잇*/
commit;
insert into movieprod(title, year, producer) values ('aliens',1986,'walt disney');/*title year 이름 모두 잇*/
commit;
insert into movieprod values('Z5',2018,'X2');/*title year는없 이름은 잇*/
commit;

select * from movie;

select * from movieexec;

select * from movieprod;

select * from studio;

select max(certno) from movieexec;

select count(title), name from studio, movie where studioname = name group by name order by 1;

select studioname from (select studioname from movie group by studioname order by count(*)) where rownum = 1;

insert into starplays(title, year, name) values('A1',2019,'이재홍');
commit;
insert into starplays(title, year, name) values('A2',2018,'삼재홍');
commit;
insert into starplays(title, year, name) values('A3',2017,'사재홍');
commit;
insert into starplays(title, year, name) values('A4',2017,'오재홍');
commit;
insert into starplays(title, year, name) values('A4',2017,'육재홍');
commit;
insert into starplays(title, year, name) values('star wars', 1977 , '이재홍');
commit;
insert into starplays(title, year, name) values('star wars', 1977 , 'clark gable');
commit;
insert into starplays(title, year, name) values('A4',2017,'clark gable');
commit;

select * from movie;
select * from starplays;
select * from moviestar;
select * from starsin;