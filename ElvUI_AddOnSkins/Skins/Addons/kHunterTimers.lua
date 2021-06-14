local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

if not AS:IsAddonLODorEnabled("KHunterTimers") then return end

local _G = _G

-- Kharthus's Hunter Timers 3.2.5
-- https://www.curseforge.com/wow/addons/kharthuss-hunter-timers/files/423973

S:AddCallbackForAddon("KHunterTimers", "KHunterTimers", function()
	if not E.private.addOnSkins.KHunterTimers then return end

	KHTvars.bartexture = E.media.normTex

	KHunterTimersAnchor:SetTemplate("Default")

	KHunterTimersOptions:StripTextures()
	KHunterTimersOptions:SetTemplate("Transparent")

	KHunterTimersOptionsTimers:SetTemplate("Transparent")
	KHunterTimersOptionsBars:SetTemplate("Transparent")

	S:HandleEditBox(KHunterTimersOptionsBarsEditBox1)
	KHunterTimersOptionsBarsEditBox1:Height(22)

	S:HandleEditBox(KHunterTimersOptionsBarsEditBox2)
	KHunterTimersOptionsBarsEditBox2:Height(22)

	S:HandleButton(KHunterTimersOptionsButtonOkay)
	S:HandleButton(KHunterTimersOptionsButtonApply)
	S:HandleButton(KHunterTimersOptionsButtonCancel)

	S:HandleCheckBox(KHunterTimersOptionsBarsCheckButtonOn)

	for i = 1, KHT_NUM_OPTIONS do
		S:HandleCheckBox(_G["KHunterTimersOptionsBarsCheckButton"..i])
	end

	for i = 1, KHT_NUM_SLIDERS do
		S:HandleSliderFrame(_G["KHunterTimersOptionsBarsSlider"..i.."Slider"])
	end

	for i = 1, 6 do
		for j = 1, 13 do
			S:HandleCheckBox(_G["KHunterTimersOptionsTimers"..i.."CheckButton"..j])
		end

		S:HandleScrollBar(_G["KHunterTimers"..i.."ScrollBarScrollBar"])

		local tabName = "KHunterTimersOptionsTimersTab"..i
		S:HandleTab(_G[tabName])
		_G[tabName .. "Text"]:Point("CENTER", 0, 1)
	end

	KHunterTimersFrame:StripTextures()

	for i = 1, KHT_NUM_BARS do
		S:HandleIcon(_G["KHunterTimersStatus"..i.."Icon"])
		S:HandleStatusBar(_G["KHunterTimersStatus"..i.."Bar"])
	end
end)