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

	for i = 1, 11 do
		_G["PallyPowerConfigFrameClassGroup"..i.."ClassButtonIcon"]:SetTexCoord(unpack(E.TexCoords))

		for j = 1, 8 do
			_G["PallyPowerConfigFramePlayer"..j.."Class"..i.."Icon"]:SetTexCoord(unpack(E.TexCoords))
		end
	end

	local function SkinDewdrop()
		local frame
		local i = 1

		while _G["Dewdrop20Level" .. i] do
			frame = _G["Dewdrop20Level" .. i]

			if not frame.isSkinned then
				frame:SetTemplate("Transparent")

				select(1, frame:GetChildren()):Hide()
				frame.SetBackdropColor = E.noop
				frame.SetBackdropBorderColor = E.noop

				frame.isSkinned = true
			end

			i = i + 1
		end

		i = 1
		while _G["Dewdrop20Button"..i] do
			if not _G["Dewdrop20Button" .. i].isHook then
				_G["Dewdrop20Button" .. i]:HookScript("OnEnter", function(self)
					if not self.disabled and self.hasArrow then
						SkinDewdrop()
					end
				end)
				_G["Dewdrop20Button" .. i].isHook = true
			end

			i = i + 1
		end
	end

	local Dewdrop = LibStub("Dewdrop-2.0", true)
	if Dewdrop and not S:IsHooked(Dewdrop, "Open") then
		S:SecureHook(Dewdrop, "Open", SkinDewdrop)
	end

	local AceAddon = LibStub("AceAddon-2.0", true)
	if AceAddon and not S:IsHooked(AceAddon.prototype, "PrintAddonInfo") then
		S:SecureHook(AceAddon.prototype, "PrintAddonInfo", function()
			AceAddon20AboutFrame:SetTemplate("Transparent")
			S:HandleButton(AceAddon20AboutFrameButton)
			S:HandleButton(AceAddon20AboutFrameDonateButton)

			S:Unhook(AceAddon.prototype, "PrintAddonInfo")
		end)
	end
end

S:AddCallbackForAddon("PallyPower", "PallyPower", LoadSkin);