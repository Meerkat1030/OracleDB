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

ALTER TABLE assistant ADD CONSTRAINT assistant_pk PRIMARY KEY ( assistant_number );

CREATE TABLE department (
    name          VARCHAR2(30 CHAR) NOT NULL,
    dean_number   NUMBER(10) NOT NULL
);

CREATE UNIQUE INDEX department__idx ON
    department (
        dean_number
    ASC );

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

ALTER TABLE lecture ADD CONSTRAINT lecture_pk PRIMARY KEY ( lecture_number );

CREATE TABLE lecture_room (
    building_name   VARCHAR2(30 CHAR) NOT NULL,
    floor           NUMBER(10),
    room_number     NUMBER(10) NOT NULL,
    max             NUMBER(10)
);

ALTER TABLE lecture_room ADD CONSTRAINT lecture_room_pk PRIMARY KEY ( room_number,
                                                                      building_name );

CREATE TABLE listen (
    listen_student_number   NUMBER(10) NOT NULL,
    listen_lecture_number   NUMBER(10) NOT NULL
);

ALTER TABLE listen ADD CONSTRAINT listen_pk PRIMARY KEY ( listen_student_number,
                                                          listen_lecture_number );

CREATE TABLE professor (
    info             people_info,
    staff_number     NUMBER(10) NOT NULL,
    office_address   VARCHAR2(250 CHAR),
    department       VARCHAR2(30 CHAR) NOT NULL,
    major_field      VARCHAR2(30 CHAR) NOT NULL
);

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

ALTER TABLE student ADD CONSTRAINT student_pk PRIMARY KEY ( student_number );

CREATE TABLE subject (
    subject_number   NUMBER(10) NOT NULL,
    assistant_no     NUMBER(10) NOT NULL,
    name             VARCHAR2(30 CHAR)
);

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
