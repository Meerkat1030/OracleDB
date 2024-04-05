drop table Cartoon;
drop table StarsIn;
drop table "DB2017948072"."MOVIESTAR" cascade constraints PURGE;
drop table Movie;
drop table Studio;
drop table "DB2017948072"."MOVIEEXEC" cascade constraints PURGE;

  CREATE TABLE "MOVIEEXEC" 
   (	"NAME" VARCHAR2(30), 
	"ADDRESS" VARCHAR2(255), 
	"CERTNO" NUMBER(*,0), 
	"NETWORTH" NUMBER(*,0),
  "SPOUSENAME" VARCHAR2(30),
  "BIRTHDATE" DATE,
  "GENDER" CHAR(6)
   )
/
REM INSERTING into MOVIEEXEC
SET DEFINE OFF;
Insert into MOVIEEXEC (NAME,ADDRESS,CERTNO,NETWORTH,SPOUSENAME,BIRTHDATE,GENDER) values ('이재홍',	'경남 양산시 서들로 179 반도유보라 3차 109동 904호	', 1, 99999999999,	'박수연', 	to_date('1999-10-30','RRRR-MM-DD'),	'male  ');
Insert into MOVIEEXEC (NAME,ADDRESS,CERTNO,NETWORTH,SPOUSENAME,BIRTHDATE,GENDER) values ('남주혁',	'서울시', 	2, 4657845, '조아라', to_date('1998-09-26','RRRR-MM-DD'), 'male  ');
Insert into MOVIEEXEC (NAME,ADDRESS,CERTNO,NETWORTH,SPOUSENAME,BIRTHDATE,GENDER) values ('톰 홀랜드', '영국시 스파이더맨구 거미줄동', 3, 6526487428, '손주원', to_date('1998-01-26','RRRR-MM-DD'), 'male  ');
Insert into MOVIEEXEC (NAME,ADDRESS,CERTNO,NETWORTH,SPOUSENAME,BIRTHDATE,GENDER) values ('박세웅',	'부산시 롯데구 자이언츠동', 4,	157518,	'문성민',	to_date('1998-03-14','RRRR-MM-DD'), 'male  ');
Insert into MOVIEEXEC (NAME,ADDRESS,CERTNO,NETWORTH,SPOUSENAME,BIRTHDATE,GENDER) values ('이민혁',	'일본 도쿄시',	5, 52525252, '홍혜정', to_date('1998-03-11','RRRR-MM-DD'), 'male  ');
Insert into MOVIEEXEC (NAME,ADDRESS,CERTNO,NETWORTH,SPOUSENAME,BIRTHDATE,GENDER) values ('엄태균',	'부산시 경성대학교 528호 6번자리', '6', 741822, '양기석', to_date('1998-01-03','RRRR-MM-DD'), 'male  ');
Insert into MOVIEEXEC (NAME,ADDRESS,CERTNO,NETWORTH,SPOUSENAME,BIRTHDATE,GENDER) values ('기네스 펠트로', '미국 토니에게시 따뜻한구 마음이동 있었다는아파트', 7, 548724857, '로버트 다우니 주니어', to_date('1978-01-01','RRRR-MM-DD'), 'female');
Insert into MOVIEEXEC (NAME,ADDRESS,CERTNO,NETWORTH,SPOUSENAME,BIRTHDATE,GENDER) values ('송재익',	'부산시 경성대학교 528호 7번자리', 8, 457523785, '최광민', to_date('1998-01-05','RRRR-MM-DD'), 'male  ');
--------------------------------------------------------
--  DDL for Index SYS_C00233212
--------------------------------------------------------

  CREATE UNIQUE INDEX "SYS_C00233212" ON "MOVIEEXEC" ("CERTNO");
/
--------------------------------------------------------
--  Constraints for Table MOVIEEXEC
--------------------------------------------------------

  ALTER TABLE "MOVIEEXEC" ADD PRIMARY KEY ("CERTNO") ENABLE;
/
  ALTER TABLE "MOVIEEXEC" ADD UNIQUE ("NAME") ENABLE;
  /
ALTER TABLE "MOVIEEXEC" ADD CONSTRAINT "SEX_CHK" CHECK (gender in ('male', 'female'));

/

--------------------------------------------------------
--  DDL for Table MOVIESTAR
--------------------------------------------------------

  CREATE TABLE "MOVIESTAR" 
   (	"NAME" VARCHAR2(30), 
	"ADDRESS" VARCHAR2(255), 
	"GENDER" CHAR(6), 
	"BIRTHDATE" DATE,
   "SPOUSENAME" VARCHAR2(30)
   )
/
REM INSERTING into MOVIESTAR
SET DEFINE OFF;
Insert into MOVIESTAR (NAME,ADDRESS,GENDER,BIRTHDATE,SPOUSENAME) values ('박수연','경남 양산시 범어주공 아파트','female',to_date('1999-10-30','RRRR-MM-DD'), '이재홍');
Insert into MOVIESTAR (NAME,ADDRESS,GENDER,BIRTHDATE,SPOUSENAME) values ('조아라','경남 양산시 대방노블랜드7차','female',to_date('1998-09-26','RRRR-MM-DD'), '남주혁');
Insert into MOVIESTAR (NAME,ADDRESS,GENDER,BIRTHDATE,SPOUSENAME) values ('손주원','부산시 남구 대연동 원룸 어딘가','female',to_date('1998-01-26','RRRR-MM-DD'), '톰 홀랜드');
Insert into MOVIESTAR (NAME,ADDRESS,GENDER,BIRTHDATE,SPOUSENAME) values ('문성민','부산시 부산역','female',to_date('1998-03-14','RRRR-MM-DD'), '박세웅');
Insert into MOVIESTAR (NAME,ADDRESS,GENDER,BIRTHDATE,SPOUSENAME) values ('홍혜정','부산시 남구 대연동 원룸 어딘가2','female',to_date('1998-03-11','RRRR-MM-DD'), '이민혁');
Insert into MOVIESTAR (NAME,ADDRESS,GENDER,BIRTHDATE,SPOUSENAME) values ('톰 크루즈','미국 미션시 임파서블동','male  ',to_date('1999-10-30','RRRR-MM-DD'),'');
Insert into MOVIESTAR (NAME,ADDRESS,GENDER,BIRTHDATE,SPOUSENAME) values ('하상엽','부산시 경성대학교 528호 1번자리','male  ',to_date('1999-10-30','RRRR-MM-DD'),'');
Insert into MOVIESTAR (NAME,ADDRESS,GENDER,BIRTHDATE,SPOUSENAME) values ('신무곤','부산시 경성대학교 528호 2번자리','male  ',to_date('1999-10-30','RRRR-MM-DD'),'');
Insert into MOVIESTAR (NAME,ADDRESS,GENDER,BIRTHDATE,SPOUSENAME) values ('양기석','부산시 경성대학교 528호 3번자리','male  ',to_date('1995-01-03','RRRR-MM-DD'), '엄태균');
Insert into MOVIESTAR (NAME,ADDRESS,GENDER,BIRTHDATE,SPOUSENAME) values ('콩진호','서울시 서울시 이이동 이이동 둘둘아파트 둘둘아파트 222호 222호','female',to_date('1992-02-22','RRRR-MM-DD'), '');
Insert into MOVIESTAR (NAME,ADDRESS,GENDER,BIRTHDATE,SPOUSENAME) values ('로버트 다우니 주니어','미국 아이엠시 아이언멘동 똭아파트','male  ',to_date('1963-01-01','RRRR-MM-DD'), '기네스 펠트로');
Insert into MOVIESTAR (NAME,ADDRESS,GENDER,BIRTHDATE,SPOUSENAME) values ('스탠 리','미국 할리우드','male  ',to_date('1999-10-30','RRRR-MM-DD'), '');
Insert into MOVIESTAR (NAME,ADDRESS,GENDER,BIRTHDATE,SPOUSENAME) values ('박동현','부산시 경성대학교 528호 4번자리','male  ',to_date('1998-01-04','RRRR-MM-DD'), '');
Insert into MOVIESTAR (NAME,ADDRESS,GENDER,BIRTHDATE,SPOUSENAME) values ('최광민','부산시 경성대학교 528호 5번자리','male  ',to_date('1998-01-05','RRRR-MM-DD'), '송재익');
--------------------------------------------------------
--  DDL for Index SYS_C00233216
--------------------------------------------------------

  CREATE UNIQUE INDEX "SYS_C00233216" ON "MOVIESTAR" ("NAME")
/
--------------------------------------------------------
--  Constraints for Table MOVIESTAR
--------------------------------------------------------

  ALTER TABLE "MOVIESTAR" ADD CONSTRAINT "SEX2_CHK" CHECK (gender in ('male', 'female'))
/
  ALTER TABLE "MOVIESTAR" ADD PRIMARY KEY ("NAME")
/
  ALTER TABLE "MOVIESTAR" ADD FOREIGN KEY ("SPOUSENAME")
	  REFERENCES "MOVIEEXEC" ("NAME") ON DELETE CASCADE ENABLE
/
--------------------------------------------------------
--  DDL for Table STUDIO
--------------------------------------------------------

  CREATE TABLE "STUDIO" 
   (	"NAME" VARCHAR2(30), 
	"ADDRESS" VARCHAR2(255), 
	"PRESNO" NUMBER(*,0),
  "EMPNO" NUMBER(*,0)
   )
/
REM INSERTING into STUDIO
SET DEFINE OFF;
Insert into STUDIO (NAME,ADDRESS,PRESNO,EMPNO) values ('멜론','김해시 어느시골 비닐하우스',8,1);
Insert into STUDIO (NAME,ADDRESS,PRESNO,EMPNO) values ('Fox','부산시 어린이대공원 여우존',4,1000);
Insert into STUDIO (NAME,ADDRESS,PRESNO,EMPNO) values ('마블','부산 남구 수영로 123',1,500000);
Insert into STUDIO (NAME,ADDRESS,PRESNO,EMPNO) values ('지니','올레시 기가동',3,7845);
Insert into STUDIO (NAME,ADDRESS,PRESNO,EMPNO) values ('네이버뮤직','서울시 강남구 판교동',5,78548);
Insert into STUDIO (NAME,ADDRESS,PRESNO,EMPNO) values ('재홍뮤직','경남 양산시 서들로 111',1,3000000);

--------------------------------------------------------
--  DDL for Index SYS_C00233213
--------------------------------------------------------

  CREATE UNIQUE INDEX "SYS_C00233213" ON "STUDIO" ("NAME");
/
--------------------------------------------------------
--  Constraints for Table STUDIO
--------------------------------------------------------

  ALTER TABLE "STUDIO" ADD PRIMARY KEY ("NAME") ENABLE
/
--------------------------------------------------------
--  Ref Constraints for Table STUDIO
--------------------------------------------------------

  ALTER TABLE "STUDIO" ADD FOREIGN KEY ("PRESNO")
	  REFERENCES "MOVIEEXEC" ("CERTNO") ON DELETE CASCADE ENABLE
/

--------------------------------------------------------
--  DDL for Table MOVIE
--------------------------------------------------------

  CREATE TABLE "MOVIE" 
   (	"TITLE" VARCHAR2(255), 
	"YEAR" NUMBER(*,0), 
	"LENGTH" NUMBER(*,0), 
	"INCOLOR" CHAR(1), 
	"STUDIONAME" VARCHAR2(30), 
	"PRODUCERNO" NUMBER(*,0),
  "DIRECTORNO" NUMBER(*,0),
  "SOUNDSTUDIO" VARCHAR2(30)
   )
/
REM INSERTING into MOVIE
SET DEFINE OFF;
Insert into MOVIE (TITLE,YEAR,LENGTH,INCOLOR,STUDIONAME,PRODUCERNO,DIRECTORNO,SOUNDSTUDIO) values ('Little Mermaid',2019,90,'t','Fox',2,2,'멜론');
Insert into MOVIE (TITLE,YEAR,LENGTH,INCOLOR,STUDIONAME,PRODUCERNO,DIRECTORNO,SOUNDSTUDIO) values ('작전명 발키리',2017,120,'t','Fox',2,2,'지니');
Insert into MOVIE (TITLE,YEAR,LENGTH,INCOLOR,STUDIONAME,PRODUCERNO,DIRECTORNO,SOUNDSTUDIO) values ('Star Wars',2019,90,'t','Fox',2,2,'네이버뮤직');
Insert into MOVIE (TITLE,YEAR,LENGTH,INCOLOR,STUDIONAME,PRODUCERNO,DIRECTORNO,SOUNDSTUDIO) values ('아이언맨',2013,200,'t','마블',1,1,'재홍뮤직');
Insert into MOVIE (TITLE,YEAR,LENGTH,INCOLOR,STUDIONAME,PRODUCERNO,DIRECTORNO,SOUNDSTUDIO) values ('아이언맨2',2014,123,'t','마블',1,1,'재홍뮤직');
Insert into MOVIE (TITLE,YEAR,LENGTH,INCOLOR,STUDIONAME,PRODUCERNO,DIRECTORNO,SOUNDSTUDIO) values ('아이언맨3',2015,156,'t','마블',1,1,'재홍뮤직');
Insert into MOVIE (TITLE,YEAR,LENGTH,INCOLOR,STUDIONAME,PRODUCERNO,DIRECTORNO,SOUNDSTUDIO) values ('어벤져스',2016,130,'t','마블',1,3,'재홍뮤직');
Insert into MOVIE (TITLE,YEAR,LENGTH,INCOLOR,STUDIONAME,PRODUCERNO,DIRECTORNO,SOUNDSTUDIO) values ('어벤져스 : 에이지 오브 울트론',2017,120,'t','마블',4,3,'재홍뮤직');
Insert into MOVIE (TITLE,YEAR,LENGTH,INCOLOR,STUDIONAME,PRODUCERNO,DIRECTORNO,SOUNDSTUDIO) values ('어벤져스 : 인피니티워',2018,128,'t','마블',1,3,'재홍뮤직');
Insert into MOVIE (TITLE,YEAR,LENGTH,INCOLOR,STUDIONAME,PRODUCERNO,DIRECTORNO,SOUNDSTUDIO) values ('어벤져스 : 앤드게임',2019,303,'t','마블',1,1,'재홍뮤직');
Insert into MOVIE (TITLE,YEAR,LENGTH,INCOLOR,STUDIONAME,PRODUCERNO,DIRECTORNO,SOUNDSTUDIO) values ('꼴데자이언츠',2018,51,'t','Fox',4,1,'재홍뮤직');
Insert into MOVIE (TITLE,YEAR,LENGTH,INCOLOR,STUDIONAME,PRODUCERNO,DIRECTORNO,SOUNDSTUDIO) values ('꼴데자이언츠2',2019,60,'t','Fox',4,1,'재홍뮤직');
--------------------------------------------------------
--  DDL for Index SYS_C00233218
--------------------------------------------------------

  CREATE UNIQUE INDEX "SYS_C00233218" ON "MOVIE" ("TITLE", "YEAR");
/
--------------------------------------------------------
--  Constraints for Table MOVIE
--------------------------------------------------------

  ALTER TABLE "MOVIE" ADD CONSTRAINT "MOV_CHK" CHECK (length > 50 and year > 1900 and year <= 2019) ENABLE;
 /
  ALTER TABLE "MOVIE" ADD PRIMARY KEY ("TITLE", "YEAR") ENABLE;
/
--------------------------------------------------------
--  Ref Constraints for Table MOVIE
--------------------------------------------------------

   ALTER TABLE "MOVIE" ADD FOREIGN KEY ("DIRECTORNO")
         REFERENCES "MOVIEEXEC" ("CERTNO") ON DELETE SET NULL ENABLE;
      /
  ALTER TABLE "MOVIE" ADD FOREIGN KEY ("PRODUCERNO")
	  REFERENCES "MOVIEEXEC" ("CERTNO") ON DELETE SET NULL ENABLE;
    /
    ALTER TABLE "MOVIE" ADD FOREIGN KEY ("SOUNDSTUDIO")
         REFERENCES "STUDIO" ("NAME") ON DELETE SET NULL ENABLE;
      /
    ALTER TABLE "MOVIE" ADD FOREIGN KEY ("STUDIONAME")
	     REFERENCES "STUDIO" ("NAME") ON DELETE  SET NULL ENABLE;
    /

--------------------------------------------------------
--  DDL for Table STARSIN
--------------------------------------------------------

  CREATE TABLE "STARSIN" 
   (	"MOVIETITLE" VARCHAR2(255), 
	"MOVIEYEAR" NUMBER(*,0), 
	"STARNAME" VARCHAR2(30),
  "GURANTEE" NUMBER(*,0)
   )
/
REM INSERTING into STARSIN
SET DEFINE OFF;
Insert into STARSIN (MOVIETITLE,MOVIEYEAR,STARNAME,GURANTEE) values ('Little Mermaid',2019,'박수연',482457);
Insert into STARSIN (MOVIETITLE,MOVIEYEAR,STARNAME,GURANTEE) values ('Little Mermaid',2019,'조아라',21654);
Insert into STARSIN (MOVIETITLE,MOVIEYEAR,STARNAME,GURANTEE) values ('Little Mermaid',2019,'손주원',659875);
Insert into STARSIN (MOVIETITLE,MOVIEYEAR,STARNAME,GURANTEE) values ('Little Mermaid',2019,'문성민',65854);
Insert into STARSIN (MOVIETITLE,MOVIEYEAR,STARNAME,GURANTEE) values ('Little Mermaid',2019,'홍혜정',65671);
Insert into STARSIN (MOVIETITLE,MOVIEYEAR,STARNAME,GURANTEE) values ('작전명 발키리',2017,'조아라',547893);
Insert into STARSIN (MOVIETITLE,MOVIEYEAR,STARNAME,GURANTEE) values ('작전명 발키리',2017,'톰 크루즈',12012201);
Insert into STARSIN (MOVIETITLE,MOVIEYEAR,STARNAME,GURANTEE) values ('작전명 발키리',2017,'하상엽',2157231);
Insert into STARSIN (MOVIETITLE,MOVIEYEAR,STARNAME,GURANTEE) values ('Star Wars',2019,'조아라',2165754);
Insert into STARSIN (MOVIETITLE,MOVIEYEAR,STARNAME,GURANTEE) values ('Star Wars',2019,'신무곤',3287521);
Insert into STARSIN (MOVIETITLE,MOVIEYEAR,STARNAME,GURANTEE) values ('Star Wars',2019,'양기석',4189752);
Insert into STARSIN (MOVIETITLE,MOVIEYEAR,STARNAME,GURANTEE) values ('Star Wars',2019,'콩진호',2222222);
Insert into STARSIN (MOVIETITLE,MOVIEYEAR,STARNAME,GURANTEE) values ('아이언맨',2013,'박수연',168742);
Insert into STARSIN (MOVIETITLE,MOVIEYEAR,STARNAME,GURANTEE) values ('아이언맨',2013,'로버트 다우니 주니어',265879765);
Insert into STARSIN (MOVIETITLE,MOVIEYEAR,STARNAME,GURANTEE) values ('아이언맨',2013,'스탠 리',1572215);
Insert into STARSIN (MOVIETITLE,MOVIEYEAR,STARNAME,GURANTEE) values ('아이언맨2',2014,'박수연',4567547);
Insert into STARSIN (MOVIETITLE,MOVIEYEAR,STARNAME,GURANTEE) values ('아이언맨2',2014,'로버트 다우니 주니어',26987533);
Insert into STARSIN (MOVIETITLE,MOVIEYEAR,STARNAME,GURANTEE) values ('아이언맨2',2014,'스탠 리',686577);
Insert into STARSIN (MOVIETITLE,MOVIEYEAR,STARNAME,GURANTEE) values ('아이언맨3',2015,'박수연',652575221);
Insert into STARSIN (MOVIETITLE,MOVIEYEAR,STARNAME,GURANTEE) values ('아이언맨3',2015,'로버트 다우니 주니어',587255);
Insert into STARSIN (MOVIETITLE,MOVIEYEAR,STARNAME,GURANTEE) values ('아이언맨3',2015,'스탠 리',4782487);
Insert into STARSIN (MOVIETITLE,MOVIEYEAR,STARNAME,GURANTEE) values ('어벤져스',2016,'박수연',3543258);
Insert into STARSIN (MOVIETITLE,MOVIEYEAR,STARNAME,GURANTEE) values ('어벤져스',2016,'로버트 다우니 주니어',34874286);
Insert into STARSIN (MOVIETITLE,MOVIEYEAR,STARNAME,GURANTEE) values ('어벤져스',2016,'스탠 리',98754874);
Insert into STARSIN (MOVIETITLE,MOVIEYEAR,STARNAME,GURANTEE) values ('어벤져스 : 에이지 오브 울트론',2017,'박수연',3248756254);
Insert into STARSIN (MOVIETITLE,MOVIEYEAR,STARNAME,GURANTEE) values ('어벤져스 : 에이지 오브 울트론',2017,'로버트 다우니 주니어',278548);
Insert into STARSIN (MOVIETITLE,MOVIEYEAR,STARNAME,GURANTEE) values ('어벤져스 : 에이지 오브 울트론',2017,'스탠 리',547547654);
Insert into STARSIN (MOVIETITLE,MOVIEYEAR,STARNAME,GURANTEE) values ('어벤져스 : 인피니티워',2018,'박수연',874845575);
Insert into STARSIN (MOVIETITLE,MOVIEYEAR,STARNAME,GURANTEE) values ('어벤져스 : 인피니티워',2018,'로버트 다우니 주니어',6247795489);
Insert into STARSIN (MOVIETITLE,MOVIEYEAR,STARNAME,GURANTEE) values ('어벤져스 : 인피니티워',2018,'스탠 리',49876587);
Insert into STARSIN (MOVIETITLE,MOVIEYEAR,STARNAME,GURANTEE) values ('어벤져스 : 앤드게임',2019,'박수연',5487454);
Insert into STARSIN (MOVIETITLE,MOVIEYEAR,STARNAME,GURANTEE) values ('어벤져스 : 앤드게임',2019,'로버트 다우니 주니어',47821579);
Insert into STARSIN (MOVIETITLE,MOVIEYEAR,STARNAME,GURANTEE) values ('어벤져스 : 앤드게임',2019,'스탠 리',2789748754);
Insert into STARSIN (MOVIETITLE,MOVIEYEAR,STARNAME,GURANTEE) values ('꼴데자이언츠',2018,'문성민',74224475);
Insert into STARSIN (MOVIETITLE,MOVIEYEAR,STARNAME,GURANTEE) values ('꼴데자이언츠',2018,'박동현',1547557);
Insert into STARSIN (MOVIETITLE,MOVIEYEAR,STARNAME,GURANTEE) values ('꼴데자이언츠',2018,'최광민',474875487);
Insert into STARSIN (MOVIETITLE,MOVIEYEAR,STARNAME,GURANTEE) values ('꼴데자이언츠2',2019,'문성민',58416576);
Insert into STARSIN (MOVIETITLE,MOVIEYEAR,STARNAME,GURANTEE) values ('꼴데자이언츠2',2019,'박동현',24894232);
Insert into STARSIN (MOVIETITLE,MOVIEYEAR,STARNAME,GURANTEE) values ('꼴데자이언츠2',2019,'최광민',548754887);
--------------------------------------------------------
--  DDL for Index SYS_C00233221
--------------------------------------------------------

  CREATE UNIQUE INDEX "SYS_C00233221" ON "STARSIN" ("MOVIETITLE", "MOVIEYEAR", "STARNAME")
/
--------------------------------------------------------
--  Constraints for Table STARSIN
--------------------------------------------------------


  ALTER TABLE "STARSIN" ADD PRIMARY KEY ("MOVIETITLE", "MOVIEYEAR", "STARNAME") ENABLE;
/
  ALTER TABLE "STARSIN" ADD CONSTRAINT "GURANTEE_CHK" CHECK (GURANTEE >= (10000));
/
--------------------------------------------------------
--  Ref Constraints for Table STARSIN
--------------------------------------------------------

  ALTER TABLE "STARSIN" ADD FOREIGN KEY ("MOVIETITLE", "MOVIEYEAR")
	  REFERENCES "MOVIE" ("TITLE", "YEAR") ON DELETE CASCADE ENABLE
/
  ALTER TABLE "STARSIN" ADD FOREIGN KEY ("STARNAME")
	  REFERENCES "MOVIESTAR" ("NAME") ON DELETE CASCADE ENABLE
/

CREATE TABLE "CARTOON"
  (   "CARTOONTITLE" VARCHAR2(255), 
	"CARTOONYEAR" NUMBER(*,0),
  "VOICE" VARCHAR2(50)
  )
/
REM INSERTING into CARTOON
SET DEFINE OFF;
Insert into CARTOON (CARTOONTITLE, CARTOONYEAR, VOICE) values ('Little Mermaid',	2019, '박수연');
Insert into CARTOON (CARTOONTITLE, CARTOONYEAR, VOICE) values ('Little Mermaid',	2019, '조아라');
Insert into CARTOON (CARTOONTITLE, CARTOONYEAR, VOICE) values ('Little Mermaid',	2019, '손주원');
Insert into CARTOON (CARTOONTITLE, CARTOONYEAR, VOICE) values ('Little Mermaid',	2019, '문성민');
Insert into CARTOON (CARTOONTITLE, CARTOONYEAR, VOICE) values ('Little Mermaid',	2019, '홍혜정');
--
CREATE UNIQUE INDEX "SYS_C00233225" ON "CARTOON" ("CARTOONTITLE", "CARTOONYEAR","VOICE");
/
 ALTER TABLE "CARTOON" ADD FOREIGN KEY ("CARTOONTITLE", "CARTOONYEAR")
	  REFERENCES "MOVIE" ("TITLE", "YEAR") ON DELETE CASCADE ENABLE;
 /
  ALTER TABLE "CARTOON" ADD FOREIGN KEY ("VOICE")
	  REFERENCES "MOVIESTAR" ("NAME") ON DELETE CASCADE ENABLE;
 /
 -----movieexec의 배우자 moviestar의 name 참조

   ALTER TABLE "MOVIEEXEC" ADD FOREIGN KEY ("SPOUSENAME")
  REFERENCES "MOVIESTAR" ("NAME") ON DELETE CASCADE ENABLE
/
commit;
quit;
