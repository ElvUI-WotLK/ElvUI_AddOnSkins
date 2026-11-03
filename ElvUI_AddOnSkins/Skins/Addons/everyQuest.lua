local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
-- Optional controls differ between supported addon versions. Keep missing
-- targets out of native skin handlers without masking other Lua errors.
local function SkinControl(method, frame, ...)
	if frame then return S[method](S, frame, ...) end
end
local function SkinFrame(frame, method, ...)
	if frame then return frame[method](frame, ...) end
end

local AS = E:GetModule("AddOnSkins")

if not AS:IsAddonLODorEnabled("EveryQuest") then return end

-- EveryQuest r162
-- https://www.wowace.com/projects/everyquest/files/459624

S:AddCallbackForAddon("EveryQuest", "EveryQuest", function()
	if not E.private.addOnSkins.EveryQuest then return end

	local addon = LibStub("AceAddon-3.0"):GetAddon("EveryQuest", true)
	if not addon then return end

	SkinFrame(EveryQuestFrame, "StripTextures")
	SkinFrame(EveryQuestFrame, "SetTemplate", "Transparent")
	SkinFrame(EveryQuestFrame, "Size", 341, 494)
	EveryQuestFrame:SetClampedToScreen(true)
	EveryQuestFrame:SetHitRectInsets(0, 0, 0, 0)

	SkinFrame(EveryQuestTitleText, "Point", "TOP", 0, -5)

	EveryQuestListScrollFrame:CreateBackdrop("Transparent")
	EveryQuestListScrollFrame.backdrop:Point("TOPLEFT", -3, 1)
	EveryQuestListScrollFrame.backdrop:Point("BOTTOMRIGHT", 1, 2)
	SkinFrame(EveryQuestListScrollFrame, "Point", "TOPLEFT", 11, -51)
	EveryQuestListScrollFrame.Hide = E.noop
	SkinFrame(EveryQuestListScrollFrame, "Show")

	SkinControl("HandleScrollBar", EveryQuestListScrollFrameScrollBar)
	SkinFrame(EveryQuestListScrollFrameScrollBar, "Point", "TOPLEFT", EveryQuestListScrollFrame, "TOPRIGHT", 4, -18)
	SkinFrame(EveryQuestListScrollFrameScrollBar, "Point", "BOTTOMLEFT", EveryQuestListScrollFrame, "BOTTOMRIGHT", 4, 21)

	SkinFrame(EveryQuestTitle1, "Point", "TOPLEFT", 10, -52)

	for i = 1, 27 do
		SkinControl("HandleButtonHighlight", _G["EveryQuestTitle"..i], 1, 0.8, 0.1)
	end

	SkinControl("HandleCloseButton", EveryQuestFrameCloseButton, EveryQuestFrame)

	SkinControl("HandleDropDownBox", addon.frames.Menu, 241)
	addon.frames.Menu:Point("TOPRIGHT", -56, -22)

	SkinFrame(EQ_MenuText, "Point", "RIGHT", EQ_MenuButton, "LEFT", -6, 0)

	addon.frames.ShownTT:SetTemplate("Transparent")
	addon.frames.ShownTT:Point("BOTTOMLEFT", EveryQuestFrame, "BOTTOMLEFT", 8, 8)

	SkinControl("HandleButton", EveryQuestExitButton)
	SkinFrame(EveryQuestExitButton, "ClearAllPoints")
	SkinFrame(EveryQuestExitButton, "Point", "BOTTOMRIGHT", -8, 8)
	SkinFrame(EveryQuestExitButton, "Width", 72)

	SkinControl("HandleButton", addon.frames.Options)
	addon.frames.Options:Point("TOPLEFT", addon.frames.Filters, "TOPRIGHT", 3, 0)

	SkinControl("HandleButton", addon.frames.Filters)
	addon.frames.Filters:Point("BOTTOMLEFT", EveryQuestFrame, "BOTTOMLEFT", 135, 8)

	SkinControl("HandleButton", addon.frames.Show)
	addon.frames.Show:ClearAllPoints()
	addon.frames.Show:Point("LEFT", QuestLogCount, "RIGHT", 8, -2)
	addon.frames.Show:Size(50, 20)

	hooksecurefunc(addon, "OnShow", function(self)
		if not self.dbpc.profile.posx and not self.dbpc.profile.posy then
			SkinFrame(EveryQuestFrame, "ClearAllPoints")
			SkinFrame(EveryQuestFrame, "Point", "TOPLEFT", QuestLogFrame, "TOPRIGHT", 6, -12)
		end
	end)
end)
