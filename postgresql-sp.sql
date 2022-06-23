CREATE PROCEDURE ins_emp (numeric, varchar(100), bool, date, float8, money, text)

LANGUAGE 'plpgsql'

AS $$

BEGIN 

CREATE TABLE IF NOT EXISTS emp(
  id numeric,
  fName varchar(100), 
  lName varchar(100), 
  isEmployed bool, 
  hireDate date, 
  rating float8, 
  salary money, 
  description text)

INSERT INTO emp(id, fName, lName, isEmployed, hireDate, rating, salary, description)
VALUES ($1, $2, $3, $4, $5, $6, $7)
