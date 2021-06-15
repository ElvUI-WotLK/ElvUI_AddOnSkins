local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

if not AS:IsAddonLODorEnabled("Auc-Advanced") then return end

local unpack = unpack

local hooksecurefunc = hooksecurefunc

-- AuctioneerSuite 5.8.4723
-- https://www.curseforge.com/wow/addons/auctioneer/files/427823

S:AddCallbackForAddon("Auc-Advanced", "Auc-Advanced", function()
	if not E.private.addOnSkins.AuctioneerSuite then return end

	AS:SkinLibrary("Configator")
	AS:SkinLibrary("LibExtraTip-1")

	local function setMoneyBackdropColor(self, r, g, b, a)
		if a == 0 then
			r, g, b = unpack(E.media.bordercolor)
			self.backdrop:SetBackdropBorderColor(r, g, b, 1)
		else
			self.backdrop:SetBackdropBorderColor(r, g, b, a)
		end
	end
	local function skinMoneyFrame(obj, hookBackdropColor)
		if obj.gold then
			S:HandleEditBox(obj.gold)
			if hookBackdropColor then
				obj.gold:SetBackdrop(nil)
				obj.gold.SetBackdropColor = setMoneyBackdropColor
			end
		end
		if obj.silver then
			S:HandleEditBox(obj.silver)
			if hookBackdropColor then
				obj.silver:SetBackdrop(nil)
				obj.silver.SetBackdropColor = setMoneyBackdropColor
			end
		end
		if obj.copper then
			S:HandleEditBox(obj.copper)
			if hookBackdropColor then
				obj.copper:SetBackdrop(nil)
				obj.copper.SetBackdropColor = setMoneyBackdropColor
			end
		end
	end

	local function skinEditBox(obj)
		if not obj then return end

		local objName = obj:GetName()
		if objName then
			_G[objName.."Left"]:Hide()
			_G[objName.."Middle"]:Hide()
			_G[objName.."Right"]:Hide()
		else
			for i = 1, obj:GetNumRegions() do
				local region = select(i, obj:GetRegions())
				if region.IsObjectType and region:IsObjectType("Texture") and region:GetTexture() == "Interface\\Common\\Common-Input-Border" then
					region:Hide()
				end
			end
		end

		obj:Height(17)
		obj:CreateBackdrop("Default")
		obj.backdrop:Point("TOPLEFT", -2, 0)
		obj.backdrop:Point("BOTTOMRIGHT", 2, 0)
		obj.backdrop:SetParent(obj:GetParent())
		obj:SetParent(obj.backdrop)
	end

	local Appraiser = AucAdvanced.Modules.Util.Appraiser
	if Appraiser then
		S:SecureHook(Appraiser.Private, "CreateFrames", function()
			AucAdvanced.Settings.SetDefault("util.mover.anchors", {"TOPLEFT", UIParent, "TOPLEFT", 0, -116})

			local frame = Appraiser.Private.frame

			local title = frame:GetRegions()
			title:Point("TOPLEFT", 80, -10)

			frame.toggleManifest:Point("TOPRIGHT", -30, -8)
			frame.config:Point("TOPRIGHT", frame.toggleManifest, "TOPLEFT", -3, 0)

			S:HandleButton(frame.toggleManifest)
			S:HandleButton(frame.config)
			S:HandleButton(frame.switchToStack)
			S:HandleButton(frame.switchToStack2)
			S:HandleButton(frame.go)
			S:HandleButton(frame.gobatch)
			S:HandleButton(frame.refresh)
			S:HandleButton(frame.cancel)

			frame.go:Height(22)
			frame.go:Point("BOTTOMRIGHT", -8, 31)
			frame.gobatch:Height(22)
			frame.gobatch:Point("BOTTOMRIGHT", -91, 31)
			frame.refresh:Height(22)
			frame.refresh:Point("BOTTOMRIGHT", -174, 31)
			frame.cancel:Size(24, 22)
			frame.cancel:Point("BOTTOMLEFT", 180, 31)

			-- Left Panel
			frame.itembox:SetTemplate("Transparent")
			frame.itembox:Size(230, 339)
			frame.itembox:Point("TOPLEFT", 19, -48)

			frame.itembox.showAuctions:Point("BOTTOMRIGHT", frame.itembox, "TOPRIGHT", -30 -Auc_Util_Appraiser_ShowAuctionsText:GetWidth(), 0)
			frame.itembox.showText:Point("BOTTOMRIGHT", frame.itembox.showHidden, "BOTTOMLEFT", 0, 1)

			S:HandleSliderFrame(frame.scroller)
			frame.scroller:SetPoint("TOPRIGHT", 0, 0)
			frame.scroller:SetPoint("BOTTOM", 0, 0)

			for i, item in ipairs(frame.items) do
				if i == 1 then
					item:Point("TOPLEFT", 4, -8)
				end
				item:Point("RIGHT", frame.itembox, "RIGHT", -15,0)

				S:HandleButtonHighlight(item)

				item.name:Point("TOPLEFT", item.icon, "TOPRIGHT", 3, 0)
				item.info:Point("BOTTOMLEFT", item.icon, "BOTTOMRIGHT", 3, -2)
				item.bg:Hide()

				item.iconbutton:SetTemplate("Default")

				item.icon:SetInside()
				item.icon:SetTexCoord(unpack(E.TexCoords))
			end

			-- SaleBox
			frame.salebox:SetTemplate("Transparent")
			frame.salebox:Point("TOPLEFT", frame.itembox, "TOPRIGHT", 3, 12)
			frame.salebox:Point("RIGHT", -8, 0)

			S:HandleCheckBox(frame.salebox.numberonly)
			S:HandleCheckBox(frame.salebox.matcher)
			S:HandleCheckBox(frame.salebox.ignore)
			S:HandleCheckBox(frame.salebox.bulk)

			S:HandleSliderFrame(frame.salebox.stack)
			S:HandleSliderFrame(frame.salebox.number)
			S:HandleSliderFrame(frame.salebox.duration)

			S:HandleEditBox(frame.salebox.numberentry)
			S:HandleEditBox(frame.salebox.stackentry)

			skinMoneyFrame(frame.salebox.bid, true)
			skinMoneyFrame(frame.salebox.buy, true)
			skinMoneyFrame(frame.salebox.bid.stack, true)
			skinMoneyFrame(frame.salebox.buy.stack, true)

			S:HandleDropDownBox(frame.salebox.model, 140)

			frame.salebox.slot:SetTexture(nil)

			frame.salebox.slotBackdrop = CreateFrame("Frame", nil, frame.salebox)
			frame.salebox.slotBackdrop:SetTemplate("Default")
			frame.salebox.slotBackdrop:SetOutside(frame.salebox.icon)

			frame.salebox.icon:GetHighlightTexture():SetTexture(1, 1, 1, 0.3)

			hooksecurefunc(Appraiser.Private.frame, "SelectItem", function(link)
				if not Appraiser.Private.frame.salebox.sig then return end

				Appraiser.Private.frame.salebox.icon:GetNormalTexture():SetTexCoord(unpack(E.TexCoords))
			end)

			-- ImageView
			frame.imageview:SetTemplate("Transparent")
			frame.imageview:Point("TOPLEFT", frame.salebox, "BOTTOMLEFT", 0, -3)
			frame.imageview:SetPoint("BOTTOM", frame.itembox, "BOTTOM", 0, 0)
			frame.imageview.purchase:SetBackdrop(nil)

			frame.imageview.purchase:Point("TOPLEFT", frame.imageview, "BOTTOMLEFT", 0, 23)
			frame.imageview.purchase:SetPoint("BOTTOMRIGHT", 0, 0)

			S:HandleCheckBox(frame.itembox.showAuctions)
			S:HandleCheckBox(frame.itembox.showHidden)

			S:HandleButton(frame.imageview.purchase.buy)
			S:HandleButton(frame.imageview.purchase.bid)

			-- Manifest
			frame.manifest:SetTemplate("Transparent")
			frame.manifest:Point("TOPLEFT", frame, "TOPRIGHT", -1, 0)
			frame.manifest:Point("BOTTOM", 0, 60)

			frame.manifest.close:Size(32)
			S:HandleCloseButton(frame.manifest.close, frame.manifest)

			-- SellerIgnore
			frame.sellerIgnore:SetTemplate("Transparent")

			frame.sellerIgnore.help:Point("CENTER", frame.sellerIgnore, "TOP", 0, -20)

			frame.sellerIgnore.yes:Height(21)
			S:HandleButton(frame.sellerIgnore.yes)

			frame.sellerIgnore.no:Height(21)
			S:HandleButton(frame.sellerIgnore.no)

			S:Unhook(Appraiser.Private,"CreateFrames")
		end)
	end

	local AutoMagic = AucAdvanced.Modules.Util.AutoMagic
	if AutoMagic then
		local frame = autosellframe

		frame:SetTemplate("Transparent")
		frame.baglist:SetTemplate("Transparent")
		frame.resultlist:SetTemplate("Transparent")

		S:HandleScrollBar(frame.baglist.sheet.panel.vScroll)
		S:HandleScrollBar(frame.resultlist.sheet.panel.vScroll)
		S:HandleScrollBar(frame.resultlist.sheet.panel.hScroll, true)

		S:HandleButton(frame.additem)
		S:HandleButton(frame.removeitem)
		S:HandleButton(frame.bagList)
		S:HandleButton(frame.closeButton)

		frame.slot:CreateBackdrop("Default")
		frame.slot.backdrop:Point("TOPLEFT", frame.slot, 3, -3)
		frame.slot.backdrop:Point("BOTTOMRIGHT", frame.slot, -4, 4)
		frame.slot:SetTexture(nil)
		frame.slot:SetTexCoord(unpack(E.TexCoords))

		frame.icon:GetHighlightTexture():SetInside()
		frame.icon:GetHighlightTexture():SetTexture(1, 1, 1, 0.3)

		hooksecurefunc(frame, "ClearIcon", function()
			frame.slot:SetTexture(nil)
		end)
	end

	local Glypher = AucAdvanced.Modules.Util.Glypher
	if Glypher then
		S:SecureHook(Glypher.Private, "SetupConfigGui", function()
			local frame = Glypher.Private.frame

			S:HandleButton(frame.refreshButton)
			S:HandleButton(frame.searchButton)
			S:HandleButton(frame.skilletButton)

			frame.glypher:SetTemplate("Transparent")

			S:Unhook(Glypher.Private, "SetupConfigGui")
		end)
	end

	local GlypherPost = AucAdvanced.Modules.Util.GlypherPost
	if GlypherPost then
		S:SecureHook(GlypherPost.Private, "SetupConfigGui", function()
			S:HandleButton(GlypherPost.Private.frame.refreshButton)
			S:Unhook(GlypherPost.Private, "SetupConfigGui")
		end)
	end

	local SearchUI = AucAdvanced.Modules.Util.SearchUI
	if SearchUI then
		local private = SearchUI.Private

		function SearchUI.AttachToAH()
			if private.isAttached then return end
			local gui = private.gui
			gui.buttonTop = -43
			local height, width = 410, 830
			gui:SetPosition(gui.AuctionFrame, width, height, 7, 21 + height)
			gui:HideBackdrop()
			gui:EnableMouse(false)
			gui:RealSetScale(0.9999)
			gui:RealSetScale(1.0)
			gui:Show()
			private.isAttached = true
		end

		S:SecureHook(SearchUI, "CreateAuctionFrames", function()
			local frame = private.gui.AuctionFrame

			if frame then
				frame.title:Point("TOP", 0, -5)

				frame.scanslabel:Point("TOPLEFT", 50, -28)

				frame.backing:SetBackdrop(nil)
				frame.money:Hide()

				S:Unhook(SearchUI, "CreateAuctionFrames")
			end
		end)

		S:SecureHook(SearchUI, "MakeGuiConfig", function()
			local gui = private.gui

			-- Top Buttons
			gui.saves:Height(24)
			gui.saves:Point("TOPRIGHT", -5, -6)

			S:HandleEditBox(gui.saves.name)

			gui.saves.select.button:Point("TOPRIGHT", -18, -3)
			S:HandleNextPrevButton(gui.saves.select.button, "down", {1, 0.8, 0})

			S:HandleButton(gui.saves.load)
			S:HandleButton(gui.saves.save)
			S:HandleButton(gui.saves.delete)
			S:HandleButton(gui.saves.reset)

			-- Left Panel
			gui.LeftBackground = CreateFrame("Frame", nil, gui)
			gui.LeftBackground.SetFrameLevel = E.noop
			gui.LeftBackground:SetTemplate("Transparent")
			gui.LeftBackground:Size(150, 317)
			gui.LeftBackground:Point("TOPLEFT", 12, -33)

			gui.buttons[1]:Point("TOPLEFT", 12, -34)
			gui.buttons[1].SetPoint = E.noop

			-- Right Panel
			for _, tab in ipairs(gui.tabs) do
				tab.topOffset = 23
				tab.expandGap = 26
				tab.frame:Point("TOPLEFT", 160 + tab.leftOffset, -10 - tab.topOffset)
			end

			gui.frame:SetTemplate("Transparent")
			gui.frame:Point("TOP", 0, -119)
			gui.frame:Point("LEFT", gui:GetButton(1), "RIGHT", 3, 0)
			gui.frame:Point("BOTTOMRIGHT", gui.Done, "TOPRIGHT", -5, 31)

			-- Bottom Buttons
			S:HandleButton(gui.Search)
			S:HandleButton(gui.frame.cancel)
			S:HandleButton(gui.frame.purchase)
			S:HandleButton(gui.frame.notnow)
			S:HandleButton(gui.frame.ignore)
			S:HandleButton(gui.frame.ignoreperm)
			S:HandleButton(gui.frame.snatch)
			S:HandleButton(gui.frame.clear)
			S:HandleButton(gui.frame.buyout)
			S:HandleButton(gui.frame.bid)

			skinMoneyFrame(gui.frame.bidbox)

			gui.Search:Point("BOTTOMLEFT", 72, 34)
			gui.frame.cancel:Size(24, 21)
			gui.frame.cancel:Point("BOTTOMLEFT", gui, "BOTTOMLEFT", 39, 34)

			gui.frame.purchase:Point("BOTTOMLEFT", gui, "BOTTOMLEFT", 170, 34)
			gui.frame.notnow:Point("BOTTOMLEFT", gui, "BOTTOMLEFT", 263, 34)
			gui.frame.ignore:Point("BOTTOMLEFT", gui, "BOTTOMLEFT", 400, 34)
			gui.frame.ignoreperm:Point("BOTTOMLEFT", gui, "BOTTOMLEFT", 493, 34)
			gui.frame.snatch:Point("BOTTOMLEFT", gui, "BOTTOMLEFT", 650, 34)
			gui.frame.bidbox:Point("BOTTOMRIGHT", gui.frame.bid, "BOTTOMLEFT", -4, 3)

			-- ProgressBar
			gui.frame.progressbar:SetTemplate("Transparent")
			gui.frame.progressbar:SetStatusBarTexture(E.media.normTex)
			E:RegisterStatusBar(gui.frame.progressbar)

			S:HandleButton(gui.frame.progressbar.cancel)

			S:Unhook(SearchUI, "MakeGuiConfig")
		end)

		local RealTime = SearchUI.Searchers.RealTime
		if RealTime then
			S:SecureHook(RealTime, "HookAH", function()
				local button = AS:GetObjectChildren(AuctionFrameBrowse)

				button:Point("TOPRIGHT", AuctionFrameBrowse, "TOPLEFT", 229, -6)
				S:HandleButton(button.control)

				S:Unhook(RealTime, "HookAH")
			end)
		end

		local Snatch = SearchUI.Searchers.Snatch
		if Snatch then
			S:SecureHook(Snatch, "MakeGuiConfig", function(self, gui)
				local frame = self.Private.frame

				frame.snatchlist:SetBackdrop(nil)

				frame.slot:Hide()

				frame.icon:SetTemplate("Default")
				frame.icon:GetHighlightTexture():SetInside()
				frame.icon:GetHighlightTexture():SetTexture(1, 1, 1, 0.3)

				skinMoneyFrame(frame.money)
				skinEditBox(frame.pctBox)

				S:HandleButton(frame.additem)
				S:HandleButton(frame.removeitem)
				S:HandleButton(frame.resetList)

				S:Unhook(Snatch, "MakeGuiConfig")
			end)

			hooksecurefunc(Snatch, "SetWorkingItem", function(link)
				if not Snatch.Private.workingItemLink then return end

				Snatch.Private.frame.icon:GetNormalTexture():SetTexCoord(unpack(E.TexCoords))
				Snatch.Private.frame.icon:GetNormalTexture():SetInside()
			end)
		end

		local ItemPrice = SearchUI.Filters.ItemPrice
		if ItemPrice then
			S:SecureHook(ItemPrice, "MakeGuiConfig", function(self, gui)
				local t, id = gui:GetTabByName(ItemPrice.tabname, "Filters")
				if t then
					local ignorelistGUI, removebutton = AS:GetObjectChildren(gui.tabs[id][3], -1, true)
					ignorelistGUI:SetTemplate("Default")
					S:HandleButton(removebutton)
				end

				S:Unhook(ItemPrice, "MakeGuiConfig")
			end)
		end
	end

	local CompactUI = AucAdvanced.Modules.Util.CompactUI
	if CompactUI then
		local private = CompactUI.Private

		S:HandleButton(private.switchUI)

		-- SellerIgnore
		private.sellerIgnore:SetTemplate("Transparent")

		private.sellerIgnore.help:Point("CENTER", private.sellerIgnore, "TOP", 0, -20)

		private.sellerIgnore.yes:Height(21)
		S:HandleButton(private.sellerIgnore.yes)

		private.sellerIgnore.no:Height(21)
		S:HandleButton(private.sellerIgnore.no)

		S:SecureHook(private, "HookAH", function()
			private.switchUI:Point("TOPRIGHT", AuctionFrameBrowse, "TOPRIGHT", -120, -6)

			BrowseButton1:Point("TOPLEFT", 188, -87)

			local i = 1
			local button = _G["BrowseButton"..i]
			while button do
				button.Icon:SetTexCoord(unpack(E.TexCoords))

				i = i + 1
				button = _G["BrowseButton"..i]
			end
			_G["BrowseButton"..(i - 1)]:Show()

			local _, tex = BrowsePrevPageButton:GetPoint()
			tex:Size(614, 32)
			tex:Point("TOPLEFT", private.buttons[#private.buttons].Count, "BOTTOMLEFT", 0, -1)

			S:HandleCheckBox(private.PerItem)
			private.PerItem:Point("TOPLEFT", tex, "TOPLEFT", 3, -3)
			private.PerItem:SetFrameLevel(AuctionFrameBrowse:GetFrameLevel() + 2)

			BrowseSearchCountText:Point("BOTTOMRIGHT", tex, "BOTTOMRIGHT", -40, 20)

			-- prevent main AH skin from repointing
			BrowseButton1.SetPoint = E.noop
			BrowsePrevPageButton.SetPoint = E.noop
			BrowseNextPageButton.SetPoint = E.noop
			BrowseSearchCountText.SetPoint = E.noop

			S:Unhook(private, "HookAH")
		end)
	end

	local ScanButton = AucAdvanced.Modules.Util.ScanButton
	if ScanButton then
		S:SecureHook(ScanButton.Private, "HookAH", function()
			local private = ScanButton.Private

			private.buttons:Point("TOPLEFT", AuctionFrameBrowse, 100, -6)

			S:HandleButton(private.buttons.stop)
			S:HandleButton(private.buttons.play)
			S:HandleButton(private.buttons.pause)
			S:HandleButton(private.buttons.getall)

			private.message:SetTemplate("Transparent")
			S:HandleButton(private.message.Done)

			S:Unhook(ScanButton.Private, "HookAH")
		end)
	end

	local SimpleAuction = AucAdvanced.Modules.Util.SimpleAuction
	if SimpleAuction then
		S:SecureHook(SimpleAuction.Private, "CreateFrames", function()
			local frame = SimpleAuction.Private.frame

			-- BrowseFrame
			S:HandleButton(frame.scanbutton)
			frame.scanbutton:Height(22)
			frame.scanbutton:Point("LEFT", AuctionFrameMoneyFrame, "RIGHT", 6, -1)

			-- PostFrame
			frame.title:Point("TOP", 0, -5)

			S:HandleButton(frame.config)
			frame.config:Point("TOPRIGHT", -30, -8)

			frame.slot:SetTexture(nil)
			frame.slot:Size(42)
			frame.slot:Point("TOPLEFT", 80, -24)

			frame.name:Point("TOPLEFT", frame.slot, "TOPRIGHT", 6, 0)

			frame.icon:SetTemplate("Default")
			frame.icon:SetPoint("TOPLEFT", frame.slot, "TOPLEFT", 0, 0)
			frame.icon:GetHighlightTexture():SetInside()
			frame.icon:GetHighlightTexture():SetTexture(1, 1, 1, 0.3)

			S:HandleButton(frame.refresh)
			S:HandleButton(frame.bid)
			S:HandleButton(frame.buy)

			frame.refresh:Height(22)
			frame.refresh:Point("BOTTOMRIGHT", -174, 31)
			frame.bid:Height(22)
			frame.bid:Point("TOPLEFT", frame.refresh, "TOPRIGHT", 3, 0)
			frame.buy:Height(22)
			frame.buy:Point("TOPLEFT", frame.bid, "TOPRIGHT", 3, 0)

			-- Left Panel
			frame.LeftBackground = CreateFrame("Frame", nil, frame)
			frame.LeftBackground:SetFrameLevel(frame:GetFrameLevel() - 1)
			frame.LeftBackground:SetTemplate("Transparent")
			frame.LeftBackground:Point("TOPLEFT", 19, -75)
			frame.LeftBackground:Point("BOTTOMRIGHT", -648, 60)

			skinMoneyFrame(frame.minprice)
			skinMoneyFrame(frame.buyout)

			S:HandleEditBox(frame.stacks.num)
			S:HandleEditBox(frame.stacks.size)

			S:HandleButton(frame.create)
			S:HandleButton(frame.clear)

			for pos in ipairs(frame.duration.time.intervals) do
				S:HandleCheckBox(frame.duration.time[pos])
			end

			for _, obj in pairs(frame.options) do
				if type(obj) == "table" and obj.GetObjectType and obj:GetObjectType() == "CheckButton" then
					S:HandleCheckBox(obj)
				end
			end

			frame.minprice:Point("TOPLEFT", 24, -92)

			frame.options:Point("TOPLEFT", frame.stacks, "BOTTOMLEFT", 0, -37)

			frame.create:Width(157)
			frame.create:Point("BOTTOMRIGHT", AuctionFrameMoneyFrame, "TOPRIGHT", -1, 14)
			frame.clear:Width(157)
			frame.clear:Point("BOTTOMRIGHT", frame.create, "TOPRIGHT", 0, 3)

			-- ImageView
			frame.imageview:SetTemplate("Transparent")
			frame.imageview:Point("TOPLEFT", 187, -75)
			frame.imageview:Point("TOPRIGHT", -8, 0)
			frame.imageview:Point("BOTTOM", 0, 60)

			S:Unhook(SimpleAuction.Private, "CreateFrames")
		end)

		hooksecurefunc(SimpleAuction.Private, "LoadItemLink", function(link)
			if not SimpleAuction.Private.frame.icon.itemLink then return end

			SimpleAuction.Private.frame.icon:GetNormalTexture():SetTexCoord(unpack(E.TexCoords))
			SimpleAuction.Private.frame.icon:GetNormalTexture():SetInside()
		end)
	end

	local Scan = AucAdvanced.Scan
	if Scan then
		hooksecurefunc(Scan , "ProgressBars", function(self)
			if self.isSkinned then return end

			self:SetTemplate("Transparent")
			self:SetStatusBarTexture(E.media.normTex)
			E:RegisterStatusBar(self)

			self.isSkinned = true
		end)
	end

	if AucAdvanced.Buy then
		AucAdvanced.Buy.Private.Prompt.Frame:SetTemplate("Transparent")
		S:HandleEditBox(AucAdvanced.Buy.Private.Prompt.Reason)
		S:HandleButton(AucAdvanced.Buy.Private.Prompt.Yes)
		S:HandleButton(AucAdvanced.Buy.Private.Prompt.No)
	end
end)

S:AddCallbackForAddon("Auc-Filter-Basic", "Auc-Filter-Basic", function()
	if not E.private.addOnSkins.AuctioneerSuite then return end

	S:HandleButton(BasicFilter_IgnoreList_IgnorePlayerButton)
	S:HandleButton(BasicFilter_IgnoreList_StopIgnoreButton)

	BasicFilter_IgnoreList_ScrollFrame:StripTextures()
	S:HandleScrollBar(BasicFilter_IgnoreList_ScrollFrameScrollBar)
end)

S:AddCallbackForAddon("Auc-Stat-Histogram", "Auc-Stat-Histogram", function()
	if not E.private.addOnSkins.AuctioneerSuite then return end

	local StatHistogram = AucAdvanced.GetModule("Stat", "Histogram")
	if StatHistogram then
		S:SecureHook(StatHistogram.Private, "SetupConfigGui", function()
			local frame = StatHistogram.Private.frame

			frame.slot:Hide()

			frame.icon:SetTemplate("Default")
			frame.icon:GetHighlightTexture():SetInside()
			frame.icon:GetHighlightTexture():SetTexture(1, 1, 1, 0.3)

			frame.bargraph:SetTemplate("Default")

			S:Unhook(StatHistogram.Private, "SetupConfigGui")
		end)

		hooksecurefunc(StatHistogram, "SetWorkingItem", function(link)
			if not StatHistogram.Private.frame.link then return end

			StatHistogram.Private.frame.icon:GetNormalTexture():SetTexCoord(unpack(E.TexCoords))
			StatHistogram.Private.frame.icon:GetNormalTexture():SetInside()
		end)
	end
end)