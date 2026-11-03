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

if not AS:IsAddonLODorEnabled("VanasKoS") then return end

-- Vanas KoS 4.25
-- https://www.curseforge.com/wow/addons/vanaskos/files/457856

S:AddCallbackForAddon("VanasKoS", "VanasKoS", function()
	if not E.private.addOnSkins.VanasKoS then return end

	SkinControl("HandleTab", FriendsFrameTab6)
	SkinFrame(FriendsFrameTab6, "ClearAllPoints")
	SkinFrame(FriendsFrameTab6, "Point", "TOPLEFT", FriendsFrameTab5, "TOPRIGHT", -15, 0)

	E:GetModule("Tooltip"):HookScript(VanasKoSListTooltip, "OnShow", "SetStyle")

	-- Warn Frame
	SkinFrame(VanasKoS_WarnFrame, "SetTemplate", "Transparent", nil, true)
	VanasKoS_WarnFrame.SetBackdropBorderColor = E.noop

	-- Main Frame
	SkinFrame(VanasKoSFrame, "StripTextures", true)
	VanasKoSFrame:CreateBackdrop("Transparent")
	VanasKoSFrame.backdrop:Point("TOPLEFT", 11, -12)
	VanasKoSFrame.backdrop:Point("BOTTOMRIGHT", -32, 76)

	S:SetUIPanelWindowInfo(VanasKoSFrame, "width")
	S:SetBackdropHitRect(VanasKoSFrame)

	SkinControl("HandleCloseButton", VanasKosFrameCloseButton, VanasKoSFrame.backdrop)

	SkinControl("HandleDropDownBox", VanasKoSFrameChooseListDropDown, 145)

	SkinControl("HandleCheckBox", VanasKoSListFrameCheckBox)

	SkinFrame(VanasKoSListScrollFrame, "StripTextures")
	SkinControl("HandleScrollBar", VanasKoSListScrollFrameScrollBar)

	for i = 1, 9 do
		SkinFrame(_G["VanasKoSListFrameColButton" .. i], "StripTextures")
		SkinFrame(_G["VanasKoSListFrameColButton" .. i], "StyleButton")
	end

	VanasKoSListFrameNoTogglePatch.Show = E.noop
	SkinFrame(VanasKoSListFrameNoTogglePatch, "Hide")

	SkinControl("HandleDropDownBox", VanasKoSPvPStatsCharacterDropDown, 119)
	SkinControl("HandleDropDownBox", VanasKoSPvPStatsTimeSpanDropDown, 120)

	SkinControl("HandleNextPrevButton", VanasKoSListFrameToggleLeftButton)
	SkinControl("HandleNextPrevButton", VanasKoSListFrameToggleRightButton)

	SkinControl("HandleEditBox", VanasKoSListFrameSearchBox)

	SkinControl("HandleButton", VanasKoSListFrameAddButton)
	SkinControl("HandleButton", VanasKoSListFrameRemoveButton)
	SkinControl("HandleButton", VanasKoSListFrameChangeButton)
	SkinControl("HandleButton", VanasKoSListFrameConfigurationButton)

	SkinControl("HandleTab", VanasKoSFrameTab1)
	SkinControl("HandleTab", VanasKoSFrameTab2)

	SkinFrame(VanasKoSFrameChooseListDropDown, "Point", "TOPLEFT", 40, -31)

	SkinFrame(VanasKoSListFrameCheckBox, "Point", "TOPLEFT", 200, -34)

	SkinFrame(VanasKoSListFrameColButton1, "Point", "TOPLEFT", 26, -56)

	SkinFrame(VanasKoSListScrollFrame, "SetTemplate", "Transparent")
	SkinFrame(VanasKoSListScrollFrame, "Size", 304, 278)
	SkinFrame(VanasKoSListScrollFrame, "Point", "TOPRIGHT", -61, -79)
	VanasKoSListScrollFrame.Hide = E.noop
	SkinFrame(VanasKoSListScrollFrame, "Show")

	SkinFrame(VanasKoSListScrollFrameScrollBar, "Point", "TOPLEFT", VanasKoSListScrollFrame, "TOPRIGHT", 3, -19)
	SkinFrame(VanasKoSListScrollFrameScrollBar, "Point", "BOTTOMLEFT", VanasKoSListScrollFrame, "BOTTOMRIGHT", 3, 19)

	SkinFrame(VanasKoSListFrameListButton1, "Point", "TOPLEFT", 22, -82)

	SkinFrame(VanasKoSPvPStatsCharacterDropDown, "Point", "RIGHT", VanasKoSListFrameToggleLeftButton, "LEFT", 5, -3)
	SkinFrame(VanasKoSPvPStatsTimeSpanDropDown, "Point", "RIGHT", VanasKoSPvPStatsCharacterDropDown, "LEFT", 25, 0)

	SkinFrame(VanasKoSListFrameToggleRightButton, "Point", "BOTTOMRIGHT", VanasKoSListFrame, "BOTTOMRIGHT", -40, 134)

	SkinFrame(VanasKoSListFrameSearchBox, "Size", 210, 20)
	SkinFrame(VanasKoSListFrameSearchBox, "Point", "BOTTOMLEFT", VanasKoSListFrame, "BOTTOMLEFT", 20, 110)

	SkinFrame(VanasKoSListFrameChangeButton, "Width", 99)
	SkinFrame(VanasKoSListFrameAddButton, "Point", "BOTTOMRIGHT", VanasKoSListFrame, "BOTTOMRIGHT", -40, 84)
	SkinFrame(VanasKoSListFrameRemoveButton, "Point", "RIGHT", VanasKoSListFrameAddButton, "LEFT", -3, 0)
	SkinFrame(VanasKoSListFrameChangeButton, "Point", "RIGHT", VanasKoSListFrameRemoveButton, "LEFT", -3, 0)
	SkinFrame(VanasKoSListFrameConfigurationButton, "Point", "BOTTOM", VanasKoSListFrameAddButton, "TOP", 0, 3)

	SkinFrame(VanasKoSFrameTab1, "Point", "BOTTOMLEFT", 11, 46)
	SkinFrame(VanasKoSFrameTab2, "Point", "LEFT", VanasKoSFrameTab1, "RIGHT", -14, 0)
end)
