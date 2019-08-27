local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")

-- Factionizer 30300.4
-- https://www.curseforge.com/wow/addons/factionizer/files/419110

local function LoadSkin()
	if not E.private.addOnSkins.Factionizer then return end

	FIZ_OptionsFrame:StripTextures()
	FIZ_OptionsFrame:SetTemplate("Transparent")

	FIZ_OptionsFrame:ClearAllPoints()
	FIZ_OptionsFrame:Point("TOPLEFT", CharacterFrame.backdrop, "TOPRIGHT", -1, 0)

	S:HandleCloseButton(FIZ_OptionsFrameClose)
	S:HandleButton(FIZ_OptionsButton)

	S:HandleCheckBox(FIZ_OrderByStandingCheckBox)
	S:HandleCheckBox(FIZ_EnableMissingBox)
	S:HandleCheckBox(FIZ_ExtendDetailsBox)
	S:HandleCheckBox(FIZ_GainToChatBox)
	S:HandleCheckBox(FIZ_SupressOriginalGainBox)
	S:HandleCheckBox(FIZ_ShowPreviewRepBox)

	S:HandleSliderFrame(FIZ_ChatFrameSlider)
end

S:AddCallbackForAddon("Factionizer", "Factionizer", LoadSkin)