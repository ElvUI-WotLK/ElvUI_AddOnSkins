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

	S:HandleCloseButton(FIZ_OptionsFrameClose)

	FIZ_ReputationDetailFrame:StripTextures()
	FIZ_ReputationDetailFrame:SetTemplate("Transparent")

	FIZ_ReputationDetailFrame:ClearAllPoints()
	FIZ_ReputationDetailFrame:Point("TOPLEFT", CharacterFrame.backdrop, "TOPRIGHT", -1, 0)

	S:HandleCloseButton(FIZ_ReputationDetailCloseButton)

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
end)