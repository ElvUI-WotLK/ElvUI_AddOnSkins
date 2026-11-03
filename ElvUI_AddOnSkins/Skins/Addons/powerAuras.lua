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

if not AS:IsAddonLODorEnabled("PowerAuras") then return end

local _G = _G

-- Power Auras Classic 3.0.0S
-- https://www.curseforge.com/wow/addons/powerauras-classic/files/452580

S:AddCallbackForAddon("PowerAuras", "PowerAuras", function()
	if not E.private.addOnSkins.PowerAuras then return end

	local frames = {
		-- Options
		"PowaOptionsFrame",
		"PowaOptionsPlayerListFrame",
		"PowaOptionsGlobalListFrame",
		"PowaOptionsSelectorFrame",
		-- Config
		"PowaBarConfigFrame",
		"PowaBarConfigFrameEditor",
		"PowaBarConfigFrameEditor2",
		"PowaBarConfigFrameEditor3",
		"PowaBarConfigFrameEditor4",
		"PowaBarConfigFrameEditor5",
		"PowaBarConfigFrameEditor6",
		"PowaEquipmentSlotsFrame",
	}

	local buttons = {
		-- Blizzard Options
		"PowaShowAuraBrowserButton",
		"PowaResetPositionButton",
		-- Options
		"PowaOptionsRename",
		"PowaMainTestAllButton",
		"PowaMainTestButton",
		"PowaOptionsSelectorNew",
		"PowaOptionsMove",
		"PowaOptionsSelectorImport",
		"PowaOptionsSelectorImportSet",
		"PowaMainHideAllButton",
		"PowaOptionsSelectorDelete",
		"PowaOptionsCopy",
		"PowaOptionsSelectorExport",
		"PowaOptionsSelectorExportSet",
		"PowaEditButton",
		-- Config Main
		"PowaBarAuraTextureSliderMinus",
		"PowaBarAuraTextureSliderPlus",
		"PowaFontsButton",
		"PowaBarAuraCoordXSliderMinus",
		"PowaBarAuraCoordXSliderPlus",
		"PowaBarAuraCoordSliderMinus",
		"PowaBarAuraCoordSliderPlus",
		-- Config Animation
		"PowaBarAuraAnimSpeedSliderMinus",
		"PowaBarAuraAnimSpeedSliderPlus",
		"PowaBarAuraDurationSliderMinus",
		"PowaBarAuraDurationSliderPlus",
		-- Config Timer
		"PowaTimerCoordXSliderMinus",
		"PowaTimerCoordXSliderPlus",
		"PowaTimerCoordSliderMinus",
		"PowaTimerCoordSliderPlus",
		"PowaTimerSizeSliderMinus",
		"PowaTimerSizeSliderPlus",
		"PowaTimerAlphaSliderMinus",
		"PowaTimerAlphaSliderPlus",
		"PowaTimerInvertAuraSliderMinus",
		"PowaTimerInvertAuraSliderPlus",
		"PowaTimerDurationSliderMinus",
		"PowaTimerDurationSliderPlus",
		-- Config Stacks
		"PowaStacksCoordXSliderMinus",
		"PowaStacksCoordXSliderPlus",
		"PowaStacksCoordSliderMinus",
		"PowaStacksCoordSliderPlus",
		"PowaStacksSizeSliderMinus",
		"PowaStacksSizeSliderPlus",
		"PowaStacksAlphaSliderMinus",
		"PowaStacksAlphaSliderPlus",
	}

	local checkBoxes = {
		-- Blizzard Options
		"PowaEnableButton",
		"PowaDebugButton",
		"PowaTimerRoundingButton",
		"PowaAllowInspectionsButton",
		-- Config Main
		"PowaTexModeButton",
		"PowaWowTextureButton",
		"PowaCustomTextureButton",
		"PowaTextAuraButton",
		"PowaRandomColorButton",
		"PowaOwntexButton",
		-- Config Activation
		"PowaExactButton",
		"PowaIngoreCaseButton",
		"PowaInverseButton",
		"PowaMineButton",
		"PowaPvPButton",
		"PowaInCombatButton",
		"PowaRestingButton",
		"PowaIsAliveButton",
		"PowaIsInPartyButton",
		"PowaIsInRaidButton",
		"PowaIsMountedButton",
		"PowaInVehicleButton",
		"PowaTargetButton",
		"PowaTargetFriendButton",
		"PowaFocusButton",
		"PowaGroupOrSelfButton",
		"PowaPartyButton",
		"PowaRaidButton",
		"PowaOptunitnButton",
		"Powa5ManInstanceButton",
		"Powa5ManHeroicInstanceButton",
		"Powa10ManInstanceButton",
		"Powa10ManHeroicInstanceButton",
		"Powa25ManInstanceButton",
		"Powa25ManHeroicInstanceButton",
		"PowaBgInstanceButton",
		"PowaArenaInstanceButton",
		"PowaRoleTankButton",
		"PowaRoleHealerButton",
		"PowaRoleMeleDpsButton",
		"PowaRoleRangeDpsButton",
		"PowaTalentGroup1Button",
		"PowaTalentGroup2Button",
		"PowaGroupAnyButton",
		"PowaAuraDebugButton",
		"PowaThresholdInvertButton",
		"PowaExtraButton",
		-- Config Animation
		"PowaShowSpinAtBeginning",
		"PowaOldAnimation",
		-- Config Timer
		"PowaShowTimerButton",
		"PowaBuffTimerCentsButton",
		"PowaBuffTimerLeadingZerosButton",
		"PowaBuffTimerTransparentButton",
		"PowaBuffTimerUseOwnColorButton",
		"PowaBuffTimerUpdatePingButton",
		"PowaBuffTimerActivationTime",
		-- Config Stacks
		"PowaShowStacksButton",
		"PowaBuffStacksTransparentButton",
		"PowaBuffStacksUseOwnColorButton",
		"PowaBuffStacksUpdatePingButton",
	}

	local sliders = {
		-- Blizzard Options
		"PowaOptionsUpdateSlider2",
		"PowaOptionsAnimationsSlider2",
		"PowaOptionsTimerUpdateSlider2",
		-- Config Main
		"PowaBarAuraTextureSlider",
		"PowaBarAuraAlphaSlider",
		"PowaBarAuraSymSlider",
		"PowaBarAuraDeformSlider",
		"PowaBarAuraSizeSlider",
		"PowaBarAuraCoordXSlider",
		"PowaBarAuraCoordSlider",
		-- Config Activation
		"PowaBarThresholdSlider",
		-- Config Animation
		"PowaBarAuraAnimSpeedSlider",
		"PowaBarAuraDurationSlider",
		-- Config Timer
		"PowaTimerCoordXSlider",
		"PowaTimerCoordSlider",
		"PowaTimerSizeSlider",
		"PowaTimerAlphaSlider",
		"PowaTimerInvertAuraSlider",
		"PowaTimerDurationSlider",
		-- Config Stacks
		"PowaStacksCoordXSlider",
		"PowaStacksCoordSlider",
		"PowaStacksSizeSlider",
		"PowaStacksAlphaSlider",
	}

	local editBoxes = {
		-- Options
		"PowaOptionsRenameEditBox",
		-- Config Main
		"PowaBarAuraTextureEdit",
		"PowaBarCustomTexName",
		"PowaBarAurasText",
		"PowaBarAuraCoordXEdit",
		"PowaBarAuraCoordYEdit",
		-- Config Activation
		"PowaBarBuffStacks",
		"PowaBarBuffName",
		"PowaBarMultiID",
		"PowaBarTooltipCheck",
		-- Config Sound
		"PowaBarCustomSound",
		"PowaBarCustomSoundEnd",
	}

	local dropDownBoxes = {
		-- Blizzard Options
		"PowaDropDownDefaultTimerTexture",
		"PowaDropDownDefaultStacksTexture",
		-- Config Activation
		"PowaDropDownBuffType",
		"PowaDropDownPowerType",
		"PowaDropDownStance",
		"PowaDropDownGTFO",
		-- Config Animation
		"PowaDropDownAnimBegin",
		"PowaDropDownAnimEnd",
		"PowaDropDownAnim1",
		"PowaDropDownAnim2",
		-- Config Sound
		"PowaDropDownSound",
		"PowaDropDownSound2",
		"PowaDropDownSoundEnd",
		"PowaDropDownSound2End",
		-- Config Timer
		"PowaDropDownTimerTexture",
		"PowaBuffTimerRelative",
		-- Config Stacks
		"PowaDropDownStacksTexture",
		"PowaBuffStacksRelative",
	}

	local itemButtons = {
		"PowaHeadSlot",
		"PowaNeckSlot",
		"PowaShoulderSlot",
		"PowaBackSlot",
		"PowaChestSlot",
		"PowaShirtSlot",
		"PowaTabardSlot",
		"PowaWristSlot",
		"PowaHandsSlot",
		"PowaWaistSlot",
		"PowaLegsSlot",
		"PowaFeetSlot",
		"PowaFinger0Slot",
		"PowaFinger1Slot",
		"PowaTrinket0Slot",
		"PowaTrinket1Slot",
		"PowaMainHandSlot",
		"PowaSecondaryHandSlot",
		"PowaRangedSlot",
	}

	for _, frame in ipairs(frames) do
		frame = _G[frame]
		SkinFrame(frame, "StripTextures")
		SkinFrame(frame, "SetTemplate", "Transparent")
	end
	for _, button in ipairs(buttons) do
		SkinControl("HandleButton", _G[button])
	end
	for _, checkBox in ipairs(checkBoxes) do
		SkinControl("HandleCheckBox", _G[checkBox])
	end
	for _, slider in ipairs(sliders) do
		SkinControl("HandleSliderFrame", _G[slider])
	end
	for _, editBox in ipairs(editBoxes) do
		SkinControl("HandleEditBox", _G[editBox])
	end
	for _, dropDownBox in ipairs(dropDownBoxes) do
		SkinControl("HandleDropDownBox", _G[dropDownBox])
	end
	for _, itemButton in ipairs(itemButtons) do
		SkinControl("HandleItemButton", _G[itemButton], true)
	end

	local icon
	for i = 1, 24 do
		icon = _G["PowaIcone"..i]
		SkinFrame(icon, "SetTemplate")
		icon:GetNormalTexture():SetTexCoord(unpack(E.TexCoords))
		icon:GetNormalTexture():SetInside(icon)
		SkinFrame(icon, "StyleButton", false, true)
	end

	SkinFrame(PowaSelected, "SetFrameStrata", PowaSelected:GetParent():GetFrameStrata())
	SkinFrame(PowaSelected, "SetFrameLevel", PowaSelected:GetParent():GetFrameLevel() + 2)
	SkinFrame(PowaSelected, "StripTextures")
	SkinFrame(PowaSelected, "SetTemplate", "Default", nil, true)
	SkinFrame(PowaSelected, "SetBackdropColor", 0, 0, 0, 0)
	SkinFrame(PowaSelected, "SetBackdropBorderColor", 1, 0.82, 0)
	SkinFrame(PowaSelected, "Hide")

	local tab
	for i = 1, 5 do
		tab = _G["PowaEditorTab"..i]
		SkinControl("HandleTab", tab)
		SkinFrame(tab, "Height", 29)
	end

	SkinFrame(PowaOptionsFrame, "Height", 463)

	SkinFrame(PowaOptionsSelectorFrame, "Height", 390)
	SkinFrame(PowaOptionsSelectorNew, "Point", "BOTTOMLEFT", 5, 86)

	SkinFrame(PowaOptionsRename, "Point", "TOP", PowaOptionsGlobalListFrame, "BOTTOM", 0, -5)

	SkinFrame(PowaOptionsRenameEditBox, "Size", 88, 20)
	SkinFrame(PowaOptionsRenameEditBox, "Point", "TOP", PowaOptionsRename, "TOP", 0, -1)

	SkinFrame(PowaEquipmentSlotsFrame, "Height", 370)

	SkinFrame(PowaHeadSlot, "Point", "TOPLEFT", 11, -25)
	SkinFrame(PowaHandsSlot, "Point", "TOPRIGHT", -11, -25)

	SkinFrame(PowaOptionsHeader, "Point", "TOP", 0, -10)
	SkinFrame(PowaHeader, "Point", "TOP", 0, -8)
	SkinFrame(PowaTitleText, "Point", "TOP", 0, -8)

	SkinControl("HandleCloseButton", PowaOptionsFrameCloseButton, PowaOptionsFrame)
	SkinControl("HandleCloseButton", PowaCloseButton, PowaBarConfigFrame)
	SkinControl("HandleCloseButton", PowaFrameCloseButton, PowaEquipmentSlotsFrame)

	SkinFrame(PowaBuffTimerCentsButton, "Size", 25)

	PowaAuthorText.Show = E.noop
	SkinFrame(PowaAuthorText, "Hide")
end)
