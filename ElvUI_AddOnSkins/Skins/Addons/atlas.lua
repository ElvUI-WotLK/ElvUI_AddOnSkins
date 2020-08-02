local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

if not AS:IsAddonLODorEnabled("Atlas") then return end

-- Atlas 1.18.1

S:AddCallbackForAddon("Atlas", "Atlas", function()
	if not E.private.addOnSkins.Atlas then return end

	AtlasFrame:StripTextures()
	AtlasFrame:SetTemplate("Transparent")
	AtlasFrame:SetClampRectInsets(0, 0, 0, 0)

	S:HandleCloseButton(AtlasFrameCloseButton, AtlasFrame)

	AtlasFrameLockButton:Point("RIGHT", AtlasFrameCloseButton, "LEFT", 12, -1)
	AtlasFrameLockButton:SetHitRectInsets(6, 6, 6, 6)

	AtlasLockNorm:SetInside(AtlasFrameLockButton, 10, 10)
	AtlasLockPush:SetInside(AtlasFrameLockButton, 10, 10)
	AtlasLockNorm:SetTexCoord(.36, .65, .32, .73)
	AtlasLockPush:SetTexCoord(.36, .60, .38, .76)

	AtlasMap:SetDrawLayer("ARTWORK")
	AtlasMap:CreateBackdrop()

	hooksecurefunc("Atlas_UpdateLock", function()
		AtlasLockNorm:SetDesaturated(true)
		AtlasLockPush:SetDesaturated(true)
	end)
	Atlas_UpdateLock()

	S:HandleDropDownBox(AtlasFrameDropDownType)
	S:HandleDropDownBox(AtlasFrameDropDown)

	S:HandleEditBox(AtlasSearchEditBox)
	AtlasSearchEditBox:Height(22)

	S:HandleButton(AtlasSwitchButton)
	S:HandleButton(AtlasSearchButton)
	S:HandleButton(AtlasSearchClearButton)
	S:HandleButton(AtlasFrameOptionsButton)

	S:HandleScrollBar(AtlasScrollBarScrollBar)

	AtlasFrameDropDownType:Point("TOPLEFT", 24, -40)
	AtlasFrameDropDown:Point("LEFT", AtlasFrameDropDownType, "RIGHT", 2, 0)

	AtlasFrameOptionsButton:Point("TOPRIGHT", -14, -43)

	AtlasMap:Point("TOPLEFT", 15, -74)
	AtlasMap.ClearAllPoints = E.noop
	AtlasMap.SetPoint = E.noop

	AtlasSwitchButton:Height(24)
	AtlasSearchButton:Height(24)
	AtlasSearchClearButton:Size(62, 24)

	AtlasSearchEditBox:Point("BOTTOMRIGHT", -152, 15)
	AtlasSwitchButton:Point("RIGHT", AtlasSearchEditBox, "LEFT", -4, 0)
	AtlasSearchButton:Point("LEFT", AtlasSearchEditBox, "RIGHT", 4, 0)
	AtlasSearchClearButton:Point("LEFT", AtlasSearchButton, "RIGHT", 3, 0)

	AtlasScrollBarScrollBar:Point("TOPLEFT", AtlasScrollBar, "TOPRIGHT", 8, -16)
	AtlasScrollBarScrollBar:Point("BOTTOMLEFT", AtlasScrollBar, "BOTTOMRIGHT", 8, 16)

	-- options
	S:HandleCheckBox(AtlasOptionsFrameToggleButton)
	S:HandleCheckBox(AtlasOptionsFrameAutoSelect)
	S:HandleCheckBox(AtlasOptionsFrameRightClick)
	S:HandleCheckBox(AtlasOptionsFrameAcronyms)
	S:HandleCheckBox(AtlasOptionsFrameClamped)
	S:HandleCheckBox(AtlasOptionsFrameCtrl)

	S:HandleSliderFrame(AtlasOptionsFrameSliderButtonPos)
	S:HandleSliderFrame(AtlasOptionsFrameSliderButtonRad)
	S:HandleSliderFrame(AtlasOptionsFrameSliderAlpha)
	S:HandleSliderFrame(AtlasOptionsFrameSliderScale)

	S:HandleDropDownBox(AtlasOptionsFrameDropDownCats)

	S:HandleButton(AtlasOptionsFrameResetPosition)
end)