local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

if not AS:IsAddonLODorEnabled("EveryQuest") then return end

-- EveryQuest r162
-- https://www.wowace.com/projects/everyquest/files/459624

S:AddCallbackForAddon("EveryQuest", "EveryQuest", function()
	if not E.private.addOnSkins.EveryQuest then return end

	local addon = LibStub("AceAddon-3.0"):GetAddon("EveryQuest", true)
	if not addon then return end

	EveryQuestFrame:SetHitRectInsets(0, 0, 0, 0)
	EveryQuestFrame:StripTextures()
	EveryQuestFrame:SetTemplate("Transparent")

	EveryQuestTitleText:Point("TOP", 0, -3)

	EveryQuestFrame:SetSize(364, 512)

	addon.frames.Menu:ClearAllPoints()
	addon.frames.Menu:Point("TOP", EveryQuestFrame, 0, -20)
	S:HandleDropDownBox(addon.frames.Menu, 190)

	EveryQuestListScrollFrame:SetTemplate("Transparent")
	EveryQuestListScrollFrame:ClearAllPoints()
	EveryQuestListScrollFrame:Point("TOPLEFT", EveryQuestFrame, 20, -73)
	S:HandleScrollBar(EveryQuestListScrollFrameScrollBar)

	S:HandleCloseButton(EveryQuestFrameCloseButton, EveryQuestFrame)

	addon.frames.Show:ClearAllPoints()
	addon.frames.Show:Point("BOTTOMLEFT", QuestLogCount, "TOPLEFT", 0, 3)
	addon.frames.Show:Size(50, 20)
	S:HandleButton(addon.frames.Show)

	S:HandleButton(EveryQuestExitButton)
	S:HandleButton(addon.frames.Options)
	S:HandleButton(addon.frames.Filters)

	EveryQuestExitButton:ClearAllPoints()
	EveryQuestExitButton:Point("BOTTOMRIGHT", EveryQuestFrame, "BOTTOMRIGHT", -21, 4)

	addon.frames.Options:ClearAllPoints()
	addon.frames.Options:Point("RIGHT", EveryQuestExitButton, "LEFT", -1, 0)

	addon.frames.Filters:ClearAllPoints()
	addon.frames.Filters:Point("RIGHT", addon.frames.Options, "LEFT", -1, 0)

	addon.frames.Shown:ClearAllPoints()
	addon.frames.Shown:Point("BOTTOMLEFT", EveryQuestFrame, "BOTTOMLEFT", 20, 4)

	hooksecurefunc(addon, "OnShow", function(self)
		if not self.dbpc.profile.posx and not self.dbpc.profile.posy then
			EveryQuestFrame:ClearAllPoints()
			EveryQuestFrame:Point("TOPLEFT", QuestLogFrame, "TOPRIGHT", -2, -12)
		end
	end)
end)