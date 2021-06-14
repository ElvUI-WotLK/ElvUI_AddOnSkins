local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
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
		frame:StripTextures()
		frame:SetTemplate("Transparent")
	end

	for _, button in ipairs(buttons) do
		S:HandleButton(_G[button])
	end

	for _, editBox in ipairs(editBoxes) do
		S:HandleEditBox(_G[editBox])
	end

	-- mainFrame
	sdm_mainFrame:Size(670, 424)
	sdm_mainFrame:SetClampedToScreen(true)
	sdm_mainFrame:HookScript("OnShow", function(self)
		self:Point("TOPLEFT", UIParent, "TOPLEFT", 11, -116)
	end)

	S:HandleCloseButton(sdm_mainFrame_quitButton, sdm_mainFrame)

	sdm_mainFrameTitle:Point("TOP", 0, -4)

	sdm_mainFrame_linkToMacroFrame:Point("TOPLEFT", 8, -8)

	sdm_mainFrame_newButton:Point("TOPLEFT", 84, -30)
	sdm_mainFrame_sendReceiveButton:Point("TOPLEFT", sdm_mainFrame_newButton, "TOPRIGHT", 3, 0)

	S:HandleDropDownBox(sdm_mainFrame_charFilterDropdown)
	sdm_mainFrame_charFilterDropdown:Point("BOTTOMRIGHT", sdm_mainFrame_macrosScroll, "TOPRIGHT", 30, -5)
	S:HandleDropDownBox(sdm_mainFrame_typeFilterDropdown)
	sdm_mainFrame_typeFilterDropdown:Point("RIGHT", sdm_mainFrame_charFilterDropdown, "LEFT", 25, 0)

	sdm_mainFrame_collapseAllButton:SetNormalTexture(E.Media.Textures.Minus)
	sdm_mainFrame_collapseAllButton:SetCheckedTexture(E.Media.Textures.Plus)
	sdm_mainFrame_collapseAllButton:Point("BOTTOMLEFT", sdm_mainFrame_macrosScroll, "TOPLEFT", 5, 3)

	sdm_mainFrame_macrosScroll:Size(256, 306)
	sdm_mainFrame_macrosScroll:Point("BOTTOMLEFT", 9, 39)

	sdm_mainFrame_listBackground:SetTemplate("Transparent")
	sdm_mainFrame_listBackground:Size(258, 309)
	sdm_mainFrame_listBackground:Point("TOPRIGHT", sdm_mainFrame_macrosScroll, "TOPRIGHT", 1, 1)

	S:HandleScrollBar(sdm_mainFrame_macrosScrollScrollBar)
	sdm_mainFrame_macrosScrollScrollBar:Point("TOPLEFT", sdm_mainFrame_macrosScroll, "TOPRIGHT", 4, -18)
	sdm_mainFrame_macrosScrollScrollBar:Point("BOTTOMLEFT", sdm_mainFrame_macrosScroll, "BOTTOMRIGHT", 4, 17)

	sdm_mainFrame_editScrollFrame:Size(347, 353)
	sdm_mainFrame_editScrollFrame:Point("BOTTOMRIGHT", -30, 39)

	sdm_mainFrame_editBackground:SetTemplate("Transparent")
	sdm_mainFrame_editBackground:Size(349, 357)
	sdm_mainFrame_editBackground:Point("TOPRIGHT", sdm_mainFrame_editScrollFrame, "TOPRIGHT", 1, 2)

	sdm_mainFrame_editScrollFrame_text:Width(346)

	S:HandleScrollBar(sdm_mainFrame_editScrollFrameScrollBar)
	sdm_mainFrame_editScrollFrameScrollBar:Point("TOPLEFT", sdm_mainFrame_editScrollFrame, "TOPRIGHT", 4, -17)
	sdm_mainFrame_editScrollFrameScrollBar:Point("BOTTOMLEFT", sdm_mainFrame_editScrollFrame, "BOTTOMRIGHT", 4, 17)

	sdm_mainFrame_saveButton:Point("BOTTOMRIGHT", -8, 8)
	sdm_mainFrame_deleteButton:Point("RIGHT", sdm_mainFrame_saveButton, "LEFT", -3, 0)
	sdm_mainFrame_getLinkButton:Point("RIGHT", sdm_mainFrame_deleteButton, "LEFT", -3, 0)

	sdm_mainFrame_changeIconButton:Width(144)
	sdm_mainFrame_changeIconButton:Point("RIGHT", sdm_mainFrame_getLinkButton, "LEFT", -3, 0)

	sdm_mainFrame_newFolderButton:Point("RIGHT", sdm_mainFrame_getLinkButton, "LEFT", -308, 0)

	S:HandleSliderFrame(sdm_mainFrame_iconSizeSlider)
	sdm_mainFrame_iconSizeSlider:Width(155)
	sdm_mainFrame_iconSizeSlider:Point("BOTTOMLEFT", 111, 13)

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
	sdm_newFrame_input:Height(20)

	sdm_newFrame_createButton:Point("TOPLEFT", sdm_newFrame_input, "BOTTOMLEFT", -1, -8)
	sdm_newFrame_cancelButton:Point("LEFT", sdm_newFrame_createButton, "RIGHT", 7, 0)

	hooksecurefunc("sdm_DefaultMacroFrameLoaded", function()
		MacroFrame_linkToSDM:Point("TOPLEFT", 19, -20)
		S:HandleButton(MacroFrame_linkToSDM)

		S:HandleCheckBox(MacroPopupFrame_buttonTextCheckBox)

		S:HandleButton(MacroPopupFrame_sdmOkayButton)
		S:HandleButton(MacroPopupFrame_sdmCancelButton)
	end)

	-- newFolderFrame
	sdm_newFolderFrame_input:Height(20)

	sdm_newFolderFrame_createButton:Point("TOPLEFT", sdm_newFolderFrame_input, "BOTTOMLEFT", -1, -8)
	sdm_newFolderFrame_cancelButton:Point("LEFT", sdm_newFolderFrame_createButton, "RIGHT", 7, 0)

	-- sendReceiveFrame
	sdm_sendReceiveFrame:Point("LEFT", sdm_mainFrame, "RIGHT", -1, 62)

	S:HandleCloseButton(sdm_sendReceiveFrame_quitButton, sdm_sendReceiveFrame)

	sdm_sendReceiveFrame_sendInput:Height(20)
	sdm_sendReceiveFrame_receiveInput:Height(20)

	sdm_sendReceiveFrame_sendBar:SetBackdrop(nil)
	S:HandleStatusBar(sdm_sendReceiveFrame_sendBar_statusBar)

	sdm_sendReceiveFrame_receiveBar:SetBackdrop(nil)
	S:HandleStatusBar(sdm_sendReceiveFrame_receiveBar_statusBar)

	-- changeIconFrame
	sdm_changeIconFrame:StripTextures()
	sdm_changeIconFrame:SetTemplate("Default")
	sdm_changeIconFrame:EnableMouse(true)
	sdm_changeIconFrame:Size(296, 357)
	sdm_changeIconFrame:Point("CENTER", 107, 4)

	sdm_changeIconFrame_input:Height(20)

	hooksecurefunc("sdm_OnShow_changeIconFrame", function(f)
		MacroPopupFrame:Point("BOTTOM", -4, 1)
	end)
end)