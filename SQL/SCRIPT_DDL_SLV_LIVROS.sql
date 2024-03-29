/* 
Relation Database e SQL
Checkpoint #05 Segundo Semestre

RM 553653 - Charles Eduardo dos Santos

*/

-- 1)

/* DROP TABLE T_SLV_CATEGORIA CASCADE CONSTRAINTS; */
CREATE TABLE T_SLV_CATEGORIA (
    CD_CATEGORIA        NUMBER(3)       NOT NULL,
    DS_SIGLA_CATEGORIA  CHAR(3)         NOT NULL,
    DS_CATEGORIA        VARCHAR2(30)    NOT NULL
);
ALTER TABLE T_SLV_CATEGORIA ADD CONSTRAINT PK_SLV_CATEGORIA PRIMARY KEY (CD_CATEGORIA);
ALTER TABLE T_SLV_CATEGORIA ADD CONSTRAINT UN_SLV_CATEGORIA_SIGLA UNIQUE (DS_SIGLA_CATEGORIA);
ALTER TABLE T_SLV_CATEGORIA ADD CONSTRAINT UN_SLV_CATEGORIA_DESC UNIQUE (DS_CATEGORIA);

/* DROP TABLE T_SLV_AUTOR CASCADE CONSTRAINTS; */
CREATE TABLE T_SLV_AUTOR (
    CD_AUTOR            NUMBER(3)       NOT NULL,
    NM_PRIMEIRO_AUTOR   VARCHAR2(20)    NOT NULL,
    NM_SEGUNDO_AUTOR    VARCHAR2(20)    NOT NULL
);
ALTER TABLE T_SLV_AUTOR ADD CONSTRAINT PK_SLV_AUTOR PRIMARY KEY (CD_AUTOR);

/* DROP TABLE T_SLV_LIVRO CASCADE CONSTRAINTS; */
CREATE TABLE T_SLV_LIVRO (
    NR_ISBN             NUMBER(8)       NOT NULL,
    CD_CATEGORIA        NUMBER(3)       NOT NULL,
    NM_TITULO           VARCHAR(50)     NOT NULL,
    DS_SINOPSE          VARCHAR(200)    NOT NULL,
    NR_EDICAO           NUMBER(2)       NOT NULL,
    NR_ANO              NUMBER(4)       NOT NULL
);
ALTER TABLE T_SLV_LIVRO ADD CONSTRAINT PK_SLV_LIVRO PRIMARY KEY (NR_ISBN);
ALTER TABLE T_SLV_LIVRO ADD CONSTRAINT CK_SLV_LIVRO_ANO CHECK (NR_ANO > 0);
ALTER TABLE T_SLV_LIVRO ADD CONSTRAINT CK_SLV_LIVRO_EDICAO CHECK (NR_EDICAO > 0);

/* DROP TABLE T_SLV_AUTOR_LIVRO CASCADE CONSTRAINTS; */
CREATE TABLE T_SLV_AUTOR_LIVRO (
    NR_ISBN             NUMBER(8)       NOT NULL,
    CD_AUTOR            NUMBER(3)       NOT NULL,
    ST_AUTOR_PRINCIPAL  NUMBER(1)       NOT NULL
);
ALTER TABLE T_SLV_AUTOR_LIVRO ADD CONSTRAINT PK_SLV_AUTOR_LIVRO PRIMARY KEY (NR_ISBN,CD_AUTOR);
ALTER TABLE T_SLV_AUTOR_LIVRO ADD CONSTRAINT CK_SLV_AUTOR_LIVRO_STATUS CHECK (ST_AUTOR_PRINCIPAL IN (1,2));

-- FOREIGN KEY
ALTER TABLE T_SLV_LIVRO ADD CONSTRAINT FK_SLV_LIVRO_CATEGORIA FOREIGN KEY (CD_CATEGORIA) REFERENCES T_SLV_CATEGORIA (CD_CATEGORIA);
ALTER TABLE T_SLV_AUTOR_LIVRO ADD CONSTRAINT FK_SLV_AUTOR_LIVRO_AUTOR FOREIGN KEY (CD_AUTOR) REFERENCES T_SLV_AUTOR (CD_AUTOR);
ALTER TABLE T_SLV_AUTOR_LIVRO ADD CONSTRAINT FK_SLV_AUTOR_LIVRO_LIVRO FOREIGN KEY (NR_ISBN) REFERENCES T_SLV_LIVRO (NR_ISBN);

-- 2)
--- 2.1)
ALTER TABLE T_SLV_CATEGORIA RENAME COLUMN DS_SIGLA_CATEGORIA TO DS_SIGLA_CATEG;

--- 2.2)
ALTER TABLE T_SLV_CATEGORIA RENAME CONSTRAINT UN_SLV_CATEGORIA_DESC TO UN_SLV_CATEG_DESC;

--- 2.3)
ALTER TABLE T_SLV_AUTOR MODIFY NM_SEGUNDO_AUTOR VARCHAR(30);

--- 2.4)
ALTER TABLE T_SLV_AUTOR ADD ( DS_EMAIL VARCHAR2(40) NOT NULL );

--- 2.5)
ALTER TABLE T_SLV_AUTOR MODIFY DS_EMAIL VARCHAR2(60) NULL;

--- 2.6)
ALTER TABLE T_SLV_AUTOR_LIVRO MODIFY NR_ISBN NUMBER(13);

--- 2.7)
ALTER TABLE T_SLV_AUTOR_LIVRO DROP CONSTRAINT FK_SLV_AUTOR_LIVRO_LIVRO;
ALTER TABLE T_SLV_LIVRO MODIFY NR_ISBN NUMBER(13);
ALTER TABLE T_SLV_AUTOR_LIVRO ADD CONSTRAINT FK_SLV_AUTOR_LIVRO_LIVRO FOREIGN KEY (NR_ISBN) REFERENCES T_SLV_LIVRO (NR_ISBN);

--- 2.8)
ALTER TABLE T_SLV_AUTOR ADD ( NM_PAIS_ORIGEM VARCHAR(30) );

--- 2.9) 
ALTER TABLE T_SLV_LIVRO ADD CONSTRAINT UN_SLV_LIVRO_TITULO UNIQUE (NM_TITULO);

--- 2.10)
ALTER TABLE T_SLV_AUTOR_LIVRO DROP CONSTRAINT FK_SLV_AUTOR_LIVRO_AUTOR;

--- 2.11)
ALTER TABLE T_SLV_LIVRO DROP CONSTRAINT PK_SLV_LIVRO CASCADE;



