CREATE PROCEDURE my_proc
AS
SELECT * FROM Employees;


--- To use this store procedure
EXEC my_prod;
--------------------------------------

CREATE PROCEDURE Tmp_Employee
AS
CREATE OR REPLACE TABLE #temp_employee (
  JobTitle VARCHAR(100),
  EmployeesPerJob INT,
  AvgAge INT,
  AvgSalary INT
  );
  
INSERT INTO #temp_employee
 SELECT JobTitle, COUNT(JobTitle), AVG(Age), AVG(Salary)
 FROM dbo.EmployeeDemographics emp
 JOIN dbo.EmployeeSalary sal
 ON emp.EmployeeID = sal.EmployeeID
 GROUP BY JobTitle;
 
SELECT * FROM #temp_employee;

--- To use this store procedure
EXEC Tmp_Employee;
-----------------------------------------------
