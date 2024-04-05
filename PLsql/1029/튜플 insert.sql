insert into people values(
    '홍길동', '2001-01-01',
    phone_tab(),
    addr_tab()
);
insert into table(select phone_list from people where name = '홍길동') values(
    phone_ty('office',1,'051-663-5140'));
insert into table(select phone_list from people where name = '홍길동') values(
    phone_ty('mobile',2,'010-1234-5140'));
insert into table(select addresses from people where name = '홍길동') values(
    addr_ty('부산시','남구','대연동'));



insert into people values(
    '경성대', '1991-11-01',
    phone_tab(phone_ty('office',1,'051-663-5140')),
    addr_tab(addr_ty('부산시','남구','대연동'))
);
insert into people values(
    '강남길', '1992-02-10',
    phone_tab(phone_ty('office',1,'051-663-5140'),phone_ty('home',2,'010-2663-5140'),phone_ty('mobile',3,'010-1234-5140')),
    addr_tab(addr_ty('부산시','남구','대연동'),addr_ty('대전시','남구','대연동'))
);

select p.name, l.no, l.seq
from people p, table(p.phone_list) l;/*nested table형태의 애트리뷰트를 뽑아낼때의 형식*/

select p.name, l.no, l.seq, a.city, a.gu
from people p, table(p.phone_list) l, table(p.addresses) a;

select p.name, p.birthdate, cursor(select name, no from table(p.phone_list)), cursor(select * from table(p.addresses))
from people p;/*여러가지 정보가 나열될때는 cursor를 이용하면 된다.*/