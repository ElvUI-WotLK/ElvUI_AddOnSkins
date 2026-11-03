local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
-- Optional controls differ between supported addon versions. Keep missing
-- targets out of native skin handlers without masking other Lua errors.
local function SkinControl(method, frame, ...)
	if frame then return S[method](S, frame, ...) end
end
local function SkinFrame(frame, method, ...)
	if frame then return frame[method](frame, ...) end
end

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
	SkinFrame(OutfitterButtonFrame, "SetAllPoints", CharacterFrame.backdrop)

	SkinFrame(OutfitterButton, "ClearAllPoints")
	SkinFrame(OutfitterButton, "Point", "TOPRIGHT", OutfitterButtonFrame, -25, -5)

	SkinFrame(OutfitterButton, "Size", 30, 16)
	SkinFrame(OutfitterButton, "SetTemplate", "Transparent")
	SkinFrame(OutfitterButton, "SetHighlightTexture", "")
	SkinFrame(OutfitterButton, "HookScript", "OnEnter", S.SetModifiedBackdrop)
	SkinFrame(OutfitterButton, "HookScript", "OnLeave", S.SetOriginalBackdrop)

	local buttonTexture = OutfitterButton:GetNormalTexture()
	SkinFrame(buttonTexture, "SetInside")
	SkinFrame(buttonTexture, "SetTexCoord", 0.296875, 0.765625, 0.140625, 0.390625)
	buttonTexture = OutfitterButton:GetPushedTexture()
	SkinFrame(buttonTexture, "SetInside")
	SkinFrame(buttonTexture, "SetTexCoord", 0.25, 0.71875, 0.640625, 0.890625)

	-- AboutFrame
	SkinFrame(OutfitterAboutFrame, "StripTextures")
	SkinFrame(OutfitterAboutFrame, "SetTemplate", "Transparent")

	-- OptionsFrame
	SkinFrame(OutfitterOptionsFrame, "StripTextures")
	SkinFrame(OutfitterOptionsFrame, "SetTemplate", "Transparent")

	SkinControl("HandleCheckBox", OutfitterAutoSwitch, true)
	SkinControl("HandleCheckBox", OutfitterShowOutfitBar, true)
	SkinControl("HandleCheckBox", OutfitterShowMinimapButton, true)
	SkinControl("HandleCheckBox", OutfitterShowHotkeyMessages, true)
	SkinControl("HandleCheckBox", OutfitterTooltipInfo, true)
	SkinControl("HandleCheckBox", OutfitterItemComparisons, true)

	SkinFrame(OutfitterShowOutfitBar, "Point", "TOPLEFT", OutfitterAutoSwitch, "BOTTOMLEFT", 0, -5)

	-- MainFrame
	SkinFrame(OutfitterFrame, "Point", "TOPLEFT", OutfitterButtonFrame, "TOPRIGHT", -1, 0)

	SkinFrame(OutfitterMainFrame, "SetTemplate", "Transparent")

	SkinFrame(OutfitterMainFrameBackground, "StripTextures")
	SkinFrame(OutfitterMainFrameButtonBarBackground, "StripTextures")

	SkinFrame(OutfitterFrameTitle, "Point", "TOP", 0, -6)
	OutfitterFrameTitle:SetParent(OutfitterMainFrame)

	SkinControl("HandleCloseButton", OutfitterCloseButton, OutfitterFrame)

	for i = 1, 3 do
		local tab = _G["OutfitterFrameTab"..i]
		SkinFrame(tab, "StripTextures")
		SkinFrame(tab, "SetTemplate")

		SkinFrame(tab, "Height", 28)

		if i == 1 then
			SkinFrame(tab, "Point", "BOTTOMRIGHT", -6, -27)
		else
			SkinFrame(tab, "Point", "RIGHT", _G["OutfitterFrameTab"..(i - 1)], "LEFT", -5, 0)
		end
	end

	OutfitterMainFrameHighlight:SetTexture(E.Media.Textures.Highlight)
	OutfitterMainFrameHighlight:SetVertexColor(0.9, 0.9, 0.9, 0.35)

	SkinFrame(OutfitterMainFrameScrollbarTrench, "StripTextures")

	SkinControl("HandleScrollBar", OutfitterMainFrameScrollFrameScrollBar)
	SkinFrame(OutfitterMainFrameScrollFrameScrollBar, "Point", "TOPLEFT", OutfitterMainFrameScrollFrame, "TOPRIGHT", 3, -20)
	SkinFrame(OutfitterMainFrameScrollFrameScrollBar, "Point", "BOTTOMLEFT", OutfitterMainFrameScrollFrame, "BOTTOMRIGHT", 3, 20)

	SkinFrame(OutfitterItem0, "Point", "TOPLEFT", 3, -57)

	SkinControl("HandleButton", OutfitterNewButton)
	SkinFrame(OutfitterNewButton, "Point", "BOTTOMRIGHT", -8, 8)

	for i = 0, 13 do
		local categoryExpand = _G["OutfitterItem"..i.."CategoryExpand"]
		SkinControl("HandleCollapseExpandButton", categoryExpand)
		SkinFrame(categoryExpand, "Point", "BOTTOMLEFT", 2, 1)

		local outfitSelected = _G["OutfitterItem"..i.."OutfitSelected"]
		SkinControl("HandleCheckBox", outfitSelected, true)
		SkinFrame(outfitSelected, "Point", "BOTTOMLEFT", 5, 1)

		SkinFrame(_G["OutfitterItem"..i.."ItemIcon"], "SetTexCoord", unpack(E.TexCoords))

		local outfitServerButton = _G["OutfitterItem"..i.."OutfitServerButton"]
		outfitServerButton:GetNormalTexture():SetTexCoord(unpack(E.TexCoords))
		outfitServerButton:GetPushedTexture():SetTexCoord(unpack(E.TexCoords))

		local outfitMenu = _G["OutfitterItem"..i.."OutfitMenu"]
		SkinControl("HandleNextPrevButton", outfitMenu, "down")
		SkinFrame(outfitMenu, "Size", 16)
	end

	hooksecurefunc(Outfitter._SidebarWindowFrame, "Construct", function(self)
		for _, textureFrame in pairs(self.Background) do
			SkinFrame(textureFrame, "StripTextures")
		end
	end)

	-- SlotEnables
	SkinControl("HandleButton", OutfitterEnableAll)
	SkinControl("HandleButton", OutfitterEnableNone)

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
		SkinControl("HandleCheckBox", slot)
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

		SkinFrame(icon, "SetInside")
		SkinFrame(icon, "SetTexCoord", unpack(E.TexCoords))

		E:RegisterCooldown(_G[buttonName.."Cooldown"])
	end)

	-- ScriptFrame
	SkinFrame(OutfitterEditScriptDialog, "StripTextures")
	SkinFrame(OutfitterEditScriptDialog, "SetTemplate", "Transparent")
	SkinFrame(OutfitterEditScriptDialog, "ClearAllPoints")
	SkinFrame(OutfitterEditScriptDialog, "SetPoint", "CENTER")

	OutfitterEditScriptDialog.CloseButton:Size(32)
	SkinControl("HandleCloseButton", OutfitterEditScriptDialog.CloseButton, OutfitterEditScriptDialog)

	SkinControl("HandleDropDownBox", OutfitterEditScriptDialogPresetScript)
	SkinFrame(OutfitterEditScriptDialogPresetScript, "Point", "TOPLEFT", 291, -20)

	SkinFrame(OutfitterEditScriptDialogSourceScript, "StripTextures")
	OutfitterEditScriptDialogSourceScript:CreateBackdrop("Transparent")
	SkinFrame(OutfitterEditScriptDialogSourceScript, "Size", 422, 369)
	SkinFrame(OutfitterEditScriptDialogSourceScript, "Point", "TOPLEFT", 60, -51)

	SkinFrame(OutfitterEditScriptDialogSourceScriptEditBox, "Width", 421)

	SkinControl("HandleScrollBar", OutfitterEditScriptDialogSourceScriptScrollBar)
	SkinFrame(OutfitterEditScriptDialogSourceScriptScrollBar, "Point", "TOPLEFT", OutfitterEditScriptDialogSourceScript, "TOPRIGHT", 4, -18)
	SkinFrame(OutfitterEditScriptDialogSourceScriptScrollBar, "Point", "BOTTOMLEFT", OutfitterEditScriptDialogSourceScript, "BOTTOMRIGHT", 4, 18)

	SkinControl("HandleButton", OutfitterEditScriptDialogDoneButton)
	SkinControl("HandleButton", OutfitterEditScriptDialogCancelButton)
	SkinFrame(OutfitterEditScriptDialogCancelButton, "Point", "BOTTOMRIGHT", -8, 8)

	SkinControl("HandleTab", OutfitterEditScriptDialogTab1)
	SkinControl("HandleTab", OutfitterEditScriptDialogTab2)

	SkinFrame(OutfitterEditScriptDialogTab1, "Point", "TOPLEFT", OutfitterEditScriptDialog, "BOTTOMLEFT", 0, 2)
	SkinFrame(OutfitterEditScriptDialogTab2, "Point", "LEFT", OutfitterEditScriptDialogTab1, "RIGHT", -15, 0)

	hooksecurefunc(OutfitterEditScriptDialog, "ConstructSettingsFields", function(self, pSettings) -- Outfitter._EditScriptDialog.ConstructSettingsFields
		if pSettings.Inputs then

			for _, frame in ipairs(self.SettingsFrames) do
				local vSettingTypeInfo = Outfitter.SettingTypeInfo[lower(frame.Descriptor.Type)]
				local vFrameType = vSettingTypeInfo.FrameType

				if vFrameType == "ScrollableEditBox" then
					SkinFrame(frame, "StripTextures")
					frame:CreateBackdrop()

					SkinFrame(_G[frame:GetName().."EditBox"], "Width", frame:GetWidth() - 1)

					local scrollBar = _G[frame:GetName().."ScrollBar"]
					SkinControl("HandleScrollBar", scrollBar)
					SkinFrame(scrollBar, "Point", "TOPLEFT", frame, "TOPRIGHT", 4, -18)
					SkinFrame(scrollBar, "Point", "BOTTOMLEFT", frame, "BOTTOMRIGHT", 4, 18)
				elseif vFrameType == "EditBox" then
					SkinControl("HandleEditBox", frame)

					for _, region in ipairs({frame:GetRegions()}) do
						if region:GetObjectType("Texture") and region:GetDrawLayer() == "BACKGROUND" then
							SkinFrame(region, "Hide")
						end
					end
				elseif vFrameType == "ZoneListEditBox" then
					SkinFrame(frame, "StripTextures")
					frame:CreateBackdrop()

					SkinFrame(_G[frame:GetName().."EditBox"], "Width", frame:GetWidth() - 1)

					local scrollBar = _G[frame:GetName().."ScrollBar"]
					SkinControl("HandleScrollBar", scrollBar)
					SkinFrame(scrollBar, "Point", "TOPLEFT", frame, "TOPRIGHT", 4, -18)
					SkinFrame(scrollBar, "Point", "BOTTOMLEFT", frame, "BOTTOMRIGHT", 4, 18)

					SkinControl("HandleButton", _G[frame:GetName().."ZoneButton"])
				elseif vFrameType == "Checkbox" then
					SkinControl("HandleCheckBox", frame)
				end
			end
		end
	end)

	-- ChooseIconDialog
	OutfitterChooseIconDialog:GetChildren():Hide() -- backdrop
	SkinFrame(OutfitterChooseIconDialog, "SetTemplate", "Transparent")
	SkinFrame(OutfitterChooseIconDialog, "Size", 303, 367)

	SkinControl("HandleDropDownBox", OutfitterChooseIconDialogIconSetMenu)

	SkinControl("HandleEditBox", OutfitterChooseIconDialogFilterEditBox)
	local leftTex, rightTex, middleTex = select(OutfitterChooseIconDialogFilterEditBox:GetNumRegions() - 2, OutfitterChooseIconDialogFilterEditBox:GetRegions())
	SkinFrame(leftTex, "Hide")
	SkinFrame(rightTex, "Hide")
	SkinFrame(middleTex, "Hide")

	SkinFrame(OutfitterChooseIconDialogScrollFrame, "StripTextures")
	SkinFrame(OutfitterChooseIconDialogScrollFrame, "Point", "TOPLEFT", OutfitterChooseIconDialogFilterEditBox, "BOTTOMLEFT", -64, -19)

	SkinControl("HandleScrollBar", OutfitterChooseIconDialogScrollFrameScrollBar)
	SkinFrame(OutfitterChooseIconDialogScrollFrameScrollBar, "Point", "TOPLEFT", OutfitterChooseIconDialogScrollFrame, "TOPRIGHT", 6, -19)
	SkinFrame(OutfitterChooseIconDialogScrollFrameScrollBar, "Point", "BOTTOMLEFT", OutfitterChooseIconDialogScrollFrame, "BOTTOMRIGHT", 6, 19)

	SkinControl("HandleButton", OutfitterChooseIconDialogOKButton)
	SkinControl("HandleButton", OutfitterChooseIconDialogCancelButton)
	SkinFrame(OutfitterChooseIconDialogCancelButton, "Point", "BOTTOMRIGHT", -8, 8)

	hooksecurefunc(OutfitterChooseIconDialog, "NewIconButton", function(self) -- Outfitter.OutfitBar._ChooseIconDialog
		local button = _G["OutfitterChooseIconDialogButton"..#self.IconButtons]
		local buttonIcon = _G["OutfitterChooseIconDialogButton"..#self.IconButtons.."Icon"]

		SkinFrame(button, "StripTextures")
		SkinFrame(button, "SetTemplate", nil, true)
		SkinFrame(button, "StyleButton", nil, true)

		buttonIcon:SetDrawLayer("ARTWORK")
		SkinFrame(buttonIcon, "SetTexCoord", unpack(E.TexCoords))
		SkinFrame(buttonIcon, "SetInside")
	end)

	-- OutfitBar
	hooksecurefunc(Outfitter.OutfitBar, "NewBar", function(self)
		local frame = _G["OutfitterOutfitBar" .. (self.UniqueNameIndex - 1)]

		for _, texture in ipairs(frame.BackgroundTextures) do
			texture.Show = E.noop
			SkinFrame(texture, "Hide")
		end

		if not self.Settings.OutfitBar.HideBackground then
			SkinFrame(frame, "SetTemplate", "Transparent")
		end

		for _, button in ipairs(frame.Buttons) do
			button.Widgets.Icon:SetDrawLayer("BORDER")
			SkinControl("HandleItemButton", button, true)
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
			SkinFrame(self, "Size", 53, 12)
		else
			SkinFrame(self, "Size", 12, 53)
		end
	end

	hooksecurefunc(Outfitter.OutfitBar._SettingsDialog, "Construct", function(self)
		SkinFrame(self, "SetTemplate", "Transparent")

		SkinControl("HandleSliderFrame", self.SizeSlider)
		SkinControl("HandleSliderFrame", self.AlphaSlider)
		SkinControl("HandleSliderFrame", self.CombatAlphaSlider)

		SkinControl("HandleCheckBox", self.VerticalCheckbutton)
		SkinControl("HandleCheckBox", self.LockPositionCheckbutton)
		SkinControl("HandleCheckBox", self.HideBackgroundCheckbutton)
	end)

	function Outfitter._ButtonBar:ShowBackground(pShow)
		self.HideBackground = not pShow
		SkinFrame(self, "SetTemplate", pShow and "Transparent" or "NoBackdrop")
	end

	-- MC2UIElementsLib
	hooksecurefunc(Outfitter.UIElementsLib._SidebarWindowFrame, "Construct", function(self)
		SkinFrame(self, "SetTemplate", "Transparent")
		SkinControl("HandleCloseButton", self.CloseButton, self)

		for _, textureFrame in pairs(self.Background) do
			SkinFrame(textureFrame, "StripTextures")
		end
	end)
	hooksecurefunc(Outfitter.UIElementsLib._ModalDialogFrame, "Construct", function(self)
		SkinFrame(self, "SetTemplate", "Transparent")

		self.Title:Point("TOP", 0, -5)

		self.TitleBackground.Show = E.noop
		self.TitleBackground:Hide()
	end)
	hooksecurefunc(Outfitter.UIElementsLib._Tabs, "Construct", function(self, pFrame, pXOffset, pYOffset)
		self.XOffset = (pXOffset or 0) + 15
		self.YOffset = (pYOffset or 0) + 3
	end)
	hooksecurefunc(Outfitter.UIElementsLib._Tabs, "NewTab", function(self)
		SkinControl("HandleTab", self.Tabs[#self.Tabs])
	end)
	hooksecurefunc(Outfitter.UIElementsLib._ScrollbarTrench, "Construct", function(self)
		SkinFrame(self, "StripTextures")
	end)
	hooksecurefunc(Outfitter.UIElementsLib._Scrollbar, "Construct", function(self)
		SkinControl("HandleScrollBar", self)
	end)
	hooksecurefunc(Outfitter.UIElementsLib._CheckButton, "Construct", function(self)
		SkinControl("HandleCheckBox", self, true)
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
		SkinFrame(self, "SetTemplate", "Transparent")
	end)
	hooksecurefunc(Outfitter.UIElementsLib._CloseButton, "Construct", function(self, pParent)
		SkinControl("HandleCloseButton", self, pParent)
	end)
	hooksecurefunc(Outfitter.UIElementsLib._FadingTitleBar, "Construct", function(self)
		self.FullBar:StripTextures()
		self.FullBar:SetTemplate("Transparent")
	end)
	hooksecurefunc(Outfitter.UIElementsLib._ExpandButton, "Construct", function(self)
		SkinControl("HandleCollapseExpandButton", self, "-")
	end)
	local dropdownArrowColor = {1, 0.8, 0}
	hooksecurefunc(Outfitter.UIElementsLib._DropDownMenuButton, "Construct", function(self, pParent, pMenuFunc, pWidth)
		SkinControl("HandleNextPrevButton", self.Button, "down", dropdownArrowColor)
	end)
	hooksecurefunc(Outfitter.UIElementsLib._Section, "Construct", function(self)
		SkinFrame(self, "SetTemplate", "Transparent")
	end)
	hooksecurefunc(Outfitter.UIElementsLib._DropDownMenu, "Construct", function(self)
		SkinFrame(self, "StripTextures")
		SkinFrame(self, "SetTemplate")

		self.Button:Point("RIGHT", -2, 0)
	end)
	hooksecurefunc(Outfitter.UIElementsLib._EditBox, "Construct", function(self, pParent, pLabel, pMaxLetters, pWidth, pPlain)
		SkinFrame(self, "SetTemplate")

		if not pPlain then
			self.LeftTexture:SetAlpha(0)
			self.MiddleTexture:SetAlpha(0)
			self.RightTexture:SetAlpha(0)
		end
	end)
	hooksecurefunc(Outfitter.UIElementsLib._PushButton, "Construct", function(self)
		SkinControl("HandleButton", self, true)

		self.HighlightTexture.Show = E.noop
		self.HighlightTexture:Hide()
	end)
	hooksecurefunc(Outfitter.UIElementsLib._ScrollingEditBox, "Construct", function(self)
		self.BackgroundTextures:SetTemplate("Transparent")
		self.EditBox:SetTemplate("NoBackdrop")
	end)
	hooksecurefunc(Outfitter.UIElementsLib._ProgressBar, "Construct", function(self)
		SkinControl("HandleStatusBar", self)
	end)
end)
