local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")

local _G = _G
local pairs = pairs

-- Poisoner 3.01
-- https://www.curseforge.com/wow/addons/poisoner/files/301731

local function LoadSkin()
	if not E.private.addOnSkins.Poisoner then return end

	local function skinButton(button)
		if button.isSkinned then return end

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

	hooksecurefunc("Poisoner_CreateButtons", function()
		local button

		for poison in pairs(Poisoner_PoisonsEverSeen) do
			button = _G["PoisonerMenuButton"..poison]

			if button then
				skinButton(button)
			end
		end
	end)
end

S:AddCallbackForAddon("Poisoner", "Poisoner", LoadSkin)