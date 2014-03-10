USE [mvdb]
GO
SET NOCOUNT ON

declare @currentPlaylist int
declare @currentMenu int
declare @now datetime
SET @now = GETDATE()

SET @currentMenu = NULL

IF NOT EXISTS (SELECT * FROM tblPlaylists WHERE Guid = 'A7CF0F87-7314-4D6D-8DCA-6017C3AC171C') BEGIN
	EXEC dbo.sp_playlist_AddPlaylist 'A7CF0F87-7314-4D6D-8DCA-6017C3AC171C', 'Menu-Featured-Crowns', 0, @now, NULL, 1, 0, 1
	SET @currentPlaylist = (SELECT TOP 1 PlaylistId FROM tblPlaylists WHERE Guid = 'A7CF0F87-7314-4D6D-8DCA-6017C3AC171C')
	EXEC dbo.sp_playlist_AddTopLevelMenu -1, @currentPlaylist, 0, 1
	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-Crowns-DecayedTooth', 2, '228F66B1-86C5-43BE-87FB-565E871AD0A4', 'media\Featured\png\posCracked_Amalgam_InterproximalDecay.png'
	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-Crowns-CrackedTooth', 1, '8CF25E31-56F5-431A-9CBB-B3352A10CADE', 'media\Featured\mov\posCracked_Crowns_01.mov'
	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-Crowns-PosteriorCrack', 2, 'DFE610AE-3C1D-45AB-B7E4-9E0D47EEEEC1', 'media\Featured\png\posCracked.png'
	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-Crowns-Fractures', 2, 'F1734434-7B68-412A-BA92-F7B96A4002CC', 'media\Featured\png\fractureCracksIntDecay.png'
	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-Crowns-InterproximalDecay', 2, '84B6418E-F5DE-4250-837B-2617AD0B95D6', 'media\Featured\png\severeDecay_TopInterproximal.png'
	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-Crowns-RecurrentDecay', 1, 'FA113902-0D2C-4FA2-BE01-ED39C48E1664', 'media\Featured\mov\bridgeDecay_Crowns_01.mov'
	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-Crowns-BridgeDecay', 2, 'D6451F3B-AA81-4719-83F3-20836278598E', 'media\Featured\png\bridgeDecay.png'
	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-Crowns-Crown', 2, 'FA3F4433-A359-4233-82AC-7ECE89750892', 'media\Featured\png\posCrownReplace_IntDecay.png'
	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-Crowns-CrownDecay', 1, '185DE0CE-1B32-4D61-9798-78FB87BC2FD4', 'media\Featured\mov\posCrownReplace_Crowns_01.mov'
	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-Crowns-Fillingdecay', 2, 'F1734434-7B68-412A-BA92-F7B96A4002CC', 'media\Featured\png\fractureCracksIntDecay.png'
	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-Crowns-Removefilling', 2, 'B142083A-6655-4E17-B567-48FD25E6F230', 'media\Featured\png\fractureFillingRemoved.png'
	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-Crowns-CleanupProcess', 2, 'DB65AD22-5522-4CE1-A738-623FA5111C3B', 'media\Featured\png\fractureFillingRemovedCleaned.png'
	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-Crowns-CordPackingOption', 2, '3BD0D8B1-DD2D-404E-9208-8508D92D6865', 'media\Featured\png\Cord_Packing.png'
	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-Crowns-LaserPrep', 2, 'CEE71A9E-61C8-4612-B2FC-3AFD98677D2A', 'media\Featured\png\laserPrep.png'
	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-Crowns-BuildupProcess', 1, '302D9B1E-47AA-472E-AD4C-0426BE08F838', 'media\Featured\mov\posCrownProcess_Crowns_01.mov'
	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-Crowns-BuildupComplete', 2, '7F88498A-5657-4541-B570-9E43819A7BA6', 'media\Featured\png\posCrownProcess_01.png'
	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-Crowns-MaterialOptions', 1, '970AA882-816F-46B9-8985-F215EC9FDA8C', 'media\Featured\mov\fractureV_Crowns_01.mov'
	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-Crowns-CrownComparison', 2, 'F9A8EF1A-95BE-41E5-801A-2ECB074D621A', 'media\Featured\png\crowncompare_WideScreen.png'
END


IF NOT EXISTS (SELECT * FROM tblPlaylists WHERE Guid = 'EFA44DA4-172F-4A1E-824B-94F2DD47985C') BEGIN
	EXEC dbo.sp_playlist_AddPlaylist 'EFA44DA4-172F-4A1E-824B-94F2DD47985C', 'Menu-Featured-Endo', 0, @now, NULL, 1, 0, 1
	SET @currentPlaylist = (SELECT TOP 1 PlaylistId FROM tblPlaylists WHERE Guid = 'EFA44DA4-172F-4A1E-824B-94F2DD47985C')
	EXEC dbo.sp_playlist_AddTopLevelMenu -1, @currentPlaylist, 0, 1
	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-Endo-DigitalX-ray', 3, '4DD55383-1FE0-48CF-BF81-0DF83B536F22', 'media\GURU\mov\xray.mov'
	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-Endo-CheckingforPulp', 2, '0C901335-9B57-4948-93B6-711805205708', 'media\Featured\png\xray.png'
	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-Endo-Intra-oralPictures', 2, '1F627EDA-7347-4C84-9D50-D947B53CC55A', 'media\Featured\png\intraoralCamera.png'
	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-Endo-HotColdTests', 2, '8925D13A-51A2-4FC7-A76B-8CFE457E1479', 'media\Featured\png\cold_hot_WaterTest.png'
	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-Endo-PercussionTests', 2, 'D0027679-928E-4010-80AA-D85FCD2973E4', 'media\Featured\png\dental_mirror_stemTap.png'
	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-Endo-ElectronicPulpTests', 2, '4885CE34-72A4-4479-A391-79051E48F65D', 'media\Featured\png\pulpVitalityTest.png'
	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-Endo-PressureTests', 1, '22ABD161-F960-4CF6-9EE0-41267720F1DB', 'media\Featured\mov\posCracked_01.mov'
	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-Endo-SmallCracks', 2, 'DFE610AE-3C1D-45AB-B7E4-9E0D47EEEEC1', 'media\Featured\png\posCracked.png'
	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-Endo-BrokenCusp', 2, 'B1631936-F665-4AD5-8809-D5BB033CF348', 'media\Featured\png\fractureV.png'
	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-Endo-Anesthetic', 2, 'D889B2C5-8B26-440C-81DB-7ABF7C57027D', 'media\Featured\png\anesthetic.png'
	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-Endo-Isolation', 2, '4C67BEC3-CAFF-478D-B891-F6E346369CF2', 'media\Featured\png\rubberDam.png'
	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-Endo-GainingAccess', 2, 'EEC5C4EE-0775-48AD-9A2D-8366F61B5DC6', 'media\Featured\png\accessCanal_Occlusal.png'
	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-Endo-LocatingCanals', 2, '52BA2F97-D9D1-4559-9131-754A3ED20AD0', 'media\Featured\png\rootCanal_AccessPulp.png'
	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-Endo-Instrumentation', 2, '2293D04C-94D1-4B68-99A5-7D7ACEC9B0C9', 'media\Featured\png\rootCanal_Cleaned.png'
	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-Endo-Irrigation', 2, '90B07383-C6FA-4F6E-8E1A-C4DF3EEFF7A5', 'media\Featured\png\rootCanal_Irrigated.png'
	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-Endo-Obturation', 2, '66137BFD-B27D-443A-B8AF-62251AB75A03', 'media\Featured\png\rootCanal_Obturation.png'
	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-Endo-Overview', 1, 'D5F52858-4F98-4B7C-AA2D-C9D810B5E67D', 'media\Featured\mov\posRootCanal_Endo_01.mov'
	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-Endo-Restoration', 3, 'F0037570-E2E2-4C04-B493-6A5BE66FC800', 'media\GURU\mov\posCrownProcess.mov'
END


IF NOT EXISTS (SELECT * FROM tblPlaylists WHERE Guid = 'BE1F4537-AA88-4ED6-BAF2-6009ACCA5A2A') BEGIN
	EXEC dbo.sp_playlist_AddPlaylist 'BE1F4537-AA88-4ED6-BAF2-6009ACCA5A2A', 'Menu-Featured-Implant', 0, @now, NULL, 1, 0, 1
	SET @currentPlaylist = (SELECT TOP 1 PlaylistId FROM tblPlaylists WHERE Guid = 'BE1F4537-AA88-4ED6-BAF2-6009ACCA5A2A')
	EXEC dbo.sp_playlist_AddTopLevelMenu -1, @currentPlaylist, 0, 1
	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-Implant-ImplantOverview', 1, 'B6B244A1-DF88-4808-95DF-EF60CC10A574', 'media\Featured\mov\implantMolar_Implant_01.mov'
	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-Implant-MinimalAccess', 2, 'C507F8A9-3766-447B-855F-16147E5C6D14', 'media\Featured\png\implantMolar_BeforeAccess.png'
	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-Implant-ImplantMolar', 1, '476370AB-17FC-4B34-9299-E429E9CC6C97', 'media\Featured\mov\implantMolar_Implant_02.mov'
	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-Implant-AdjacentTeeth', 2, 'B4791CE7-91DC-4BB8-B5AA-9F5AF0FCA16E', 'media\Featured\png\implantMolar_CrownPlaced.png'
	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-Implant-MaintainingBone', 2, '7A7AA0A5-F74A-405B-B11E-65E9BEEA3CF6', 'media\Featured\png\implant_BoneMaintain.png'
	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-Implant-BridgeVsImplant', 2, '8691B21E-0ADF-41CE-92D2-81846E13E1F1', 'media\Featured\png\bridgeVsImplantBoneLoss.png'
	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-Implant-3UnitBridge', 1, '35CD0381-DE5B-4EEF-B190-E5F3F5DE4D1F', 'media\Featured\mov\bridgeFlossing_Implant_01.mov'
	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-Implant-FlossThreader', 2, '3170F992-84DC-42CC-911E-74E4C1A4A553', 'media\Featured\png\bridgeFlossing_Threader.png'
	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-Implant-BridgeFlossing', 1, '60DD39E0-997B-498E-89F7-E1FE147D0513', 'media\Featured\mov\bridgeFlossing_Implant_02.mov'
	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-Implant-BridgeDecay', 1, 'B7647C2E-67E5-4710-841C-1BA749E2EC57', 'media\Featured\mov\bridgeDecay_Implant_01.mov'
	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-Implant-RecurrentDecay', 2, 'D6451F3B-AA81-4719-83F3-20836278598E', 'media\Featured\png\bridgeDecay.png'
	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-Implant-BridgeBoneLoss', 1, '9BA712CE-C50A-4B01-8034-29CAEBA87A2C', 'media\Featured\mov\bridgeBoneLoss_Implant_01.mov'
	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-Implant-BridgeBoneLoss', 2, 'A3095008-D94B-41A6-A58D-8A9C23C8B421', 'media\Featured\png\bridgeBoneLoss.png'
	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-Implant-ToothMovement', 3, '8173B720-D560-4CF8-98B4-442154410FC4', 'media\GURU\mov\toothMove.mov'
	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-Implant-SpaceMaintainer', 1, '811D4178-83AC-49E8-9AD7-83E55F85A016', 'media\Featured\mov\kidsSpaceRetainer_Implant_01.mov'
	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-Implant-BoneGrafting', 3, '917A0D6A-6EEB-4EC5-A1F8-38A1D4EDDAF4', 'media\GURU\mov\boneGraft.mov'
END

IF NOT EXISTS (SELECT * FROM tblPlaylists WHERE Guid = '77EFEB90-7CF4-4999-8468-C11A93A7EF54') BEGIN
	EXEC dbo.sp_playlist_AddPlaylist '77EFEB90-7CF4-4999-8468-C11A93A7EF54', 'Menu-Featured-ChildSpaceMaintainer', 0, @now, NULL, 1, 0, 1
	SET @currentPlaylist = (SELECT TOP 1 PlaylistId FROM tblPlaylists WHERE Guid = '77EFEB90-7CF4-4999-8468-C11A93A7EF54')
	EXEC dbo.sp_playlist_AddTopLevelMenu -1, @currentPlaylist, 0, 1
	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-ChildSpaceMaintainer-ChildPan', 2, 'D1C33DF1-776F-46DA-905B-FBEE426194DC', 'media\Featured\png\Child_Pan.png'
	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-ChildSpaceMaintainer-NoSpaceMaintainerand', 2, 'E6B5C1BB-3345-4DD6-B74E-0A1FB8668A0B', 'media\Featured\png\No_SpaceMaintainer_Decay.png'
	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-ChildSpaceMaintainer-TeethDevelopment', 3, '00294498-700B-4400-8C85-536B1A753544', 'media\GURU\mov\eruptionProcess_Closeup.mov'
	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-ChildSpaceMaintainer-SpaceMaintainer', 3, '66780933-8BEF-4C8B-89DB-CBC836C82CFA', 'media\GURU\mov\kidsSpaceRetainer.mov'
END

IF NOT EXISTS (SELECT * FROM tblPlaylists WHERE Guid = '734FA16E-E03D-4310-8DEC-C1544D8AC6E5') BEGIN
	EXEC dbo.sp_playlist_AddPlaylist '734FA16E-E03D-4310-8DEC-C1544D8AC6E5', 'Menu-Featured-CrackedTooth', 0, @now, NULL, 1, 0, 1
	SET @currentPlaylist = (SELECT TOP 1 PlaylistId FROM tblPlaylists WHERE Guid = '734FA16E-E03D-4310-8DEC-C1544D8AC6E5')
	EXEC dbo.sp_playlist_AddTopLevelMenu -1, @currentPlaylist, 0, 1
	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-CrackedTooth-Filling', 2, 'E2021F2B-09B7-4BEC-B1C6-16C78B90E4F1', 'media\Featured\png\filling.png'
	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-CrackedTooth-DecayX-Ray', 2, '0DF7FAF6-1EC5-4DF9-94E3-1397B632E541', 'media\Featured\png\Decay_1.png'
	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-CrackedTooth-CrackedTooth', 3, 'A8AD6F97-8A9F-4A36-A7CC-D1FA69B48B05', 'media\GURU\mov\posCracked.mov'
	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-CrackedTooth-CrownProcessPosterior', 3, 'F0037570-E2E2-4C04-B493-6A5BE66FC800', 'media\GURU\mov\posCrownProcess.mov'
	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-CrackedTooth-CrownComparison', 2, 'F9A8EF1A-95BE-41E5-801A-2ECB074D621A', 'media\Featured\png\crowncompare_WideScreen.png'
	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-CrackedTooth-RootCanalPosterior', 3, 'FC41A73A-2414-4052-A3CB-406A21B37B46', 'media\GURU\mov\posRootCanal.mov'
	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-CrackedTooth-CrownBeforeAfter', 2, '5E86563E-852E-40E7-8C3E-30BE5CF169D2', 'media\Featured\png\Crown_Before_After.png'
END

IF NOT EXISTS (SELECT * FROM tblPlaylists WHERE Guid = '11B46F39-2E3C-4AE2-BFD9-7BE8FD648DDD') BEGIN
	EXEC dbo.sp_playlist_AddPlaylist '11B46F39-2E3C-4AE2-BFD9-7BE8FD648DDD', 'Menu-Featured-Diastema', 0, @now, NULL, 1, 0, 1
	SET @currentPlaylist = (SELECT TOP 1 PlaylistId FROM tblPlaylists WHERE Guid = '11B46F39-2E3C-4AE2-BFD9-7BE8FD648DDD')
	EXEC dbo.sp_playlist_AddTopLevelMenu -1, @currentPlaylist, 0, 1
	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-Diastema-1Before', 2, 'C4DB9122-5397-44E7-9447-F22764B632DC', 'media\Featured\png\1_Before.png'
	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-Diastema-Bonding', 3, '02A075ED-2047-4B55-A13A-1E6960B7DB1D', 'media\GURU\mov\bonding.mov'
	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-Diastema-2After', 2, '5C93269D-DDB5-4EEA-B9EE-202A64B3DBC7', 'media\Featured\png\2_After.png'
END


IF NOT EXISTS (SELECT * FROM tblPlaylists WHERE Guid = '2EA34E95-B54E-4B5E-9A5D-7F4962FD94D8') BEGIN
	EXEC dbo.sp_playlist_AddPlaylist '2EA34E95-B54E-4B5E-9A5D-7F4962FD94D8', 'Menu-Featured-ImpactedWisdomTooth', 0, @now, NULL, 1, 0, 1
	SET @currentPlaylist = (SELECT TOP 1 PlaylistId FROM tblPlaylists WHERE Guid = '2EA34E95-B54E-4B5E-9A5D-7F4962FD94D8')
	EXEC dbo.sp_playlist_AddTopLevelMenu -1, @currentPlaylist, 0, 1
	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-ImpactedWisdomTooth-ImpactedToothX-Ray', 2, '9B01303B-D3F1-46DE-B6F4-0DC1E7E7F165', 'media\Featured\png\Impacted_Xray.png'
	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-ImpactedWisdomTooth-ImpactedWisdomTooth', 2, '58C07F77-59A6-4215-8249-A492675650DF', 'media\Featured\png\impaction.png'
	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-ImpactedWisdomTooth-WisdomToothCrowding', 3, 'DE973DFB-2C00-4E35-8C58-14E8CCCAA125', 'media\GURU\mov\ImpactedWisdomCrowding.mov'
	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-ImpactedWisdomTooth-WisdomToothDecay', 3, '0D0C7739-A67F-4656-ABD5-BBC0326E12C3', 'media\GURU\mov\wisdomToothDecay.mov'
	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-ImpactedWisdomTooth-WisdomToothNormal', 3, 'D1132E7E-A833-4A4F-BD00-BE202E750F71', 'media\GURU\mov\wisdomToothNormal.mov'
	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-ImpactedWisdomTooth-WisdomToothExtraction', 3, '521C2AC4-8014-42A8-A878-928025430771', 'media\GURU\mov\wisdomToothExtraction.mov'
END


IF EXISTS (SELECT * FROM tblPlaylists WHERE Guid = 'B2D925D2-9E57-439D-94F7-634473BE1A87') BEGIN
	DELETE FROM tblPlaylists WHERE Guid = 'B2D925D2-9E57-439D-94F7-634473BE1A87'
END

--IF NOT EXISTS (SELECT * FROM tblPlaylists WHERE Guid = 'B2D925D2-9E57-439D-94F7-634473BE1A87') BEGIN
--	EXEC dbo.sp_playlist_AddPlaylist 'B2D925D2-9E57-439D-94F7-634473BE1A87', 'Menu-Featured-Implant', 0, @now, NULL, 1, 0, 1
--	SET @currentPlaylist = (SELECT TOP 1 PlaylistId FROM tblPlaylists WHERE Guid = 'B2D925D2-9E57-439D-94F7-634473BE1A87')
--	EXEC dbo.sp_playlist_AddTopLevelMenu -1, @currentPlaylist, 0, 1
--	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-Implant-X-RayGap', 2, '8385A0C0-6E80-4135-B55F-046069497B6B', 'media\Featured\png\X-Ray_Gap.png'
--	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-Implant-PartialDenturevsImplant', 3, '302405EE-628A-4059-B88C-595142CA0649', 'media\GURU\mov\PartialDentureVsImplant.mov'
--	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-Implant-ImplantMolar', 3, '61CBF176-5791-4A12-9307-832D51C8CAE4', 'media\GURU\mov\implant_Molar.mov'
--	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-Implant-X-RayImplant', 2, '722F5726-9A48-42FE-9FEC-0F6EDDED1DF1', 'media\Featured\png\X-Ray_Implant.png'
--	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-Implant-Restoration', 2, 'FF198200-78A4-46A3-ACDD-E32517DD409A', 'media\Featured\png\After_Crown.png'
--END


IF NOT EXISTS (SELECT * FROM tblPlaylists WHERE Guid = '530DDF15-2145-4528-ABCF-751BA1534A99') BEGIN
	EXEC dbo.sp_playlist_AddPlaylist '530DDF15-2145-4528-ABCF-751BA1534A99', 'Menu-Featured-MissingTooth', 0, @now, NULL, 1, 0, 1
	SET @currentPlaylist = (SELECT TOP 1 PlaylistId FROM tblPlaylists WHERE Guid = '530DDF15-2145-4528-ABCF-751BA1534A99')
	EXEC dbo.sp_playlist_AddTopLevelMenu -1, @currentPlaylist, 0, 1
	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-MissingTooth-Fracture', 2, '0318DE48-A696-4583-99E6-E0D8A109D83A', 'media\Featured\png\Fracture.png'
	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-MissingTooth-SpaceRetain', 2, '52E6C0D4-F006-4894-9276-A522357F1B17', 'media\Featured\png\SpaceRetain.png'
	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-MissingTooth-SpaceRetain2', 2, '541E1226-2262-47D1-A3FB-11764CE6F901', 'media\Featured\png\SpaceRetain_3.png'
	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-MissingTooth-ToothMovement', 3, '8173B720-D560-4CF8-98B4-442154410FC4', 'media\GURU\mov\toothMove.mov'
	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-MissingTooth-Bridges', 3, '29BF87C2-073C-4BDB-913C-A4CA584781B0', 'media\GURU\mov\bridges.mov'
	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-MissingTooth-BridgeBoneLoss', 3, '4C9880BD-C5E3-47ED-B306-C9F1038E59DD', 'media\GURU\mov\bridgeBoneLoss.mov'
	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-MissingTooth-BridgeFlossing', 3, 'E703CA8A-11A8-4577-BE4C-31B250EB7F8A', 'media\GURU\mov\bridgeFlossing.mov'
	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-MissingTooth-BridgeDecay', 3, '75C861A4-F701-4604-949E-3282FC499488', 'media\GURU\mov\bridgeDecay.mov'
	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-MissingTooth-DistalFreeEndPartial', 3, '036F506E-B534-479A-B94E-6396357119AD', 'media\GURU\mov\molarPartial.mov'
	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-MissingTooth-ImplantMolar', 3, '61CBF176-5791-4A12-9307-832D51C8CAE4', 'media\GURU\mov\implantMolar.mov'
	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-MissingTooth-ImplantRoot', 2, '7A7AA0A5-F74A-405B-B11E-65E9BEEA3CF6', 'media\Featured\png\implant_BoneMaintain.png'
	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-MissingTooth-Abutment', 2, '139DAC0B-E6C8-4DAD-9369-826E5746BD85', 'media\Featured\png\Abutment.png'
	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-MissingTooth-AfterCrown', 2, 'FF198200-78A4-46A3-ACDD-E32517DD409A', 'media\Featured\png\After_Crown.png'
END


IF NOT EXISTS (SELECT * FROM tblPlaylists WHERE Guid = 'CD1AAA4C-0FC4-47A2-9F73-89CA842815DE') BEGIN
	EXEC dbo.sp_playlist_AddPlaylist 'CD1AAA4C-0FC4-47A2-9F73-89CA842815DE', 'Menu-Featured-Perio', 0, @now, NULL, 1, 0, 1
	SET @currentPlaylist = (SELECT TOP 1 PlaylistId FROM tblPlaylists WHERE Guid = 'CD1AAA4C-0FC4-47A2-9F73-89CA842815DE')
	EXEC dbo.sp_playlist_AddTopLevelMenu -1, @currentPlaylist, 0, 1
	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-Perio-1Before', 2, '4D90092A-7DDC-4B90-9AB8-A42F2312ABAE', 'media\Featured\png\Perio_1_Before.png'
	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-Perio-2Before', 2, '60071019-7BF3-4531-9A63-9B3E2ACFB3A0', 'media\Featured\png\Perio_2_Before.png'
	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-Perio-3Before', 2, '363BCF80-3081-4A0F-80F1-0F90B3D3CA38', 'media\Featured\png\Perio_3_Before.png'
	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-Perio-PeriodontitisStages', 3, '917469D5-F2D0-41A7-BEBD-E603395D8722', 'media\GURU\mov\periodontitis.mov'
	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-Perio-GingivalRecession', 3, 'D608A2F7-DD0D-4246-92E9-C58AA650A63B', 'media\GURU\mov\gumRecession.mov'
	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-Perio-PerioPocket', 3, '8DF7F743-26E1-44DA-A02D-2B0328DCFA90', 'media\GURU\mov\perioPocket.mov'
	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-Perio-RootPlaning', 3, '2BFA7F61-27A2-4A51-8797-F078C33AE096', 'media\GURU\mov\rootPlaning.mov'
	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-Perio-PerioAntibiotic', 3, '2192095D-59E7-40FA-92F2-9999CEF81927', 'media\GURU\mov\perioAntiBiotech.mov'
	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-Perio-1Before', 2, '4D90092A-7DDC-4B90-9AB8-A42F2312ABAE', 'media\Featured\png\Perio_1_Before.png'
	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-Perio-4After', 2, '3ADC7CA4-97A6-44A6-9F63-E55EF641BE74', 'media\Featured\png\Perio_4_After.png'
	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-Perio-2Before', 2, '60071019-7BF3-4531-9A63-9B3E2ACFB3A0', 'media\Featured\png\Perio_2_Before.png'
	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-Perio-5After', 2, 'E22CD88C-6473-4E03-8F69-2CD474F9FB72', 'media\Featured\png\Perio_5_After.png'
	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-Perio-3Before', 2, '363BCF80-3081-4A0F-80F1-0F90B3D3CA38', 'media\Featured\png\Perio_3_Before.png'
	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-Perio-6After', 2, '902C417B-F86A-4E22-B35F-48A30BC45276', 'media\Featured\png\Perio_6_After.png'
END

--IF NOT EXISTS (SELECT * FROM tblPlaylists WHERE Guid = '5F60BFF6-96D1-45BA-B2D0-C80370E4436A') BEGIN
--	EXEC dbo.sp_playlist_AddPlaylist '5F60BFF6-96D1-45BA-B2D0-C80370E4436A', 'Menu-Featured-TMJ', 0, @now, NULL, 1, 0, 1
--	SET @currentPlaylist = (SELECT TOP 1 PlaylistId FROM tblPlaylists WHERE Guid = '5F60BFF6-96D1-45BA-B2D0-C80370E4436A')
--	EXEC dbo.sp_playlist_AddTopLevelMenu -1, @currentPlaylist, 0, 1
--	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-TMJ-TMJX-Ray', 2, '6DFED2FB-7994-485A-9F78-269E97C5F759', 'media\Featured\png\TMJ_Xray.png'
--	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-TMJ-HealthyBite', 1, 'CCBBDE14-B423-43E6-9FB9-F559FDBE1A5E', 'media\Featured\mov\tmj_healthyBite.mov'
--	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-TMJ-HealthyMolarContact', 1, 'BDDD5E82-532F-4E44-BC5F-7EE1DCEC0164', 'media\Featured\mov\tmj_healthyBite_MolarContact.mov'
--	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-TMJ-TMDTMJ', 3, '6AA2CCE7-C3CD-49BA-AD43-A9882B144C28', 'media\GURU\mov\tmd.mov'
--	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-TMJ-UnhealthyBite', 1, '86B8349C-DAD3-4212-8EFB-9645969E490B', 'media\Featured\mov\tmj_UnhealthyBite.mov'
--	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-TMJ-UnhealthyBiteLateral', 1, 'AAF46D48-0291-4E03-B255-32E37AD5D425', 'media\Featured\mov\tmj_UnhealthyBite_MolarContact_lateral.mov'
--	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-TMJ-UnhealthyBiteMolarContact', 1, '9E685C39-7A7F-4B55-8CEB-972E4627404F', 'media\Featured\mov\tmj_UnhealthyBite_MolarContact.mov'
--	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-TMJ-UnhealthyBiteMuscles', 1, 'DC8ED41C-C02E-4B23-8E85-BD89802FAF02', 'media\Featured\mov\tmj_UnhealthyBite_Muscles.mov'
--	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-TMJ-LigamentTear', 1, 'EE021206-18A7-4B04-BA95-7DA65F053EC7', 'media\Featured\mov\tmj_ligamentTear.mov'
--	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-TMJ-CrackedMolar', 1, 'D8F48E14-DCFC-4660-8E2C-FFD4E388448C', 'media\Featured\mov\tmj_UnhealthyBite_MolarContact_cracked.mov'
--	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-TMJ-GrindingMolar', 1, '3BE12758-00E5-4F28-A245-51CE0B67A3FC', 'media\Featured\mov\tmj_UnhealthyBite_MolarContact_grinding.mov'
--	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-TMJ-LooseMolar', 1, '6C9EBB4B-EEEE-4BFB-9EF3-FB9006408DB7', 'media\Featured\mov\tmj_UnhealthyBite_MolarContact_loose.mov'
--	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-TMJ-TMJRestorability', 2, '3FD3AC38-7990-457C-B4F0-649D7CEAE208', 'media\Featured\png\TMJ_Restorability.png'
--	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-TMJ-TMJNormal', 2, 'AD6E7C4D-13FC-40D3-A752-84B12D7F5437', 'media\Featured\png\Structurally_Intact_TMJ.png'
--	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-TMJ-TMJLateralPole', 2, 'AEC84BBC-B2EC-49E0-99A7-E1F8D954318D', 'media\Featured\png\Lateral_Pole_Displacement.png'
--	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-TMJ-TMJMedialPole', 2, '22F2BB9C-5941-4180-8674-14664A3E4727', 'media\Featured\png\Medial_Pole_Displacement.png'
--	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-TMJ-BSplint', 1, '246787ED-9CBE-4E9F-975E-0784D0EC3E0B', 'media\Featured\mov\tmj_bSplint.mov'
--	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-TMJ-LowerSplint', 1, '42DFFD65-E5F7-4163-90B0-9BE4C91C9B18', 'media\Featured\mov\tmj_lowerSplint.mov'
--	EXEC dbo.AddCompleteMedia @currentPlaylist, @currentMenu, 'Featured-TMJ-UpperSplint', 1, '7D62ED6A-19E3-4F43-A419-EB5A5DB4DE4F', 'media\Featured\mov\tmj_upperSplint.mov'
--END
GO