--SP 1
CREATE OR REPLACE PROCEDURE test_sp1(f1 int, f2 varchar(20))
AS $$
DECLARE
  min_val int;
BEGIN
  DROP TABLE IF EXISTS tmp_tbl;
  CREATE TEMP TABLE tmp_tbl(id int);
  INSERT INTO tmp_tbl values (f1),(10001),(10002);
  SELECT INTO min_val MIN(id) FROM tmp_tbl;
  RAISE INFO 'min_val = %, f2 = %', min_val, f2;
END;
$$ LANGUAGE plpgsql;


call test_sp1(3,'book');
-- INFO:  Table "tmp_tbl" does not exist and will be skipped
-- INFO:  min_val = 3, f2 = book



-- SP 2

CREATE OR REPLACE PROCEDURE test_sp2(f1 IN int, f2 INOUT varchar(256), out_var OUT varchar(256))
AS $$
DECLARE
  loop_var int;
BEGIN
  IF f1 is null OR f2 is null THEN
    RAISE EXCEPTION 'input cannot be null';
  END IF;
  DROP TABLE if exists my_etl;
  CREATE TEMP TABLE my_etl(a int, b varchar);
    FOR loop_var IN 1..f1 LOOP
        insert into my_etl values (loop_var, f2);
        f2 := f2 || '+' || f2;
    END LOOP;
  SELECT INTO out_var count(*) from my_etl;
END;
$$ LANGUAGE plpgsql;

call test_sp2(2,'2019');

--          f2          | column2
-- ---------------------+---------
--  2019+2019+2019+2019 | 2
-- (1 row) 




-- UDF #1
CREATE FUNCTION f_no_of_workingdays (datetime, datetime)
RETURNS bigint
STABLE 
AS $$ 
SELECT  DATEDIFF(day, $1, $2) +
        CASE  WHEN date_part('dow', $1) = 6 THEN 0
              WHEN date_part('dow', $1) = 0 THEN -1
              ELSE 0
        END
        - (datediff(week,$1,$2)*2)

$$ language sql;

-- Example #1:
-- SELECT no_of_working_days('01/11/2018 00:00:00', '09/11/2018')
------------------------------------------------------------------------------------------
-- UDF #2
create function f_sql_greater (float, float)
  returns float
stable
as $$
  select case when $1 > $2 then $1
    else $2
  end
$$ language sql;  

-- Example #2:
-- select f_sql_greater(commission, pricepaid*0.20) from sales;
----------------------------------------------------------------------------------------------
-- UDF #3
create or replace function f_py_greater (a float, b float)
  returns float
stable
as $$
  if a > b:
    return a
  return b
$$ language plpythonu;

-- Example #:3
-- select f_sql_greater(commission, pricepaid*0.20) from sales;
-- select f_sql_greater(1.0, 2.8*0.20);
-----------------------------------------------------------------------------------------------------
