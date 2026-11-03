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

if not AS:IsAddonLODorEnabled("SuperDuperMacro") then return end

local _G = _G
local ipairs = ipairs
local unpack = unpack

-- SuperDuperMacro 1.8.3
-- https://github.com/hypehuman/super-duper-macro/tree/d25b5fe50add9f03185bc09327144d450ffc85e4

S:AddCallbackForAddon("SuperDuperMacro", "SuperDuperMacro", function()
	if not E.private.addOnSkins.SuperDuperMacro then return end

	local frames = {
		"sdm_mainFrame",
		"sdm_newFrame",
		"sdm_newFolderFrame",
		"sdm_sendReceiveFrame",
	}

	local buttons = {
		"sdm_mainFrame_linkToMacroFrame",
		"sdm_mainFrame_aboutButton",
		"sdm_mainFrame_newButton",
		"sdm_mainFrame_sendReceiveButton",
		"sdm_mainFrame_newFolderButton",
		"sdm_mainFrame_changeIconButton",
		"sdm_mainFrame_getLinkButton",
		"sdm_mainFrame_deleteButton",
		"sdm_mainFrame_saveButton",

		"sdm_newFrame_createButton",
		"sdm_newFrame_cancelButton",

		"sdm_newFolderFrame_createButton",
		"sdm_newFolderFrame_cancelButton",

		"sdm_sendReceiveFrame_sendButton",
		"sdm_sendReceiveFrame_cancelSendButton",
		"sdm_sendReceiveFrame_receiveButton",
		"sdm_sendReceiveFrame_cancelReceiveButton",
	}

	local editBoxes = {
		"sdm_newFrame_input",

		"sdm_sendReceiveFrame_sendInput",
		"sdm_sendReceiveFrame_receiveInput",
		"sdm_sendReceiveFrame_receiveInput",

		"sdm_newFolderFrame_input",

		"sdm_changeIconFrame_input",
	}

	for _, frame in ipairs(frames) do
		frame = _G[frame]
		SkinFrame(frame, "StripTextures")
		SkinFrame(frame, "SetTemplate", "Transparent")
	end

	for _, button in ipairs(buttons) do
		SkinControl("HandleButton", _G[button])
	end

	for _, editBox in ipairs(editBoxes) do
		SkinControl("HandleEditBox", _G[editBox])
	end

	-- mainFrame
	SkinFrame(sdm_mainFrame, "Size", 670, 424)
	sdm_mainFrame:SetClampedToScreen(true)
	SkinFrame(sdm_mainFrame, "HookScript", "OnShow", function(self)
		SkinFrame(self, "Point", "TOPLEFT", UIParent, "TOPLEFT", 11, -116)
	end)

	SkinControl("HandleCloseButton", sdm_mainFrame_quitButton, sdm_mainFrame)

	SkinFrame(sdm_mainFrameTitle, "Point", "TOP", 0, -4)

	SkinFrame(sdm_mainFrame_linkToMacroFrame, "Point", "TOPLEFT", 8, -8)

	SkinFrame(sdm_mainFrame_newButton, "Point", "TOPLEFT", 84, -30)
	SkinFrame(sdm_mainFrame_sendReceiveButton, "Point", "TOPLEFT", sdm_mainFrame_newButton, "TOPRIGHT", 3, 0)

	SkinControl("HandleDropDownBox", sdm_mainFrame_charFilterDropdown)
	SkinFrame(sdm_mainFrame_charFilterDropdown, "Point", "BOTTOMRIGHT", sdm_mainFrame_macrosScroll, "TOPRIGHT", 30, -5)
	SkinControl("HandleDropDownBox", sdm_mainFrame_typeFilterDropdown)
	SkinFrame(sdm_mainFrame_typeFilterDropdown, "Point", "RIGHT", sdm_mainFrame_charFilterDropdown, "LEFT", 25, 0)

	SkinFrame(sdm_mainFrame_collapseAllButton, "SetNormalTexture", E.Media.Textures.Minus)
	sdm_mainFrame_collapseAllButton:SetCheckedTexture(E.Media.Textures.Plus)
	SkinFrame(sdm_mainFrame_collapseAllButton, "Point", "BOTTOMLEFT", sdm_mainFrame_macrosScroll, "TOPLEFT", 5, 3)

	SkinFrame(sdm_mainFrame_macrosScroll, "Size", 256, 306)
	SkinFrame(sdm_mainFrame_macrosScroll, "Point", "BOTTOMLEFT", 9, 39)

	SkinFrame(sdm_mainFrame_listBackground, "SetTemplate", "Transparent")
	SkinFrame(sdm_mainFrame_listBackground, "Size", 258, 309)
	SkinFrame(sdm_mainFrame_listBackground, "Point", "TOPRIGHT", sdm_mainFrame_macrosScroll, "TOPRIGHT", 1, 1)

	SkinControl("HandleScrollBar", sdm_mainFrame_macrosScrollScrollBar)
	SkinFrame(sdm_mainFrame_macrosScrollScrollBar, "Point", "TOPLEFT", sdm_mainFrame_macrosScroll, "TOPRIGHT", 4, -18)
	SkinFrame(sdm_mainFrame_macrosScrollScrollBar, "Point", "BOTTOMLEFT", sdm_mainFrame_macrosScroll, "BOTTOMRIGHT", 4, 17)

	SkinFrame(sdm_mainFrame_editScrollFrame, "Size", 347, 353)
	SkinFrame(sdm_mainFrame_editScrollFrame, "Point", "BOTTOMRIGHT", -30, 39)

	SkinFrame(sdm_mainFrame_editBackground, "SetTemplate", "Transparent")
	SkinFrame(sdm_mainFrame_editBackground, "Size", 349, 357)
	SkinFrame(sdm_mainFrame_editBackground, "Point", "TOPRIGHT", sdm_mainFrame_editScrollFrame, "TOPRIGHT", 1, 2)

	SkinFrame(sdm_mainFrame_editScrollFrame_text, "Width", 346)

	SkinControl("HandleScrollBar", sdm_mainFrame_editScrollFrameScrollBar)
	SkinFrame(sdm_mainFrame_editScrollFrameScrollBar, "Point", "TOPLEFT", sdm_mainFrame_editScrollFrame, "TOPRIGHT", 4, -17)
	SkinFrame(sdm_mainFrame_editScrollFrameScrollBar, "Point", "BOTTOMLEFT", sdm_mainFrame_editScrollFrame, "BOTTOMRIGHT", 4, 17)

	SkinFrame(sdm_mainFrame_saveButton, "Point", "BOTTOMRIGHT", -8, 8)
	SkinFrame(sdm_mainFrame_deleteButton, "Point", "RIGHT", sdm_mainFrame_saveButton, "LEFT", -3, 0)
	SkinFrame(sdm_mainFrame_getLinkButton, "Point", "RIGHT", sdm_mainFrame_deleteButton, "LEFT", -3, 0)

	SkinFrame(sdm_mainFrame_changeIconButton, "Width", 144)
	SkinFrame(sdm_mainFrame_changeIconButton, "Point", "RIGHT", sdm_mainFrame_getLinkButton, "LEFT", -3, 0)

	SkinFrame(sdm_mainFrame_newFolderButton, "Point", "RIGHT", sdm_mainFrame_getLinkButton, "LEFT", -308, 0)

	SkinControl("HandleSliderFrame", sdm_mainFrame_iconSizeSlider)
	SkinFrame(sdm_mainFrame_iconSizeSlider, "Width", 155)
	SkinFrame(sdm_mainFrame_iconSizeSlider, "Point", "BOTTOMLEFT", 111, 13)

	local function collapseSetTexture(self, texture)
		if texture == "Interface\\Buttons\\UI-PlusButton-UP" then
			self:_SetTexture(E.Media.Textures.Plus)
		else
			self:_SetTexture(E.Media.Textures.Minus)
		end
	end

	hooksecurefunc("sdm_UpdateList", function()
		if not sdm_mainFrame:IsShown() then return end

		for _, button in ipairs(sdm_listItems) do
			if not button.isSkinned then
				button.highlight:SetTexture(E.Media.Textures.Highlight)

				if button.isContainerFrame then
					button.icon._SetTexture = button.icon.SetTexture
					button.icon.SetTexture = collapseSetTexture
					button.icon:SetTexture(button.icon:GetTexture())
				else
					button.icon:SetTexCoord(unpack(E.TexCoords))

					button.buttonHighlight:SetTexture(1, 1, 1, 0.3)
					button.buttonHighlight.SetTexture = E.noop

					button.slotIcon:Hide()
				end

				button.isSkinned = true
			end
		end
	end)

	-- newFrame
	SkinFrame(sdm_newFrame_input, "Height", 20)

	SkinFrame(sdm_newFrame_createButton, "Point", "TOPLEFT", sdm_newFrame_input, "BOTTOMLEFT", -1, -8)
	SkinFrame(sdm_newFrame_cancelButton, "Point", "LEFT", sdm_newFrame_createButton, "RIGHT", 7, 0)

	hooksecurefunc("sdm_DefaultMacroFrameLoaded", function()
		SkinFrame(MacroFrame_linkToSDM, "Point", "TOPLEFT", 19, -20)
		SkinControl("HandleButton", MacroFrame_linkToSDM)

		SkinControl("HandleCheckBox", MacroPopupFrame_buttonTextCheckBox)

		SkinControl("HandleButton", MacroPopupFrame_sdmOkayButton)
		SkinControl("HandleButton", MacroPopupFrame_sdmCancelButton)
	end)

	-- newFolderFrame
	SkinFrame(sdm_newFolderFrame_input, "Height", 20)

	SkinFrame(sdm_newFolderFrame_createButton, "Point", "TOPLEFT", sdm_newFolderFrame_input, "BOTTOMLEFT", -1, -8)
	SkinFrame(sdm_newFolderFrame_cancelButton, "Point", "LEFT", sdm_newFolderFrame_createButton, "RIGHT", 7, 0)

	-- sendReceiveFrame
	SkinFrame(sdm_sendReceiveFrame, "Point", "LEFT", sdm_mainFrame, "RIGHT", -1, 62)

	SkinControl("HandleCloseButton", sdm_sendReceiveFrame_quitButton, sdm_sendReceiveFrame)

	SkinFrame(sdm_sendReceiveFrame_sendInput, "Height", 20)
	SkinFrame(sdm_sendReceiveFrame_receiveInput, "Height", 20)

	SkinFrame(sdm_sendReceiveFrame_sendBar, "SetBackdrop", nil)
	SkinControl("HandleStatusBar", sdm_sendReceiveFrame_sendBar_statusBar)

	SkinFrame(sdm_sendReceiveFrame_receiveBar, "SetBackdrop", nil)
	SkinControl("HandleStatusBar", sdm_sendReceiveFrame_receiveBar_statusBar)

	-- changeIconFrame
	SkinFrame(sdm_changeIconFrame, "StripTextures")
	SkinFrame(sdm_changeIconFrame, "SetTemplate", "Default")
	sdm_changeIconFrame:EnableMouse(true)
	SkinFrame(sdm_changeIconFrame, "Size", 296, 357)
	SkinFrame(sdm_changeIconFrame, "Point", "CENTER", 107, 4)

	SkinFrame(sdm_changeIconFrame_input, "Height", 20)

	hooksecurefunc("sdm_OnShow_changeIconFrame", function(f)
		SkinFrame(MacroPopupFrame, "Point", "BOTTOM", -4, 1)
	end)
end)
