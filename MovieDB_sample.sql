-- 생성자 Oracle SQL Developer Data Modeler 19.2.0.182.1216
--   위치:        2019-09-09 23:37:40 KST
--   사이트:      Oracle Database 12cR2
--   유형:      Oracle Database 12cR2



DROP TABLE movie CASCADE CONSTRAINTS;

DROP TABLE movieexec CASCADE CONSTRAINTS;

DROP TABLE moviestar CASCADE CONSTRAINTS;

DROP TABLE starsin CASCADE CONSTRAINTS;

DROP TABLE studio CASCADE CONSTRAINTS;

CREATE TABLE movie(
    title        VARCHAR2(256)NOT NULL,
    year         NUMBER(4)NOT NULL,
    length       NUMBER NOT NULL,
    filmtype     CHAR(5),
    studioname   VARCHAR2(50)NOT NULL
);

ALTER TABLE movie ADD CHECK(year BETWEEN 1900 AND 2019);

ALTER TABLE movie ADD CHECK(length BETWEEN 50 AND 300);

ALTER TABLE movie
    ADD CHECK(filmtype IN(
        'f',
        't'
    ));

ALTER TABLE movie ADD CONSTRAINT movie_pk PRIMARY KEY(title,
                                                      year);

CREATE TABLE movieexec(
    certno      NUMBER(5)NOT NULL,
    address     VARCHAR2(250),
    networth    NUMBER(12),
    birthdate   DATE
);

ALTER TABLE movieexec
    ADD CHECK(birthdate > DATE '1900-01-01'
              AND birthdate < DATE '2018-12-31');

ALTER TABLE movieexec ADD CONSTRAINT movieexec_pk PRIMARY KEY(certno);

CREATE TABLE moviestar(
    name        VARCHAR2(50)NOT NULL,
    address     VARCHAR2(250),
    gender      CHAR(6),
    birthdate   DATE
);

ALTER TABLE moviestar
    ADD CHECK(gender IN(
        'female',
        'male'
    ));

ALTER TABLE moviestar ADD CONSTRAINT moviestar_pk PRIMARY KEY(name);

CREATE TABLE starsin(
    movietitle   VARCHAR2(256)NOT NULL,
    movieyear    NUMBER(4)NOT NULL,
    starname     VARCHAR2(50)NOT NULL,
    gurantee     NUMBER(10)
);

ALTER TABLE starsin ADD CHECK(movieyear BETWEEN 1900 AND 2019);

ALTER TABLE starsin
    ADD CONSTRAINT starsin_pk PRIMARY KEY(movietitle,
                                          movieyear,
                                          starname);

CREATE TABLE studio(
    name      VARCHAR2(50)NOT NULL,
    address   VARCHAR2(250),
    presno    NUMBER(5)
);

CREATE UNIQUE INDEX studio__idx ON
    studio(
        presno
    ASC);

ALTER TABLE studio ADD CONSTRAINT studio_pk PRIMARY KEY(name);

ALTER TABLE movie
    ADD CONSTRAINT owns FOREIGN KEY(studioname)
        REFERENCES studio(name);

ALTER TABLE studio
    ADD CONSTRAINT run FOREIGN KEY(presno)
        REFERENCES movieexec(certno);

ALTER TABLE starsin
    ADD CONSTRAINT starsin_movie_fk FOREIGN KEY(movietitle,
                                                movieyear)
        REFERENCES movie(title,
                         year);

ALTER TABLE starsin
    ADD CONSTRAINT starsin_moviestar_fk FOREIGN KEY(starname)
        REFERENCES moviestar(name);



-- Oracle SQL Developer Data Modeler 요약 보고서: 
-- 
-- CREATE TABLE                             5
-- CREATE INDEX                             1
-- ALTER TABLE                             15
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
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
