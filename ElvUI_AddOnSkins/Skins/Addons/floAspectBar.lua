local E, L, V, P, G = unpack(ElvUI)
local AB = E:GetModule("ActionBars")
local S = E:GetModule("Skins")

-- FloAspectBar 3.3.0.16
-- https://www.curseforge.com/wow/addons/flo-aspect-bar/files/399320

local function LoadSkin()
	if not E.private.addOnSkins.FloAspectBar then return end

	FloAspectBar:SetTemplate("Default")

	for i = 1, 10 do
		AB:StyleButton(_G["FloAspectBarButton" .. i])
	end
end

S:AddCallbackForAddon("FloAspectBar", "FloAspectBar", LoadSkin)