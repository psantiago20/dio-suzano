SHOW DATABASES;
CREATE DATABASE IF NOT EXISTS first_example;

USE first_example;
SHOW TABLES;
CREATE TABLE person(
	person_id SMALLINT UNSIGNED,
	fname VARCHAR(20),
	lname VARCHAR(20),
	gender ENUM('M', 'F'),
	birth_date DATE,
	street VARCHAR(20),
	city VARCHAR(20),
	state VARCHAR(20),
	country VARCHAR(20),
	postal_code VARCHAR(20),
    CONSTRAINT pk_person PRIMARY KEY (person_id)
);

DESC person;

CREATE TABLE favorite_food(
	person_id SMALLINT UNSIGNED,
    food VARCHAR(20),
    CONSTRAINT pk_favorite_food	PRIMARY KEY (person_id, food),
    CONSTRAINT fk_favorite_food_person_id FOREIGN KEY (person_id) 
    REFERENCES person(person_id)
);

DESC favorite_food;

SHOW DATABASES;

SELECT * FROM information_schema.table_constraints
WHERE constraint_schema = 'first_example';

DESC information_schema.table_constraints;
SELECT constraint_name FROM information_schema.table_constraints
WHERE table_name = 'person';

SELECT * FROM information_schema.table_constraints
WHERE table_name = 'person';

SELECT * FROM information_schema.table_constraints
WHERE constraint_schema = 'first_example';

DESC person;

INSERT INTO person VALUES('1', 'Carolina', 'Silva', 'F', '1979-08-01',
							'rua tal', 'J', 'RJ', 'Brasil', '26054-89');

SELECT * FROM person;

DELETE FROM person WHERE person_id=2
					OR person_id=3;

INSERT INTO person VALUES	('2', 'Roberta', 'Silva', 'F', '1979-08-01',
							'rua tal', 'J', 'RJ', 'Brasil', '26054-89'),
                            ('3', 'Luiz', 'Silva', 'M', '1979-08-01',
							'rua tal', 'J', 'RJ', 'Brasil', '26054-89');
                            
INSERT INTO favorite_food VALUES(1, 'lasanha'),
								(2, 'carne assada'),
                                (3, 'fetuccine');
SELECT * FROM favorite_food;