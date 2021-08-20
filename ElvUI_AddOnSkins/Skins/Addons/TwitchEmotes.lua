local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

-- Twitch Emotes
-- https://github.com/fxpw/TwitchEmotes


if not AS:IsAddonLODorEnabled("TwitchEmotes") then return end


S:AddCallbackForAddon("TwitchEmotes", "TwitchEmotes", function()
	if not E.private.addOnSkins.TwitchEmotes then return end
	L_DropDownList1:SetTemplate("Transparent")
	L_DropDownList2:SetTemplate("Transparent")
	L_DropDownList1MenuBackdrop:SetTemplate("Transparent")
	L_DropDownList2MenuBackdrop:SetTemplate("Transparent")

		

	

	end)