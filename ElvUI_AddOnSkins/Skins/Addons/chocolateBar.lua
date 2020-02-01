local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")

-- ChocolateBar r109
-- https://www.curseforge.com/wow/addons/chocolatebar/files/445816

local function LoadSkin()
	if not E.private.addOnSkins.ChocolateBar then return end

	local frame
	for i = 1, 20 do
		frame = _G["ChocolateBar"..i]
		if frame then
			frame:SetTemplate("Transparent")
		end
	end

	if RaidUtility_ShowButton then
		RaidUtility_ShowButton:SetFrameStrata("TOOLTIP")
	end
end

S:AddCallbackForAddon("ChocolateBar", "ChocolateBar", LoadSkin)
