-- CreateUsers.sql
--
-- Author: Michael Cowan (7/29/2008)
--
-- This script performs several steps:
--
-- Step 1: Add the hardcoded Skookum user to the MVDB database
-- Step 2: Give the Skookum user the correct permissions to the MVDB database

USE [master]
GO

-- Script Debugging Information
DECLARE @debug_message nvarchar(2048)
SET @debug_message = ''

-- Step 1: Add the hardcoded Skookum user to the MVDB database
-- QA History: Tested on SQL 2000 and 2005 Express (7/29/2009 - msc)
IF NOT EXISTS(SELECT * FROM Master.dbo.syslogins WHERE name='skookum')
   BEGIN
		EXEC master.dbo.sp_addlogin @loginame = 'skookum', @passwd = 'I81@gr8ness', @defdb = 'mvdb', @deflanguage = 'us_english'
		--SET @debug_message = @debug_message + 'Added login for the skookum user, '
	END
--ELSE
	--SET @debug_message = @debug_message + 'The skookum user already has a login, '

-- Step 2: Give the Skookum user the correct permissions to the MVDB database
-- QA History: Tested on SQL 2000 and 2005 Express (7/29/2009 - msc)

USE[mvdb]
IF EXISTS(SELECT * FROM sysusers WHERE name='skookum')
	BEGIN
		EXEC sp_droprolemember 'db_owner', 'skookum'		
		EXEC sp_dropuser 'skookum'
		--SET @debug_message = @debug_message + 'Deleted skookum user from sysusers, '
	END
--ELSE
	--SET @debug_message = @debug_message + 'The skookum user does not exists in sysusers, '
	
IF NOT EXISTS(SELECT * FROM sysusers WHERE name='skookum')
	BEGIN
		EXEC sp_grantdbaccess 'skookum'
		EXEC sp_addrolemember 'db_owner', 'skookum'
		--SET @debug_message = @debug_message + 'Added Access/Roles for the skookum user in sysusers, '
	END
--ELSE
	--SET @debug_message = @debug_message + 'The skookum user was already in sysusers, '

--SELECT @debug_message