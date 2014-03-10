-- CreateDatabase.sql
--
-- Author: Michael Cowan (7/29/2008)
--
-- This script performs several steps:
--
-- Step 1: Attempt to reconnect with an pre-existing MVDB database
-- Step 2: If there are no pre-existing MVDB databases a new one is created.

USE [master]
GO

DECLARE @data_path nvarchar(256);

-- Script Debugging Information
DECLARE @debug_message nvarchar(2048)
SET @debug_message = '' 

-- Step 1: Attempt to reconnect with an pre-existing MVDB database
-- QA History: Tested on SQL 2000 and 2005 Express (7/29/2009 - msc)
IF NOT EXISTS(SELECT NAME FROM SYSDATABASES WHERE NAME = 'MVDB') AND @data_path = ' '
	BEGIN
		SET @data_path = (SELECT SUBSTRING(filename, 1, CHARINDEX('master.mdf', LOWER(filename)) - 1)
              FROM master.dbo.sysdatabases
              WHERE name = 'master');
		SET @data_path = @data_path + 'mvdb.mdf';
		
		--DECLARE @temp 
		--IF (exec master.dbo.xp_fileexist @data_path) = 0
		--PRINT @temp
		
		--SET @debug_message = @debug_message + '@data_path = ' + @data_path + ', ';

		--EXEC ('CREATE DATABASE mvdb
		--	  ON (FILENAME = '''+ @data_path + 'mvdb.mdf'')
		--	  FOR ATTACH');
--		IF @@ERROR = 0
			--SET @debug_message = @debug_message + 'MVDB Database ReAttached, '
	END
--ELSE
	--PRINT 'Existing Database Check - Database Already Exists, '

			
-- Step 2: If there are no pre-existing MVDB databases a new one is created.
-- QA History: Tested on SQL 2000 and 2005 Express (7/29/2009 - msc)
IF NOT EXISTS(SELECT NAME FROM SYSDATABASES WHERE NAME = 'MVDB')
	BEGIN
		CREATE DATABASE [mvdb]
		IF @@ERROR = 0
			BEGIN
				EXEC dbo.sp_dbcmptlevel @dbname='mvdb', @new_cmptlevel=100
				
				IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
				BEGIN
					EXEC [mvdb].[dbo].[sp_fulltext_database] @action = 'enable'
				END
				
				ALTER DATABASE [mvdb] SET ANSI_NULL_DEFAULT OFF 
				ALTER DATABASE [mvdb] SET ANSI_NULLS OFF 
				ALTER DATABASE [mvdb] SET ANSI_PADDING OFF 
				ALTER DATABASE [mvdb] SET ANSI_WARNINGS OFF 
				ALTER DATABASE [mvdb] SET ARITHABORT OFF 
				ALTER DATABASE [mvdb] SET AUTO_CLOSE ON 
				ALTER DATABASE [mvdb] SET AUTO_CREATE_STATISTICS ON 
				ALTER DATABASE [mvdb] SET AUTO_SHRINK OFF 
				ALTER DATABASE [mvdb] SET AUTO_UPDATE_STATISTICS ON 
				ALTER DATABASE [mvdb] SET CURSOR_CLOSE_ON_COMMIT OFF 
				ALTER DATABASE [mvdb] SET CURSOR_DEFAULT  GLOBAL 
				ALTER DATABASE [mvdb] SET CONCAT_NULL_YIELDS_NULL OFF 
				ALTER DATABASE [mvdb] SET NUMERIC_ROUNDABORT OFF 
				ALTER DATABASE [mvdb] SET QUOTED_IDENTIFIER OFF 
				ALTER DATABASE [mvdb] SET RECURSIVE_TRIGGERS OFF 
				ALTER DATABASE [mvdb] SET  READ_WRITE 
				ALTER DATABASE [mvdb] SET RECOVERY SIMPLE 
				ALTER DATABASE [mvdb] SET  MULTI_USER 
				
				--PRINT 'New MVDB Database Created, '
			END
	END
--ELSE
	--PRINT 'New Database Check - Database Already Exists, '
