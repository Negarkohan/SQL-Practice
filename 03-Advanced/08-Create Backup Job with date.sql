
--Create simple backup job-------------
BACKUP DATABASE MyDB
TO DISK = 'D:\Backup\MyDB.bak'
WITH INIT;   --If the file already exists, overwrite it---


--Create backup job with date-------------
DECLARE @Path NVARCHAR(200) = 'D:\Backup\MyDB_' + FORMAT(GETDATE(), 'yyyyMMdd_HHmm') + '.bak';
BACKUP DATABASE MyDB TO DISK = @Path WITH INIT;