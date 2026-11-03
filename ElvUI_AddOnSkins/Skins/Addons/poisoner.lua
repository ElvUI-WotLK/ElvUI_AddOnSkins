local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
-- Optional controls differ between supported addon versions. Keep missing
-- targets out of native skin handlers without masking other Lua errors.
local function SkinControl(method, frame, ...)
	if frame then return S[method](S, frame, ...) end
end
local function SkinFrame(frame, method, ...)
	if frame then return frame[method](frame, ...) end
end

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
		SkinFrame(PoisonerMinimapButton, "SetTemplate")
		SkinFrame(PoisonerMinimapButton, "Size", 22)

		local normalTexture = PoisonerMinimapButton:GetNormalTexture()
		normalTexture:SetTexture("Interface\\Icons\\Ability_Creature_Poison_02")
		SkinFrame(normalTexture, "SetTexCoord", unpack(E.TexCoords))
		normalTexture:SetDrawLayer("ARTWORK")
		SkinFrame(normalTexture, "SetInside")

		SkinFrame(PoisonerMinimapButton, "SetPushedTexture", nil)
		SkinFrame(PoisonerMinimapButton, "SetHighlightTexture", nil)
		SkinFrame(PoisonerMinimapButton, "SetDisabledTexture", nil)

		PoisonerMinimapButton.isSkinned = true
	end

	hooksecurefunc("Poisoner_CreateButtons", function()
		for poison in pairs(Poisoner_PoisonsEverSeen) do
			local button = _G["PoisonerMenuButton"..poison]

			if button and not button.isSkinned then
				SkinFrame(button, "SetTemplate")
				SkinFrame(button, "StyleButton", nil, true)

				local texture = button:GetNormalTexture()
				SkinFrame(texture, "SetTexCoord", unpack(E.TexCoords))
				SkinFrame(texture, "SetInside", button)

				texture = button:GetHighlightTexture()
				SkinFrame(texture, "SetTexCoord", unpack(E.TexCoords))
				SkinFrame(texture, "SetInside", button)

				button.isSkinned = true
			end
		end
	end)
end)
