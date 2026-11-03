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

if not AS:IsAddonLODorEnabled("EquipCompare") then return end

-- EquipCompare 2.17

S:AddCallbackForAddon("EquipCompare", "EquipCompare", function()
	if not E.private.addOnSkins.EquipCompare then return end

	local TT = E:GetModule("Tooltip")

	SkinFrame(TT, "HookScript", ComparisonTooltip1, "OnShow", "SetStyle")
	SkinFrame(TT, "HookScript", ComparisonTooltip2, "OnShow", "SetStyle")
end)
