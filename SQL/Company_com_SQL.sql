CREATE SCHEMA IF NOT EXISTS COMPANY_CONSTRAINTS;

USE COMPANY_CONSTRAINTS;

CREATE TABLE EMPLOYEE(
	FNAME VARCHAR(15) NOT NULL,
	MINIT CHAR,
	LNAME VARCHAR(15) NOT NULL,
	SSN CHAR(9) NOT NULL,
	BDATE DATE,
	ADDRESS VARCHAR(30),
	SEX CHAR,
	SALARY DECIMAL(10,2),
	SUPER_SSN CHAR(9),
	DNO INT NOT NULL,
    CONSTRAINT CHK_SALARY_EMPLOYEE CHECK (SALARY > 2000.0),
	CONSTRAINT PK_EMPLOYEE PRIMARY KEY (SSN)
);

DESC EMPLOYEE;

ALTER TABLE EMPLOYEE
	ADD CONSTRAINT FK_EMPLOYEE
    FOREIGN KEY(SUPER_SSN) REFERENCES EMPLOYEE(SSN)
    ON DELETE SET NULL
    ON UPDATE CASCADE;

CREATE TABLE DEPARTAMENT(
	DNAME VARCHAR(15) NOT NULL,
    DNUMBER INT NOT NULL,
    MGR_SSN CHAR(9) NOT NULL,
    MGR_START_DATE DATE,
    DEPT_CREATE_DATE DATE,
	CONSTRAINT CHK_DATE_DEPT CHECK (DEPT_CREATE_DATE < MGR_START_DATE),
    CONSTRAINT PK_DEPT PRIMARY KEY (DNUMBER),
    CONSTRAINT UNIQUE_NAME_DEPT UNIQUE (DNAME),
    FOREIGN KEY (MGR_SSN) REFERENCES EMPLOYEE(SSN)
);

-- 'def', 'company_constraints', 'departament_ibfk_1', 'company_constraints', 'departament', 'FOREIGN KEY', 'YES'
-- MODIFICAR UMA CONSTRAINT: DROP E ADD
ALTER TABLE DEPARTAMENT DROP CONSTRAINT departament_ibfk_1;
ALTER TABLE DEPARTAMENT
	ADD CONSTRAINT FK_DEPT FOREIGN KEY(MGR_SSN) REFERENCES EMPLOYEE(SSN)
    ON UPDATE CASCADE;

DESC DEPARTAMENT;

CREATE TABLE DEPT_LOCATIONS(
	DNUMBER INT NOT NULL,
    DLOCATION VARCHAR(15) NOT NULL,
    CONSTRAINT PK_DEPT_LOCATIONS PRIMARY KEY (DNUMBER, DLOCATION),
    CONSTRAINT FK_DEPT_LOCATIONS FOREIGN KEY (DNUMBER) REFERENCES DEPARTAMENT(DNUMBER)
);

ALTER TABLE DEPT_LOCATIONS DROP CONSTRAINT FK_DEPT_LOCATIONS;

ALTER TABLE DEPT_LOCATIONS
	ADD CONSTRAINT FK_DEPT_LOCATIONS FOREIGN KEY(DNUMBER) REFERENCES DEPARTAMENT(DNUMBER)
    ON DELETE CASCADE
    ON UPDATE CASCADE;

CREATE TABLE PROJECT(
	PNAME VARCHAR(15) NOT NULL,
    PNUMBER INT NOT NULL,
    PLOCATION VARCHAR(15),
    DNUM INT NOT NULL,
    PRIMARY KEY (PNUMBER),
    CONSTRAINT UNIQUE_PROJECT UNIQUE (PNAME),
    CONSTRAINT FK_PROJECT FOREIGN KEY (DNUM) REFERENCES DEPARTAMENT(DNUMBER)
);

CREATE TABLE WORKS_ON(
	ESSN CHAR(9) NOT NULL,
    PNO INT NOT NULL,
    HOURS DECIMAL(3,1) NOT NULL,
    PRIMARY KEY (ESSN, PNO),
    CONSTRAINT FK_EMPLOYEE_WORKS_ON FOREIGN KEY (ESSN) REFERENCES EMPLOYEE (SSN),
    CONSTRAINT FK_PROJECT_WORKS_ON FOREIGN KEY (PNO) REFERENCES PROJECT (PNUMBER)
);

DROP TABLE DEPENDENT;
CREATE TABLE DEPENDENT(
	ESSN CHAR(9) NOT NULL,
    DEPENDENT_NAME VARCHAR(15) NOT NULL,
    SEX CHAR, -- F OU M
    BDATE DATE,
    RELATIONSHIP VARCHAR(8),
    PRIMARY KEY (ESSN, DEPENDENT_NAME),
    CONSTRAINT FK_DEPENDENT FOREIGN KEY (ESSN) REFERENCES EMPLOYEE (SSN)
);

SHOW TABLES;
-- DESC DEPARTAMENT;
-- ALTER TABLE EMPLOYEE RENAME COLUMN LNMAE TO LNAME;
-- DESC EMPLOYEE;

-- RESTRIÇÃO ATRIBUÍDA A UM DOMÍNIO
-- CREATE DOMAIN D_NUM AS INT CHECK(D_NUM > 0 AND D_NUM < 21)

-- SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_SCHEMA = 'COMPANY';
    
-- SELECT * FROM INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS WHERE CONSTRAINT_SCHEMA = 'COMPANY';

SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_SCHEMA = 'COMPANY_CONSTRAINTS';