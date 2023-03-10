CREATE TABLE LIVRARIA(
    ID_LIVRARIA NUMBER(10) PRIMARY KEY,
    NOME_LIVRARIA VARCHAR2(100) NOT NULL
);

INSERT INTO LIVRARIA (ID_LIVRARIA, NOME_LIVRARIA) VALUES (1,'LIVRARIA HAGNOS');
INSERT INTO LIVRARIA (ID_LIVRARIA, NOME_LIVRARIA) VALUES (2,'LIVRARIA PÃO DIÁRIO');
INSERT INTO LIVRARIA (ID_LIVRARIA, NOME_LIVRARIA) VALUES (3,'LIVRARIA VIRTUAL');
INSERT INTO LIVRARIA (ID_LIVRARIA, NOME_LIVRARIA) VALUES (4,'LIVRARIA FIEL');

CREATE TABLE LOCALIDADE(
    ID_LOCAL NUMBER(10) PRIMARY KEY,
    CIDADE VARCHAR2(100) NOT NULL,
    ESTADO CHAR(2) NOT NULL,
    PAIS CHAR(3) NOT NULL
);

INSERT INTO LOCALIDADE (ID_LOCAL, CIDADE, ESTADO, PAIS) VALUES (1,'BOTUCATU', 'SP', 'BRA');
INSERT INTO LOCALIDADE (ID_LOCAL, CIDADE, ESTADO, PAIS) VALUES (2,'MARILIA', 'SP', 'BRA');
INSERT INTO LOCALIDADE (ID_LOCAL, CIDADE, ESTADO, PAIS) VALUES (3,'CURITIBA', 'PR', 'BRA');
INSERT INTO LOCALIDADE (ID_LOCAL, CIDADE, ESTADO, PAIS) VALUES (4,'VIRGINA BEACH', 'VR', 'EUA');

CREATE TABLE FAIXA_IDADE(
    ID_FAIXA NUMBER(10) PRIMARY KEY,
    DESCRICAO VARCHAR2(20) NOT NULL
);

INSERT INTO FAIXA_IDADE (ID_FAIXA, DESCRICAO) VALUES (1,'APARTIR DE 10 ANOS');
INSERT INTO FAIXA_IDADE (ID_FAIXA, DESCRICAO) VALUES (2,'APARTIR DE 12 ANOS');
INSERT INTO FAIXA_IDADE (ID_FAIXA, DESCRICAO) VALUES (3,'APARTIR DE 14 ANOS');
INSERT INTO FAIXA_IDADE (ID_FAIXA, DESCRICAO) VALUES (4,'APARTIR DE 16 ANOS');
INSERT INTO FAIXA_IDADE (ID_FAIXA, DESCRICAO) VALUES (5,'APARTIR DE 18 ANOS');
INSERT INTO FAIXA_IDADE (ID_FAIXA, DESCRICAO) VALUES (6,'LIVRE');

CREATE TABLE TEMPO(
    ID_TEMPO NUMBER(10) PRIMARY KEY,
    MES NUMBER(2) NOT NULL,
    ANO NUMBER(4) NOT NULL
);

INSERT INTO TEMPO (ID_TEMPO, MES, ANO) VALUES (1, 02, 2018);
INSERT INTO TEMPO (ID_TEMPO, MES, ANO) VALUES (2, 04, 2021);
INSERT INTO TEMPO (ID_TEMPO, MES, ANO) VALUES (3, 05, 2021);
INSERT INTO TEMPO (ID_TEMPO, MES, ANO) VALUES (4, 03, 2022);
INSERT INTO TEMPO (ID_TEMPO, MES, ANO) VALUES (5, 09, 2014);
INSERT INTO TEMPO (ID_TEMPO, MES, ANO) VALUES (6, 01, 2011);

CREATE TABLE AUTOR(
    ID_AUTOR NUMBER(10) PRIMARY KEY,
    NOME_AUTOR VARCHAR2(10) NOT NULL
);

INSERT INTO AUTOR (ID_AUTOR, NOME_AUTOR) VALUES (1, 'MATHEUS');
INSERT INTO AUTOR (ID_AUTOR, NOME_AUTOR) VALUES (2, 'MARCOS');
INSERT INTO AUTOR (ID_AUTOR, NOME_AUTOR) VALUES (3, 'LUCAS');
INSERT INTO AUTOR (ID_AUTOR, NOME_AUTOR) VALUES (4, 'JOÃO');
INSERT INTO AUTOR (ID_AUTOR, NOME_AUTOR) VALUES (5, 'RUTE');
INSERT INTO AUTOR (ID_AUTOR, NOME_AUTOR) VALUES (6, 'ESTER');

CREATE TABLE EDITORA(
    ID_EDITORA NUMBER(10) PRIMARY KEY,
    NOME_EDITORA VARCHAR2(120) NOT NULL
);

INSERT INTO EDITORA (ID_EDITORA, NOME_EDITORA) VALUES (1, 'PRINCIPS');
INSERT INTO EDITORA (ID_EDITORA, NOME_EDITORA) VALUES (2, 'ROCCO');
INSERT INTO EDITORA (ID_EDITORA, NOME_EDITORA) VALUES (3, 'HAGNOS');
INSERT INTO EDITORA (ID_EDITORA, NOME_EDITORA) VALUES (4, 'FIEL');

CREATE TABLE ASSUNTO(
    ID_ASSUNTO NUMBER(10) PRIMARY KEY,
    NOME_ASSUNTO VARCHAR2(120) NOT NULL
);

INSERT INTO ASSUNTO (ID_ASSUNTO, NOME_ASSUNTO) VALUES (1, 'TECNOLOGIA');
INSERT INTO ASSUNTO (ID_ASSUNTO, NOME_ASSUNTO) VALUES (2, 'AVENTURA');
INSERT INTO ASSUNTO (ID_ASSUNTO, NOME_ASSUNTO) VALUES (3, 'TEOLOGIA');

CREATE TABLE VENDA(
    ID_LIVRARIA NUMBER(10) NOT NULL,
    ID_LOCAL NUMBER(10) NOT NULL,
    ID_TEMPO NUMBER(10) NOT NULL,
    ID_AUTOR NUMBER(10) NOT NULL,
    ID_EDITORA NUMBER(10) NOT NULL,
    ID_ASSUNTO NUMBER(10) NOT NULL,
    ID_FAIXA NUMBER(10) NOT NULL,
    GENERO CHAR(2) NOT NULL,
    QUANTIDADE NUMBER(20) NOT NULL,
    VALOR NUMBER(6,2) NOT NULL,

    CONSTRAINT FK_VENDA_LIVRARIA FOREIGN KEY(ID_LIVRARIA) REFERENCES LIVRARIA (ID_LIVRARIA),    
    CONSTRAINT FK_VENDA_LOCAL FOREIGN KEY(ID_LOCAL) REFERENCES LOCALIDADE (ID_LOCAL),    
    CONSTRAINT FK_VENDA_TEMPO FOREIGN KEY(ID_TEMPO) REFERENCES TEMPO (ID_TEMPO),
    CONSTRAINT FK_VENDA_AUTOR FOREIGN KEY(ID_AUTOR) REFERENCES AUTOR (ID_AUTOR),
    CONSTRAINT FK_VENDA_EDITORA FOREIGN KEY(ID_EDITORA) REFERENCES EDITORA (ID_EDITORA),
    CONSTRAINT FK_VENDA_ASSUNTO FOREIGN KEY(ID_ASSUNTO) REFERENCES ASSUNTO (ID_ASSUNTO),
    CONSTRAINT FK_VENDA_FAIXA FOREIGN KEY(ID_FAIXA) REFERENCES FAIXA_IDADE (ID_FAIXA),
    CONSTRAINT CK_GENERO CHECK (GENERO IN('M','F'))
);

INSERT INTO VENDA (ID_LIVRARIA, ID_LOCAL, ID_TEMPO, ID_AUTOR, ID_EDITORA, ID_ASSUNTO, ID_FAIXA, GENERO, 
  QUANTIDADE, VALOR
) VALUES (1, 2, 3, 1, 2, 3, 1, 'F', 7, 10.76);


SELECT ASSUNTO.NOME_ASSUNTO, LOCALIDADE.CIDADE, LOCALIDADE.ESTADO, LOCALIDADE.PAIS, SUM(VENDA.VALOR), LIVRARIA.NOME_LIVRARIA FROM VENDA    
INNER JOIN LOCALIDADE ON VENDA.ID_LOCAL = LOCALIDADE.ID_LOCAL  
INNER JOIN LIVRARIA ON VENDA.ID_LIVRARIA = LIVRARIA.ID_LIVRARIA  
INNER JOIN ASSUNTO ON VENDA.ID_ASSUNTO = ASSUNTO.ID_ASSUNTO
GROUP BY ASSUNTO.NOME_ASSUNTO, LIVRARIA.NOME_LIVRARIA, LOCALIDADE.ESTADO, LOCALIDADE.CIDADE, LOCALIDADE.PAIS;
ORDER BY ASSUNTO.NOME_ASSUNTO, LIVRARIA.NOME_LIVRARIA;

SELECT ASSUNTO.NOME_ASSUNTO, LOCALIDADE.CIDADE, LOCALIDADE.ESTADO, LOCALIDADE.PAIS, SUM(VENDA.VALOR), LIVRARIA.NOME_LIVRARIA FROM VENDA    
INNER JOIN LOCALIDADE ON VENDA.ID_LOCAL = LOCALIDADE.ID_LOCAL  
INNER JOIN LIVRARIA ON VENDA.ID_LIVRARIA = LIVRARIA.ID_LIVRARIA  
INNER JOIN ASSUNTO ON VENDA.ID_ASSUNTO = ASSUNTO.ID_ASSUNTO
GROUP BY CUBE (ASSUNTO.NOME_ASSUNTO, LIVRARIA.NOME_LIVRARIA, LOCALIDADE.ESTADO, LOCALIDADE.CIDADE, LOCALIDADE.PAIS);
ORDER BY ASSUNTO.NOME_ASSUNTO, LIVRARIA.NOME_LIVRARIA;
