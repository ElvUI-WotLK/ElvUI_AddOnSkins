local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")

local select = select
local unpack = unpack

local GetItemInfo = GetItemInfo
local GetItemQualityColor = GetItemQualityColor
local hooksecurefunc = hooksecurefunc

-- LootWonAlert 1.3
-- https://gitlab.com/Artur91425/LootWonAlert

S:AddCallbackForAddon("LootWonAlert", "LootWonAlert", function()
	if not E.private.addOnSkins.LootWonAlert then return end

	local function skinFrame(frame)
		if frame.isSkinned then return end

		frame:Size(300, 88)
		frame.Background:Hide()
		frame.lootItem.IconBorder:Hide()

		frame:CreateBackdrop("Transparent")
		frame.backdrop:Point("TOPLEFT", 0, -6)
		frame.backdrop:Point("BOTTOMRIGHT", 0, 6)

		S:SetBackdropHitRect(frame)

		frame.glow:Size(336, 116)

		frame.shine:Size(158, 66)
		frame.shine:Point("TOPLEFT", -10, -12)

		frame.lootItem:SetTemplate("Transparent")
		frame.lootItem:Point("TOPLEFT", 12, -18)

		frame.lootItem.Icon:CreateBackdrop("Transparent")

		frame.isSkinned = true
	end

	S:RawHook("LootWonAlertFrame_Create", function(self, ...)
		local frame = S.hooks.LootWonAlertFrame_Create(self, ...)
		skinFrame(frame)
		return frame
	end)

	hooksecurefunc("LootWonAlertFrame_SetUp", function(self, itemLink)
		if itemLink then
			local quality = select(3, GetItemInfo(itemLink))
			if quality then
				local r, g, b = GetItemQualityColor(quality)
				self:SetBackdropBorderColor(r, g, b)
				-- self.backdrop:SetBackdropBorderColor(r, g, b)
				self.lootItem.Icon.backdrop:SetBackdropBorderColor(r, g, b)
			else
				self:SetBackdropBorderColor(unpack(E.media.bordercolor))
				-- self.backdrop:SetBackdropBorderColor(r, g, b)
				self.lootItem.Icon.backdrop:SetBackdropBorderColor(unpack(E.media.bordercolor))
			end
		end
	end)

	do
		local i = 1
		local frame = _G["LootWonAlertFrame"..i]
		while frame do
			skinFrame(frame)
			i = i + 1
			frame = _G["LootWonAlertFrame"..i]
		end
	end
end)