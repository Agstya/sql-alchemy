CREATE SCHEMA deworktest;

CREATE PROCEDURE ins_emp (numeric, varchar(100), varchar(100), bool, date, float8, float8, text)

LANGUAGE 'plpgsql'

AS $$

BEGIN 

CREATE TABLE IF NOT EXISTS deworktest.emp(
  id numeric,
  fName varchar(100), 
  lName varchar(100), 
  isEmployed bool, 
  hireDate date, 
  rating float8, 
  salary float8, 
  description text);

INSERT INTO deworktest.emp(id, fName, lName, isEmployed, hireDate, rating, salary, description)
VALUES ($1, $2, $3, $4, $5, $6, $7, $8);

COMMIT;

END;

$$
