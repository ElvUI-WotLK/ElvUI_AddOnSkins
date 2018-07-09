local E, L, V, P, G, _ = unpack(ElvUI)
local AS = E:GetModule("AddOnSkins")
local S = E:GetModule("Skins")

-- Repository: 
-- Version: 

local _G = _G

local function LoadSkin()
	if(not E.private.addOnSkins.TrinketMenu) then return end
	AS:UpdateMedia()

	--TrinketMenu_MainFrame:StripTextures()
	--TrinketMenu_MainFrame:SetTemplate("Transparent")

	AS:SkinFrame(TrinketMenu_MainFrame)
	AS:SkinIconButton(TrinketMenu_Trinket0)
	AS:SkinIconButton(TrinketMenu_Trinket1)

	AS:SkinFrame(TrinketMenu_MenuFrame)

	for i = 1, 30 do
		AS:SkinIconButton(getglobal("TrinketMenu_Menu"..i))
	end
end

S:AddCallbackForAddon("TrinketMenu", "TrinketMenu", LoadSkin)