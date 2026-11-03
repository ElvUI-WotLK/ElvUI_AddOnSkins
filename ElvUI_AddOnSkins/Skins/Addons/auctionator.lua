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

if not AS:IsAddonLODorEnabled("Auctionator") then return end

local _G = _G
local type = type
local unpack = unpack

local GetItemIcon = GetItemIcon
local GetItemInfo = GetItemInfo
local GetItemQualityColor = GetItemQualityColor

-- Auctionator 2.6.3
-- https://www.curseforge.com/wow/addons/auctionator/files/426882

S:AddCallbackForAddon("Auctionator", "Auctionator", function()
	if not E.private.addOnSkins.Auctionator then return end

	-- Error Frame
	SkinFrame(Atr_Error_Frame, "SetTemplate", "Transparent")
	SkinControl("HandleButton", (Atr_Error_Frame:GetChildren()))

	-- BuyConfirm Frame
	SkinFrame(Atr_Buy_Confirm_Frame, "SetTemplate", "Transparent")

	SkinControl("HandleEditBox", Atr_Buy_Confirm_Numstacks)

	SkinControl("HandleButton", Atr_Buy_Confirm_OKBut)
	SkinControl("HandleButton", Atr_Buy_Confirm_CancelBut)

	-- Advanced Search
	SkinFrame(Atr_Adv_Search_Dialog, "StripTextures")
	SkinFrame(Atr_Adv_Search_Dialog, "SetTemplate", "Transparent")
	SkinFrame(Atr_Adv_Search_Dialog, "Point", "TOPLEFT", 215, -183)

	SkinControl("HandleEditBox", Atr_AS_Searchtext)
	SkinControl("HandleEditBox", Atr_AS_Minlevel)
	SkinControl("HandleEditBox", Atr_AS_Maxlevel)

	SkinControl("HandleDropDownBox", Atr_ASDD_Class, 180)
	SkinControl("HandleDropDownBox", Atr_ASDD_Subclass, 180)

	SkinControl("HandleButton", Atr_Adv_Search_ResetBut)
	SkinControl("HandleButton", Atr_Adv_Search_OKBut)
	SkinControl("HandleButton", Atr_Adv_Search_CancelBut)

	hooksecurefunc("Atr_FullScanAnalyze", function()
		SkinFrame(Atr_FullScanResults, "SetBackdropColor", unpack(E.media.backdropfadecolor))
	end)

	-- Full Scan
	SkinFrame(Atr_FullScanFrame, "StripTextures")
	SkinFrame(Atr_FullScanFrame, "SetTemplate", "Transparent")
	SkinFrame(Atr_FullScanFrame, "Height", 424)
	SkinFrame(Atr_FullScanFrame, "Point", "TOPLEFT", 215, -116)

	SkinFrame(Atr_FullScanResults, "SetTemplate", "Transparent")

	SkinControl("HandleButton", Atr_FullScanStartButton)
	SkinControl("HandleButton", Atr_FullScanDone)

	hooksecurefunc("Atr_ShowFullScanFrame", function()
		SkinFrame(Atr_FullScanFrame, "SetBackdropColor", unpack(E.media.backdropfadecolor))
	end)

	-- Check Actives
	SkinFrame(Atr_CheckActives_Frame, "StripTextures")
	SkinFrame(Atr_CheckActives_Frame, "SetTemplate", "Transparent")

	local checkActivesButton1, checkActivesButton2 = Atr_CheckActives_Frame:GetChildren()
	SkinControl("HandleButton", checkActivesButton1)
	SkinControl("HandleButton", checkActivesButton2)

	-- Confirm Frame
	SkinFrame(Atr_Confirm_Frame, "SetTemplate", "Transparent")
	SkinControl("HandleButton", Atr_Confirm_Cancel)
	SkinControl("HandleButton", (select(2, Atr_Confirm_Frame:GetChildren())))

	local SELL_TAB = 1
	local BUY_TAB = 3
	hooksecurefunc("Atr_AuctionFrameTab_OnClick", function(self, index, down)
		if not index or type(index) == "string" then
			index = self:GetID()
		end

		if Atr_IsAuctionatorTab(index) then
			if index == Atr_FindTabIndex(BUY_TAB) then
				SkinFrame(Atr_Hlist, "Height", Atr_SrchSListButton and 220 or 242)
				SkinFrame(Atr_Hlist_ScrollFrame, "Height", Atr_SrchSListButton and 220 or 242)
			else
				SkinFrame(Atr_Hlist, "Height", 330)
				SkinFrame(Atr_Hlist_ScrollFrame, "Height", 330)

				if index == Atr_FindTabIndex(SELL_TAB) then
					Atr_Hlist_ScrollFrame:_Hide()
					SkinFrame(AuctionFrameMoneyFrame, "Show")
				end
			end
		end
	end)

	hooksecurefunc("Atr_SetTextureButton", function(elementName, count, itemlink)
		local button = _G[elementName]
		local buttonName = _G[elementName.."Name"]

		if GetItemIcon(itemlink) then
			local _, _, quality = GetItemInfo(itemlink)
			if quality then
				local r, g, b = GetItemQualityColor(quality)

				SkinFrame(button, "SetBackdropBorderColor", r, g, b)
				if buttonName then
					SkinFrame(buttonName, "SetTextColor", r, g, b)
				end
			else
				SkinFrame(button, "SetBackdropBorderColor", unpack(E.media.bordercolor))
				if buttonName then
					SkinFrame(buttonName, "SetTextColor", 1, 0.82, 0)
				end
			end
		else
			SkinFrame(button, "SetBackdropBorderColor", unpack(E.media.bordercolor))
			if buttonName then
				SkinFrame(buttonName, "SetTextColor", 1, 0.82, 0)
			end
		end
	end)

	local function itemButtomSetNormalTexture(self, texture)
		self.normalTexture:SetTexture(texture)
	end
	local function skinItemButtom(frame)
		SkinFrame(frame, "StripTextures")
		SkinFrame(frame, "SetTemplate", "Default", true)
		SkinFrame(frame, "StyleButton", nil, true)

		SkinFrame(frame, "SetNormalTexture", "")
		frame.normalTexture = frame:GetNormalTexture()
		frame.normalTexture:SetTexCoord(unpack(E.TexCoords))
		frame.normalTexture:SetInside()
		frame.SetNormalTexture = itemButtomSetNormalTexture
	end

	local function skinButtonHighlight(button)
		local highlight = button:GetHighlightTexture()
		SkinFrame(highlight, "SetTexCoord", 0, 1, 0, 1)
		highlight:SetTexture(E.Media.Textures.Highlight)
		highlight:SetVertexColor(0.9, 0.9, 0.9, 0.35)

		local pushed = button:GetPushedTexture()
		SkinFrame(pushed, "SetTexCoord", 0, 1, 0, 1)
		pushed:SetTexture(E.Media.Textures.Highlight)
		pushed:SetVertexColor(0.9, 0.9, 0.9, 0.35)
	end

	S:SecureHook("Atr_Init", function()
		S:Unhook("Atr_Init")

		if not E.private.skins.blizzard.enable or not E.private.skins.blizzard.auctionhouse then
			for i = AuctionFrame.numTabs - 2, AuctionFrame.numTabs do
				local tab = _G["AuctionFrameTab"..i]
				SkinControl("HandleTab", tab)
				SkinFrame(tab, "Point", "LEFT", _G["AuctionFrameTab"..(i - 1)], "RIGHT", -15, 0)
			end
		end

		SkinFrame(Atr_Main_Panel, "Size", 412, 424)

		SkinFrame(Atr_Mask, "Size", 819, 422)
		SkinFrame(Atr_Mask, "Point", "TOPLEFT", 12, -117)

		SkinFrame(AuctionatorTitle, "Point", "TOP", 0, -5)

		SkinControl("HandleButton", Atr_FullScanButton)
		SkinFrame(Atr_FullScanButton, "Height", 22)
		SkinFrame(Atr_FullScanButton, "Point", "RIGHT", Auctionator1Button, "LEFT", -5, 0)

		SkinControl("HandleButton", Auctionator1Button)
		SkinFrame(Auctionator1Button, "Height", 22)
		SkinFrame(Auctionator1Button, "Point", "LEFT", Atr_Search_Button, "RIGHT", 177, 0)

		SkinControl("HandleButton", AuctionatorCloseButton)
		SkinControl("HandleButton", Atr_CancelSelectionButton)
		SkinControl("HandleButton", Atr_Buy1_Button)

		SkinFrame(AuctionatorCloseButton, "Point", "BOTTOMRIGHT", 202, 8)
		SkinFrame(Atr_Buy1_Button, "Point", "RIGHT", AuctionatorCloseButton, "LEFT", -5, 0)
		SkinFrame(Atr_CancelSelectionButton, "Point", "RIGHT", Atr_Buy1_Button, "LEFT", -5, 0)

		-- Left panel
		SkinFrame(Atr_Hlist, "StripTextures")
		SkinFrame(Atr_Hlist, "SetTemplate", "Transparent")
		SkinFrame(Atr_Hlist, "Width", 172)
		SkinFrame(Atr_Hlist, "Point", "TOPLEFT", -191, -57)

		SkinFrame(Atr_Hlist_ScrollFrame, "Width", 172)
		SkinFrame(Atr_Hlist_ScrollFrame, "Point", "TOPLEFT", -191, -57)
		Atr_Hlist_ScrollFrame._Hide = Atr_Hlist_ScrollFrame.Hide
		Atr_Hlist_ScrollFrame.Hide = E.noop

		SkinControl("HandleScrollBar", Atr_Hlist_ScrollFrameScrollBar)
		SkinFrame(Atr_Hlist_ScrollFrameScrollBar, "Point", "TOPLEFT", Atr_Hlist_ScrollFrame, "TOPRIGHT", 3, -19)
		SkinFrame(Atr_Hlist_ScrollFrameScrollBar, "Point", "BOTTOMLEFT", Atr_Hlist_ScrollFrame, "BOTTOMRIGHT", 3, 19)

		for i = 1, 20 do -- ITEM_HIST_NUM_LINES
			local button = _G["AuctionatorHEntry"..i]

			SkinFrame(button, "Width", 170)
			skinButtonHighlight(button)

			SkinFrame(_G["AuctionatorHEntry"..i.."_EntryText"], "Width", 168)

			if i == 1 then
				SkinFrame(button, "Point", "TOPLEFT", 1, -1)
			else
				SkinFrame(button, "Point", "TOPLEFT", 1, -1 - (i - 1) * 16)
			end
		end

		-- Right panel
		SkinFrame(Atr_Hilite1, "SetTemplate", "Transparent", nil, true)
		SkinFrame(Atr_Hilite1, "SetBackdropColor", 0, 0, 0, 0)
		SkinFrame(Atr_Hilite1, "Height", 112)
		SkinFrame(Atr_Hilite1, "ClearAllPoints")
		SkinFrame(Atr_Hilite1, "Point", "TOPLEFT", 5, -57)
		SkinFrame(Atr_Hilite1, "Point", "RIGHT", 202, 0)

		skinItemButtom(Atr_RecommendItem_Tex)

		SkinFrame(AuctionatorMessageFrame, "Point", "TOP", 100, -65)
		SkinFrame(AuctionatorMessage2Frame, "Point", "TOP", 100, -55)

		for i = 1, 3 do
			local tab = _G["Atr_ListTabsTab"..i]
			SkinFrame(tab, "StripTextures")
			SkinControl("HandleButton", tab)
			SkinFrame(tab, "Height", 22)

			if i ~= 3 then
				SkinFrame(tab, "Point", "RIGHT", _G["Atr_ListTabsTab"..(i + 1)], "LEFT", -3, 0)
			end
		end

		SkinFrame(Atr_HeadingsBar, "StripTextures")
		SkinFrame(Atr_HeadingsBar, "Point", "TOPLEFT", 6, -152)
		Atr_HeadingsBar:CreateBackdrop("Transparent")
		Atr_HeadingsBar.backdrop:Point("TOPLEFT", -1, -41)
		Atr_HeadingsBar.backdrop:Point("BOTTOMRIGHT", 3, -171)

		SkinFrame(Atr_ListTabs, "Point", "BOTTOMRIGHT", Atr_HeadingsBar, "TOPRIGHT", 11, -22)

		SkinFrame(AuctionatorScrollFrame, "Height", 194)
		SkinFrame(AuctionatorScrollFrame, "Point", "TOPLEFT", 5, -193)

		SkinControl("HandleScrollBar", AuctionatorScrollFrameScrollBar)
		SkinFrame(AuctionatorScrollFrameScrollBar, "Point", "TOPLEFT", AuctionatorScrollFrame, "TOPRIGHT", 3, -19)
		SkinFrame(AuctionatorScrollFrameScrollBar, "Point", "BOTTOMLEFT", AuctionatorScrollFrame, "BOTTOMRIGHT", 3, 19)

		for _, tab in ipairs({Atr_Col1_Heading_Button, Atr_Col3_Heading_Button}) do
			SkinFrame(tab, "StripTextures")
			SkinFrame(tab, "SetNormalTexture", [[Interface\Buttons\UI-SortArrow]])
			SkinFrame(tab, "StyleButton")
		end

		SkinFrame(AuctionatorEntry1, "Point", "TOPLEFT", AuctionatorScrollFrame, "TOPLEFT", 1, -1)

		for i = 1, 12 do
			local button = _G["AuctionatorEntry"..i]
			SkinFrame(button, "Width", 586)
			skinButtonHighlight(button)
		end

		SkinFrame(AuctionatorScrollFrame, "HookScript", "OnShow", function(self)
			Atr_HeadingsBar.backdrop:Point("BOTTOMRIGHT", -18, -171)
		end)
		SkinFrame(AuctionatorScrollFrame, "HookScript", "OnHide", function(self)
			Atr_HeadingsBar.backdrop:Point("BOTTOMRIGHT", 3, -171)
		end)

		-- Buy tab
		SkinControl("HandleDropDownBox", Atr_DropDownSL, 221)
		SkinFrame(Atr_DropDownSL, "Point", "TOPLEFT", -211, -29)

		SkinControl("HandleEditBox", Atr_Search_Box)
		SkinControl("HandleButton", Atr_Search_Button)
		SkinControl("HandleButton", Atr_Adv_Search_Button)

		SkinFrame(Atr_Search_Box, "Point", "TOPLEFT", 20, -32)
		SkinFrame(Atr_Search_Button, "Point", "LEFT", Atr_Search_Box, "RIGHT", 6, 0)

		SkinFrame(Atr_Adv_Search_Button, "Height", 22)
		SkinFrame(Atr_Adv_Search_Button, "Point", "LEFT", Atr_Search_Button, "RIGHT", 5, 0)

		SkinControl("HandleButton", Atr_AddToSListButton)
		SkinFrame(Atr_AddToSListButton, "Width", 193)
		SkinFrame(Atr_AddToSListButton, "Point", "TOPLEFT", -191, -304)

		SkinControl("HandleButton", Atr_RemFromSListButton)
		SkinFrame(Atr_RemFromSListButton, "Width", 193)
		SkinFrame(Atr_RemFromSListButton, "Point", "TOPLEFT", -191, -325)

		SkinControl("HandleButton", Atr_DelSListButton)
		SkinFrame(Atr_DelSListButton, "Width", 193)
		SkinFrame(Atr_DelSListButton, "Point", "TOPLEFT", -191, -346)

		SkinControl("HandleButton", Atr_NewSListButton)
		SkinFrame(Atr_NewSListButton, "Width", 193)
		SkinFrame(Atr_NewSListButton, "Point", "TOPLEFT", -191, -367)

		if Atr_SrchSListButton and Atr_MngSListsButton then
			local shoppingButtons = {Atr_AddToSListButton, Atr_RemFromSListButton,
				Atr_SrchSListButton, Atr_MngSListsButton, Atr_NewSListButton}
			for i, button in ipairs(shoppingButtons) do
				SkinControl("HandleButton", button)
				button:ClearAllPoints()
				button:Size(193, 20)
				button:Point("TOPLEFT", Atr_Main_Panel, "TOPLEFT", -191, -282 - (i - 1) * 22)
			end
			SkinControl("HandleButton", Atr_SaveThisList_Button)
		end

		SkinControl("HandleButton", Atr_Back_Button)
		SkinFrame(Atr_Back_Button, "Height", 22)
		SkinFrame(Atr_Back_Button, "Point", "TOPLEFT", 7, 13)

		-- Sell tab
		SkinFrame(Atr_SellControls, "SetTemplate", "Transparent")
		SkinFrame(Atr_SellControls, "Size", 193, 330)
		SkinFrame(Atr_SellControls, "Point", "TOPLEFT", -191, -57)

		skinItemButtom(Atr_SellControls_Tex)
		SkinFrame(Atr_SellControls_Tex, "Point", "TOPLEFT", 11, -14)

		SkinFrame(Atr_StackPriceText, "Point", "TOPLEFT", 7, -56)
		SkinFrame(Atr_ItemPriceText, "Point", "TOPLEFT", 7, -96)

		SkinControl("HandleButton", Atr_CreateAuctionButton)
		SkinFrame(Atr_CreateAuctionButton, "Point", "TOPLEFT", 4, -139)

		SkinFrame(Atr_Batch_Stacksize_Text, "Point", "TOPLEFT", 55, -177)
		SkinFrame(Atr_Batch_NumAuctions, "Point", "TOPLEFT", Atr_Batch_Stacksize_Text, "TOPLEFT", -41, 0)

		SkinFrame(Atr_Batch_MaxAuctions_Text, "ClearAllPoints")
		SkinFrame(Atr_Batch_MaxAuctions_Text, "Point", "BOTTOM", Atr_Batch_NumAuctions, 0, -14)
		SkinFrame(Atr_Batch_MaxStacksize_Text, "ClearAllPoints")
		SkinFrame(Atr_Batch_MaxStacksize_Text, "Point", "BOTTOM", Atr_Batch_Stacksize, 0, -14)

		SkinFrame(Atr_StartingPriceText, "Point", "TOPLEFT", 13, -229)
		SkinFrame(Atr_StartingPriceDiscountText, "Point", "TOPLEFT", 10, -238)

		SkinFrame(Atr_Duration_Text, "Point", "TOPLEFT", 10, -276)
		Atr_Duration_Text.SetPoint = E.noop
		SkinControl("HandleDropDownBox", Atr_Duration, 130)

		SkinFrame(Atr_Deposit_Text, "Point", "TOPLEFT", 10, -304)
		-- Keep deposit text free of inline coin texture artifacts. Preserve
		-- Auctionator's calculated amount and multi-auction multiplier.
		local function formatDeposit()
			local text = Atr_Deposit_Text:GetText()
			if not text or text == "" then return end
			text = text:gsub("|TInterface\\MoneyFrame\\UI%-(%a+)Icon:[^|]*|t", function(coin)
				return ({Gold="g", Silver="s", Copper="c"})[coin] or ""
			end)
			text = text:gsub("%s+$", "")
			Atr_Deposit_Text:SetText(text.."|r")
		end
		hooksecurefunc("Atr_SetDepositText", formatDeposit)
		formatDeposit()


		SkinControl("HandleEditBox", Atr_StackPriceGold)
		SkinControl("HandleEditBox", Atr_StackPriceSilver)
		SkinControl("HandleEditBox", Atr_StackPriceCopper)
		SkinControl("HandleEditBox", Atr_ItemPriceGold)
		SkinControl("HandleEditBox", Atr_ItemPriceSilver)
		SkinControl("HandleEditBox", Atr_ItemPriceCopper)
		SkinControl("HandleEditBox", Atr_StartingPriceGold)
		SkinControl("HandleEditBox", Atr_StartingPriceSilver)
		SkinControl("HandleEditBox", Atr_StartingPriceCopper)
		SkinControl("HandleEditBox", Atr_Batch_NumAuctions)
		SkinControl("HandleEditBox", Atr_Batch_Stacksize)

		-- More tab
		SkinControl("HandleDropDownBox", Atr_DropDown1, 221)
		SkinFrame(Atr_DropDown1, "Point", "TOPLEFT", -211, -29)

		SkinControl("HandleButton", Atr_CheckActiveButton)
		SkinFrame(Atr_CheckActiveButton, "Size", 193, 22)
		SkinFrame(Atr_CheckActiveButton, "Point", "TOPLEFT", -191, -394)

		if Atr_CancelAllUndercutsButton then
			SkinControl("HandleButton", Atr_CancelAllUndercutsButton)
			SkinFrame(Atr_CancelAllUndercutsButton, "Height", 22)
			SkinFrame(Atr_CancelAllUndercutsButton, "Point", "TOPLEFT", 7, -394)
		end

		-- Auctionator+ changes both sizes on tab switches, completed searches,
		-- and clearing the sale. Replace its old anchors, then keep the real
		-- mouse target identical to the visible rectangle on every transition.
		if Atr_Hilite1_btn then
			local function syncDropArea()
				local selling = Atr_SellControls:IsShown()
				Atr_Hilite1:ClearAllPoints()
				Atr_Hilite1:Point("TOPLEFT", Atr_Main_Panel, "TOPLEFT", selling and 5 or -191, -57)
				Atr_Hilite1:Point("BOTTOMRIGHT", Atr_Main_Panel, "TOPLEFT", 614, selling and -169 or -387)
				Atr_Hilite1_btn:ClearAllPoints()
				Atr_Hilite1_btn:SetAllPoints(Atr_Hilite1)
			end
			hooksecurefunc(Atr_Hilite1, "SetSize", syncDropArea)
			hooksecurefunc(Atr_Hilite1_btn, "SetSize", syncDropArea)
			Atr_SellControls:HookScript("OnShow", syncDropArea)
			Atr_SellControls:HookScript("OnHide", syncDropArea)
			syncDropArea()
		end
	end)

	-- Config
	SkinFrame(Atr_BasicOptionsFrame, "SetTemplate", "Transparent")
	SkinFrame(Atr_TooltipsOptionsFrame, "SetTemplate", "Transparent")
	SkinFrame(Atr_UCConfigFrame, "SetTemplate", "Transparent")
	SkinFrame(Atr_StackingOptionsFrame, "SetTemplate", "Transparent")
	SkinFrame(Atr_ScanningOptionsFrame, "SetTemplate", "Transparent")
	SkinFrame(AuctionatorDescriptionFrame, "SetTemplate", "Transparent")

	SkinFrame(Atr_Stacking_List, "SetTemplate", "Transparent")

	SkinControl("HandleCheckBox", AuctionatorOption_Enable_Alt_CB)
	SkinControl("HandleCheckBox", AuctionatorOption_Open_All_Bags_CB)
	SkinControl("HandleCheckBox", AuctionatorOption_Show_StartingPrice_CB)
	SkinControl("HandleCheckBox", AuctionatorOption_Def_Duration_CB)
	SkinControl("HandleCheckBox", ATR_tipsVendorOpt_CB)
	SkinControl("HandleCheckBox", ATR_tipsAuctionOpt_CB)
	SkinControl("HandleCheckBox", ATR_tipsDisenchantOpt_CB)

	SkinControl("HandleDropDownBox", AuctionatorOption_Deftab)
	SkinControl("HandleDropDownBox", Atr_tipsShiftDD)
	SkinControl("HandleDropDownBox", Atr_deDetailsDD, 220)
	SkinControl("HandleDropDownBox", Atr_scanLevelDD)
	SkinFrame(Atr_deDetailsDDText, "SetJustifyH", "RIGHT")

	local moneyEditBoxes = {
		"UC_5000000_MoneyInput",
		"UC_1000000_MoneyInput",
		"UC_200000_MoneyInput",
		"UC_50000_MoneyInput",
		"UC_10000_MoneyInput",
		"UC_2000_MoneyInput",
		"UC_500_MoneyInput",
	}
	for _, name in ipairs(moneyEditBoxes) do
		SkinControl("HandleEditBox", _G[name.."Gold"])
		SkinControl("HandleEditBox", _G[name.."Silver"])
		SkinControl("HandleEditBox", _G[name.."Copper"])
	end
	SkinControl("HandleEditBox", Atr_Starting_Discount)

	SkinControl("HandleButton", Atr_UCConfigFrame_Reset)
	SkinControl("HandleButton", Atr_StackingOptionsFrame_Edit)
	SkinControl("HandleButton", Atr_StackingOptionsFrame_New)
end)
