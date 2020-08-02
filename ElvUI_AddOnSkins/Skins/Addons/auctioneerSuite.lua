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

	local function skinMoneyFrame(obj)
		if obj.gold then S:HandleEditBox(obj.gold) end
		if obj.silver then S:HandleEditBox(obj.silver) end
		if obj.copper then S:HandleEditBox(obj.copper) end
	end

	local function skinEditBox(obj)
		if not obj then return end

		local objName = obj:GetName()
		if objName then
			_G[objName.."Left"]:Kill()
			_G[objName.."Middle"]:Kill()
			_G[objName.."Right"]:Kill()
		else
			for i = 1, obj:GetNumRegions() do
				local region = select(i, obj:GetRegions())
				if region and region.IsObjectType and region:IsObjectType("Texture") then
					if region:GetTexture() == "Interface\\Common\\Common-Input-Border" then
						region:Hide()
					end
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
			local frame = Appraiser.Private.frame

			frame.itembox:SetBackdrop(nil)
			frame.itembox:CreateBackdrop("Transparent")
			frame.itembox.backdrop:Point("TOPLEFT")
			frame.itembox.backdrop:Point("BOTTOMRIGHT", -10, 0)

			frame.salebox:SetTemplate("Transparent")
			frame.manifest:SetTemplate("Transparent")

			frame.imageview:SetTemplate("Transparent")
			frame.imageview.purchase:SetBackdrop(nil)

			frame.manifest:ClearAllPoints()
			frame.manifest:Point("TOPLEFT", frame, "TOPRIGHT", -1, 0)
			frame.manifest:Point("BOTTOM", frame, "BOTTOM", 0, 60)

			S:HandleCloseButton(frame.manifest.close)

			frame.itembox.showAuctions:SetPoint("BOTTOMRIGHT", frame.itembox, "TOPRIGHT", - 12 - Auc_Util_Appraiser_ShowAuctionsText:GetWidth(), 0)

			S:HandleCheckBox(frame.itembox.showAuctions)
			S:HandleCheckBox(frame.itembox.showHidden)
			S:HandleCheckBox(frame.salebox.numberonly)
			S:HandleCheckBox(frame.salebox.matcher)
			S:HandleCheckBox(frame.salebox.ignore)
			S:HandleCheckBox(frame.salebox.bulk)

			S:HandleButton(frame.toggleManifest)
			S:HandleButton(frame.config)
			S:HandleButton(frame.switchToStack)
			S:HandleButton(frame.switchToStack2)
			S:HandleButton(frame.imageview.purchase.buy)
			S:HandleButton(frame.imageview.purchase.bid)
			S:HandleButton(frame.go)
			S:HandleButton(frame.gobatch)
			S:HandleButton(frame.refresh)
			S:HandleButton(frame.cancel)

			S:HandleSliderFrame(frame.salebox.stack)
			S:HandleSliderFrame(frame.salebox.number)
			S:HandleSliderFrame(frame.salebox.duration)

			S:HandleEditBox(frame.salebox.numberentry)
			S:HandleEditBox(frame.salebox.stackentry)

			skinMoneyFrame(frame.salebox.bid)
			skinMoneyFrame(frame.salebox.buy)
			skinMoneyFrame(frame.salebox.bid.stack)
			skinMoneyFrame(frame.salebox.buy.stack)

			S:HandleDropDownBox(frame.salebox.model, 140)

			frame.salebox.slot:Hide()

			frame.salebox.icon:SetTemplate("Default")
			frame.salebox.icon:GetHighlightTexture():SetInside()
			frame.salebox.icon:GetHighlightTexture():SetTexture(1, 1, 1, 0.3)

			hooksecurefunc(Appraiser.Private.frame, "SelectItem", function(link)
				if not Appraiser.Private.frame.salebox.sig then return end

				Appraiser.Private.frame.salebox.icon:GetNormalTexture():SetTexCoord(unpack(E.TexCoords))
				Appraiser.Private.frame.salebox.icon:GetNormalTexture():SetInside()
			end)

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
		S:SecureHook(SearchUI, "CreateAuctionFrames", function()
			local frame = SearchUI.Private.gui.AuctionFrame

			if frame then
				frame.backing:SetTemplate("Transparent")
				frame.money:Hide()
			end

			S:Unhook(SearchUI, "CreateAuctionFrames")
		end)

		S:SecureHook(SearchUI, "MakeGuiConfig", function()
			local gui = SearchUI.Private.gui

			gui.frame:SetBackdrop(nil)
			gui.sheet.panel:SetTemplate("Transparent")

			gui.saves:Height(24)

			S:HandleEditBox(gui.saves.name)

			gui.saves.select.button:SetPoint("TOPRIGHT", -18, -3)
			S:HandleNextPrevButton(gui.saves.select.button)
			S:SetNextPrevButtonDirection(gui.saves.select.button)

			S:HandleButton(gui.saves.load)
			S:HandleButton(gui.saves.save)
			S:HandleButton(gui.saves.delete)
			S:HandleButton(gui.saves.reset)

			S:HandleButton(gui.Search)
			S:HandleButton(gui.frame.purchase)
			S:HandleButton(gui.frame.notnow)
			S:HandleButton(gui.frame.ignore)
			S:HandleButton(gui.frame.ignoreperm)
			S:HandleButton(gui.frame.snatch)
			S:HandleButton(gui.frame.clear)
			S:HandleButton(gui.frame.cancel)
			S:HandleButton(gui.frame.buyout)
			S:HandleButton(gui.frame.bid)
			S:HandleButton(gui.frame.progressbar.cancel)

			skinMoneyFrame(gui.frame.bidbox)

			gui.frame.progressbar:SetStatusBarTexture(E.media.normTex)
			E:RegisterStatusBar(gui.frame.progressbar)

			S:Unhook(SearchUI, "MakeGuiConfig")
		end)

		local RealTime = SearchUI.Searchers.RealTime
		if RealTime then
			S:SecureHook(RealTime, "HookAH", function()
				local button = AS:GetObjectChildren(AuctionFrameBrowse)

				button:Point("TOPRIGHT", AuctionFrameBrowse, "TOPLEFT", 310, -6)
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
		S:HandleButton(CompactUI.Private.switchUI)

		S:SecureHook(CompactUI.Private, "HookAH", function()
			local private = CompactUI.Private

			S:HandleCheckBox(private.PerItem)

			-- prevent main AH skin from repointing
			BrowsePrevPageButton.SetPoint = E.noop
			BrowseNextPageButton.SetPoint = E.noop
			BrowseSearchCountText.SetPoint = E.noop

			S:Unhook(CompactUI.Private, "MakeGuiConfig")
		end)
	end

	local ScanButton = AucAdvanced.Modules.Util.ScanButton
	if ScanButton then
		S:SecureHook(ScanButton.Private, "HookAH", function()
			local private = ScanButton.Private

			private.buttons:Point("TOPLEFT", AuctionFrameBrowse, 180, -6)

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

			frame.imageview:SetTemplate("Transparent")
			frame.imageview.sheet.panel:SetTemplate("Transparent")

			frame.name:Point("TOPLEFT", frame.slot, "TOPRIGHT", 10, 15)

			skinMoneyFrame(frame.minprice)
			skinMoneyFrame(frame.buyout)

			S:HandleEditBox(frame.stacks.num)
			S:HandleEditBox(frame.stacks.size)

			S:HandleButton(frame.create)
			S:HandleButton(frame.clear)
			S:HandleButton(frame.config)
			S:HandleButton(frame.scanbutton)
			S:HandleButton(frame.refresh)
			S:HandleButton(frame.bid)
			S:HandleButton(frame.buy)

			for _, obj in pairs(frame.options) do
				if type(obj) == "table" and obj.GetObjectType and obj:GetObjectType() == "CheckButton" then
					S:HandleCheckBox(obj)
				end
			end

			for pos in ipairs(frame.duration.time.intervals) do
				S:HandleCheckBox(frame.duration.time[pos])
			end

			frame.slot:Hide()

			frame.icon:SetTemplate("Default")
			frame.icon:GetHighlightTexture():SetInside()
			frame.icon:GetHighlightTexture():SetTexture(1, 1, 1, 0.3)

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
		S:SecureHook(Scan , "ProgressBars", function(self)
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