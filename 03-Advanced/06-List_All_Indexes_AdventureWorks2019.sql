use AdventureWorks2019
SELECT 
    t.name AS TableName,
    i.name AS IndexName,
    i.type_desc AS IndexType,
    c.name AS ColumnName,
    ic.key_ordinal AS ColumnOrder,
    i.is_unique AS IsUnique,
    i.is_primary_key AS IsPrimaryKey
FROM 
    sys.indexes i
INNER JOIN 
    sys.index_columns ic ON i.object_id = ic.object_id AND i.index_id = ic.index_id
INNER JOIN 
    sys.columns c ON ic.object_id = c.object_id AND ic.column_id = c.column_id
INNER JOIN 
    sys.tables t ON i.object_id = t.object_id
WHERE 
    t.is_ms_shipped = 0  -- فقط جداول کاربر
ORDER BY 
    t.name, i.name, ic.key_ordinal;
