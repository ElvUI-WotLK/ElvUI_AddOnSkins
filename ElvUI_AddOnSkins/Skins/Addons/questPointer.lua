local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")

-- QuestPointer 5.3
-- https://www.curseforge.com/wow/addons/questpointer/files/438550

local function LoadSkin()
	if not E.private.addOnSkins.QuestPointer then return end

	QuestPointerTooltip:StripTextures()
	QuestPointerTooltip:CreateBackdrop("Transparent")
end

S:AddCallbackForAddon("QuestPointer", "QuestPointer", LoadSkin)