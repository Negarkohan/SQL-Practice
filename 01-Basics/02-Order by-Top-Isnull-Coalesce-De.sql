USE AdventureWorks2019;
GO

-- 1 -- Kunden nach Nachname aufsteigend sortieren
SELECT FirstName, LastName
FROM Person.Person
ORDER BY LastName ASC;

-- 2 -- Kunden nach Nachname absteigend sortieren
SELECT FirstName, LastName
FROM Person.Person
ORDER BY LastName DESC;

-- 3 -- Wenn ASC oder DESC nicht angegeben ist, ist standardmäßig ASC (aufsteigend)
-- Hinweis: Standardverhalten von SQL Server

-- 4 -- Mehrere Spalten gleichzeitig sortieren
ORDER BY LastName ASC, FirstName DESC;

-- 5 -- Die ersten 5 Kunden anzeigen
SELECT TOP 5 FirstName, LastName
FROM Person.Person
ORDER BY LastName;

-- 6 -- Die obersten 10 Prozent der Kunden nach LastName anzeigen
SELECT TOP 10 PERCENT FirstName, LastName
FROM Person.Person
ORDER BY LastName;

-- 7 -- Wenn MiddleName NULL ist, 'N/A' anzeigen
SELECT FirstName, ISNULL(MiddleName, 'N/A') AS MiddleName
FROM Person.Person;

/* 
Nimmt nur zwei Argumente: Originalwert und Ersatzwert.
Der Ersatzwert muss mit dem Datentyp der Spalte kompatibel sein.
In SQL Server wird der Ersatzwert angezeigt, wenn die Spalte NULL ist.
*/

-- 8 -- Zeigt MiddleName oder, falls NULL, Title oder 'N/A' an
SELECT FirstName, COALESCE(MiddleName, Title, 'N/A') AS DisplayName
FROM Person.Person;

/*
Kann mehrere Argumente haben.
Gibt den ersten Nicht-NULL-Wert zurück.
*/
