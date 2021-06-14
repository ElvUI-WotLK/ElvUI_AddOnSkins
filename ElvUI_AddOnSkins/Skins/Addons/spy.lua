local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

if not AS:IsAddonLODorEnabled("Spy") then return end

local _G = _G

-- Spy 1.2
-- https://www.curseforge.com/wow/addons/spy/files/442604

S:AddCallbackForAddon("Spy", "Spy", function()
	if not E.private.addOnSkins.Spy then return end

	Spy_AlertWindow:StripTextures()
	Spy_AlertWindow:SetTemplate("Transparent")
	Spy_AlertWindow:Point("TOP", UIParent, "TOP", 0, -130)

	Spy.AlertWindow.Title:FontTemplate()
	Spy.AlertWindow.Name:FontTemplate()
	Spy.AlertWindow.Location:FontTemplate()

	Spy_MainWindow:StripTextures()
	Spy_MainWindow:CreateBackdrop("Transparent")
	Spy_MainWindow.backdrop:Point("TOPLEFT", 0, -10)
	Spy_MainWindow.backdrop:Point("BOTTOMRIGHT", 0, 12)

	Spy.MainWindow.Title:FontTemplate()

	S:HandleCloseButton(Spy_MainWindow.CloseButton)
	Spy_MainWindow.CloseButton:Size(32)
	Spy_MainWindow.CloseButton:Point("TOPRIGHT", 3, -6)

	S:HandleNextPrevButton(Spy_MainWindow.RightButton, "right", nil, true)
	Spy_MainWindow.RightButton:Size(20)
	Spy_MainWindow.RightButton:Point("TOPRIGHT", -22, -12)

	S:HandleNextPrevButton(Spy_MainWindow.LeftButton, "left", nil, true)
	Spy_MainWindow.LeftButton:Size(20)
	Spy_MainWindow.LeftButton:SetPoint("RIGHT", Spy_MainWindow.RightButton, "LEFT", 0, 0)

	Spy_MainWindow.ClearButton:Size(18)
	Spy_MainWindow.ClearButton:Point("RIGHT", Spy_MainWindow.LeftButton, "LEFT", 1, 0)
	Spy_MainWindow.ClearButton:SetNormalTexture(E.Media.Textures.Minus)
	Spy_MainWindow.ClearButton:SetPushedTexture(nil)
	Spy_MainWindow.ClearButton:SetHighlightTexture(nil)
	Spy_MainWindow.ClearButton:HookScript("OnEnter", function(self) self:GetNormalTexture():SetVertexColor(unpack(E.media.rgbvaluecolor)) end)
	Spy_MainWindow.ClearButton:HookScript("OnLeave", function(self) self:GetNormalTexture():SetVertexColor(1, 1, 1) end)

	Spy_MainWindow.DragBottomLeft:SetNormalTexture(nil)
	Spy_MainWindow.DragBottomRight:SetNormalTexture(nil)

	local function SkinBar(bar, i)
		if bar.isSkinned then return end

		bar:GetHighlightTexture():SetTexture(1, 1, 1, 0.3)
		bar.LeftText:FontTemplate()
		bar.RightText:FontTemplate()

		bar:SetPoint("TOPLEFT", Spy.MainWindow, "TOPLEFT", 1, -33 - (Spy.db.profile.MainWindow.RowHeight + Spy.db.profile.MainWindow.RowSpacing) * (i - 1))
		bar:SetWidth(Spy.MainWindow:GetWidth() - 2)

		bar.isSkinned = true
	end

	for i = 1, Spy.ButtonLimit do
		SkinBar(_G["Spy_MainWindow_Bar"..i], i)
	end

	hooksecurefunc(Spy, "CreateRow", function(self, num)
		SkinBar(Spy.MainWindow.Rows[num], num)
	end)

	hooksecurefunc(Spy, "ResizeMainWindow", function()
		local CurWidth = Spy.MainWindow:GetWidth() - 2
		for i, row in pairs(Spy.MainWindow.Rows) do
			row:SetWidth(CurWidth)
		end
	end)

	hooksecurefunc(Spy, "RestoreMainWindowPosition", function(self, _, _, width)
		for i = 1, Spy.ButtonLimit do
			Spy.MainWindow.Rows[i]:SetWidth(width - 2)
		end
	end)

	hooksecurefunc(Spy, "ShowMapTooltip", function()
		if Spy.MapTooltip then
			Spy.MapTooltip:SetTemplate("Transparent")
		end
	end)

	-- for backported version
	if Spy.MainWindow.TitleBar then
		Spy_MainWindow.backdrop:Point("TOPLEFT", 0, -32)
		Spy_MainWindow.backdrop:Point("BOTTOMRIGHT", 0, 2)

		Spy.MainWindow.TitleBar:SetTemplate()

		Spy_MainWindow.StatsButton:Size(18)
		Spy_MainWindow.StatsButton:Point("RIGHT", Spy_MainWindow.ClearButton, "LEFT", 2, 0)
		Spy_MainWindow.StatsButton:SetNormalTexture(E.Media.Textures.Copy)
		Spy_MainWindow.StatsButton:SetPushedTexture(nil)
		Spy_MainWindow.StatsButton:SetHighlightTexture(nil)
		Spy_MainWindow.StatsButton:HookScript("OnEnter", function(self) self:GetNormalTexture():SetVertexColor(unpack(E.media.rgbvaluecolor)) end)
		Spy_MainWindow.StatsButton:HookScript("OnLeave", function(self) self:GetNormalTexture():SetVertexColor(1, 1, 1) end)

		Spy_MainWindow.CountFrame:Size(20)
		Spy_MainWindow.CountFrame:Point("RIGHT", Spy_MainWindow.StatsButton, "LEFT", 1, 0)
		Spy_MainWindow.CountButton:Size(20)
		Spy_MainWindow.CountButton:Point("RIGHT", Spy_MainWindow.StatsButton, "LEFT", 1, 0)
		Spy.MainWindow.CountFrame.Text:FontTemplate()
		Spy_MainWindow.CountButton:HookScript("OnEnter", function() Spy_MainWindow.CountFrame.Text:SetTextColor(unpack(E.media.rgbvaluecolor)) end)
		Spy_MainWindow.CountButton:HookScript("OnLeave", function() Spy_MainWindow.CountFrame.Text:SetTextColor(1, 1, 1) end)

		SpyStatsFrame:SetTemplate("Transparent")
		SpyStatsFrame_Header:Hide()

		S:HandleCloseButton(SpyStatsFrameTopCloseButton)

		S:HandleButton(SpyStatsRefreshButton)
		SpyStatsTabFrameTabContentFrame:SetTemplate("Transparent")
		S:HandleScrollBar(SpyStatsTabFrameTabContentFrameScrollFrameScrollBar)
		SpyStatsFilterBox:SetTemplate()
		S:HandleCheckBox(SpyStatsKosCheckbox)
		S:HandleCheckBox(SpyStatsWinsLosesCheckbox)
		S:HandleCheckBox(SpyStatsReasonCheckbox)

		function Spy:BarsChanged()
			for k, v in pairs(Spy.MainWindow.Rows) do
				v:SetHeight(Spy.db.profile.MainWindow.RowHeight)
				v:SetPoint("TOPLEFT", Spy.MainWindow, "TOPLEFT", 1, -33 - (Spy.db.profile.MainWindow.RowHeight + Spy.db.profile.MainWindow.RowSpacing) * (k - 1))
			end
			Spy:ResizeMainWindow()
		end

		function Spy:UpdateActiveCount()
			local activeCount = 0
			for _ in pairs(Spy.ActiveList) do
				activeCount = activeCount + 1
			end
			Spy.MainWindow.CountFrame.Text:SetText(activeCount)
		end
	end
end)