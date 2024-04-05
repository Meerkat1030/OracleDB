-- 생성자 Oracle SQL Developer Data Modeler 19.2.0.182.1216
--   위치:        2019-09-19 18:13:20 KST
--   사이트:      Oracle Database 12cR2
--   유형:      Oracle Database 12cR2


drop type PEOPLE_INFO force;

drop type NUMBER_INFO force;

DROP TABLE assistant CASCADE CONSTRAINTS;

DROP TABLE department CASCADE CONSTRAINTS;

DROP TABLE lecture CASCADE CONSTRAINTS;

DROP TABLE lecture_room CASCADE CONSTRAINTS;

DROP TABLE listen CASCADE CONSTRAINTS;

DROP TABLE professor CASCADE CONSTRAINTS;

DROP TABLE student CASCADE CONSTRAINTS;

DROP TABLE subject CASCADE CONSTRAINTS;

CREATE OR REPLACE TYPE number_info AS OBJECT (
    home     VARCHAR2(13),
    cell     VARCHAR2(13),
    office   VARCHAR2(13)
) NOT FINAL;
/

CREATE OR REPLACE TYPE people_info AS OBJECT (
    name       VARCHAR2(30 CHAR),
    address    VARCHAR2(250 CHAR),
    "number"   number_info
) NOT FINAL;
/

CREATE TABLE assistant (
    assistant_number   NUMBER(10) NOT NULL,
    info               people_info,
    department_name    VARCHAR2(30 CHAR) NOT NULL
);

insert into assistant values (1,people_info('쯔위','서울 트둥1동',number_info('02-123-1234','010-1234-1234','051-234-5678')),'소프트웨어학과');
insert into assistant values (2,people_info('지효','서울 트둥2동',number_info('02-123-2345','010-1234-2345','051-444-4444')),'소프트웨어학과');
insert into assistant values (3,people_info('모모','서울 트둥3동',number_info('02-123-3456','010-1234-3456','051-666-6666')),'경영학과');
insert into assistant values (4,people_info('다현','서울 트둥4동',number_info('02-123-4567','010-1234-4567','051-555-5555')),'경영학과');
insert into assistant values (5,people_info('정연','서울 트둥5동',number_info('02-123-5678','010-1234-5678','051-888-8888')),'신학과');

ALTER TABLE assistant ADD CONSTRAINT assistant_pk PRIMARY KEY ( assistant_number );

CREATE TABLE department (
    name          VARCHAR2(30 CHAR) NOT NULL,
    dean_number   NUMBER(10) NOT NULL
);

CREATE UNIQUE INDEX department__idx ON
    department (
        dean_number
    ASC );

insert into department values ('소프트웨어학과',1);
insert into department values ('경영학과',3);
insert into department values ('신학과',5);


ALTER TABLE department ADD CONSTRAINT department_pk PRIMARY KEY ( name );

CREATE TABLE lecture (
    lecture_number           NUMBER(10) NOT NULL,
    lecture_subject_number   NUMBER(10) NOT NULL,
    lecture_room_number      NUMBER(10) NOT NULL,
    lecture_building_name    VARCHAR2(30 CHAR) NOT NULL,
    professor_no             NUMBER(10) NOT NULL,
    lecture_time             VARCHAR2(30 CHAR),
    lecture_credit           VARCHAR2(30 CHAR),
     lecture_name             VARCHAR2(30 CHAR)
);

insert into lecture values (1001,1000,629,'8관',1,'(월,1),(월,2),(월,3)','3학점','데이터베이스응용');
insert into lecture values (1002,1000,626,'8관',2,'(금,1),(금,2),(금,3)','3학점','데이터베이스응용');
insert into lecture values (2001,2000,418,'30관',3,'(수,6),(수,7)','2학점','콘텐츠사업과마케팅');
insert into lecture values (2002,2000,418,'30관',4,'(수,8),(수,9)','2학점','콘텐츠사업과마케팅');
insert into lecture values (3001,3000,418,'30관',5,'(월,7)','1학점','경성채플');

ALTER TABLE lecture ADD CONSTRAINT lecture_pk PRIMARY KEY ( lecture_number );

CREATE TABLE lecture_room (
    building_name   VARCHAR2(30 CHAR) NOT NULL,
    floor           NUMBER(10),
    room_number     NUMBER(10) NOT NULL,
    max             NUMBER(10)
);

insert into lecture_room values('8관',6,629,30);
insert into lecture_room values('8관',6,628,30);
insert into lecture_room values('8관',6,626,50);
insert into lecture_room values('30관',4,418,50);

ALTER TABLE lecture_room ADD CONSTRAINT lecture_room_pk PRIMARY KEY ( room_number,
                                                                      building_name );

CREATE TABLE listen (
    listen_student_number   NUMBER(10) NOT NULL,
    listen_lecture_number   NUMBER(10) NOT NULL
);

insert into listen values(2017948072,1001);
insert into listen values(2017948040,1001);
insert into listen values(2017948090,1001);
insert into listen values(2017948054,1002);
insert into listen values(2017222222,1002);
insert into listen values(2017111111,1002);
insert into listen values(76004888,2001);
insert into listen values(2019000000,2001);
insert into listen values(2019111111,2001);
insert into listen values(2019222222,2002);
insert into listen values(2017948072,2002);
insert into listen values(2017948040,2002);
insert into listen values(2017948090,3001);
insert into listen values(2017948054,3001);
insert into listen values(2017222222,3001);

ALTER TABLE listen ADD CONSTRAINT listen_pk PRIMARY KEY ( listen_student_number,
                                                          listen_lecture_number );

CREATE TABLE professor (
    info             people_info,
    staff_number     NUMBER(10) NOT NULL,
    office_address   VARCHAR2(250 CHAR),
    department       VARCHAR2(30 CHAR) NOT NULL,
    major_field      VARCHAR2(30 CHAR) NOT NULL
);

insert into professor values (people_info('홍석희','부산시 남구 대연동',number_info('051-123-4567','010-1111-1111','051-234-5678')),1,'경성대학교 공대 601호','소프트웨어학과','Database');
insert into professor values (people_info('김진천','부산시 북구 화명동',number_info('051-111-1111','010-3333-3333','051-444-4444')),2,'경성대학교 공대 602호','소프트웨어학과','Os');
insert into professor values (people_info('홍길동','양산시 서들로179',number_info('055-222-2222','010-5555-5555','051-666-6666')),3,'경성대학교 30관 301호','경영학과','도술');
insert into professor values (people_info('이상호','서울시 영등포구',number_info('02-333-3333','010-7777-7777','051-555-5555')),4,'경성대학교 30관 101호','경영학과','마케팅');
insert into professor values (people_info('신상언','양산시 범어리',number_info('055-777-7777','010-8888-8888','051-888-8888')),5,'경성대학교 29관 101호','신학과','선교');

ALTER TABLE professor ADD CONSTRAINT professor_pk PRIMARY KEY ( staff_number );

CREATE TABLE student (
    info             people_info,
    student_number   NUMBER(10) NOT NULL,
    classification   VARCHAR2(30) NOT NULL,
    major            VARCHAR2(30 CHAR) NOT NULL,
    minor            VARCHAR2(30 CHAR)
);

ALTER TABLE student
    ADD CHECK ( classification IN (
        'PhD',
        'faculty',
        'master',
        '박사',
        '석사',
        '학부'
    ) );
    
insert into student values (people_info('이재홍','양산 반도유보라3차',number_info('055-234-6789','010-2345-6789','')),2017948072,'학부','소프트웨어학과','');
insert into student values (people_info('박수연','양산 범어주공아파트',number_info('055-234-5678','010-2345-5678','')),2017948040,'학부','소프트웨어학과','');
insert into student values (people_info('조아라','양산 대방노블랜드7차',number_info('055-234-4567','010-2345-4567','')),2017948090,'학부','소프트웨어학과','');
insert into student values (people_info('손주원','경성대 어딘가 2동',number_info('051-234-3456','010-2345-3456','')),2017948054,'학부','소프트웨어학과','');
insert into student values (people_info('문성민','부산역 CU',number_info('051-234-2345','010-2345-2345','')),2017222222,'학부','경영학과','');
insert into student values (people_info('홍혜정','경성대 어딘가1동',number_info('051-234-1234','010-2345-1234','')),2017111111,'학부','경영학과','');
insert into student values (people_info('최인호','파주 어딘가동',number_info('01-000-0000','010-0000-0000','')),76004888,'학부','신학과','');
insert into student values (people_info('나연','서울 트둥8동',number_info('02-123-8901','010-1234-8901','')),2019000000,'학부','신학과','');
insert into student values (people_info('사나','서울 트둥7동',number_info('02-123-7890','010-1234-7890','')),2019111111,'학부','신학과','');
insert into student values (people_info('미나','서울 트둥6동',number_info('02-123-6789','010-1234-6789','')),2019222222,'학부','경영학과','');

ALTER TABLE student ADD CONSTRAINT student_pk PRIMARY KEY ( student_number );

CREATE TABLE subject (
    subject_number   NUMBER(10) NOT NULL,
    assistant_no     NUMBER(10) NOT NULL,
    name             VARCHAR2(30 CHAR)
);

insert into subject values (1000,1,'데이터베이스응용');
insert into subject values (2000,3,'콘텐츠사업과마케팅');
insert into subject values (3000,5,'경성채플');


ALTER TABLE subject ADD CONSTRAINT subject_pk PRIMARY KEY ( subject_number );

ALTER TABLE professor
    ADD CONSTRAINT belong FOREIGN KEY ( department )
        REFERENCES department ( name );

ALTER TABLE department
    ADD CONSTRAINT dean FOREIGN KEY ( dean_number )
        REFERENCES professor ( staff_number );

ALTER TABLE assistant
    ADD CONSTRAINT department_belong FOREIGN KEY ( department_name )
        REFERENCES department ( name );

ALTER TABLE listen
    ADD CONSTRAINT listen_lecture_fk FOREIGN KEY ( listen_lecture_number )
        REFERENCES lecture ( lecture_number );

ALTER TABLE listen
    ADD CONSTRAINT listen_student_fk FOREIGN KEY ( listen_student_number )
        REFERENCES student ( student_number );

ALTER TABLE student
    ADD CONSTRAINT major FOREIGN KEY ( major )
        REFERENCES department ( name );

ALTER TABLE student
    ADD CONSTRAINT minor FOREIGN KEY ( minor )
        REFERENCES department ( name );

ALTER TABLE lecture
    ADD CONSTRAINT relation_12 FOREIGN KEY ( lecture_room_number,
                                             lecture_building_name )
        REFERENCES lecture_room ( room_number,
                                  building_name );

ALTER TABLE lecture
    ADD CONSTRAINT relation_13 FOREIGN KEY ( professor_no )
        REFERENCES professor ( staff_number );

ALTER TABLE subject
    ADD CONSTRAINT subject_belong FOREIGN KEY ( assistant_no )
        REFERENCES assistant ( assistant_number );

ALTER TABLE lecture
    ADD CONSTRAINT subject_of FOREIGN KEY ( lecture_subject_number )
        REFERENCES subject ( subject_number );

CREATE OR REPLACE VIEW Dept_Info ( name, "Count_staff_Number", "Count_assistant_Number" ) AS
SELECT
    department.name,
    COUNT(distinct professor.staff_number) AS "Count_staff_Number",
    COUNT(distinct assistant.assistant_number) AS "Count_assistant_Number"
FROM
    department,
    professor,
    assistant
WHERE
    professor.staff_number = department.dean_Number
    AND department.name = assistant.department_name
GROUP BY
    department.name
HAVING
    COUNT(professor.staff_number) >= 2 
;

CREATE OR REPLACE VIEW Prof_of_CS ( office_Address, name, "Count_lecture_Number" ) AS
SELECT
    p.office_address   AS "office_Address",
    p.info.name    AS "name",
    COUNT(lecture.lecture_number) AS "Count_lecture_Number"
FROM
    professor p
    INNER JOIN lecture ON p.staff_number = lecture.professor_no
WHERE
    p.department = '소프트웨어학과'
GROUP BY
    p.office_address,
    p.info.name 
;

CREATE OR REPLACE VIEW Special_Lectures ( lecture_subject_number, lecture_room_number, lecture_building_name, lecture_time ) AS
SELECT
    lecture.lecture_room_number,
    lecture.lecture_building_name,
    lecture.lecture_time,
    lecture.lecture_name
FROM
    lecture
WHERE
    ( lecture.lecture_time LIKE '%(월,6)%' )
    OR ( lecture.lecture_time LIKE '%(월,7)%' )
    OR ( lecture.lecture_time LIKE '%(월,8)%' )
    OR ( lecture.lecture_time LIKE '%(월,9)%' )
    OR ( lecture.lecture_time LIKE '%(수,6)%' )
    OR ( lecture.lecture_time LIKE '%(수,7)%' )
    OR ( lecture.lecture_time LIKE '%(수,8)%' )
    OR ( lecture.lecture_time LIKE '%(수,9)%' )
    OR ( lecture.lecture_time LIKE '%(금,6)%' )
    OR ( lecture.lecture_time LIKE '%(금,7)%' )
    OR ( lecture.lecture_time LIKE '%(금,8)%' )
    OR ( lecture.lecture_time LIKE '%(금,9)%' ) 
;



-- Oracle SQL Developer Data Modeler 요약 보고서: 
-- 
-- CREATE TABLE                             8
-- CREATE INDEX                             1
-- ALTER TABLE                             20
-- CREATE VIEW                              3
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   2
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
