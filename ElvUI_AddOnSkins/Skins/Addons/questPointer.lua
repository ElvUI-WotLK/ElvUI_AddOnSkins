local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

if not AS:IsAddonLODorEnabled("QuestPointer") then return end

-- QuestPointer 5.3
-- https://www.curseforge.com/wow/addons/questpointer/files/438550

S:AddCallbackForAddon("QuestPointer", "QuestPointer", function()
	if not E.private.addOnSkins.QuestPointer then return end

	QuestPointerTooltip:StripTextures()
	QuestPointerTooltip:CreateBackdrop("Transparent")
end)