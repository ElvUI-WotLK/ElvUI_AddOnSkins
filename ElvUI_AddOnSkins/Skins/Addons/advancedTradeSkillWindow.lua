local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

if not AS:IsAddonLODorEnabled("AdvancedTradeSkillWindow") then return end

local _G = _G
local ipairs = ipairs
local find = string.find

local hooksecurefunc = hooksecurefunc

-- AdvancedTradeSkillWindow 0.7.8
-- https://www.curseforge.com/wow/addons/advanced-trade-skill-window/files/400569

S:AddCallbackForAddon("AdvancedTradeSkillWindow", "AdvancedTradeSkillWindow", function()
	if not E.private.addOnSkins.AdvancedTradeSkillWindow then return end

	local scrollBars = {
		-- Main Frame
		"ATSWListScrollFrameScrollBar",
		"ATSWQueueScrollFrameScrollBar",
		-- Sorting Editor
		"ATSWCSUListScrollFrameScrollBar",
		"ATSWCSSListScrollFrameScrollBar",
	}

	local buttons = {
		-- Scan
		"ATSWScanDelayFrameSkipButton",
		"ATSWScanDelayFrameAbortButton",
		-- Main Frame
		"ATSWCSButton",
		"ATSWOptionsButton",
		"ATSWQueueAllButton",
		"ATSWCreateAllButton",
		"ATSWCreateButton",
		"ATSWQueueButton",
		"ATSWQueueStartStopButton",
		"ATSWQueueDeleteButton",
		"ATSWReagentsButton",
		"ATSWQueueItem1DeleteButton",
		"ATSWQueueItem2DeleteButton",
		"ATSWQueueItem3DeleteButton",
		"ATSWQueueItem4DeleteButton",
		-- Sorting Editor
		"ATSWAddCategoryButton",
		-- Reagent Frame
		"ATSWBuyReagentsButton",
		-- Options
		"ATSWOptionsFrameOKButton",
		-- Merchant Frame
		"ATSWAutoBuyButton",
	}

	local checkBoxes = {
		-- Main Frame
		"ATSWHeaderSortButton",
		"ATSWNameSortButton",
		"ATSWDifficultySortButton",
		"ATSWCustomSortButton",
		"ATSWOnlyCreatableButton",
		-- Options
		"ATSWOFUnifiedCounterButton",
		"ATSWOFSeparateCounterButton",
		"ATSWOFIncludeBankButton",
		"ATSWOFIncludeAltsButton",
		"ATSWOFIncludeMerchantsButton",
		"ATSWOFAutoBuyButton",
		"ATSWOFTooltipButton",
		"ATSWOFShoppingListButton",
		"ATSWOFReagentListButton",
		"ATSWOFNewRecipeLinkButton",
	}

	local editBoxes = {
		-- Main Frame
		"ATSWFilterBox",
		"ATSWInputBox",
		-- Sorting Editor
		"ATSWCSNewCategoryBox",
	}

	local dropDownBoxes = {
		-- Main Frame
		"ATSWSubClassDropDown",
		"ATSWInvSlotDropDown",
	}

	local closeButtons = {
		-- Main Frame
		"ATSWFrameCloseButton",
		-- Reagent Frame
		"ATSWReagentFrameCloseButton",
		-- Sorting Editor
		"ATSWCSFrameCloseButton",
	}

	local statusBars = {
		-- Scan
		"ATSWScanDelayFrameBar",
		-- Main Frame
		"ATSWRankFrame",
	}

	local frame

	for _, scrollBar in ipairs(scrollBars) do
		frame = _G[scrollBar]
		frame:GetParent():StripTextures()
		S:HandleScrollBar(frame)
	end
	for _, button in ipairs(buttons) do
		S:HandleButton(_G[button])
	end
	for _, checkBox in ipairs(checkBoxes) do
		S:HandleCheckBox(_G[checkBox])
	end
	for _, editBox in ipairs(editBoxes) do
		S:HandleEditBox(_G[editBox])
	end
	for _, dropDownBox in ipairs(dropDownBoxes) do
		S:HandleDropDownBox(_G[dropDownBox])
	end
	for _, closeButton in ipairs(closeButtons) do
		frame = _G[closeButton]
		S:HandleCloseButton(frame, frame:GetParent().backdrop)
	end
	for _, statusBar in ipairs(statusBars) do
		frame = _G[statusBar]
		frame:StripTextures()
		frame:CreateBackdrop()
		frame:SetStatusBarTexture(E["media"].normTex)
		E:RegisterStatusBar(frame)
	end

	ATSWScanDelayFrame:StripTextures()
	ATSWScanDelayFrame:SetTemplate("Transparent")

	ATSWOptionsFrame:SetParent(E.UIParent)
	ATSWOptionsFrame:StripTextures()
	ATSWOptionsFrame:SetTemplate("Transparent")

	ATSWFrame:StripTextures()
	ATSWFrame:CreateBackdrop("Transparent")
	ATSWFrame.backdrop:Point("TOPLEFT", 10, -12)
	ATSWFrame.backdrop:Point("BOTTOMRIGHT", -34, 10)
	ATSWFrame:SetClampedToScreen(true)

	ATSWCSFrame:StripTextures()
	ATSWCSFrame:CreateBackdrop("Transparent")
	ATSWCSFrame.backdrop:Point("TOPLEFT", 10, -12)
	ATSWCSFrame.backdrop:Point("BOTTOMRIGHT", -34, 10)
	ATSWCSFrame:SetClampedToScreen(true)

	ATSWReagentFrame:StripTextures()
	ATSWReagentFrame:CreateBackdrop("Transparent")
	ATSWReagentFrame.backdrop:Point("TOPLEFT", 12, -14)
	ATSWReagentFrame.backdrop:Point("BOTTOMRIGHT", -34, 74)


	S:HandleNextPrevButton(_G["ATSWDecrementButton"])
	S:HandleNextPrevButton(_G["ATSWIncrementButton"])

	ATSWTradeskillTooltip:SetTemplate("Transparent")

	ATSWScanDelayFrame:Size(400, 151) -- fix pixelperfect

	ATSWFramePortrait:Kill()

	for i = 1, 23 do
		local button = _G["ATSWSkill" .. i]

		button:SetNormalTexture("")
		button.SetNormalTexture = E.noop
		button:GetHighlightTexture():SetAlpha(0)
		button:SetDisabledTexture("")
		button.SetDisabledTexture = E.noop

		button.Text = button:CreateFontString(nil, "OVERLAY")
		button.Text:FontTemplate(nil, 22)
		button.Text:Point("LEFT", 3, 0)
		button.Text:SetText("+")

		hooksecurefunc(button, "SetNormalTexture", function(self, texture)
			if find(texture, "MinusButton") then
				self.Text:SetText("-")
			elseif find(texture, "PlusButton") then
				self.Text:SetText("+")
			else
				self.Text:SetText("")
			end
		end)
	end

	ATSWExpandButtonFrame:StripTextures()

	ATSWCollapseAllButton:SetNormalTexture("")
	ATSWCollapseAllButton.SetNormalTexture = E.noop
	ATSWCollapseAllButton:GetHighlightTexture():SetAlpha(0)
	ATSWCollapseAllButton:SetDisabledTexture("")
	ATSWCollapseAllButton.SetDisabledTexture = E.noop

	ATSWCollapseAllButton.Text = ATSWCollapseAllButton:CreateFontString(nil, "OVERLAY")
	ATSWCollapseAllButton.Text:FontTemplate(nil, 22)
	ATSWCollapseAllButton.Text:Point("LEFT", 3, 0)
	ATSWCollapseAllButton.Text:SetText("-")

	ATSWCollapseAllButton:HookScript("OnClick", function(self)
		if self.collapsed then
			self.Text:SetText("+")
		else
			self.Text:SetText("-")
		end
	end)

	ATSWRankFrameBorder:StripTextures()
	ATSWRankFrameBorder:Hide()

	local function SkinIcon(reagent, icon, count)
		reagent:StripTextures()

		icon:SetTexCoord(unpack(E.TexCoords))
		icon:SetDrawLayer("OVERLAY")

		icon.backdrop = CreateFrame("Frame", nil, reagent)
		icon.backdrop:SetFrameLevel(reagent:GetFrameLevel() - 1)
		icon.backdrop:SetTemplate("Default")
		icon.backdrop:SetOutside(icon)

		icon:SetParent(icon.backdrop)
		count:SetParent(icon.backdrop)
		count:SetDrawLayer("OVERLAY")
	end

	hooksecurefunc(ATSWSkillIcon, "SetNormalTexture", function(self)
		if self.skinned then
			self:GetNormalTexture():SetTexCoord(unpack(E.TexCoords))
		else
			local reagent = _G["ATSWSkillIcon"]
			local icon = _G["ATSWSkillIcon"]:GetNormalTexture()
			local count = _G["ATSWSkillIconCount"]

			SkinIcon(reagent, icon, count)

			self.skinned = true
		end
	end)

	for i = 1, ATSW_MAX_TRADE_SKILL_REAGENTS do
		local reagent = _G["ATSWReagent" .. i]
		local icon = _G["ATSWReagent" .. i .. "IconTexture"]
		local count = _G["ATSWReagent" .. i .. "Count"]

		SkinIcon(reagent, icon, count)
	end

	for i = 1, 17 do
		local buttonDelete = _G["ATSWCSCSkill" .. i .. "Delete"]
		local buttonUp = _G["ATSWCSCSkill" .. i .. "MoveUp"]
		local buttonDown = _G["ATSWCSCSkill" .. i .. "MoveDown"]

		buttonDelete:Size(17)
		buttonUp:Size(24)
		buttonDown:Size(24)

		S:HandleButton(buttonDelete)
		S:HandleNextPrevButton(buttonUp, "up")
		S:HandleNextPrevButton(buttonDown, "down")
	end

	ATSWRankFrame:Size(282, 15)
	ATSWRankFrame:ClearAllPoints()
	ATSWRankFrame:Point("TOPLEFT", ATSWFrame, "TOPRIGHT", -412, -33)
	ATSWRankFrame:SetStatusBarColor(0.13, 0.35, 0.80)

	ATSWHeaderSortButton:ClearAllPoints()
	ATSWHeaderSortButton:Point("TOPLEFT", ATSWFrame, "TOPLEFT", 24, -34)

	ATSWNameSortButton:ClearAllPoints()
	ATSWNameSortButton:Point("TOP", ATSWHeaderSortButton, "BOTTOM", 0, 6)

	ATSWDifficultySortButton:ClearAllPoints()
	ATSWDifficultySortButton:Point("LEFT", ATSWHeaderSortButton, "RIGHT", 140, 0)

	ATSWCustomSortButton:ClearAllPoints()
	ATSWCustomSortButton:Point("TOP", ATSWDifficultySortButton, "BOTTOM", 0, 6)


	ATSWOptionsButton:Height(20)
	ATSWOptionsButton:ClearAllPoints()
	ATSWOptionsButton:Point("TOPLEFT", ATSWFrame, "TOPRIGHT", -130, -50)

	ATSWCreateButton:ClearAllPoints()
	ATSWCreateButton:Point("CENTER", ATSWFrame, "TOPLEFT", 627, -348)

	ATSWDecrementButton:ClearAllPoints()
	ATSWDecrementButton:Point("LEFT", ATSWCreateAllButton, "RIGHT", 5, 0)

	ATSWInputBox:ClearAllPoints()
	ATSWInputBox:Point("LEFT", ATSWDecrementButton, "RIGHT", 5, 0)

	ATSWIncrementButton:ClearAllPoints()
	ATSWIncrementButton:Point("LEFT", ATSWInputBox, "RIGHT", 5, 0)

	ATSWReagentsButton:ClearAllPoints()
	ATSWReagentsButton:Point("BOTTOMLEFT", ATSWFrame, "BOTTOMRIGHT", -130, 20)

	ATSWQueueDeleteButton:ClearAllPoints()
	ATSWQueueDeleteButton:Point("RIGHT", ATSWReagentsButton, "LEFT", -8, 0)

	ATSWQueueStartStopButton:ClearAllPoints()
	ATSWQueueStartStopButton:Point("RIGHT", ATSWQueueDeleteButton, "LEFT", -8, 0)

	ATSWInvSlotDropDown:ClearAllPoints()
	ATSWInvSlotDropDown:Point("TOPLEFT", ATSWFrame, "TOPLEFT", 198, -66)

	ATSWSubClassDropDown:ClearAllPoints()
	ATSWSubClassDropDown:Point("RIGHT", ATSWInvSlotDropDown, "LEFT", 24, 0)

	ATSWCSNewCategoryBox:ClearAllPoints()
	ATSWCSNewCategoryBox:Point("TOPLEFT", ATSWCSFrame, "TOPLEFT", 398, -471)

	ATSWAddCategoryButton:ClearAllPoints()
	ATSWAddCategoryButton:Point("LEFT", ATSWCSNewCategoryBox, "RIGHT", 3, 0)

	-- ChatLink fix
	ATSWTradeSkillLinkButton:SetScript("OnClick", function()
		local ChatFrameEditBox = ChatEdit_ChooseBoxForSend()
		if not ChatFrameEditBox:IsShown() then
			ChatEdit_ActivateChat(ChatFrameEditBox)
		end

		ChatFrameEditBox:Insert(GetTradeSkillListLink())
	end)
end)