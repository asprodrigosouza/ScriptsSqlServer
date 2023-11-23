DECLARE @tableName NVARCHAR(255)
DECLARE @newTableName NVARCHAR(255)
DECLARE @sql NVARCHAR(MAX)

SELECT name
INTO #TempTableList
FROM sys.tables

WHILE EXISTS (SELECT * FROM #TempTableList)
BEGIN
    SELECT TOP 1 @tableName = name FROM #TempTableList
    SET @newTableName = @tableName + '_old'

    SET @sql = 'EXEC sp_rename ''' + @tableName + ''', ''' + @newTableName + ''''
    EXEC sp_executesql @sql

    DELETE FROM #TempTableList WHERE name = @tableName
END

DROP TABLE #TempTableList