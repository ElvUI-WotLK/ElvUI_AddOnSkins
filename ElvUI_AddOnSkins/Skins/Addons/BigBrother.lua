local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

-- BigBrother
--


if not AS:IsAddonLODorEnabled("BigBrother") then return end


S:AddCallbackForAddon("BigBrother", "BigBrother", function()
	if not E.private.addOnSkins.BigBrother then return end

	BigBrother_BuffWindow:CreateBackdrop("Transparent")
	BigBrother_BuffWindow:SetTemplate("Transparent")
	BigBrother_BuffWindow:StripTextures()
	BigBrother_BuffWindow:StripTextures()
	BigBrother_BuffWindow:SetTemplate("Transparent")
	print("bb zagr")


	end)