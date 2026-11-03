local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
-- Optional controls differ between supported addon versions. Keep missing
-- targets out of native skin handlers without masking other Lua errors.
local function SkinControl(method, frame, ...)
	if frame then return S[method](S, frame, ...) end
end
local function SkinFrame(frame, method, ...)
	if frame then return frame[method](frame, ...) end
end

local AS = E:GetModule("AddOnSkins")

if not AS:IsAddonLODorEnabled("BlackList") then return end

-- Black List 3.3.01
-- https://www.curseforge.com/wow/addons/black-list-siv0968/files/439842

S:AddCallbackForAddon("BlackList", "BlackList", function()
	if not E.private.addOnSkins.BlackList then return end

	SkinFrame(FriendsTabHeaderTab4, "StripTextures")
	SkinFrame(FriendsTabHeaderTab4, "Size", 63, 26)
	SkinFrame(FriendsTabHeaderTab4, "Point", "TOPLEFT", FriendsTabHeaderTab3, "TOPLEFT", 3, -7)
	SkinControl("HandleButton", FriendsTabHeaderTab4)

	SkinControl("HandleButton", FriendsFrameBlacklistPlayerButton)
	SkinControl("HandleButton", FriendsFrameRemovePlayerButton)
	SkinControl("HandleButton", FriendsFrameOptionsButton)
	SkinControl("HandleButton", FriendsFrameShareListButton)

	SkinFrame(FriendsFrameBlacklistPlayerButton, "Height", 22)
	SkinFrame(FriendsFrameRemovePlayerButton, "Height", 22)
	SkinFrame(FriendsFrameOptionsButton, "Height", 22)
	SkinFrame(FriendsFrameShareListButton, "Height", 22)

	SkinFrame(FriendsFrameBlacklistPlayerButton, "Point", "BOTTOMLEFT", FriendsFrame, "BOTTOMLEFT", 19, 109)
	SkinFrame(FriendsFrameRemovePlayerButton, "Point", "TOP", FriendsFrameBlacklistPlayerButton, "BOTTOM", 0, -3)
	SkinFrame(FriendsFrameOptionsButton, "Point", "LEFT", FriendsFrameBlacklistPlayerButton, "RIGHT", 63, 0)
	SkinFrame(FriendsFrameShareListButton, "Point", "TOP", FriendsFrameOptionsButton, "BOTTOM", 0, -3)

	SkinFrame(FriendsFrameBlackListButton1, "Width", 302)
	SkinFrame(FriendsFrameBlackListButton1, "Point", "TOPLEFT", FriendsFrame, "TOPLEFT", 20, -97)

	SkinFrame(FriendsFrameBlackListScrollFrame, "Size", 304, 282)
	SkinFrame(FriendsFrameBlackListScrollFrame, "Point", "TOPRIGHT", FriendsFrame, "TOPRIGHT", -61, -92)

	SkinFrame(FriendsFrameBlackListScrollFrame, "StripTextures")
	SkinControl("HandleScrollBar", FriendsFrameBlackListScrollFrameScrollBar)
	SkinFrame(FriendsFrameBlackListScrollFrameScrollBar, "Point", "TOPLEFT", FriendsFrameBlackListScrollFrame, "TOPRIGHT", 3, -19)
	SkinFrame(FriendsFrameBlackListScrollFrameScrollBar, "Point", "BOTTOMLEFT", FriendsFrameBlackListScrollFrame, "BOTTOMRIGHT", 3, 19)

	-- Details
	SkinFrame(BlackListDetailsFrame, "StripTextures")
	SkinFrame(BlackListDetailsFrame, "SetTemplate", "Transparent")
	SkinFrame(BlackListDetailsFrame, "Point", "TOPLEFT", FriendsFrame, "TOPRIGHT", -33, -97)

	SkinControl("HandleCloseButton", BlackListDetailsCloseButton, BlackListDetailsFrame)

	SkinControl("HandleButton", BlackListDetailsEditButton)
	SkinControl("HandleCheckBox", BlackListDetailsFrameCheckButton1)
	SkinControl("HandleCheckBox", BlackListDetailsFrameCheckButton2)

	SkinFrame(BlackListDetailsFrameReasonTextBackground, "SetTemplate")
	SkinControl("HandleScrollBar", BlackListDetailsFrameScrollFrameScrollBar)

	SkinFrame(BlackListDetailsFrameScrollFrameScrollBar, "Point", "BOTTOMLEFT", BlackListDetailsFrameScrollFrame, "BOTTOMRIGHT", 6, 18)

	-- Details Edit
	SkinFrame(BlackListEditDetailsFrame, "StripTextures")
	SkinFrame(BlackListEditDetailsFrame, "SetTemplate", "Transparent")
	SkinFrame(BlackListEditDetailsFrame, "Point", "TOPLEFT", BlackListDetailsFrame, "BOTTOMLEFT", 0, 1)

	SkinFrame(BlackListEditDetailsFrameLevelBackground, "StripTextures")
	BlackListEditDetailsFrameLevelBackground:CreateBackdrop()
	SkinFrame(BlackListEditDetailsFrameLevelBackground, "Size", 39, 28)
	SkinFrame(BlackListEditDetailsFrameLevelBackground, "Point", "TOPLEFT", 7, -18)
	BlackListEditDetailsFrameLevelBackground.backdrop:Point("TOPLEFT", 5, -3)
	BlackListEditDetailsFrameLevelBackground.backdrop:Point("BOTTOMRIGHT", -5, 5)

	SkinControl("HandleDropDownBox", BlackListEditDetailsFrameClassDropDown, 143)
	SkinControl("HandleDropDownBox", BlackListEditDetailsFrameRaceDropDown, 143)

	SkinFrame(BlackListEditDetailsFrameClassDropDown, "Point", "TOPLEFT", BlackListEditDetailsFrameLevelBackground, "TOPRIGHT", -18, 0)
	BlackListEditDetailsFrameClassDropDown.SetWidth = E.noop
	BlackListEditDetailsFrameClassDropDownButton.SetWidth = E.noop

	SkinFrame(BlackListEditDetailsFrameRaceDropDown, "Point", "TOPLEFT", BlackListEditDetailsFrameClassDropDown, "TOPRIGHT", -21, 0)
	BlackListEditDetailsFrameRaceDropDown.SetWidth = E.noop
	BlackListEditDetailsFrameRaceDropDownButton.SetWidth = E.noop

	SkinControl("HandleButton", BlackListEditDetailsFrameSaveButton)
	SkinControl("HandleButton", BlackListEditDetailsFrameCancelButton)

	SkinFrame(BlackListEditDetailsFrameSaveButton, "Point", "TOPLEFT", 8, -61)
	SkinFrame(BlackListEditDetailsFrameCancelButton, "Point", "LEFT", BlackListEditDetailsFrameSaveButton, "RIGHT", 19, 0)

	-- Options
	SkinFrame(BlackListOptionsFrame, "StripTextures")
	SkinFrame(BlackListOptionsFrame, "SetTemplate", "Transparent")

	SkinControl("HandleCheckBox", SoundCheckButton)
	SkinControl("HandleCheckBox", CenterCheckButton)
	SkinControl("HandleCheckBox", ChatCheckButton)
	SkinControl("HandleCheckBox", IgnoreCheckButton)
	SkinControl("HandleCheckBox", BanCheckButton)
	SkinControl("HandleCheckBox", KickCheckButton)

	SkinFrame(BL_RankBox, "Size", 20)
	SkinFrame(BL_RankBox, "Point", "TOPLEFT", 65, -273)
	SkinControl("HandleEditBox", BL_RankBox)

	SkinControl("HandleButton", BlackListOptionsFrameClose)
end)
