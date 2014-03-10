
-- CreateBaseline.sql
--
-- Author: Michael Cowan (7/29/2008)
--
-- This script performs several steps:
--
-- Step 1: Create Guru 3.1 Baseline Tables
-- Step 2: Repair possible NULL Values from Damaged CEP Builds
-- Step 3: Populate Guru 3.1 Baseline Tables
-- Step 4: Create Guru 3.1 Baseline Stored Procedures

USE [mvdb]

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Script Debugging Information
DECLARE @debug_message nvarchar(2048)
SET @debug_message = '' 

-- Step 1: Create Guru 3.1 Baseline Tables

/****** Object:  Table [dbo].[tblAudio]    Script Date: 08/03/2009 14:56:28 ******/

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblAudio]') AND type in (N'U'))
	BEGIN
		CREATE TABLE [dbo].[tblAudio](
			[Guid] [uniqueidentifier] NOT NULL,
			[Data] [image] NOT NULL
		) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
		--SET @debug_message = @debug_message + 'Created  Table [dbo].[tblAudio], '
	END
--ELSE
	--SET @debug_message = @debug_message + 'Table [dbo].[tblAudio] already exists, '

/****** Object:  Table [dbo].[tblAudioLinks]    Script Date: 08/03/2009 14:56:28 ******/
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblAudioLinks]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblAudioLinks](
	[MenuID] [int] NOT NULL,
	[AudioGuid] [uniqueidentifier] NOT NULL
) ON [PRIMARY]
END
/****** Object:  Table [dbo].[tblMediaPaths]    Script Date: 08/03/2009 14:56:28 ******/

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblMediaPaths]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblMediaPaths](
	[PathID] [int] IDENTITY(1,1) NOT NULL,
	[Path] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_tblMediaPaths] PRIMARY KEY CLUSTERED 
(
	[PathID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
/****** Object:  Table [dbo].[tblMenus]    Script Date: 08/03/2009 14:56:28 ******/
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblMenus]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblMenus](
	[MenuID] [int] IDENTITY(1,1) NOT NULL,
	[ParentID] [int] NULL,
	[SortOrder] [int] NULL,
	[MenuName] [nvarchar](50) NULL,
	[MediaID] [int] NULL,
	[PlaylistID] [int] NULL,
 CONSTRAINT [PK_tblMenus] PRIMARY KEY CLUSTERED 
(
	[MenuID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
/****** Object:  Table [dbo].[tblPatientImages]    Script Date: 08/03/2009 14:56:28 ******/
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblPatientImages]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblPatientImages](
	[ImageID] [int] NOT NULL,
	[PatientID] [int] NOT NULL,
	[ImageTitle] [nvarchar](150) NULL,
	[CreateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_tblPatientImages] PRIMARY KEY CLUSTERED 
(
	[ImageID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
/****** Object:  Table [dbo].[tblAudioScripts]    Script Date: 08/03/2009 14:56:28 ******/
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblAudioScripts]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblAudioScripts](
	[MenuID] [int] NULL,
	[Script] [nvarchar](max) NULL
) ON [PRIMARY]
END
/****** Object:  Table [dbo].[tblPatients]    Script Date: 08/03/2009 14:56:28 ******/
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblPatients]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblPatients](
	[PatientID] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](50) NULL,
	[LastName] [nvarchar](50) NULL,
	[AccountNumber] [nvarchar](50) NULL,
	[IntegrationID] [nvarchar](50) NULL,
 CONSTRAINT [PK_tblPatients] PRIMARY KEY CLUSTERED 
(
	[PatientID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
/****** Object:  Table [dbo].[tblPatientPlaylists]    Script Date: 06/08/2009 15:59:49 ******/
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblPatientPlaylists]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblPatientPlaylists](
	[PatientID] [int] NOT NULL,
	[PlaylistID] [int] NOT NULL,
	[SortOrder] [int] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[ModifiedDate] [datetime] NOT NULL
) ON [PRIMARY]
END
/****** Object:  Table [dbo].[tblPlaylists]    Script Date: 08/03/2009 14:56:28 ******/
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblPlaylists]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblPlaylists](
	[GUID] [uniqueidentifier] NULL,
	[PlaylistID] [int] IDENTITY(1,1) NOT NULL,
	[ListName] [nvarchar](50) NULL,
	[IsCustom] [bit] NOT NULL,
	[InstallDate] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NULL,
	[IsLicensed] [bit] NOT NULL,
	[IsExpired] [bit] NOT NULL,
 CONSTRAINT [PK_tblContentPacks] PRIMARY KEY CLUSTERED 
(
	[PlaylistID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
/****** Object:  Table [dbo].[tblPracticeInfo]    Script Date: 08/03/2009 14:56:28 ******/
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblPracticeInfo]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblPracticeInfo](
	[PracticeID] [int] IDENTITY(1,1) NOT NULL,
	[PracticeInfo] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_tblPracticeInfo] PRIMARY KEY CLUSTERED 
(
	[PracticeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
/****** Object:  Table [dbo].[tblTopLevelMenu]    Script Date: 08/03/2009 14:56:28 ******/
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblTopLevelMenu]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblTopLevelMenu](
	[UserID] [int] NOT NULL,
	[PlaylistID] [int] NOT NULL,
	[SortOrder] [int] NOT NULL,
	[IsVisible] [bit] NOT NULL
) ON [PRIMARY]
END
/****** Object:  Table [dbo].[tblUsers]    Script Date: 08/03/2009 14:56:28 ******/
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblUsers]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblUsers](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [nvarchar](150) NULL,
	[DefaultCustomPlaylist] [nvarchar](50) NULL,
	[MenuOnRight] [bit] NULL,
 CONSTRAINT [PK_tblUsers] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
/****** Object:  Table [dbo].[tblMedia]    Script Date: 08/03/2009 14:56:28 ******/
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblMedia]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblMedia](
	[MediaID] [int] IDENTITY(1,1) NOT NULL,
	[GUID] [uniqueidentifier] NULL,
	[TypeID] [int] NULL,
	[PathID] [int] NULL,
	[PlaylistID] [int] NULL,
 CONSTRAINT [PK_tblMedia] PRIMARY KEY CLUSTERED 
(
	[MediaID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END

-- Step 2: Repair possible NULL Values from Damaged CEP Builds
DELETE tblMedia WHERE GUID IS NULL
DELETE tblMedia WHERE PathID IS NULL
DELETE tblMedia WHERE MediaID IS NULL
DELETE tblMedia WHERE PlaylistID IS NULL
DELETE tblMenus WHERE SortOrder IS NULL
DELETE tblMenus WHERE MediaID IS NULL

-- Step 3: Populate Guru 3.1 Baseline Tables

-- Step 4: Create Guru 3.1 Baseline Stored Procedures

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_patient_AddPatientPlaylist]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[sp_patient_AddPatientPlaylist]
END
GO
-- =============================================
-- Author:		Michael Prestwich
-- =============================================
CREATE PROCEDURE [dbo].[sp_patient_AddPatientPlaylist] 
	-- Add the parameters for the stored procedure here
	@patientID int, 
	@playlistID int,
	@sortOrder int,
	@createDate datetime
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO tblPatientPlaylists
		(PatientID, PlaylistID, SortOrder, CreateDate, ModifiedDate)
		VALUES (@patientID, @playlistID, @sortOrder, @createDate, @createDate)
END
GO

/****** Object:  StoredProcedure [dbo].[sp_patient_DeletePatientPlaylist]    Script Date: 06/08/2009 16:00:43 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_patient_DeletePatientPlaylist]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[sp_patient_DeletePatientPlaylist]
END
GO
-- =============================================
-- Author:		Michael Prestwich
-- =============================================
CREATE PROCEDURE [dbo].[sp_patient_DeletePatientPlaylist] 
	-- Add the parameters for the stored procedure here
	@playlistID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DELETE FROM tblPatientPlaylists WHERE PlaylistID = @playlistID
END
GO

/****** Object:  StoredProcedure [dbo].[sp_patient_GetPlaylistByPatientID]    Script Date: 06/08/2009 16:01:02 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_patient_GetPlaylistByPatientID]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[sp_patient_GetPlaylistByPatientID]
END
GO
-- =============================================
-- Author:		Michael Prestwich
-- =============================================
CREATE PROCEDURE [dbo].[sp_patient_GetPlaylistByPatientID] 
	-- Add the parameters for the stored procedure here
	@PatientID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
		SELECT PlaylistID, SortOrder, CreateDate, ModifiedDate 
		from tblPatientPlaylists where PatientID = @PatientID;
END
GO

/****** Object:  StoredProcedure [dbo].[sp_patient_ModifyPatientPlaylist]    Script Date: 8/18/2009 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_patient_ModifyPatientPlaylist]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[sp_patient_ModifyPatientPlaylist]
END
GO
-- =============================================
-- Author:		Michael Prestwich
-- =============================================
CREATE PROCEDURE [dbo].[sp_patient_ModifyPatientPlaylist] 
	-- Add the parameters for the stored procedure here
	@playlistID int,
	@ModifiedDate datetime
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE tblPatientPlaylists
		SET ModifiedDate = @ModifiedDate
		WHERE PlaylistID = @playlistID
END
GO

/****** Object:  StoredProcedure [dbo].[sp_menu_UpdateMenuItemSortOrderByID]    Script Date: 06/10/2009 16:32:32 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_menu_UpdateMenuItemSortOrderByID]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[sp_menu_UpdateMenuItemSortOrderByID]
END
GO
-- =============================================
-- Author:		<James Ballard>
-- =============================================
CREATE PROCEDURE [dbo].[sp_menu_UpdateMenuItemSortOrderByID] 
	-- Add the parameters for the stored procedure here
	@MenuID int,
	@SortOrder int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE tblMenus
		SET SortOrder = @SortOrder
		WHERE MenuID = @MenuID
END
GO

/****** Object:  StoredProcedure [dbo].[sp_menu_RenameMenuItemByID]    Script Date: 06/10/2009 16:33:19 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_menu_RenameMenuItemByID]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[sp_menu_RenameMenuItemByID]
END
GO
-- =============================================
-- Author:		<Michael Prestwich>
-- =============================================
CREATE PROCEDURE [dbo].[sp_menu_RenameMenuItemByID] 
	-- Add the parameters for the stored procedure here
	@MenuID int,
	@MenuName nvarchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE tblMenus
		SET MenuName = @MenuName
		WHERE MenuID = @MenuID
END
GO

/****** Object:  StoredProcedure [dbo].[sp_image_GetPatientImageByID]    Script Date: 08/03/2009 14:56:26 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_image_GetPatientImageByID]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[sp_image_GetPatientImageByID]
END
GO
-- =============================================
-- Author:		<James Ballard>
-- =============================================
CREATE PROCEDURE [dbo].[sp_image_GetPatientImageByID] 
	-- Add the parameters for the stored procedure here
	@ImageID int
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.

    -- Insert statements for procedure here
	SELECT i.ImageID, i.ImageData, p.PatientID, p.ImageTitle FROM tblImages i INNER JOIN tblPatientImages p ON i.ImageID = p.ImageID WHERE i.ImageID = @ImageID
END
GO

/****** Object:  StoredProcedure [dbo].[sp_image_GetPatientImageByPatientID]    Script Date: 08/03/2009 14:56:26 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_image_GetPatientImageByPatientID]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[sp_image_GetPatientImageByPatientID]
END
GO
-- =============================================
-- Author:		<James Ballard>
-- =============================================
CREATE PROCEDURE [dbo].[sp_image_GetPatientImageByPatientID] 
	-- Add the parameters for the stored procedure here
	@PatientID int
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.

    -- Insert statements for procedure here

	--- 04/03/07 Michael - changed return column from PatientID to CreateDate
	SELECT i.ImageID, i.ImageData, p.CreateDate, p.ImageTitle FROM tblImages i INNER JOIN tblPatientImages p ON i.ImageID = p.ImageID WHERE p.PatientID = @PatientID
END
GO

/****** Object:  StoredProcedure [dbo].[sp_image_GetImageByID]    Script Date: 08/03/2009 14:56:26 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_image_GetImageByID]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[sp_image_GetImageByID]
END
GO
-- =============================================
-- Author:		<James Ballard>
-- =============================================
CREATE PROCEDURE [dbo].[sp_image_GetImageByID] 
	-- Add the parameters for the stored procedure here
	@ImageID int
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM tblImages WHERE ImageID = @ImageID
END
GO

/****** Object:  StoredProcedure [dbo].[sp_image_DeleteImportImageByID]    Script Date: 08/03/2009 14:56:26 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_image_DeleteImportImageByID]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[sp_image_DeleteImportImageByID]
END
GO
-- =============================================
-- Author:		<James Ballard>
-- =============================================
CREATE PROCEDURE [dbo].[sp_image_DeleteImportImageByID] 
	-- Add the parameters for the stored procedure here
	@ImageID int
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	DECLARE @ImgID int
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	Delete From tblImages
		Where ImageID = @ImageID
END
GO

/****** Object:  StoredProcedure [dbo].[sp_image_AddImportImage]    Script Date: 08/03/2009 14:56:26 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_image_AddImportImage]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[sp_image_AddImportImage]
END
GO
-- =============================================
-- Author:		<James Ballard>
-- =============================================
CREATE PROCEDURE [dbo].[sp_image_AddImportImage] 
	-- Add the parameters for the stored procedure here
	@ImageData image
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO tblImages
		(ImageData)
		VALUES (@ImageData)

	SELECT TOP 1 ImageID FROM tblImages ORDER BY ImageID DESC
END
GO

/****** Object:  StoredProcedure [dbo].[sp_image_UpdateImageByID]    Script Date: 08/03/2009 14:56:26 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_image_UpdateImageByID]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[sp_image_UpdateImageByID]
END
GO
-- =============================================
-- Author:		<James Ballard>
-- =============================================
CREATE PROCEDURE [dbo].[sp_image_UpdateImageByID] 
	-- Add the parameters for the stored procedure here
	@ImageID int,
	@ImageData image
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.

    -- Insert statements for procedure here
	UPDATE tblImages SET ImageData = @ImageData WHERE ImageID = @ImageID
END
GO

/****** Object:  StoredProcedure [dbo].[sp_audio_AddAudio]    Script Date: 08/03/2009 14:56:26 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_audio_AddAudio]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[sp_audio_AddAudio]
END
GO
-- =============================================
-- Author:		<Michael Prestwich>
-- =============================================
CREATE PROCEDURE [dbo].[sp_audio_AddAudio] 
	-- Add the parameters for the stored procedure here
	@Guid uniqueidentifier, 
	@Data image 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO tblAudio (Guid, Data) VALUES (@Guid, @Data)
END
GO

/****** Object:  StoredProcedure [dbo].[sp_audio_GetAudio]    Script Date: 08/03/2009 14:56:26 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_audio_GetAudio]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[sp_audio_GetAudio]
END
GO
-- =============================================
-- Author:		<Michael Prestwich>
-- =============================================
CREATE PROCEDURE [dbo].[sp_audio_GetAudio]
	-- Add the parameters for the stored procedure here
	@Guid uniqueidentifier 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT Data FROM tblAudio WHERE Guid=@Guid
END
GO

/****** Object:  StoredProcedure [dbo].[sp_audio_RemoveLink]    Script Date: 08/03/2009 14:56:26 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_audio_RemoveLink]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[sp_audio_RemoveLink]
END
GO
-- =============================================
-- Author:		<Michael Prestwich>
-- =============================================
CREATE PROCEDURE [dbo].[sp_audio_RemoveLink]
	-- Add the parameters for the stored procedure here
	@MenuID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DELETE FROM tblAudioLinks WHERE MenuID=@MenuID
END
GO

/****** Object:  StoredProcedure [dbo].[sp_audio_UpdateLink]    Script Date: 08/03/2009 14:56:26 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_audio_UpdateLink]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[sp_audio_UpdateLink]
END
GO
-- =============================================
-- Author:		<Michael Prestwich>
-- =============================================
CREATE PROCEDURE [dbo].[sp_audio_UpdateLink]
	-- Add the parameters for the stored procedure here
	@MenuID int,
	@AudioGuid uniqueidentifier
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE tblAudioLinks SET AudioGuid=@AudioGuid WHERE MenuID=@MenuID
END
GO

/****** Object:  StoredProcedure [dbo].[sp_audio_AddLink]    Script Date: 08/03/2009 14:56:26 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_audio_AddLink]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[sp_audio_AddLink]
END	
GO
-- =============================================
-- Author:		<Michael Prestwich>
-- =============================================
CREATE PROCEDURE [dbo].[sp_audio_AddLink]
	-- Add the parameters for the stored procedure here
	@MenuID int,
	@AudioGuid uniqueidentifier
AS
BEGIN
	/* SET NOCOUNT ON added to prevent extra result sets from
	   interfering with SELECT statements. */
	SET NOCOUNT ON;

	DECLARE @rowCt INT;
	SELECT @rowCt = COUNT(1) from tblAudioLinks WHERE [MenuId]=@MenuId;
	if(@rowCt = 0)
	BEGIN
		/* Insert statements for procedure here */
		INSERT INTO tblAudioLinks (MenuID, AudioGuid) VALUES (@MenuID, @AudioGuid)
	END
END
GO

/****** Object:  StoredProcedure [dbo].[sp_audio_GetAllLinks]    Script Date: 08/03/2009 14:56:26 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_audio_GetAllLinks]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[sp_audio_GetAllLinks]
END
GO
-- =============================================
-- Author:		<Michael Prestwich>
-- =============================================
CREATE PROCEDURE [dbo].[sp_audio_GetAllLinks]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM tblAudioLinks
END
GO

/****** Object:  StoredProcedure [dbo].[sp_mediapath_AddPath]    Script Date: 08/03/2009 14:56:26 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_mediapath_AddPath]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[sp_mediapath_AddPath]
END
GO
-- =============================================
-- Author:		<James Ballard>
-- =============================================
CREATE PROCEDURE [dbo].[sp_mediapath_AddPath] 
	-- Add the parameters for the stored procedure here
	@Path nvarchar(max)
	
AS
BEGIN
	/* SET NOCOUNT ON added to prevent extra result sets from */
	/* interfering with SELECT statements. */
	SET NOCOUNT ON;

	DECLARE @rowCt INT;
	SELECT @rowCt = COUNT(1) from tblMediaPaths WHERE [Path]=@Path;
	if(@rowCt = 0)
	BEGIN
		/* Insert statements for procedure here */
		INSERT INTO tblMediaPaths
			([Path])
			VALUES (@Path)
	END
	
	SELECT TOP 1 PathID FROM tblMediaPaths WHERE [Path]=@Path
END
GO

/****** Object:  StoredProcedure [dbo].[sp_media_DeletePathByID]    Script Date: 08/03/2009 14:56:26 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_media_DeletePathByID]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[sp_media_DeletePathByID]
END
GO
-- =============================================
-- Author:		<James Ballard>
-- =============================================
CREATE PROCEDURE [dbo].[sp_media_DeletePathByID]
	-- Add the parameters for the stored procedure here
	@PathID int
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DELETE FROM tblMediaPaths WHERE PathID = @PathID
END
GO

/****** Object:  StoredProcedure [dbo].[sp_mediapath_GetPathByID]    Script Date: 08/03/2009 14:56:26 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_mediapath_GetPathByID]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[sp_mediapath_GetPathByID]
END
GO
-- =============================================
-- Author:		<James Ballard>
-- =============================================
CREATE PROCEDURE [dbo].[sp_mediapath_GetPathByID]
	-- Add the parameters for the stored procedure here
	@PathID int
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM tblMediaPaths WHERE PathID = @PathID
END
GO

/****** Object:  StoredProcedure [dbo].[sp_mediapath_UpdatePathByID]    Script Date: 08/03/2009 14:56:26 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_mediapath_UpdatePathByID]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[sp_mediapath_UpdatePathByID]
END
GO
-- =============================================
-- Author:		<James Ballard>
-- =============================================
CREATE PROCEDURE [dbo].[sp_mediapath_UpdatePathByID]
	-- Add the parameters for the stored procedure here
	@PathID	int,
	@Path nvarchar(max)
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE tblMediaPaths
		SET [Path] = @Path
		WHERE PathID = @PathID
END
GO

/****** Object:  StoredProcedure [dbo].[sp_image_DeletePatientImageByID]    Script Date: 08/03/2009 14:56:26 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_image_DeletePatientImageByID]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[sp_image_DeletePatientImageByID] 
END
GO
-- =============================================
-- Author:		<James Ballard>
-- =============================================
CREATE PROCEDURE [dbo].[sp_image_DeletePatientImageByID] 
	-- Add the parameters for the stored procedure here
	@ImageID int
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	DECLARE @ImgID int
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	Delete From tblMediaPaths
		Where PathId = @ImageID
	Delete From tblPatientImages
		Where ImageID = @ImageID
END
GO

/****** Object:  StoredProcedure [dbo].[sp_image_DeletePatientImageByPatientID]    Script Date: 08/03/2009 14:56:26 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_image_DeletePatientImageByPatientID]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[sp_image_DeletePatientImageByPatientID] 
END
GO
-- =============================================
-- Author:		<James Ballard>
-- =============================================
CREATE PROCEDURE [dbo].[sp_image_DeletePatientImageByPatientID] 
	-- Add the parameters for the stored procedure here
	@PatientID int
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	DECLARE @ImgID int
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	Delete From tblMediaPaths
		Where PathID IN 
		(SELECT ImageID FROM tblPatientImages WHERE PatientID = @PatientID)
	Delete From tblPatientImages
		Where PatientID = @PatientID
END  
GO

/****** Object:  StoredProcedure [dbo].[sp_menu_AddMenuItem]    Script Date: 08/03/2009 14:56:26 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_menu_AddMenuItem]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[sp_menu_AddMenuItem]
END
GO
-- =============================================
-- Author:		<James Ballard>
-- Create date: <0/29/2007>
-- Description:	<Takes a MenuID and returns the children of that ID>
-- =============================================
CREATE PROCEDURE [dbo].[sp_menu_AddMenuItem] 
	-- Add the parameters for the stored procedure here
	@ParentID int,
	@SortOrder int,
	@MenuName nvarchar(50),
	@MediaID int,
	@PlaylistID int
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO tblMenus
		(ParentID, SortOrder, MediaID, PlaylistID, MenuName)
		VALUES (@ParentID, @SortOrder, @MediaID, @PlaylistID, @MenuName)

	SELECT TOP 1 MenuID FROM tblMenus ORDER BY MenuID DESC
END
GO

/****** Object:  StoredProcedure [dbo].[sp_menu_DeleteMenuItemByID]    Script Date: 08/03/2009 14:56:26 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_menu_DeleteMenuItemByID]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[sp_menu_DeleteMenuItemByID]
END
GO
-- =============================================
-- Author:		<James Ballard>
-- =============================================
CREATE PROCEDURE [dbo].[sp_menu_DeleteMenuItemByID] 
	-- Add the parameters for the stored procedure here
	@MenuID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DELETE FROM tblMenus WHERE MenuID IN (SELECT MenuID FROM dbo.fnGetMenuChildren(@MenuID))	
	DELETE FROM tblMenus WHERE MenuID = @MenuID
	

END
GO

/****** Object:  StoredProcedure [dbo].[sp_menu_DeleteMenuItemByParentID]    Script Date: 08/03/2009 14:56:26 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_menu_DeleteMenuItemByParentID]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[sp_menu_DeleteMenuItemByParentID]
END
GO
-- =============================================
-- Author:		<James Ballard>
-- =============================================
CREATE PROCEDURE [dbo].[sp_menu_DeleteMenuItemByParentID] 
	-- Add the parameters for the stored procedure here
	@ParentID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DELETE FROM tblMenus WHERE MenuID IN (SELECT MenuID FROM dbo.fnGetMenuChildren(@ParentID))
	DELETE FROM tblMenus WHERE ParentID = @ParentID
END
GO

/****** Object:  StoredProcedure [dbo].[sp_menu_DeleteMenuItemByPlaylistID]    Script Date: 08/03/2009 14:56:26 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_menu_DeleteMenuItemByPlaylistID]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[sp_menu_DeleteMenuItemByPlaylistID]
END
GO
-- =============================================
-- Author:		<James Ballard>
-- =============================================
CREATE PROCEDURE [dbo].[sp_menu_DeleteMenuItemByPlaylistID] 
	-- Add the parameters for the stored procedure here
	@PlaylistID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DELETE FROM tblMenus WHERE PlaylistID = @PlaylistID
END
GO

/****** Object:  StoredProcedure [dbo].[sp_menu_GetMenuItemByID]    Script Date: 08/03/2009 14:56:26 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_menu_GetMenuItemByID]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[sp_menu_GetMenuItemByID] 
END
GO
-- =============================================
-- Author:		<James Ballard>
-- Create date: <0/29/2007>
-- Description:	<Takes a MenuID and returns the children of that ID>
-- =============================================
CREATE PROCEDURE [dbo].[sp_menu_GetMenuItemByID] 
	-- Add the parameters for the stored procedure here
	@MenuID int
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * from tblMenus where MenuID = @MenuID
END
GO

/****** Object:  StoredProcedure [dbo].[sp_menu_GetMenuItemByParentID]    Script Date: 08/03/2009 14:56:26 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_menu_GetMenuItemByParentID]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[sp_menu_GetMenuItemByParentID] 
END
GO
-- =============================================
-- Author:		<James Ballard>
-- Create date: <0/29/2007>
-- Description:	<Takes a MenuID and returns the children of that ID>
-- =============================================
CREATE PROCEDURE [dbo].[sp_menu_GetMenuItemByParentID] 
	-- Add the parameters for the stored procedure here
	@ParentID int
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * from tblMenus where ParentID = @ParentID Order By SortOrder
END
GO

/****** Object:  StoredProcedure [dbo].[sp_menu_GetMenuItemByMediaID]    Script Date: 08/03/2009 14:56:26 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_menu_GetMenuItemByMediaID]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[sp_menu_GetMenuItemByMediaID] 
END
GO
-- =============================================
-- Author:		<James Ballard>
-- =============================================
CREATE PROCEDURE [dbo].[sp_menu_GetMenuItemByMediaID] 
	-- Add the parameters for the stored procedure here
	@PlaylistID int
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM tblMenus WHERE PlaylistID LIKE @PlaylistID
END
GO

/****** Object:  StoredProcedure [dbo].[sp_menu_GetMenuItemByPlaylistID]    Script Date: 08/03/2009 14:56:26 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_menu_GetMenuItemByPlaylistID]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[sp_menu_GetMenuItemByPlaylistID] 
END
GO
-- =============================================
-- Author:		<James Ballard>
-- =============================================
CREATE PROCEDURE [dbo].[sp_menu_GetMenuItemByPlaylistID] 
	-- Add the parameters for the stored procedure here
	@PlaylistID int
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM tblMenus WHERE PlaylistID LIKE @PlaylistID
END
GO

/****** Object:  StoredProcedure [dbo].[sp_menu_GetParentIDByChildID]    Script Date: 08/03/2009 14:56:26 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_menu_GetParentIDByChildID]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[sp_menu_GetParentIDByChildID]
END
GO
-- =============================================
-- Author:		<James Ballard>
-- =============================================
CREATE PROCEDURE [dbo].[sp_menu_GetParentIDByChildID] 
	-- Add the parameters for the stored procedure here
	@ChildID int
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT ParentID FROM tblMenus WHERE MenuID = @ChildID
END
GO

/****** Object:  StoredProcedure [dbo].[sp_menu_UpdateMenuItemByID]    Script Date: 08/03/2009 14:56:26 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_menu_UpdateMenuItemByID]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[sp_menu_UpdateMenuItemByID]
END
GO
-- =============================================
-- Author:		<James Ballard>
-- =============================================
CREATE PROCEDURE [dbo].[sp_menu_UpdateMenuItemByID] 
	-- Add the parameters for the stored procedure here
	@MenuID int,
	@ParentID int,
	@SortOrder int,
	@MenuName nvarchar(50),
	@MediaID int,
	@PlaylistID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE tblMenus
		SET MenuName = @MenuName, MediaID = @MediaID, ParentID = @ParentID,
			SortOrder = @SortOrder, PlaylistID = @PlaylistID
		WHERE MenuID = @MenuID
END
GO

/****** Object:  UserDefinedFunction [dbo].[fnGetMenuChildren]    Script Date: 08/03/2009 14:56:29 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fnGetMenuChildren]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
	DROP FUNCTION [dbo].[fnGetMenuChildren]
END
GO
CREATE FUNCTION [dbo].[fnGetMenuChildren]
(
 @MenuID AS INT
)

RETURNS @ChildMenuIDs TABLE(MenuID INT)

AS

BEGIN
 INSERT INTO @ChildMenuIDs (MenuID)
  SELECT MenuID FROM tblMenus WHERE ParentID = @MenuID

 DECLARE @TempChildMenuIDs TABLE(MenuID INT)
 INSERT INTO @TempChildMenuIDs (MenuID)
  SELECT MenuID FROM @ChildMenuIDs ORDER BY MenuID

 DECLARE @ChildMenuID AS INT
 SET @ChildMenuID = (SELECT TOP 1 MenuID FROM @TempChildMenuIDs)
 
 WHILE (@ChildMenuID IS NOT NULL)
 BEGIN
  INSERT INTO @ChildMenuIDs (MenuID)
   SELECT MenuID FROM dbo.fnGetMenuChildren(@ChildMenuID)
  DELETE FROM @TempChildMenuIDs WHERE MenuID = @ChildMenuID

  SET @ChildMenuID = (SELECT TOP 1 MenuID FROM @TempChildMenuIDs)
 END
RETURN
END
GO

/****** Object:  StoredProcedure [dbo].[sp_patient_GetAllPatientImagesByPatientID]    Script Date: 08/03/2009 14:56:26 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_patient_GetAllPatientImagesByPatientID]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[sp_patient_GetAllPatientImagesByPatientID] 
END
GO
-- =============================================
-- Author:		<James Ballard>
-- =============================================
CREATE PROCEDURE [dbo].[sp_patient_GetAllPatientImagesByPatientID] 
	-- Add the parameters for the stored procedure here
	@PatientID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM tblPatientImages WHERE PatientID = @PatientID

	
END
GO

/****** Object:  StoredProcedure [dbo].[sp_image_UpdatePatientImageNameByID]    Script Date: 08/03/2009 14:56:26 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_image_UpdatePatientImageNameByID]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[sp_image_UpdatePatientImageNameByID]
END
GO
-- =============================================
-- Author:		<James Ballard>
-- =============================================
CREATE PROCEDURE [dbo].[sp_image_UpdatePatientImageNameByID] 
	-- Add the parameters for the stored procedure here
	@ImageID int,
	@ImageTitle	nvarchar(150)
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.

    -- Insert statements for procedure here
	UPDATE tblPatientImages SET ImageTitle = @ImageTitle WHERE ImageID = @ImageID
END
GO

/****** Object:  StoredProcedure [dbo].[sp_image_AddPatientImage]    Script Date: 08/03/2009 14:56:26 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_image_AddPatientImage]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[sp_image_AddPatientImage]
END
GO
CREATE PROCEDURE [dbo].[sp_image_AddPatientImage] 
	-- Add the parameters for the stored procedure here
	@ImageID int,
	@PatientID int,
	@ImageTitle nvarchar(150),
	@CreateDate datetime = getdate
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.

	SET NOCOUNT ON;

    -- Insert statements for procedure here

	INSERT INTO tblPatientImages
		(ImageID, PatientID, ImageTitle, CreateDate)
		VALUES (@ImageID, @PatientID, @ImageTitle, @CreateDate)

END
GO

/****** Object:  StoredProcedure [dbo].[sp_image_UpdatePatientImageByID]    Script Date: 08/03/2009 14:56:26 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_image_UpdatePatientImageByID]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[sp_image_UpdatePatientImageByID]
END
GO
-- =============================================
-- Author:		<James Ballard>
-- =============================================
CREATE PROCEDURE [dbo].[sp_image_UpdatePatientImageByID] 
	-- Add the parameters for the stored procedure here
	@ImageID int,
	@ImageData image,
	@ImageTitle	nvarchar(150)
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.

    -- Insert statements for procedure here
	UPDATE tblImages SET ImageData = @ImageData WHERE ImageID = @ImageID
	UPDATE tblPatientImages SET ImageTitle = @ImageTitle WHERE ImageID = @ImageID
END
GO

/****** Object:  StoredProcedure [dbo].[sp_audio_GetScript]    Script Date: 08/03/2009 14:56:26 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_audio_GetScript]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[sp_audio_GetScript]
END
GO
-- =============================================
-- Author:		<James Ballard>
-- =============================================
CREATE PROCEDURE [dbo].[sp_audio_GetScript]
	-- Add the parameters for the stored procedure here
	@MenuID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM tblAudioScripts where MenuID = @MenuID
END
GO

/****** Object:  StoredProcedure [dbo].[sp_audio_SaveScript]    Script Date: 08/03/2009 14:56:26 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_audio_SaveScript]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[sp_audio_SaveScript]
END
GO
-- =============================================
-- Author:		<James Ballard>
-- =============================================
CREATE PROCEDURE [dbo].[sp_audio_SaveScript]
	-- Add the parameters for the stored procedure here
	@MenuID int,
	@Script nvarchar(max)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO tblAudioScripts (MenuID, Script) VALUES (@MenuID, @Script)
END
GO

/****** Object:  StoredProcedure [dbo].[sp_audio_DeleteScript]    Script Date: 08/03/2009 14:56:26 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_audio_DeleteScript]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[sp_audio_DeleteScript]
END
GO
-- =============================================
-- Author:		<James Ballard>
-- =============================================
CREATE PROCEDURE [dbo].[sp_audio_DeleteScript]
	-- Add the parameters for the stored procedure here
	@MenuID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DELETE FROM tblAudioScripts WHERE MenuID = @MenuID
END
GO

/****** Object:  StoredProcedure [dbo].[sp_patient_GetAllPatients]    Script Date: 08/03/2009 14:56:26 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_patient_GetAllPatients]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[sp_patient_GetAllPatients]
END
GO
-- =============================================
-- Author:		<James Ballard>
-- =============================================
CREATE PROCEDURE [dbo].[sp_patient_GetAllPatients]
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM tblPatients

END
GO

/****** Object:  StoredProcedure [dbo].[sp_patient_GetPatientByFirstAndLastName]    Script Date: 08/03/2009 14:56:26 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_patient_GetPatientByFirstAndLastName]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[sp_patient_GetPatientByFirstAndLastName]
END
GO
-- =============================================
-- Author:		<James Ballard>
-- =============================================
CREATE PROCEDURE [dbo].[sp_patient_GetPatientByFirstAndLastName] 
	-- Add the parameters for the stored procedure here
	@FirstName nvarchar(50),	
	@LastName nvarchar(50)
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM tblPatients WHERE FirstName like @FirstName AND LastName like @LastName
END
GO

/****** Object:  StoredProcedure [dbo].[sp_patient_GetPatientByFirstName]    Script Date: 08/03/2009 14:56:26 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_patient_GetPatientByFirstName]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[sp_patient_GetPatientByFirstName]
END
GO
-- =============================================
-- Author:		<James Ballard>
-- Create date: <0/29/2007>
-- Description:	<Takes a MenuID and returns the children of that ID>
-- =============================================
CREATE PROCEDURE [dbo].[sp_patient_GetPatientByFirstName] 
	-- Add the parameters for the stored procedure here
	@FirstName nvarchar(50)
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM tblPatients WHERE FirstName like @FirstName
END
GO

/****** Object:  StoredProcedure [dbo].[sp_patient_GetPatientByID]    Script Date: 08/03/2009 14:56:26 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_patient_GetPatientByID]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[sp_patient_GetPatientByID]
END
GO
-- =============================================
-- Author:		<James Ballard>
-- =============================================
CREATE PROCEDURE [dbo].[sp_patient_GetPatientByID] 
	-- Add the parameters for the stored procedure here
	@PatientID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM tblPatients WHERE PatientID = @PatientID

	
END
GO

/****** Object:  StoredProcedure [dbo].[sp_patient_GetPatientByLastName]    Script Date: 08/03/2009 14:56:26 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_patient_GetPatientByLastName]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[sp_patient_GetPatientByLastName]
END
GO
-- =============================================
-- Author:		<James Ballard>
-- Create date: <0/29/2007>
-- Description:	<Takes a MenuID and returns the children of that ID>
-- =============================================
CREATE PROCEDURE [dbo].[sp_patient_GetPatientByLastName] 
	-- Add the parameters for the stored procedure here
	@LastName nvarchar(50)
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM tblPatients WHERE LastName like @LastName
END
GO

/****** Object:  StoredProcedure [dbo].[sp_patient_UpdatePatientByID]    Script Date: 08/03/2009 14:56:26 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_patient_UpdatePatientByID]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[sp_patient_UpdatePatientByID]
END
GO
-- =============================================
-- Author:		<James Ballard>
-- =============================================
-- 04/03/07 Michael - removed MiddleName parameter
CREATE PROCEDURE [dbo].[sp_patient_UpdatePatientByID] 
	-- Add the parameters for the stored procedure here
	@PatientID int,
	@FirstName nvarchar(50),
	@LastName nvarchar(50),
	@AccountNumber nvarchar(50),
	@IntegrationID nvarchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE tblPatients
		SET FirstName = @FirstName, LastName = @LastName, 
			AccountNumber = @AccountNumber, IntegrationID = @IntegrationID
		WHERE PatientID = @PatientID
END
GO

/****** Object:  StoredProcedure [dbo].[sp_patient_UpdatePatientByName]    Script Date: 08/03/2009 14:56:26 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_patient_UpdatePatientByName]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[sp_patient_UpdatePatientByName]
END
GO
-- =============================================
-- Author:		<James Ballard>
-- =============================================
CREATE PROCEDURE [dbo].[sp_patient_UpdatePatientByName] 
	-- Add the parameters for the stored procedure here
	@NewFirstName nvarchar(50),
	@NewLastName nvarchar(50),
	@NewMiddleName nvarchar(50),
	@OldFirstName nvarchar(50),
	@OldLastName nvarchar(50),
	@OldMiddleName nvarchar(50),
	@AccountNumber nvarchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE tblPatients
		SET FirstName = @NewFirstName, LastName = @NewLastName, 
			AccountNumber = @AccountNumber
		WHERE FirstName LIKE @OldFirstName AND LastName LIKE @OldLastName
END
GO

/****** Object:  StoredProcedure [dbo].[sp_patient_AddPatient]    Script Date: 08/03/2009 14:56:26 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_patient_AddPatient]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[sp_patient_AddPatient] 
END
GO
-- =============================================
-- Author:		<James Ballard>
-- =============================================
-- 04/03/07 Michael - removed middle name parameter
CREATE PROCEDURE [dbo].[sp_patient_AddPatient] 
	-- Add the parameters for the stored procedure here
	@FirstName nvarchar(50),
	@LastName nvarchar(50),
	@AccountNumber nvarchar(50),
	@IntegrationID nvarchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO tblPatients
		(FirstName, LastName, AccountNumber, IntegrationID)
		VALUES (@FirstName, @LastName, @AccountNumber, @IntegrationID)

	SELECT top 1 PatientID FROM tblPatients ORDER BY PatientID Desc
END
GO

/****** Object:  StoredProcedure [dbo].[sp_patient_DeletePatientByID]    Script Date: 08/03/2009 14:56:26 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_patient_DeletePatientByID]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[sp_patient_DeletePatientByID]
END
GO
-- =============================================
-- Author:		<James Ballard>
-- =============================================
CREATE PROCEDURE [dbo].[sp_patient_DeletePatientByID] 
	-- Add the parameters for the stored procedure here
	@PatientID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DELETE FROM tblPatients WHERE PatientID = @PatientID
END
GO

/****** Object:  StoredProcedure [dbo].[sp_patient_DeletePatientByName]    Script Date: 08/03/2009 14:56:26 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_patient_DeletePatientByName]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[sp_patient_DeletePatientByName]
END
GO
-- =============================================
-- Author:		<James Ballard>
-- =============================================
CREATE PROCEDURE [dbo].[sp_patient_DeletePatientByName]
	-- Add the parameters for the stored procedure here
	@FirstName nvarchar(50),	
	@LastName nvarchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DELETE FROM tblPatients WHERE FirstName like @FirstName AND LastName like @LastName
END
GO

/****** Object:  StoredProcedure [dbo].[sp_playlist_AddCustomPlaylist]    Script Date: 08/03/2009 14:56:26 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_playlist_AddCustomPlaylist]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[sp_playlist_AddCustomPlaylist]
END
GO
-- =============================================
-- Author:		<James Ballard>
-- =============================================
CREATE PROCEDURE [dbo].[sp_playlist_AddCustomPlaylist] 
	-- Add the parameters for the stored procedure here
	@ListName nvarchar(50),
	@InstallDate datetime,
	@ExpirationDate datetime,
	@IsLicensed bit = 0,
	@IsExpired bit = 0
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO tblPlaylists
		(GUID, ListName, IsCustom, InstallDate, ExpirationDate, IsLicensed, IsExpired)
		VALUES (newid(), @ListName, 'True', @InstallDate, @ExpirationDate, @IsLicensed, @IsExpired)

	SELECT TOP 1 PlaylistID FROM tblPlaylists ORDER BY PlaylistID DESC
END
GO

/****** Object:  StoredProcedure [dbo].[sp_playlist_AddPlaylist]    Script Date: 08/03/2009 14:56:26 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_playlist_AddPlaylist]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[sp_playlist_AddPlaylist]
END
GO
-- =============================================
-- Author:		<James Ballard>
-- =============================================
CREATE PROCEDURE [dbo].[sp_playlist_AddPlaylist] 
	-- Add the parameters for the stored procedure here
	@GUID uniqueidentifier,
	@ListName nvarchar(50),
	@IsCustom bit = 0,
	@InstallDate datetime,
	@ExpirationDate datetime,
	@Licensed bit = 1,
	@IsExpired bit = 0
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO tblPlaylists
		(GUID, ListName, IsCustom, InstallDate, ExpirationDate, IsLicensed, IsExpired)
		VALUES (@GUID, @ListName, @IsCustom, @InstallDate, @ExpirationDate, @Licensed, @IsExpired)

	SELECT TOP 1 PlaylistID FROM tblPlaylists ORDER BY PlaylistID DESC
END
GO

/****** Object:  StoredProcedure [dbo].[sp_playlist_DeletePlaylistByGUID]    Script Date: 08/03/2009 14:56:27 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_playlist_DeletePlaylistByGUID]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[sp_playlist_DeletePlaylistByGUID]
END
GO
-- =============================================
-- Author:		<James Ballard>
-- =============================================
CREATE PROCEDURE [dbo].[sp_playlist_DeletePlaylistByGUID]
	-- Add the parameters for the stored procedure here
	@GUID uniqueidentifier
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DELETE FROM tblPlaylists WHERE GUID = @GUID
END
GO

/****** Object:  StoredProcedure [dbo].[sp_playlist_DeletePlaylistByID]    Script Date: 08/03/2009 14:56:27 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_playlist_DeletePlaylistByID]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[sp_playlist_DeletePlaylistByID]
END
GO
-- =============================================
-- Author:		<James Ballard>
-- =============================================
CREATE PROCEDURE [dbo].[sp_playlist_DeletePlaylistByID]
	-- Add the parameters for the stored procedure here
	@PlaylistID int
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DELETE FROM tblPlaylists WHERE PlayListID = @PlaylistID
END
GO

/****** Object:  StoredProcedure [dbo].[sp_playlist_GetPlaylistByGUID]    Script Date: 08/03/2009 14:56:27 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_playlist_GetPlaylistByGUID]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[sp_playlist_GetPlaylistByGUID]
END
GO
-- =============================================
-- Author:		<James Ballard>
-- =============================================
CREATE PROCEDURE [dbo].[sp_playlist_GetPlaylistByGUID]
	-- Add the parameters for the stored procedure here
	@GUID uniqueidentifier
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM tblPlaylists WHERE GUID = @GUID
END
GO

/****** Object:  StoredProcedure [dbo].[sp_playlist_GetPlaylistByID]    Script Date: 08/03/2009 14:56:27 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_playlist_GetPlaylistByID]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[sp_playlist_GetPlaylistByID]
END
GO
-- =============================================
-- Author:		<James Ballard>
-- =============================================
CREATE PROCEDURE [dbo].[sp_playlist_GetPlaylistByID]
	-- Add the parameters for the stored procedure here
	@PlaylistID int
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM tblPlaylists WHERE PlaylistID = @PlaylistID
END
GO

/****** Object:  StoredProcedure [dbo].[sp_playlist_GetPlaylistByName]    Script Date: 08/03/2009 14:56:27 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_playlist_GetPlaylistByName]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[sp_playlist_GetPlaylistByName]
END
GO
-- =============================================
-- Author:		<James Ballard>
-- =============================================
CREATE PROCEDURE [dbo].[sp_playlist_GetPlaylistByName]
	-- Add the parameters for the stored procedure here
	@PlaylistName nvarchar(50)
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM tblPlaylists WHERE ListName LIKE @PlaylistName
END
GO

/****** Object:  StoredProcedure [dbo].[sp_playlist_UpdatePlaylistByGUID]    Script Date: 08/03/2009 14:56:27 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_playlist_UpdatePlaylistByGUID]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[sp_playlist_UpdatePlaylistByGUID] 
END
GO
-- =============================================
-- Author:		<James Ballard>
-- =============================================
CREATE PROCEDURE [dbo].[sp_playlist_UpdatePlaylistByGUID] 
	-- Add the parameters for the stored procedure here
	@GUID uniqueidentifier,
	@PlaylistName nvarchar(50),
	@IsCustom bit = 0,
	@InstallDate datetime,
	@ExpirationDate datetime,
	@IsLicensed bit = 1,
	@IsExpired bit = 0
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	Update tblPlaylists
		SET ListName = @PlaylistName, IsCustom = @IsCustom, InstallDate = @InstallDate,
		ExpirationDate = @ExpirationDate, IsLicensed = @IsLicensed, IsExpired = @IsExpired
		WHERE GUID = @GUID
END
GO

/****** Object:  StoredProcedure [dbo].[sp_playlist_UpdatePlaylistByID]    Script Date: 08/03/2009 14:56:27 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_playlist_UpdatePlaylistByID]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[sp_playlist_UpdatePlaylistByID] 
END
GO
-- =============================================
-- Author:		<James Ballard>
-- =============================================
CREATE PROCEDURE [dbo].[sp_playlist_UpdatePlaylistByID] 
	-- Add the parameters for the stored procedure here
	@PlaylistID int,
	@PlaylistName nvarchar(50),
	@IsCustom bit = 0,
	@InstallDate datetime,
	@ExpirationDate datetime,
	@IsLicensed bit = 1,
	@IsExpired bit = 0
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	Update tblPlaylists
		SET ListName = @PlaylistName, IsCustom = @IsCustom, InstallDate = @InstallDate,
		ExpirationDate = @ExpirationDate, IsLicensed = @IsLicensed, IsExpired = @IsExpired
		WHERE PlaylistID = @PlaylistID
END
GO

/****** Object:  StoredProcedure [dbo].[sp_playlist_UpdatePlaylistNameByID]    Script Date: 08/03/2009 14:56:27 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_playlist_UpdatePlaylistNameByID]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[sp_playlist_UpdatePlaylistNameByID] 
END
GO
-- =============================================
-- Author:		<James Ballard>
-- =============================================
CREATE PROCEDURE [dbo].[sp_playlist_UpdatePlaylistNameByID] 
	-- Add the parameters for the stored procedure here
	@PlaylistID int,
	@PlaylistName nvarchar(50)
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	Update tblPlaylists
		SET ListName = @PlaylistName
		WHERE PlaylistID = @PlaylistID
END
GO

/****** Object:  StoredProcedure [dbo].[sp_user_CopyUserMenu]    Script Date: 08/03/2009 14:56:27 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_user_CopyUserMenu]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[sp_user_CopyUserMenu]
END
GO
-- =============================================
-- Author:		<James Ballard>
-- =============================================
-- 04/04/07 - James - changed ''add'' store proc calls to inserts to avoid unnecessary return values.
--			- James	- commented out custom menu junk, only copies licensed (non-editable) menus
CREATE PROCEDURE [dbo].[sp_user_CopyUserMenu]
	-- Add the parameters for the stored procedure here
	@SrcUserID int,
	@DestUserID int
AS
BEGIN

	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @RC int
	DECLARE @PlaylistID int
	DECLARE @SrcPlaylistID int
	DECLARE @DestPlaylistID int
	DECLARE @ListName nvarchar(50)
	DECLARE @IsCustom bit
	DECLARE @IsVis bit
	DECLARE @NewMenuID int
	DECLARE @SrcMenuID int
	DECLARE @SrcParentID int
	DECLARE @ParentID int
	DECLARE @SortOrder int
	DECLARE @MediaID int
	DECLARE @MenuName nvarchar(100)
	DECLARE @ParentMenuName nvarchar(100)
	DECLARE @ContentPackID int
	DECLARE @NewPlaylistID int
	DECLARE @Today datetime
	SET @Today = getdate()

	DECLARE TopMenuCursor Cursor
		FOR SELECT p.PlaylistID, p.ListName, p.IsCustom, m.SortOrder, m.IsVisible
			FROM tblPlaylists p INNER JOIN tblTopLevelMenu m ON p.PlaylistID = m.PlaylistID
			WHERE m.UserId = @SrcUserID ORDER BY p.PlaylistID
	OPEN TopMenuCursor
	FETCH NEXT FROM TopMenuCursor INTO @PlaylistID, @ListName, @IsCustom, @SortOrder, @IsVis
	WHILE @@FETCH_STATUS = 0
	BEGIN
		If @IsCustom <> '1' --Custom Playlist, copy everything into new playlist and add new TLM with new user/pl IDs
		/*BEGIN
			--EXECUTE sp_playlist_AddCustomPlaylist @ListName, @today, null, ''0'', ''0''
			INSERT INTO tblPlaylists (ListName, IsCustom, InstallDate, ExpirationDate, IsLicensed, IsExpired) VALUES
				(@ListName, ''True'', @Today, NULL, ''0'', ''0'')
			SET @NewPlaylistID = (SELECT TOP 1 PlaylistID FROM tblPlaylists ORDER BY PlaylistID DESC)
			--EXECUTE sp_playlist_AddTopLevelMenu @DestUserID, @NewPlaylistID, @SortOrder, @IsVis
			INSERT INTO tblTopLevelMenu (UserID, PlaylistID, SortOrder, IsVisible) VALUES
				(@DestUserID, @NewPlaylistID, @SortOrder, @IsVis)
		END
		ELSE */
		--Non-Custom playlist.  Create new TLM with new user id, old plid
		BEGIN
			--EXECUTE sp_playlist_AddTopLevelMenu @DestUserID, @PlaylistID, @SortOrder, @IsVis
			INSERT INTO tblTopLevelMenu (UserID, PlaylistID, SortOrder, IsVisible) VALUES
				(@DestUserID, @PlaylistID, @SortOrder, @IsVis)
		END
		FETCH NEXT FROM TopMenuCursor INTO @PlaylistID, @ListName, @IsCustom, @SortOrder, @IsVis
	END
	CLOSE TopMenuCursor
	DEALLOCATE TopMenuCursor	

END
GO

/****** Object:  StoredProcedure [dbo].[sp_practice_AddPractice]    Script Date: 08/03/2009 14:56:27 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_practice_AddPractice]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[sp_practice_AddPractice]
END
GO
-- =============================================
-- Author:		<James Ballard>
-- =============================================
CREATE PROCEDURE [dbo].[sp_practice_AddPractice]
	-- Add the parameters for the stored procedure here
	@PracticeInfo nvarchar(max)
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @PracCount AS int;

	SELECT @PracCount = (SELECT count(PracticeID) FROM tblPracticeInfo)
	IF @PracCount < 1
	BEGIN

		-- Insert statements for procedure here
		INSERT INTO tblPracticeInfo
			(PracticeInfo)
			VALUES (@PracticeInfo)
	END
	SELECT PracticeID FROM tblPracticeInfo ORDER BY PracticeID Desc
END
GO

/****** Object:  StoredProcedure [dbo].[sp_prac_DeletePracticeByID]    Script Date: 08/03/2009 14:56:27 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_prac_DeletePracticeByID]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[sp_prac_DeletePracticeByID]
END
GO
-- =============================================
-- Author:		<James Ballard>
-- =============================================
CREATE PROCEDURE [dbo].[sp_prac_DeletePracticeByID]
	-- Add the parameters for the stored procedure here
	@PracticeID int
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DELETE FROM tblPracticeInfo WHERE PracticeID = @PracticeID
END
GO

/****** Object:  StoredProcedure [dbo].[sp_practice_GetPractice]    Script Date: 08/03/2009 14:56:27 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_practice_GetPractice]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[sp_practice_GetPractice]
END
GO
-- =============================================
-- Author:		<James Ballard>
-- =============================================
CREATE PROCEDURE [dbo].[sp_practice_GetPractice]
	-- Add the parameters for the stored procedure here
	
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM tblPracticeInfo
END
GO

/****** Object:  StoredProcedure [dbo].[sp_prac_GetPracticeByID]    Script Date: 08/03/2009 14:56:27 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_prac_GetPracticeByID]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[sp_prac_GetPracticeByID]
END
GO
-- =============================================
-- Author:		<James Ballard>
-- =============================================
CREATE PROCEDURE [dbo].[sp_prac_GetPracticeByID]
	-- Add the parameters for the stored procedure here
	@PracticeID int
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM tblPracticeInfo WHERE PracticeID = @PracticeID
END
GO

/****** Object:  StoredProcedure [dbo].[sp_practice_UpdatePracticeByID]    Script Date: 08/03/2009 14:56:27 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_practice_UpdatePracticeByID]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[sp_practice_UpdatePracticeByID]
END
GO
-- =============================================
-- Author:		<James Ballard>
-- =============================================
CREATE PROCEDURE [dbo].[sp_practice_UpdatePracticeByID]
	-- Add the parameters for the stored procedure here
	@PracticeID int,
	@PracticeInfo nvarchar(max)
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE tblPracticeInfo SET 
		PracticeInfo = @PracticeInfo
		WHERE PracticeID = @PracticeID
END
GO

/****** Object:  StoredProcedure [dbo].[sp_playlist_UpdateTopLevelMenuSortByUserIDAndPlaylistID]    Script Date: 08/03/2009 14:56:27 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_playlist_UpdateTopLevelMenuSortByUserIDAndPlaylistID]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[sp_playlist_UpdateTopLevelMenuSortByUserIDAndPlaylistID] 
END
GO
-- =============================================
-- Author:		<James Ballard>
-- =============================================
CREATE PROCEDURE [dbo].[sp_playlist_UpdateTopLevelMenuSortByUserIDAndPlaylistID] 
	-- Add the parameters for the stored procedure here
	@PlaylistID int,
	@UserID int,
	@SortOrder int
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	Update tblTopLevelMenu
		SET SortOrder = @SortOrder
		WHERE PlaylistID = @PlaylistID and UserID = @UserID
END
GO

/****** Object:  StoredProcedure [dbo].[sp_playlist_UpdateTopLevelMenuVisibleAndSortByUserIDAndPlaylistID]    Script Date: 08/03/2009 14:56:27 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_playlist_UpdateTopLevelMenuVisibleAndSortByUserIDAndPlaylistID]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[sp_playlist_UpdateTopLevelMenuVisibleAndSortByUserIDAndPlaylistID]
END
GO
-- =============================================
-- Author:		<James Ballard>
-- =============================================
CREATE PROCEDURE [dbo].[sp_playlist_UpdateTopLevelMenuVisibleAndSortByUserIDAndPlaylistID] 
	-- Add the parameters for the stored procedure here
	@PlaylistID int,
	@UserID int,
	@SortOrder int,
	@IsVisible bit
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	Update tblTopLevelMenu
		SET SortOrder = @SortOrder, IsVisible = @IsVisible
		WHERE PlaylistID = @PlaylistID and UserID = @UserID
END
GO

/****** Object:  StoredProcedure [dbo].[sp_playlist_UpdateTopLevelMenuVisibleByUserIDAndPlaylistID]    Script Date: 08/03/2009 14:56:27 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_playlist_UpdateTopLevelMenuVisibleByUserIDAndPlaylistID]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[sp_playlist_UpdateTopLevelMenuVisibleByUserIDAndPlaylistID]
END
GO
-- =============================================
-- Author:		<James Ballard>
-- =============================================
CREATE PROCEDURE [dbo].[sp_playlist_UpdateTopLevelMenuVisibleByUserIDAndPlaylistID] 
	-- Add the parameters for the stored procedure here
	@UserID int,
	@PlaylistID int,
	@IsVisible bit
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    UPDATE tblTopLevelMenu
		SET IsVisible = @IsVisible
		 WHERE UserID = @UserID AND PlaylistID = @PlaylistID
END
GO

/****** Object:  StoredProcedure [dbo].[sp_playlist_GetTopLevelMenuByUserID]    Script Date: 08/03/2009 14:56:27 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_playlist_GetTopLevelMenuByUserID]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[sp_playlist_GetTopLevelMenuByUserID] 
END
GO
-- =============================================
-- Author:		<James Ballard>
-- =============================================
CREATE PROCEDURE [dbo].[sp_playlist_GetTopLevelMenuByUserID] 
	-- Add the parameters for the stored procedure here
	@UserID int	
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT * FROM tblTopLevelMenu WHERE UserID = @UserID
END
GO

/****** Object:  StoredProcedure [dbo].[sp_playlist_DeleteTopLevelMenuByPlaylistID]    Script Date: 08/03/2009 14:56:27 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_playlist_DeleteTopLevelMenuByPlaylistID]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[sp_playlist_DeleteTopLevelMenuByPlaylistID]
END
GO
-- =============================================
-- Author:		<James Ballard>
-- =============================================
CREATE PROCEDURE [dbo].[sp_playlist_DeleteTopLevelMenuByPlaylistID] 
	-- Add the parameters for the stored procedure here
	@PlaylistID int	
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DELETE FROM tblTopLevelMenu WHERE PlaylistID = @PlaylistID
END
GO

/****** Object:  StoredProcedure [dbo].[sp_playlist_DeleteTopLevelMenuByUserID]    Script Date: 08/03/2009 14:56:27 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_playlist_DeleteTopLevelMenuByUserID]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[sp_playlist_DeleteTopLevelMenuByUserID]
END
GO
-- =============================================
-- Author:		<James Ballard>
-- =============================================
CREATE PROCEDURE [dbo].[sp_playlist_DeleteTopLevelMenuByUserID] 
	-- Add the parameters for the stored procedure here
	@UserID int	
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DELETE FROM tblTopLevelMenu WHERE UserID = @UserID
END
GO

/****** Object:  StoredProcedure [dbo].[sp_playlist_AddTopLevelMenu]    Script Date: 08/03/2009 14:56:27 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_playlist_AddTopLevelMenu]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[sp_playlist_AddTopLevelMenu]
END
GO
-- =============================================
-- Author:		<James Ballard>
-- =============================================
CREATE PROCEDURE [dbo].[sp_playlist_AddTopLevelMenu] 
	-- Add the parameters for the stored procedure here
	@UserID int,
	@PlaylistID int,
	@SortOrder int,
	@IsVisible bit = 0
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO tblTopLevelMenu
		(UserID, PlaylistID, SortOrder, IsVisible)
		VALUES (@UserID, @PlaylistID, @SortOrder, @IsVisible)
END
GO

/****** Object:  StoredProcedure [dbo].[sp_user_DeleteUserByID]    Script Date: 08/03/2009 14:56:27 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_user_DeleteUserByID]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[sp_user_DeleteUserByID]
END
GO
-- =============================================
-- Author:		<James Ballard>
-- =============================================
CREATE PROCEDURE [dbo].[sp_user_DeleteUserByID]
	-- Add the parameters for the stored procedure here
	@UserID int
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DELETE FROM tblUsers WHERE UserID = @UserID

END
GO

/****** Object:  StoredProcedure [dbo].[sp_user_GetAllUsers]    Script Date: 08/03/2009 14:56:27 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_user_GetAllUsers]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[sp_user_GetAllUsers]
END
GO
-- =============================================
-- Author:		<James Ballard>
-- =============================================
CREATE PROCEDURE [dbo].[sp_user_GetAllUsers]
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM tblUsers

END
GO

/****** Object:  StoredProcedure [dbo].[sp_user_GetUserByID]    Script Date: 08/03/2009 14:56:27 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_user_GetUserByID]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[sp_user_GetUserByID]
END
GO
-- =============================================
-- Author:		<James Ballard>
-- =============================================
CREATE PROCEDURE [dbo].[sp_user_GetUserByID]
	-- Add the parameters for the stored procedure here
	@UserID int
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM tblUsers

END
GO

/****** Object:  StoredProcedure [dbo].[sp_user_UpdateUserByID]    Script Date: 08/03/2009 14:56:27 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_user_UpdateUserByID]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[sp_user_UpdateUserByID]
END
GO
-- =============================================
-- Author:		<James Ballard>
-- =============================================
CREATE PROCEDURE [dbo].[sp_user_UpdateUserByID]
	-- Add the parameters for the stored procedure here
	@UserID int,
	@UserName nvarchar(50),
	@DefaultCustomPlaylist nvarchar(50),
	@MenuOnRight bit
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE tblUsers SET 
		UserName = @UserName, DefaultCustomPlaylist = @DefaultCustomPlaylist, MenuOnRight = @MenuOnRight
		WHERE UserID = @UserID
END
GO

/****** Object:  StoredProcedure [dbo].[sp_user_UpdateUserMenuByUserID]    Script Date: 08/03/2009 14:56:27 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_user_UpdateUserMenuByUserID]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[sp_user_UpdateUserMenuByUserID]
END
GO
-- =============================================
-- Author:		<James Ballard>
-- =============================================
CREATE PROCEDURE [dbo].[sp_user_UpdateUserMenuByUserID]
	-- Add the parameters for the stored procedure here
	@UserID int,
	@MenuOnRight bit
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE tblUsers SET 
		MenuOnRight = @MenuOnRight
		WHERE UserID = @UserID
END
GO

/****** Object:  StoredProcedure [dbo].[sp_image_GetImageByTypeIDAndPathID]    Script Date: 08/03/2009 14:56:26 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_image_GetImageByTypeIDAndPathID]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[sp_image_GetImageByTypeIDAndPathID]
END
GO
-- =============================================
-- Author:		<James Ballard>
-- =============================================
CREATE PROCEDURE [dbo].[sp_image_GetImageByTypeIDAndPathID] 
	-- Add the parameters for the stored procedure here
	@TypeID int,
	@PathID int
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT MediaID, GUID FROM tblMedia WHERE TypeId = @TypeID and PathID = @PathID
END
GO

/****** Object:  StoredProcedure [dbo].[sp_media_AddMedia]    Script Date: 08/03/2009 14:56:26 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_media_AddMedia]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[sp_media_AddMedia] 
END
GO
-- =============================================
-- Author:		<James Ballard>
-- =============================================
CREATE PROCEDURE [dbo].[sp_media_AddMedia] 
	-- Add the parameters for the stored procedure here
	@GUID uniqueidentifier,
	@TypeID	int,
	@PathID	int,
	@PlaylistID int
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO tblMedia
		(GUID, TypeID, PathID, PlaylistID)
		VALUES (@GUID, @TypeID, @PathID, @PlaylistID)

	SELECT TOP 1 MediaID FROM tblMedia ORDER BY MediaID DESC
END
GO

/****** Object:  StoredProcedure [dbo].[sp_media_DeleteMediaByGUID]    Script Date: 08/03/2009 14:56:26 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_media_DeleteMediaByGUID]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[sp_media_DeleteMediaByGUID]
END
GO
-- =============================================
-- Author:		<James Ballard>
-- =============================================
CREATE PROCEDURE [dbo].[sp_media_DeleteMediaByGUID]
	-- Add the parameters for the stored procedure here
	@GUID uniqueidentifier
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DELETE FROM tblMedia WHERE GUID = @GUID
END
GO

/****** Object:  StoredProcedure [dbo].[sp_media_DeleteMediaByID]    Script Date: 08/03/2009 14:56:26 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_media_DeleteMediaByID]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[sp_media_DeleteMediaByID]
END
GO
-- =============================================
-- Author:		<James Ballard>
-- =============================================
CREATE PROCEDURE [dbo].[sp_media_DeleteMediaByID]
	@MediaID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.5
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DELETE FROM tblMedia WHERE MediaID = @MediaID
END
GO

/****** Object:  StoredProcedure [dbo].[sp_media_DeleteMediaByPlaylistID]    Script Date: 08/03/2009 14:56:26 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_media_DeleteMediaByPlaylistID]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[sp_media_DeleteMediaByPlaylistID]
END
GO
-- =============================================
-- Author:		<James Ballard>
-- =============================================
CREATE PROCEDURE [dbo].[sp_media_DeleteMediaByPlaylistID]
	-- Add the parameters for the stored procedure here
	@PlaylistID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DELETE FROM tblMedia WHERE PlaylistID = @PlaylistID
END
GO

/****** Object:  StoredProcedure [dbo].[sp_media_GetMediaByGUID]    Script Date: 08/03/2009 14:56:26 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_media_GetMediaByGUID]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[sp_media_GetMediaByGUID]
END
GO
-- =============================================
-- Author:		<James Ballard>
-- =============================================
CREATE PROCEDURE [dbo].[sp_media_GetMediaByGUID]
	-- Add the parameters for the stored procedure here
	@GUID uniqueidentifier
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM tblMedia WHERE GUID = @GUID
END
GO

/****** Object:  StoredProcedure [dbo].[sp_media_GetMediaByID]    Script Date: 08/03/2009 14:56:26 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_media_GetMediaByID]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[sp_media_GetMediaByID]
END
GO
-- =============================================
-- Author:		<James Ballard>
-- =============================================
CREATE PROCEDURE [dbo].[sp_media_GetMediaByID]
	-- Add the parameters for the stored procedure here
	@MediaID int
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM tblMedia WHERE MediaID = @MediaID
END
GO

/****** Object:  StoredProcedure [dbo].[sp_media_UpdateMediaByID]    Script Date: 08/03/2009 14:56:26 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_media_UpdateMediaByID]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[sp_media_UpdateMediaByID]
END
GO
-- =============================================
-- Author:		<James Ballard>
-- =============================================
CREATE PROCEDURE [dbo].[sp_media_UpdateMediaByID]
	-- Add the parameters for the stored procedure here
	@MediaID int,
	@GUID uniqueidentifier,
	@TypeId	int,
	@PathID	int,
	@PlaylistID int
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE tblMedia
		SET TypeID = @TypeID, PathID = @PathID, PlaylistID = @PlaylistID
		WHERE GUID = @GUID and MediaID = @MediaID
END
GO

/****** Object:  StoredProcedure [dbo].[sp_user_AddUser]    Script Date: 08/03/2009 14:56:27 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_user_AddUser]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[sp_user_AddUser]
END
GO
-- =============================================
-- Author:		<James Ballard>
-- =============================================
-- 04/03/07 Michael - removed reference to mvdb in the EXECUTE statement
CREATE PROCEDURE [dbo].[sp_user_AddUser]
	-- Add the parameters for the stored procedure here
	@UserName nvarchar(150),
	@DefaultCustomPlaylist nvarchar(50),
	@MenuOnRight bit --left = 0, right = 1
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	DECLARE @UserID int
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO tblUsers 
		(UserName, DefaultCustomPlaylist, MenuOnRight)
		VALUES (@UserName, @DefaultCustomPlaylist, @MenuOnRight)

	SET @UserID = (SELECT TOP 1 UserID FROM tblUsers ORDER BY UserID DESC)
	EXECUTE [dbo].[sp_user_CopyUserMenu] -1, @UserID
	SELECT @UserID as UserID

END
GO

-- SELECT @debug_message