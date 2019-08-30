local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")

-- Informant 5.8.4723
-- https://www.curseforge.com/wow/addons/auctioneer/files/427823

local function LoadSkin()
	if not E.private.addOnSkins.Informant then return end

	E:GetModule("AddOnSkins"):SkinLibrary("Configator")
end

S:AddCallbackForAddon("Informant", "Informant", LoadSkin)