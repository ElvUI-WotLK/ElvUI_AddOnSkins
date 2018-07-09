local E, L, V, P, G, _ = unpack(ElvUI)
local AS = E:GetModule("AddOnSkins")
local S = E:GetModule("Skins")

local function LoadSkin()
	for i = 1, 20 do 	
		local f = _G['ChocolateBar'..i]
		if f then
			AS:SkinFrame(f, 'Default')
		end
	end
	if RaidUtility_ShowButton then
		RaidUtility_ShowButton:SetFrameStrata('TOOLTIP')
	end
end

S:AddCallbackForAddon("ChocolateBar", "ChocolateBar", LoadSkin)
