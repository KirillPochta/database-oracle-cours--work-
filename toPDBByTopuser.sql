create user Topuser  IDENTIFIED by pass;
grant create table,INSERT ANY TABLE,UPDATE ANY TABLE,DELETE ANY TABLE,DROP ANY PROCEDURE,CREATE ANY PROCEDURE,ALTER ANY PROCEDURE, EXECUTE ANY PROCEDURE,ALTER SESSION,CREATE SESSION,CREATE TABLESPACE,ALTER TABLESPACE,DROP TABLESPACE,CREATE SEQUENCE,DROP ANY SEQUENCE,ALTER ANY SEQUENCE to Topuser;
ALTER USER Topuser quota unlimited on TBS_PERM_KINO;

ALTER PLUGGABLE DATABASE ALL OPEN;

--CREATE TABLESPACE 
CREATE TABLESPACE TBS_PERM_KINO
  DATAFILE 'Z:\scripts\tbs_perm.dat' 
    SIZE 10M
    REUSE
    AUTOEXTEND ON NEXT 10M MAXSIZE 1000M;
    
--creation of all table
CREATE sequence DIR_ID_SEQ;
create table DIRECTORS (
ID_DIR INTEGER DEFAULT DIR_ID_SEQ.NEXTVAL NOT NULL,
DIRECTOR_CODE INTEGER DEFAULT DIR_ID_SEQ.NEXTVAL NOT NULL,
SURNAME VARCHAR2(200) NOT NULL,
NAME VARCHAR2(200) NOT NULL,
COUNTRY_CODE INTEGER,
CONSTRAINT  PK_ID_DIR PRIMARY KEY (ID_DIR)
)
TABLESPACE TBS_PERM_KINO;
-------------
CREATE sequence FILM_ID_SEQ;
CREATE TABLE FILMS (
ID_FILM INTEGER DEFAULT FILM_ID_SEQ.NEXTVAL NOT NULL,
FILM_CODE INTEGER NOT NULL,
FILM VARCHAR2(200) NOT NULL UNIQUE,
GENRE_CODE INTEGER NOT NULL,
DIRECTOR_CODE INTEGER NOT NULL,
YEAROFRELEAS DATE,
CONSTRAINT  PK_ID_FILM PRIMARY KEY (ID_FILM)
)
TABLESPACE TBS_PERM_KINO;
---------------
CREATE sequence COUNTRY_ID_SEQ;
CREATE TABLE COUNTRY (
ID_COUNTRY INTEGER DEFAULT COUNTRY_ID_SEQ.NEXTVAL NOT NULL,
NAME VARCHAR2(200) NOT NULL,
COUNTRY_CODE INTEGER,
CONSTRAINT  PK_ID_COUNTRY PRIMARY KEY (ID_COUNTRY)
)
TABLESPACE TBS_PERM_KINO;
---------------
CREATE sequence GENRE_ID_SEQ;
CREATE TABLE GENRE (
ID_GENRE INTEGER DEFAULT GENRE_ID_SEQ.NEXTVAL NOT NULL,
GENRE_CODE INTEGER DEFAULT GENRE_ID_SEQ.NEXTVAL NOT NULL,
NAMEOFGENRE VARCHAR2(200) NOT NULL,
CONSTRAINT  PK_ID_GENRE PRIMARY KEY (ID_GENRE)
)
TABLESPACE TBS_PERM_KINO;
---------------
CREATE sequence SESSION_ID_SEQ;
CREATE TABLE SESSIONF(
ID_SESSION INTEGER DEFAULT SESSION_ID_SEQ.NEXTVAL NOT NULL,
FILM_CODE INTEGER NOT NULL,
NAMEOFGENRE VARCHAR2(200) NOT NULL,
HALL_CODE INTEGER NOT NULL,
NUMBEROFFREEPLACES INTEGER NOT NULL,
ALL_PLACES INTEGER NOT NULL,
COST INTEGER NOT NULL,
DATA_OF_SESSION DATE,
CONSTRAINT  PK_ID_SESSION PRIMARY KEY (ID_SESSION)
)
TABLESPACE TBS_PERM_KINO;
---------------
CREATE sequence HALL_ID_SEQ;
CREATE TABLE HALL (
ID_HALL INTEGER DEFAULT HALL_ID_SEQ.NEXTVAL NOT NULL,
HALL_CODE INTEGER NOT NULL,
NAME VARCHAR2(200) NOT NULL,
NUMBEROFLINES INTEGER NOT NULL,
NUMBEROFPLACES INTEGER NOT NULL,
CONSTRAINT  PK_ID_HALL PRIMARY KEY (HALL_CODE)
)
TABLESPACE TBS_PERM_KINO;
---------------
CREATE sequence CLIENT_ID_SEQ;
CREATE TABLE CLIENTS (
ID_CLIENT INTEGER DEFAULT CLIENT_ID_SEQ.NEXTVAL NOT NULL,
CNUMBER INTEGER NOT NULL,
NAME VARCHAR2(200) NOT NULL,
FILM VARCHAR2(200) NOT NULL,
BOUGHT_TICKETS INTEGER NOT NULL,
CONSTRAINT  PK_ID_CLIENT PRIMARY KEY (ID_CLIENT)
)
TABLESPACE TBS_PERM_KINO;
---------------
CREATE sequence ORDER_ID_SEQ;
CREATE TABLE ORDERS (
ID_ORDER INT DEFAULT ORDER_ID_SEQ.NEXTVAL NOT NULL,
CLIENT_CODE INTEGER DEFAULT ORDER_ID_SEQ.NEXTVAL NOT NULL,
SESSION_CODE INTEGER NOT NULL,
CLIENTNAME VARCHAR2(200) NOT NULL,
COUNT_OF_TICKETS INTEGER NOT NULL,
CONSTRAINT  PK_ID_ORD PRIMARY KEY (ID_ORDER)
)
TABLESPACE TBS_PERM_KINO;
--------------- ADD FOREIGN KEYS
alter table FILMS add constraint FK_GENRE_CODE_REF_ID_GENRE foreign key (GENRE_CODE) references GENRE (ID_GENRE) ON DELETE CASCADE;
alter table FILMS add constraint FR_DIR_CODE_REF_ID_DIR foreign key (DIRECTOR_CODE) references DIRECTORS (ID_DIR) ON DELETE CASCADE;
alter table SESSIONF add constraint FK_FILM_CODE_REF_ID_FILM foreign key (FILM_CODE) references FILMS (ID_FILM) ON DELETE CASCADE;
alter table SESSIONF add constraint FK_HALL_CODE_REF_HALL_CODE foreign key (HALL_CODE) references HALL (HALL_CODE) ON DELETE CASCADE;
ALTER TABLE DIRECTORS ADD CONSTRAINT FK_COUNTRY_CODE_REF_ID_COUNTRY foreign key (COUNTRY_CODE) REFERENCES COUNTRY (ID_COUNTRY) ON DELETE CASCADE;
alter table ORDERS add constraint FK_CLIENT_CODE_REF_ID_CLIENT foreign key (CLIENT_CODE) references CLIENTS (ID_CLIENT) ON DELETE CASCADE;
alter table ORDERS add constraint FK_ID_SESS_REF_ID_SESS foreign key (SESSION_CODE) references SESSIONF (ID_SESSION) ON DELETE CASCADE;
SELECT *FROM ALL_CONS_COLUMNS WHERE TABLE_NAME='DIRECTORS';
-------------- DROP ALL OBJECT
DROP TABLE HALL;
DROP TABLE SESSIONF;
DROP TABLE GENRE;
DROP TABLE COUNTRY;
DROP TABLE DIRECTORS;
DROP TABLE FILMS;
DROP TABLE ORDERS;
DROP TABLE CLIENTS;
DROP SEQUENCE CLIENT_ID_SEQ;
DROP SEQUENCE COUNTRY_ID_SEQ;
DROP SEQUENCE DIR_ID_SEQ;
DROP SEQUENCE FILM_ID_SEQ;
DROP SEQUENCE GENRE_ID_SEQ;
DROP SEQUENCE HALL_ID_SEQ;
DROP SEQUENCE ORDER_ID_SEQ;
DROP SEQUENCE SESSION_ID_SEQ;
DROP TABLESPACE TBS_PERM_KINO;
DROP PROCEDURE UpdateDirector;
DROP PROCEDURE DeleteDirector;
DROP PROCEDURE AddNewDirector;
DROP PROCEDURE DeleteCOUNTRY;
COMMIT;
SELECT *FROM ALL_SEQUENCES WHERE SEQUENCE_OWNER LIKE '%TOP%';


SELECT *FROM DICT WHERE TABLE_NAME LIKE '%SEQ%';






