local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")
if not AS:IsAddonLODorEnabled("RaidBuffStatus") then return end

local _G = _G
local ipairs = ipairs
local unpack = unpack

local hooksecurefunc = hooksecurefunc


S:AddCallbackForAddon("RaidBuffStatus", "RaidBuffStatus", function()
	if not E.private.addOnSkins.RaidBuffStatus then return end

	local core = LibStub("AceAddon-3.0"):GetAddon("RaidBuffStatus")
	if not core then return end
	-- Master
	RBSFrame:StripTextures()
	RBSFrame:SetTemplate("Transparent")
	RBSFrame:SetClampRectInsets(0, 0, 0, 0)
	-- Talents Frame
	RBSTalentsFrame:StripTextures()
	RBSTalentsFrame:SetTemplate("Transparent")
	RBSTalentsFrame:SetClampRectInsets(0, 0, 0, 0)
	-- Options
	RBSOptionsFrame:StripTextures()
	RBSOptionsFrame:SetTemplate("Transparent")
	RBSOptionsFrame:SetClampRectInsets(0, 0, 0, 0)
	
	S:HandleButton(_G["talentsbutton"])
	_G["talentsbutton"]:SetNormalTexture(E.Media.Textures.Plus)
	_G["talentsbutton"]:SetPushedTexture(E.Media.Textures.Plus)

	S:HandleButton(_G["optionsbutton"])
	_G["optionsbutton"]:SetNormalTexture(E.Media.Textures.Plus)
	_G["optionsbutton"]:SetPushedTexture(E.Media.Textures.Plus)

	
	local scrollBars = {
		-- Main Frame

	}

	local buttons = {
		"RBSTalentsFrameButton",
		"RBSOptionsFrameButton",
	}

	local checkBoxes = {
		-- Config

	}

	local editBoxes = {
		-- Master

	}

	local dropDownBoxes = {
		-- Main Frame

	}

	local closeButtons = {
		-- Main Frame
	}

	local statusBars = {
		-- History

	}

	local sliderFrames = {
		-- Config
	}

	for _, scrollBar in ipairs(scrollBars) do
		scrollBar = _G[scrollBar]
		scrollBar:GetParent():StripTextures()
		S:HandleScrollBar(scrollBar)
	end
	for _, button in ipairs(buttons) do
		S:HandleButton(_G[button])
	end
	for _, checkBox in ipairs(checkBoxes) do
		S:HandleCheckBox(_G[checkBox])
	end
	for _, editBox in ipairs(editBoxes) do
		S:HandleEditBox(_G[editBox])
	end
	for _, dropDownBox in ipairs(dropDownBoxes) do
		S:HandleDropDownBox(_G[dropDownBox])
	end
	for _, closeButton in ipairs(closeButtons) do
		closeButton = _G[closeButton]
		S:HandleCloseButton(closeButton, closeButton:GetParent().backdrop)
	end
	for _, sliderFrame in ipairs(sliderFrames) do
		sliderFrame = _G[sliderFrame]
		S:HandleSliderFrame(sliderFrame)
	end
	for _, statusBar in ipairs(statusBars) do
		statusBar = _G[statusBar]
		statusBar:StripTextures()
		statusBar:CreateBackdrop()
		statusBar:SetStatusBarTexture(E.media.normTex)
		E:RegisterStatusBar(statusBar)
	end
end)
