local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")

local unpack, select = unpack, select

local hooksecurefunc = hooksecurefunc

-- LootWonAlert 1.3
-- https://gitlab.com/Artur91425/LootWonAlert

S:AddCallbackForAddon("LootWonAlert", "LootWonAlert", function()
	if not E.private.addOnSkins.LootWonAlert then return end

	hooksecurefunc("LootWonAlertFrame_SetUp", function(self, itemLink)
		local frame = self

		frame.Background:StripTextures()
		frame.lootItem.IconBorder:StripTextures()

		frame.lootItem:SetTemplate("Transparent")

		frame.Background:CreateBackdrop("Transparent")
		frame.lootItem.Icon:CreateBackdrop("Transparent")

		frame.Background:SetSize(258, 76)
		frame.glow:SetSize(296, 116)
		frame.shine:SetSize(158, 66)

		frame.lootItem:SetPoint("TOPLEFT", 22, -22)
		frame.shine:SetPoint("TOPLEFT", -10, -12)

		if itemLink then
			local quality = select(3, GetItemInfo(itemLink))
			if quality then
				local r, g, b = GetItemQualityColor(quality)
				frame.Background.backdrop:SetBackdropBorderColor(r, g, b)
				frame.lootItem.Icon.backdrop:SetBackdropBorderColor(r, g, b)
			else
				frame.Background.backdrop:SetBackdropBorderColor(unpack(E.media.bordercolor))
				frame.lootItem.Icon.backdrop:SetBackdropBorderColor(unpack(E.media.bordercolor))
			end
		end
	end)
end)