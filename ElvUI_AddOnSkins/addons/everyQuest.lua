local E, L, V, P, G = unpack(ElvUI);
local S = E:GetModule("Skins");

local function LoadSkin()
	if(not E.private.addOnSkins.EveryQuest) then return; end

	EveryQuestFrame:StripTextures();
	EveryQuestFrame:SetTemplate("Transparent");
	EveryQuestListScrollFrame:CreateBackdrop("Default");
	S:HandleDropDownBox(EQ_Menu);
	EQ_Menu:SetWidth(190);
	S:HandleButton(EveryQuestExitButton);
	S:HandleCloseButton(EveryQuestFrameCloseButton);
	S:HandleButton(EQ_Options);
	S:HandleButton(EQ_Filters);
	S:HandleButton(EQ_ToggleButton);
	EQ_ToggleButton:Width(50);
	EQ_ToggleButton:Height(25);
	S:HandleScrollBar(EveryQuestListScrollFrameScrollBar);
end

S:AddCallbackForAddon("EveryQuest", "EveryQuest", LoadSkin);