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

if not AS:IsAddonLODorEnabled("LootCouncil_Lite") then return end

-- Loot Council Lite 1.011
-- https://www.curseforge.com/wow/addons/lootcouncil-lite/files/457971

S:AddCallbackForAddon("LootCouncil_Lite", "LootCouncil_Lite", function()
	if not E.private.addOnSkins.LootCouncil_Lite then return end

	-- Main Frame
	SkinFrame(MainFrame, "SetTemplate", "Transparent")

	SkinFrame(EntryFrame, "SetTemplate", "Transparent")

	SkinFrame(EmptyTexture, "Kill")

	local icons = {
		CurrentItemTexture,
		CurrentSelectionTexture,
		DualItemTexture1,
		DualItemTexture2,
	}

	local showBackdrop = function(self) self.backdrop:Show() end
	local hideBackdrop = function(self) self.backdrop:Hide() end
	for _, icon in ipairs(icons) do
		SkinFrame(icon, "SetTexCoord", unpack(E.TexCoords))
		icon:CreateBackdrop()
		icon.backdrop:Hide()

		hooksecurefunc(icon, "Show", showBackdrop)
		hooksecurefunc(icon, "Hide", hideBackdrop)
	end

	SkinFrame(DisenchantButton, "Point", "TOPLEFT", MainFrame, "BOTTOMLEFT", 480, 73)

	if SyncButton then
		SkinControl("HandleButton", SyncButton)
	end

	SkinControl("HandleButton", AwardButton)
	SkinControl("HandleButton", RemoveButton)
	SkinControl("HandleButton", DisenchantButton)
	SkinControl("HandleButton", AbortButton)
	SkinControl("HandleButton", ClearSelectionButton)
	SkinControl("HandleButton", CloseButton)

--	SkinControl("HandleDropDownBox", GroupLootDropDownLCL)

	-- Options
	SkinFrame(LCOptionsFrame, "SetTemplate", "Transparent")

	SkinControl("HandleDropDownBox", OptDropDown)

	SkinControl("HandleButton", OptAcceptButton)
	SkinControl("HandleButton", OptCancelButton)

	SkinControl("HandleSliderFrame", ScaleSlider)

	local checkBoxes = {
		PrivateVoteMode,
		SingleVoteMode,
		SelfVoteMode,
		DisplaySpecMode,
		WhisperLinkMode,
		OfficerLinkMode,
		RaidLinkMode,
		ConfirmEnding,
		MasterLootIntegration,
		GuildLinkMode,
	}

	for _, checkbox in ipairs(checkBoxes) do
		local p1, a, p2, x, y = checkbox:GetPoint()
		SkinFrame(checkbox, "Point", p1, a, p2, x, y - 8)
		SkinFrame(checkbox, "Size", 24)

		SkinControl("HandleCheckBox", checkbox)
	end

	-- RankFrame
	RankFrame:EnableMouse(true)
	SkinFrame(RankFrame, "SetTemplate", "Transparent")

	SkinControl("HandleDropDownBox", RankDropDown)

	SkinControl("HandleButton", RankAcceptButton)
	SkinControl("HandleButton", RankCancelButton)

	-- TestFrame
	if LCTestFrame then
		SkinFrame(LCTestFrame, "SetTemplate", "Transparent")

		SkinControl("HandleButton", RunTestButton)
		SkinControl("HandleButton", TestCancelButton)
	end
end)
