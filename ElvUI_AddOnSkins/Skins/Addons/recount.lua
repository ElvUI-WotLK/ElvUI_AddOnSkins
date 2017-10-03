local E, L, V, P, G = unpack(ElvUI)
local AS = E:GetModule("AddOnSkins")
local S = E:GetModule("Skins")

local function LoadSkin()
	if not E.private.addOnSkins.Recount then return end

	function Recount:ShowReset()
		AS:AcceptFrame(L["Reset Recount?"], function(self) Recount:ResetData() self:GetParent():Hide() end)
	end

	local function SkinFrame(frame)
		frame:SetBackdrop(nil)

		local backdrop = CreateFrame("Frame", nil, frame)
		backdrop:SetFrameLevel(frame:GetFrameLevel() - 1)
		backdrop:Point("BOTTOMLEFT", frame, E.PixelMode and 1 or 0, E.PixelMode and 1 or 0)
		backdrop:Point("TOPRIGHT", frame, E.PixelMode and -1 or 0, -(E.PixelMode and 31 or 30))
		if frame == Recount.MainWindow then
			backdrop:SetTemplate("Default")
		else
			backdrop:SetTemplate("Transparent")
		end
		frame.backdrop = backdrop

		local header = CreateFrame("Frame", nil, backdrop)
		header:Height(22)
		header:Point("TOPLEFT", frame, E.PixelMode and 1 or 0, -(E.PixelMode and 8 or 7))
		header:Point("TOPRIGHT", frame, E.PixelMode and -1 or 0, 0)
		header:SetTemplate("Default", true)

		frame.Title:ClearAllPoints()
		frame.Title:SetPoint("LEFT", header, 6, 0)
		frame.Title:FontTemplate()
		frame.Title:SetTextColor(unpack(E.media.rgbvaluecolor))

		frame.CloseButton:ClearAllPoints()
		frame.CloseButton:SetPoint("RIGHT", header, -6, 0)
	end

	SkinFrame(Recount.MainWindow)

	S:HandleCloseButton(Recount.MainWindow.CloseButton)
	Recount.MainWindow.CloseButton:Size(32)
	Recount.MainWindow.CloseButton:Point("TOPRIGHT", 4, -3)

	S:HandleNextPrevButton(Recount.MainWindow.RightButton)
	S:SquareButton_SetIcon(Recount.MainWindow.RightButton, "RIGHT")
	Recount.MainWindow.RightButton:Size(15)
	Recount.MainWindow.RightButton:Point("TOPRIGHT", Recount.MainWindow.CloseButton, "TOPLEFT", 3, -8)

	S:HandleNextPrevButton(Recount.MainWindow.LeftButton)
	S:SquareButton_SetIcon(Recount.MainWindow.LeftButton, "LEFT")
	Recount.MainWindow.LeftButton:Size(15)
	Recount.MainWindow.LeftButton:Point("TOPRIGHT", Recount.MainWindow.RightButton, "TOPLEFT", -3, 0)

	S:HandleNextPrevButton(Recount.MainWindow.ResetButton)
	S:SquareButton_SetIcon(Recount.MainWindow.ResetButton, "DELETE")
	Recount.MainWindow.ResetButton:Size(15)
	Recount.MainWindow.ResetButton:Point("TOPRIGHT", Recount.MainWindow.LeftButton, "TOPLEFT", -3, 0)

	Recount.MainWindow.FileButton:Point("RIGHT", Recount.MainWindow.ResetButton, "LEFT", -3, 0)



	local buttons = {
		Recount.MainWindow.RightButton,
		Recount.MainWindow.LeftButton,
		Recount.MainWindow.ResetButton,
		Recount.MainWindow.FileButton,
		Recount.MainWindow.ConfigButton,
		Recount.MainWindow.ReportButton
	}

	for i = 1, #buttons do
		local button = buttons[i]
		if button then
			AS:Desaturate(button)
		end
	end

	Recount.MainWindow.DragBottomLeft:SetNormalTexture(nil)
	Recount.MainWindow.DragBottomRight:SetNormalTexture(nil)

	S:HandleScrollBar(Recount_MainWindow_ScrollBarScrollBar)

	hooksecurefunc(Recount, "HideScrollbarElements", function(self, name)
		_G[name .. "ScrollBar"].trackbg:Hide();
		_G[name .. "ScrollBar"].thumbbg:Hide();
	end);
	hooksecurefunc(Recount, "ShowScrollbarElements", function(self, name)
		_G[name .. "ScrollBar"].trackbg:Show();
		_G[name .. "ScrollBar"].thumbbg:Show();
	end);

	if(Recount.db.profile.MainWindow.ShowScrollbar) then
		Recount:ShowScrollbarElements("Recount_MainWindow_ScrollBar");
	else
		Recount:HideScrollbarElements("Recount_MainWindow_ScrollBar");
	end

	hooksecurefunc(Recount, "ShowReport", function()
		if not Recount_ReportWindow.isSkinned then
			SkinFrame(Recount_ReportWindow)

			S:HandleButton(Recount_ReportWindow.ReportButton)
			S:HandleSliderFrame(Recount_ReportWindow_Slider)

			AS:Desaturate(Recount_ReportWindow.CloseButton)

			Recount_ReportWindow.Whisper:StripTextures(true)
			S:HandleEditBox(Recount_ReportWindow.Whisper)
			Recount_ReportWindow.Whisper:Height(16)

			Recount_ReportWindow.isSkinned = true
		end
	end)

	hooksecurefunc(Recount, "ShowConfig", function()
		if not Recount.ConfigWindow.isSkinned then
			SkinFrame(Recount.ConfigWindow)

			Recount.ConfigWindow:StripTextures()

			Recount.ConfigWindow.backdrop:StripTextures()
			Recount.ConfigWindow.backdrop:SetTemplate("Transparent")

			S:HandleCloseButton(Recount.ConfigWindow.CloseButton)
			Recount.ConfigWindow.CloseButton:Size(32)
			Recount.ConfigWindow.CloseButton:Point("TOPRIGHT", 4, -3)

			S:HandleSliderFrame(Recount_ConfigWindow_Scaling_Slider)
			S:HandleSliderFrame(Recount_ConfigWindow_RowHeight_Slider)
			S:HandleSliderFrame(Recount_ConfigWindow_RowSpacing_Slider)

			Recount.ConfigWindow.isSkinned = true
		end
	end)

	hooksecurefunc(Recount, "HideScrollbarElements", function(self, name)
		_G[name .. "ScrollBar"].trackbg:Hide()
		_G[name .. "ScrollBar"].thumbbg:Hide()
	end)
	hooksecurefunc(Recount, "ShowScrollbarElements", function(self, name)
		_G[name .. "ScrollBar"].trackbg:Show()
		_G[name .. "ScrollBar"].thumbbg:Show()
	end)

	if(Recount.db.profile.MainWindow.ShowScrollbar) then
		Recount:ShowScrollbarElements("Recount_MainWindow_ScrollBar")
	else
		Recount:HideScrollbarElements("Recount_MainWindow_ScrollBar")
	end
end

S:AddCallbackForAddon("Recount", "Recount", LoadSkin)