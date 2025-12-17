local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

if not AS:IsAddonLODorEnabled("AwesomeCVar") then return end

-- EPGP 5.5.19
-- https://www.curseforge.com/wow/addons/epgp-dkp-reloaded/files/442647

S:AddCallbackForAddon("AwesomeCVar", "AwesomeCVar", function()
	if not E.private.addOnSkins.AwesomeCVar then return end
	
	GameMenuButtonAwesomeCVar:StripTextures()
	S:HandleButton(GameMenuButtonAwesomeCVar)
	--[[
		тут надо писать много строк и скинить внутрянку всего аддона
		когда-нибудь я этим займусь... наверное.
	]]
end)