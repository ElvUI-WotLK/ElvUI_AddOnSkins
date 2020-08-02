local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

if not AS:IsAddonLODorEnabled("BlackList") then return end

-- Black List 3.3.01
-- https://www.curseforge.com/wow/addons/black-list-siv0968/files/439842

S:AddCallbackForAddon("BlackList", "BlackList", function()
	if not E.private.addOnSkins.BlackList then return end

	FriendsTabHeaderTab4:StripTextures()
	FriendsTabHeaderTab4:Size(63, 26)
	FriendsTabHeaderTab4:Point("TOPLEFT", FriendsTabHeaderTab3, "TOPLEFT", 3, -7)
	S:HandleButton(FriendsTabHeaderTab4)

	S:HandleButton(FriendsFrameBlacklistPlayerButton)
	S:HandleButton(FriendsFrameRemovePlayerButton)
	S:HandleButton(FriendsFrameOptionsButton)
	S:HandleButton(FriendsFrameShareListButton)

	FriendsFrameBlacklistPlayerButton:Height(22)
	FriendsFrameRemovePlayerButton:Height(22)
	FriendsFrameOptionsButton:Height(22)
	FriendsFrameShareListButton:Height(22)

	FriendsFrameBlacklistPlayerButton:Point("BOTTOMLEFT", FriendsFrame, "BOTTOMLEFT", 19, 109)
	FriendsFrameRemovePlayerButton:Point("TOP", FriendsFrameBlacklistPlayerButton, "BOTTOM", 0, -3)
	FriendsFrameOptionsButton:Point("LEFT", FriendsFrameBlacklistPlayerButton, "RIGHT", 63, 0)
	FriendsFrameShareListButton:Point("TOP", FriendsFrameOptionsButton, "BOTTOM", 0, -3)

	FriendsFrameBlackListButton1:Width(302)
	FriendsFrameBlackListButton1:Point("TOPLEFT", FriendsFrame, "TOPLEFT", 20, -97)

	FriendsFrameBlackListScrollFrame:Size(304, 282)
	FriendsFrameBlackListScrollFrame:Point("TOPRIGHT", FriendsFrame, "TOPRIGHT", -61, -92)

	FriendsFrameBlackListScrollFrame:StripTextures()
	S:HandleScrollBar(FriendsFrameBlackListScrollFrameScrollBar)
	FriendsFrameBlackListScrollFrameScrollBar:Point("TOPLEFT", FriendsFrameBlackListScrollFrame, "TOPRIGHT", 3, -19)
	FriendsFrameBlackListScrollFrameScrollBar:Point("BOTTOMLEFT", FriendsFrameBlackListScrollFrame, "BOTTOMRIGHT", 3, 19)

	-- Details
	BlackListDetailsFrame:StripTextures()
	BlackListDetailsFrame:SetTemplate("Transparent")
	BlackListDetailsFrame:Point("TOPLEFT", FriendsFrame, "TOPRIGHT", -33, -97)

	S:HandleCloseButton(BlackListDetailsCloseButton, BlackListDetailsFrame)

	S:HandleButton(BlackListDetailsEditButton)
	S:HandleCheckBox(BlackListDetailsFrameCheckButton1)
	S:HandleCheckBox(BlackListDetailsFrameCheckButton2)

	BlackListDetailsFrameReasonTextBackground:SetTemplate()
	S:HandleScrollBar(BlackListDetailsFrameScrollFrameScrollBar)

	BlackListDetailsFrameScrollFrameScrollBar:Point("BOTTOMLEFT", BlackListDetailsFrameScrollFrame, "BOTTOMRIGHT", 6, 18)

	-- Details Edit
	BlackListEditDetailsFrame:StripTextures()
	BlackListEditDetailsFrame:SetTemplate("Transparent")
	BlackListEditDetailsFrame:Point("TOPLEFT", BlackListDetailsFrame, "BOTTOMLEFT", 0, 1)

	BlackListEditDetailsFrameLevelBackground:StripTextures()
	BlackListEditDetailsFrameLevelBackground:CreateBackdrop()
	BlackListEditDetailsFrameLevelBackground:Size(39, 28)
	BlackListEditDetailsFrameLevelBackground:Point("TOPLEFT", 7, -18)
	BlackListEditDetailsFrameLevelBackground.backdrop:Point("TOPLEFT", 5, -3)
	BlackListEditDetailsFrameLevelBackground.backdrop:Point("BOTTOMRIGHT", -5, 5)

	S:HandleDropDownBox(BlackListEditDetailsFrameClassDropDown, 143)
	S:HandleDropDownBox(BlackListEditDetailsFrameRaceDropDown, 143)

	BlackListEditDetailsFrameClassDropDown:Point("TOPLEFT", BlackListEditDetailsFrameLevelBackground, "TOPRIGHT", -18, 0)
	BlackListEditDetailsFrameClassDropDown.SetWidth = E.noop
	BlackListEditDetailsFrameClassDropDownButton.SetWidth = E.noop

	BlackListEditDetailsFrameRaceDropDown:Point("TOPLEFT", BlackListEditDetailsFrameClassDropDown, "TOPRIGHT", -21, 0)
	BlackListEditDetailsFrameRaceDropDown.SetWidth = E.noop
	BlackListEditDetailsFrameRaceDropDownButton.SetWidth = E.noop

	S:HandleButton(BlackListEditDetailsFrameSaveButton)
	S:HandleButton(BlackListEditDetailsFrameCancelButton)

	BlackListEditDetailsFrameSaveButton:Point("TOPLEFT", 8, -61)
	BlackListEditDetailsFrameCancelButton:Point("LEFT", BlackListEditDetailsFrameSaveButton, "RIGHT", 19, 0)

	-- Options
	BlackListOptionsFrame:StripTextures()
	BlackListOptionsFrame:SetTemplate("Transparent")

	S:HandleCheckBox(SoundCheckButton)
	S:HandleCheckBox(CenterCheckButton)
	S:HandleCheckBox(ChatCheckButton)
	S:HandleCheckBox(IgnoreCheckButton)
	S:HandleCheckBox(BanCheckButton)
	S:HandleCheckBox(KickCheckButton)

	BL_RankBox:Size(20)
	BL_RankBox:Point("TOPLEFT", 65, -273)
	S:HandleEditBox(BL_RankBox)

	S:HandleButton(BlackListOptionsFrameClose)
end)