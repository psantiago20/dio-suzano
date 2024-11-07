SELECT * FROM editora;

INSERT INTO editora(nome_editora, pais) VALUES ('IEEE_EU', 'EU');

SELECT *FROM periodicos;

INSERT INTO periodicos(nome_periodico, issn, id_editora) VALUES (
'Special Issue', '156795164', '1');

INSERT INTO periodicos(nome_periodico, issn, id_editora) VALUES (
'Special Issue 2', '156795164', '4');

SHOW TABLES;

SELECT * FROM editora;

SELECT * FROM periodicos;