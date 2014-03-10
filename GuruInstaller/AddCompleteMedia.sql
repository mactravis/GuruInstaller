USE [mvdb]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AddCompleteMedia]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[AddCompleteMedia]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Thomas Luckart
-- Create date: 9/1/2011
-- Description:	Set parentId to NULL if this is a top level media item.
-- =============================================
CREATE PROCEDURE [AddCompleteMedia]
	-- Add the parameters for the stored procedure here
	@playlistId int,
	@parentId int, 
	@title nvarchar(50),
	@typeId int,
	@mediaGuid uniqueidentifier, 
	@mediaPath nvarchar(max)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON
	
	IF NOT EXISTS (SELECT * FROM tblPlaylists WHERE PlaylistId = @playlistId) BEGIN
		RAISERROR('PlaylistId ''%d'' does not exist in tblPlaylists', 10, 2, @playlistId);
	END
	
	IF @title IS NULL OR @title = '' BEGIN
		RAISERROR('Parameter @title cannot be null or empty.', 10, 2)
	END
	IF @typeId IS NULL OR @typeId <= 0 OR @typeId > = 4 BEGIN
		RAISERROR('Parameter @typeId is not an acceptable value. (1 - Movie w/ No Sound, 2 - Image, 3 - Movie w/ Sound)', 11, 2);
	END
	IF @mediaGuid IS NULL BEGIN
		RAISERROR('Parameter @mediaGuid cannot be NULL.', 10, 2);
	END
	IF @mediaPath IS NULL OR @mediaPath = '' BEGIN
		RAISERROR('Parameter @mediaPath cannot be NULL or empty.', 10, 2);
	END
	
	declare @sortOrder int
	
	IF @parentId IS NULL BEGIN
		SET @parentId = -1
		SET @sortOrder = (SELECT TOP 1 (SortOrder + 1) FROM tblMenus WHERE PlaylistId = @playlistId ORDER BY SortOrder DESC)
	END
	ELSE BEGIN
		IF NOT EXISTS (SELECT * FROM tblMenus WHERE Menuid = @parentId) BEGIN
			RAISERROR('Parameter @parentId must exist if not set to NULL.', 10, 2);
		END
		SET @sortOrder = (SELECT TOP 1 (SortOrder + 1) FROM tblMenus WHERE ParentId = @parentId ORDER BY SortOrder DESC)
	END
	
	IF @sortOrder IS NULL
		SET @sortOrder = 1
	
	declare @pathId int
	declare @mediaId int
	declare @menuId int

	IF EXISTS (SELECT * FROM tblMediaPaths WHERE Path = @mediaPath)
		SET @pathId = (SELECT TOP 1 PathId FROM tblMediaPaths WHERE Path = @mediaPath)
	ELSE BEGIN
		EXEC dbo.sp_mediapath_AddPath @mediaPath
		SET @pathId = (SELECT TOP 1 PathId FROM tblMediaPaths WHERE Path = @mediaPath)
	END

	IF EXISTS (SELECT * FROM tblMedia WHERE Guid = @mediaGuid) BEGIN
		IF @typeId = (SELECT TOP 1 TypeId FROM tblMedia WHERE Guid = @mediaGuid) BEGIN
			IF NOT EXISTS (SELECT * FROM tblMedia WHERE Guid = @mediaGuid AND PathId = @pathId) AND @pathId IS NOT NULL
				UPDATE tblMedia SET PathId = @pathId WHERE Guid = @mediaGuid
			SET @mediaId = (SELECT TOP 1 MediaId FROM tblMedia WHERE Guid = @mediaGuid)
		END
		ELSE BEGIN
			IF NOT EXISTS (SELECT * FROM tblMedia WHERE Guid = @mediaGuid AND PathId = @pathId) AND @pathId IS NOT NULL
				UPDATE tblMedia SET PathId = @pathId WHERE Guid = @mediaGuid
			SET @mediaId = (SELECT TOP 1 MediaId FROM tblMedia WHERE Guid = @mediaGuid)
			UPDATE tblMedia SET TypeId = @typeId WHERE Guid = @mediaGuid
		END
	END	ELSE BEGIN
		EXEC dbo.sp_media_AddMedia @mediaGuid, @typeId, @pathId, @playlistId
		SET @mediaId = (SELECT TOP 1 MediaId FROM tblMedia WHERE Guid = @mediaGuid)
	END
	--IF @mediaId IS NULL
	--	RAISERROR('MediaId is null and should not be.', 18, 2);
	
	IF EXISTS (SELECT * FROM tblMenus WHERE (MediaId = @mediaId AND MenuName = @title) AND ( (ParentId = -1 AND PlaylistId = @playlistId) OR (ParentId != -1 AND ParentId = @parentId) ) )
		SET @menuId = (SELECT TOP 1 MenuId FROM tblMenus WHERE
			(MediaId = @mediaId AND MenuName = @title) AND ( (ParentId = -1 AND PlaylistId = @playlistId) OR (ParentId != -1 AND ParentId = @parentId) ))
	ELSE BEGIN
		EXEC dbo.sp_menu_AddMenuItem @parentId, @sortOrder, @title, @mediaId, @playlistId
		SET @menuId = (SELECT TOP 1 MenuId FROM tblMenus WHERE (MediaId = @mediaId AND MenuName = @title) AND ( (ParentId = -1 AND PlaylistId = @playlistId) OR ParentId = @parentId))
	END
	print @menuId
	
	RETURN 0
END
GO
