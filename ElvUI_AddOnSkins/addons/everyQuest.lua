local E, L, V, P, G = unpack(ElvUI);
local S = E:GetModule("Skins");

-- EveryQuest r162

local function LoadSkin()
	if(not E.private.addOnSkins.EveryQuest) then return; end

	local addon = LibStub("AceAddon-3.0"):GetAddon("EveryQuest", true);
	if not addon then return end

	EveryQuestFrame:StripTextures();
	EveryQuestFrame:CreateBackdrop("Transparent");
	EveryQuestFrame.backdrop:Point("TOPLEFT", 0, 0);
	EveryQuestFrame.backdrop:Point("BOTTOMRIGHT", -22, 0);

	EveryQuestListScrollFrame:CreateBackdrop("Default");
	EveryQuestListScrollFrame:Point("TOPLEFT", EveryQuestFrame, "TOPLEFT", 20, -73)
	S:HandleScrollBar(EveryQuestListScrollFrameScrollBar);

	S:HandleCloseButton(EveryQuestFrameCloseButton, EveryQuestFrame.backdrop);

	S:HandleButton(addon.frames.Show);
	addon.frames.Show:Size(50, 20);

	S:HandleDropDownBox(addon.frames.Menu);
	addon.frames.Menu:Width(190);

	S:HandleButton(addon.frames.Show);
	S:HandleButton(addon.frames.Filters);
	S:HandleButton(addon.frames.Options);
	S:HandleButton(EveryQuestExitButton);

	EveryQuestExitButton:ClearAllPoints();
	EveryQuestExitButton:Point("BOTTOMRIGHT", EveryQuestFrame, "BOTTOMRIGHT", -41, 4);

	addon.frames.Options:ClearAllPoints();
	addon.frames.Options:Point("TOPRIGHT", EveryQuestExitButton, "TOPLEFT", -2, 0);

	addon.frames.Filters:ClearAllPoints();
	addon.frames.Filters:Point("TOPRIGHT", addon.frames.Options, "TOPLEFT", -2, 0);

	hooksecurefunc(addon, "OnShow", function(self)
		if not self.dbpc.profile.posx and not self.dbpc.profile.posy then
			EveryQuestFrame:ClearAllPoints();
			EveryQuestFrame:SetPoint("TOPLEFT", QuestLogFrame, "TOPRIGHT", 10, -12)
		end
	end)
end

S:AddCallbackForAddon("EveryQuest", "EveryQuest", LoadSkin);