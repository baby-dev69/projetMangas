-- ---------  Base ORACLE MANGAS ----------------------------
-- --------- Table : User  ----------------------------------------

create table USER
(
   IDUSER            	number(3) not null,
   EMAIL                varchar2(100),
   PASSWORD             varchar2(100),
   NAME                 varchar2(20),
   constraint PK_USER primary key (IDUSER),
   constraint AK_EMAIL UNIQUE(EMAIL) 

);

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

-- ------------- BASE MANGAS -----------------------------------------
-- --------- INSERT USER ------------

INSERT INTO USER VALUES(1,"test@gmail.com","123bonjour","Jean");
INSERT INTO USER VALUES(2,"toto@gmail.com","123bonsoir","Pierre");
INSERT INTO USER VALUES(3,"tata@gmail.com","123salut","Huguette");

-- --------- INSERT LIVRE ------------

INSERT INTO LIVRE VALUES(1,1,1,'Naruto','naruto.jpg');
INSERT INTO LIVRE VALUES(2,1,2,'One Piece','onePiece.jpg');
INSERT INTO LIVRE VALUES(3,2,3,'Bleach','bleach.jpg');
INSERT INTO LIVRE VALUES(4,2,4,'Dragon Ball Z','dragonBallZ.jpg');
INSERT INTO LIVRE VALUES(5,2,5,'One Punch Man','onePunchMan.jpg');
 
-- --------- INSERT AUTEUR ------------

INSERT INTO AUTEUR VALUES(1,'Masashi','Kishimoto');
INSERT INTO AUTEUR VALUES(2,'Eiichir','Oda');
INSERT INTO AUTEUR VALUES(3,'Tite','Kubo');
INSERT INTO AUTEUR VALUES(4,'Akira','Toriyama');
INSERT INTO AUTEUR VALUES(5,'Yusuke ','Murata');


-- --------- INSERT GENRE ------------

INSERT INTO GENRE VALUES(1, 'Aventure');
INSERT INTO GENRE VALUES(2, 'Action');