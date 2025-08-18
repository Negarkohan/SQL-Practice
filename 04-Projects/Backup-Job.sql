/*
-----------------------------------------------------------
Project: SQL Server Backup Job
Author : Negar Kohnesal
Date   : 2025-08-18
-----------------------------------------------------------
Description:
این اسکریپت یک Job در SQL Server Agent ایجاد می‌کند
که هر روز از دیتابیس مشخص‌شده بک‌آپ می‌گیرد.

Steps:
1. ساخت Job
2. اضافه کردن Step برای بک‌آپ
3. زمان‌بندی اجرای Job (مثلاً روزانه ساعت 2 بامداد)
-----------------------------------------------------------
*/

-- 1. ساخت Job
USE msdb;
GO
EXEC sp_add_job
    @job_name = N'Database_AutoBackup',
    @description = N'Job for daily full backup of database';

-- 2. اضافه کردن Step
EXEC sp_add_jobstep
    @job_name = N'Database_AutoBackup',
    @step_name = N'BackupStep',
    @subsystem = N'TSQL',
    @command = N'BACKUP DATABASE [MyDatabase]
                 TO DISK = N''C:\SQLBackups\MyDatabase_Full.bak''
                 WITH INIT, STATS = 10',
    @retry_attempts = 3,
    @retry_interval = 5;

-- 3. زمان‌بندی اجرای Job
EXEC sp_add_schedule
    @schedule_name = N'DailyBackupSchedule',
    @freq_type = 4,              -- Daily
    @freq_interval = 1,          -- Every day
    @active_start_time = 020000; -- 02:00 AM

EXEC sp_attach_schedule
    @job_name = N'Database_AutoBackup',
    @schedule_name = N'DailyBackupSchedule';

-- 4. فعال‌سازی Job
EXEC sp_add_jobserver
    @job_name = N'Database_AutoBackup';
GO
