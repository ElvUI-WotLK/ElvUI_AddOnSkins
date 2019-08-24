local E, L, V, P, G, _ = unpack(ElvUI)
local AS = E:GetModule("AddOnSkins")
local S = E:GetModule("Skins")

local _G = _G

-- TrinketMenu 3.81
-- https://www.curseforge.com/wow/addons/trinket-menu/files/305868

local function LoadSkin()
	if not E.private.addOnSkins.TrinketMenu then return end

	TrinketMenu_MainFrame:SetTemplate("Transparent")
	S:HandleItemButton(TrinketMenu_Trinket0)
	S:HandleItemButton(TrinketMenu_Trinket1)

	TrinketMenu_MenuFrame:SetTemplate("Transparent")

	for i = 1, 30 do
		S:HandleItemButton(_G["TrinketMenu_Menu"..i])
	end
end

S:AddCallbackForAddon("TrinketMenu", "TrinketMenu", LoadSkin)