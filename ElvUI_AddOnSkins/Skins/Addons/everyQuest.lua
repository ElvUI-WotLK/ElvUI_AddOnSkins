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

	EveryQuestFrame:StripTextures()
	EveryQuestFrame:SetTemplate("Transparent")
	EveryQuestFrame:Width(334)
	EveryQuestFrame:SetClampedToScreen(true)
	EveryQuestFrame:SetHitRectInsets(0, 0, 0, 0)

	EveryQuestTitleText:Point("TOP", 0, -5)

	EveryQuestListScrollFrame:CreateBackdrop("Transparent")
	EveryQuestListScrollFrame.backdrop:Point("TOPLEFT", 0, 1)
	EveryQuestListScrollFrame.backdrop:Point("BOTTOMRIGHT", 0, 4)
	EveryQuestListScrollFrame:ClearAllPoints()
	EveryQuestListScrollFrame:Point("TOPLEFT", EveryQuestFrame, 6, -75)
	EveryQuestListScrollFrame.Hide = E.noop
	EveryQuestListScrollFrame:Show()

	S:HandleScrollBar(EveryQuestListScrollFrameScrollBar)
	EveryQuestListScrollFrameScrollBar:ClearAllPoints()
	EveryQuestListScrollFrameScrollBar:Point("TOPRIGHT", EveryQuestListScrollFrame, 22, -18)
	EveryQuestListScrollFrameScrollBar:Point("BOTTOMRIGHT", EveryQuestListScrollFrame, 0, 23)

	for i = 1, 27 do
		local button = _G["EveryQuestTitle"..i]

		S:HandleButtonHighlight(button, 1, 0.8, 0.1)

		if i == 1 then
			button:ClearAllPoints()
			button:Point("TOPLEFT", EveryQuestListScrollFrame, -2, 0)
		end
	end

	S:HandleCloseButton(EveryQuestFrameCloseButton, EveryQuestFrame)

	addon.frames.Menu:ClearAllPoints()
	addon.frames.Menu:Point("TOPLEFT", EveryQuestListScrollFrame, -20, 30)
	S:HandleDropDownBox(addon.frames.Menu, 220)

	EQ_MenuText:ClearAllPoints()
	EQ_MenuText:Point("LEFT", addon.frames.Menu, 23, 3)
	EQ_MenuText:SetJustifyH("LEFT")

	addon.frames.ShownTT:ClearAllPoints()
	addon.frames.ShownTT:Point("RIGHT", addon.frames.Menu, 100, 3)
	addon.frames.ShownTT:Width(100)

	S:HandleButton(EveryQuestExitButton)
	EveryQuestExitButton:ClearAllPoints()
	EveryQuestExitButton:Point("BOTTOMRIGHT", EveryQuestFrame, -28, 5)
	EveryQuestExitButton:Width(98)

	S:HandleButton(addon.frames.Options)
	addon.frames.Options:ClearAllPoints()
	addon.frames.Options:Point("RIGHT", EveryQuestExitButton, "LEFT", -3, 0)
	addon.frames.Options:Width(98)

	S:HandleButton(addon.frames.Filters)
	addon.frames.Filters:ClearAllPoints()
	addon.frames.Filters:Point("RIGHT", addon.frames.Options, "LEFT", -3, 0)
	addon.frames.Filters:Width(98)

	addon.frames.Show:ClearAllPoints()
	addon.frames.Show:Point("LEFT", QuestLogCount, "RIGHT", 6, -1)
	addon.frames.Show:Size(50, 20)
	S:HandleButton(addon.frames.Show)

	hooksecurefunc(addon, "OnShow", function(self)
		if not self.dbpc.profile.posx and not self.dbpc.profile.posy then
			EveryQuestFrame:ClearAllPoints()
			EveryQuestFrame:Point("TOPLEFT", QuestLogFrame, "TOPRIGHT", -2, -12)
		end
	end)
end)