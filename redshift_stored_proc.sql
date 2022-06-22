-- UDF #1
CREATE FUNCTION f_no_of_workingdays(datetime, datetime)
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
