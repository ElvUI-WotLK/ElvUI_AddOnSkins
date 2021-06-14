local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

if not AS:IsAddonLODorEnabled("Informant") then return end

-- Informant 5.8.4723
-- https://www.curseforge.com/wow/addons/auctioneer/files/427823

S:AddCallbackForAddon("Informant", "Informant", function()
	if not E.private.addOnSkins.Informant then return end

	AS:SkinLibrary("Configator")
	AS:SkinLibrary("LibExtraTip-1")
end)