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

if not AS:IsAddonLODorEnabled("MoveAnything") then return end

local _G = _G
local unpack = unpack

-- MoveAnything 3.3.5-10
-- https://www.curseforge.com/wow/addons/move-anything/files/434496

S:AddCallbackForAddon("MoveAnything", "MoveAnything", function()
	if not E.private.addOnSkins.MoveAnything then return end

	local SPACING = 1 + (E.Spacing * 2)

	local moverOnShow = function(self)
		SkinFrame(_G[self:GetName() .. "Backdrop"], "SetBackdropBorderColor", unpack(E.media.rgbvaluecolor))
	end
	local moverOnEnter = function(self)
		SkinFrame(_G[self:GetName() .. "BackdropMovingFrameName"], "SetTextColor", 1, 1, 1)
	end
	local moverOnLeave = function(self)
		SkinFrame(_G[self:GetName() .. "BackdropMovingFrameName"], "SetTextColor", unpack(E.media.rgbvaluecolor))
	end

	for i = 1, 20 do
		SkinFrame(_G["MAMover" .. i .. "Backdrop"], "SetTemplate", "Transparent")
		SkinFrame(_G["MAMover" .. i], "HookScript", "OnShow", moverOnShow)
		SkinFrame(_G["MAMover" .. i], "SetScript", "OnEnter", moverOnEnter)
		SkinFrame(_G["MAMover" .. i], "SetScript", "OnLeave", moverOnLeave)
	end

	SkinFrame(MAOptions, "StripTextures")
	SkinFrame(MAOptions, "SetTemplate", "Transparent")
	SkinFrame(MAOptions, "Size", 420, 500 + (16 * SPACING))

	SkinControl("HandleCheckBox", MAOptionsCharacterSpecific)
	SkinControl("HandleCheckBox", MAOptionsToggleTooltips)
	SkinControl("HandleCheckBox", MAOptionsToggleModifiedFramesOnly)
	SkinControl("HandleCheckBox", MAOptionsToggleCategories)

	SkinControl("HandleButton", MAOptionsResetAll)
	SkinControl("HandleButton", MAOptionsClose)
	SkinControl("HandleButton", MAOptionsSync)

	for i = 1, 17 do
		SkinFrame(_G["MAMove" .. i .. "Backdrop"], "SetTemplate", "Default")
		SkinControl("HandleCheckBox", _G["MAMove" .. i .. "Move"])
		SkinControl("HandleCheckBox", _G["MAMove" .. i .. "Hide"])
		SkinControl("HandleButton", _G["MAMove" .. i .. "Reset"])

		if i ~= 1 and _G["MAMove" .. i] and _G["MAMove" .. (i - 1)] then
			SkinFrame(_G["MAMove" .. i], "SetPoint", "TOPLEFT", "MAMove" .. (i - 1), "BOTTOMLEFT", 0, -SPACING)
		end
	end

	SkinFrame(MAScrollFrame, "Size", 380, 442 + (16 * SPACING))
	SkinControl("HandleScrollBar", MAScrollFrameScrollBar)
	SkinFrame(MAScrollBorder, "StripTextures")

	SkinFrame(MANudger, "SetTemplate", "Transparent")
	SkinControl("HandleButton", MANudger_NudgeUp)
	SkinFrame(MANudger_NudgeUp, "Point", "CENTER", 0, 24 + SPACING)
	SkinControl("HandleButton", MANudger_CenterMe)
	SkinFrame(MANudger_CenterMe, "Point", "TOP", MANudger_NudgeUp, "BOTTOM", 0, -SPACING)
	SkinControl("HandleButton", MANudger_NudgeDown)
	SkinFrame(MANudger_NudgeDown, "Point", "TOP", MANudger_CenterMe, "BOTTOM", 0, -SPACING)
	SkinControl("HandleButton", MANudger_NudgeLeft)
	SkinFrame(MANudger_NudgeLeft, "Point", "RIGHT", MANudger_CenterMe, "LEFT", -SPACING, 0)
	SkinControl("HandleButton", MANudger_NudgeRight)
	SkinFrame(MANudger_NudgeRight, "Point", "LEFT", MANudger_CenterMe, "RIGHT", SPACING, 0)
	SkinControl("HandleButton", MANudger_CenterH)
	SkinControl("HandleButton", MANudger_CenterV)
	SkinControl("HandleButton", MANudger_Detach)
	SkinControl("HandleButton", MANudger_Hide)
	SkinControl("HandleButton", MANudger_MoverPlus)
	SkinControl("HandleButton", MANudger_MoverMinus)

	SkinControl("HandleButton", GameMenuButtonMoveAnything)
end)
