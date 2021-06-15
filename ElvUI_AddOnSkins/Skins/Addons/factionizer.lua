local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

if not AS:IsAddonLODorEnabled("Factionizer") then return end

-- Factionizer 30300.4
-- https://www.curseforge.com/wow/addons/factionizer/files/419110

S:AddCallbackForAddon("Factionizer", "Factionizer", function()
	if not E.private.addOnSkins.Factionizer then return end

	FIZ_OptionsFrame:StripTextures()
	FIZ_OptionsFrame:SetTemplate("Transparent")

	FIZ_OptionsFrame:ClearAllPoints()
	FIZ_OptionsFrame:Point("TOPLEFT", CharacterFrame.backdrop, "TOPRIGHT", -1, 0)

	S:HandleCloseButton(FIZ_OptionsFrameClose, FIZ_OptionsFrame)

	FIZ_ReputationDetailFrame:StripTextures()
	FIZ_ReputationDetailFrame:SetTemplate("Transparent")

	FIZ_ReputationDetailFrame:ClearAllPoints()
	FIZ_ReputationDetailFrame:Point("TOPLEFT", CharacterFrame.backdrop, "TOPRIGHT", -1, 0)

	S:HandleCloseButton(FIZ_ReputationDetailCloseButton, FIZ_ReputationDetailFrame)

	S:HandleSliderFrame(FIZ_ChatFrameSlider)

	FIZ_UpdateListScrollFrame:SetTemplate("Transparent")
	S:HandleScrollBar(FIZ_UpdateListScrollFrameScrollBar)

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
		S:HandleButton(button)
	end
	for _, checkbox in ipairs(checkboxes) do
		S:HandleCheckBox(checkbox)
	end

	FIZ_OptionsButton:Point("TOPRIGHT", -40, -35)

	FIZ_UpdateListScrollFrame:Point("TOPLEFT", FIZ_ReputationDetailDivider2, "BOTTOMLEFT", 5, 18)
	FIZ_UpdateListScrollFrame:Size(363, 211)

	FIZ_UpdateListScrollFrameScrollBar:Point("TOPLEFT", FIZ_UpdateListScrollFrame, "TOPRIGHT", 3, -19)
	FIZ_UpdateListScrollFrameScrollBar:Point("BOTTOMLEFT", FIZ_UpdateListScrollFrame, "BOTTOMRIGHT", 3, 19)

	FIZ_UpdateEntry1:Point("TOPLEFT", FIZ_UpdateListScrollFrame, "TOPLEFT", 0, -1)

	FIZ_ShowAllButton:Point("TOPLEFT", FIZ_ReputationDetailDivider3, "BOTTOMLEFT", 230, 25)
	FIZ_ShowNoneButton:Point("TOPLEFT", FIZ_ReputationDetailDivider3, "BOTTOMLEFT", 230, 0)

	FIZ_SupressNoneGlobalButton:Point("TOPLEFT", FIZ_SupressNoneFactionButton, "BOTTOMLEFT", 0, -5)
end)