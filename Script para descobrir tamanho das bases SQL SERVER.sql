USE DBSHI823
GO

SELECT
	T.NAME AS ENTIDADE,
	P.ROWS AS REGISTROS,
	(SUM(A.TOTAL PAGES) * 8)/1024 AS EspacoTotalMb,
	(SUM(A.USED_PAGES) * 8/1024 AS EspacoUsadoMb,
	(SUM(A.TOTA_PAGES) - SUM(A.USED_PAGES)) * 8)/1024 AS EspacoNaoUsadoMb
FROM 
	SYS.TABLES T
			INNER JOIN SYS.INDEXES I ON T.OBJECT_ID = I.OBJECT_ID
			INNER JOIN SYS.PARTITIONS P ON I.OBJECT_ID = P.OBJECT_ID AND I.INDEX_ID = P.INDEX_ID
			INNER JOIN SYS.ALLOCATION_UNITS A ON P.PARTITION_ID = A.CONTAINER_ID
			LEFT OUTER JOIN SYS.SCHEMAS S ON T.SCHEMA_ID = S.SCHEMA_ID
WHERE
	T.IS_MS_SHIPPED = 0 AND I.OBJECT_ID > 225
GROUP BY
	T.NAME, S.NAME, P.ROWS
ORDER BY 
	3 DESC