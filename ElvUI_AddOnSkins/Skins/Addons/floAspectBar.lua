local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")
local AB = E:GetModule("ActionBars")

if not AS:IsAddonLODorEnabled("FloAspectBar") then return end

-- FloAspectBar 3.3.0.16
-- https://www.curseforge.com/wow/addons/flo-aspect-bar/files/399320

S:AddCallbackForAddon("FloAspectBar", "FloAspectBar", function()
	if not E.private.addOnSkins.FloAspectBar then return end

	FloAspectBar:SetTemplate("Default")

	for i = 1, 10 do
		AB:StyleButton(_G["FloAspectBarButton" .. i])
	end
end)