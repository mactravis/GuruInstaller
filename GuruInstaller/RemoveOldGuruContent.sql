USE [mvdb]
GO

declare @playlists table(PlaylistId int NOT NULL UNIQUE, Guid uniqueidentifier NOT NULL)

INSERT INTO @playlists (PlaylistId, Guid)
	SELECT PlaylistId, Guid FROM tblPlaylists WHERE Guid IN (
		'BE50E07B-9720-4F0C-A6B3-C763442BBAF2',
		'E27D9145-75EF-4753-B96D-50451A346878',
		'E756F05F-A04E-4705-B880-CE0925F3612B',
		'7CD25725-A1FA-4C94-A4C3-9D04DBE8820C',
		--Below is current content lists
		'78eb61c1-507b-4fc2-a311-29017ed37629',
		'A7CF0F87-7314-4D6D-8DCA-6017C3AC171C',
		'EFA44DA4-172F-4A1E-824B-94F2DD47985C',
		'77EFEB90-7CF4-4999-8468-C11A93A7EF54',
		'734FA16E-E03D-4310-8DEC-C1544D8AC6E5',
		'11B46F39-2E3C-4AE2-BFD9-7BE8FD648DDD',
		'2EA34E95-B54E-4B5E-9A5D-7F4962FD94D8',
		'B2D925D2-9E57-439D-94F7-634473BE1A87',
		'530DDF15-2145-4528-ABCF-751BA1534A99',
		'CD1AAA4C-0FC4-47A2-9F73-89CA842815DE',
		'5F60BFF6-96D1-45BA-B2D0-C80370E4436A'
	)

-- Delete this playlists	
DELETE FROM tblPlaylists WHERE PlaylistId IN (SELECT PlaylistId FROM @playlists)

-- Remove playlist menu items
DELETE FROM tblMenus WHERE PlaylistId IN (SELECT PlaylistId FROM @playlists)

-- Remove any Menus referencing Media that is on these playlists
--DELETE FROM tblMenus WHERE MediaId IN (SELECT MediaId FROM tblMedia WHERE PlaylistId IN (SELECT PlaylistId FROM @playlists))

-- Remove playlist media paths
--DELETE FROM tblMediaPaths WHERE PathId IN (SELECT PathId FROM tblMedia WHERE PlaylistId IN (SELECT PlaylistId FROM @playlists))

-- Remove playlist media items
--DELETE FROM tblMedia WHERE PlaylistId IN (SELECT PlaylistId FROM @playlists)

-- Remove playlist top level items
DELETE FROM tblTopLevelMenu WHERE PlaylistId IN (SELECT PlaylistId FROM @playlists)

--UPDATE tblMenus SET MenuName = (SELECT TOP 1 MenuName FROM 

GO

-- Fix the sort orders
DECLARE @userIds table(UserId int NOT NULL UNIQUE)
INSERT INTO @userIds (UserId) SELECT UserId FROM tblUsers WHERE UserId != -1
DECLARE @stdPlaylists table(PlaylistId int NOT NULL UNIQUE)
INSERT INTO @stdPlaylists (PlaylistId) SELECT PlaylistId FROM tblPlaylists WHERE IsCustom = 0

declare @userId int

set @userId = (SELECT TOP 1 UserId FROM @userIds)
WHILE @userId IS NOT NULL BEGIN
	DECLARE @nextPosition int
	SET @nextPosition = (SELECT TOP 1 (SortOrder+1) as Sort FROM tblTopLevelMenu WHERE UserId = @userId AND PlaylistID IN (SELECT PlaylistId FROM @stdPlaylists) ORDER BY SortOrder DESC)
	
	DECLARE @fixme TABLE(PlaylistId int NOT NULL UNIQUE)
	
	INSERT INTO @fixme (PlaylistId)
	  SELECT PlaylistId FROM tblTopLevelMenu WHERE UserId != -1 AND
		PlaylistId NOT IN (SELECT PlaylistID FROM @stdPlaylists) AND
		SortOrder IN (SELECT SortOrder FROM tblTopLevelMenu WHERE UserId = @userId AND PlaylistId IN (SELECT PlaylistId FROM @stdPlaylists) )
		ORDER BY SortOrder ASC
		
	DECLARE @pid int
	SET @pid = (SELECT TOP 1 PlaylistId FROM @fixme)
	WHILE @pid IS NOT NULL BEGIN
		UPDATE tblTopLevelMenu SET SortOrder = @nextPosition WHERE UserId = @userId AND PlaylistId = @pid
		SET @nextPosition = @nextPosition + 1
		
		DELETE FROM @fixme WHERE PlaylistId = @pid
		SET @pid = (SELECT TOP 1 PlaylistID FROM @fixme)
	END

	DELETE FROM @userIds WHERE UserID = @userId
	SET @userId = (SELECT TOP 1 UserId FROM @userIds)
END

GO