-- Author: Negar Kohansal
-- Creating a parent table: Departments
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName NVARCHAR(50)
);

-- Creating a child table: Employees
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    EmployeeName NVARCHAR(50),
    DepartmentID INT
);

-- Adding a foreign key with CASCADE
-- ON DELETE CASCADE: deleting a department will delete its employees automatically
ALTER TABLE Employees
ADD CONSTRAINT FK_Employees_Departments
FOREIGN KEY (DepartmentID)
REFERENCES Departments(DepartmentID)
ON DELETE CASCADE;

-- Insert sample departments
INSERT INTO Departments (DepartmentID, DepartmentName)
VALUES (1, 'HR'), (2, 'IT');

-- Insert sample employees
INSERT INTO Employees (EmployeeID, EmployeeName, DepartmentID)
VALUES 
(101, 'Alice', 1),
(102, 'Bob', 1),
(103, 'Charlie', 2);

-- Delete HR department
DELETE FROM Departments
WHERE DepartmentID = 1;

-- Check remaining employees
SELECT * FROM Employees;
