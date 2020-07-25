local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

if not AS:IsAddonLODorEnabled("Outfitter") then return end

local _G = _G
local pairs, ipairs = pairs, ipairs

-- Outfitter 5.0
-- https://www.wowinterface.com/downloads/getfile.php?id=5467&aid=47018

S:AddCallbackForAddon("Outfitter", "Outfitter", function()
	if not E.private.addOnSkins.Outfitter then return end

	local function skinTab(frame)
		if frame.isSkinned then return end

		frame:StripTextures()
		frame:SetTemplate()
		local width, height = frame:GetSize()
		frame:Size(width - 20, height - 4)

		local anchor1, point, anchor2, x, y = frame:GetPoint()

		if anchor1 == "RIGHT" or anchor2 == "LEFT" then
			frame:Point(anchor1, point, anchor2, x - 20, y)
		elseif anchor1 == "LEFT" or anchor2 == "RIGHT" then
			frame:Point(anchor1, point, anchor2, x + 20, y)
		elseif string.find(anchor1, "^BOTTOM") then
			frame:Point(anchor1, point, anchor2, x, y + 4)
		else
			frame:Point(anchor1, point, anchor2, x, y - 4)
		end

		frame.isSkinned = true
	end

	local function skinButton(frame)
		if frame.isSkinned then return end

		S:HandleButton(frame, true)

		if frame.HighlightTexture then
			frame.HighlightTexture:Kill()
		end
	end

	local function skinEditbox(frame)
		if frame.isSkinned then return end

		frame.LeftTexture:SetAlpha(0)
		frame.MiddleTexture:SetAlpha(0)
		frame.RightTexture:SetAlpha(0)
		frame:SetTemplate()

		frame.isSkinned = true
	end

	local colors = {1, 0.8, 0}
	local function skinDropdown(frame)
		if frame.isSkinned then return end

		frame:StripTextures()
		frame:SetTemplate()

		frame.Button:Point("RIGHT", -2, 0)
		S:HandleNextPrevButton(frame.Button, "down", colors)
	end

	OutfitterButtonFrame:SetAllPoints(CharacterFrame.backdrop)

	hooksecurefunc(Outfitter._SidebarWindowFrame, "Construct", function(self)
		for _, textureFrame in pairs(self.Background) do
			textureFrame:StripTextures(true)
		end
	end)

	OutfitterFrame:ClearAllPoints()
	OutfitterFrame:Point("TOPLEFT", OutfitterButtonFrame, "TOPRIGHT", -1, 0)

	OutfitterButton:ClearAllPoints()
	OutfitterButton:Point("TOPRIGHT", OutfitterButtonFrame, -25, -5)

	OutfitterButton:Size(30, 16)
	OutfitterButton:SetTemplate("Transparent")
	OutfitterButton:SetHighlightTexture("")
	OutfitterButton:HookScript("OnEnter", S.SetModifiedBackdrop)
	OutfitterButton:HookScript("OnLeave", S.SetOriginalBackdrop)

	local texture = OutfitterButton:GetNormalTexture()
	texture:SetInside()
	texture:SetTexCoord(0.296875, 0.765625, 0.140625, 0.390625)
	texture = OutfitterButton:GetPushedTexture()
	texture:SetInside()
	texture:SetTexCoord(0.25, 0.71875, 0.640625, 0.890625)

	OutfitterFrameTitle:ClearAllPoints()
	OutfitterFrameTitle:SetParent(OutfitterMainFrame)
	OutfitterFrameTitle:Point("TOP", 0, -6)

	OutfitterMainFrameBackground:StripTextures()
	OutfitterMainFrameButtonBarBackground:StripTextures()

	OutfitterMainFrame:SetTemplate("Transparent")
	OutfitterOptionsFrame:StripTextures()
	OutfitterOptionsFrame:SetTemplate("Transparent")
	OutfitterAboutFrame:StripTextures()
	OutfitterAboutFrame:SetTemplate("Transparent")

	S:HandleCloseButton(OutfitterCloseButton)

	skinTab(OutfitterFrameTab1)
	skinTab(OutfitterFrameTab2)
	skinTab(OutfitterFrameTab3)

	OutfitterMainFrameScrollbarTrench:StripTextures()

	S:HandleScrollBar(OutfitterMainFrameScrollFrameScrollBar)

	OutfitterNewButton:Point("BOTTOMRIGHT", -7, 4)
	S:HandleButton(OutfitterNewButton)

	S:HandleButton(OutfitterEnableAll)
	S:HandleButton(OutfitterEnableNone)

	OutfitterShowOutfitBar:Point("TOPLEFT", OutfitterAutoSwitch, "BOTTOMLEFT", 0, -5)

	S:HandleCheckBox(OutfitterAutoSwitch, true)
	S:HandleCheckBox(OutfitterShowOutfitBar, true)
	S:HandleCheckBox(OutfitterShowMinimapButton, true)
	S:HandleCheckBox(OutfitterShowHotkeyMessages, true)
	S:HandleCheckBox(OutfitterTooltipInfo, true)
	S:HandleCheckBox(OutfitterItemComparisons, true)

	hooksecurefunc(Outfitter._NameOutfitDialog, "Construct", function(self)
		if self.isSkinned then return end

		self:SetTemplate("Transparent")
		self.InfoSection:SetTemplate("Transparent")
		self.BuildSection:SetTemplate("Transparent")
		self.StatsSection:SetTemplate("Transparent")

		self.TitleBackground:StripTextures()
		self.Title:Point("TOP", 0, -7)

		skinButton(self.DoneButton)
		skinButton(self.CancelButton)
		skinButton(self.MultiStatConfig.AddStatButton)

		skinEditbox(self.Name)
		skinDropdown(self.ScriptMenu)

		S:HandleCheckBox(self.EmptyOutfitCheckButton, true)
		S:HandleCheckBox(self.ExistingOutfitCheckButton, true)
		S:HandleCheckBox(self.GenerateOutfitCheckButton, true)

		self.isSkinned = true
	end)

	hooksecurefunc(Outfitter._MultiStatConfigLine, "Construct", function(self)
		if self.isSkinned then return end

		skinDropdown(self.StatMenu)
		skinDropdown(self.OpMenu)
		skinEditbox(self.MinValue)

		if self.DeleteButton then
			skinButton(self.DeleteButton)
		end

		self.isSkinned = true
	end)

	hooksecurefunc(Outfitter.OutfitBar, "NewBar", function(self)
		local frame = _G["OutfitterOutfitBar" .. (self.UniqueNameIndex - 1)]

		for _, texture in ipairs(frame.BackgroundTextures) do
			texture:Kill()
		end

		frame:SetTemplate("Transparent")

		for _, button in ipairs(frame.Buttons) do
			button.Widgets.Icon:SetDrawLayer("BORDER")
			S:HandleItemButton(button, true)
		end
	end)

	hooksecurefunc(Outfitter.OutfitBar._DragBar, "Construct", function(self)
		self.DragTexture:CreateBackdrop(nil, nil, true)
		self.DragTexture.backdrop:SetBackdropColor(0.3, 0.3, 0.3)
		self.DragTexture.SetTexture = E.noop
		self.DragTexture.SetTexCoord = E.noop
	end)

	hooksecurefunc(Outfitter.OutfitBar._SettingsDialog, "Construct", function(self)
		self:SetTemplate("Transparent")

		S:HandleSliderFrame(self.SizeSlider)
		S:HandleSliderFrame(self.AlphaSlider)
		S:HandleSliderFrame(self.CombatAlphaSlider)

		S:HandleCheckBox(self.VerticalCheckbutton)
		S:HandleCheckBox(self.LockPositionCheckbutton)
		S:HandleCheckBox(self.HideBackgroundCheckbutton)
	end)
end)