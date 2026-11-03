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

if not AS:IsAddonLODorEnabled("KHunterTimers") then return end

local _G = _G

-- Kharthus's Hunter Timers 3.2.5
-- https://www.curseforge.com/wow/addons/kharthuss-hunter-timers/files/423973

S:AddCallbackForAddon("KHunterTimers", "KHunterTimers", function()
	if not E.private.addOnSkins.KHunterTimers then return end

	KHTvars.bartexture = E.media.normTex

	SkinFrame(KHunterTimersAnchor, "SetTemplate", "Default")

	SkinFrame(KHunterTimersOptions, "StripTextures")
	SkinFrame(KHunterTimersOptions, "SetTemplate", "Transparent")

	SkinFrame(KHunterTimersOptionsTimers, "SetTemplate", "Transparent")
	SkinFrame(KHunterTimersOptionsBars, "SetTemplate", "Transparent")

	SkinControl("HandleEditBox", KHunterTimersOptionsBarsEditBox1)
	SkinFrame(KHunterTimersOptionsBarsEditBox1, "Height", 22)

	SkinControl("HandleEditBox", KHunterTimersOptionsBarsEditBox2)
	SkinFrame(KHunterTimersOptionsBarsEditBox2, "Height", 22)

	SkinControl("HandleButton", KHunterTimersOptionsButtonOkay)
	SkinControl("HandleButton", KHunterTimersOptionsButtonApply)
	SkinControl("HandleButton", KHunterTimersOptionsButtonCancel)

	SkinControl("HandleCheckBox", KHunterTimersOptionsBarsCheckButtonOn)

	for i = 1, KHT_NUM_OPTIONS do
		SkinControl("HandleCheckBox", _G["KHunterTimersOptionsBarsCheckButton"..i])
	end

	for i = 1, KHT_NUM_SLIDERS do
		SkinControl("HandleSliderFrame", _G["KHunterTimersOptionsBarsSlider"..i.."Slider"])
	end

	for i = 1, 6 do
		for j = 1, 13 do
			SkinControl("HandleCheckBox", _G["KHunterTimersOptionsTimers"..i.."CheckButton"..j])
		end

		SkinControl("HandleScrollBar", _G["KHunterTimers"..i.."ScrollBarScrollBar"])

		local tabName = "KHunterTimersOptionsTimersTab"..i
		SkinControl("HandleTab", _G[tabName])
		SkinFrame(_G[tabName .. "Text"], "Point", "CENTER", 0, 1)
	end

	SkinFrame(KHunterTimersFrame, "StripTextures")

	for i = 1, KHT_NUM_BARS do
		SkinControl("HandleIcon", _G["KHunterTimersStatus"..i.."Icon"])
		SkinControl("HandleStatusBar", _G["KHunterTimersStatus"..i.."Bar"])
	end
end)
