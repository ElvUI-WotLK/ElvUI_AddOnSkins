local E, L, V, P, G = unpack(ElvUI)
local AB = E:GetModule("ActionBars")
local S = E:GetModule("Skins")

local function LoadSkin()
	if not E.private.addOnSkins.FloAspectBar then return end

	FloAspectBar:SetTemplate("Default")

	for i = 1, 10 do
		AB:StyleButton(_G["FloAspectBarButton" .. i])
	end
end

S:AddCallbackForAddon("FloAspectBar", "FloAspectBar", LoadSkin)