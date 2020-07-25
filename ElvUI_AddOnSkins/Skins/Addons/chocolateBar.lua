local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

if not AS:IsAddonLODorEnabled("ChocolateBar") then return end

-- ChocolateBar r109
-- https://www.curseforge.com/wow/addons/chocolatebar/files/445816

S:AddCallbackForAddon("ChocolateBar", "ChocolateBar", function()
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
end)