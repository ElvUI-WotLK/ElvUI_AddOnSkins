local E, L, V, P, G = unpack(ElvUI);
local addon = E:GetModule("AddOnSkins");

if(not addon:CheckAddOn("EveryQuest")) then return; end

function addon:EveryQuest()
	local S = E:GetModule("Skins");

	EveryQuestFrame:StripTextures();
	EveryQuestFrame:SetTemplate("Transparent");
	EveryQuestListScrollFrame:CreateBackdrop("Default");
	S:HandleDropDownBox(EQ_Menu)
	EQ_Menu:SetWidth(190);
	S:HandleButton(EveryQuestExitButton);
	S:HandleCloseButton(EveryQuestFrameCloseButton)
	S:HandleButton(EQ_Options)
	S:HandleButton(EQ_Filters)
	S:HandleButton(EQ_ToggleButton)
	EQ_ToggleButton:SetWidth(50);
	EQ_ToggleButton:SetHeight(25);
	S:HandleScrollBar(EveryQuestListScrollFrameScrollBar)
end

addon:RegisterSkin("EveryQuest", addon.EveryQuest);