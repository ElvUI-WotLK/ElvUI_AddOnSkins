local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

if not AS:IsAddonLODorEnabled("FlightMap") then return end

-- Flight Map 3.3.3 beta2
-- https://www.curseforge.com/wow/addons/flight-map/files/426246

S:AddCallbackForAddon("FlightMap", "FlightMap", function()
	if not E.private.addOnSkins.FlightMap then return end

	FlightMapTimesFrame:StripTextures()
	FlightMapTimesFrame:CreateBackdrop("Default")

	FlightMapTimesFrame:SetStatusBarTexture(E.media.glossTex)
	E:RegisterStatusBar(FlightMapTimesFrame)

	FlightMapTimesText:ClearAllPoints()
	FlightMapTimesText:SetPoint("CENTER", 0, 0)

	for optionID in pairs(FLIGHTMAP_OPTIONS) do
		S:HandleCheckBox(_G["InterfaceOptionsFlightMapPanelOption" .. optionID])
	end
end)