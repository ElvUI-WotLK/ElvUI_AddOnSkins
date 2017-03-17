local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")

-- TinyPad 1.6.2

local function LoadSkin()
	if(not E.private.addOnSkins.TinyPad) then return end

--[[
	local buttons = {
		TinyPadNew,
		TinyPadDelete,
		TinyPadRun,
		TinyPadUndo,

		TinyPadStart,
		TinyPadLeft,
		TinyPadRight,
		TinyPadEnd,

		TinyPadSearch,
		TinyPadClose,

		TinyPadLock,
		TinyPadFont,
		TinyPadSearchNext
	}
--]]

	TinyPadFrame:StripTextures()
	TinyPadFrame:SetTemplate("Transparent")

	TinyPadEditFrame:SetBackdrop(nil)
	TinyPadEditFrame:CreateBackdrop("Default")
	TinyPadEditFrame.backdrop:Point("TOPLEFT", 0, -8)
	TinyPadEditFrame.backdrop:Point("BOTTOMRIGHT", 0, 4)

	TinyPadSearchFrame:SetTemplate("Default")

	TinyPadEditScrollFrame:StripTextures()
	S:HandleScrollBar(TinyPadEditScrollFrameScrollBar)

	S:HandleEditBox(TinyPadSearchEditBox)
end

S:AddCallbackForAddon("TinyPad", "TinyPad", LoadSkin)