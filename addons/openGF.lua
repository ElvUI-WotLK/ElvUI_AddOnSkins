local E, L, V, P, G, _ = unpack(ElvUI);
local addon = E:GetModule("AddOnSkins");
local S = E:GetModule("Skins");

if(not addon:CheckAddOn("OpenGF")) then return; end

function addon:OpenGF()
	ogf_OpenGF_MainFrame:StripTextures();
	ogf_playerList:StripTextures();
	ogf_plyContextMenu:StripTextures();

	ogf_OpenGF_MainFrame:SetTemplate("Transparent");
	ogf_playerList:SetTemplate("Transparent");
	ogf_plyContextMenu:SetTemplate("Transparent");

	S:HandleDropDownBox(ogf_categorySelect);
	S:HandleDropDownBox(ogf_vanInstances);
	S:HandleDropDownBox(ogf_tbcInstances);
	S:HandleDropDownBox(ogf_tbcHeroic);
	S:HandleDropDownBox(ogf_wotlkInstances);
	S:HandleDropDownBox(ogf_wotlkHeroic);

	ogf_categorySelect:SetWidth(200);
	ogf_vanInstances:SetWidth(200);
	ogf_tbcInstances:SetWidth(200);
	ogf_tbcHeroic:SetWidth(200);
	ogf_wotlkInstances:SetWidth(200);
	ogf_wotlkHeroic:SetWidth(200);

	ogf_searchButton:Point("LEFT", ogf_vanInstances, "RIGHT")

	S:HandleScrollBar(scrollFrameScrollBar);

	S:HandleButton(ogf_searchButton);
	S:HandleButton(ogf_enlistButton);

	S:HandleCloseButton(ogf_minimizeButton);

	S:HandleEditBox(ogf_noteText);

	local OpenGFConfigCheck = {
		"ogf_dpsCheck",
		"ogf_tankCheck",
		"ogf_healCheck",
	};

	for i = 1, getn(OpenGFConfigCheck) do
		S:HandleCheckBox(_G[OpenGFConfigCheck[i]]);
	end
end

addon:RegisterSkin("OpenGF", addon.OpenGF);