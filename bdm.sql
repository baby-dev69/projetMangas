-- ---------  Base ORACLE MANGAS ----------------------------
-- --------- Table : Livre  ----------------------------------------

create table LIVRE
(
   IDLIVRE            	number(3) not null,
   IDGENRE              number(3) not null,
   IDAUTEUR             number(3) not null,
   NOMLIVRE             varchar2(20),
   COUVLIVRE            varchar2(20),
   constraint PK_LIVRE primary key (IDLIVRE),
   constraint FK_AUTEUR foreign key (IDAUTEUR) references AUTEUR (IDAUTEUR),
   constraint FK_GENRE foreign key (IDGENRE) references GENRE (IDGENRE)


);

-- -------- Table : AUTEUR ------------------------------------------

create table AUTEUR
(
   IDAUTEUR    	        number(3) not null,
   NOMAUTEUR              varchar2(20),
   PRENOMAUTEUR           varchar2(20),
   constraint PK_AUTEUR primary key (IDAUTEUR)
);

-- -------- Table : GENRE -----------------------------

create table GENRE
(
   IDGENRE    	           number(3) not null,
   LIBELLE                varchar2(20),
   constraint PK_GENRE primary key (IDGENRE)
);

-- ------------- BASE CAPITAINERIE -----------------------------------------
-- --------- INSERT LIVRE ------------

INSERT INTO LIVRE VALUES(1,1,1,'Naruto','xxxx.png');
INSERT INTO LIVRE VALUES(2,1,2,'One Piece','xxxx.png');
INSERT INTO LIVRE VALUES(3,2,3,'Bleach','xxxx.png');
INSERT INTO LIVRE VALUES(4,2,4,'Dragon Ball Z','xxxx.png');
INSERT INTO LIVRE VALUES(5,2,5,'One Punch Man','xxxx.png');
 
-- --------- INSERT AUTEUR ------------

INSERT INTO AUTEUR VALUES(1,'Masashi','Kishimoto');
INSERT INTO AUTEUR VALUES(2,'Eiichir','Oda');
INSERT INTO AUTEUR VALUES(3,'Tite','Kubo');
INSERT INTO AUTEUR VALUES(4,'Akira','Toriyama');
INSERT INTO AUTEUR VALUES(5,'Yusuke ','Murata');


-- --------- INSERT GENRE ------------

INSERT INTO GENRE VALUES(1, 'Aventure');
INSERT INTO GENRE VALUES(2, 'Action');