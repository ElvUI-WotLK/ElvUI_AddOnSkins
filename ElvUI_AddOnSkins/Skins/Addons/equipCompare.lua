local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

if not AS:IsAddonLODorEnabled("EquipCompare") then return end

-- EquipCompare 2.17

S:AddCallbackForAddon("EquipCompare", "EquipCompare", function()
	if not E.private.addOnSkins.EquipCompare then return end

	local TT = E:GetModule("Tooltip")

	TT:HookScript(ComparisonTooltip1, "OnShow", "SetStyle")
	TT:HookScript(ComparisonTooltip2, "OnShow", "SetStyle")
end)