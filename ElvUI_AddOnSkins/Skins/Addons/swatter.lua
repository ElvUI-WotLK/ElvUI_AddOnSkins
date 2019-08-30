local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")

-- Swatter 5.8.4723

local function LoadSkin()
	if not E.private.addOnSkins.Swatter then return end
	if not Swatter.Error then return end

	Swatter.Error:SetTemplate("Transparent")

	Swatter.Error.Scroll:CreateBackdrop("Transparent")
	S:HandleScrollBar(SwatterErrorInputScrollScrollBar)

	S:HandleButton(Swatter.Error.Prev)
	S:HandleButton(Swatter.Error.Next)
	S:HandleButton(Swatter.Error.Done)
end

S:AddCallbackForAddon("!Swatter", "!Swatter", LoadSkin)