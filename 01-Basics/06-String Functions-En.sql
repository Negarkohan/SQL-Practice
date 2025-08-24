-- AdventureWorks2019 SQL Examples - String Functions
-- Author: Negar Kohnesal
-- Description: Sample SQL queries using common string functions

----------------------------------------------------------
-- Example 1: LEN
-- Get the length of first name
----------------------------------------------------------
SELECT LEN(FirstName) AS NameLength
FROM Person.Person;

----------------------------------------------------------
-- Example 2: LEFT
-- Get the first 3 characters of first name
----------------------------------------------------------
SELECT LEFT(FirstName, 3) AS FirstThreeChars
FROM Person.Person;

----------------------------------------------------------
-- Example 3: RIGHT
-- Get the last 4 characters of last name
----------------------------------------------------------
SELECT RIGHT(LastName, 4) AS LastFourChars
FROM Person.Person;

----------------------------------------------------------
-- Example 4: SUBSTRING
-- Get 3 characters starting from 2nd position of first name
----------------------------------------------------------
SELECT SUBSTRING(FirstName, 2, 3) AS MiddleChars
FROM Person.Person;

----------------------------------------------------------
-- Example 5: CHARINDEX
-- Find the position of 'a' in first name
----------------------------------------------------------
SELECT CHARINDEX('a', FirstName) AS PositionOfA
FROM Person.Person;

----------------------------------------------------------
-- Example 6: PATINDEX
-- Find the position of pattern 'son' in last name
----------------------------------------------------------
SELECT PATINDEX('%son%', LastName) AS PatternPosition
FROM Person.Person;

----------------------------------------------------------
-- Example 7: REPLACE
-- Replace 'a' with '@' in first name
----------------------------------------------------------
SELECT REPLACE(FirstName, 'a', '@') AS ReplacedName
FROM Person.Person;

----------------------------------------------------------
-- Example 8: REPLICATE
-- Repeat a string 10 times
----------------------------------------------------------
SELECT REPLICATE('*', 10) AS Stars;

----------------------------------------------------------
-- Example 9: UPPER / LOWER
-- Convert first name to upper case and last name to lower case
----------------------------------------------------------
SELECT UPPER(FirstName) AS UpperName,
       LOWER(LastName) AS LowerName
FROM Person.Person;

----------------------------------------------------------
-- Example 10: LTRIM / RTRIM
-- Remove leading or trailing spaces
----------------------------------------------------------
SELECT LTRIM('   Hello') AS LeftTrimmed,
       RTRIM('Hello   ') AS RightTrimmed;

----------------------------------------------------------
-- Example 11: FORMAT
-- Format ListPrice as currency
----------------------------------------------------------
SELECT FORMAT(ListPrice, 'C', 'en-US') AS PriceFormatted
FROM Production.Product;

----------------------------------------------------------
-- Example 12: CONCAT
-- Concatenate first and last names
----------------------------------------------------------
SELECT CONCAT(FirstName, ' ', LastName) AS FullName
FROM Person.Person;

----------------------------------------------------------
-- Example 13: STRING_AGG
-- Aggregate first names separated by comma
-- STRING_AGG with VARCHAR(MAX) to avoid truncation
SELECT STRING_AGG(CONVERT(VARCHAR(MAX), FirstName), ', ') AS AllFirstNames
FROM Person.Person;

----------------------------------------------------------
-- Example 14: TRIM
-- Remove spaces from both ends of a string
----------------------------------------------------------
SELECT TRIM('   Hello World   ') AS TrimmedString;

----------------------------------------------------------
-- Example 15: SPACE
-- Insert 5 spaces between words
----------------------------------------------------------
SELECT 'Hello' + SPACE(5) + 'World' AS SpacedString;

----------------------------------------------------------
-- Example 16: ASCII / CHAR
-- Convert character to ASCII code and back
----------------------------------------------------------
SELECT ASCII('A') AS AsciiCode,
       CHAR(65) AS CharacterFromCode;
