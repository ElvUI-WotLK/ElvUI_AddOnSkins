local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

if not AS:IsAddonLODorEnabled("SexyCooldown") then return end

local unpack = unpack

-- SexyCooldown 0.6.18
-- https://www.wowace.com/projects/sexycooldown/files/424497

S:AddCallbackForAddon("SexyCooldown", "SexyCooldown", function()
	if not E.private.addOnSkins.SexyCooldown then return end

	local function SkinSexyCooldownIcon(_, icon)
		icon:SetTemplate("Default")
		icon.overlay:SetTemplate("Default")
		icon.overlay.tex:SetInside()
		icon.tex:SetInside()
		icon.overlay.tex:SetTexCoord(unpack(E.TexCoords))
		icon.tex:SetTexCoord(unpack(E.TexCoords))
	end

	local function SkinSexyCooldownBackdrop(bar)
		bar:SetTemplate("Transparent")
	end

	local function HookBar(bar)
		if bar.hooked then return end

		hooksecurefunc(bar, "UpdateSingleIconLook", SkinSexyCooldownIcon)
		hooksecurefunc(bar, "UpdateBarBackdrop", SkinSexyCooldownBackdrop)

		bar:UpdateBarLook()

		bar.hooked = true
	end

	for _, bar in ipairs(SexyCooldown.bars) do
		HookBar(bar)
	end

	hooksecurefunc(SexyCooldown, "CreateBar", function(self)
		HookBar(self.bars[#self.bars])
	end)
end)