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

if not AS:IsAddonLODorEnabled("Doom_CooldownPulse") then return end

-- Doom_CooldownPulse 1.2.3
-- https://www.curseforge.com/wow/addons/doomcooldownpulse/files/400638

S:AddCallbackForAddon("Doom_CooldownPulse", "Doom_CooldownPulse", function()
	if not E.private.addOnSkins.Doom_CooldownPulse then return end

	local frame = AS:FindFrameByPoint("CENTER", UIParent, "BOTTOMLEFT", DCP_Saved.x, DCP_Saved.y)
	if not frame then return end

	Doom_CooldownPulse = frame
	SkinFrame(frame, "SetTemplate")
	frame.icon = frame:GetRegions()

	frame.icon:SetParent(frame)
	frame.icon:SetDrawLayer("ARTWORK")
	frame.icon:SetInside()
	frame.icon:SetTexCoord(unpack(E.TexCoords))

	hooksecurefunc(frame.icon, "SetTexture", function(self)
		if not self:GetTexture() then
			self:GetParent():SetAlpha(0)
		end
	end)

	hooksecurefunc(frame, "CreateOptionsFrame", function()
		SkinFrame(DCP_OptionsFrame, "SetScale", GetCVar("uiScale"))

		SkinFrame(DCP_OptionsFrame, "StripTextures")
		SkinFrame(DCP_OptionsFrame, "SetTemplate", "Transparent")

		SkinControl("HandleSliderFrame", DCP_OptionsFrameSlider1)
		SkinControl("HandleSliderFrame", DCP_OptionsFrameSlider2)
		SkinControl("HandleSliderFrame", DCP_OptionsFrameSlider3)
		SkinControl("HandleSliderFrame", DCP_OptionsFrameSlider4)
		SkinControl("HandleSliderFrame", DCP_OptionsFrameSlider5)
		SkinControl("HandleSliderFrame", DCP_OptionsFrameSlider6)

		SkinControl("HandleEditBox", DCP_OptionsFrameIgnoreBox)
		DCP_OptionsFrameIgnoreBox.backdrop:Point("TOPLEFT", -4, -6)
		DCP_OptionsFrameIgnoreBox.backdrop:Point("BOTTOMRIGHT", 0, 5)

		SkinControl("HandleButton", DCP_OptionsFrameButton1)
		SkinControl("HandleButton", DCP_OptionsFrameButton2)
		SkinControl("HandleButton", DCP_OptionsFrameButton3)
		SkinControl("HandleButton", DCP_OptionsFrameButton4)
	end)
end)
