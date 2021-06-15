local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

if not AS:IsAddonLODorEnabled("!Swatter") then return end

-- Swatter 5.8.4723

S:AddCallbackForAddon("!Swatter", "!Swatter", function()
	if not E.private.addOnSkins.Swatter then return end
	if not (Swatter and Swatter.Error) then return end

	Swatter.Error:SetTemplate("Transparent")

	Swatter.Error.Scroll:CreateBackdrop("Transparent")
	Swatter.Error.Scroll:Point("TOPLEFT", Swatter.Error, "TOPLEFT", 9, -18)
	Swatter.Error.Scroll:Point("BOTTOM", Swatter.Error.Done, "TOP", 0, 8)

	Swatter.Error.Box:Width(461)

	S:HandleScrollBar(SwatterErrorInputScrollScrollBar)
	SwatterErrorInputScrollScrollBar:Point("TOPLEFT", SwatterErrorInputScroll, "TOPRIGHT", 4, -18)
	SwatterErrorInputScrollScrollBar:Point("BOTTOMLEFT", SwatterErrorInputScroll, "BOTTOMRIGHT", 4, 18)

	S:HandleButton(Swatter.Error.Prev)
	S:HandleButton(Swatter.Error.Next)
	S:HandleButton(Swatter.Error.Done)

	Swatter.Error.Done:Point("BOTTOMRIGHT", Swatter.Error, "BOTTOMRIGHT", -8, 8)
end)