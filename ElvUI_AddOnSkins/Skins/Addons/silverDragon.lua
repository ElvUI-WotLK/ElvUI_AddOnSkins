local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")

-- SilverDragon 2.3.4-6
-- https://www.curseforge.com/wow/addons/silver-dragon/files/455169

local function LoadSkin()
	if not E.private.addOnSkins.SilverDragon then return end

	local SilverDragon = LibStub("AceAddon-3.0"):GetAddon("SilverDragon")
	if not SilverDragon then return end

	local ClickTarget = SilverDragon:GetModule("ClickTarget")
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
end

S:AddCallbackForAddon("SilverDragon", "SilverDragon", LoadSkin)