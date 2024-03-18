CREATE DATABASE PayXpertDB
USE PayXpertDB

-- Creating Employee Table
CREATE TABLE Employees (
    employee_id INT IDENTITY(1,1) PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    dob DATE,
    gender VARCHAR(10),
    email VARCHAR(100),
    phone_no VARCHAR(20),
    address VARCHAR(255),
    position VARCHAR(100),
    join_date DATE,
    Termin_Date DATE NULL
)

--Creating Payroll Table
CREATE TABLE Payroll (
    payroll_id INT IDENTITY(1,1) PRIMARY KEY,
    employee_id INT,
    payPeriodStartDate DATE,
    payPeriodEndDate DATE,
    basic_salary DECIMAL(10, 2),
    ot_pay DECIMAL(10, 2),
    deductions DECIMAL(10, 2),
    net_salary DECIMAL(10, 2),
    FOREIGN KEY (employee_id) REFERENCES Employees(employee_id)
)

-- Creating Tax Table
CREATE TABLE Tax (
    tax_id INT IDENTITY(1,1) PRIMARY KEY,
    employee_id INT,
    tax_year INT,
    taxable_income DECIMAL(10, 2),
    tax_amount DECIMAL(10, 2),
    FOREIGN KEY (employee_id) REFERENCES Employees (employee_id)
)

-- Creating FinancialRecord Table
CREATE TABLE FinancialRecord (
    record_id INT IDENTITY(1,1) PRIMARY KEY,
    employee_id INT,
    record_date DATE,
    descriptions VARCHAR(255),
    amount DECIMAL(10, 2),
    record_type VARCHAR(50),
    FOREIGN KEY (employee_id) REFERENCES Employees(employee_id)
)
-- Inserting Values into Employee Table
INSERT INTO Employees (first_name, last_name, dob, gender, email, phone_no, address, position, join_date)
VALUES
  ('Anju', 'sharma', '2003-10-05', 'Female', 'anjusharma@company.com', '9440567890', 'Banglore', 'Engineer', '2020-02-15'),
  ('Amaya', 'kohli', '2000-08-12', 'Female', 'amayakohli@company.com', '9876543210', 'Chennai', 'Teacher', '2020-05-01'),
  ('Micy', 'Liya', '2002-03-20', 'Male', 'liyamicy@company.com', '7841234567', 'Kolkota', 'Doctor', '2020-02-09'),
  ('Kiran', 'Gare', '2001-12-31', 'Male', 'kirang@company.com', '7894561230', 'Udipi', 'Lawyer', '2020-05-02'),
  ('Dav', 'Joe', '2002-07-08', 'Male', 'davjoe@company.com', '7842724654', 'Hyderabad', 'Tutor', '2020-02-09')
SELECT * FROM Employees

-- Inserting Into PayRoll
INSERT INTO Payroll (employee_id, payPeriodStartDate, payPeriodEndDate, basic_salary, ot_pay, deductions, net_salary)
VALUES
  (1, '2021-04-01', '2022-02-10', 3500.00, 100.00, 200.00, 3400.00), 
  (2, '2021-04-01', '2022-02-10', 4200.00, 50.00, 150.00, 4100.00), 
  (3, '2021-04-01', '2022-02-10', 2800.00, 75.00, 120.00, 2755.00), 
  (4, '2021-04-01', '2022-02-10', 3800.00, 120.00, 180.00, 3740.00),
  (5, '2021-04-01', '2022-02-10', 3200.00, 85.00, 140.00, 3145.00)
SELECT * FROM Payroll

--Inserting Into Tax table
INSERT INTO Tax (employee_id, tax_year, taxable_income, tax_amount)
VALUES
  (1, 2022, 1000.00, 150.00),
  (2, 2022, 1500.00, 225.00),
  (3, 2022, 800.00, 120.00),
  (4, 2022, 1200.00, 180.00),
  (5, 2022, 900.00, 135.00)
SELECT * FROM Tax

--Inserting Into FinancialRecord
INSERT INTO FinancialRecord (employee_id, record_date, descriptions, amount, record_type)
VALUES
  (1, '2021-10-21', 'Salary', 3500.00, 'Income'),
  (2, '2021-10-22', 'Travel Reimbursement', 150.00, 'Income'),
  (3, '2021-10-23', 'Office Supplies Purchase', -200.00, 'Expense'),
  (4, '2021-10-24', 'Board payment', -50.00, 'Expense'),
  (5, '2021-10-24', 'Bonus Payment', 200.00, 'Income')

  --Queries--
 --1. Retrieve all employees' full names and positions:
 SELECT 
	concat_ws(' ', first_name, last_name) AS FullName,
	position
 FROM Employees

 --2. Calculate the total deductions for each employee for a specific pay period:
 SELECT 
	employee_id,
	concat_ws(' ', first_name, last_name) AS EmpName,
	(
		SELECT SUM(deductions) FROM Payroll p 
		WHERE p.employee_id=e.employee_id
		AND p.payPeriodStartDate ='2021-04-01'
		AND p.payPeriodEndDate='2022-02-10'
	) AS [Total Deduction]
FROM Employees e
GROUP BY employee_id, concat_ws(' ', first_name, last_name) 

--3. Retrieve the employee with the highest basic salary:
SELECT TOP 1 
	e.employee_id,
	concat_ws(' ', e.first_name, e.last_name) AS EmpName,
	p.basic_salary
FROM Employees e
JOIN Payroll p 
ON p.employee_id = e.employee_id
ORDER BY p.basic_salary desc

--4. Calculate the total tax paid by each employee for a specific tax year:
SELECT 
	e.employee_id, 
	concat_ws(' ', e.first_name, e.last_name) AS EmpName,
	t.tax_year,
	(SELECT SUM(t.tax_amount) FROM Tax t where e.employee_id= t.employee_id )
FROM Employees e, Tax t
GROUP BY tax_year,e.employee_id, concat_ws(' ', e.first_name, e.last_name)
HAVING tax_year=2022

--4.Retrieve the financial records for a specific employee within a date range:
DECLARE @emp_id int = 2
DECLARE @from date = '2021-04-01'
DECLARE @to date = '2022-02-10'

SELECT 
	e.employee_id,
	e.first_name, 
	e.last_name,
	f.record_id,
	f.record_type,
	f.record_type,
	f.descriptions,
	f.descriptions
	
FROM Employees e, FinancialRecord f
WHERE e.employee_id = @emp_id 
	AND record_date BETWEEN @from AND @to 

--5. Retrieve the employee(s) who have been terminated:
SELECT * FROM Employees
WHERE Termin_Date IS NOT NULL

-- 6. Retrive employees(s) who lives in same residence:
SELECT employee_id, CONCAT(first_name, ' ',last_name) AS FullName, Address
FROM Employees
WHERE Address IN (
    SELECT Address
    FROM Employees
    GROUP BY Address
    HAVING COUNT(*) > 1
)

--FUNCTIONALITIES:
--1. Employee Management (CRUD operations):
--Create(INSERT)
INSERT INTO Employees (first_name, last_name, dob, gender, email, phone_no, address, position, join_date)
VALUES ('Nikhil', 'Curran', '2000-11-11', 'Male', 'nikhil@company.com', '7842724800', 'Banglore', 'Actor', '2021-10-01');
--Read(SELECT)
SELECT * FROM Employees
--Update(UPDATE)
UPDATE Employees
SET position = 'Physicl Design Engineer' 
WHERE employee_id = 6
--Delete(DELETE)
DELETE FROM Employees
Where employee_id = 6

--2. PayRoll Processing
DECLARE @PayRoll Table(
	emp_id int, FullName varchar(MAX), Net_Salary decimal(10,2)
	)
SELECT * FROM Employees

--- Update the netsalary in payroll table 
UPDATE PAYROLL SET net_salary = (basic_salary + ot_pay - deductions)
--basic_salary, ot_pay, deductions, net_salary)


--- Update the netsalary in payroll table
SELECT CONCAT_WS(' ', first_name, last_name) AS FullName,Position
 FROM Employees

 --- Select name of the employee with full name and last name
 SELECT employee_id, CONCAT(first_name, ' ',last_name) AS FullName, Address
FROM Employees 
WHERE Address IN (SELECT Address
    FROM Employees  GROUP BY Address
    HAVING COUNT(*) > 1
)
-- Retrieve the employee with the highest basic salary:
SELECT TOP 1 e.employee_id,concat_ws(' ', e.first_name, e.last_name) AS EmpName,p.basic_salary
FROM Employees e
JOIN Payroll p 
ON p.employee_id = e.employee_id
ORDER BY p.basic_salary DESC

