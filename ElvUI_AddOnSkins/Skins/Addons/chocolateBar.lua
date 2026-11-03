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

if not AS:IsAddonLODorEnabled("ChocolateBar") then return end

-- ChocolateBar r109
-- https://www.curseforge.com/wow/addons/chocolatebar/files/445816

S:AddCallbackForAddon("ChocolateBar", "ChocolateBar", function()
	if not E.private.addOnSkins.ChocolateBar then return end

	local i = 1
	local frame = _G["ChocolateBar"..i]
	while frame do
		SkinFrame(frame, "SetTemplate", "Transparent")
		i = i + 1
		frame = _G["ChocolateBar"..i]
	end

	local ChocolateBar = LibStub("AceAddon-3.0"):GetAddon("ChocolateBar", true)
	if not ChocolateBar then return end

	hooksecurefunc(ChocolateBar.Bar, "New", function(self, name)
		SkinFrame(_G[name], "SetTemplate", "Transparent")
	end)

	if RaidUtility_ShowButton then
		SkinFrame(RaidUtility_ShowButton, "Point", "TOP", -400, -19)
	end
end)
