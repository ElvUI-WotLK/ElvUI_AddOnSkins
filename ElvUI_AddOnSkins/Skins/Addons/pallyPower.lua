local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

if not AS:IsAddonLODorEnabled("PallyPower") then return end

local unpack = unpack

-- PallyPower 3.2.20

S:AddCallbackForAddon("PallyPower", "PallyPower", function()
	if not E.private.addOnSkins.PallyPower then return end

	PallyPower.ApplySkin = E.noop

	PallyPower.options.args.display.args.gapping.min = -1

	local function scaleBackdrop(frame, scale)
		local backdrop = frame:GetBackdrop()
		backdrop.edgeSize = E.mult / scale
		frame:SetBackdrop(backdrop)
		frame:SetBackdropColor(unpack(E.media.backdropfadecolor))
		frame:SetBackdropBorderColor(unpack(E.media.bordercolor))
	end

	local skinnedFrames = {}

	local function skinFrame(frame)
		frame:SetTemplate("Transparent")
		skinnedFrames[#skinnedFrames + 1] = frame
	end

	hooksecurefunc(PallyPowerFrame, "SetScale", function(self, scale)
		for _, frame in ipairs(skinnedFrames) do
			scaleBackdrop(frame, scale)
		end
	end)

	hooksecurefunc(PallyPowerConfigFrame, "SetScale", scaleBackdrop)

	local backdrop = E.media.backdropfadecolor
	PallyPower.db.profile.cBuffGood = {r = backdrop[1], g = backdrop[2], b = backdrop[3], t = backdrop[4]}
	PallyPower.db.profile.cBuffNeedAll = {r = 0.5, g = 0.5, b = 0.5, t = backdrop[4]}
	PallyPower.db.profile.cBuffNeedSome = {r = 0.5, g = 0.5, b = 0.5, t = backdrop[4]}
	PallyPower.db.profile.cBuffNeedSpecial = {r = 0.5, g = 0.5, b = 0.5, t = backdrop[4]}

	skinFrame(PallyPowerAuto)
	skinFrame(PallyPowerRF)
	skinFrame(PallyPowerAura)

	PallyPowerAutoIcon:SetTexCoord(unpack(E.TexCoords))
	PallyPowerRFIcon:SetTexCoord(unpack(E.TexCoords))
	PallyPowerRFIconSeal:SetTexCoord(unpack(E.TexCoords))
	PallyPowerAuraIcon:SetTexCoord(unpack(E.TexCoords))

	for i = 1, PALLYPOWER_MAXCLASSES do
		local button = PallyPower.classButtons[i]
		skinFrame(button)

		_G[button:GetName().."ClassIcon"]:SetTexCoord(unpack(E.TexCoords))
		_G[button:GetName().."BuffIcon"]:SetTexCoord(unpack(E.TexCoords))

		for j = 1, PALLYPOWER_MAXPERCLASS do
			skinFrame(PallyPower.playerButtons[i][j])
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

	AS:SkinLibrary("AceAddon-2.0")
	AS:SkinLibrary("Dewdrop-2.0")
end)