USE [mvdb]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblSettings]') AND type in (N'U')) BEGIN
	CREATE TABLE [dbo].[tblSettings](
		[SerializedSettings] [nvarchar](max) NULL
	) ON [PRIMARY]
END

IF (NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'tblDocuments'))
BEGIN
	CREATE TABLE [dbo].[tblDocuments](
		[DocumentID] [int] IDENTITY(1,1) NOT NULL,
		[Title] [nvarchar](150) NOT NULL,
		[Category] [nvarchar](150) NOT NULL,
		[Path] [nvarchar](260) NOT NULL,
		[PreviewPath] [nvarchar](260) NULL,
	 CONSTRAINT [PK_tblDocuments] PRIMARY KEY CLUSTERED 
	(
		[DocumentID] ASC
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	) ON [PRIMARY]
END

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.Columns WHERE Table_Name = 'tblPlaylists' AND Column_Name = 'IsFeatured') BEGIN
	ALTER TABLE tblPlaylists
	ADD IsFeatured bit NOT NULL	DEFAULT 0
END

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.Columns WHERE Table_Name = 'tblPatients' AND Column_Name = 'Email') BEGIN
	ALTER TABLE tblPatients
	ADD Email nvarchar(50) NULL

END
GO


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_patient_UpdatePatientByID]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[sp_patient_UpdatePatientByID]
END
GO

-- =============================================
-- Author:		<James Ballard>
-- =============================================
-- 04/03/07 Michael - removed MiddleName parameter
-- 09/06/11 Michael - add Email
CREATE PROCEDURE [dbo].[sp_patient_UpdatePatientByID] 
	-- Add the parameters for the stored procedure here
	@PatientID int,
	@FirstName nvarchar(50),
	@LastName nvarchar(50),
	@AccountNumber nvarchar(50),
	@IntegrationID nvarchar(50),
	@Email nvarchar(50) = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE tblPatients
		SET FirstName = @FirstName, LastName = @LastName, 
			AccountNumber = @AccountNumber, IntegrationID = @IntegrationID,
			Email = @Email
		WHERE PatientID = @PatientID
END
GO


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_patient_AddPatient]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[sp_patient_AddPatient]
END
GO

-- =============================================
-- Author:		<James Ballard>
-- =============================================
-- 04/03/07 Michael - removed middle name parameter
-- 09/06/11 Michael - add email
CREATE PROCEDURE [dbo].[sp_patient_AddPatient] 
	-- Add the parameters for the stored procedure here
	@FirstName nvarchar(50),
	@LastName nvarchar(50),
	@AccountNumber nvarchar(50),
	@IntegrationID nvarchar(50),
	@Email nvarchar(50) = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO tblPatients
		(FirstName, LastName, AccountNumber, IntegrationID, Email)
		VALUES (@FirstName, @LastName, @AccountNumber, @IntegrationID, @Email)

	SELECT top 1 PatientID FROM tblPatients ORDER BY PatientID Desc
END
GO


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
	@IsExpired bit = 0,
	@IsFeatured bit = 0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO tblPlaylists
		(GUID, ListName, IsCustom, InstallDate, ExpirationDate, IsLicensed, IsExpired, IsFeatured)
		VALUES (@GUID, @ListName, @IsCustom, @InstallDate, @ExpirationDate, @Licensed, @IsExpired, @IsFeatured)

	SELECT TOP 1 PlaylistID FROM tblPlaylists ORDER BY PlaylistID DESC
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_error_RethrowError]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[sp_error_RethrowError]
END
GO

-- =============================================
-- Author:		Michael Prestwich
-- Create date: 9/30/2011
-- Description:	Rethrow an error from a catch block
-- =============================================
CREATE PROCEDURE [dbo].[sp_error_RethrowError] 
AS
BEGIN
    -- Return if there is no error information to retrieve.
    IF ERROR_NUMBER() IS NULL
        RETURN;

    DECLARE 
        @ErrorMessage    NVARCHAR(4000),
        @ErrorNumber     INT,
        @ErrorSeverity   INT,
        @ErrorState      INT,
        @ErrorLine       INT,
        @ErrorProcedure  NVARCHAR(200);

    -- Assign variables to error-handling functions that 
    -- capture information for RAISERROR.
    SELECT 
        @ErrorNumber = ERROR_NUMBER(),
        @ErrorSeverity = ERROR_SEVERITY(),
        @ErrorState = ERROR_STATE(),
        @ErrorLine = ERROR_LINE(),
        @ErrorProcedure = ISNULL(ERROR_PROCEDURE(), '-');

    -- Build the message string that will contain original
    -- error information.
    SELECT @ErrorMessage = 
        N'Error %d, Level %d, State %d, Procedure %s, Line %d, ' + 
            'Message: '+ ERROR_MESSAGE();

    -- Raise an error: msg_str parameter of RAISERROR will contain
    -- the original error information.
    RAISERROR 
        (
        @ErrorMessage, 
        @ErrorSeverity, 
        1,               
        @ErrorNumber,    -- parameter: original error number.
        @ErrorSeverity,  -- parameter: original error severity.
        @ErrorState,     -- parameter: original error state.
        @ErrorProcedure, -- parameter: original error procedure name.
        @ErrorLine       -- parameter: original error line number.
        );
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_presentation_DeletePresentationByID]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[sp_presentation_DeletePresentationByID]
END
GO


-- =============================================
-- Author:		<Michael Prestwich>
-- Create date: <9/30/2011>
-- Description:	<Removes a playlist, its menu records, and any media and paths orphaned by the deletion>
-- =============================================
CREATE PROCEDURE [dbo].[sp_presentation_DeletePresentationByID] 
	@PlaylistID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

DECLARE @MediaDeletion TABLE
(
	MediaID int
);

insert into @MediaDeletion (MediaID)
	select MediaID from
		(select MediaID, COUNT(1) as Count from tblMenus
			where MediaID in (select mediaID from tblMenus where playlistid=@PlaylistID)
			GROUP BY MediaID) foo
		where Count <= 1;

DECLARE @PathDeletion TABLE
(
	PathID int
);

insert into @PathDeletion (PathID)
	(select PathID from
		(select PathID, COUNT(1) as Count from tblMedia where PathID in
			(select PathID from tblMedia where MediaID in
				(select MediaID from @MediaDeletion))
			GROUP BY PathID) bar
		where Count <= 1);

BEGIN TRANSACTION;

BEGIN TRY

delete from tblAudioLinks
OUTPUT DELETED.AudioGuid
where MenuID in
	(select MenuID from tblMenus where PlaylistID = @PlaylistID);

delete from tblMenus
where playlistid=@PlaylistID;

delete from tblTopLevelMenu where PlaylistID = @PlaylistID;
delete from tblPatientPlaylists where PlaylistID = @PlaylistID;

delete from tblMedia
where MediaID in
	(select MediaID from @MediaDeletion);

delete from tblPlaylists where PlaylistID = @PlaylistID;

select Path from tblMediaPaths
where PathID in
	(select PathID from @PathDeletion);

delete from tblMediaPaths
where PathID in
	(select PathID from @PathDeletion);

COMMIT TRANSACTION;

END TRY
BEGIN CATCH

ROLLBACK TRANSACTION;
EXECUTE sp_error_RethrowError;

END CATCH

END
GO

/****** Object:  Table [dbo].[tblSignatures]    Script Date: 10/03/2011 10:24:28 ******/

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblSignatures]') AND type in (N'U')) BEGIN
	CREATE TABLE [dbo].[tblSignatures](
		[SignatureID] [int] IDENTITY(1,1) NOT NULL,
		[SignatureData] [varchar](max) NOT NULL,
	 CONSTRAINT [PK_tblSignatures] PRIMARY KEY CLUSTERED 
	(
		[SignatureID] ASC
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	) ON [PRIMARY]
END
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.Columns WHERE Table_Name = 'tblPatientPlaylists' AND Column_Name = 'Signature') BEGIN
	ALTER TABLE [dbo].[tblPatientPlaylists]
	ADD [Signature] [int] NULL
END
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_patient_GetPlaylistByPatientID]') AND type in (N'P', N'PC'))
BEGIN
	DROP PROCEDURE [dbo].[sp_patient_GetPlaylistByPatientID]
END
GO

-- =============================================
-- Author:		Michael Prestwich
-- Create date: 
-- Description:	
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
		SELECT PlaylistID, SortOrder, CreateDate, ModifiedDate, Signature 
		from tblPatientPlaylists where PatientID = @PatientID;
END

GO

IF (EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_NAME = 'sp_document_AddDocument'))
	DROP PROCEDURE sp_document_AddDocument
GO

CREATE PROCEDURE [dbo].[sp_document_AddDocument]
	@Title nvarchar(150),
	@Category nvarchar(150),
	@Path nvarchar(260),
	@PreviewPath nvarchar(260) = null
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @rowCt INT;
	SELECT @rowCt = COUNT(1) from tblDocuments WHERE [Title]=@Title AND [Category]=@Category AND [Path]=@Path;
	IF(@rowCt = 0)
	BEGIN
		INSERT INTO tblDocuments (Title, Category, Path, PreviewPath) VALUES (@Title, @Category, @Path, @PreviewPath)
	END
END
GO
