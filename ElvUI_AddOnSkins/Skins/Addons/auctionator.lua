local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
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
	Atr_Error_Frame:SetTemplate("Transparent")
	S:HandleButton((Atr_Error_Frame:GetChildren()))

	-- BuyConfirm Frame
	Atr_Buy_Confirm_Frame:SetTemplate("Transparent")

	S:HandleEditBox(Atr_Buy_Confirm_Numstacks)

	S:HandleButton(Atr_Buy_Confirm_OKBut)
	S:HandleButton(Atr_Buy_Confirm_CancelBut)

	-- Advanced Search
	Atr_Adv_Search_Dialog:StripTextures()
	Atr_Adv_Search_Dialog:SetTemplate("Transparent")
	Atr_Adv_Search_Dialog:Point("TOPLEFT", 215, -183)

	S:HandleEditBox(Atr_AS_Searchtext)
	S:HandleEditBox(Atr_AS_Minlevel)
	S:HandleEditBox(Atr_AS_Maxlevel)

	S:HandleDropDownBox(Atr_ASDD_Class, 180)
	S:HandleDropDownBox(Atr_ASDD_Subclass, 180)

	S:HandleButton(Atr_Adv_Search_ResetBut)
	S:HandleButton(Atr_Adv_Search_OKBut)
	S:HandleButton(Atr_Adv_Search_CancelBut)

	hooksecurefunc("Atr_FullScanAnalyze", function()
		Atr_FullScanResults:SetBackdropColor(unpack(E.media.backdropfadecolor))
	end)

	-- Full Scan
	Atr_FullScanFrame:StripTextures()
	Atr_FullScanFrame:SetTemplate("Transparent")
	Atr_FullScanFrame:Height(424)
	Atr_FullScanFrame:Point("TOPLEFT", 215, -116)

	Atr_FullScanResults:SetTemplate("Transparent")

	S:HandleButton(Atr_FullScanStartButton)
	S:HandleButton(Atr_FullScanDone)

	hooksecurefunc("Atr_ShowFullScanFrame", function()
		Atr_FullScanFrame:SetBackdropColor(unpack(E.media.backdropfadecolor))
	end)

	-- Check Actives
	Atr_CheckActives_Frame:StripTextures()
	Atr_CheckActives_Frame:SetTemplate("Transparent")

	local checkActivesButton1, checkActivesButton2 = Atr_CheckActives_Frame:GetChildren()
	S:HandleButton(checkActivesButton1)
	S:HandleButton(checkActivesButton2)

	-- Confirm Frame
	Atr_Confirm_Frame:SetTemplate("Transparent")
	S:HandleButton(Atr_Confirm_Cancel)
	S:HandleButton((select(2, Atr_Confirm_Frame:GetChildren())))

	local SELL_TAB = 1
	local BUY_TAB = 3
	hooksecurefunc("Atr_AuctionFrameTab_OnClick", function(self, index, down)
		if not index or type(index) == "string" then
			index = self:GetID()
		end

		if Atr_IsAuctionatorTab(index) then
			if index == Atr_FindTabIndex(BUY_TAB) then
				Atr_Hlist:Height(242)
				Atr_Hlist_ScrollFrame:Height(242)
			else
				Atr_Hlist:Height(330)
				Atr_Hlist_ScrollFrame:Height(330)

				if index == Atr_FindTabIndex(SELL_TAB) then
					Atr_Hlist_ScrollFrame:_Hide()
					AuctionFrameMoneyFrame:Show()
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

				button:SetBackdropBorderColor(r, g, b)
				if buttonName then
					buttonName:SetTextColor(r, g, b)
				end
			else
				button:SetBackdropBorderColor(unpack(E.media.bordercolor))
				if buttonName then
					buttonName:SetTextColor(1, 0.82, 0)
				end
			end
		else
			button:SetBackdropBorderColor(unpack(E.media.bordercolor))
			if buttonName then
				buttonName:SetTextColor(1, 0.82, 0)
			end
		end
	end)

	local function itemButtomSetNormalTexture(self, texture)
		self.normalTexture:SetTexture(texture)
	end
	local function skinItemButtom(frame)
		frame:StripTextures()
		frame:SetTemplate("Default", true)
		frame:StyleButton(nil, true)

		frame:SetNormalTexture("")
		frame.normalTexture = frame:GetNormalTexture()
		frame.normalTexture:SetTexCoord(unpack(E.TexCoords))
		frame.normalTexture:SetInside()
		frame.SetNormalTexture = itemButtomSetNormalTexture
	end

	local function skinButtonHighlight(button)
		local highlight = button:GetHighlightTexture()
		highlight:SetTexCoord(0, 1, 0, 1)
		highlight:SetTexture(E.Media.Textures.Highlight)
		highlight:SetVertexColor(0.9, 0.9, 0.9, 0.35)

		local pushed = button:GetPushedTexture()
		pushed:SetTexCoord(0, 1, 0, 1)
		pushed:SetTexture(E.Media.Textures.Highlight)
		pushed:SetVertexColor(0.9, 0.9, 0.9, 0.35)
	end

	S:SecureHook("Atr_Init", function()
		S:Unhook("Atr_Init")

		if not E.private.skins.blizzard.enable or not E.private.skins.blizzard.auctionhouse then
			for i = AuctionFrame.numTabs - 2, AuctionFrame.numTabs do
				local tab = _G["AuctionFrameTab"..i]
				S:HandleTab(tab)
				tab:Point("LEFT", _G["AuctionFrameTab"..(i - 1)], "RIGHT", -15, 0)
			end
		end

		Atr_Main_Panel:Size(412, 424)

		Atr_Mask:Size(819, 422)
		Atr_Mask:Point("TOPLEFT", 12, -117)

		AuctionatorTitle:Point("TOP", 0, -5)

		S:HandleButton(Atr_FullScanButton)
		Atr_FullScanButton:Height(22)
		Atr_FullScanButton:Point("RIGHT", Auctionator1Button, "LEFT", -5, 0)

		S:HandleButton(Auctionator1Button)
		Auctionator1Button:Height(22)
		Auctionator1Button:Point("LEFT", Atr_Search_Button, "RIGHT", 177, 0)

		S:HandleButton(AuctionatorCloseButton)
		S:HandleButton(Atr_CancelSelectionButton)
		S:HandleButton(Atr_Buy1_Button)

		AuctionatorCloseButton:Point("BOTTOMRIGHT", 202, 8)
		Atr_Buy1_Button:Point("RIGHT", AuctionatorCloseButton, "LEFT", -5, 0)
		Atr_CancelSelectionButton:Point("RIGHT", Atr_Buy1_Button, "LEFT", -5, 0)

		-- Left panel
		Atr_Hlist:StripTextures()
		Atr_Hlist:SetTemplate("Transparent")
		Atr_Hlist:Width(172)
		Atr_Hlist:Point("TOPLEFT", -191, -57)

		Atr_Hlist_ScrollFrame:Width(172)
		Atr_Hlist_ScrollFrame:Point("TOPLEFT", -191, -57)
		Atr_Hlist_ScrollFrame._Hide = Atr_Hlist_ScrollFrame.Hide
		Atr_Hlist_ScrollFrame.Hide = E.noop

		S:HandleScrollBar(Atr_Hlist_ScrollFrameScrollBar)
		Atr_Hlist_ScrollFrameScrollBar:Point("TOPLEFT", Atr_Hlist_ScrollFrame, "TOPRIGHT", 3, -19)
		Atr_Hlist_ScrollFrameScrollBar:Point("BOTTOMLEFT", Atr_Hlist_ScrollFrame, "BOTTOMRIGHT", 3, 19)

		for i = 1, 20 do -- ITEM_HIST_NUM_LINES
			local button = _G["AuctionatorHEntry"..i]

			button:Width(170)
			skinButtonHighlight(button)

			_G["AuctionatorHEntry"..i.."_EntryText"]:Width(168)

			if i == 1 then
				button:Point("TOPLEFT", 1, -1)
			else
				button:Point("TOPLEFT", 1, -1 - (i - 1) * 16)
			end
		end

		-- Right panel
		Atr_Hilite1:SetTemplate("Transparent", nil, true)
		Atr_Hilite1:SetBackdropColor(0, 0, 0, 0)
		Atr_Hilite1:Height(112)
		Atr_Hilite1:Point("TOPLEFT", 5, -57)
		Atr_Hilite1:Point("RIGHT", 202, 0)

		skinItemButtom(Atr_RecommendItem_Tex)

		AuctionatorMessageFrame:Point("TOP", 100, -65)
		AuctionatorMessage2Frame:Point("TOP", 100, -55)

		for i = 1, 3 do
			local tab = _G["Atr_ListTabsTab"..i]
			tab:StripTextures()
			S:HandleButton(tab)
			tab:Height(22)

			if i ~= 3 then
				tab:Point("RIGHT", _G["Atr_ListTabsTab"..(i + 1)], "LEFT", -3, 0)
			end
		end

		Atr_HeadingsBar:StripTextures()
		Atr_HeadingsBar:Point("TOPLEFT", 6, -152)
		Atr_HeadingsBar:CreateBackdrop("Transparent")
		Atr_HeadingsBar.backdrop:Point("TOPLEFT", -1, -41)
		Atr_HeadingsBar.backdrop:Point("BOTTOMRIGHT", 3, -171)

		Atr_ListTabs:Point("BOTTOMRIGHT", Atr_HeadingsBar, "TOPRIGHT", 11, -22)

		AuctionatorScrollFrame:Height(194)
		AuctionatorScrollFrame:Point("TOPLEFT", 5, -193)

		S:HandleScrollBar(AuctionatorScrollFrameScrollBar)
		AuctionatorScrollFrameScrollBar:Point("TOPLEFT", AuctionatorScrollFrame, "TOPRIGHT", 3, -19)
		AuctionatorScrollFrameScrollBar:Point("BOTTOMLEFT", AuctionatorScrollFrame, "BOTTOMRIGHT", 3, 19)

		for _, tab in ipairs({Atr_Col1_Heading_Button, Atr_Col3_Heading_Button}) do
			tab:StripTextures()
			tab:SetNormalTexture([[Interface\Buttons\UI-SortArrow]])
			tab:StyleButton()
		end

		AuctionatorEntry1:Point("TOPLEFT", AuctionatorScrollFrame, "TOPLEFT", 1, -1)

		for i = 1, 12 do
			local button = _G["AuctionatorEntry"..i]
			button:Width(586)
			skinButtonHighlight(button)
		end

		AuctionatorScrollFrame:HookScript("OnShow", function(self)
			Atr_HeadingsBar.backdrop:Point("BOTTOMRIGHT", -18, -171)
		end)
		AuctionatorScrollFrame:HookScript("OnHide", function(self)
			Atr_HeadingsBar.backdrop:Point("BOTTOMRIGHT", 3, -171)
		end)

		-- Buy tab
		S:HandleDropDownBox(Atr_DropDownSL, 221)
		Atr_DropDownSL:Point("TOPLEFT", -211, -29)

		S:HandleEditBox(Atr_Search_Box)
		S:HandleButton(Atr_Search_Button)
		S:HandleButton(Atr_Adv_Search_Button)

		Atr_Search_Box:Point("TOPLEFT", 20, -32)
		Atr_Search_Button:Point("LEFT", Atr_Search_Box, "RIGHT", 6, 0)

		Atr_Adv_Search_Button:Height(22)
		Atr_Adv_Search_Button:Point("LEFT", Atr_Search_Button, "RIGHT", 5, 0)

		S:HandleButton(Atr_AddToSListButton)
		Atr_AddToSListButton:Width(193)
		Atr_AddToSListButton:Point("TOPLEFT", -191, -304)

		S:HandleButton(Atr_RemFromSListButton)
		Atr_RemFromSListButton:Width(193)
		Atr_RemFromSListButton:Point("TOPLEFT", -191, -325)

		S:HandleButton(Atr_DelSListButton)
		Atr_DelSListButton:Width(193)
		Atr_DelSListButton:Point("TOPLEFT", -191, -346)

		S:HandleButton(Atr_NewSListButton)
		Atr_NewSListButton:Width(193)
		Atr_NewSListButton:Point("TOPLEFT", -191, -367)

		S:HandleButton(Atr_Back_Button)
		Atr_Back_Button:Height(22)
		Atr_Back_Button:Point("TOPLEFT", 7, 13)

		-- Sell tab
		Atr_SellControls:SetTemplate("Transparent")
		Atr_SellControls:Size(193, 330)
		Atr_SellControls:Point("TOPLEFT", -191, -57)

		skinItemButtom(Atr_SellControls_Tex)
		Atr_SellControls_Tex:Point("TOPLEFT", 11, -14)

		Atr_StackPriceText:Point("TOPLEFT", 7, -56)
		Atr_ItemPriceText:Point("TOPLEFT", 7, -96)

		S:HandleButton(Atr_CreateAuctionButton)
		Atr_CreateAuctionButton:Point("TOPLEFT", 4, -139)

		Atr_Batch_Stacksize_Text:Point("TOPLEFT", 55, -177)
		Atr_Batch_NumAuctions:Point("TOPLEFT", Atr_Batch_Stacksize_Text, "TOPLEFT", -41, 0)

		Atr_Batch_MaxAuctions_Text:ClearAllPoints()
		Atr_Batch_MaxAuctions_Text:Point("BOTTOM", Atr_Batch_NumAuctions, 0, -14)
		Atr_Batch_MaxStacksize_Text:ClearAllPoints()
		Atr_Batch_MaxStacksize_Text:Point("BOTTOM", Atr_Batch_Stacksize, 0, -14)

		Atr_StartingPriceText:Point("TOPLEFT", 13, -229)
		Atr_StartingPriceDiscountText:Point("TOPLEFT", 10, -238)

		Atr_Duration_Text:Point("TOPLEFT", 10, -276)
		Atr_Duration_Text.SetPoint = E.noop
		S:HandleDropDownBox(Atr_Duration, 130)

		Atr_Deposit_Text:Point("TOPLEFT", 10, -304)

		S:HandleEditBox(Atr_StackPriceGold)
		S:HandleEditBox(Atr_StackPriceSilver)
		S:HandleEditBox(Atr_StackPriceCopper)
		S:HandleEditBox(Atr_ItemPriceGold)
		S:HandleEditBox(Atr_ItemPriceSilver)
		S:HandleEditBox(Atr_ItemPriceCopper)
		S:HandleEditBox(Atr_StartingPriceGold)
		S:HandleEditBox(Atr_StartingPriceSilver)
		S:HandleEditBox(Atr_StartingPriceCopper)
		S:HandleEditBox(Atr_Batch_NumAuctions)
		S:HandleEditBox(Atr_Batch_Stacksize)

		-- More tab
		S:HandleDropDownBox(Atr_DropDown1, 221)
		Atr_DropDown1:Point("TOPLEFT", -211, -29)

		S:HandleButton(Atr_CheckActiveButton)
		Atr_CheckActiveButton:Size(193, 22)
		Atr_CheckActiveButton:Point("TOPLEFT", -191, -394)

		if Atr_CancelAllUndercutsButton then
			S:HandleButton(Atr_CancelAllUndercutsButton)
			Atr_CancelAllUndercutsButton:Height(22)
			Atr_CancelAllUndercutsButton:Point("TOPLEFT", 7, -394)
		end
	end)

	-- Config
	Atr_BasicOptionsFrame:SetTemplate("Transparent")
	Atr_TooltipsOptionsFrame:SetTemplate("Transparent")
	Atr_UCConfigFrame:SetTemplate("Transparent")
	Atr_StackingOptionsFrame:SetTemplate("Transparent")
	Atr_ScanningOptionsFrame:SetTemplate("Transparent")
	AuctionatorDescriptionFrame:SetTemplate("Transparent")

	Atr_Stacking_List:SetTemplate("Transparent")

	S:HandleCheckBox(AuctionatorOption_Enable_Alt_CB)
	S:HandleCheckBox(AuctionatorOption_Open_All_Bags_CB)
	S:HandleCheckBox(AuctionatorOption_Show_StartingPrice_CB)
	S:HandleCheckBox(AuctionatorOption_Def_Duration_CB)
	S:HandleCheckBox(ATR_tipsVendorOpt_CB)
	S:HandleCheckBox(ATR_tipsAuctionOpt_CB)
	S:HandleCheckBox(ATR_tipsDisenchantOpt_CB)

	S:HandleDropDownBox(AuctionatorOption_Deftab)
	S:HandleDropDownBox(Atr_tipsShiftDD)
	S:HandleDropDownBox(Atr_deDetailsDD, 220)
	S:HandleDropDownBox(Atr_scanLevelDD)
	Atr_deDetailsDDText:SetJustifyH("RIGHT")

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
		S:HandleEditBox(_G[name.."Gold"])
		S:HandleEditBox(_G[name.."Silver"])
		S:HandleEditBox(_G[name.."Copper"])
	end
	S:HandleEditBox(Atr_Starting_Discount)

	S:HandleButton(Atr_UCConfigFrame_Reset)
	S:HandleButton(Atr_StackingOptionsFrame_Edit)
	S:HandleButton(Atr_StackingOptionsFrame_New)
end)