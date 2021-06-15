local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

if not AS:IsAddonLODorEnabled("AdvancedTradeSkillWindow") then return end

local _G = _G
local ipairs = ipairs
local unpack = unpack

local GetTradeSkillListLink = GetTradeSkillListLink
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
		-- ShoppingList Frame
		"ATSWSLScrollFrameScrollBar",
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

	for _, scrollBar in ipairs(scrollBars) do
		scrollBar = _G[scrollBar]
		scrollBar:GetParent():StripTextures()
		S:HandleScrollBar(scrollBar)
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
		closeButton = _G[closeButton]
		S:HandleCloseButton(closeButton, closeButton:GetParent().backdrop)
	end
	for _, statusBar in ipairs(statusBars) do
		statusBar = _G[statusBar]
		statusBar:StripTextures()
		statusBar:CreateBackdrop()
		statusBar:SetStatusBarTexture(E.media.normTex)
		E:RegisterStatusBar(statusBar)
	end

	E:GetModule("Tooltip"):SecureHookScript(ATSWTradeskillTooltip, "OnShow", "SetStyle")

	-- ScanDelay Frame
	ATSWScanDelayFrame:Size(400, 151) -- fix pixelperfect
	ATSWScanDelayFrame:StripTextures()
	ATSWScanDelayFrame:SetTemplate("Transparent")

	-- Options Frame
	ATSWOptionsFrame:SetParent(UIParent)
	ATSWOptionsFrame:StripTextures()
	ATSWOptionsFrame:SetTemplate("Transparent")

	-- Main Frame
	ATSWFrame:StripTextures()
	ATSWFrame:CreateBackdrop("Transparent")
	ATSWFrame.backdrop:Point("TOPLEFT", 11, -12)
	ATSWFrame.backdrop:Point("BOTTOMRIGHT", -32, 10)
	ATSWFrame:SetClampedToScreen(true)
	S:SetBackdropHitRect(ATSWFrame, nil, true)

	ATSWFramePortrait:Hide()

	S:HandleNextPrevButton(ATSWDecrementButton)
	S:HandleNextPrevButton(ATSWIncrementButton)

	ATSWExpandButtonFrame:StripTextures()

	ATSWRankFrameBorder:StripTextures()
	ATSWRankFrameBorder:Hide()

	for i = 0, ATSW_TRADE_SKILLS_DISPLAYED or 23 do
		if i == 0 then
			S:HandleCollapseExpandButton(ATSWCollapseAllButton)

			local onClick = function(self)
				if self.collapsed then
					self:GetNormalTexture():SetTexture(E.Media.Textures.Minus)
					self:GetPushedTexture():SetTexture(E.Media.Textures.Minus)
					self:GetDisabledTexture():SetTexture(E.Media.Textures.Minus)
				else
					self:GetNormalTexture():SetTexture(E.Media.Textures.Plus)
					self:GetPushedTexture():SetTexture(E.Media.Textures.Plus)
					self:GetDisabledTexture():SetTexture(E.Media.Textures.Plus)
				end
			end

			onClick(ATSWCollapseAllButton)
			ATSWCollapseAllButton:HookScript("OnClick", onClick)
		else
			local button = _G["ATSWSkill"..i]
			if button then
				S:HandleCollapseExpandButton(button)
			end
		end
	end

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

	for i = 1, ATSW_MAX_TRADE_SKILL_REAGENTS do
		local reagent = _G["ATSWReagent" .. i]
		local icon = _G["ATSWReagent" .. i .. "IconTexture"]
		local count = _G["ATSWReagent" .. i .. "Count"]

		SkinIcon(reagent, icon, count)
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

	for i = 1, 4 do
		local button = _G["ATSWQueueItem"..i.."DeleteButton"]
		S:HandleButton(button)
		button:Size(20, 21)
	end

	ATSWHeaderSortButton:Point("TOPLEFT", 29, -30)
	ATSWNameSortButton:Point("TOPLEFT", 29, -45)
	ATSWDifficultySortButton:Point("TOPLEFT", 189, -30)
	ATSWCustomSortButton:Point("TOPLEFT", 189, -45)

	ATSWOnlyCreatableButton:Point("TOPLEFT", 349, -37)

	ATSWCSButton:Point("CENTER", ATSWFrame, "TOPLEFT", 594, -44)

	ATSWOptionsButton:Height(20)
	ATSWOptionsButton:Point("CENTER", ATSWFrame, "TOPLEFT", 683, -44)

	ATSWRankFrame:Point("TOPLEFT", 459, -62)

	ATSWInvSlotDropDown:Point("TOPRIGHT", -421, -65)
	ATSWSubClassDropDown:Point("RIGHT", ATSWInvSlotDropDown, "LEFT", 20, 0)

	ATSWFilterBox:Width(212)

	ATSWExpandButtonFrame:Point("TOPLEFT", 14, -95)

	ATSWListScrollFrame:SetTemplate("Transparent")
	ATSWListScrollFrame:Size(299, 374)
	ATSWListScrollFrame:Point("TOPLEFT", 19, -120)
	ATSWListScrollFrame.Hide = E.noop

	ATSWListScrollFrameScrollBar:Point("TOPLEFT", ATSWListScrollFrame, "TOPRIGHT", 3, -19)
	ATSWListScrollFrameScrollBar:Point("BOTTOMLEFT", ATSWListScrollFrame, "BOTTOMRIGHT", 3, 19)

	ATSWSkill1:Point("TOPLEFT", 22, -123)

	ATSWCreateButton:Point("CENTER", ATSWFrame, "TOPLEFT", 625, -349)
	ATSWQueueButton:Point("LEFT", ATSWCreateButton, "RIGHT", 3, 0)

	ATSWCreateAllButton:Point("RIGHT", ATSWCreateButton, "LEFT", -84, 0)
	ATSWQueueAllButton:Point("RIGHT", ATSWCreateAllButton, "LEFT", -3, 0)

	ATSWDecrementButton:Point("LEFT", ATSWCreateAllButton, "RIGHT", 5, 0)
	ATSWInputBox:Point("LEFT", ATSWDecrementButton, "RIGHT", 4, 0)
	ATSWIncrementButton:Point("RIGHT", ATSWCreateButton, "LEFT", -5, 0)

	ATSWQueueItem1:Point("TOPLEFT", 355, -373)

	ATSWQueueScrollFrameScrollBar:Point("TOPLEFT", ATSWQueueScrollFrame, "TOPRIGHT", 8, -16)
	ATSWQueueScrollFrameScrollBar:Point("BOTTOMLEFT", ATSWQueueScrollFrame, "BOTTOMRIGHT", 8, 16)

	ATSWReagentsButton:Point("CENTER", ATSWFrame, "TOPLEFT", 683, -483)
	ATSWQueueStartStopButton:Point("CENTER", ATSWFrame, "TOPLEFT", 421, -483)

	ATSWQueueDeleteButton:ClearAllPoints()
	ATSWQueueDeleteButton:Point("LEFT", ATSWQueueStartStopButton, "RIGHT", 3, 0)
	ATSWQueueDeleteButton:Point("RIGHT", ATSWReagentsButton, "LEFT", -3, 0)

	-- Reagent Frame
	ATSWReagentFrame:StripTextures()
	ATSWReagentFrame:CreateBackdrop("Transparent")
	ATSWReagentFrame.backdrop:Point("TOPLEFT", 12, -14)
	ATSWReagentFrame.backdrop:Point("BOTTOMRIGHT", -34, 74)
	S:SetBackdropHitRect(ATSWReagentFrame, nil, true)

	-- SortingEditor Frame
	ATSWCSFrame:StripTextures()
	ATSWCSFrame:CreateBackdrop("Transparent")
	ATSWCSFrame.backdrop:Point("TOPLEFT", 11, -12)
	ATSWCSFrame.backdrop:Point("BOTTOMRIGHT", -32, 10)
	ATSWCSFrame:SetClampedToScreen(true)
	S:SetBackdropHitRect(ATSWCSFrame, nil, true)

	ATSWCSUListScrollFrame:SetTemplate("Transparent")
	ATSWCSUListScrollFrame:Size(342, 383) -- 311, 383
	ATSWCSUListScrollFrame:Point("TOPLEFT", 19, -111)
	ATSWCSSkill1:Point("TOPLEFT", 28, -120)

	ATSWCSUListScrollFrameScrollBar:Point("TOPLEFT", ATSWCSUListScrollFrame, "TOPRIGHT", 3, -19)
	ATSWCSUListScrollFrameScrollBar:Point("BOTTOMLEFT", ATSWCSUListScrollFrame, "BOTTOMRIGHT", 3, 19)

	ATSWCSSListScrollFrame:SetTemplate("Transparent")
	ATSWCSSListScrollFrame:Size(322, 354)
	ATSWCSSListScrollFrame:Point("TOPLEFT", 385, -111)
	ATSWCSCSkill1:Point("TOPLEFT", 394, -120)

	ATSWCSSListScrollFrameScrollBar:Point("TOPLEFT", ATSWCSSListScrollFrame, "TOPRIGHT", 3, -19)
	ATSWCSSListScrollFrameScrollBar:Point("BOTTOMLEFT", ATSWCSSListScrollFrame, "BOTTOMRIGHT", 3, 19)

	for i = 1, 17 do
		local buttonDelete = _G["ATSWCSCSkill" .. i .. "Delete"]
		local buttonUp = _G["ATSWCSCSkill" .. i .. "MoveUp"]
		local buttonDown = _G["ATSWCSCSkill" .. i .. "MoveDown"]
		local skillButton = _G["ATSWCSCSkill" .. i .. "SkillButton"]

		buttonDelete:Size(17)
		buttonUp:Size(24)
		buttonDown:Size(24)

		S:HandleButton(buttonDelete)
		S:HandleNextPrevButton(buttonUp, "up")
		S:HandleNextPrevButton(buttonDown, "down")

		S:HandleCollapseExpandButton(skillButton)
	end

	ATSWCSNewCategoryBox:Point("TOPLEFT", 424, -473)

	ATSWAddCategoryButton:Point("LEFT", ATSWCSNewCategoryBox, "RIGHT", 4, 0)

	-- ShoppingList
	ATSWShoppingListFrame:StripTextures()
	ATSWShoppingListFrame:CreateBackdrop("Transparent")
	ATSWShoppingListFrame.backdrop:Point("TOPLEFT", 12, 0)
	ATSWShoppingListFrame.backdrop:Point("BOTTOMRIGHT", -35, 59)

	S:SetBackdropHitRect(ATSWShoppingListFrame)

	S:HandleCloseButton(ATSWSLCloseButton)
	ATSWSLCloseButton:Point("BOTTOMRIGHT", -39, 177)
	ATSWSLCloseButton:SetHitRectInsets(1, 0, 1, 0)
	ATSWSLCloseButton:SetText(nil)

	ATSWSLScrollFrameScrollBar:Point("TOPLEFT", ATSWSLScrollFrame, "TOPRIGHT", 5, -18)
	ATSWSLScrollFrameScrollBar:Point("BOTTOMLEFT", ATSWSLScrollFrame, "BOTTOMRIGHT", 5, 22)

	ATSWShoppingListFrame.SetPoint = function(self)
		ATSWSLCloseButton.SetPoint(ATSWShoppingListFrame, "TOPLEFT", AuctionFrame, "TOPLEFT", 355, -446)
	end

	-- ChatLink fix
	ATSWTradeSkillLinkButton:SetScript("OnClick", function()
		local ChatFrameEditBox = ChatEdit_ChooseBoxForSend()
		if not ChatFrameEditBox:IsShown() then
			ChatEdit_ActivateChat(ChatFrameEditBox)
		end

		ChatFrameEditBox:Insert(GetTradeSkillListLink())
	end)
end)