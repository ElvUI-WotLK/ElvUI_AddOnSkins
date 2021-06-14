local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

if not AS:IsAddonLODorEnabled("Poisoner") then return end

local _G = _G
local pairs = pairs

-- Poisoner 3.01
-- https://www.curseforge.com/wow/addons/poisoner/files/301731

S:AddCallbackForAddon("Poisoner", "Poisoner", function()
	if not E.private.addOnSkins.Poisoner then return end

	-- Minimap icon
	if not PoisonerMinimapButton.isSkinned then
		PoisonerMinimapButton:SetTemplate()
		PoisonerMinimapButton:Size(22)

		local normalTexture = PoisonerMinimapButton:GetNormalTexture()
		normalTexture:SetTexture("Interface\\Icons\\Ability_Creature_Poison_02")
		normalTexture:SetTexCoord(unpack(E.TexCoords))
		normalTexture:SetDrawLayer("ARTWORK")
		normalTexture:SetInside()

		PoisonerMinimapButton:SetPushedTexture(nil)
		PoisonerMinimapButton:SetHighlightTexture(nil)
		PoisonerMinimapButton:SetDisabledTexture(nil)

		PoisonerMinimapButton.isSkinned = true
	end

	hooksecurefunc("Poisoner_CreateButtons", function()
		for poison in pairs(Poisoner_PoisonsEverSeen) do
			local button = _G["PoisonerMenuButton"..poison]

			if button and not button.isSkinned then
				button:SetTemplate()
				button:StyleButton(nil, true)

				local texture = button:GetNormalTexture()
				texture:SetTexCoord(unpack(E.TexCoords))
				texture:SetInside(button)

				texture = button:GetHighlightTexture()
				texture:SetTexCoord(unpack(E.TexCoords))
				texture:SetInside(button)

				button.isSkinned = true
			end
		end
	end)
end)