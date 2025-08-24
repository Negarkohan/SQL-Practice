--Performance of MDF, NDF, LDF files---------
SELECT
DB_NAME(database_id) AS DatabaseName,*
FROM sys.dm_io_virtual_file_stats(NULL, NULL);