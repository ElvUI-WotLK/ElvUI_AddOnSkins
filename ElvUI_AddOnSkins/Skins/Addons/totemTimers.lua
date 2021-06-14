local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

if not AS:IsAddonLODorEnabled("TotemTimers") then return end

local _G = _G
local pairs, ipairs = pairs, ipairs
local unpack = unpack

-- TotemTimers 10.2.4
-- https://www.curseforge.com/wow/addons/totemtimers/files/454307

S:AddCallbackForAddon("TotemTimers", "TotemTimers", function()
	if not E.private.addOnSkins.TotemTimers then return end
	if E.myclass ~= "SHAMAN" then return end

	local SLOT_EMPTY_TCOORDS = {
		[EARTH_TOTEM_SLOT] = {
			left	= 66 / 128,
			right	= 96 / 128,
			top		= 3 / 256,
			bottom	= 33 / 256
		},
		[FIRE_TOTEM_SLOT] = {
			left	= 67 / 128,
			right	= 97 / 128,
			top		= 100 / 256,
			bottom	= 130 / 256
		},
		[WATER_TOTEM_SLOT] = {
			left	= 39 / 128,
			right	= 69 / 128,
			top		= 209 / 256,
			bottom	= 239 / 256
		},
		[AIR_TOTEM_SLOT] = {
			left	= 66 / 128,
			right	= 96 / 128,
			top		= 36 / 256,
			bottom	= 66 / 256
		}
	}

	S:SecureHook("TotemTimers_SetupGlobals", function()
		for i, f in pairs(TTActionBars.bars) do
			for j in pairs(f.buttons) do
				local button = _G["TT_ActionButton" .. i .. j]
				button:StyleButton(nil, nil, true)
				button:CreateBackdrop("Default")
				button.backdrop:SetAllPoints()
				button.icon:SetInside()

				for x = 1, 4 do
					button.MiniIcons[x]:SetTexCoord(unpack(E.TexCoords))
				end
			end
		end

		for i = 1, XiTimers.numtimers do
			local button = _G["XiTimers_Timer" .. i]
			local icon = _G["XiTimers_Timer" .. i .. "Icon"]

			button:StyleButton(nil, nil, true)
			button:CreateBackdrop("Default")
			button.backdrop:SetAllPoints()

			icon:SetTexCoord(unpack(E.TexCoords))
			icon:SetInside()
		end

		TotemTimers_MultiSpell:StyleButton(nil, nil, true)
		TotemTimers_MultiSpell:CreateBackdrop("Default")
		TotemTimers_MultiSpell.backdrop:SetAllPoints()
		TotemTimers_MultiSpellIcon:SetTexCoord(unpack(E.TexCoords))
		TotemTimers_MultiSpellIcon:SetInside()

		S:Unhook("TotemTimers_SetupGlobals")
	end)

	hooksecurefunc(TotemTimers, "SetEmptyTexCoord", function(icon, nr)
		if nr and nr > 0 then
			local tcoords = SLOT_EMPTY_TCOORDS[nr]
			icon:SetTexCoord(tcoords.left, tcoords.right, tcoords.top, tcoords.bottom)
		else
			icon:SetTexCoord(unpack(E.TexCoords))
		end
	end)

	hooksecurefunc(TotemTimers, "SetDoubleTexture", function(button, isdouble, flash)
		if isdouble then
			button.icons[1]:SetTexCoord(.08, 0.5, .08, .92)
			button.icons[2]:SetTexCoord(0.5, .92, .08, .92)
		end
	end)

	hooksecurefunc(XiTimers, "new", function(self)
		for _, bar in ipairs(self.timers[#self.timers].timerbars) do
			bar:SetTemplate("Default")
			bar.background.Show = E.noop
			bar.background:Hide()
		end
	end)
end)