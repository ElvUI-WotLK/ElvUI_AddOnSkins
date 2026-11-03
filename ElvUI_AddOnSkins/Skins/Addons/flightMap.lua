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

if not AS:IsAddonLODorEnabled("FlightMap") then return end

-- Flight Map 3.3.3 beta2
-- https://www.curseforge.com/wow/addons/flight-map/files/426246

S:AddCallbackForAddon("FlightMap", "FlightMap", function()
	if not E.private.addOnSkins.FlightMap then return end

	SkinFrame(FlightMapTimesFrame, "StripTextures")
	FlightMapTimesFrame:CreateBackdrop("Default")

	FlightMapTimesFrame:SetStatusBarTexture(E.media.glossTex)
	E:RegisterStatusBar(FlightMapTimesFrame)

	SkinFrame(FlightMapTimesText, "ClearAllPoints")
	SkinFrame(FlightMapTimesText, "SetPoint", "CENTER", 0, 0)

	for optionID in pairs(FLIGHTMAP_OPTIONS) do
		SkinControl("HandleCheckBox", _G["InterfaceOptionsFlightMapPanelOption" .. optionID])
	end
end)
