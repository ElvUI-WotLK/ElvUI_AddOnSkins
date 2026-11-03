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

if not AS:IsAddonLODorEnabled("Atlas") then return end

-- Atlas 1.18.1

S:AddCallbackForAddon("Atlas", "Atlas", function()
	if not E.private.addOnSkins.Atlas then return end

	SkinFrame(AtlasFrame, "StripTextures")
	SkinFrame(AtlasFrame, "SetTemplate", "Transparent")
	AtlasFrame:SetClampRectInsets(0, 0, 0, 0)

	SkinControl("HandleCloseButton", AtlasFrameCloseButton, AtlasFrame)

	SkinFrame(AtlasFrameLockButton, "Point", "RIGHT", AtlasFrameCloseButton, "LEFT", 12, -1)
	AtlasFrameLockButton:SetHitRectInsets(6, 6, 6, 6)

	SkinFrame(AtlasLockNorm, "SetInside", AtlasFrameLockButton, 10, 10)
	SkinFrame(AtlasLockPush, "SetInside", AtlasFrameLockButton, 10, 10)
	SkinFrame(AtlasLockNorm, "SetTexCoord", .36, .65, .32, .73)
	SkinFrame(AtlasLockPush, "SetTexCoord", .36, .60, .38, .76)

	AtlasMap:SetDrawLayer("ARTWORK")
	AtlasMap:CreateBackdrop()

	hooksecurefunc("Atlas_UpdateLock", function()
		AtlasLockNorm:SetDesaturated(true)
		AtlasLockPush:SetDesaturated(true)
	end)
	Atlas_UpdateLock()

	SkinControl("HandleDropDownBox", AtlasFrameDropDownType)
	SkinControl("HandleDropDownBox", AtlasFrameDropDown)

	SkinControl("HandleEditBox", AtlasSearchEditBox)
	SkinFrame(AtlasSearchEditBox, "Height", 22)

	SkinControl("HandleButton", AtlasSwitchButton)
	SkinControl("HandleButton", AtlasSearchButton)
	SkinControl("HandleButton", AtlasSearchClearButton)
	SkinControl("HandleButton", AtlasFrameOptionsButton)

	SkinControl("HandleScrollBar", AtlasScrollBarScrollBar)

	SkinFrame(AtlasFrameDropDownType, "Point", "TOPLEFT", 24, -40)
	SkinFrame(AtlasFrameDropDown, "Point", "LEFT", AtlasFrameDropDownType, "RIGHT", 2, 0)

	SkinFrame(AtlasFrameOptionsButton, "Point", "TOPRIGHT", -14, -43)

	SkinFrame(AtlasMap, "Point", "TOPLEFT", 15, -74)
	AtlasMap.ClearAllPoints = E.noop
	AtlasMap.SetPoint = E.noop

	SkinFrame(AtlasSwitchButton, "Height", 24)
	SkinFrame(AtlasSearchButton, "Height", 24)
	SkinFrame(AtlasSearchClearButton, "Size", 62, 24)

	SkinFrame(AtlasSearchEditBox, "Point", "BOTTOMRIGHT", -152, 15)
	SkinFrame(AtlasSwitchButton, "Point", "RIGHT", AtlasSearchEditBox, "LEFT", -4, 0)
	SkinFrame(AtlasSearchButton, "Point", "LEFT", AtlasSearchEditBox, "RIGHT", 4, 0)
	SkinFrame(AtlasSearchClearButton, "Point", "LEFT", AtlasSearchButton, "RIGHT", 3, 0)

	SkinFrame(AtlasScrollBarScrollBar, "Point", "TOPLEFT", AtlasScrollBar, "TOPRIGHT", 8, -16)
	SkinFrame(AtlasScrollBarScrollBar, "Point", "BOTTOMLEFT", AtlasScrollBar, "BOTTOMRIGHT", 8, 16)

	-- options
	SkinControl("HandleCheckBox", AtlasOptionsFrameToggleButton)
	SkinControl("HandleCheckBox", AtlasOptionsFrameAutoSelect)
	SkinControl("HandleCheckBox", AtlasOptionsFrameRightClick)
	SkinControl("HandleCheckBox", AtlasOptionsFrameAcronyms)
	SkinControl("HandleCheckBox", AtlasOptionsFrameClamped)
	SkinControl("HandleCheckBox", AtlasOptionsFrameCtrl)

	SkinControl("HandleSliderFrame", AtlasOptionsFrameSliderButtonPos)
	SkinControl("HandleSliderFrame", AtlasOptionsFrameSliderButtonRad)
	SkinControl("HandleSliderFrame", AtlasOptionsFrameSliderAlpha)
	SkinControl("HandleSliderFrame", AtlasOptionsFrameSliderScale)

	SkinControl("HandleDropDownBox", AtlasOptionsFrameDropDownCats)

	SkinControl("HandleButton", AtlasOptionsFrameResetPosition)
end)
