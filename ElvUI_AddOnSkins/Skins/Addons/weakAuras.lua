local E, L, V, P, G, _ = unpack(ElvUI);
local S = E:GetModule("Skins");

local function LoadSkin()
	if(not E.private.addOnSkins.WeakAuras) then return; end

	local function Skin_WeakAuras(frame, ftype)
		if(not frame.backdrop) then
			frame:CreateBackdrop("Transparent");
			frame.icon:SetTexCoord(unpack(E.TexCoords));
			frame.icon.SetTexCoord = E.noop;
		end

		if(ftype == "aurabar") then
			if(not E.db.addOnSkins.weakAuraAuraBar) then
				frame.backdrop:Hide();
			else
				frame.backdrop:Show();
			end
		end

		if(ftype == "icon") then
			if(E.db.addOnSkins.weakAuraIconCooldown) then E:RegisterCooldown(frame.cooldown); end
		end
	end

	local Create_Icon, Modify_Icon = WeakAuras.regionTypes.icon.create, WeakAuras.regionTypes.icon.modify;
	local Create_AuraBar, Modify_AuraBar = WeakAuras.regionTypes.aurabar.create, WeakAuras.regionTypes.aurabar.modify;

	WeakAuras.regionTypes.icon.create = function(parent, data)
		local region = Create_Icon(parent, data);
		Skin_WeakAuras(region, "icon");
		return region;
	end

	WeakAuras.regionTypes.aurabar.create = function(parent)
		local region = Create_AuraBar(parent);
		Skin_WeakAuras(region, "aurabar");
		return region;
	end

	WeakAuras.regionTypes.icon.modify = function(parent, region, data)
		Modify_Icon(parent, region, data);
		Skin_WeakAuras(region, "icon");
	end

	WeakAuras.regionTypes.aurabar.modify = function(parent, region, data)
		Modify_AuraBar(parent, region, data);
		Skin_WeakAuras(region, "aurabar");
	end

	for weakAura, _ in pairs(WeakAuras.regions) do
		if(WeakAuras.regions[weakAura].regionType == "icon"
		or WeakAuras.regions[weakAura].regionType == "aurabar") then
			Skin_WeakAuras(WeakAuras.regions[weakAura].region, WeakAuras.regions[weakAura].regionType);
		end
	end
end

S:AddCallbackForAddon("WeakAuras", "WeakAuras", LoadSkin);