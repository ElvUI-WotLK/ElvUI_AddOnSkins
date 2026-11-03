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

if not AS:IsAddonLODorEnabled("TinyPad") then return end

local unpack = unpack

-- TinyPad 1.6.2

S:AddCallbackForAddon("TinyPad", "TinyPad", function()
	if not E.private.addOnSkins.TinyPad then return end

	SkinFrame(TinyPadFrame, "StripTextures")
	SkinFrame(TinyPadFrame, "SetTemplate", "Transparent")

	SkinFrame(TinyPadEditFrame, "SetBackdrop", nil)
	TinyPadEditFrame:CreateBackdrop("Default")
	TinyPadEditFrame.backdrop:Point("TOPLEFT", 0, -8)
	TinyPadEditFrame.backdrop:Point("BOTTOMRIGHT", 0, 4)

	SkinFrame(TinyPadSearchFrame, "SetTemplate", "Transparent")
	SkinFrame(TinyPadSearchFrame, "Point", "BOTTOMRIGHT", TinyPadFrame, "TOPRIGHT", 0, -1)

	SkinFrame(TinyPadEditScrollFrame, "StripTextures")
	SkinControl("HandleScrollBar", TinyPadEditScrollFrameScrollBar)
	SkinFrame(TinyPadEditScrollFrameScrollBar, "Point", "TOPLEFT", TinyPadEditScrollFrame, "TOPRIGHT", 6, -17)
	SkinFrame(TinyPadEditScrollFrameScrollBar, "Point", "BOTTOMLEFT", TinyPadEditScrollFrame, "BOTTOMRIGHT", 6, 17)

	select(8, TinyPadSearchEditBox:GetRegions()):Hide()
	SkinControl("HandleEditBox", TinyPadSearchEditBox)

	hooksecurefunc(TinyPad, "UpdateLock", function()
		local r, g, b = unpack(E.media.bordercolor)
		SkinFrame(TinyPadFrame, "SetBackdropBorderColor", r, g, b, 1)
		SkinFrame(TinyPadSearchFrame, "SetBackdropBorderColor", r, g, b, 1)
	end)
end)
