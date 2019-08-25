local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")

-- EquipCompare 2.17
-- https://www.wowinterface.com/downloads/getfile.php?id=4392&aid=46750

local function LoadSkin()
	if not E.private.addOnSkins.EquipCompare then return end

	local TT = E:GetModule("Tooltip")

	TT:HookScript(ComparisonTooltip1, "OnShow", "SetStyle")
	TT:HookScript(ComparisonTooltip2, "OnShow", "SetStyle")
end

S:AddCallbackForAddon("EquipCompare", "EquipCompare", LoadSkin)