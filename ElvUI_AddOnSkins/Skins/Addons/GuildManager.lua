local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")
if not AS:IsAddonLODorEnabled("GuildManager") then return end

local _G = _G
local ipairs = ipairs
local unpack = unpack

local hooksecurefunc = hooksecurefunc


S:AddCallbackForAddon("GuildManager", "GuildManager", function()
	if not E.private.addOnSkins.GuildManager then return end

	-- Master
	GuildManagerFrame:StripTextures()
	GuildManagerFrame:SetTemplate("Transparent")
	GuildManagerFrame:SetClampRectInsets(0, 0, 0, 0)

	GuildManagerEditDialog:StripTextures()
	GuildManagerEditDialog:SetTemplate("Transparent")
	GuildManagerEditDialog:SetClampRectInsets(0, 0, 0, 0)


	local promoteButton = _G["GuildManagerEditDialogPromoteButton"]
	S:HandleButton(promoteButton)
	promoteButton:SetNormalTexture(E.Media.Textures.ArrowUp)
	promoteButton:GetNormalTexture():SetRotation(S.ArrowRotation.up)

	local demoteButton = _G["GuildManagerEditDialogDemoteButton"]
	S:HandleButton(demoteButton)
	demoteButton:SetNormalTexture(E.Media.Textures.ArrowUp)
	demoteButton:GetNormalTexture():SetRotation(S.ArrowRotation.down)
	--S:HandleButton(_G["talentsbutton"])
	--_G["talentsbutton"]:SetNormalTexture(E.Media.Textures.Plus)
	--_G["talentsbutton"]:SetPushedTexture(E.Media.Textures.Plus)

	--S:HandleButton(_G["optionsbutton"])
	--_G["optionsbutton"]:SetNormalTexture(E.Media.Textures.Plus)
	--_G["optionsbutton"]:SetPushedTexture(E.Media.Textures.Plus)


	local scrollBars = {
        "GuildManagerScrollFrameScrollBar",
        "GuildManagerEditDialogPublicNoteScrollScrollBar",
        "GuildManagerEditDialogOfficerNoteScrollScrollBar",
	}

	local buttons = {
        "GuildManagerFrameRefreshButton",
        "GuildManagerFrameAddMemberButton",
        "GuildManagerFrameHeaderFrameNameHeader",
        "GuildManagerFrameHeaderFrameClassHeader",
        "GuildManagerFrameHeaderFrameLevelHeader",
        "GuildManagerFrameHeaderFrameRankHeader",
        "GuildManagerFrameHeaderFrameNoteHeader",
        "GuildManagerFrameHeaderFrameOfficerNoteHeader",
        "GuildManagerFrameHeaderFrameLastOnlineHeader",
        "GuildManagerEditDialogSaveButton",
        "GuildManagerEditDialogCancelButton",
        "GuildManagerEditDialogRemoveButton",
        "GuildManagerEditDialogInviteButton",
	}

	local checkBoxes = {
        "GuildManagerFrameShowOfflineCheckbox",
	}

	local editBoxes = {
        "GuildManagerFrameSearchBox",
        "GuildManagerEditDialogPublicNoteScroll",
        "GuildManagerEditDialogOfficerNoteScroll",
	}

	local dropDownBoxes = {
		-- Main Frame
	}

	local closeButtons = {
        "GuildManagerFrameCloseButton",
        "GuildManagerEditDialogCloseButton",
	}

	local statusBars = {
	}

	local sliderFrames = {
	}

	for _, scrollBar in ipairs(scrollBars) do
		scrollBar = _G[scrollBar]
        --scrollBar:GetParent():StripTextures()
		S:HandleScrollBar(scrollBar)
	end
	for _, button in ipairs(buttons) do
		S:HandleButton(_G[button])
	end
	for _, checkBox in ipairs(checkBoxes) do
		S:HandleCheckBox(_G[checkBox])
	end
	for _, editBox in ipairs(editBoxes) do
        _G[editBox]:StripTextures()
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