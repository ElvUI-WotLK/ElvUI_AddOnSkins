local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

if not AS:IsAddonLODorEnabled("TinyPad") then return end

local unpack = unpack

-- TinyPad 1.6.2

S:AddCallbackForAddon("TinyPad", "TinyPad", function()
	if not E.private.addOnSkins.TinyPad then return end

	TinyPadFrame:StripTextures()
	TinyPadFrame:SetTemplate("Transparent")

	TinyPadEditFrame:SetBackdrop(nil)
	TinyPadEditFrame:CreateBackdrop("Default")
	TinyPadEditFrame.backdrop:Point("TOPLEFT", 0, -8)
	TinyPadEditFrame.backdrop:Point("BOTTOMRIGHT", 0, 4)

	TinyPadSearchFrame:SetTemplate("Transparent")
	TinyPadSearchFrame:Point("BOTTOMRIGHT", TinyPadFrame, "TOPRIGHT", 0, -1)

	TinyPadEditScrollFrame:StripTextures()
	S:HandleScrollBar(TinyPadEditScrollFrameScrollBar)
	TinyPadEditScrollFrameScrollBar:Point("TOPLEFT", TinyPadEditScrollFrame, "TOPRIGHT", 6, -17)
	TinyPadEditScrollFrameScrollBar:Point("BOTTOMLEFT", TinyPadEditScrollFrame, "BOTTOMRIGHT", 6, 17)

	select(8, TinyPadSearchEditBox:GetRegions()):Hide()
	S:HandleEditBox(TinyPadSearchEditBox)

	hooksecurefunc(TinyPad, "UpdateLock", function()
		local r, g, b = unpack(E.media.bordercolor)
		TinyPadFrame:SetBackdropBorderColor(r, g, b, 1)
		TinyPadSearchFrame:SetBackdropBorderColor(r, g, b, 1)
	end)
end)