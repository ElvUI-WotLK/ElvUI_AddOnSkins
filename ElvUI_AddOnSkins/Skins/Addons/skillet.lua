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

if not AS:IsAddonLODorEnabled("Skillet") then return end

local _G = _G
local unpack = unpack

local GetTradeSkillListLink = GetTradeSkillListLink

-- Skillet 1.13 r167
-- https://www.wowace.com/projects/skillet/files/438510

S:AddCallbackForAddon("Skillet", "Skillet", function()
	if not E.private.addOnSkins.Skillet then return end

	SkinControl("HandleCloseButton", SkilletFrameCloseButton, SkilletFrame)

	SkinControl("HandleDropDownBox", SkilletSortDropdown)

	SkinControl("HandleEditBox", SkilletFilterBox)

	SkinControl("HandleCheckBox", SkilletHideUncraftableRecipes)
	SkilletHideUncraftableRecipes.backdrop:SetFrameLevel(SkilletHideUncraftableRecipes:GetFrameLevel())

	SkinControl("HandleCheckBox", SkilletHideTrivialRecipes)
	SkilletHideTrivialRecipes.backdrop:SetFrameLevel(SkilletHideTrivialRecipes:GetFrameLevel())

	SkinFrame(SkilletRankFrameBorder, "Hide")
	SkinFrame(SkilletRankFrame, "Point", "TOPRIGHT", -9, -32)
	SkinControl("HandleStatusBar", SkilletRankFrame, {0.2, 0.2, 1})

	SkinControl("HandleButton", SkilletRescanButton)
	SkinControl("HandleButton", SkilletShowOptionsButton)
	SkinControl("HandleButton", SkilletRecipeNotesButton)
	SkinControl("HandleButton", SkilletQueueAllButton)
	SkinControl("HandleButton", SkilletCreateAllButton)
	SkinControl("HandleButton", SkilletQueueButton)
	SkinControl("HandleButton", SkilletCreateButton)

	SkinControl("HandleEditBox", SkilletItemCountInputBox)
	SkinControl("HandleSliderFrame", SkilletCreateCountSlider)

	SkinFrame(SkilletShowOptionsButton, "Point", "TOPRIGHT", SkilletRankFrame, "BOTTOMRIGHT", 1, -4)
	SkinFrame(SkilletRescanButton, "Point", "RIGHT", SkilletShowOptionsButton, "LEFT", -3, 0)

	SkinFrame(SkilletSkillListParent, "Point", "TOPLEFT", 8, -100)
	SkinFrame(SkilletSkillListParent, "Point", "BOTTOM", 0, 8)

	SkinControl("HandleScrollBar", SkilletSkillListScrollBar)
	SkinFrame(SkilletSkillListScrollBar, "Point", "TOPLEFT", SkilletSkillList, "TOPRIGHT", 7, -16)
	SkinFrame(SkilletSkillListScrollBar, "Point", "BOTTOMLEFT", SkilletSkillList, "BOTTOMRIGHT", 7, 16)

	SkinFrame(SkilletReagentParent, "Point", "TOPRIGHT", -8, -75)

	SkinControl("HandleScrollBar", SkilletQueueListScrollBar)
	SkinFrame(SkilletQueueListScrollBar, "Point", "TOPLEFT", SkilletQueueList, "TOPRIGHT", 7, -16)
	SkinFrame(SkilletQueueListScrollBar, "Point", "BOTTOMLEFT", SkilletQueueList, "BOTTOMRIGHT", 7, 16)

	SkinFrame(SkilletQueueParent, "Point", "BOTTOMRIGHT", -8, 31)

	SkinControl("HandleScrollBar", SkilletNotesListScrollBar)
	SkinFrame(SkilletNotesListScrollBar, "Point", "TOPLEFT", SkilletNotesList, "TOPRIGHT", 7, -16)
	SkinFrame(SkilletNotesListScrollBar, "Point", "BOTTOMLEFT", SkilletNotesList, "BOTTOMRIGHT", 7, 16)

	SkinControl("HandleButton", SkilletStartQueueButton)
	SkinControl("HandleButton", SkilletEmptyQueueButton)
	SkinControl("HandleButton", SkilletShoppingListButton)

	SkinFrame(SkilletEmptyQueueButton, "ClearAllPoints")
	SkinFrame(SkilletEmptyQueueButton, "Point", "LEFT", SkilletStartQueueButton, "RIGHT", 1, 0)
	SkinFrame(SkilletEmptyQueueButton, "Point", "RIGHT", SkilletShoppingListButton, "LEFT", -1, 0)

	E:GetModule("Tooltip"):SecureHookScript(SkilletTradeskillTooltip, "OnShow", "SetStyle")

	S:SecureHook(Skillet, "CreateTradeSkillWindow", function(self)
		SkinFrame(SkilletFrame, "StripTextures")
		SkinFrame(SkilletFrame, "SetTemplate", "Transparent")

		SkinFrame(SkilletSkillListParent, "SetTemplate", "Transparent")
		SkinFrame(SkilletReagentParent, "SetTemplate", "Transparent")
		SkinFrame(SkilletQueueParent, "SetTemplate", "Transparent")
		SkinFrame(SkilletRecipeNotesFrame, "SetTemplate", "Transparent")

		SkinFrame(SkilletFrame_SizerSoutheast, "Size", 20)
		SkinFrame(SkilletFrame_SizerSoutheast, "SetScale", 0.7)

		S:Unhook(self, "CreateTradeSkillWindow")
	end)

	local scrollButtons = 0
	hooksecurefunc(Skillet, "internal_UpdateTradeSkillWindow", function(self)
		if not self.currentTrade or self.currentTrade == "UNKNOWN" then return end

		local i = scrollButtons + 1
		local button = _G["SkilletScrollButton"..i]
		while button do
			SkinControl("HandleCollapseExpandButton", button)
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
			SkinControl("HandleButton", button)
			i = i + 1
			button = _G["SkilletQueueButton"..i.."DeleteButton"]
		end
		deleteButtons = i - 1
	end)

	-- Fix TradeSkill Link
	SkinFrame(SkilletTradeSkillLinkButton, "SetScript", "OnClick", function()
		local ChatFrameEditBox = ChatEdit_ChooseBoxForSend()
		if not ChatFrameEditBox:IsShown() then
			ChatEdit_ActivateChat(ChatFrameEditBox)
		end

		ChatFrameEditBox:Insert(GetTradeSkillListLink())
	end)

	-- Notes Window
	SkinControl("HandleCloseButton", SkilletNotesCloseButton, SkilletRecipeNotesFrame)

	for i = 1, 7 do
		local icon = _G["SkilletNotesButton"..i.."Icon"]
		SkinFrame(icon, "SetTemplate", "Default")
		SkinFrame(icon, "SetNormalTexture", "")
		icon:GetNormalTexture():SetInside()

		local note = _G["SkilletNotesButton"..i.."Notes"]
		SkinFrame(note, "Point", "TOPLEFT", 1, -25)
		SkinFrame(note, "Height", 22)
	end

	hooksecurefunc(Skillet, "UpdateNotesWindow", function()
		for i = 1, 7 do
			local icon = _G["SkilletNotesButton"..i.."Icon"]:GetNormalTexture()
			if icon then
				SkinFrame(icon, "SetTexCoord", unpack(E.TexCoords))
			end
		end
	end)

	S:SecureHook(Skillet, "RecipeNote_OnClick", function(self, button)
		for _, child in ipairs({button:GetChildren()}) do
			if child:GetObjectType() == "EditBox" then
				SkinFrame(child, "SetTemplate", "Default")
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

		SkinFrame(titlebar1, "Point", "TOPLEFT", self.frame, "TOPLEFT", 4, -4)
		SkinFrame(titlebar1, "Point", "TOPRIGHT", self.frame, "TOPRIGHT", -4, -4)

		SkinControl("HandleCloseButton", SkilletShoppingListCloseButton)
		SkinFrame(SkilletShoppingListCloseButton, "SetPoint", "TOPRIGHT", 0, 0)

		SkinFrame(SkilletShoppingListParent, "SetTemplate", "Transparent")
		SkinFrame(SkilletShoppingListParent, "Point", "TOPLEFT", 4, -33)
		SkinFrame(SkilletShoppingListParent, "Point", "BOTTOMRIGHT", -4, 32)

		SkinControl("HandleScrollBar", SkilletShoppingListListScrollBar)

		SkinFrame(SkilletShoppingListListScrollBar, "Point", "TOPLEFT", SkilletShoppingListList, "TOPRIGHT", 7, -16)
		SkinFrame(SkilletShoppingListListScrollBar, "Point", "BOTTOMLEFT", SkilletShoppingListList, "BOTTOMRIGHT", 7, 16)

		SkinControl("HandleCheckBox", SkilletShowQueuesFromAllAlts)

		S:Unhook(self, "internal_DisplayShoppingList")
	end)

	-- Merchant Popup
	SkinFrame(SkilletMerchantBuyFrame, "SetTemplate", "Transparent")
	SkinFrame(SkilletMerchantBuyFrame, "Width", 341)
	SkinFrame(SkilletMerchantBuyFrame, "Point", "TOPLEFT", MerchantFrame, "TOPLEFT", 11, 37)
	SkilletMerchantBuyFrame.SetPoint = E.noop
	SkinControl("HandleButton", SkilletMerchantBuyFrameButton)

	-- Inventory Information
	S:SecureHook(Skillet, "ShowInventoryInfoPopup", function()
		if SkilletInfoBoxFrame then
			SkinFrame(SkilletInfoBoxFrame, "SetTemplate", "Transparent")
			SkinControl("HandleButton", SkilletInfoBoxFrameButton)
		end

		S:Unhook(Skillet, "ShowInventoryInfoPopup")
	end)

	AS:SkinLibrary("AceAddon-2.0")
	AS:SkinLibrary("Waterfall-1.0")
end)
