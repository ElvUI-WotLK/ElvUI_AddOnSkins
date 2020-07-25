local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

if not AS:IsAddonLODorEnabled("OpenGF") then return end

-- Open Group Finder

S:AddCallbackForAddon("OpenGF", "OpenGF", function()
	if not E.private.addOnSkins.OpenGF then return end

	ogf_OpenGF_MainFrame:StripTextures()
	ogf_playerList:StripTextures()
	ogf_plyContextMenu:StripTextures()

	ogf_OpenGF_MainFrame:SetTemplate("Transparent")
	ogf_playerList:SetTemplate("Transparent")
	ogf_plyContextMenu:SetTemplate("Transparent")

	S:HandleDropDownBox(ogf_categorySelect)
	S:HandleDropDownBox(ogf_vanInstances)
	S:HandleDropDownBox(ogf_tbcInstances)
	S:HandleDropDownBox(ogf_tbcHeroic)
	S:HandleDropDownBox(ogf_wotlkInstances)
	S:HandleDropDownBox(ogf_wotlkHeroic)

	ogf_categorySelect:Width(200)
	ogf_vanInstances:Width(200)
	ogf_tbcInstances:Width(200)
	ogf_tbcHeroic:Width(200)
	ogf_wotlkInstances:Width(200)
	ogf_wotlkHeroic:Width(200)

	ogf_searchButton:Point("LEFT", ogf_vanInstances, "RIGHT")

	S:HandleScrollBar(scrollFrameScrollBar)

	S:HandleButton(ogf_searchButton)
	S:HandleButton(ogf_enlistButton)

	S:HandleCloseButton(ogf_minimizeButton)

	S:HandleEditBox(ogf_noteText)

	local OpenGFConfigCheck = {
		"ogf_dpsCheck",
		"ogf_tankCheck",
		"ogf_healCheck",
	}

	for i = 1, #OpenGFConfigCheck do
		S:HandleCheckBox(_G[OpenGFConfigCheck[i]])
	end
end)