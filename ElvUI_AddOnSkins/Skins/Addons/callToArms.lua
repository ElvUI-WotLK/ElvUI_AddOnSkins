local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

if not AS:IsAddonLODorEnabled("CallToArms") then return end

S:AddCallbackForAddon("CallToArms", "CallToArms", function()
	if not E.private.addOnSkins.CallToArms then return end

	CTA_MainFrame:SetHeight(CTA_MainFrame:GetHeight() + 20)

	CTA_MainFrame:StripTextures()
	CTA_SearchFrame_Filters_PlayerInternalFrame:StripTextures()
	CTA_SearchFrame_Filters_GroupInternalFrame:StripTextures()
	CTA_SettingsFrameMinimapSettings:StripTextures()
	CTA_SettingsFrameLFxSettings:StripTextures()
	CTA_LogFrameInternalFrame:StripTextures()
	CTA_GreyListItemEditFrame:StripTextures()
	CTA_SearchFrameDescriptionEditBox:StripTextures()
	CTA_GreyListItemEditFrameEditBox:StripTextures()
	CTA_PlayerMinLevelEditBox:StripTextures()
	CTA_PlayerMaxLevelEditBox:StripTextures()
	CTA_ChatFrameNumberEditBox:StripTextures()
	CTA_MyRaidFrameDescriptionEditBox:StripTextures()
	CTA_MyRaidFrameMaxSizeEditBox:StripTextures()
	CTA_MyRaidFrameMinLevelEditBox:StripTextures()
	CTA_MyRaidFramePasswordEditBox:StripTextures()
	CTA_LFGDescriptionEditBox:StripTextures()
	CTA_ChatFrameNumberEditBox:StripTextures()
	CTA_LogFrameButton:StripTextures()
	CTA_ShowResultsButton:StripTextures()
	CTA_ShowOptionsButton:StripTextures()
	CTA_ShowSearchButton:StripTextures()
	CTA_ShowMyRaidButton:StripTextures()
	CTA_ShowMFFButton:StripTextures()
	CTA_ShowLFGButton:StripTextures()
	CTA_ShowBlacklistButton:StripTextures()
	CTA_SettingsFrameButton:StripTextures()
	CTA_Acid0barBorder:StripTextures()
	CTA_Acid1barBorder:StripTextures()
	CTA_Acid2barBorder:StripTextures()
	CTA_Acid3barBorder:StripTextures()
	CTA_Acid4barBorder:StripTextures()
	CTA_Acid5barBorder:StripTextures()
	CTA_Acid6barBorder:StripTextures()
	CTA_Acid7barBorder:StripTextures()
	CTA_Acid8barBorder:StripTextures()
	CTA_AcidEditDialog:StripTextures()

	CTA_MainFrame:SetTemplate("Transparent")
	CTA_SearchFrame_Filters_PlayerInternalFrame:SetTemplate("Transparent")
	CTA_SearchFrame_Filters_GroupInternalFrame:SetTemplate("Transparent")
	CTA_SettingsFrameMinimapSettings:SetTemplate("Transparent")
	CTA_SettingsFrameLFxSettings:SetTemplate("Transparent")
	CTA_LogFrameInternalFrame:SetTemplate("Transparent")
	CTA_GreyListItemEditFrame:SetTemplate("Transparent")
	CTA_Acid0barBorder:SetTemplate("Transparent")
	CTA_Acid1barBorder:SetTemplate("Transparent")
	CTA_Acid2barBorder:SetTemplate("Transparent")
	CTA_Acid3barBorder:SetTemplate("Transparent")
	CTA_Acid4barBorder:SetTemplate("Transparent")
	CTA_Acid5barBorder:SetTemplate("Transparent")
	CTA_Acid6barBorder:SetTemplate("Transparent")
	CTA_Acid7barBorder:SetTemplate("Transparent")
	CTA_Acid8barBorder:SetTemplate("Transparent")
	CTA_AcidEditDialog:SetTemplate("Default")

	S:HandleDropDownBox(CTA_SearchDropDown)
	S:HandleDropDownBox(CTA_PlayerClassDropDown)
	S:HandleDropDownBox(CTA_RoleplayDropDown)

	S:HandleCloseButton(CTA_MainFrameCloseButton)

	S:HandleNextPrevButton(CTA_SearchFrame_ResultsPrev)
	S:HandleNextPrevButton(CTA_SearchFrame_ResultsNext)
	S:HandleNextPrevButton(CTA_GreyListFramePrev)
	S:HandleNextPrevButton(CTA_GreyListFrameNext)
	S:HandleNextPrevButton(CTA_LogUpButton)
	S:HandleNextPrevButton(CTA_LogDownButton)
	S:HandleNextPrevButton(CTA_LogBottomButton)

	local callToArmsTabs = {
		"CTA_ShowSearchButton",
		"CTA_ShowMyRaidButton",
		"CTA_ShowMFFButton",
		"CTA_ShowLFGButton"
	}

	for i = 1, #callToArmsTabs do
		S:HandleTab(_G[callToArmsTabs[i]])
		_G[callToArmsTabs[i].."Text"]:SetPoint("CENTER", 0, 1)
	end

	S:HandleButton(CTA_ShowResultsButton)
	S:HandleButton(CTA_ShowOptionsButton)
	S:HandleButton(CTA_SearchButton)
	S:HandleButton(CTA_RequestInviteButton)
	S:HandleButton(CTA_ShowBlacklistButton)
	S:HandleButton(CTA_SettingsFrameButton)
	S:HandleButton(CTA_LogFrameButton)
	S:HandleButton(CTA_GreyListItemEditFrameDeleteButton)
	S:HandleButton(CTA_GreyListItemEditFrameCloseButton)
	S:HandleButton(CTA_GreyListItemEditFrameEditButton)
	S:HandleButton(CTA_AddPlayerButton)
	S:HandleButton(CTA_AnnounceToLFGButton)
	S:HandleButton(CTA_AnnounceToLFGButton2)
	S:HandleButton(CTA_StopHostingButton)
	S:HandleButton(CTA_ToggleViewableButton)
	S:HandleButton(CTA_StartAPartyButton)
	S:HandleButton(CTA_StartARaidButton)
	S:HandleButton(CTA_Acid1DeleteButton)
	S:HandleButton(CTA_Acid2DeleteButton)
	S:HandleButton(CTA_Acid3DeleteButton)
	S:HandleButton(CTA_Acid4DeleteButton)
	S:HandleButton(CTA_Acid5DeleteButton)
	S:HandleButton(CTA_Acid6DeleteButton)
	S:HandleButton(CTA_Acid7DeleteButton)
	S:HandleButton(CTA_Acid8DeleteButton)
	S:HandleButton(CTA_AcidEditDialogCloseButton)
	S:HandleButton(CTA_AcidEditDialogOkButton)

	S:HandleEditBox(CTA_SearchFrameDescriptionEditBox)
	S:HandleEditBox(CTA_GreyListItemEditFrameEditBox)
	S:HandleEditBox(CTA_PlayerMinLevelEditBox)
	S:HandleEditBox(CTA_PlayerMaxLevelEditBox)
	S:HandleEditBox(CTA_ChatFrameNumberEditBox)
	S:HandleEditBox(CTA_MyRaidFrameDescriptionEditBox)
	S:HandleEditBox(CTA_MyRaidFrameMaxSizeEditBox)
	S:HandleEditBox(CTA_MyRaidFrameMinLevelEditBox)
	S:HandleEditBox(CTA_MyRaidFramePasswordEditBox)
	S:HandleEditBox(CTA_LFGDescriptionEditBox)

	S:HandleSliderFrame(CTA_MinimapArcSlider)
	S:HandleSliderFrame(CTA_MinimapRadiusSlider)
	S:HandleSliderFrame(CTA_MinimapMsgArcSlider)
	S:HandleSliderFrame(CTA_MinimapMsgRadiusSlider)
	S:HandleSliderFrame(CTA_FrameTransparencySlider)
	S:HandleSliderFrame(CTA_FilterLevelSlider)

	CTA_ShowSearchButton:ClearAllPoints()
	CTA_ShowSearchButton:SetFrameLevel(CTA_MainFrame:GetFrameLevel() + 20)
	CTA_ShowSearchButton:Point("BOTTOMLEFT", 0, -31)
	CTA_ShowMyRaidButton:ClearAllPoints()
	CTA_ShowMyRaidButton:SetFrameLevel(CTA_MainFrame:GetFrameLevel() + 20)
	CTA_ShowMyRaidButton:Point("LEFT", CTA_ShowSearchButton, "RIGHT", 0, 0)
	CTA_ShowLFGButton:ClearAllPoints()
	CTA_ShowLFGButton:SetFrameLevel(CTA_MainFrame:GetFrameLevel() + 20)
	CTA_ShowLFGButton:Point("LEFT", CTA_ShowMyRaidButton, "RIGHT", 0, 0)
	CTA_ShowMFFButton:ClearAllPoints()
	CTA_ShowMFFButton:SetFrameLevel(CTA_MainFrame:GetFrameLevel() + 20)
	CTA_ShowMFFButton:Point("BOTTOMRIGHT", 0, -31)

	local callToArmsConfigCheck = {
		"CTA_MuteLFGChannelCheckButton",
		"CTA_ShowFilteredMessagesInChatCheckButton",
		"CTA_ShowOnMinimapCheckButton",
		"CTA_PlaySoundOnNewResultCheckButton",
		"CTA_ScanGuildChat",
		"CTA_DisableBroadcast",
		"CTA_MyRaidFramePVPCheckButton",
		"CTA_MyRaidFramePVECheckButton",
		"CTA_LFGCheckButton",
		"CTA_AcidClassCheckButton1",
		"CTA_AcidClassCheckButton2",
		"CTA_AcidClassCheckButton3",
		"CTA_AcidClassCheckButton4",
		"CTA_AcidClassCheckButton5",
		"CTA_AcidClassCheckButton6",
		"CTA_AcidClassCheckButton7",
		"CTA_AcidClassCheckButton8",
		"CTA_AcidClassCheckButton9",
		"CTA_AcidClassCheckButton10"
	}

	for i = 1, #callToArmsConfigCheck do
		S:HandleCheckBox(_G[callToArmsConfigCheck[i]])
	end
end)