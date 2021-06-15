local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

if not AS:IsAddonLODorEnabled("LootCouncil_Lite") then return end

-- Loot Council Lite 1.011
-- https://www.curseforge.com/wow/addons/lootcouncil-lite/files/457971

S:AddCallbackForAddon("LootCouncil_Lite", "LootCouncil_Lite", function()
	if not E.private.addOnSkins.LootCouncil_Lite then return end

	-- Main Frame
	MainFrame:SetTemplate("Transparent")

	EntryFrame:SetTemplate("Transparent")

	EmptyTexture:Kill()

	local icons = {
		CurrentItemTexture,
		CurrentSelectionTexture,
		DualItemTexture1,
		DualItemTexture2,
	}

	local showBackdrop = function(self) self.backdrop:Show() end
	local hideBackdrop = function(self) self.backdrop:Hide() end
	for _, icon in ipairs(icons) do
		icon:SetTexCoord(unpack(E.TexCoords))
		icon:CreateBackdrop()
		icon.backdrop:Hide()

		hooksecurefunc(icon, "Show", showBackdrop)
		hooksecurefunc(icon, "Hide", hideBackdrop)
	end

	DisenchantButton:Point("TOPLEFT", MainFrame, "BOTTOMLEFT", 480, 73)

	if SyncButton then
		S:HandleButton(SyncButton)
	end

	S:HandleButton(AwardButton)
	S:HandleButton(RemoveButton)
	S:HandleButton(DisenchantButton)
	S:HandleButton(AbortButton)
	S:HandleButton(ClearSelectionButton)
	S:HandleButton(CloseButton)

--	S:HandleDropDownBox(GroupLootDropDownLCL)

	-- Options
	LCOptionsFrame:SetTemplate("Transparent")

	S:HandleDropDownBox(OptDropDown)

	S:HandleButton(OptAcceptButton)
	S:HandleButton(OptCancelButton)

	S:HandleSliderFrame(ScaleSlider)

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
		checkbox:Point(p1, a, p2, x, y - 8)
		checkbox:Size(24)

		S:HandleCheckBox(checkbox)
	end

	-- RankFrame
	RankFrame:EnableMouse(true)
	RankFrame:SetTemplate("Transparent")

	S:HandleDropDownBox(RankDropDown)

	S:HandleButton(RankAcceptButton)
	S:HandleButton(RankCancelButton)

	-- TestFrame
	if LCTestFrame then
		LCTestFrame:SetTemplate("Transparent")

		S:HandleButton(RunTestButton)
		S:HandleButton(TestCancelButton)
	end
end)