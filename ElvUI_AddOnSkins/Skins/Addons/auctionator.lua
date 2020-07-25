local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

if not AS:IsAddonLODorEnabled("Auctionator") then return end

local _G = _G
local unpack = unpack

local GetItemIcon = GetItemIcon

-- Auctionator 2.6.3
-- https://www.curseforge.com/wow/addons/auctionator/files/426882

S:AddCallbackForAddon("Auctionator", "Auctionator", function()
	if not E.private.addOnSkins.Auctionator then return end

	hooksecurefunc("Atr_SetTextureButton", function(elementName, _, itemlink)
		local textureElement = _G[elementName]

		if not textureElement.backdrop then
			textureElement:StyleButton(nil, true)
			textureElement:SetTemplate("Default", true)

			textureElement.backdrop = true
		end

		if GetItemIcon(itemlink) then
			textureElement:GetNormalTexture():SetTexCoord(unpack(E.TexCoords))
			textureElement:GetNormalTexture():SetInside()
		end
	end)

	Atr_Error_Frame:SetTemplate("Transparent")
	S:HandleButton((Atr_Error_Frame:GetChildren()))

	Atr_Confirm_Frame:SetTemplate("Transparent")
	S:HandleButton(Atr_Confirm_Cancel)
	S:HandleButton(select(2, Atr_Confirm_Frame:GetChildren()))

	-- Options skinning
	Atr_BasicOptionsFrame:StripTextures()
	Atr_BasicOptionsFrame:SetTemplate("Transparent")
	Atr_TooltipsOptionsFrame:StripTextures()
	Atr_TooltipsOptionsFrame:SetTemplate("Transparent")
	Atr_UCConfigFrame:StripTextures()
	Atr_UCConfigFrame:SetTemplate("Transparent")
	Atr_StackingOptionsFrame:StripTextures()
	Atr_StackingOptionsFrame:SetTemplate("Transparent")
	Atr_ScanningOptionsFrame:StripTextures()
	Atr_ScanningOptionsFrame:SetTemplate("Transparent")
	AuctionatorDescriptionFrame:StripTextures()
	AuctionatorDescriptionFrame:SetTemplate("Transparent")
	Atr_Stacking_List:StripTextures()
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
	S:HandleDropDownBox(Atr_deDetailsDD)
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

	S:SecureHook("Atr_OnAuctionHouseShow", function()
		S:HandleDropDownBox(Atr_DropDownSL, 223)
		S:HandleDropDownBox(Atr_DropDown1, 223)

		Atr_DropDownSL:ClearAllPoints()
		Atr_DropDownSL:Point("BOTTOMRIGHT", Atr_Hlist, "TOPRIGHT", 8, 0)
		Atr_DropDown1:ClearAllPoints()
		Atr_DropDown1:Point("BOTTOMRIGHT", Atr_Hlist, "TOPRIGHT", 8, 0)

		Atr_CheckActiveButton:SetWidth(195)
		S:HandleButton(Atr_CheckActiveButton)

		Atr_Adv_Search_Button:Height(22)
		Atr_FullScanButton:Size(153, 22)
		Auctionator1Button:Height(22)

		Atr_Search_Box:Point("TOPLEFT", 7, -45)
		Atr_Search_Button:Point("LEFT", Atr_Search_Box, "RIGHT", 5, 0)
		Atr_Adv_Search_Button:Point("LEFT", Atr_Search_Button, "RIGHT", 5, 0)

		Atr_FullScanButton:ClearAllPoints()
		Atr_FullScanButton:Point("LEFT", Atr_Adv_Search_Button, "RIGHT", 5, 0)

		Auctionator1Button:ClearAllPoints()
		Auctionator1Button:Point("LEFT", Atr_FullScanButton, "RIGHT", 5, 0)

		S:HandleEditBox(Atr_Search_Box)
		S:HandleButton(Atr_Search_Button)
		S:HandleButton(Atr_Adv_Search_Button)
		S:HandleButton(Auctionator1Button)
		S:HandleButton(Atr_FullScanButton)
		Atr_FullScanButton:Width(132)
		S:HandleScrollBar(Atr_Hlist_ScrollFrameScrollBar)

		Atr_Hlist:StripTextures()
		Atr_Hlist:SetTemplate("Transparent")
		Atr_Hlist:SetWidth(195)
		Atr_Hlist:ClearAllPoints()
		Atr_Hlist:Point("TOPLEFT", -195, -75)

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

		S:HandleButton(Atr_CreateAuctionButton)
		S:HandleDropDownBox(Atr_Duration, 130)

		Atr_Batch_MaxAuctions_Text:ClearAllPoints()
		Atr_Batch_MaxAuctions_Text:Point("BOTTOM", Atr_Batch_NumAuctions, 0, -14)
		Atr_Batch_MaxStacksize_Text:ClearAllPoints()
		Atr_Batch_MaxStacksize_Text:Point("BOTTOM", Atr_Batch_Stacksize, 0, -14)

		Atr_Duration:Point("TOPLEFT", Atr_Duration_Text, 56, 7)
		S:HandleButton(Atr_AddToSListButton)
		Atr_RemFromSListButton:SetPoint("TOPLEFT", -195, -350)
		S:HandleButton(Atr_RemFromSListButton)
		Atr_DelSListButton:SetPoint("TOPLEFT", -195, -371)
		S:HandleButton(Atr_DelSListButton)
		Atr_NewSListButton:SetPoint("TOPLEFT", -195, -392)
		S:HandleButton(Atr_NewSListButton)

		S:HandleButton(AuctionatorCloseButton)
		S:HandleButton(Atr_CancelSelectionButton)
		S:HandleButton(Atr_Buy1_Button)

		S:HandleScrollBar(AuctionatorScrollFrameScrollBar)

		Atr_HeadingsBar:StripTextures()
		Atr_HeadingsBar:SetTemplate("Transparent")
		Atr_HeadingsBar:Size(608, 20)

		for i = 1, 3 do
			local tab = _G["Atr_ListTabsTab"..i]
			tab:StripTextures()
			S:HandleButton(tab)
			tab:Height(22)
		end

		Atr_ListTabsTab3:Point("BOTTOMRIGHT", Atr_ListTabs, -8, 21)

		S:HandleButton(Atr_Back_Button)
		Atr_Back_Button:Height(22)
		Atr_Back_Button:Point("TOPLEFT", Atr_HeadingsBar, 8, 21)

		Atr_Hilite1:SetTemplate("Transparent", true, true)
		Atr_Hilite1:SetBackdropColor(0, 0, 0, 0)

		S:HandleDropDownBox(Atr_ASDD_Class, 180)
		S:HandleDropDownBox(Atr_ASDD_Subclass, 180)

		S:HandleButton(Atr_FullScanStartButton)
		S:HandleButton(Atr_FullScanDone)
		S:HandleButton(Atr_Adv_Search_ResetBut)
		S:HandleButton(Atr_Adv_Search_OKBut)
		S:HandleButton(Atr_Adv_Search_CancelBut)
		S:HandleButton(Atr_Buy_Confirm_OKBut)
		S:HandleButton(Atr_Buy_Confirm_CancelBut)

		S:HandleEditBox(Atr_AS_Searchtext)
		S:HandleEditBox(Atr_AS_Minlevel)
		S:HandleEditBox(Atr_AS_Maxlevel)

		Atr_FullScanResults:StripTextures()
		Atr_FullScanResults:SetTemplate("Transparent")
		Atr_Adv_Search_Dialog:StripTextures()
		Atr_Adv_Search_Dialog:SetTemplate("Transparent")
		Atr_FullScanFrame:StripTextures()
		Atr_FullScanFrame:SetTemplate("Transparent")
		Atr_Buy_Confirm_Frame:StripTextures()
		Atr_Buy_Confirm_Frame:SetTemplate("Transparent")
		Atr_CheckActives_Frame:StripTextures()
		Atr_CheckActives_Frame:SetTemplate("Transparent")

		-- Button Positions
		Atr_Buy1_Button:Point("RIGHT", AuctionatorCloseButton, "LEFT", -5, 0)
		Atr_CancelSelectionButton:Point("RIGHT", Atr_Buy1_Button, "LEFT", -5, 0)

		for i = 1, AuctionFrame.numTabs do
			S:HandleTab(_G["AuctionFrameTab"..i])
		end

		Atr_Mask:SetAllPoints(AuctionFrame.backdrop)

		local child
		for i = 1, Atr_CheckActives_Frame:GetNumChildren() do
			child = select(i, Atr_CheckActives_Frame:GetChildren())

			if child and child:IsObjectType("Button") then
				S:HandleButton(child)
			end
		end

		S:Unhook("Atr_OnAuctionHouseShow")
	end)
end)