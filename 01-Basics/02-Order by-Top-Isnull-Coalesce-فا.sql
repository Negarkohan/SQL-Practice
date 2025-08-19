Use AdventureWorks2019
Go
-- 1 -- مرتب‌سازی مشتریان بر اساس نام خانوادگی به ترتیب صعودی
SELECT FirstName, LastName
FROM Person.Person
ORDER BY LastName ASC;

-- 2 -- مرتب‌سازی مشتریان بر اساس نام خانوادگی به ترتیب نزولی
SELECT FirstName, LastName
FROM Person.Person
ORDER BY LastName DESC;

-- 3 -- اگر ASC یا DESC مشخص نشود، پیش‌فرض ASC (صعودی) است.

-- 4 -- می‌توان چند ستون را همزمان مرتب کرد
ORDER BY LastName ASC, FirstName DESC;

-- 5 -- نمایش 5 مشتری اول
SELECT TOP 5 FirstName, LastName
FROM Person.Person
ORDER BY LastName;

-- 6 -- نمایش 10 درصد از مشتریان بر اساس ترتیب LastName
SELECT TOP 10 PERCENT FirstName, LastName
FROM Person.Person
ORDER BY LastName;

-- 7 -- اگر ستون MiddleName خالی باشد، 'N/A' نمایش داده شود
SELECT FirstName, ISNULL(MiddleName, 'N/A') AS MiddleName
FROM Person.Person;

/*  فقط دو آرگومان می‌گیرد: مقدار اصلی و مقدار جایگزین.

نوع داده جایگزین باید با نوع داده ستون سازگار باشد.

در SQL Server، اگر ستون NULL باشد، مقدار جایگزین نمایش داده می‌شود.  */


-- 8 -- نمایش نام میانی یا اگر خالی بود نام مستعار یا 'N/A'
SELECT FirstName, COALESCE(MiddleName, Title, 'N/A') AS DisplayName
FROM Person.Person;

/* می‌تواند چندین آرگومان بگیرد.

اولین مقدار غیر NULL را برمی‌گرداند.  */