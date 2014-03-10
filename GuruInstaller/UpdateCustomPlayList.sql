
declare @libraryPlaylist int
SET @libraryPlaylist = (SELECT TOP 1 PlaylistId FROM tblPlaylists WHERE Guid = '78eb61c1-507b-4fc2-a311-29017ed37629')

declare @source table(MenuId int NOT NULL UNIQUE)

INSERT INTO @source (MenuId) 
SELECT MenuId FROM tblMenus WHERE 
	PlaylistId IN (SELECT PlaylistId FROM tblPlaylists WHERE IsCustom = 1)
	AND
	MediaId IN (SELECT MediaId FROM tblMenus WHERE PlaylistId = @libraryPlaylist)
	
declare @currentMenu int
set @currentMenu = (SELECT TOP 1 MenuId FROM @source)

WHILE @currentMenu IS NOT NULL BEGIN
	declare @mediaId int
	set @mediaId = (SELECT TOP 1 MediaId FROM tblMenus WHERE MenuId = @currentMenu)
	UPDATE tblMenus SET MenuName = (SELECT TOP 1 MenuName FROM tblMenus WHERE MediaId = @mediaId AND PlaylistId = @libraryPlaylist)
		WHERE MenuId = @currentMenu

	DELETE FROM @source WHERE MenuId = @currentMenu
	SET @currentMenu = (SELECT TOP 1 MenuId FROM @source)
END