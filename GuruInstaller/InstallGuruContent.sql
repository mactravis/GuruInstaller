USE [mvdb]
GO
SET NOCOUNT ON

declare @currentPlaylist int
declare @currentMenu int
declare @tempInt int


--78eb61c1-507b-4fc2-a311-29017ed37629
-- Create the playlists...
IF NOT EXISTS (SELECT * FROM tblPlaylists WHERE Guid = '78eb61c1-507b-4fc2-a311-29017ed37629') BEGIN
	declare @now datetime
	SET @now = GETDATE()
	EXEC dbo.sp_playlist_AddPlaylist '78eb61c1-507b-4fc2-a311-29017ed37629', 'GURU Dental', 0, @now, NULL, 1, 0, 0
END

set @currentPlaylist = (SELECT TOP 1 PlaylistID FROM tblPlaylists WHERE Guid = '78eb61c1-507b-4fc2-a311-29017ed37629') -- Now Loading Guru Dental content

IF NOT EXISTS (SELECT * FROM tblTopLevelMenu WHERE UserId = -1 AND PlaylistId = @currentPlaylist) BEGIN
	set @tempInt = (SELECT TOP 1 (SortOrder + 1) as Sort FROM tblTopLevelMenu WHERE UserId = -1 ORDER BY SortOrder DESC)
	IF @tempInt IS NULL
		set @tempInt = -1
	INSERT INTO tblTopLevelMenu (UserId, PlaylistId, SortOrder, IsVisible)
		VALUES (-1, @currentPlaylist, @tempInt, 1)
END

-- Create the Media

--Bridges
IF NOT EXISTS (SELECT * FROM tblMenus WHERE MenuName = 'Menu-Dental-Bridges' AND PlaylistId = @currentPlaylist)
	EXEC dbo.sp_menu_AddMenuItem -1, 1, 'Menu-Dental-Bridges', -1, @currentPlaylist
SET @currentMenu = (SELECT TOP 1 MenuId FROM tblMenus WHERE MenuName = 'Menu-Dental-Bridges' AND PlaylistId = @currentPlaylist)
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Bridges-BridgeBoneLoss', 3, '4C9880BD-C5E3-47ED-B306-C9F1038E59DD', 'media\GURU\mov\bridgeBoneLoss.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Bridges-BridgeFlossing', 3, 'E703CA8A-11A8-4577-BE4C-31B250EB7F8A', 'media\GURU\mov\bridgeFlossing.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Bridges-BridgeDecay', 3, '75C861A4-F701-4604-949E-3282FC499488', 'media\GURU\mov\bridgeDecay.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Bridges-Bridges', 3, '29BF87C2-073C-4BDB-913C-A4CA584781B0', 'media\GURU\mov\bridges.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Bridges-MarylandBridge', 3, '1FD30B1B-DD56-4801-95D9-6A51C3777D3D', 'media\GURU\mov\marylandBridge.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Bridges-ToothMovement', 3, '8173B720-D560-4CF8-98B4-442154410FC4', 'media\GURU\mov\toothMove.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Bridges-ToothReplacement-Ext', 3, 'E3BF3B32-95DE-49FD-910A-1C8EAFC6C40B', 'media\GURU\mov\toothReplaceV.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Bridges-DentureBridge', 3, 'E294CC52-E521-4620-9850-BE4021A75579', 'media\GURU\mov\dentureBridge.mov'


--Bruxism
IF NOT EXISTS (SELECT * FROM tblMenus WHERE MenuName = 'Menu-Dental-Bruxism' AND PlaylistId = @currentPlaylist)
	EXEC dbo.sp_menu_AddMenuItem -1, 2, 'Menu-Dental-Bruxism', -1, @currentPlaylist
SET @currentMenu = (SELECT TOP 1 MenuId FROM tblMenus WHERE MenuName = 'Menu-Dental-Bruxism' AND PlaylistId = @currentPlaylist)
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Bruxism-Bruxism', 3, 'ADCA2F7A-3675-4178-8A93-CF41B4B2A49D', 'media\GURU\mov\bruxism.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Bruxism-Bruxism-Ext', 3, '8895BD95-85E9-4D2E-BC46-EEEC8C3538D8', 'media\GURU\mov\bruxismV.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Bruxism-Abfraction', 3, '4764806F-2ABB-40B4-A5D9-3139FDB060C2', 'media\GURU\mov\Abfraction.mov'


--Children
IF NOT EXISTS (SELECT * FROM tblMenus WHERE MenuName = 'Menu-Dental-Children' AND PlaylistId = @currentPlaylist)
	EXEC dbo.sp_menu_AddMenuItem -1, 3, 'Menu-Dental-Children', -1, @currentPlaylist
SET @currentMenu = (SELECT TOP 1 MenuId FROM tblMenus WHERE MenuName = 'Menu-Dental-Children' AND PlaylistId = @currentPlaylist)
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Children-BabyBottleDecay', 3, '3004EC99-B83C-404D-8EAE-5DD20F8872F1', 'media\GURU\mov\kidsBottleDecay.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Children-CavityStages', 3, '4206CDFE-84E5-4811-A31F-C7D12591EFA4', 'media\GURU\mov\kidsCavityStages.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Children-Crowns', 3, 'FA6CE086-8E76-4248-8628-109E3F6A9637', 'media\GURU\mov\kidsCrowns.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Children-DigitalX-ray', 3, '16699E46-1888-4198-8E4E-DB9F3EE920DF', 'media\GURU\mov\kidsXray.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Children-Flossing', 3, '28E7C157-9BC9-42D9-BD41-8E326B19309D', 'media\GURU\mov\kidsFlossing.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Children-FluorideTreatment', 3, 'C81CFE43-C6F9-40E7-BD1A-477FE6B8B42B', 'media\GURU\mov\kidsFluoride.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Children-Gingivitis', 3, '7F1736E6-E85E-4D83-BD00-B9852EEAFC79', 'media\GURU\mov\kidsGingivitis.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Children-Impression', 3, 'BFA38800-63A1-4671-BF37-EF75010A78C0', 'media\GURU\mov\kidsImpression.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Children-MouthGuard', 3, 'C3ED137D-E1F4-4DB4-92F0-FDB6CDECE65E', 'media\GURU\mov\kidsMouthguard.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Children-PlaqueBuildup', 3, '948E365A-60ED-496D-B034-3633B4CF96CA', 'media\GURU\mov\kidsplaque.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Children-Pulpotomy', 3, '4D99AA25-6713-404E-8960-776F55CCF1F9', 'media\GURU\mov\kidsPulpectomy.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Children-Scaling', 3, 'D75F3C42-B89A-4D05-A600-5AF94DF6E84C', 'media\GURU\mov\kidsScaling.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Children-Sealant', 3, '2F652FD4-CB86-43FE-AAE0-279F33CA02B1', 'media\GURU\mov\kidsSealant.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Children-Sealant-Ext', 3, 'EA26E817-9AEA-4DC2-BE27-7EEF15E7660C', 'media\GURU\mov\sealantV.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Children-SpaceMaintainer', 3, '66780933-8BEF-4C8B-89DB-CBC836C82CFA', 'media\GURU\mov\kidsSpaceMaintainer.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Children-TeethDevelopment', 3, '00294498-700B-4400-8C85-536B1A753544', 'media\GURU\mov\eruptionProcess_CloseUp.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Children-BrusherBailey-SealtheDeal', 3, 'EB882EE9-8825-438B-AF62-66987ACEAE66', 'media\GURU\mov\sealthedeal.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Children-BrusherBailey-AttackoftheBioflim', 3, '8F35B77A-59DA-4CAA-A869-422D2B067031', 'media\GURU\mov\aotb.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Children-KidsCrownStainlessSteel', 3, '2374CBE1-DED9-11DE-8A39-0800200C9A66', 'media\GURU\mov\kidsCrownStainlessSteel.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Children-KidsFluorideNew', 3, '68EB7D96-8931-4A94-8C9F-FB6B1C161841', 'media\GURU\mov\kidsFluorideNew.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Children-KidsFluorideVarnish', 3, '2374CBE5-DED9-11DE-8A39-0800200C9A66', 'media\GURU\mov\kidsFluorideVarnish.mov'

--Crowns
IF NOT EXISTS (SELECT * FROM tblMenus WHERE MenuName = 'Menu-Dental-Crowns' AND PlaylistId = @currentPlaylist)
	EXEC dbo.sp_menu_AddMenuItem -1, 4, 'Menu-Dental-Crowns', -1, @currentPlaylist
SET @currentMenu = (SELECT TOP 1 MenuId FROM tblMenus WHERE MenuName = 'Menu-Dental-Crowns' AND PlaylistId = @currentPlaylist)
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Crowns-Buildup-Ext', 3, 'E4BF7192-BF7E-4DDF-82AC-2790D667B29B', 'media\GURU\mov\buildupV.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Crowns-CrackedTooth', 3, 'A8AD6F97-8A9F-4A36-A7CC-D1FA69B48B05', 'media\GURU\mov\posCracked.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Crowns-CrownComparison', 2, 'D0F99FB4-00C9-4448-B835-844064017861', 'media\GURU\png\crownCompare.png'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Crowns-LargeMOD-Ext', 3, 'E9DA312F-3A77-4761-A48F-F22FFC4B7E6F', 'media\GURU\mov\largeModV.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Crowns-LaserTroughing', 3, '5479C19A-69E6-4049-88D7-F6502ADD28D1', 'media\GURU\mov\laserTroughing.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Crowns-CrownProcessAnterior', 3, 'F6DE8A7C-6DA6-44A4-922F-84EA316DC265', 'media\GURU\mov\antCrownProcess.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Crowns-CrownProcessPosterior', 3, 'F0037570-E2E2-4C04-B493-6A5BE66FC800', 'media\GURU\mov\posCrownProcess.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Crowns-Fracture-Ext', 3, 'E5532482-B17E-418C-BB09-9D44CF6BBAFF', 'media\GURU\mov\fractureV.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Crowns-ReasonforCrownCracked', 2, '83E71CB2-9DF7-485A-80EB-A3AC347677C0', 'media\GURU\png\crack.png'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Crowns-ReasonforCrownLargeCavity', 2, '5EE4C0E9-ECC8-4D94-933B-FC6FB46C1EC0', 'media\GURU\png\cavity.png'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Crowns-ReasonforCrownLargeFilling', 2, 'C0767D93-0949-48C3-A105-D8CFC3B72FBB', 'media\GURU\png\largeFilling.png'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Crowns-ReasonforCrownStain', 2, '742C8EA4-0DC3-4356-B1A3-B0ADE30B2910', 'media\GURU\png\stain.png'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Crowns-Anesthetic', 3, 'AD2949CF-B56D-42FF-95DF-7FD337393A86', 'media\GURU\mov\anesthetic.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Crowns-CrownPFMvsCeramic', 3, '34326A18-733A-4C58-A960-A7C9D7F6B6D1', 'media\GURU\mov\crownPFMvsCeramic.mov'

--Denture
IF NOT EXISTS (SELECT * FROM tblMenus WHERE MenuName = 'Menu-Dental-Denture' AND PlaylistId = @currentPlaylist)
	EXEC dbo.sp_menu_AddMenuItem -1, 5, 'Menu-Dental-Denture', -1, @currentPlaylist
SET @currentMenu = (SELECT TOP 1 MenuId FROM tblMenus WHERE MenuName = 'Menu-Dental-Denture' AND PlaylistId = @currentPlaylist)
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Denture-AgingEffect', 3, '47D5E8AA-1409-411F-A44F-7862F7B3AAF0', 'media\GURU\mov\aging.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Denture-DentureReplacement', 3, '5F0D4CC5-E9D5-4BC3-B3B1-FB3A0EE36208', 'media\GURU\mov\dentures.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Denture-PrecisionPartial', 3, 'A40614BD-78BC-42AE-A1B5-7C71554C3D73', 'media\GURU\mov\hiddenClaspPartial.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Denture-ImplantvsPartialComparison', 2, '27110F02-BBAD-4DE5-8DE5-F012FEAB66D7', 'media\GURU\png\Implantspartialcomparison.png'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Denture-RidgeDeterioration', 3, 'CDBECC08-2600-4926-AD3C-DBF642221A73', 'media\GURU\mov\mandibularDeterioration.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Denture-DistalFreeEndPartial', 3, '036F506E-B534-479A-B94E-6396357119AD', 'media\GURU\mov\molarPartial.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Denture-OverDenture', 3, '3AAFE9F1-649A-4454-A8B9-E9A46AAB515B', 'media\GURU\mov\overdenture.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Denture-ConventionalClaspedPartial', 3, '2E33CD5E-085F-4C72-A1BA-4669FD69ACD6', 'media\GURU\mov\vitalliumPartial.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Denture-MandibleDeteriorationPartial', 3, '543AFCAC-2409-4CF7-BF33-13F5DF3CFBCC', 'media\GURU\mov\mandibDetPartial.mov'

--Endodontics
IF NOT EXISTS (SELECT * FROM tblMenus WHERE MenuName = 'Menu-Dental-Endodontics' AND PlaylistId = @currentPlaylist)
	EXEC dbo.sp_menu_AddMenuItem -1, 6, 'Menu-Dental-Endodontics', -1, @currentPlaylist
SET @currentMenu = (SELECT TOP 1 MenuId FROM tblMenus WHERE MenuName = 'Menu-Dental-Endodontics' AND PlaylistId = @currentPlaylist)
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Endodontics-FiberCore', 3, '755D42D1-8D22-4CC9-B84E-A24BC1269816', 'media\GURU\mov\fiberPost.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Endodontics-FiberCorevsMetalCore', 3, 'F2A9708A-245C-4E16-92D8-E1CFF6C349B6', 'media\GURU\mov\fiberVSmetalCore.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Endodontics-Pins', 3, 'E420891E-CAF3-4A76-8567-A21D09683881', 'media\GURU\mov\pins.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Endodontics-PostCore', 3, 'CBD64E4D-80E9-484D-8231-5EAC700ED00B', 'media\GURU\mov\postCore.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Endodontics-RootCanal-Ext', 3, '63B07E61-9546-4B39-A01C-999C82890D79', 'media\GURU\mov\rootCanalV.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Endodontics-RootCanalAnterior', 3, '2D9FAAE3-CD7D-472A-B766-CCC5F85C235B', 'media\GURU\mov\antRootCanal.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Endodontics-RootCanalPosterior', 3, 'FC41A73A-2414-4052-A3CB-406A21B37B46', 'media\GURU\mov\posRootCanal.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Endodontics-Anesthetic', 3, 'AD2949CF-B56D-42FF-95DF-7FD337393A86', 'media\GURU\mov\anesthetic.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Endodontics-Apicoectomy', 3, 'E6FCD980-218D-11DF-8A39-0800200C9A66', 'media\GURU\mov\apicoectomy.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Endodontics-PulpVitalityTest', 3, '8A4F8A40-2190-11DF-8A39-0800200C9A66', 'media\GURU\mov\pulpVitalityTest.mov'

--High Tech
IF NOT EXISTS (SELECT * FROM tblMenus WHERE MenuName = 'Menu-Dental-HighTech' AND PlaylistId = @currentPlaylist)
	EXEC dbo.sp_menu_AddMenuItem -1, 7, 'Menu-Dental-HighTech', -1, @currentPlaylist
SET @currentMenu = (SELECT TOP 1 MenuId FROM tblMenus WHERE MenuName = 'Menu-Dental-HighTech' AND PlaylistId = @currentPlaylist)
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'HighTech-AirAbrasion', 3, '288F103B-0EB8-4FE1-9E68-3B0FBEC270CC', 'media\GURU\mov\airAbrasion.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'HighTech-CrownMilling', 3, 'A96289AB-E6E6-4781-876C-5B375B26B331', 'media\GURU\mov\cerec.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'HighTech-DigitalX-ray', 3, '4DD55383-1FE0-48CF-BF81-0DF83B536F22', 'media\GURU\mov\xray.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'HighTech-ChemiluminescentOralCancerDetection', 3, 'A3E00F49-A0DA-4864-96B4-606B794EDCBD', 'media\GURU\mov\oralCancerDetection2.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'HighTech-DiagnosticLaser', 3, '2374CBE4-DED9-11DE-8A39-0800200C9A66', 'media\GURU\mov\diagnosticLaser.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'HighTech-FullBreathSleep', 3, '0DCEE19E-99A1-4287-BB1A-6A9CE367DE00', 'media\GURU\mov\fullBreathSleep.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'HighTech-IntraoralCamera', 3, '69296033-4A4C-4393-890B-C089FCBE53A1', 'media\GURU\mov\intraoralCameraHD.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'HighTech-OralCancerDetection', 3, 'EF8B7660-AF38-4CE2-918D-F33615546BF1', 'media\GURU\mov\oralCancerDetection.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'HighTech-WaterLaserClassI', 3, '81833649-30B5-4AA7-8E32-2BBFE706FDE5', 'media\GURU\mov\waterLaser.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'HighTech-OralTumorRemoval', 3, '154C7165-A34B-4B42-8CCF-C7708BC3CEA7', 'media\GURU\mov\oralLesionRemoval.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'HighTech-MicroscopicExamination', 3, '35466662-3815-4FF2-A83D-39AAADAFE61E', 'media\GURU\mov\microscopicExamination.mov'

IF NOT EXISTS (SELECT * FROM tblMenus WHERE MenuName = 'Menu-Dental-Hygiene' AND PlaylistId = @currentPlaylist)
	EXEC dbo.sp_menu_AddMenuItem -1, 8, 'Menu-Dental-Hygiene', -1, @currentPlaylist
SET @currentMenu = (SELECT TOP 1 MenuId FROM tblMenus WHERE MenuName = 'Menu-Dental-Hygiene' AND PlaylistId = @currentPlaylist)
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Hygiene-Biofilm', 3, 'BA333602-7E9D-40D4-8C89-1FDD3146AEC2', 'media\GURU\mov\biofilm.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Hygiene-Biofilm-Ext', 3, 'E3655523-CB4E-471F-AB4A-8C23AFEFF8D4', 'media\GURU\mov\biofilmV.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Hygiene-BrushLower', 3, 'C0A989FE-CF78-4E30-9953-8B2DEBF4D1C2', 'media\GURU\mov\bottombrushing.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Hygiene-BrushUpper', 3, '4292AE3E-6A00-443E-B026-F52C2A1E4A2D', 'media\GURU\mov\topbrushing.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Hygiene-Brushing-Ext', 3, 'FFDEA717-CC30-4A77-90D0-077F41617731', 'media\GURU\mov\brushingV.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Hygiene-BrushingClose-up', 3, 'F4206E0C-A073-4591-8256-E9D06EF02054', 'media\GURU\mov\gumbrushing.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Hygiene-Cavities-Ext', 3, '6ACC87AE-CAC3-46CF-B750-F2704C04F6AF', 'media\GURU\mov\cavitiesV.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Hygiene-CavityCrossSection', 3, '0A2FC92D-00DB-45CF-A7C1-F372A19ED788', 'media\GURU\mov\cavityCrossSection.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Hygiene-ElectricToothbrush', 3, 'CEEC3637-F56E-48E8-82A2-C720BA40FF8A', 'media\GURU\mov\electricToothbrush.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Hygiene-FlossAid', 3, '89837B0F-5921-4362-BBFC-5F1B751C63D8', 'media\GURU\mov\flossaid.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Hygiene-Flossing', 3, '703971B6-DA01-4A08-8A97-D18C601B2742', 'media\GURU\mov\flossing.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Hygiene-Flossing-Ext', 3, 'E5EE88A6-BD9F-4A18-9307-B806AA687FBD', 'media\GURU\mov\flossingV.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Hygiene-FlossingClose-up', 3, '84CC2A46-D318-49E8-AEBD-3F89E87ECFBF', 'media\GURU\mov\flossingcloseup.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Hygiene-FluorideTreatment', 3, 'D5575B48-307C-4C17-84C3-EB4BC2495009', 'media\GURU\mov\fluoride.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Hygiene-GingivalRecession', 3, 'D608A2F7-DD0D-4246-92E9-C58AA650A63B', 'media\GURU\mov\gumRecession.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Hygiene-OuterSweepBrushing', 3, 'B005E239-F016-45EB-B566-108356336B2A', 'media\GURU\mov\outersweepbrushing.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Hygiene-pHLevels', 3, '789581AD-AA6A-4C09-8154-73E1DF5BA8CD', 'media\GURU\mov\phLevel.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Hygiene-ProxyBrush', 3, '28F87F90-06AB-4618-A51F-BC07679C9E1B', 'media\GURU\mov\proxyBrush.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Hygiene-Sealant', 3, '696081C0-65EE-49EF-91D1-B19B90CD396E', 'media\GURU\mov\sealant.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Hygiene-ToothSensitivity-Ext', 3, 'ED913D20-0D83-4DAD-A3A1-F49F6C058D2C', 'media\GURU\mov\sensitivityV.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Hygiene-SensitivityTreatment', 3, '6936EE69-E84E-4FA8-8F82-0A5D6F18465B', 'media\GURU\mov\sensitivityTreatment.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Hygiene-PerioPocket', 3, '8DF7F743-26E1-44DA-A02D-2B0328DCFA90', 'media\GURU\mov\perioPocket.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Hygiene-RepairSequence', 3, '99467346-8E43-4217-9B78-7C522AF516B0', 'media\GURU\mov\repairSequence.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Hygiene-Remineralization', 3, 'F02325D8-08AC-4D47-BDA6-2A97DAC92AB8', 'media\GURU\mov\DecayRestore.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Hygiene-AbnormalEating', 3, 'A6DA6800-A8CF-493D-990D-52714FFAB338', 'media\GURU\mov\AbnormalEating.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Hygiene-ChlorhexidineRinse', 3, '8775BD10-CDB2-4225-AC6A-437B2D7C894E', 'media\GURU\mov\ChlorhexidineRinse.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Hygiene-DentureCare', 3, '8D3E2AF7-2DE7-4683-8BAB-6F77903E71FE', 'media\GURU\mov\DentureCare.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Hygiene-ExtractionPremolar', 3, '2AC163A6-E8B6-4ACE-9EED-9890922E4B7B', 'media\GURU\mov\ExtractionPremolar.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Hygiene-FluorideNew', 3, '7880217B-5F71-4FEF-9AB1-8E9F15FEF859', 'media\GURU\mov\FluorideNew.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Hygiene-FoodImpaction', 3, 'AAA72926-5CA0-456A-9760-EF8A41C36131', 'media\GURU\mov\FoodImpaction.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Hygiene-NormalEating', 3, '559EB93C-3E6A-4E49-B79A-AF08E0EA50C5', 'media\GURU\mov\normalEating.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Hygiene-SalivaEffect', 3, 'BD132FD2-A0EA-4658-946D-065F6EF9BEE4', 'media\GURU\mov\SalivaEffect.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Hygiene-ToothSplint', 3, '38469E15-2378-4628-AD81-7C5E7669A19C', 'media\GURU\mov\ToothSplint.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Hygiene-UltrasonicScaling', 3, '98F574FC-C095-4DD6-9228-AE1EDB35BA10', 'media\GURU\mov\ultrasonicScaling.mov'


IF NOT EXISTS (SELECT * FROM tblMenus WHERE MenuName = 'Menu-Dental-Implant' AND PlaylistId = @currentPlaylist)
	EXEC dbo.sp_menu_AddMenuItem -1, 9, 'Menu-Dental-Implant', -1, @currentPlaylist
SET @currentMenu = (SELECT TOP 1 MenuId FROM tblMenus WHERE MenuName = 'Menu-Dental-Implant' AND PlaylistId = @currentPlaylist)
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Implant-Implant-Ext', 3, 'BB38A111-18E7-4961-B212-21E37E4B0343', 'media\GURU\mov\implantV.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Implant-ImplantvsPartialComparison', 2, '27110F02-BBAD-4DE5-8DE5-F012FEAB66D7', 'media\GURU\png\Implantspartialcomparison.png'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Implant-AnteriorImplant', 3, '5160C6C6-D002-41F6-99BF-6D4BAB096B6D', 'media\GURU\mov\cuspidImplant.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Implant-FullBarImplant', 3, '0E69B825-59EE-4000-81A1-3AA882C03D2B', 'media\GURU\mov\fullBarImplant.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Implant-ImplantIncisor', 3, '96724806-343C-4195-AD75-B9EBE2876764', 'media\GURU\mov\ImplantIncisor.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Implant-ImplantMolar', 3, '61CBF176-5791-4A12-9307-832D51C8CAE4', 'media\GURU\mov\ImplantMolar.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Implant-LaserImplantRestoration', 3, 'D176F86B-329F-43C9-8C12-02084156EB25', 'media\GURU\mov\laserImplantRestoration.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Implant-MiniImplant', 3, '0F7889BC-7741-44DC-A34E-7194ECB493C4', 'media\GURU\mov\miniImplant.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Implant-RootFormImplant', 3, '5E090960-33C0-434F-83F2-F831A2B1AFAC', 'media\GURU\mov\implantRootForm.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Implant-SinusCavityExpansion', 3, 'F36E91A9-6AAE-432E-A60B-632CB514A97E', 'media\GURU\mov\sinusExpansion.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Implant-SinusLift', 3, 'BE5D704B-855C-432E-8E87-4B966C3907CD', 'media\GURU\mov\sinusLift.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Implant-ImplantIncisor-OneStage', 3, 'A48E1E99-44E9-4120-B845-6FBA6873F52D', 'media\GURU\mov\implantRootOneStage.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Implant-PartialDenturevsImplant', 3, '302405EE-628A-4059-B88C-595142CA0649', 'media\GURU\mov\dentureImplant.mov'


IF NOT EXISTS (SELECT * FROM tblMenus WHERE MenuName = 'Menu-Dental-IntracoronalRestoration' AND PlaylistId = @currentPlaylist)
	EXEC dbo.sp_menu_AddMenuItem -1, 10, 'Menu-Dental-IntracoronalRestoration', -1, @currentPlaylist
SET @currentMenu = (SELECT TOP 1 MenuId FROM tblMenus WHERE MenuName = 'Menu-Dental-IntracoronalRestoration' AND PlaylistId = @currentPlaylist)
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'IntracoronalRestoration-Class1', 3, '00105E04-1C96-4BBC-B93C-7D0075E1162D', 'media\GURU\mov\class1.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'IntracoronalRestoration-Class3', 3, '8181A4F1-8216-467D-8330-941395D1296E', 'media\GURU\mov\class3.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'IntracoronalRestoration-Class4', 3, '4728B8E6-52F3-4138-ACC0-26A7682FB2E9', 'media\GURU\mov\class4.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'IntracoronalRestoration-Class5', 3, '286B087E-A69C-4D82-8F90-9B1334FBCB60', 'media\GURU\mov\class5Lesion.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'IntracoronalRestoration-Inlay', 3, 'E1871F9A-B00C-431E-8823-E8D2D0447CB3', 'media\GURU\mov\inlay.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'IntracoronalRestoration-InlayComparison', 2, '1532C242-0E0E-48BF-9F24-673DB041CB98', 'media\GURU\png\inlayCompare.png'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'IntracoronalRestoration-ClassIIAmalgam', 3, '1FC458B9-B6C2-4B07-A8E1-EE447BA8F79B', 'media\GURU\mov\amalgam.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'IntracoronalRestoration-MODComposite', 3, '422F6CB6-0769-4B5F-B887-73DBDD815FE7', 'media\GURU\mov\composite.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'IntracoronalRestoration-Onlay', 3, '7F8984E2-4C8C-4486-A628-76019D01195B', 'media\GURU\mov\onlay.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'IntracoronalRestoration-ChemicalToothErosion', 3, '7AA1718C-E312-48C0-8EC0-75990888FE6D', 'media\GURU\mov\toothErosionHD.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'IntracoronalRestoration-DentinGrowthAnimation', 3, 'C515D345-76BD-4D95-8BD2-D5B8619CAEB2', 'media\GURU\mov\DentinGrowth.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'IntracoronalRestoration-MicroFractures', 3, '7886FF40-2169-11DF-8A39-0800200C9A66', 'media\GURU\mov\microfractures.mov'


IF NOT EXISTS (SELECT * FROM tblMenus WHERE MenuName = 'Menu-Dental-Laser' AND PlaylistId = @currentPlaylist)
	EXEC dbo.sp_menu_AddMenuItem -1, 11, 'Menu-Dental-Laser', -1, @currentPlaylist
SET @currentMenu = (SELECT TOP 1 MenuId FROM tblMenus WHERE MenuName = 'Menu-Dental-Laser' AND PlaylistId = @currentPlaylist)
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Laser-LaserCavityRemoval', 3, 'CA4FA91F-DA47-431D-9186-2B3C74D27EE1', 'media\GURU\mov\laserCavityRemoval.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Laser-CosmeticLaserGingivectomy', 3, '367681F7-AC09-495D-8653-D198FC9BC0F3', 'media\GURU\mov\laserCrownLengthening.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Laser-LaserBacterialDecontamination', 3, '7C21B40A-BD4F-4EC4-B4AC-E26F892786BB', 'media\GURU\mov\laserDeepClean.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Laser-LaserFrenectomy', 3, 'D53B7F92-A1E6-4797-9C49-5F37FDA57071', 'media\GURU\mov\Frenectomy.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Laser-LaserFrenectomyLip', 3, '34971F7B-F6BB-406E-AFFF-853225970E5D', 'media\GURU\mov\laserFrenectomyLip.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Laser-LaserImplantRestoration', 3, 'D176F86B-329F-43C9-8C12-02084156EB25', 'media\GURU\mov\laserImplantRestoration.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Laser-LaserTroughing', 3, '5479C19A-69E6-4049-88D7-F6502ADD28D1', 'media\GURU\mov\laserTroughing.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Laser-LaserUlcerTreatment', 3, '870DCB5B-C218-47BE-86FA-83F47E040A27', 'media\GURU\mov\laserAphthousUlcerTreatment.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Laser-LaserStainRemoval', 3, '06C41918-745D-43D9-9EE7-A61F6A71F27A', 'media\GURU\mov\laserStainRemoval.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Laser-LaserWhitening', 3, '6AC31A6A-4BBD-4C1E-8279-675A5B5245AC', 'media\GURU\mov\laserBleaching.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Laser-LaserSealant', 3, '086BED93-6677-4E29-BC70-CF72EDCA9ED0', 'media\GURU\mov\LaserSealant.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Laser-LaserSensitivityTreatment', 3, '7C8D7FEA-0E96-4FC0-A0F1-4054ED6D6EEA', 'media\GURU\mov\LaserSensitivityTreatment.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Laser-WaterLaserClassI', 3, '81833649-30B5-4AA7-8E32-2BBFE706FDE5', 'media\GURU\mov\waterLaser.mov'


IF NOT EXISTS (SELECT * FROM tblMenus WHERE MenuName = 'Menu-Dental-Orthodontics' AND PlaylistId = @currentPlaylist)
	EXEC dbo.sp_menu_AddMenuItem -1, 12, 'Menu-Dental-Orthodontics', -1, @currentPlaylist
SET @currentMenu = (SELECT TOP 1 MenuId FROM tblMenus WHERE MenuName = 'Menu-Dental-Orthodontics' AND PlaylistId = @currentPlaylist)
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Orthodontics-AestheticToothAlignment', 3, 'B4815ADB-FF17-420C-9712-FD9AB94454CD', 'media\GURU\mov\invisalign.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Orthodontics-BondedRetainer', 3, 'F09DA5C7-023F-4A83-98EC-D9A14AA2328E', 'media\GURU\mov\bondedRetainer.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Orthodontics-Braces-Ext', 3, '6443D099-3D28-4B6F-BDE0-60A9493D2727', 'media\GURU\mov\bracesV.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Orthodontics-BracesCompared', 3, 'CEB42C50-89A0-46E9-910D-0A7D94882A8A', 'media\GURU\mov\bracesCompare.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Orthodontics-BracesCrowding', 3, '9BD374B5-D873-4088-86A9-7AAAC815D7B9', 'media\GURU\mov\bracesCrowding.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Orthodontics-BracesProxyBrush', 3, 'EFE23DC8-620B-45EE-981C-CB493E068CB7', 'media\GURU\mov\bracesProxyBrush.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Orthodontics-CelbRetainer', 3, 'A638DFCF-7EBD-446D-A91D-99911E06B7E6', 'media\GURU\mov\celbRetainer.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Orthodontics-ClassIMalocclusion', 3, '41D6FFEF-0BE5-4557-86B6-0117A8D690B3', 'media\GURU\mov\classImalocclusion.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Orthodontics-ClassIIMalocclusion', 3, 'F34011A6-D4B2-4AC9-9D14-C54095EAB5E2', 'media\GURU\mov\classIImalocclusion.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Orthodontics-ClassIIIMalocclusion', 3, '5BDD1611-FF33-47AC-88DA-06736E1EF02B', 'media\GURU\mov\classIIImalocclusion.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Orthodontics-ClosedBite', 3, '2A71994F-F410-4BF5-B9F8-86C195B415C0', 'media\GURU\mov\closedBite.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Orthodontics-Crossbite', 3, '72069DD0-3AEB-438C-8AF4-111F451D1AAE', 'media\GURU\mov\crossBite.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Orthodontics-FlossingBraces', 3, '3444509E-AB0E-4C3E-9C8F-2CE38112657B', 'media\GURU\mov\bracesFlossing.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Orthodontics-Hawley', 3, 'D920D3B5-A75C-4E0A-8E29-C4D96E17E325', 'media\GURU\mov\hawley.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Orthodontics-HawleyElastic', 3, '5DC2EE5E-D5B0-4820-B5C5-0903D6380B46', 'media\GURU\mov\hawleyElastic.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Orthodontics-HawleySpring', 3, '163B039A-ABC2-4A21-A60E-337F7F6B449E', 'media\GURU\mov\hawleySpring.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Orthodontics-HerbstAppliance', 3, '529966A9-5DDF-4E08-8459-A142C3CEB5D3', 'media\GURU\mov\herbstAppliance.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Orthodontics-LingualBraces', 3, '93B82EE4-B836-4BC9-A55A-EA1DB506B5BA', 'media\GURU\mov\lingualBraces.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Orthodontics-LowerLingualArch', 3, '40977DAB-CB90-49A8-AE26-D549561B5AAD', 'media\GURU\mov\lowerLingualArch.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Orthodontics-NanceApplianceCaseA', 3, 'AF0AFBFA-6F5F-4050-AF88-884B139D2DFC', 'media\GURU\mov\nanceApplianceCaseA.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Orthodontics-NanceApplianceCaseB', 3, '11B99E29-B6A6-4554-A39B-5806CE7BB806', 'media\GURU\mov\nanceApplianceCaseB.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Orthodontics-OpenBite', 3, 'A0F98696-6258-4E1C-A5AA-B42437C162CF', 'media\GURU\mov\openBite.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Orthodontics-OrthodonticAppliance-Ext', 3, '39C41973-FB5E-4098-9992-BE4050EC9994', 'media\GURU\mov\orthoAppV.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Orthodontics-QuadHelix', 3, '357B65BC-7633-40A9-8251-D0CB40611CD5', 'media\GURU\mov\quadHelix.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Orthodontics-RapidPalatalExpander', 3, 'D7975FCE-A197-47A7-8977-43542EB8AD45', 'media\GURU\mov\rapidPalateExpander.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Orthodontics-RickettsRetainer', 3, 'D972AC1E-2956-45C3-A4BC-815ACEA60587', 'media\GURU\mov\rickettsRetainer.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Orthodontics-SagittalAppliance', 3, '316CC99A-C353-45DB-B703-8B6FA0B11823', 'media\GURU\mov\sagittalAppliance.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Orthodontics-SpaceMaintainer', 3, 'D9316A1B-24B5-4CFD-AD73-422BAA234C2F', 'media\GURU\mov\spaceRegainer.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Orthodontics-TongueThrusting', 3, '0E0FE5C7-CB33-4A6F-A9AC-D555DDD40242', 'media\GURU\mov\TongueThrusting.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Orthodontics-OvergrownGumsonBraces', 3, '2374CBE7-DED9-11DE-8A39-0800200C9A66', 'media\GURU\mov\overgrownBraces.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Orthodontics-TemporaryAnchorageScrews', 3, '2374CBE6-DED9-11DE-8A39-0800200C9A66', 'media\GURU\mov\temporaryAnchorDevice.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Orthodontics-TranspalatalAppliance', 3, '2374CBE0-DED9-11DE-8A39-0800200C9A66', 'media\GURU\mov\transpalatalAppliance.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Orthodontics-HealthyOcclusion', 3, 'EE470D86-CCA5-48DD-897F-373C5A17F92F', 'media\GURU\mov\healthyOcclusion.mov'

IF NOT EXISTS (SELECT * FROM tblMenus WHERE MenuName = 'Menu-Dental-Periodontics' AND PlaylistId = @currentPlaylist)
	EXEC dbo.sp_menu_AddMenuItem -1, 13, 'Menu-Dental-Periodontics', -1, @currentPlaylist
SET @currentMenu = (SELECT TOP 1 MenuId FROM tblMenus WHERE MenuName = 'Menu-Dental-Periodontics' AND PlaylistId = @currentPlaylist)
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Periodontics-BoneGrafting', 3, '917A0D6A-6EEB-4EC5-A1F8-38A1D4EDDAF4', 'media\GURU\mov\boneGraft.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Periodontics-CrownLengtheningCosmetic', 3, '488E66EA-C5E7-4251-970A-4CEA3490E41E', 'media\GURU\mov\crownlengthening.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Periodontics-CrownLengthening', 3, '5F32AFB7-08AC-475B-B0AB-235128424C28', 'media\GURU\mov\crownlengthen2.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Periodontics-CosmeticLaserGingivectomy', 3, '367681F7-AC09-495D-8653-D198FC9BC0F3', 'media\GURU\mov\laserCrownLengthening.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Periodontics-FurcationPockets', 3, '5121D428-0051-4AB5-5A02-EB839D65E792', 'media\GURU\mov\furcationPocketsSevere.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Periodontics-GingivalRecession', 3, 'D608A2F7-DD0D-4246-92E9-C58AA650A63B', 'media\GURU\mov\gumRecession.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Periodontics-GingivalGraftUpper', 3, '3E0B5EEB-38CF-45C1-B4F7-52170D8164D0', 'media\GURU\mov\GingivalGraftUpper.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Periodontics-Gingivitis', 3, '1271D428-0051-4AB5-8A02-EB839D65E728', 'media\GURU\mov\gingivitis.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Periodontics-PerioPocket', 3, '8DF7F743-26E1-44DA-A02D-2B0328DCFA90', 'media\GURU\mov\perioPocket.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Periodontics-Periodontitis-Ext', 3, '9441E5EF-5D8A-413A-A047-913C7BA51852', 'media\GURU\mov\perioV.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Periodontics-PeriodontitisStages', 3, '917469D5-F2D0-41A7-BEBD-E603395D8722', 'media\GURU\mov\periodontitis.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Periodontics-RootPlaning', 3, '2BFA7F61-27A2-4A51-8797-F078C33AE096', 'media\GURU\mov\RootPlaning.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Periodontics-SinusCavityExpansion', 3, 'F36E91A9-6AAE-432E-A60B-632CB514A97E', 'media\GURU\mov\sinusExpansion.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Periodontics-SinusLift', 3, 'BE5D704B-855C-432E-8E87-4B966C3907CD', 'media\GURU\mov\sinusLift.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Periodontics-SoftTissueGrafting', 3, 'FECA09CF-3D6B-4073-919E-9666FA66BBA1', 'media\GURU\mov\TissueGrafting.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Periodontics-Stage1Healthygums', 2, '77A89DBA-DA1D-4BF5-98F6-80D420D729D6', 'media\GURU\png\healthy tooth.png'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Periodontics-Stage2Gingivitis', 2, '41F5EF18-45DB-482D-B65F-3FB6FACE7E9C', 'media\GURU\png\gingivitis.png'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Periodontics-Stage3MildPeriodontitis', 2, 'FE3A9955-F3B1-4029-A881-50BAC56E0B8D', 'media\GURU\png\mild periodontitis.png'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Periodontics-Stage4ModeratePeriodontitis', 2, 'EE51BCC5-D570-499F-92F2-0F14BBCB5410', 'media\GURU\png\moderateperiodontitis.png'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Periodontics-Stage5SeverePeriodontitis', 2, 'DC3671E4-0586-4B62-A2F3-D35F3B580B17', 'media\GURU\png\severe periodontitis.png'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Periodontics-Anesthetic', 3, 'AD2949CF-B56D-42FF-95DF-7FD337393A86', 'media\GURU\mov\anesthetic.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Periodontics-ElectroSurgery', 3, 'EFEDA5B1-F0D6-444C-B323-5B30FE11F62F', 'media\GURU\mov\electrosurgery.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Periodontics-Endogain', 3, '39CF902C-E649-4051-B36C-247319B56C95', 'media\GURU\mov\endogain.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Periodontics-GuidedBoneRegeneration', 3, 'F6268EC9-B9DA-41F1-A644-A0AA55F0B2E4', 'media\GURU\mov\GuidedBoneRegeneration.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Periodontics-Osseous', 3, '60A752CC-778A-4FAD-A431-E1D66AEF7020', 'media\GURU\mov\osseousSurgery.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Periodontics-PerioAntibiotic', 3, '2192095D-59E7-40FA-92F2-9999CEF81927', 'media\GURU\mov\PerioAntibiotic.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Periodontics-PerioBoneGraft', 3, 'BAC360DB-F476-4141-B41F-5B2C0D8A75FA', 'media\GURU\mov\perioBoneGraft.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Periodontics-PerioChipChlorhexidine', 3, '2374CBE2-DED9-11DE-8A39-0800200C9A66', 'media\GURU\mov\perioChipChlorhexidine.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Periodontics-ProphyvsPerio', 3, 'BDA0107E-A211-4542-94B9-5F4330F8F90C', 'media\GURU\mov\ProphyVPerio.mov'


IF NOT EXISTS (SELECT * FROM tblMenus WHERE MenuName = 'Menu-Dental-Reference' AND PlaylistId = @currentPlaylist)
	EXEC dbo.sp_menu_AddMenuItem -1, 14, 'Menu-Dental-Reference', -1, @currentPlaylist
SET @currentMenu = (SELECT TOP 1 MenuId FROM tblMenus WHERE MenuName = 'Menu-Dental-Reference' AND PlaylistId = @currentPlaylist)
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Reference-ArchView', 2, '92A70957-CD11-46EA-8CDA-230C76C58727', 'media\GURU\png\arch.png'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Reference-Front', 2, '0131FCA9-ECD2-42C0-8267-8EFB661826D2', 'media\GURU\png\full mouth front -gums.png'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Reference-FullMouthLeft', 2, '6889D602-93DF-4DC5-A8CF-A11CA524B77C', 'media\GURU\png\full mouth left.png'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Reference-FullMouthRight', 2, '639A7BA4-0B6D-4635-9EA0-87149BCCAEB5', 'media\GURU\png\full mouth right.png'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Reference-MandibularAnterior', 2, '07FF93CE-3E42-4E6D-B13D-7879928DB21F', 'media\GURU\png\mandibular front.png'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Reference-MandibularLeft', 2, 'E31BB3BA-6909-4E75-BF1E-48342468C6B4', 'media\GURU\png\mandibular left.png'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Reference-MandibularOcclusal', 2, 'BB104838-CC7B-4147-9008-6FB823340FC4', 'media\GURU\png\mandibular occlusal.png'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Reference-MandibularRight', 2, '23083F0C-6D9D-455C-BB03-CFF9D62DE023', 'media\GURU\png\mandibular right.png'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Reference-MaxillaryAnterior', 2, '8419E4D6-561D-4768-AD93-2E0567C2E705', 'media\GURU\png\maxillary front.png'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Reference-MaxillaryLeft', 2, 'D00AA859-FFE4-454E-97E1-2EF54241E53A', 'media\GURU\png\maxillary left.png'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Reference-MaxillaryOcclusal', 2, 'EF0BD8C0-FBB6-40CD-AA3D-6AF5D5E7B764', 'media\GURU\png\maxillary occlusal.png'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Reference-MaxillaryRight', 2, 'F19A58D0-8C1B-488A-AB3C-9E74DED23BC6', 'media\GURU\png\maxillary right.png'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Reference-KidsArchView', 2, '71CE5572-2284-4A03-9F41-D0E6890DDC47', 'media\GURU\png\kidsarch.png'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Reference-KidsFront', 2, 'DC60B2B4-4A78-4878-A415-A5C90C791C00', 'media\GURU\png\kidsFullMouthAnterior.png'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Reference-KidsFullMouthLeft', 2, '8BFD4627-9602-4A56-B58A-565AD4DF158E', 'media\GURU\png\kidsFullMouthLeft.png'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Reference-KidsFullMouthRight', 2, 'D330EF15-57A1-4CD9-8677-2783A71F8AB2', 'media\GURU\png\kidsFullMouthRight.png'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Reference-KidsMandibularAnterior', 2, '3963CE3A-A3FD-4D19-BF18-9C0ACE7F85D1', 'media\GURU\png\kidsMandibularAnterior.png'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Reference-KidsMandibularLeft', 2, 'FBCC9EEF-D3F7-40D2-AF61-EA19F57CFC6A', 'media\GURU\png\kidsMandibularLeft.png'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Reference-KidsMandibularOcclusal', 2, '57A52302-A76D-4F73-80CF-59CC48161F57', 'media\GURU\png\kidsMandibularOcclusal.png'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Reference-KidsMandibularRight', 2, '40215DDE-26F0-4E4F-AE29-D7F05BB536CD', 'media\GURU\png\kidsMandibularRight.png'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Reference-KidsMaxillaryAnterior', 2, 'EC349D5A-B08A-41FE-95F8-61285C3EAA97', 'media\GURU\png\kidsMaxillaryAnterior.png'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Reference-KidsMaxillaryLeft', 2, '70E39BEF-8615-4776-854A-E5A6EFEC189E', 'media\GURU\png\kidsMaxillaryLeft.png'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Reference-KidsMaxillaryOcclusal', 2, 'CDD5908C-6A8B-4320-A78F-765826DEB390', 'media\GURU\png\kidsMaxillaryOcclusal.png'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Reference-KidsMaxillaryRight', 2, '07351A59-4C24-48C1-885C-DA0ED940E187', 'media\GURU\png\kidsMaxillaryRight.png'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Reference-TurnAroundBicuspid', 3, '1BD06DCB-186C-4F0D-805D-925FA6AC8B27', 'media\GURU\mov\turnAroundBicuspid.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Reference-TurnAroundCuspid', 3, '05D7250F-5CCE-46E9-8FCE-8483AFE006A2', 'media\GURU\mov\turnAroundCuspid.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Reference-TurnAroundIncisor', 3, 'E06025F1-6D34-4201-95CE-B47B586C2D4D', 'media\GURU\mov\turnAroundIncisor.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Reference-TurnAroundMolar', 3, 'E00F0B2E-F996-4B08-9ACA-A9611748F89F', 'media\GURU\mov\turnAroundMolar.mov'


IF NOT EXISTS (SELECT * FROM tblMenus WHERE MenuName = 'Menu-Dental-TMJ' AND PlaylistId = @currentPlaylist)
	EXEC dbo.sp_menu_AddMenuItem -1, 15, 'Menu-Dental-TMJ', -1, @currentPlaylist
SET @currentMenu = (SELECT TOP 1 MenuId FROM tblMenus WHERE MenuName = 'Menu-Dental-TMJ' AND PlaylistId = @currentPlaylist)
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'TMJ-Malocclusion', 3, '4909CF6A-6CA6-4F13-B4A2-1C33BF3F184E', 'media\GURU\mov\malocclusion.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'TMJ-TMDTMJ', 3, '6AA2CCE7-C3CD-49BA-AD43-A9882B144C28', 'media\GURU\mov\tmd.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'TMJ-NTISuppression', 3, '2374CBE3-DED9-11DE-8A39-0800200C9A66', 'media\GURU\mov\ntiSuppression.mov'


IF NOT EXISTS (SELECT * FROM tblMenus WHERE MenuName = 'Menu-Dental-Veneers' AND PlaylistId = @currentPlaylist)
	EXEC dbo.sp_menu_AddMenuItem -1, 16, 'Menu-Dental-Veneers', -1, @currentPlaylist
SET @currentMenu = (SELECT TOP 1 MenuId FROM tblMenus WHERE MenuName = 'Menu-Dental-Veneers' AND PlaylistId = @currentPlaylist)
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Veneers-Bonding', 3, '02A075ED-2047-4B55-A13A-1E6960B7DB1D', 'media\GURU\mov\bonding.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Veneers-Diastema-Ext', 3, 'B8763AFA-2285-413F-9CE0-4C1128ABC89E', 'media\GURU\mov\diastemaV.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Veneers-ProximalDecay', 2, 'A6E99C83-E6A2-4A55-AA48-C422EC7D1A15', 'media\GURU\png\veneerDecayTooth.png'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Veneers-Veneers-Ext', 3, 'F252E956-9C5D-4C69-B531-5932545C6004', 'media\GURU\mov\veneersV.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Veneers-VeneerChipped', 3, 'FE314FC4-0B72-4C9F-8C9E-11E621015237', 'media\GURU\mov\veneerChipped.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Veneers-VeneerMalformedTooth', 3, '43E6C34D-2F63-4201-81C3-A67D0A4A5BEA', 'media\GURU\mov\veneer.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Veneers-VeneerStained', 3, '2CD3BAC7-346B-4818-81C4-4C1A9A574076', 'media\GURU\mov\veneerStained.mov'


IF NOT EXISTS (SELECT * FROM tblMenus WHERE MenuName = 'Menu-Dental-Whitening' AND PlaylistId = @currentPlaylist)
	EXEC dbo.sp_menu_AddMenuItem -1, 17, 'Menu-Dental-Whitening', -1, @currentPlaylist
SET @currentMenu = (SELECT TOP 1 MenuId FROM tblMenus WHERE MenuName = 'Menu-Dental-Whitening' AND PlaylistId = @currentPlaylist)
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Whitening-In-officeWhitening', 3, '77BC2E8F-6B75-496A-AF52-4B10ABDD7D2C', 'media\GURU\mov\zoomWhitening.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Whitening-LaserWhitening', 3, '6AC31A6A-4BBD-4C1E-8279-675A5B5245AC', 'media\GURU\mov\laserBleaching.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Whitening-Strips', 3, '93FC9635-B158-47CB-9F5E-47E5BCD73E48', 'media\GURU\mov\bleachingStrips.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Whitening-Trays', 3, 'AAC7952F-804C-4E2D-9432-5F95CFC119F8', 'media\GURU\mov\bleachingTray.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Whitening-Whitening-Ext', 3, 'F268600B-EF7C-4E6F-8DE6-B12B6FB9949E', 'media\GURU\mov\whiteningV.mov'


IF NOT EXISTS (SELECT * FROM tblMenus WHERE MenuName = 'Menu-Dental-WisdomTeeth' AND PlaylistId = @currentPlaylist)
	EXEC dbo.sp_menu_AddMenuItem -1, 18, 'Menu-Dental-WisdomTeeth', -1, @currentPlaylist
SET @currentMenu = (SELECT TOP 1 MenuId FROM tblMenus WHERE MenuName = 'Menu-Dental-WisdomTeeth' AND PlaylistId = @currentPlaylist)
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'WisdomTeeth-ImpactedWisdomTooth', 2, '92293FD1-FB59-4538-869B-51EF583AEFC9', 'media\GURU\png\impaction.png'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'WisdomTeeth-WisdomTeeth-Ext', 3, '2D57ACD0-53AD-4078-ABA2-E90460EDC4E9', 'media\GURU\mov\wisdomTeethV.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'WisdomTeeth-WisdomToothCrowding', 3, 'DE973DFB-2C00-4E35-8C58-14E8CCCAA125', 'media\GURU\mov\impactedWisdomCrowding.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'WisdomTeeth-WisdomToothDecay', 3, '0D0C7739-A67F-4656-ABD5-BBC0326E12C3', 'media\GURU\mov\wisdomToothDecay.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'WisdomTeeth-WisdomToothExtraction', 3, '521C2AC4-8014-42A8-A878-928025430771', 'media\GURU\mov\wisdomToothExtraction.mov'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'WisdomTeeth-NormalWisdomTooth', 3, 'D1132E7E-A833-4A4F-BD00-BE202E750F71', 'media\GURU\mov\wisdomToothNormal.mov'


IF NOT EXISTS (SELECT * FROM tblMenus WHERE MenuName = 'Menu-Dental-DrawingSheets' AND PlaylistId = @currentPlaylist)
	EXEC dbo.sp_menu_AddMenuItem -1, 19, 'Menu-Dental-DrawingSheets', -1, @currentPlaylist
SET @currentMenu = (SELECT TOP 1 MenuId FROM tblMenus WHERE MenuName = 'Menu-Dental-DrawingSheets' AND PlaylistId = @currentPlaylist)
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'DrawingSheets-Black', 2, '39F5602B-D348-40AF-B140-F6FEBEC957D7', 'media\GURU\png\black.png'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'DrawingSheets-White', 2, '10A71813-C100-4D08-9AFD-8746B2E7E89B', 'media\GURU\png\white.png'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'DrawingSheets-CollegeRule', 2, 'EBBDC543-38EA-4020-A374-1AB8A4273C3A', 'media\GURU\png\college_rule.png'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'DrawingSheets-LinedBlue', 2, '4797AC28-E936-47E9-BE49-B73EFB0E9F0D', 'media\GURU\png\lined_blue.png'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'DrawingSheets-LinedGray', 2, 'FB396C84-FC9E-437B-BEC2-9F0EDB208EB8', 'media\GURU\png\lined_gray.png'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'DrawingSheets-LargeDots', 2, '4396E5A1-4B8D-4CCF-8E42-718144EE45F6', 'media\GURU\png\dots_large.png'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'DrawingSheets-MediumDots', 2, '49A58E1E-2BAA-48B1-83FE-59029E890ACF', 'media\GURU\png\dots_medium.png'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'DrawingSheets-SmallDots', 2, '97F4456A-5A3C-4C65-A6DD-BE4861D941CA', 'media\GURU\png\dots_small.png'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'DrawingSheets-BlueGrid', 2, '31B332D9-822E-4887-AB97-8A4D1A9985AE', 'media\GURU\png\grid_multi_blue.png'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'DrawingSheets-LargeBlueGrid', 2, '254A16D8-7216-4EF0-893E-949206190760', 'media\GURU\png\grid_large_blue.png'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'DrawingSheets-MediumBlueGrid', 2, 'CE076432-0557-462E-AED7-36C24C8DA4BC', 'media\GURU\png\grid_medium_blue.png'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'DrawingSheets-SmallBlueGrid', 2, '150B69C5-A715-4FDA-8553-4E05B9E0DEC4', 'media\GURU\png\grid_small_blue.png'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'DrawingSheets-GrayGrid', 2, '719FC86A-98EE-42DB-80DD-ABD06CDC6B38', 'media\GURU\png\grid_multi_gray.png'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'DrawingSheets-LargeGrayGrid', 2, '9E545479-4493-4D78-814A-FEA6B7224A08', 'media\GURU\png\grid_large_gray.png'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'DrawingSheets-MediumGrayGrid', 2, 'B085B99E-7622-40E9-A483-091D919EA3DF', 'media\GURU\png\grid_medium_gray.png'
EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'DrawingSheets-SmallGrayGrid', 2, '21C4914C-5A37-4749-A59B-5F228AE594A4', 'media\GURU\png\grid_small_gray.png'

-- Add in the Documents Section
EXEC sp_document_AddDocument '01', 'Documents-BrusherBaileyColoringBook', 'media\Guru\png\1.png'
EXEC sp_document_AddDocument '02', 'Documents-BrusherBaileyColoringBook', 'media\Guru\png\2.png'
EXEC sp_document_AddDocument '03', 'Documents-BrusherBaileyColoringBook', 'media\Guru\png\3.png'
EXEC sp_document_AddDocument '04', 'Documents-BrusherBaileyColoringBook', 'media\Guru\png\4.png'
EXEC sp_document_AddDocument '05', 'Documents-BrusherBaileyColoringBook', 'media\Guru\png\5.png'
EXEC sp_document_AddDocument '06', 'Documents-BrusherBaileyColoringBook', 'media\Guru\png\6.png'
EXEC sp_document_AddDocument '07', 'Documents-BrusherBaileyColoringBook', 'media\Guru\png\7.png'
EXEC sp_document_AddDocument '08', 'Documents-BrusherBaileyColoringBook', 'media\Guru\png\8.png'
EXEC sp_document_AddDocument '09', 'Documents-BrusherBaileyColoringBook', 'media\Guru\png\9.png'
EXEC sp_document_AddDocument '10', 'Documents-BrusherBaileyColoringBook', 'media\Guru\png\10.png'
EXEC sp_document_AddDocument '11', 'Documents-BrusherBaileyColoringBook', 'media\Guru\png\11.png'
EXEC sp_document_AddDocument '12', 'Documents-BrusherBaileyColoringBook', 'media\Guru\png\12.png'

--Ensure future references to the standard library are linked to the right playlist
UPDATE tblMedia SET PlaylistId = @currentPlaylist WHERE MediaId IN (SELECT MediaId FROM tblMenus WHERE PlaylistId = @currentPlaylist)
GO


---- Fix the sort orders
--DECLARE @userIds table(UserId int NOT NULL UNIQUE)
--INSERT INTO @userIds (UserId) SELECT UserId FROM tblUsers WHERE UserId != -1
--DECLARE @stdPlaylists table(PlaylistId int NOT NULL UNIQUE)
--INSERT INTO @stdPlaylists (PlaylistId) SELECT PlaylistId FROM tblPlaylists WHERE IsCustom = 0

--declare @userId int

--set @userId = (SELECT TOP 1 UserId FROM @userIds)
--WHILE @userId IS NOT NULL BEGIN
--	DECLARE @nextPosition int
--	SET @nextPosition = (SELECT TOP 1 (SortOrder+1) as Sort FROM tblTopLevelMenu WHERE UserId = @userId AND PlaylistID IN (SELECT PlaylistId FROM @stdPlaylists) ORDER BY SortOrder DESC)
	
--	DECLARE @fixme TABLE(PlaylistId int NOT NULL UNIQUE)
	
--	INSERT INTO @fixme (PlaylistId)
--	  SELECT PlaylistId FROM tblTopLevelMenu WHERE UserId != -1 AND
--		PlaylistId NOT IN (SELECT PlaylistID FROM @stdPlaylists) AND
--		SortOrder IN (SELECT SortOrder FROM tblTopLevelMenu WHERE UserId = @userId AND PlaylistId IN (SELECT PlaylistId FROM @stdPlaylists) )
--		ORDER BY SortOrder ASC
		
--	DECLARE @pid int
--	SET @pid = (SELECT TOP 1 PlaylistId FROM @fixme)
--	WHILE @pid IS NOT NULL BEGIN
--		UPDATE tblTopLevelMenu SET SortOrder = @nextPosition WHERE UserId = @userId AND PlaylistId = @pid
--		SET @nextPosition = @nextPosition + 1
		
--		DELETE FROM @fixme WHERE PlaylistId = @pid
--		SET @pid = (SELECT TOP 1 PlaylistID FROM @fixme)
--	END

--	DELETE FROM @userIds WHERE UserID = @userId
--	SET @userId = (SELECT TOP 1 UserId FROM @userIds)
--END

--GO