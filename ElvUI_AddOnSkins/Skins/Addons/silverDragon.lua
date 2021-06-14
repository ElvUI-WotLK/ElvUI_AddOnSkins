local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

if not AS:IsAddonLODorEnabled("SilverDragon") then return end

-- SilverDragon 2.3.4-6
-- https://www.curseforge.com/wow/addons/silver-dragon/files/455169

S:AddCallbackForAddon("SilverDragon", "SilverDragon", function()
	if not E.private.addOnSkins.SilverDragon then return end

	local SilverDragon = LibStub("AceAddon-3.0"):GetAddon("SilverDragon", true)
	if not SilverDragon then return end

	local ClickTarget = SilverDragon:GetModule("ClickTarget", true)
	if ClickTarget then
		ClickTarget.popup:SetParent(UIParent)

		ClickTarget.popup:SetNormalTexture(nil)
		ClickTarget.popup:SetTemplate("Transparent")

		ClickTarget.popup.close:ClearAllPoints()
		S:HandleCloseButton(ClickTarget.popup.close, ClickTarget.popup)

		ClickTarget.popup:HookScript("OnEnter", S.SetModifiedBackdrop)
		ClickTarget.popup:HookScript("OnLeave", S.SetOriginalBackdrop)

		ClickTarget.popup.details:SetTextColor(1, 1, 1)
		ClickTarget.popup.subtitle:SetTextColor(0.5, 0.5, 0.5)
	end

	AS:SkinLibrary("LibQTip-1.0")
end)