local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

if not AS:IsAddonLODorEnabled("SuperDuperMacro") then return end

local _G = _G

-- SuperDuperMacro 1.8.3
-- https://www.wowinterface.com/downloads/getfile.php?id=10496&aid=59782

S:AddCallbackForAddon("SuperDuperMacro", "SuperDuperMacro", function()
	if not E.private.addOnSkins.SuperDuperMacro then return end

	local frames = {
		"sdm_mainFrame",
		"sdm_newFrame",
		"sdm_newFolderFrame",
		"sdm_changeIconFrame",
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
		"sdm_sendReceiveFrame_sendButton",
		"sdm_sendReceiveFrame_cancelSendButton",
		"sdm_sendReceiveFrame_receiveButton",
		"sdm_sendReceiveFrame_cancelReceiveButton",
		"sdm_newFolderFrame_createButton",
		"sdm_newFolderFrame_cancelButton",
	}

	local editBoxes = {
		"sdm_newFrame_input",
		"sdm_sendReceiveFrame_sendInput",
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

	sdm_mainFrame_listBackground:SetTemplate("Transparent")
	S:HandleScrollBar(sdm_mainFrame_macrosScrollScrollBar)

	sdm_mainFrame_editBackground:SetTemplate("Transparent")
	S:HandleScrollBar(sdm_mainFrame_editScrollFrameScrollBar)

	S:HandleCloseButton(sdm_mainFrame_quitButton)
	S:HandleCloseButton(sdm_sendReceiveFrame_quitButton)

	sdm_mainFrame_charFilterDropdown:Point("BOTTOMRIGHT", sdm_mainFrame_macrosScroll, "TOPRIGHT", 30, 0)
	S:HandleDropDownBox(sdm_mainFrame_charFilterDropdown)
	sdm_mainFrame_typeFilterDropdown:Point("RIGHT", sdm_mainFrame_charFilterDropdown, "LEFT", 26, 0)
	S:HandleDropDownBox(sdm_mainFrame_typeFilterDropdown)

	S:HandleSliderFrame(sdm_mainFrame_iconSizeSlider)

	sdm_sendReceiveFrame_sendBar:SetBackdrop(nil)
	S:HandleStatusBar(sdm_sendReceiveFrame_sendBar_statusBar)
	sdm_sendReceiveFrame_receiveBar_statusBar:SetBackdrop(nil)
	S:HandleStatusBar(sdm_sendReceiveFrame_receiveBar_statusBar)

	hooksecurefunc("sdm_DefaultMacroFrameLoaded", function()
		S:HandleButton(MacroFrame_linkToSDM)
		S:HandleButton(MacroPopupFrame_sdmOkayButton)
		S:HandleButton(MacroPopupFrame_sdmCancelButton)
	end)
end)