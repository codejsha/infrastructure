USE [Northwind]
GO


-- enable cdc for db
EXEC sys.sp_cdc_enable_db
GO


-- enable cdc for all tables
DECLARE @Schema AS VARCHAR(50)
DECLARE @Table AS VARCHAR(50)

DECLARE table_cursor CURSOR FOR
SELECT TABLE_SCHEMA, TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND TABLE_TYPE = 'BASE TABLE';

OPEN table_cursor;
FETCH NEXT FROM table_cursor INTO @Schema, @Table;

WHILE @@FETCH_STATUS = 0
BEGIN
EXEC sys.sp_cdc_enable_table
	@source_schema = @Schema,
	@source_name   = @Table,
	@role_name     = NULL,
	@filegroup_name = N'PRIMARY',
	@supports_net_changes = 0

FETCH NEXT FROM table_cursor INTO @Schema, @Table;
END

CLOSE table_cursor
DEALLOCATE table_cursor


-- check cdc configuration
EXEC sys.sp_cdc_help_change_data_capture
GO
