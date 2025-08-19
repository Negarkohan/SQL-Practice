-- Datenbank auswählen
USE AdventureWorks2019;
GO

-- 1️⃣ SELECT: Anzeige von Vor- und Nachname der Kunden
SELECT FirstName, LastName
FROM Person.Person;
-- Dieser Befehl wird verwendet, um Daten aus der Tabelle Person anzuzeigen

-- 2️⃣ INSERT in die Tabelle Culture
INSERT INTO Production.Culture (CultureID, Name, ModifiedDate)
VALUES ('xx-XX', 'TestCulture', GETDATE());
-- Dieser Befehl fügt einen neuen Datensatz in die Tabelle Culture ein

-- 3️⃣ UPDATE: Ändern des Vornamens eines Kunden
UPDATE Person.Person
SET FirstName = 'Negar Updated'
WHERE BusinessEntityID = 1;
-- Dieser Befehl ändert den Wert einer Spalte im ausgewählten Datensatz

-- 4️⃣ DELETE: Löschen eines einfachen Datensatzes in der Tabelle Culture
DELETE FROM Production.Culture
WHERE CultureID = 'xx-XX';
-- Dieser Befehl löscht einen bestimmten Datensatz aus der Tabelle

-- 5️⃣ WHERE: Anzeige von Bestellungen mit Gesamtbetrag über 1000
SELECT SalesOrderID, TotalDue
FROM Sales.SalesOrderHeader
WHERE TotalDue > 1000;
-- Dieser Befehl zeigt nur Datensätze an, die die angegebene Bedingung erfüllen
