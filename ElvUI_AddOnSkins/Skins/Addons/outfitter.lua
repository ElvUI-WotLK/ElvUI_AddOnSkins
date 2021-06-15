local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

if not AS:IsAddonLODorEnabled("Outfitter") then return end

local _G = _G
local pairs, ipairs = pairs, ipairs
local unpack = unpack
local lower = string.lower

local hooksecurefunc = hooksecurefunc

-- Outfitter 5.0

S:AddCallbackForAddon("Outfitter", "Outfitter", function()
	if not E.private.addOnSkins.Outfitter then return end

	-- ButtonFrame
	OutfitterButtonFrame:SetAllPoints(CharacterFrame.backdrop)

	OutfitterButton:ClearAllPoints()
	OutfitterButton:Point("TOPRIGHT", OutfitterButtonFrame, -25, -5)

	OutfitterButton:Size(30, 16)
	OutfitterButton:SetTemplate("Transparent")
	OutfitterButton:SetHighlightTexture("")
	OutfitterButton:HookScript("OnEnter", S.SetModifiedBackdrop)
	OutfitterButton:HookScript("OnLeave", S.SetOriginalBackdrop)

	local buttonTexture = OutfitterButton:GetNormalTexture()
	buttonTexture:SetInside()
	buttonTexture:SetTexCoord(0.296875, 0.765625, 0.140625, 0.390625)
	buttonTexture = OutfitterButton:GetPushedTexture()
	buttonTexture:SetInside()
	buttonTexture:SetTexCoord(0.25, 0.71875, 0.640625, 0.890625)

	-- AboutFrame
	OutfitterAboutFrame:StripTextures()
	OutfitterAboutFrame:SetTemplate("Transparent")

	-- OptionsFrame
	OutfitterOptionsFrame:StripTextures()
	OutfitterOptionsFrame:SetTemplate("Transparent")

	S:HandleCheckBox(OutfitterAutoSwitch, true)
	S:HandleCheckBox(OutfitterShowOutfitBar, true)
	S:HandleCheckBox(OutfitterShowMinimapButton, true)
	S:HandleCheckBox(OutfitterShowHotkeyMessages, true)
	S:HandleCheckBox(OutfitterTooltipInfo, true)
	S:HandleCheckBox(OutfitterItemComparisons, true)

	OutfitterShowOutfitBar:Point("TOPLEFT", OutfitterAutoSwitch, "BOTTOMLEFT", 0, -5)

	-- MainFrame
	OutfitterFrame:Point("TOPLEFT", OutfitterButtonFrame, "TOPRIGHT", -1, 0)

	OutfitterMainFrame:SetTemplate("Transparent")

	OutfitterMainFrameBackground:StripTextures()
	OutfitterMainFrameButtonBarBackground:StripTextures()

	OutfitterFrameTitle:Point("TOP", 0, -6)
	OutfitterFrameTitle:SetParent(OutfitterMainFrame)

	S:HandleCloseButton(OutfitterCloseButton, OutfitterFrame)

	for i = 1, 3 do
		local tab = _G["OutfitterFrameTab"..i]
		tab:StripTextures()
		tab:SetTemplate()

		tab:Height(28)

		if i == 1 then
			tab:Point("BOTTOMRIGHT", -6, -27)
		else
			tab:Point("RIGHT", _G["OutfitterFrameTab"..(i - 1)], "LEFT", -5, 0)
		end
	end

	OutfitterMainFrameHighlight:SetTexture(E.Media.Textures.Highlight)
	OutfitterMainFrameHighlight:SetVertexColor(0.9, 0.9, 0.9, 0.35)

	OutfitterMainFrameScrollbarTrench:StripTextures()

	S:HandleScrollBar(OutfitterMainFrameScrollFrameScrollBar)
	OutfitterMainFrameScrollFrameScrollBar:Point("TOPLEFT", OutfitterMainFrameScrollFrame, "TOPRIGHT", 3, -20)
	OutfitterMainFrameScrollFrameScrollBar:Point("BOTTOMLEFT", OutfitterMainFrameScrollFrame, "BOTTOMRIGHT", 3, 20)

	OutfitterItem0:Point("TOPLEFT", 3, -57)

	S:HandleButton(OutfitterNewButton)
	OutfitterNewButton:Point("BOTTOMRIGHT", -8, 8)

	for i = 0, 13 do
		local categoryExpand = _G["OutfitterItem"..i.."CategoryExpand"]
		S:HandleCollapseExpandButton(categoryExpand)
		categoryExpand:Point("BOTTOMLEFT", 2, 1)

		local outfitSelected = _G["OutfitterItem"..i.."OutfitSelected"]
		S:HandleCheckBox(outfitSelected, true)
		outfitSelected:Point("BOTTOMLEFT", 5, 1)

		_G["OutfitterItem"..i.."ItemIcon"]:SetTexCoord(unpack(E.TexCoords))

		local outfitServerButton = _G["OutfitterItem"..i.."OutfitServerButton"]
		outfitServerButton:GetNormalTexture():SetTexCoord(unpack(E.TexCoords))
		outfitServerButton:GetPushedTexture():SetTexCoord(unpack(E.TexCoords))

		local outfitMenu = _G["OutfitterItem"..i.."OutfitMenu"]
		S:HandleNextPrevButton(outfitMenu, "down")
		outfitMenu:Size(16)
	end

	hooksecurefunc(Outfitter._SidebarWindowFrame, "Construct", function(self)
		for _, textureFrame in pairs(self.Background) do
			textureFrame:StripTextures()
		end
	end)

	-- SlotEnables
	S:HandleButton(OutfitterEnableAll)
	S:HandleButton(OutfitterEnableNone)

--[[
	local slots = {
		OutfitterEnableHeadSlot,
		OutfitterEnableNeckSlot,
		OutfitterEnableShoulderSlot,
		OutfitterEnableBackSlot,
		OutfitterEnableChestSlot,
		OutfitterEnableShirtSlot,
		OutfitterEnableTabardSlot,
		OutfitterEnableWristSlot,
		OutfitterEnableHandsSlot,
		OutfitterEnableWaistSlot,
		OutfitterEnableLegsSlot,
		OutfitterEnableFeetSlot,
		OutfitterEnableFinger0Slot,
		OutfitterEnableFinger1Slot,
		OutfitterEnableTrinket0Slot,
		OutfitterEnableTrinket1Slot,
		OutfitterEnableMainHandSlot,
		OutfitterEnableSecondaryHandSlot,
		OutfitterEnableRangedSlot,
		OutfitterEnableAmmoSlot,
	}

	for _, slot in ipairs(slots) do
		S:HandleCheckBox(slot)
	end
--]]

	--	OutfitterQuickSlots
	hooksecurefunc(Outfitter, "InitializeQuickSlots", function()
		Outfitter.QuickSlots:StripTextures()
		Outfitter.QuickSlots:SetTemplate("Transparent")
	end)
	local hiddenTextures = 0
	hooksecurefunc(Outfitter._ButtonBar, "SetDimensions", function(self)
		if hiddenTextures >= #self.BackgroundTextures then return end

		for i = hiddenTextures + 1, #self.BackgroundTextures do
			self.BackgroundTextures[i].Show = E.noop
			self.BackgroundTextures[i]:Hide()
		end

		hiddenTextures = #self.BackgroundTextures
	end)
	hooksecurefunc(Outfitter._QuickSlotButton, "Construct", function(self)
		local buttonName = self.ItemButton:GetName()
		local icon = _G[buttonName.."IconTexture"]

		self.ItemButton:GetNormalTexture():SetTexture(nil)
		self.ItemButton:SetTemplate("Default")
		self.ItemButton:StyleButton()

		icon:SetInside()
		icon:SetTexCoord(unpack(E.TexCoords))

		E:RegisterCooldown(_G[buttonName.."Cooldown"])
	end)

	-- ScriptFrame
	OutfitterEditScriptDialog:StripTextures()
	OutfitterEditScriptDialog:SetTemplate("Transparent")
	OutfitterEditScriptDialog:ClearAllPoints()
	OutfitterEditScriptDialog:SetPoint("CENTER")

	OutfitterEditScriptDialog.CloseButton:Size(32)
	S:HandleCloseButton(OutfitterEditScriptDialog.CloseButton, OutfitterEditScriptDialog)

	S:HandleDropDownBox(OutfitterEditScriptDialogPresetScript)
	OutfitterEditScriptDialogPresetScript:Point("TOPLEFT", 291, -20)

	OutfitterEditScriptDialogSourceScript:StripTextures()
	OutfitterEditScriptDialogSourceScript:CreateBackdrop("Transparent")
	OutfitterEditScriptDialogSourceScript:Size(422, 369)
	OutfitterEditScriptDialogSourceScript:Point("TOPLEFT", 60, -51)

	OutfitterEditScriptDialogSourceScriptEditBox:Width(421)

	S:HandleScrollBar(OutfitterEditScriptDialogSourceScriptScrollBar)
	OutfitterEditScriptDialogSourceScriptScrollBar:Point("TOPLEFT", OutfitterEditScriptDialogSourceScript, "TOPRIGHT", 4, -18)
	OutfitterEditScriptDialogSourceScriptScrollBar:Point("BOTTOMLEFT", OutfitterEditScriptDialogSourceScript, "BOTTOMRIGHT", 4, 18)

	S:HandleButton(OutfitterEditScriptDialogDoneButton)
	S:HandleButton(OutfitterEditScriptDialogCancelButton)
	OutfitterEditScriptDialogCancelButton:Point("BOTTOMRIGHT", -8, 8)

	S:HandleTab(OutfitterEditScriptDialogTab1)
	S:HandleTab(OutfitterEditScriptDialogTab2)

	OutfitterEditScriptDialogTab1:Point("TOPLEFT", OutfitterEditScriptDialog, "BOTTOMLEFT", 0, 2)
	OutfitterEditScriptDialogTab2:Point("LEFT", OutfitterEditScriptDialogTab1, "RIGHT", -15, 0)

	hooksecurefunc(OutfitterEditScriptDialog, "ConstructSettingsFields", function(self, pSettings) -- Outfitter._EditScriptDialog.ConstructSettingsFields
		if pSettings.Inputs then

			for _, frame in ipairs(self.SettingsFrames) do
				local vSettingTypeInfo = Outfitter.SettingTypeInfo[lower(frame.Descriptor.Type)]
				local vFrameType = vSettingTypeInfo.FrameType

				if vFrameType == "ScrollableEditBox" then
					frame:StripTextures()
					frame:CreateBackdrop()

					_G[frame:GetName().."EditBox"]:Width(frame:GetWidth() - 1)

					local scrollBar = _G[frame:GetName().."ScrollBar"]
					S:HandleScrollBar(scrollBar)
					scrollBar:Point("TOPLEFT", frame, "TOPRIGHT", 4, -18)
					scrollBar:Point("BOTTOMLEFT", frame, "BOTTOMRIGHT", 4, 18)
				elseif vFrameType == "EditBox" then
					S:HandleEditBox(frame)

					for _, region in ipairs({frame:GetRegions()}) do
						if region:GetObjectType("Texture") and region:GetDrawLayer() == "BACKGROUND" then
							region:Hide()
						end
					end
				elseif vFrameType == "ZoneListEditBox" then
					frame:StripTextures()
					frame:CreateBackdrop()

					_G[frame:GetName().."EditBox"]:Width(frame:GetWidth() - 1)

					local scrollBar = _G[frame:GetName().."ScrollBar"]
					S:HandleScrollBar(scrollBar)
					scrollBar:Point("TOPLEFT", frame, "TOPRIGHT", 4, -18)
					scrollBar:Point("BOTTOMLEFT", frame, "BOTTOMRIGHT", 4, 18)

					S:HandleButton(_G[frame:GetName().."ZoneButton"])
				elseif vFrameType == "Checkbox" then
					S:HandleCheckBox(frame)
				end
			end
		end
	end)

	-- ChooseIconDialog
	OutfitterChooseIconDialog:GetChildren():Hide() -- backdrop
	OutfitterChooseIconDialog:SetTemplate("Transparent")
	OutfitterChooseIconDialog:Size(303, 367)

	S:HandleDropDownBox(OutfitterChooseIconDialogIconSetMenu)

	S:HandleEditBox(OutfitterChooseIconDialogFilterEditBox)
	local leftTex, rightTex, middleTex = select(OutfitterChooseIconDialogFilterEditBox:GetNumRegions() - 2, OutfitterChooseIconDialogFilterEditBox:GetRegions())
	leftTex:Hide()
	rightTex:Hide()
	middleTex:Hide()

	OutfitterChooseIconDialogScrollFrame:StripTextures()
	OutfitterChooseIconDialogScrollFrame:Point("TOPLEFT", OutfitterChooseIconDialogFilterEditBox, "BOTTOMLEFT", -64, -19)

	S:HandleScrollBar(OutfitterChooseIconDialogScrollFrameScrollBar)
	OutfitterChooseIconDialogScrollFrameScrollBar:Point("TOPLEFT", OutfitterChooseIconDialogScrollFrame, "TOPRIGHT", 6, -19)
	OutfitterChooseIconDialogScrollFrameScrollBar:Point("BOTTOMLEFT", OutfitterChooseIconDialogScrollFrame, "BOTTOMRIGHT", 6, 19)

	S:HandleButton(OutfitterChooseIconDialogOKButton)
	S:HandleButton(OutfitterChooseIconDialogCancelButton)
	OutfitterChooseIconDialogCancelButton:Point("BOTTOMRIGHT", -8, 8)

	hooksecurefunc(OutfitterChooseIconDialog, "NewIconButton", function(self) -- Outfitter.OutfitBar._ChooseIconDialog
		local button = _G["OutfitterChooseIconDialogButton"..#self.IconButtons]
		local buttonIcon = _G["OutfitterChooseIconDialogButton"..#self.IconButtons.."Icon"]

		button:StripTextures()
		button:SetTemplate(nil, true)
		button:StyleButton(nil, true)

		buttonIcon:SetDrawLayer("ARTWORK")
		buttonIcon:SetTexCoord(unpack(E.TexCoords))
		buttonIcon:SetInside()
	end)

	-- OutfitBar
	hooksecurefunc(Outfitter.OutfitBar, "NewBar", function(self)
		local frame = _G["OutfitterOutfitBar" .. (self.UniqueNameIndex - 1)]

		for _, texture in ipairs(frame.BackgroundTextures) do
			texture.Show = E.noop
			texture:Hide()
		end

		if not self.Settings.OutfitBar.HideBackground then
			frame:SetTemplate("Transparent")
		end

		for _, button in ipairs(frame.Buttons) do
			button.Widgets.Icon:SetDrawLayer("BORDER")
			S:HandleItemButton(button, true)
		end
	end)

	hooksecurefunc(Outfitter.OutfitBar._DragBar, "Construct", function(self)
		self:CreateBackdrop("Default")

		self.DragTexture.SetTexture = E.noop
		self.DragTexture.SetTexCoord = E.noop
		self.DragTexture.SetTextureOffset = E.noop
	end)

	function Outfitter.OutfitBar._DragBar:SetVerticalOrientation(pVertical)
		self.Vertical = pVertical
		if pVertical then
			self:Size(53, 12)
		else
			self:Size(12, 53)
		end
	end

	hooksecurefunc(Outfitter.OutfitBar._SettingsDialog, "Construct", function(self)
		self:SetTemplate("Transparent")

		S:HandleSliderFrame(self.SizeSlider)
		S:HandleSliderFrame(self.AlphaSlider)
		S:HandleSliderFrame(self.CombatAlphaSlider)

		S:HandleCheckBox(self.VerticalCheckbutton)
		S:HandleCheckBox(self.LockPositionCheckbutton)
		S:HandleCheckBox(self.HideBackgroundCheckbutton)
	end)

	function Outfitter._ButtonBar:ShowBackground(pShow)
		self.HideBackground = not pShow
		self:SetTemplate(pShow and "Transparent" or "NoBackdrop")
	end

	-- MC2UIElementsLib
	hooksecurefunc(Outfitter.UIElementsLib._SidebarWindowFrame, "Construct", function(self)
		self:SetTemplate("Transparent")
		S:HandleCloseButton(self.CloseButton, self)

		for _, textureFrame in pairs(self.Background) do
			textureFrame:StripTextures()
		end
	end)
	hooksecurefunc(Outfitter.UIElementsLib._ModalDialogFrame, "Construct", function(self)
		self:SetTemplate("Transparent")

		self.Title:Point("TOP", 0, -5)

		self.TitleBackground.Show = E.noop
		self.TitleBackground:Hide()
	end)
	hooksecurefunc(Outfitter.UIElementsLib._Tabs, "Construct", function(self, pFrame, pXOffset, pYOffset)
		self.XOffset = (pXOffset or 0) + 15
		self.YOffset = (pYOffset or 0) + 3
	end)
	hooksecurefunc(Outfitter.UIElementsLib._Tabs, "NewTab", function(self)
		S:HandleTab(self.Tabs[#self.Tabs])
	end)
	hooksecurefunc(Outfitter.UIElementsLib._ScrollbarTrench, "Construct", function(self)
		self:StripTextures()
	end)
	hooksecurefunc(Outfitter.UIElementsLib._Scrollbar, "Construct", function(self)
		S:HandleScrollBar(self)
	end)
	hooksecurefunc(Outfitter.UIElementsLib._CheckButton, "Construct", function(self)
		S:HandleCheckBox(self, true)
	end)
	hooksecurefunc(Outfitter.UIElementsLib._ExpandAllButton, "Construct", function(self)
		self.TabLeft.Show = E.noop
		self.TabMiddle.Show = E.noop
		self.TabRight.Show = E.noop
		self.TabLeft:Hide()
		self.TabMiddle:Hide()
		self.TabRight:Hide()
	end)
	hooksecurefunc(Outfitter.UIElementsLib._PlainBorderedFrame, "Construct", function(self)
		self:SetTemplate("Transparent")
	end)
	hooksecurefunc(Outfitter.UIElementsLib._CloseButton, "Construct", function(self, pParent)
		S:HandleCloseButton(self, pParent)
	end)
	hooksecurefunc(Outfitter.UIElementsLib._FadingTitleBar, "Construct", function(self)
		self.FullBar:StripTextures()
		self.FullBar:SetTemplate("Transparent")
	end)
	hooksecurefunc(Outfitter.UIElementsLib._ExpandButton, "Construct", function(self)
		S:HandleCollapseExpandButton(self, "-")
	end)
	local dropdownArrowColor = {1, 0.8, 0}
	hooksecurefunc(Outfitter.UIElementsLib._DropDownMenuButton, "Construct", function(self, pParent, pMenuFunc, pWidth)
		S:HandleNextPrevButton(self.Button, "down", dropdownArrowColor)
	end)
	hooksecurefunc(Outfitter.UIElementsLib._Section, "Construct", function(self)
		self:SetTemplate("Transparent")
	end)
	hooksecurefunc(Outfitter.UIElementsLib._DropDownMenu, "Construct", function(self)
		self:StripTextures()
		self:SetTemplate()

		self.Button:Point("RIGHT", -2, 0)
	end)
	hooksecurefunc(Outfitter.UIElementsLib._EditBox, "Construct", function(self, pParent, pLabel, pMaxLetters, pWidth, pPlain)
		self:SetTemplate()

		if not pPlain then
			self.LeftTexture:SetAlpha(0)
			self.MiddleTexture:SetAlpha(0)
			self.RightTexture:SetAlpha(0)
		end
	end)
	hooksecurefunc(Outfitter.UIElementsLib._PushButton, "Construct", function(self)
		S:HandleButton(self, true)

		self.HighlightTexture.Show = E.noop
		self.HighlightTexture:Hide()
	end)
	hooksecurefunc(Outfitter.UIElementsLib._ScrollingEditBox, "Construct", function(self)
		self.BackgroundTextures:SetTemplate("Transparent")
		self.EditBox:SetTemplate("NoBackdrop")
	end)
	hooksecurefunc(Outfitter.UIElementsLib._ProgressBar, "Construct", function(self)
		S:HandleStatusBar(self)
	end)
end)