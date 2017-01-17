local E, L, V, P, G, _ = unpack(ElvUI);
local S = E:GetModule("Skins");

local function LoadSkin()
	if(not E.private.addOnSkins.TotemTimers) then return; end

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
	};

	hooksecurefunc("TotemTimers_SetupGlobals", function()
		for i, f in pairs(TTActionBars.bars) do
			for j, h in pairs(f.buttons) do
				local button = _G["TT_ActionButton" .. i .. j];
				button:StyleButton(nil, nil, true);
				button:CreateBackdrop("Default");
				button.backdrop:SetAllPoints();

				button.icon:SetInside();
				for i = 1, 4 do
					button.MiniIcons[i]:SetTexCoord(unpack(E.TexCoords));
				end
			end
		end

		for i = 1, XiTimers.numtimers do
			local button = _G["XiTimers_Timer" .. i];
			local icon = _G["XiTimers_Timer" .. i .. "Icon"];

			button:StyleButton(nil, nil, true);
			button:CreateBackdrop("Default");
			button.backdrop:SetAllPoints();

			icon:SetTexCoord(unpack(E.TexCoords));
			icon:SetInside();
		end

		TotemTimers_MultiSpell:StyleButton(nil, nil, true);
		TotemTimers_MultiSpell:CreateBackdrop("Default");
		TotemTimers_MultiSpell.backdrop:SetAllPoints();
		TotemTimers_MultiSpellIcon:SetTexCoord(unpack(E.TexCoords));
		TotemTimers_MultiSpellIcon:SetInside();
	end);

	hooksecurefunc(TotemTimers, "SetEmptyTexCoord", function(icon, nr)
		if(nr and nr > 0) then
			local tcoords = SLOT_EMPTY_TCOORDS[nr];
			local tcoordLeft, tcoordRight, tcoordTop, tcoordBottom = tcoords.left, tcoords.right, tcoords.top, tcoords.bottom;
			icon:SetTexCoord(tcoordLeft, tcoordRight, tcoordTop, tcoordBottom);
		else
			icon:SetTexCoord(unpack(E.TexCoords));
		end
	end);

	hooksecurefunc(TotemTimers, "SetDoubleTexture", function(button, isdouble, flash)
		if(isdouble) then
			button.icons[1]:SetTexCoord(.08, 0.5, .08, .92);
			button.icons[2]:SetTexCoord(0.5, .92, .08, .92);
		end
	end);

	hooksecurefunc(XiTimers, "ShowTimerBar", function(self, nr)
		self.timerbars[nr]:GetStatusBarTexture():ClearAllPoints();
		if(self.visibleTimerBars) then
			self.timerbars[nr].background:SetTemplate("Default");
		end
	end);
end

S:AddCallbackForAddon("TotemTimers", "TotemTimers", LoadSkin);