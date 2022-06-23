CREATE SCHEMA deworktest;

DROP TABLE IF EXISTS deworktest.emp2;

CREATE OR REPLACE PROCEDURE ins_emp2 ( varchar(100), varchar(100), bool, date, float8, float8, text)
AS $$
BEGIN 
CREATE TABLE IF NOT EXISTS deworktest.emp2(
  id bigint  PRIMARY KEY NOT NULL IDENTITY(0, 1),
  fName varchar(100) NOT NULL, 
  lName varchar(100)NOT NULL, 
  isEmployed bool NOT NULL, 
  hireDate date NOT NULL, 
  rating float8, 
  salary float8, 
  description text);
  
INSERT INTO deworktest.emp2(fName, lName, isEmployed, hireDate, rating, salary, description)
VALUES ($1, $2, $3, $4, $5, $6, $7);

COMMIT;
END;
$$ LANGUAGE 'plpgsql'

---


CALL ins_emp2( 'Jane', 'Bates', true, '2017-07-15', 6.2, 135000, 'Cloud Security Engineer-I');
CALL ins_emp2( 'Susan', 'Douglas', true, '2018-04-05', 8.8, 185000, 'Cloud Data Manager');
CALL ins_emp2( 'Arfan', 'Khan', true, '2019-06-19', 9.4, 165000, 'Cloud Data Engineer-I');
CALL ins_emp2( 'John', 'Sears', true, '2021-12-11', 7.2, 165000, 'Cloud Security Engineer-II');
CALL ins_emp2( 'Mike', 'Clark', true, '2019-08-09', 8.1, 275000, 'Cloud Architect');
CALL ins_emp2( 'Tim', 'Johnson', true, '2021-08-04', 6.4, 125000, 'Cloud Data Modeler-I');
CALL ins_emp2( 'Alex', 'Brown', false, '2022-06-12', 7.6, 145000, 'Cloud Reporting Engineer-II');

SELECT * FROM deworktest.emp2;

-- ALTER TABLE deworktest.emp DROP column id;
