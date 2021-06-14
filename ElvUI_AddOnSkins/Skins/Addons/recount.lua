local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

if not AS:IsAddonLODorEnabled("Recount") then return end


local _G = _G

-- Recount 4.0.1
-- https://www.wowace.com/projects/recount/files/458517

S:AddCallbackForAddon("Recount", "Recount", function()
	if not E.private.addOnSkins.Recount then return end

	local function skinFrame(frame)
		frame:SetTemplate("Transparent")

		frame.Title:ClearAllPoints()
		frame.Title:Point("TOP", frame, "TOP", 0, -5)
		frame.Title:FontTemplate()
		frame.Title:SetTextColor(1, 0.82, 0, 1)

		S:HandleCloseButton(frame.CloseButton)
		frame.CloseButton:ClearAllPoints()
		frame.CloseButton:Point("TOPRIGHT", frame, "TOPRIGHT", -2, -2)
	end

	local function skinMainFrame(frame)
		frame:SetBackdrop(nil)

		local backdrop = CreateFrame("Frame", nil, frame)
		backdrop:SetFrameLevel(frame:GetFrameLevel() - 1)
		backdrop:Point("BOTTOMLEFT", frame, E.PixelMode and 1 or 0, E.PixelMode and 1 or 0)
		backdrop:Point("TOPRIGHT", frame, E.PixelMode and -1 or 0, -(E.PixelMode and 31 or 30))
		backdrop:SetTemplate(E.db.addOnSkins.recountTemplate, E.db.addOnSkins.recountTemplate == "Default" and E.db.addOnSkins.recountTemplateGloss or false)
		frame.backdrop = backdrop

		local header = CreateFrame("Frame", nil, backdrop)
		header:Height(22)
		header:Point("TOPLEFT", frame, E.PixelMode and 1 or 0, -(E.PixelMode and 8 or 7))
		header:Point("TOPRIGHT", frame, E.PixelMode and -1 or 0, 0)
		header:SetTemplate(E.db.addOnSkins.recountTitleTemplate, E.db.addOnSkins.recountTitleTemplate == "Default" and E.db.addOnSkins.recountTitleTemplateGloss or false)
		frame.header = header

		frame.Title:ClearAllPoints()
		frame.Title:Point("LEFT", header, 6, 0)

		S:HandleCloseButton(frame.CloseButton)
		frame.CloseButton:ClearAllPoints()
		frame.CloseButton:Point("RIGHT", header, -6, 0)
		frame.CloseButton.Texture:Size(10)

		frame.RightButton:Size(18)
		frame.LeftButton:Size(18)
		S:HandleNextPrevButton(frame.RightButton, "right", nil, true)
		S:HandleNextPrevButton(frame.LeftButton, "left", nil, true)

		Recount:SetupMainWindowButtons()

		frame.DragBottomLeft:SetNormalTexture(nil)
		frame.DragBottomRight:SetNormalTexture(nil)
	end

	hooksecurefunc(Recount, "AddWindow", function(self, window)
		if window:GetName() == "Recount_ReportWindow" then
			if Recount_ReportWindow.isSkinned then return end

			skinFrame(Recount_ReportWindow)

			Recount_ReportWindow.slider:Point("TOP", Recount_ReportWindow, 0, -45)
			Recount_ReportWindow.ReportTitle:Point("TOPLEFT", Recount_ReportWindow, 10, -75)
			Recount_ReportWindow.WhisperText:Point("BOTTOMLEFT", Recount_ReportWindow, 10, 37)

			Recount_ReportWindow.ReportTitle:FontTemplate()
			Recount_ReportWindow.WhisperText:FontTemplate()

			Recount_ReportWindow.Whisper:StripTextures(true)
			Recount_ReportWindow.Whisper:Height(16)

			S:HandleSliderFrame(Recount_ReportWindow.slider)
			S:HandleEditBox(Recount_ReportWindow.Whisper)
			S:HandleButton(Recount_ReportWindow.ReportButton)

			Recount_ReportWindow.isSkinned = true
		elseif window:GetName() == "Recount_ConfigWindow" then
			if Recount_ConfigWindow.isSkinned then return end

			skinFrame(Recount_ConfigWindow)

			S:HandleSliderFrame(Recount_ConfigWindow_Scaling_Slider)
			S:HandleSliderFrame(Recount_ConfigWindow_RowHeight_Slider)
			S:HandleSliderFrame(Recount_ConfigWindow_RowSpacing_Slider)

			Recount_ConfigWindow.isSkinned = true
		end
	end)

	skinMainFrame(Recount.MainWindow)
	skinFrame(Recount.DetailWindow)
	skinFrame(Recount.GraphWindow)

	S:HandleScrollBar(Recount_MainWindow_ScrollBarScrollBar)

	hooksecurefunc(Recount, "HideScrollbarElements", function(self, name)
		_G[name.."ScrollBar"].backdrop:Hide()
		_G[name.."ScrollBar"]:GetThumbTexture().backdrop:Hide()
	end)
	hooksecurefunc(Recount, "ShowScrollbarElements", function(self, name)
		_G[name.."ScrollBar"].backdrop:Show()
		_G[name.."ScrollBar"]:GetThumbTexture().backdrop:Show()
	end)

	if Recount.db.profile.MainWindow.ShowScrollbar then
		Recount:ShowScrollbarElements("Recount_MainWindow_ScrollBar")
	else
		Recount:HideScrollbarElements("Recount_MainWindow_ScrollBar")
	end

	local buttons = {
		Recount.MainWindow.CloseButton,
		Recount.MainWindow.RightButton,
		Recount.MainWindow.LeftButton,
		Recount.MainWindow.ResetButton,
		Recount.MainWindow.FileButton,
		Recount.MainWindow.ConfigButton,
		Recount.MainWindow.ReportButton,
		Recount_DetailWindow.LeftButton,
		Recount_DetailWindow.RightButton,
		Recount_DetailWindow.ReportButton,
		Recount_DetailWindow.SummaryButton
	}

	for _, button in ipairs(buttons) do
		if button:GetNormalTexture() then
			button:GetNormalTexture():SetDesaturated(true)
		end
		if button:GetPushedTexture() then
			button:GetPushedTexture():SetDesaturated(true)
		end
		if button:GetHighlightTexture() then
			button:GetHighlightTexture():SetDesaturated(true)
		end
	end

	local RecountLocale = LibStub("AceLocale-3.0"):GetLocale("Recount")
	local function resetData(self) Recount:ResetData() self:GetParent():Hide() end

	function Recount:ShowReset()
		AS:AcceptFrame(RecountLocale["Reset Recount?"], resetData)
	end
end)