local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

if not AS:IsAddonLODorEnabled("Skillet") then return end

local _G = _G
local unpack = unpack

local GetTradeSkillListLink = GetTradeSkillListLink

-- Skillet 1.13 r167
-- https://www.wowace.com/projects/skillet/files/438510

S:AddCallbackForAddon("Skillet", "Skillet", function()
	if not E.private.addOnSkins.Skillet then return end

	S:HandleCloseButton(SkilletFrameCloseButton, SkilletFrame)

	S:HandleDropDownBox(SkilletSortDropdown)

	S:HandleEditBox(SkilletFilterBox)

	S:HandleCheckBox(SkilletHideUncraftableRecipes)
	SkilletHideUncraftableRecipes.backdrop:SetFrameLevel(SkilletHideUncraftableRecipes:GetFrameLevel())

	S:HandleCheckBox(SkilletHideTrivialRecipes)
	SkilletHideTrivialRecipes.backdrop:SetFrameLevel(SkilletHideTrivialRecipes:GetFrameLevel())

	SkilletRankFrameBorder:Hide()
	SkilletRankFrame:Point("TOPRIGHT", -9, -32)
	S:HandleStatusBar(SkilletRankFrame, {0.2, 0.2, 1})

	S:HandleButton(SkilletRescanButton)
	S:HandleButton(SkilletShowOptionsButton)
	S:HandleButton(SkilletRecipeNotesButton)
	S:HandleButton(SkilletQueueAllButton)
	S:HandleButton(SkilletCreateAllButton)
	S:HandleButton(SkilletQueueButton)
	S:HandleButton(SkilletCreateButton)

	S:HandleEditBox(SkilletItemCountInputBox)
	S:HandleSliderFrame(SkilletCreateCountSlider)

	SkilletShowOptionsButton:Point("TOPRIGHT", SkilletRankFrame, "BOTTOMRIGHT", 1, -4)
	SkilletRescanButton:Point("RIGHT", SkilletShowOptionsButton, "LEFT", -3, 0)

	SkilletSkillListParent:Point("TOPLEFT", 8, -100)
	SkilletSkillListParent:Point("BOTTOM", 0, 8)

	S:HandleScrollBar(SkilletSkillListScrollBar)
	SkilletSkillListScrollBar:Point("TOPLEFT", SkilletSkillList, "TOPRIGHT", 7, -16)
	SkilletSkillListScrollBar:Point("BOTTOMLEFT", SkilletSkillList, "BOTTOMRIGHT", 7, 16)

	SkilletReagentParent:Point("TOPRIGHT", -8, -75)

	S:HandleScrollBar(SkilletQueueListScrollBar)
	SkilletQueueListScrollBar:Point("TOPLEFT", SkilletQueueList, "TOPRIGHT", 7, -16)
	SkilletQueueListScrollBar:Point("BOTTOMLEFT", SkilletQueueList, "BOTTOMRIGHT", 7, 16)

	SkilletQueueParent:Point("BOTTOMRIGHT", -8, 31)

	S:HandleScrollBar(SkilletNotesListScrollBar)
	SkilletNotesListScrollBar:Point("TOPLEFT", SkilletNotesList, "TOPRIGHT", 7, -16)
	SkilletNotesListScrollBar:Point("BOTTOMLEFT", SkilletNotesList, "BOTTOMRIGHT", 7, 16)

	S:HandleButton(SkilletStartQueueButton)
	S:HandleButton(SkilletEmptyQueueButton)
	S:HandleButton(SkilletShoppingListButton)

	SkilletEmptyQueueButton:ClearAllPoints()
	SkilletEmptyQueueButton:Point("LEFT", SkilletStartQueueButton, "RIGHT", 1, 0)
	SkilletEmptyQueueButton:Point("RIGHT", SkilletShoppingListButton, "LEFT", -1, 0)

	E:GetModule("Tooltip"):SecureHookScript(SkilletTradeskillTooltip, "OnShow", "SetStyle")

	S:SecureHook(Skillet, "CreateTradeSkillWindow", function(self)
		SkilletFrame:StripTextures()
		SkilletFrame:SetTemplate("Transparent")

		SkilletSkillListParent:SetTemplate("Transparent")
		SkilletReagentParent:SetTemplate("Transparent")
		SkilletQueueParent:SetTemplate("Transparent")
		SkilletRecipeNotesFrame:SetTemplate("Transparent")

		SkilletFrame_SizerSoutheast:Size(20)
		SkilletFrame_SizerSoutheast:SetScale(0.7)

		S:Unhook(self, "CreateTradeSkillWindow")
	end)

	local scrollButtons = 0
	hooksecurefunc(Skillet, "internal_UpdateTradeSkillWindow", function(self)
		if not self.currentTrade or self.currentTrade == "UNKNOWN" then return end

		local i = scrollButtons + 1
		local button = _G["SkilletScrollButton"..i]
		while button do
			S:HandleCollapseExpandButton(button)
			i = i + 1
			button = _G["SkilletScrollButton"..i]
		end
		scrollButtons = i - 1
	end)

	local deleteButtons = 0
	hooksecurefunc(Skillet, "UpdateQueueWindow", function(self)
		if not self.stitch:GetQueueInfo() then return end

		local i = deleteButtons + 1
		local button = _G["SkilletQueueButton"..i.."DeleteButton"]
		while button do
			S:HandleButton(button)
			i = i + 1
			button = _G["SkilletQueueButton"..i.."DeleteButton"]
		end
		deleteButtons = i - 1
	end)

	-- Fix TradeSkill Link
	SkilletTradeSkillLinkButton:SetScript("OnClick", function()
		local ChatFrameEditBox = ChatEdit_ChooseBoxForSend()
		if not ChatFrameEditBox:IsShown() then
			ChatEdit_ActivateChat(ChatFrameEditBox)
		end

		ChatFrameEditBox:Insert(GetTradeSkillListLink())
	end)

	-- Notes Window
	S:HandleCloseButton(SkilletNotesCloseButton, SkilletRecipeNotesFrame)

	for i = 1, 7 do
		local icon = _G["SkilletNotesButton"..i.."Icon"]
		icon:SetTemplate("Default")
		icon:SetNormalTexture("")
		icon:GetNormalTexture():SetInside()

		local note = _G["SkilletNotesButton"..i.."Notes"]
		note:Point("TOPLEFT", 1, -25)
		note:Height(22)
	end

	hooksecurefunc(Skillet, "UpdateNotesWindow", function()
		for i = 1, 7 do
			local icon = _G["SkilletNotesButton"..i.."Icon"]:GetNormalTexture()
			if icon then
				icon:SetTexCoord(unpack(E.TexCoords))
			end
		end
	end)

	S:SecureHook(Skillet, "RecipeNote_OnClick", function(self, button)
		for _, child in ipairs({button:GetChildren()}) do
			if child:GetObjectType() == "EditBox" then
				child:SetTemplate("Default")
				break
			end
		end

		S:Unhook(self, "RecipeNote_OnClick")
	end)

	-- Shopping List
	S:SecureHook(Skillet, "internal_DisplayShoppingList", function(self)
		self.shoppingList:SetTemplate("Transparent")

		local titlebar1, titlebar2 = self.shoppingList:GetRegions()
		titlebar1:SetDrawLayer("ARTWORK")
		titlebar2:SetDrawLayer("ARTWORK")

		titlebar1:Point("TOPLEFT", self.frame, "TOPLEFT", 4, -4)
		titlebar1:Point("TOPRIGHT", self.frame, "TOPRIGHT", -4, -4)

		S:HandleCloseButton(SkilletShoppingListCloseButton)
		SkilletShoppingListCloseButton:SetPoint("TOPRIGHT", 0, 0)

		SkilletShoppingListParent:SetTemplate("Transparent")
		SkilletShoppingListParent:Point("TOPLEFT", 4, -33)
		SkilletShoppingListParent:Point("BOTTOMRIGHT", -4, 32)

		S:HandleScrollBar(SkilletShoppingListListScrollBar)

		SkilletShoppingListListScrollBar:Point("TOPLEFT", SkilletShoppingListList, "TOPRIGHT", 7, -16)
		SkilletShoppingListListScrollBar:Point("BOTTOMLEFT", SkilletShoppingListList, "BOTTOMRIGHT", 7, 16)

		S:HandleCheckBox(SkilletShowQueuesFromAllAlts)

		S:Unhook(self, "internal_DisplayShoppingList")
	end)

	-- Merchant Popup
	SkilletMerchantBuyFrame:SetTemplate("Transparent")
	SkilletMerchantBuyFrame:Width(341)
	SkilletMerchantBuyFrame:Point("TOPLEFT", MerchantFrame, "TOPLEFT", 11, 37)
	SkilletMerchantBuyFrame.SetPoint = E.noop
	S:HandleButton(SkilletMerchantBuyFrameButton)

	-- Inventory Information
	S:SecureHook(Skillet, "ShowInventoryInfoPopup", function()
		if SkilletInfoBoxFrame then
			SkilletInfoBoxFrame:SetTemplate("Transparent")
			S:HandleButton(SkilletInfoBoxFrameButton)
		end

		S:Unhook(Skillet, "ShowInventoryInfoPopup")
	end)

	AS:SkinLibrary("AceAddon-2.0")
	AS:SkinLibrary("Waterfall-1.0")
end)