local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

if not AS:IsAddonLODorEnabled("OpenGF") then return end

-- Open Group Finder

S:AddCallbackForAddon("OpenGF", "OpenGF", function()
	if not E.private.addOnSkins.OpenGF then return end

	ogf_OpenGF_MainFrame:SetTemplate("Transparent")

	S:HandleCloseButton(ogf_minimizeButton, ogf_OpenGF_MainFrame)

	S:HandleCheckBox(ogf_dpsCheck)
	S:HandleCheckBox(ogf_tankCheck)
	S:HandleCheckBox(ogf_healCheck)

	S:HandleEditBox(ogf_noteText)
	ogf_noteText:Height(22)

	S:HandleDropDownBox(ogf_categorySelect, 200)
	S:HandleDropDownBox(ogf_vanInstances, 200)
	S:HandleDropDownBox(ogf_tbcInstances, 200)
	S:HandleDropDownBox(ogf_tbcHeroic, 200)
	S:HandleDropDownBox(ogf_wotlkInstances, 200)
	S:HandleDropDownBox(ogf_wotlkHeroic, 200)

	ogf_categorySelect:Point("TOPLEFT", 0, -100)
	ogf_vanInstances:Point("TOPLEFT", 175, -100)
	ogf_tbcInstances:Point("TOPLEFT", 175, -100)
	ogf_tbcHeroic:Point("TOPLEFT", 175, -100)
	ogf_wotlkInstances:Point("TOPLEFT", 175, -100)
	ogf_wotlkHeroic:Point("TOPLEFT", 175, -100)

	S:HandleButton(ogf_searchButton)
	S:HandleButton(ogf_enlistButton)
	S:HandleButton(ogf_unlistButton)
	S:HandleButton(ogf_unlistAllButton)

	ogf_searchButton:Point("TOPRIGHT", -192, -101)
	ogf_enlistButton:Point("TOPRIGHT", -103, -101)
	ogf_unlistButton:Point("TOPRIGHT", -103, -101)
	ogf_unlistAllButton:Point("TOPRIGHT", -14, -101)

	ogf_playerList:SetTemplate("Transparent")
	ogf_plyContextMenu:SetTemplate("Transparent")

	S:HandleScrollBar(scrollFrameScrollBar)
end)