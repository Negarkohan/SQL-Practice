/*
=================================================================================
Author:       Negar Kohansal
Description:  Lists all triggers in databases 
=================================================================================
*/
SELECT 
    t.name AS TriggerName,
    t.type_desc AS TriggerType,
    t.is_disabled AS IsDisabled,
    s.name AS SchemaName,
    o.name AS TableName,
    CASE 
        WHEN t.parent_class_desc = 'DATABASE' THEN 'Database Trigger'
        WHEN t.parent_class_desc = 'OBJECT_OR_COLUMN' THEN 'Table Trigger'
        ELSE t.parent_class_desc
    END AS ParentType
FROM sys.triggers t
LEFT JOIN sys.objects o
    ON t.parent_id = o.object_id
LEFT JOIN sys.schemas s
    ON o.schema_id = s.schema_id
ORDER BY ParentType, SchemaName, TableName, TriggerName;
