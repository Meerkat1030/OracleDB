-- 생성자 Oracle SQL Developer Data Modeler 19.2.0.182.1216
--   위치:        2019-09-12 02:08:32 KST
--   사이트:      Oracle Database 12cR2
--   유형:      Oracle Database 12cR2



DROP TABLE address CASCADE CONSTRAINTS;

DROP TABLE employee CASCADE CONSTRAINTS;

DROP TABLE manufacturer CASCADE CONSTRAINTS;

DROP TABLE member CASCADE CONSTRAINTS;

DROP TABLE "Number" CASCADE CONSTRAINTS;

DROP TABLE "order" CASCADE CONSTRAINTS;

DROP TABLE product CASCADE CONSTRAINTS;

DROP TABLE product_board CASCADE CONSTRAINTS;

DROP TABLE product_management CASCADE CONSTRAINTS;

DROP TABLE product_post CASCADE CONSTRAINTS;

DROP TABLE shipping_board CASCADE CONSTRAINTS;

DROP TABLE shipping_management CASCADE CONSTRAINTS;

DROP TABLE shipping_post CASCADE CONSTRAINTS;

DROP TABLE supply CASCADE CONSTRAINTS;

CREATE TABLE address (
    address        VARCHAR2(250 CHAR) NOT NULL,
    member_id      VARCHAR2(30 CHAR) NOT NULL,
    address_type   VARCHAR2(30) NOT NULL
);

ALTER TABLE address
    ADD CHECK ( address_type IN (
        'home',
        'rectal',
        '직장',
        '집'
    ) );

ALTER TABLE address ADD CONSTRAINT address_pk PRIMARY KEY ( address,
                                                            address_type );

CREATE TABLE employee (
    emp_no         CHAR(13) NOT NULL,
    id             VARCHAR2(30 CHAR) NOT NULL,
    email          VARCHAR2(30 CHAR),
    department     VARCHAR2(30 CHAR),
    phone_number   CHAR(13),
    address        VARCHAR2(250 CHAR)
);

ALTER TABLE employee ADD CONSTRAINT employee_pk PRIMARY KEY ( emp_no );

CREATE TABLE manufacturer (
    name           VARCHAR2(20 CHAR) NOT NULL,
    phone_number   CHAR(13),
    address        VARCHAR2(250 CHAR)
);

ALTER TABLE manufacturer ADD CONSTRAINT manufacturer_pk PRIMARY KEY ( name );

CREATE TABLE member (
    id      VARCHAR2(30 CHAR) NOT NULL,
    name    VARCHAR2(20 CHAR),
    email   VARCHAR2(30 CHAR)
);

ALTER TABLE member ADD CONSTRAINT member_pk PRIMARY KEY ( id );

CREATE TABLE "Number" (
    "number"      CHAR(13) NOT NULL,
    member_id     VARCHAR2(30 CHAR) NOT NULL,
    number_type   VARCHAR2(30) NOT NULL
);

ALTER TABLE "Number"
    ADD CHECK ( number_type IN (
        'home',
        'rectal',
        '직장',
        '집'
    ) );

ALTER TABLE "Number" ADD CONSTRAINT number_pk PRIMARY KEY ( "number",
                                                            number_type );

CREATE TABLE "order" (
    order_member_id    VARCHAR2(30 CHAR) NOT NULL,
    order_product_no   CHAR(13) NOT NULL,
    order_date         DATE NOT NULL,
    shipping_address   VARCHAR2(250 CHAR)
);

ALTER TABLE "order"
    ADD CHECK ( order_date >= DATE '1990-01-01'
                AND order_date <= DATE '2019-09-11' );

ALTER TABLE "order" ADD CONSTRAINT order_pk PRIMARY KEY ( order_member_id,
                                                          order_product_no );

CREATE TABLE product (
    product_no        CHAR(13) NOT NULL,
    product_name      VARCHAR2(20 CHAR) NOT NULL,
    price             NUMBER(20),
    available_stock   CHAR(13)
);

ALTER TABLE product ADD CONSTRAINT product_pk PRIMARY KEY ( product_no );

CREATE TABLE product_board (
    publish_no     CHAR(13) NOT NULL,
    title          VARCHAR2(250 CHAR),
    writer         VARCHAR2(20 CHAR),
    publish_date   DATE,
    contents       CLOB,
    maneger_no     CHAR(13) NOT NULL
);

ALTER TABLE product_board
    ADD CHECK ( publish_date >= DATE '1990-01-01'
                AND publish_date <= DATE '2019-09-11' );

CREATE UNIQUE INDEX product_board__idx ON
    product_board (
        maneger_no
    ASC );

ALTER TABLE product_board ADD CONSTRAINT shipping_board_pk PRIMARY KEY ( publish_no );

CREATE TABLE product_management (
    emp_number        CHAR(13) NOT NULL,
    product_post_no   CHAR(13) NOT NULL,
    reply             CLOB
);

ALTER TABLE product_management ADD CONSTRAINT product_management_pk PRIMARY KEY ( product_post_no );

CREATE TABLE product_post (
    member_id         VARCHAR2(30 CHAR) NOT NULL,
    product_post_no   CHAR(13) NOT NULL
);

ALTER TABLE product_post ADD CONSTRAINT product_post_pk PRIMARY KEY ( product_post_no );

CREATE TABLE shipping_board (
    publish_no     CHAR(13) NOT NULL,
    title          VARCHAR2(250 CHAR),
    writer         VARCHAR2(20 CHAR),
    publish_date   DATE,
    contents       CLOB,
    manager_no     CHAR(13) NOT NULL
);

ALTER TABLE shipping_board
    ADD CHECK ( publish_date >= DATE '1990-01-01'
                AND publish_date <= DATE '2019-09-11' );

CREATE UNIQUE INDEX shipping_board__idx ON
    shipping_board (
        manager_no
    ASC );

ALTER TABLE shipping_board ADD CONSTRAINT shipping_board_pkv1 PRIMARY KEY ( publish_no );

CREATE TABLE shipping_management (
    emp_number         CHAR(13) NOT NULL,
    reply              CLOB,
    shipping_post_no   CHAR(13) NOT NULL
);

ALTER TABLE shipping_management ADD CONSTRAINT management_pk PRIMARY KEY ( shipping_post_no );

CREATE TABLE shipping_post (
    shipping_post_no   CHAR(13) NOT NULL,
    member_id          VARCHAR2(30 CHAR) NOT NULL
);

ALTER TABLE shipping_post ADD CONSTRAINT shipping_post_pk PRIMARY KEY ( shipping_post_no );

CREATE TABLE supply (
    supply_product_no          CHAR(13) NOT NULL,
    supply_manufacturer_name   VARCHAR2(20 CHAR) NOT NULL
);

ALTER TABLE supply ADD CONSTRAINT supply_pk PRIMARY KEY ( supply_product_no,
                                                          supply_manufacturer_name );

ALTER TABLE address
    ADD CONSTRAINT mem_addr FOREIGN KEY ( member_id )
        REFERENCES member ( id );

ALTER TABLE "Number"
    ADD CONSTRAINT mem_num FOREIGN KEY ( member_id )
        REFERENCES member ( id );

ALTER TABLE "order"
    ADD CONSTRAINT order_member_fk FOREIGN KEY ( order_member_id )
        REFERENCES member ( id );

ALTER TABLE "order"
    ADD CONSTRAINT order_product_fk FOREIGN KEY ( order_product_no )
        REFERENCES product ( product_no );

ALTER TABLE product_board
    ADD CONSTRAINT product_administrate FOREIGN KEY ( maneger_no )
        REFERENCES employee ( emp_no );

ALTER TABLE product_management
    ADD CONSTRAINT product_management FOREIGN KEY ( emp_number )
        REFERENCES employee ( emp_no );

ALTER TABLE product_post
    ADD CONSTRAINT product_post FOREIGN KEY ( member_id )
        REFERENCES member ( id );

ALTER TABLE product_management
    ADD CONSTRAINT product_reply FOREIGN KEY ( product_post_no )
        REFERENCES product_post ( product_post_no );

ALTER TABLE product_post
    ADD CONSTRAINT relation_12 FOREIGN KEY ( product_post_no )
        REFERENCES product_board ( publish_no );

ALTER TABLE shipping_post
    ADD CONSTRAINT relation_8 FOREIGN KEY ( shipping_post_no )
        REFERENCES shipping_board ( publish_no );

ALTER TABLE shipping_board
    ADD CONSTRAINT shipping_administrate FOREIGN KEY ( manager_no )
        REFERENCES employee ( emp_no );

ALTER TABLE shipping_management
    ADD CONSTRAINT shipping_management FOREIGN KEY ( emp_number )
        REFERENCES employee ( emp_no );

ALTER TABLE shipping_post
    ADD CONSTRAINT shipping_post FOREIGN KEY ( member_id )
        REFERENCES member ( id );

ALTER TABLE shipping_management
    ADD CONSTRAINT shipping_reply FOREIGN KEY ( shipping_post_no )
        REFERENCES shipping_post ( shipping_post_no );

ALTER TABLE supply
    ADD CONSTRAINT supply_manufacturer_fk FOREIGN KEY ( supply_manufacturer_name )
        REFERENCES manufacturer ( name );

ALTER TABLE supply
    ADD CONSTRAINT supply_product_fk FOREIGN KEY ( supply_product_no )
        REFERENCES product ( product_no );



-- Oracle SQL Developer Data Modeler 요약 보고서: 
-- 
-- CREATE TABLE                            14
-- CREATE INDEX                             2
-- ALTER TABLE                             35
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
