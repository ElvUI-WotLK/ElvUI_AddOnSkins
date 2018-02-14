local E, L, V, P, G = unpack(ElvUI)
local AS = E:GetModule("AddOnSkins")
local S = E:GetModule("Skins")

local function LoadSkin()
	if not E.private.addOnSkins.Recount then return end

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

		if frame.CloseButton then
			frame.CloseButton:ClearAllPoints()
			if frame ~= Recount.MainWindow then
				S:HandleCloseButton(frame.CloseButton)
				frame.CloseButton:Size(32)
				frame.CloseButton:Point("RIGHT", header, 4, 0)
			else
				frame.CloseButton:Point("RIGHT", header, -6, 0)
			end
		end
	end

	SkinFrame(Recount.MainWindow)

	Recount.MainWindow.RightButton:SetNormalTexture([[Interface\AddOns\ElvUI\media\textures\SquareButtonTextures.blp]])
	Recount.MainWindow.RightButton:GetNormalTexture():SetTexCoord(0.421, 0.234, 0.015, 0.203)
	Recount.MainWindow.RightButton:GetNormalTexture():Point("TOPLEFT", 2, -4)
	Recount.MainWindow.RightButton:GetNormalTexture():Point("BOTTOMRIGHT", -2, 4)
	Recount.MainWindow.RightButton:SetPushedTexture([[Interface\AddOns\ElvUI\media\textures\SquareButtonTextures.blp]])
	Recount.MainWindow.RightButton:GetPushedTexture():SetTexCoord(0.421, 0.234, 0.015, 0.203)
	Recount.MainWindow.RightButton:GetPushedTexture():Point("TOPLEFT", 2, -4)
	Recount.MainWindow.RightButton:GetPushedTexture():Point("BOTTOMRIGHT", -2, 4)

	Recount.MainWindow.LeftButton:SetNormalTexture([[Interface\AddOns\ElvUI\media\textures\SquareButtonTextures.blp]])
	Recount.MainWindow.LeftButton:GetNormalTexture():SetTexCoord(0.234, 0.421, 0.015, 0.203)
	Recount.MainWindow.LeftButton:GetNormalTexture():Point("TOPLEFT", 2, -4)
	Recount.MainWindow.LeftButton:GetNormalTexture():Point("BOTTOMRIGHT", -2, 4)
	Recount.MainWindow.LeftButton:SetPushedTexture([[Interface\AddOns\ElvUI\media\textures\SquareButtonTextures.blp]])
	Recount.MainWindow.LeftButton:GetPushedTexture():SetTexCoord(0.234, 0.421, 0.015, 0.203)
	Recount.MainWindow.LeftButton:GetPushedTexture():Point("TOPLEFT", 2, -4)
	Recount.MainWindow.LeftButton:GetPushedTexture():Point("BOTTOMRIGHT", -2, 4)

	Recount.MainWindow.ResetButton:SetNormalTexture([[Interface\AddOns\ElvUI\media\textures\SquareButtonTextures.blp]])
	Recount.MainWindow.ResetButton:GetNormalTexture():SetTexCoord(0.015, 0.203, 0.015, 0.203)
	Recount.MainWindow.ResetButton:GetNormalTexture():Point("TOPLEFT", 2, -2)
	Recount.MainWindow.ResetButton:GetNormalTexture():Point("BOTTOMRIGHT", -2, 2)
	Recount.MainWindow.ResetButton:SetPushedTexture([[Interface\AddOns\ElvUI\media\textures\SquareButtonTextures.blp]])
	Recount.MainWindow.ResetButton:GetPushedTexture():SetTexCoord(0.015, 0.203, 0.015, 0.203)
	Recount.MainWindow.ResetButton:GetPushedTexture():Point("TOPLEFT", 2, -2)
	Recount.MainWindow.ResetButton:GetPushedTexture():Point("BOTTOMRIGHT", -2, -2)

	local buttons = {
		Recount.MainWindow.CloseButton,
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
			button:GetNormalTexture():SetDesaturated(true)
			button:GetHighlightTexture():SetDesaturated(true)
		end
	end

	Recount.MainWindow.DragBottomLeft:SetNormalTexture(nil)
	Recount.MainWindow.DragBottomRight:SetNormalTexture(nil)

	S:HandleScrollBar(Recount_MainWindow_ScrollBarScrollBar)

	hooksecurefunc(Recount, "HideScrollbarElements", function(self, name)
		_G[name.."ScrollBar"].trackbg:Hide()
		_G[name.."ScrollBar"].thumbbg:Hide()
	end)
	hooksecurefunc(Recount, "ShowScrollbarElements", function(self, name)
		_G[name.."ScrollBar"].trackbg:Show()
		_G[name.."ScrollBar"].thumbbg:Show()
	end)

	if(Recount.db.profile.MainWindow.ShowScrollbar) then
		Recount:ShowScrollbarElements("Recount_MainWindow_ScrollBar")
	else
		Recount:HideScrollbarElements("Recount_MainWindow_ScrollBar")
	end

	hooksecurefunc(Recount, "AddWindow", function(self, window)
		if window.YesButton and not window.isSkinned then
			SkinFrame(window)
			window.Text:SetPoint("TOP", window.backdrop, 0, -3)

			S:HandleButton(window.YesButton)
			window.YesButton:SetPoint("BOTTOMRIGHT", window, "BOTTOM", -3, 5)
			S:HandleButton(window.NoButton)
			window.NoButton:SetPoint("BOTTOMLEFT", window, "BOTTOM", 3, 5)

			window.isSkinned = true
		end
	end)

	hooksecurefunc(Recount, "ShowReport", function()
		if not Recount_ReportWindow.isSkinned then
			SkinFrame(Recount_ReportWindow)

			S:HandleButton(Recount_ReportWindow.ReportButton)
			S:HandleSliderFrame(Recount_ReportWindow_Slider)

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

			S:HandleSliderFrame(Recount_ConfigWindow_Scaling_Slider)
			S:HandleSliderFrame(Recount_ConfigWindow_RowHeight_Slider)
			S:HandleSliderFrame(Recount_ConfigWindow_RowSpacing_Slider)

			Recount.ConfigWindow.isSkinned = true
		end
	end)
end

S:AddCallbackForAddon("Recount", "Recount", LoadSkin)