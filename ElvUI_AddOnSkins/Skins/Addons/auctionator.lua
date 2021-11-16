-- Auctionator 9.1.3 for sirus
-- by fxpw
-- discord fxpw#9990

local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

if not AS:IsAddonLODorEnabled("Auctionator") then return end

local _G = _G


-- TimeSinceLastUpdate = 0
-- MyAddon_UpdateInterval = 11.1
local proverkafuncfirsttab = 1
local proverkafuncsectab = 1
local proverkafuncitframe = 1
local handlebuttonsselltabcheck = 1
local handlebuttonscanctabcheck = 1
local fourperemchec = 1

-----------------------------
-----------------------------
-----------
------------ func for icons if exist
-----------
-----------------------------
-----------------------------

local function handlebuttonsselltab()
	if handlebuttonsselltabcheck == 1 then
		if AuctionatorSellingFrameBagListingScrollFrameItemListingFrameWeaponItems ~= nil  then
			for _, button in ipairs(AuctionatorSellingFrameBagListingScrollFrameItemListingFrameWeaponItems.buttons) do
				if button then
					button.Icon:SetDrawLayer("BORDER")
					S:HandleIcon(button.Icon)
				end
			end
		end
		if AuctionatorSellingFrameBagListingScrollFrameItemListingFrameArmorItems ~= nil then
			for _, button in ipairs(AuctionatorSellingFrameBagListingScrollFrameItemListingFrameArmorItems.buttons) do
				if button then
					button.Icon:SetDrawLayer("BORDER")
					S:HandleIcon(button.Icon)
				end
			end
		end
		if AuctionatorSellingFrameBagListingScrollFrameItemListingFrameContainerItems ~= nil then
			for _, button in ipairs(AuctionatorSellingFrameBagListingScrollFrameItemListingFrameContainerItems.buttons) do
				if button then
					button.Icon:SetDrawLayer("BORDER")
					S:HandleIcon(button.Icon)
				end
			end
		end
		if AuctionatorSellingFrameBagListingScrollFrameItemListingFrameGemItems ~= nil then
			for _, button in ipairs(AuctionatorSellingFrameBagListingScrollFrameItemListingFrameGemItems.buttons) do
					if button then
						button.Icon:SetDrawLayer("BORDER")
						S:HandleIcon(button.Icon)
					end
			end
		end
		if AuctionatorSellingFrameBagListingScrollFrameItemListingFrameConsumableItems ~= nil then
			for _, button in ipairs(AuctionatorSellingFrameBagListingScrollFrameItemListingFrameConsumableItems.buttons) do
				if button then
					button.Icon:SetDrawLayer("BORDER")
					S:HandleIcon(button.Icon)
				end
			end
		end
		if 	AuctionatorSellingFrameBagListingScrollFrameItemListingFrameGlyphItems ~= nil then
			for _, button in ipairs(AuctionatorSellingFrameBagListingScrollFrameItemListingFrameGlyphItems.buttons) do
				if button then
					button.Icon:SetDrawLayer("BORDER")
					S:HandleIcon(button.Icon)
				end
			end
		end

		if AuctionatorSellingFrameBagListingScrollFrameItemListingFrameTradeGoodItems ~= nil then

			for _, button in ipairs(AuctionatorSellingFrameBagListingScrollFrameItemListingFrameTradeGoodItems.buttons) do
				if button then
					button.Icon:SetDrawLayer("BORDER")
					S:HandleIcon(button.Icon)
				end
			end
		end
		if AuctionatorSellingFrameBagListingScrollFrameItemListingFrameRecipeItems ~= nil then
			for _, button in ipairs(AuctionatorSellingFrameBagListingScrollFrameItemListingFrameRecipeItems.buttons) do
				if button then
					button.Icon:SetDrawLayer("BORDER")
					S:HandleIcon(button.Icon)
				end
			end
		end
		if AuctionatorSellingFrameBagListingScrollFrameItemListingFrameQuestItems ~= nil then
			for _, button in ipairs(AuctionatorSellingFrameBagListingScrollFrameItemListingFrameQuestItems.buttons) do
				if button then
					button.Icon:SetDrawLayer("BORDER")
					S:HandleIcon(button.Icon)
				end
			end
		end
		if AuctionatorSellingFrameBagListingScrollFrameItemListingFrameAmmoItems ~= nil then
			for _, button in ipairs(AuctionatorSellingFrameBagListingScrollFrameItemListingFrameAmmoItems.buttons) do
				if button then
					button.Icon:SetDrawLayer("BORDER")
					S:HandleIcon(button.Icon)
				end
			end
		end
		if AuctionatorSellingFrameBagListingScrollFrameItemListingFrameQuiverItems ~= nil then
			for _, button in ipairs(AuctionatorSellingFrameBagListingScrollFrameItemListingFrameQuiverItems.buttons) do
				if button then
					button.Icon:SetDrawLayer("BORDER")
					S:HandleIcon(button.Icon)
				end
			end
		end
		if AuctionatorSellingFrameBagListingScrollFrameItemListingFrameMiscItems ~= nil then
			for _, button in ipairs(AuctionatorSellingFrameBagListingScrollFrameItemListingFrameMiscItems.buttons) do
				if button then
					button.Icon:SetDrawLayer("BORDER")
					S:HandleIcon(button.Icon)
				end
			end
		end
	end
	handlebuttonsselltabcheck = 0
end

-----------------------------
-----------------------------
-----------
----------- first tab
-----------
-----------------------------
-----------------------------

local function auceditframe()
	if proverkafuncitframe == 1 then
		local frames = {
			"AuctionatorEditItemFrame",

			}
			for _, frame in ipairs(frames) do
				frame = _G[frame]
				if frame then
					frame:StripTextures()
					frame:CreateBackdrop("Transarent")
				end
			end
			AuctionatorEditItemFrameInset:Hide()

			local buttons = {
				"AuctionatorEditItemFrameCancel",
				"AuctionatorEditItemFrameResetAllButton",
				"AuctionatorEditItemFrameFinished",
				}
				for _, button in ipairs(buttons) do
					S:HandleButton(_G[button])
				end

				AuctionatorEditItemFrameCancel:ClearAllPoints()
				AuctionatorEditItemFrameCancel:SetPoint("TOPLEFT", AuctionatorEditItemFrame, "BOTTOMLEFT", 11, 30)
				AuctionatorEditItemFrameResetAllButton:SetText("Сбросить")
				AuctionatorEditItemFrameFinished:SetText("Сохранить")
				AuctionatorEditItemFrameFinished:ClearAllPoints()
				AuctionatorEditItemFrameFinished:SetPoint("TOPLEFT", AuctionatorEditItemFrameResetAllButton, "TOPRIGHT", 0, 0)
				AuctionatorEditItemFrameFinished:Width(120)

				local editboxes = {
					"AuctionatorEditItemFrameSearchContainerSearchString",
					"AuctionatorEditItemFrameLevelRangeMinBox",
					"AuctionatorEditItemFrameLevelRangeMaxBox",
					"AuctionatorEditItemFramePriceRangeMinBox",
					"AuctionatorEditItemFramePriceRangeMaxBox",
					"AuctionatorEditItemFrameItemLevelRangeMinBox",
					"AuctionatorEditItemFrameItemLevelRangeMaxBox",
					"AuctionatorEditItemFrameCraftedLevelRangeMinBox",
					"AuctionatorEditItemFrameCraftedLevelRangeMaxBox",
					}
					for _, editbox in ipairs(editboxes) do
						editbox = _G[editbox]
						if editbox then
							S:HandleEditBox(editbox)
						end
					end
				local refreshbuttons ={
					"AuctionatorEditItemFrameSearchContainerAuctionatorResetButton",
					"AuctionatorEditItemFrameFilterKeySelectorResetButton",
					"AuctionatorEditItemFrameLevelRangeResetButton",
					"AuctionatorEditItemFramePriceRangeResetButton",
					"AuctionatorEditItemFrameItemLevelRangeResetButton",
					"AuctionatorEditItemFrameCraftedLevelRangeResetButton",
				}

					for _, refreshbutton in ipairs(refreshbuttons) do
						refreshbutton = _G[refreshbutton]
						if refreshbutton then
							S:HandleButton(refreshbutton)

						end
					end
					local dropdowns = {
						"AuctionatorEditItemFrameFilterKeySelector",
						}
						for _, dropdown in ipairs(dropdowns) do
							dropdown = _G[dropdown]
							if dropdown then
								S:HandleDropDownBox(dropdown)
							end
						end
					local checkboxes = {
						"AuctionatorEditItemFrameSearchContainerIsExact"
					}
					for _, checkbox in ipairs(checkboxes) do
						checkbox = _G[checkbox]
						if checkbox then
							S:HandleCheckBox(checkbox)
						end
					end

						AuctionatorEditItemFrameFilterKeySelector:SetWidth(200)
						AuctionatorEditItemFrameFilterKeySelectorResetButton:ClearAllPoints()
						AuctionatorEditItemFrameFilterKeySelectorResetButton:SetPoint("TOPLEFT", AuctionatorEditItemFrameFilterKeySelector, "TOPRIGHT", -5, -6)
			end
	end
	proverkafuncitframe = 0
local function firsauctttab()
	if proverkafuncfirsttab == 1 then
	--buttons 1
	local buttons = {
		"AuctionatorShoppingListFrameImport",
		"AuctionatorShoppingListFrameExport",
		"AuctionatorShoppingListFrameRename",
		"AuctionatorShoppingListFrameDeleteList",
		"AuctionatorShoppingListFrameCreateList",
		"AuctionatorShoppingListFrameExportCSV",
		"AuctionatorShoppingListFrameManualSearch",
		"AuctionatorShoppingListFrameAddItem",
		"AuctionatorShoppingListFrameResultsListingHeaderContainerPoolFrameAuctionatorStringColumnHeaderTemplate1",
		"AuctionatorShoppingListFrameResultsListingHeaderContainerPoolFrameAuctionatorStringColumnHeaderTemplate2",
		"AuctionatorShoppingListFrameResultsListingHeaderContainerPoolFrameAuctionatorStringColumnHeaderTemplate3",
		"AuctionatorShoppingListFrameResultsListingHeaderContainerPoolFrameAuctionatorStringColumnHeaderTemplate4",
		}
		for _, button in ipairs(buttons) do
			S:HandleButton(_G[button])
		end

		AuctionatorShoppingListFrameResultsListingHeaderContainerPoolFrameAuctionatorStringColumnHeaderTemplate1:ClearAllPoints()
		AuctionatorShoppingListFrameResultsListingHeaderContainerPoolFrameAuctionatorStringColumnHeaderTemplate1:SetPoint("BOTTOMLEFT", 15, 4)
	-- dropdown 1
	local dropdowns = {
		"AuctionatorShoppingListFrameListDropdown",
		}
		for _, dropdown in ipairs(dropdowns) do
			dropdown = _G[dropdown]
			if dropdown then
				S:HandleDropDownBox(dropdown)
			end
		end
	-- scrollbars 1
	local scrollbars = {
		"AuctionatorShoppingListFrameResultsListingScrollFrameScrollBar",
		"AuctionatorShoppingListFrameScrollListScrollFrameScrollBar",
		}
		for _, scrollbar in ipairs(scrollbars) do
			scrollbar = _G[scrollbar]
			if scrollbar then
				S:HandleScrollBar(scrollbar)
			end
		end
		--frames strip
	local frames = {
		"AuctionatorShoppingListFrameScrollListScrollFrame",
		"AuctionatorShoppingListFrameResultsListingScrollFrame",
		"AuctionatorShoppingListFrameShoppingResultsInsetNineSlice",
		"AuctionatorShoppingListFrameShoppingResultsInset",
		"AuctionatorShoppingListFrameResultsListing",
		"AuctionatorShoppingListFrameScrollListScrollFrameScrollChild",
		"AuctionatorShoppingListFrameScrollListInsetFrame",
		}
		for _, frame in ipairs(frames) do
			frame = _G[frame]
			if frame then
				frame:StripTextures()
				-- frame:CreateBackdrop("Transparent")
			end
		end
		--frames createback
		local frames = {
			-- "AuctionatorShoppingListFrameScrollListScrollFrame",
			-- "AuctionatorShoppingListFrameResultsListingScrollFrame",
			"AuctionatorShoppingListFrameShoppingResultsInsetNineSlice",
			"AuctionatorShoppingListFrameScrollListScrollFrameScrollChild",
			-- "AuctionatorShoppingListFrameShoppingResultsInset",
			-- "AuctionatorShoppingListFrameResultsListing",
			-- "AuctionatorShoppingListFrameResultsListingScrollFrame",
			}
			for _, frame in ipairs(frames) do
				frame = _G[frame]
				if frame then
					-- frame:StripTextures()
					frame:CreateBackdrop("Transparent")
				end
			end
		AuctionatorShoppingListFrameCreateList:ClearAllPoints()
		AuctionatorShoppingListFrameCreateList:SetPoint("LEFT", AuctionatorShoppingListFrameListDropdown, "RIGHT", 10, 2)
	end
	proverkafuncfirsttab = 0

end
-----------------------------
-----------------------------
-----------
----------- second tab
-----------
-----------------------------
-----------------------------
local function auctionatorsectab()
	if proverkafuncsectab == 1 then
		AuctionatorSellingFrameSaleItemFrameIconIconBorder:StripTextures()
		AuctionatorSellingFrameSaleItemFrameIconEmptySlot:StripTextures()
		AuctionatorSellingFrameSaleItemFrameIcon.Icon:SetDrawLayer("BORDER")
		S:HandleIcon(AuctionatorSellingFrameSaleItemFrameIcon.Icon)
		local tabs = {
			"AuctionatorSellingFrameHistoryTabsContainerRealmHistoryTab",
			"AuctionatorSellingFrameHistoryTabsContainerYourHistoryTab"
			}
			for _, tab in ipairs(tabs) do
				tab = _G[tab]
				if tab then
					S:HandleTab(tab)
				end
			end
		local buttons = {
			"AuctionatorSellingFrameHistoricalPriceListingHeaderContainerPoolFrameAuctionatorStringColumnHeaderTemplate1",
			"AuctionatorSellingFrameHistoricalPriceListingHeaderContainerPoolFrameAuctionatorStringColumnHeaderTemplate2",
			"AuctionatorSellingFrameHistoricalPriceListingHeaderContainerPoolFrameAuctionatorStringColumnHeaderTemplate3",
			"AuctionatorSellingFrameHistoricalPriceListingHeaderContainerPoolFrameAuctionatorStringColumnHeaderTemplate4",
			"AuctionatorSellingFrameCurrentItemListingHeaderContainerPoolFrameAuctionatorStringColumnHeaderTemplate1",
			"AuctionatorSellingFrameCurrentItemListingHeaderContainerPoolFrameAuctionatorStringColumnHeaderTemplate2",
			"AuctionatorSellingFrameCurrentItemListingHeaderContainerPoolFrameAuctionatorStringColumnHeaderTemplate3",
			"AuctionatorSellingFrameCurrentItemListingHeaderContainerPoolFrameAuctionatorStringColumnHeaderTemplate4",
			"AuctionatorSellingFrameCurrentItemListingHeaderContainerPoolFrameAuctionatorStringColumnHeaderTemplate5",
			"AuctionatorSellingFrameCurrentItemListingHeaderContainerPoolFrameAuctionatorStringColumnHeaderTemplate6",
			"AuctionatorSellingFrameCurrentItemListingHeaderContainerPoolFrameAuctionatorStringColumnHeaderTemplate7",
			"AuctionatorSellingFrameSaleItemFrameMaxButton",
			"AuctionatorPostButton",
			"AuctionatorSellingFramePostingHistoryListingHeaderContainerPoolFrameAuctionatorStringColumnHeaderTemplate1",
			"AuctionatorSellingFramePostingHistoryListingHeaderContainerPoolFrameAuctionatorStringColumnHeaderTemplate2",
			"AuctionatorSellingFramePostingHistoryListingHeaderContainerPoolFrameAuctionatorStringColumnHeaderTemplate3",
			"AuctionatorSellingFramePostingHistoryListingHeaderContainerPoolFrameAuctionatorStringColumnHeaderTemplate4",
			"AuctionatorSellingFramePostingHistoryListingHeaderContainerPoolFrameAuctionatorStringColumnHeaderTemplate5",
			}
			for _, button in ipairs(buttons) do
				button = _G[button]
				if button then
					S:HandleButton(button)
				end
			end
		local scrollbars = {
			"AuctionatorSellingFramePostingHistoryListingScrollFrameScrollBar",
			"AuctionatorSellingFrameCurrentItemListingScrollFrameScrollBar",
			"AuctionatorSellingFrameHistoricalPriceListingScrollFrameScrollBar",
			"AuctionatorSellingFrameBagListingScrollFrameScrollBar",
			}
			for _,scrollbar in ipairs(scrollbars) do
				scrollbar = _G[scrollbar]
					if scrollbar then
						scrollbar:StripTextures()
						S:HandleScrollBar(scrollbar)
						-- scrollbar:ClearAllPoints()
						-- scrollbar:SetPoint("TOPLEFT", AuctionatorSellingFrameBagListingScrollFrame, "TOPRIGHT", 60, -16)
					end
			end
		local frames = {
			"AuctionatorSellingFramePostingHistoryListingScrollFrame",
			"AuctionatorSellingFrameCurrentItemListingScrollFrame",
			"AuctionatorSellingFrameHistoricalPriceListingScrollFrame",
		}
		for _, frame in ipairs(frames) do
			frame = _G[frame]
				if frame then
					frame:StripTextures()
					frame:CreateBackdrop("Transparent")
				end
		end
		local frames2 = {
			"AuctionatorSellingFramePostingHistoryListing",
			"AuctionatorSellingFrameCurrentItemListing",
			"AuctionatorSellingFrameHistoricalPriceListing",
			"AuctionatorSellingFramePostingHistoryListingScrollFrameScrollChild",
			"AuctionatorSellingFrameCurrentItemListingScrollFrameScrollChild",
			"AuctionatorSellingFrameHistoricalPriceListingScrollFrameScrollChild",
			"AuctionatorSellingFrameBagListingScrollFrame",
			"AuctionatorSellingFrameBagListingScrollFrameItemListingFrameWeaponItemsSectionTitle",
			"AuctionatorSellingFrameBagListingScrollFrameItemListingFrameArmorItemsSectionTitle",
			"AuctionatorSellingFrameBagListingScrollFrameItemListingFrameContainerItemsSectionTitle",
			"AuctionatorSellingFrameBagListingScrollFrameItemListingFrameGemItemsSectionTitle",
			"AuctionatorSellingFrameBagListingScrollFrameItemListingFrameConsumableItemsSectionTitle",
			"AuctionatorSellingFrameBagListingScrollFrameItemListingFrameGlyphItemsSectionTitle",
			"AuctionatorSellingFrameBagListingScrollFrameItemListingFrameTradeGoodItemsSectionTitle",
			"AuctionatorSellingFrameBagListingScrollFrameItemListingFrameRecipeItemsSectionTitle",
			"AuctionatorSellingFrameBagListingScrollFrameItemListingFrameQuestItemsSectionTitle",
			"AuctionatorSellingFrameBagListingScrollFrameItemListingFrameAmmoItemsSectionTitle",
			"AuctionatorSellingFrameBagListingScrollFrameItemListingFrameQuiverItemsSectionTitle",
			"AuctionatorSellingFrameBagListingScrollFrameItemListingFrameMiscItemsSectionTitle",
		}
		for _, frame in ipairs(frames2) do
			frame = _G[frame]
				if frame then
					frame:StripTextures()
				end
		end
		local frames3 = {
			"AuctionatorSellingFrameHistoricalPriceInset",
			"AuctionatorSellingFramePostingHistoryListingInset",
			"AuctionatorSellingFrameCurrentItemInset",
			"AuctionatorSellingFrameBagInset",
			-- "AuctionHouseFramePortrait",
			"AuctionatorSellingFrameBagListingScrollFrameScrollBarThumbTexture",
			"AuctionatorSellingFrameBagListingScrollFrameScrollBarChild",
		}
			for _,frame in ipairs(frames3) do
				frame = _G[frame]
					if frame then
						frame:Hide()
					end
			end

			local editboxes = {
				"AuctionatorSellingFrameSaleItemFramePriceMoneyInputGoldBox",
				"AuctionatorSellingFrameSaleItemFramePriceMoneyInputSilverBox",
				"AuctionatorSellingFrameSaleItemFrameQuantityInputBox"
			}
			for _,editbox in ipairs(editboxes) do
				editbox = _G[editbox]
					if editbox then
						S:HandleEditBox(editbox)
					end
			end
			AuctionatorSellingFrameSaleItemFramePriceMoneyInputSilverBoxIcon:ClearAllPoints()
			AuctionatorSellingFrameSaleItemFramePriceMoneyInputSilverBoxIcon:SetPoint( "RIGHT", AuctionatorSellingFrameSaleItemFramePriceMoneyInputSilverBox, "RIGHT", -13.000000136774, 2)

			local checkbuttons = {
				"AuctionatorSellingFrameSaleItemFrameDurationDuration12RadioButton",
				"AuctionatorSellingFrameSaleItemFrameDurationDuration24RadioButton",
				"AuctionatorSellingFrameSaleItemFrameDurationDuration48RadioButton",


			}
			for _,checkbutton in ipairs(checkbuttons) do
				checkbutton = _G[checkbutton]
					if checkbutton then
						S:HandleCheckBox(checkbutton)
					end
			end
	end

	proverkafuncsectab = 0

end

-----------------------------
-----------------------------
-----------
----------- shrek best part tab
-----------
-----------------------------
-----------------------------
local function auctionatorthrtab()
	if handlebuttonscanctabcheck == 1 then
		local buttons = {
			"AuctionatorCancellingFrameScanStartScanButton",
			"AuctionatorCancelUndercutButton",
			"AuctionatorCancellingFrameResultsListingHeaderContainerPoolFrameAuctionatorStringColumnHeaderTemplate1",
			"AuctionatorCancellingFrameResultsListingHeaderContainerPoolFrameAuctionatorStringColumnHeaderTemplate2",
			"AuctionatorCancellingFrameResultsListingHeaderContainerPoolFrameAuctionatorStringColumnHeaderTemplate3",
			"AuctionatorCancellingFrameResultsListingHeaderContainerPoolFrameAuctionatorStringColumnHeaderTemplate4",
			"AuctionatorCancellingFrameResultsListingHeaderContainerPoolFrameAuctionatorStringColumnHeaderTemplate5",
			"AuctionatorCancellingFrameResultsListingHeaderContainerPoolFrameAuctionatorStringColumnHeaderTemplate6",
			"AuctionatorCancellingFrameResultsListingHeaderContainerPoolFrameAuctionatorStringColumnHeaderTemplate7",
		}
		for _,button in ipairs(buttons) do
			button = _G[button]
				if button then
					S:HandleButton(button)
				end
		end

		AuctionatorCancellingFrameResultsListingHeaderContainerPoolFrameAuctionatorStringColumnHeaderTemplate2:SetText("Кол-во")

		local editboxes = {
			"AuctionatorCancellingFrameSearchFilter",
		}
		for _,editbox in ipairs(editboxes) do
			editbox = _G[editbox]
				if editbox then
					S:HandleEditBox(editbox)
				end
		end
		local frames1 = {
			"AuctionatorCancellingFrameHistoricalPriceInset",
			"AuctionatorCancellingFrameHistoricalPriceInsetNineSlice",
		}
		for _,frame in ipairs(frames1) do
			frame = _G[frame]
				if frame then
					frame:StripTextures()
					frame:CreateBackdrop("Transparent")
				end
		end

		local frames2 = {
			"AuctionatorCancellingFrameResultsListingScrollFrameScrollChild",
			"AuctionatorCancellingFrameResultsListingScrollFrame",
			"AuctionatorCancellingFrameResultsListingHeaderContainer",
			"AuctionatorCancellingFrameResultsListing",
		}
		for _,frame in ipairs(frames2) do
			frame = _G[frame]
				if frame then
					frame:StripTextures()
				end
		end
		-- AuctionatorCancellingFrameResultsListing:Hide()

		local scrollbars = {
			"AuctionatorCancellingFrameResultsListingScrollFrameScrollBar",
			-- "AuctionatorCancellingFrameResultsListingScrollFrame",
			-- "AuctionatorCancellingFrameResultsListingHeaderContainer",
		}
		for _,scrollbar in ipairs(scrollbars) do
			scrollbar = _G[scrollbar]
				if scrollbar then
					S:HandleScrollBar(scrollbar)
				end
		end
	end
	handlebuttonscanctabcheck = 0
end


-----------------------------
-----------------------------
-----------
----------- 4 tab
-----------
-----------------------------
-----------------------------


local function fourauctionatortab()
	if fourperemchec == 1 then
		local buttons = {
			"AuctionatorConfigFrameOptionsButton",
			"AuctionatorConfigFrameScanButton",
		}
		for _,button in ipairs(buttons) do
			button = _G[button]
				if button then
					S:HandleButton(button)
				end
		end

		local frames = {
			"AuctionatorConfigFrame",
			"AuctionatorConfigFrameNineSlice",
		}
		for _,frame in ipairs(frames) do
			frame = _G[frame]
				if frame then
					frame:StripTextures()
					frame:CreateBackdrop("Transparent")
				end
		end
		local editboxes = {
			"AuctionatorConfigFrameDiscordLinkInputBox",
			"AuctionatorConfigFrameBugReportLinkInputBox",
			"AuctionatorConfigFrameTechnicalRoadmapInputBox",
		}
		for _,editbox in ipairs(editboxes) do
			editbox = _G[editbox]
				if editbox then
					S:HandleEditBox(editbox)
				end
		end
	end
	fourperemchec = 0

end



S:AddCallbackForAddon("Auctionator", "Auctionator", function()
	if not E.private.addOnSkins.Auctionator then return end
	AuctionHouseFrame:HookScript("OnUpdate", function()
		S:HandleTab(AuctionatorTabs_ShoppingLists)
		S:HandleTab(AuctionatorTabs_Selling)
		S:HandleTab(AuctionatorTabs_Cancelling)
		S:HandleTab(AuctionatorTabs_Auctionator)

		local funcionshow1 = AuctionatorTabs_ShoppingLists:GetScript("OnUpdate")
		local funcionshow2 = AuctionatorEditItemFrame:GetScript("OnUpdate")
		local funcionshow3 = AuctionatorTabs_Selling:GetScript("OnUpdate")
		local funcionshow4 = AuctionatorSellingFrameBagListingScrollFrame:GetScript("OnUpdate")
		local funcionshow5 = AuctionatorTabs_Cancelling:GetScript("OnUpdate")
		local funcionshow6 = AuctionatorTabs_Auctionator:GetScript("OnUpdate")

		if funcionshow1 == nil then
			if AuctionatorTabs_ShoppingLists ~= nil then
				AuctionatorTabs_ShoppingLists:SetScript("OnUpdate",firsauctttab )
				if funcionshow2 == nil then
					if AuctionatorEditItemFrame ~= nil then
						AuctionatorEditItemFrame:SetScript("OnUpdate",  auceditframe)
					end
				end
			end
		end
		if funcionshow3 == nil then
			if AuctionatorTabs_Selling ~= nil then
				AuctionatorTabs_Selling:SetScript("OnUpdate", auctionatorsectab)
			end
		end
		if funcionshow4 == nil then
			AuctionatorSellingFrameBagListingScrollFrame:SetScript("OnUpdate", handlebuttonsselltab )
		end
		if funcionshow5 == nil then
			if AuctionatorTabs_Cancelling ~= nil then
				AuctionatorTabs_Cancelling:SetScript("OnUpdate", auctionatorthrtab)
			end
		end
		if funcionshow6 == nil then
			if AuctionatorTabs_Auctionator ~= nil then
				AuctionatorTabs_Auctionator:SetScript("OnUpdate", fourauctionatortab)
			end
		end
	end)
end)


