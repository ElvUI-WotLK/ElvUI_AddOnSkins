local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

if not AS:IsAddonLODorEnabled("ChocolateBar") then return end

-- ChocolateBar r109
-- https://www.curseforge.com/wow/addons/chocolatebar/files/445816

S:AddCallbackForAddon("ChocolateBar", "ChocolateBar", function()
	if not E.private.addOnSkins.ChocolateBar then return end

	local i = 1
	local frame = _G["ChocolateBar"..i]
	while frame do
		frame:SetTemplate("Transparent")
		i = i + 1
		frame = _G["ChocolateBar"..i]
	end

	local ChocolateBar = LibStub("AceAddon-3.0"):GetAddon("ChocolateBar", true)
	if not ChocolateBar then return end

	hooksecurefunc(ChocolateBar.Bar, "New", function(self, name)
		_G[name]:SetTemplate("Transparent")
	end)

	if RaidUtility_ShowButton then
		RaidUtility_ShowButton:Point("TOP", -400, -19)
	end
end)