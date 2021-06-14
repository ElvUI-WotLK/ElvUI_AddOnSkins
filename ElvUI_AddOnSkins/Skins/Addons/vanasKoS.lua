local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

if not AS:IsAddonLODorEnabled("VanasKoS") then return end

-- Vanas KoS 4.25
-- https://www.curseforge.com/wow/addons/vanaskos/files/457856

S:AddCallbackForAddon("VanasKoS", "VanasKoS", function()
	if not E.private.addOnSkins.VanasKoS then return end

	S:HandleTab(FriendsFrameTab6)
	FriendsFrameTab6:ClearAllPoints()
	FriendsFrameTab6:Point("TOPLEFT", FriendsFrameTab5, "TOPRIGHT", -15, 0)

	E:GetModule("Tooltip"):HookScript(VanasKoSListTooltip, "OnShow", "SetStyle")

	-- Warn Frame
	VanasKoS_WarnFrame:SetTemplate("Transparent", nil, true)
	VanasKoS_WarnFrame.SetBackdropBorderColor = E.noop

	-- Main Frame
	VanasKoSFrame:StripTextures(true)
	VanasKoSFrame:CreateBackdrop("Transparent")
	VanasKoSFrame.backdrop:Point("TOPLEFT", 11, -12)
	VanasKoSFrame.backdrop:Point("BOTTOMRIGHT", -32, 76)

	S:SetUIPanelWindowInfo(VanasKoSFrame, "width")
	S:SetBackdropHitRect(VanasKoSFrame)

	S:HandleCloseButton(VanasKosFrameCloseButton, VanasKoSFrame.backdrop)

	S:HandleDropDownBox(VanasKoSFrameChooseListDropDown, 145)

	S:HandleCheckBox(VanasKoSListFrameCheckBox)

	VanasKoSListScrollFrame:StripTextures()
	S:HandleScrollBar(VanasKoSListScrollFrameScrollBar)

	for i = 1, 9 do
		_G["VanasKoSListFrameColButton" .. i]:StripTextures()
		_G["VanasKoSListFrameColButton" .. i]:StyleButton()
	end

	VanasKoSListFrameNoTogglePatch.Show = E.noop
	VanasKoSListFrameNoTogglePatch:Hide()

	S:HandleDropDownBox(VanasKoSPvPStatsCharacterDropDown, 119)
	S:HandleDropDownBox(VanasKoSPvPStatsTimeSpanDropDown, 120)

	S:HandleNextPrevButton(VanasKoSListFrameToggleLeftButton)
	S:HandleNextPrevButton(VanasKoSListFrameToggleRightButton)

	S:HandleEditBox(VanasKoSListFrameSearchBox)

	S:HandleButton(VanasKoSListFrameAddButton)
	S:HandleButton(VanasKoSListFrameRemoveButton)
	S:HandleButton(VanasKoSListFrameChangeButton)
	S:HandleButton(VanasKoSListFrameConfigurationButton)

	S:HandleTab(VanasKoSFrameTab1)
	S:HandleTab(VanasKoSFrameTab2)

	VanasKoSFrameChooseListDropDown:Point("TOPLEFT", 40, -31)

	VanasKoSListFrameCheckBox:Point("TOPLEFT", 200, -34)

	VanasKoSListFrameColButton1:Point("TOPLEFT", 26, -56)

	VanasKoSListScrollFrame:SetTemplate("Transparent")
	VanasKoSListScrollFrame:Size(304, 278)
	VanasKoSListScrollFrame:Point("TOPRIGHT", -61, -79)
	VanasKoSListScrollFrame.Hide = E.noop
	VanasKoSListScrollFrame:Show()

	VanasKoSListScrollFrameScrollBar:Point("TOPLEFT", VanasKoSListScrollFrame, "TOPRIGHT", 3, -19)
	VanasKoSListScrollFrameScrollBar:Point("BOTTOMLEFT", VanasKoSListScrollFrame, "BOTTOMRIGHT", 3, 19)

	VanasKoSListFrameListButton1:Point("TOPLEFT", 22, -82)

	VanasKoSPvPStatsCharacterDropDown:Point("RIGHT", VanasKoSListFrameToggleLeftButton, "LEFT", 5, -3)
	VanasKoSPvPStatsTimeSpanDropDown:Point("RIGHT", VanasKoSPvPStatsCharacterDropDown, "LEFT", 25, 0)

	VanasKoSListFrameToggleRightButton:Point("BOTTOMRIGHT", VanasKoSListFrame, "BOTTOMRIGHT", -40, 134)

	VanasKoSListFrameSearchBox:Size(210, 20)
	VanasKoSListFrameSearchBox:Point("BOTTOMLEFT", VanasKoSListFrame, "BOTTOMLEFT", 20, 110)

	VanasKoSListFrameChangeButton:Width(99)
	VanasKoSListFrameAddButton:Point("BOTTOMRIGHT", VanasKoSListFrame, "BOTTOMRIGHT", -40, 84)
	VanasKoSListFrameRemoveButton:Point("RIGHT", VanasKoSListFrameAddButton, "LEFT", -3, 0)
	VanasKoSListFrameChangeButton:Point("RIGHT", VanasKoSListFrameRemoveButton, "LEFT", -3, 0)
	VanasKoSListFrameConfigurationButton:Point("BOTTOM", VanasKoSListFrameAddButton, "TOP", 0, 3)

	VanasKoSFrameTab1:Point("BOTTOMLEFT", 11, 46)
	VanasKoSFrameTab2:Point("LEFT", VanasKoSFrameTab1, "RIGHT", -14, 0)
end)