
-- انتخاب دیتابیس
USE AdventureWorks2019;
GO

-- 1️ -- SELECT: نمایش نام و نام خانوادگی مشتریان
SELECT FirstName, LastName
FROM Person.Person;
-- این دستور برای مشاهده داده‌ها در جدول Person استفاده می‌شود

-- 2 -- INSERT  در جدول Culture
INSERT INTO Production.Culture (CultureID, Name, ModifiedDate)
VALUES ('xx-XX', 'TestCulture', GETDATE());
-- این دستور یک رکورد جدید به جدول Culture اضافه می‌کند

-- 3️ -- UPDATE: تغییر نام یک مشتری
UPDATE Person.Person
SET FirstName = 'Negar Updated'
WHERE BusinessEntityID = 1;
-- این دستور مقدار ستون مشخص را در رکورد انتخاب شده تغییر می‌دهد

-- 4 -- حذف یک رکورد ساده در جدول Culture
DELETE FROM Production.Culture
WHERE CultureID = 'xx-XX';
-- این دستور رکورد مشخصی را از جدول حذف می‌کند

-- 5️ -- WHERE: نمایش سفارشات با مبلغ بالای 1000
SELECT SalesOrderID, TotalDue
FROM Sales.SalesOrderHeader
WHERE TotalDue > 1000;
-- این دستور فقط رکوردهایی را نمایش می‌دهد که شرط مشخص را دارند
