local E, L, V, P, G = unpack(ElvUI);
local S = E:GetModule("Skins");

local unpack = unpack

-- PallyPower 3.2.20

local function LoadSkin()
	if(not E.private.addOnSkins.PallyPower) then return; end

	PallyPower.BuffScale = E.noop
	PallyPower.ConfigScale = E.noop
	PallyPower.ApplySkin = E.noop

	PallyPower.opt.configscale = 1
	PallyPower.opt.buffscale = 1

	local backdrop = E["media"].backdropfadecolor
	PallyPower.db.profile.cBuffGood = {r = backdrop[1], g = backdrop[2], b = backdrop[3], t = backdrop[4]}
	PallyPower.db.profile.cBuffNeedAll = {r = 0.5, g = 0.5, b = 0.5, t = backdrop[4]}
	PallyPower.db.profile.cBuffNeedSome = {r = 0.5, g = 0.5, b = 0.5, t = backdrop[4]}
	PallyPower.db.profile.cBuffNeedSpecial = {r = 0.5, g = 0.5, b = 0.5, t = backdrop[4]}

	PallyPowerAuto:SetTemplate("Transparent", nil, true)
	PallyPowerRF:SetTemplate("Transparent", nil, true)
	PallyPowerAura:SetTemplate("Transparent", nil, true)

	PallyPowerAutoIcon:SetTexCoord(unpack(E.TexCoords))
	PallyPowerRFIcon:SetTexCoord(unpack(E.TexCoords))
	PallyPowerRFIconSeal:SetTexCoord(unpack(E.TexCoords))
	PallyPowerAuraIcon:SetTexCoord(unpack(E.TexCoords))

	for i = 1, PALLYPOWER_MAXCLASSES do
		local button = PallyPower.classButtons[i]
		button:SetTemplate("Transparent", nil, true)

		_G[button:GetName().."ClassIcon"]:SetTexCoord(unpack(E.TexCoords))
		_G[button:GetName().."BuffIcon"]:SetTexCoord(unpack(E.TexCoords))

		for j = 1, PALLYPOWER_MAXPERCLASS do
			PallyPower.playerButtons[i][j]:SetTemplate("Transparent", nil, true)
		end
	end

	PallyPowerConfigFrame:SetTemplate("Transparent")
	S:HandleCloseButton(PallyPowerConfigFrameCloseButton)
	S:HandleCheckBox(PallyPowerConfigFrameFreeAssign)

	S:HandleButton(PallyPowerConfigFrameOptions)
	S:HandleButton(PallyPowerConfigFrameAutoAssign)
	S:HandleButton(PallyPowerConfigFrameClear)
	S:HandleButton(PallyPowerConfigFrameRefresh)

	PallyPowerConfigFrameAuraGroup1AuraHeaderIcon:SetTexCoord(unpack(E.TexCoords))

	for i = 1, 8 do
		_G["PallyPowerConfigFramePlayer"..i.."Aura1Icon"]:SetTexCoord(unpack(E.TexCoords))
	end

	for i = 1, PALLYPOWER_MAXCLASSES do
		_G["PallyPowerConfigFrameClassGroup"..i.."ClassButtonIcon"]:SetTexCoord(unpack(E.TexCoords))

		for j = 1, 8 do
			_G["PallyPowerConfigFramePlayer"..j.."Class"..i.."Icon"]:SetTexCoord(unpack(E.TexCoords))
		end
	end

	E:GetModule("AddOnSkins"):SkinLibrary("AceAddon-2.0")
	E:GetModule("AddOnSkins"):SkinLibrary("Dewdrop-2.0")
end

S:AddCallbackForAddon("PallyPower", "PallyPower", LoadSkin);