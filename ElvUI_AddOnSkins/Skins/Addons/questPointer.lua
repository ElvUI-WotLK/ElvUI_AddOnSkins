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

if not AS:IsAddonLODorEnabled("QuestPointer") then return end

-- QuestPointer 5.3
-- https://www.curseforge.com/wow/addons/questpointer/files/438550

S:AddCallbackForAddon("QuestPointer", "QuestPointer", function()
	if not E.private.addOnSkins.QuestPointer then return end

	SkinFrame(QuestPointerTooltip, "StripTextures")
	QuestPointerTooltip:CreateBackdrop("Transparent")
end)
