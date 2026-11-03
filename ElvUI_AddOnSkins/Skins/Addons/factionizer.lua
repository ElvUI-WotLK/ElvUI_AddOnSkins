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

if not AS:IsAddonLODorEnabled("Factionizer") then return end

-- Factionizer 30300.4
-- https://www.curseforge.com/wow/addons/factionizer/files/419110

S:AddCallbackForAddon("Factionizer", "Factionizer", function()
	if not E.private.addOnSkins.Factionizer then return end

	SkinFrame(FIZ_OptionsFrame, "StripTextures")
	SkinFrame(FIZ_OptionsFrame, "SetTemplate", "Transparent")

	SkinFrame(FIZ_OptionsFrame, "ClearAllPoints")
	SkinFrame(FIZ_OptionsFrame, "Point", "TOPLEFT", CharacterFrame.backdrop, "TOPRIGHT", -1, 0)

	SkinControl("HandleCloseButton", FIZ_OptionsFrameClose, FIZ_OptionsFrame)

	SkinFrame(FIZ_ReputationDetailFrame, "StripTextures")
	SkinFrame(FIZ_ReputationDetailFrame, "SetTemplate", "Transparent")

	SkinFrame(FIZ_ReputationDetailFrame, "ClearAllPoints")
	SkinFrame(FIZ_ReputationDetailFrame, "Point", "TOPLEFT", CharacterFrame.backdrop, "TOPRIGHT", -1, 0)

	SkinControl("HandleCloseButton", FIZ_ReputationDetailCloseButton, FIZ_ReputationDetailFrame)

	SkinControl("HandleSliderFrame", FIZ_ChatFrameSlider)

	SkinFrame(FIZ_UpdateListScrollFrame, "SetTemplate", "Transparent")
	SkinControl("HandleScrollBar", FIZ_UpdateListScrollFrameScrollBar)

	local buttons = {
		FIZ_OptionsButton,
		FIZ_ShowAllButton,
		FIZ_ExpandButton,
		FIZ_ShowNoneButton,
		FIZ_CollapseButton,
		FIZ_SupressNoneFactionButton,
		FIZ_SupressNoneGlobalButton,
	}

	local checkboxes = {
		FIZ_OrderByStandingCheckBox,
		FIZ_EnableMissingBox,
		FIZ_ExtendDetailsBox,
		FIZ_GainToChatBox,
		FIZ_SupressOriginalGainBox,
		FIZ_ShowPreviewRepBox,
		FIZ_ReputationDetailAtWarCheckBox,
		FIZ_ReputationDetailInactiveCheckBox,
		FIZ_ReputationDetailMainScreenCheckBox,
		FIZ_ShowQuestButton,
		FIZ_ShowInstancesButton,
		FIZ_ShowMobsButton,
		FIZ_ShowItemsButton,
	}

	for _, button in ipairs(buttons) do
		SkinControl("HandleButton", button)
	end
	for _, checkbox in ipairs(checkboxes) do
		SkinControl("HandleCheckBox", checkbox)
	end

	SkinFrame(FIZ_OptionsButton, "Point", "TOPRIGHT", -40, -35)

	SkinFrame(FIZ_UpdateListScrollFrame, "Point", "TOPLEFT", FIZ_ReputationDetailDivider2, "BOTTOMLEFT", 5, 18)
	SkinFrame(FIZ_UpdateListScrollFrame, "Size", 363, 211)

	SkinFrame(FIZ_UpdateListScrollFrameScrollBar, "Point", "TOPLEFT", FIZ_UpdateListScrollFrame, "TOPRIGHT", 3, -19)
	SkinFrame(FIZ_UpdateListScrollFrameScrollBar, "Point", "BOTTOMLEFT", FIZ_UpdateListScrollFrame, "BOTTOMRIGHT", 3, 19)

	SkinFrame(FIZ_UpdateEntry1, "Point", "TOPLEFT", FIZ_UpdateListScrollFrame, "TOPLEFT", 0, -1)

	SkinFrame(FIZ_ShowAllButton, "Point", "TOPLEFT", FIZ_ReputationDetailDivider3, "BOTTOMLEFT", 230, 25)
	SkinFrame(FIZ_ShowNoneButton, "Point", "TOPLEFT", FIZ_ReputationDetailDivider3, "BOTTOMLEFT", 230, 0)

	SkinFrame(FIZ_SupressNoneGlobalButton, "Point", "TOPLEFT", FIZ_SupressNoneFactionButton, "BOTTOMLEFT", 0, -5)
end)
