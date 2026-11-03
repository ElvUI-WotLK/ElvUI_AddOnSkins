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

if not AS:IsAddonLODorEnabled("CallToArms") then return end

local _G = _G
local ipairs = ipairs
local select = select

-- CallToArms r303

S:AddCallbackForAddon("CallToArms", "CallToArms", function()
	if not E.private.addOnSkins.CallToArms then return end

	local frames = {
		CTA_SearchFrame_Filters_PlayerInternalFrame,
		CTA_SearchFrame_Filters_GroupInternalFrame,
		CTA_SettingsFrameMinimapSettings,
		CTA_SettingsFrameLFxSettings,
		CTA_LogFrameInternalFrame,
		CTA_GreyListItemEditFrame,
		CTA_AddPlayerFrame,
	}
	local buttons = {
		CTA_SearchButton,
		CTA_RequestInviteButton,
		CTA_GreyListItemEditFrameDeleteButton,
		CTA_GreyListItemEditFrameCloseButton,
		CTA_GreyListItemEditFrameEditButton,
		CTA_AddPlayerButton,
		CTA_AnnounceToLFGButton,
		CTA_AnnounceToLFGButton2,
		CTA_StopHostingButton,
		CTA_ConvertToRaidButton,
		CTA_ConvertToPartyButton,
		CTA_ToggleViewableButton,
		CTA_StartAPartyButton,
		CTA_StartARaidButton,
		CTA_AcidEditDialogCloseButton,
		CTA_AcidEditDialogOkButton,
		CTA_AddPlayerFrameCloseButton,
		CTA_AddPlayerFrameOkButton,
	}
	local checkBoxes = {
		CTA_MuteLFGChannelCheckButton,
		CTA_ShowFilteredMessagesInChatCheckButton,
		CTA_ShowOnMinimapCheckButton,
		CTA_PlaySoundOnNewResultCheckButton,
		CTA_ScanGuildChat,
		CTA_DisableBroadcast,
		CTA_MyRaidFramePVPCheckButton,
		CTA_MyRaidFramePVECheckButton,
		CTA_LFGCheckButton,
		CTA_AcidClassCheckButton1,
		CTA_AcidClassCheckButton2,
		CTA_AcidClassCheckButton3,
		CTA_AcidClassCheckButton4,
		CTA_AcidClassCheckButton5,
		CTA_AcidClassCheckButton6,
		CTA_AcidClassCheckButton7,
		CTA_AcidClassCheckButton8,
		CTA_AcidClassCheckButton9,
		CTA_AcidClassCheckButton10
	}
	local editBoxes = {
		CTA_SearchFrameDescriptionEditBox,
		CTA_GreyListItemEditFrameEditBox,
		CTA_PlayerMinLevelEditBox,
		CTA_PlayerMaxLevelEditBox,
		CTA_ChatFrameNumberEditBox,
		CTA_MyRaidFrameDescriptionEditBox,
		CTA_MyRaidFrameMaxSizeEditBox,
		CTA_MyRaidFrameMinLevelEditBox,
		CTA_MyRaidFramePasswordEditBox,
		CTA_LFGDescriptionEditBox,
		CTA_AddPlayerFrameEditBox,
	}
	local sliders = {
		CTA_MinimapArcSlider,
		CTA_MinimapRadiusSlider,
		CTA_MinimapMsgArcSlider,
		CTA_MinimapMsgRadiusSlider,
		CTA_FrameTransparencySlider,
		CTA_FilterLevelSlider,
	}
	local nextPrevButtons = {
		CTA_SearchFrame_ResultsPrev,
		CTA_SearchFrame_ResultsNext,
		CTA_GreyListFramePrev,
		CTA_GreyListFrameNext,
		CTA_LogUpButton,
		CTA_LogDownButton,
		CTA_LogBottomButton,
	}
	local tabNames = {
		CTA_ShowResultsButton,
		CTA_ShowOptionsButton,
		CTA_ShowBlacklistButton,
		CTA_SettingsFrameButton,
		CTA_LogFrameButton,
		CTA_ShowSearchButton,
		CTA_ShowMyRaidButton,
		CTA_ShowMFFButton,
		CTA_ShowLFGButton,
	}

	for _, frame in ipairs(frames) do
		SkinFrame(frame, "SetTemplate", "Transparent")
	end
	for _, button in ipairs(buttons) do
		SkinControl("HandleButton", button)
	end
	for _, checkbox in ipairs(checkBoxes) do
		SkinControl("HandleCheckBox", checkbox)
	end
	for _, slider in ipairs(sliders) do
		SkinControl("HandleSliderFrame", slider)
	end
	for _, nextPrevButton in ipairs(nextPrevButtons) do
		SkinControl("HandleNextPrevButton", nextPrevButton)
	end
	for _, tab in ipairs(tabNames) do
		SkinControl("HandleTab", tab)

		local text = _G[tab:GetName().."Text"]
		SkinFrame(text, "ClearAllPoints")
		SkinFrame(text, "Point", "CENTER", 0, 1)
	end

	local function editboxClearFocus(self)
		self:ClearFocus()
	end
	for _, editBox in ipairs(editBoxes) do
		local backdrop, border = select(6, editBox:GetRegions())
		SkinFrame(backdrop, "Hide")
		SkinFrame(border, "Hide")

		SkinControl("HandleEditBox", editBox)

		if not editBox:GetScript("OnEnterPressed") then
			SkinFrame(editBox, "SetScript", "OnEnterPressed", editboxClearFocus)
		end
		if not editBox:GetScript("OnEscapePressed") then
			SkinFrame(editBox, "SetScript", "OnEscapePressed", editboxClearFocus)
		end
	end

	SkinFrame(CTA_MainFrame, "StripTextures")
	SkinFrame(CTA_MainFrame, "SetTemplate", "Transparent")
	SkinFrame(CTA_MainFrame, "Height", 500)

	SkinControl("HandleCloseButton", CTA_MainFrameCloseButton, CTA_MainFrame)

	SkinFrame(CTA_SearchDropDown, "Point", "TOPLEFT", 4, -48)
	SkinControl("HandleDropDownBox", CTA_SearchDropDown, 200)
	SkinControl("HandleDropDownBox", CTA_PlayerClassDropDown, 100)
	SkinControl("HandleDropDownBox", CTA_RoleplayDropDown, 100)

	SkinFrame(CTA_SearchFrame_ResultsPrev, "Point", "BOTTOM", -60, 7)
	SkinFrame(CTA_SearchFrame_ResultsNext, "Point", "BOTTOM", 60, 7)

	SkinFrame(CTA_GreyListFramePrev, "Point", "BOTTOM", -60, 7)
	SkinFrame(CTA_GreyListFrameNext, "Point", "BOTTOM", 60, 7)

	SkinFrame(CTA_ShowSearchButton, "Point", "TOPLEFT", CTA_MainFrame, "BOTTOMLEFT", 0, 2)
	SkinFrame(CTA_ShowMyRaidButton, "Point", "TOPLEFT", CTA_ShowSearchButton, "TOPRIGHT", -15, 0)
	SkinFrame(CTA_ShowLFGButton, "Point", "TOPLEFT", CTA_ShowMyRaidButton, "TOPRIGHT", -15, 0)
	SkinFrame(CTA_ShowMFFButton, "Point", "TOPRIGHT", CTA_MainFrame, "BOTTOMRIGHT", 0, 2)

	SkinFrame(CTA_AnnounceToLFGButton2, "Point", "BOTTOM", 0, 90)

	SkinFrame(CTA_AcidEditDialog, "StripTextures")
	SkinFrame(CTA_AcidEditDialog, "SetTemplate", "Default")

	for i = 0, 10 do
		SkinFrame(_G["CTA_Acid"..i.."barBorder"], "SetTemplate", "Transparent")
		SkinControl("HandleButton", _G["CTA_Acid"..i.."DeleteButton"])

		local button = _G["CTA_Acid"..i.."MoreButton"]
		SkinFrame(button, "Point", "TOPLEFT", 43, 0)
		SkinControl("HandleNextPrevButton", button, "up")

		button = _G["CTA_Acid"..i.."LessButton"]
		SkinFrame(button, "Point", "TOPLEFT", 43, -30)
		SkinControl("HandleNextPrevButton", button, "down")
	end
end)
