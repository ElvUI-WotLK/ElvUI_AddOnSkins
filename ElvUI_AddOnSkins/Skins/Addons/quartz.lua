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

if not AS:IsAddonLODorEnabled("Quartz") then return end

-- Quartz 3.0.3.1
-- https://www.wowace.com/projects/quartz/files/441489

S:AddCallbackForAddon("Quartz", "Quartz", function()
	if not E.private.addOnSkins.Quartz then return end

	local Quartz3 = LibStub("AceAddon-3.0"):GetAddon("Quartz3", true)
	local CastBar = Quartz3.CastBarTemplate.template

	Quartz3.db.profile.backgroundalpha = 0
	Quartz3.db.profile.borderalpha = 0

	local function SkinQuartzBar(self)
		if not self.isSkinned then
			self.IconBorder = CreateFrame("Frame", nil, self)
			self.IconBorder:SetTemplate("Transparent")
			self.IconBorder:SetParent(self)
			self.IconBorder:SetOutside(self.Icon)
			self.Icon:SetTexCoord(unpack(E.TexCoords))

			SkinFrame(self, "SetBackdrop", nil)
			self.Bar:CreateBackdrop("Transparent")

			self.isSkinned = true
		end
		if self.config.hideicon then
			self.IconBorder:Hide()
		else
			self.IconBorder:Show()
		end
	end

	local function SkinQuartzUnlock(self)
		SkinFrame(Quartz3UnlockDialog, "StripTextures")
		SkinFrame(Quartz3UnlockDialog, "SetTemplate", "Transparent")
		SkinControl("HandleButton", Quartz3UnlockDialogLock)
	end

	hooksecurefunc(CastBar, "UNIT_SPELLCAST_START", SkinQuartzBar)
	hooksecurefunc(CastBar, "UNIT_SPELLCAST_CHANNEL_START", SkinQuartzBar)
	hooksecurefunc(Quartz3, "ShowUnlockDialog", SkinQuartzUnlock)
end)
