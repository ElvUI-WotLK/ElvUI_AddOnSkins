local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

if not AS:IsAddonLODorEnabled("KHunterTimers") then return end

local _G = _G

-- Kharthus's Hunter Timers 3.2.5
-- https://www.curseforge.com/wow/addons/kharthuss-hunter-timers/files/423973

S:AddCallbackForAddon("KHunterTimers", "KHunterTimers", function()
	if not E.private.addOnSkins.KHunterTimers then return end

	KHunterTimersAnchor:StripTextures()
	KHunterTimersAnchor:SetTemplate("Transparent")
	KHunterTimersFrame:StripTextures()
	KHunterTimersFrame:CreateBackdrop("Transparent")
	KHunterTimersOptions:StripTextures()
	KHunterTimersOptions:SetTemplate("Transparent")
	KHunterTimersOptionsTimers:StripTextures()
	KHunterTimersOptionsTimers:SetTemplate("Transparent")
	KHunterTimersOptionsBars:StripTextures()
	KHunterTimersOptionsBars:SetTemplate("Transparent")

	S:HandleButton(KHunterTimersOptionsButtonOkay)
	S:HandleButton(KHunterTimersOptionsButtonApply)
	S:HandleButton(KHunterTimersOptionsButtonCancel)

	S:HandleScrollBar(KHunterTimers1ScrollBarScrollBar)
	S:HandleScrollBar(KHunterTimers2ScrollBarScrollBar)
	S:HandleScrollBar(KHunterTimers3ScrollBarScrollBar)
	S:HandleScrollBar(KHunterTimers4ScrollBarScrollBar)
	S:HandleScrollBar(KHunterTimers5ScrollBarScrollBar)
	S:HandleScrollBar(KHunterTimers6ScrollBarScrollBar)

	S:HandleSliderFrame(KHunterTimersOptionsBarsSlider1Slider)
	S:HandleSliderFrame(KHunterTimersOptionsBarsSlider2Slider)
	S:HandleSliderFrame(KHunterTimersOptionsBarsSlider3Slider)
	S:HandleSliderFrame(KHunterTimersOptionsBarsSlider4Slider)
	S:HandleSliderFrame(KHunterTimersOptionsBarsSlider5Slider)
	S:HandleSliderFrame(KHunterTimersOptionsBarsSlider6Slider)
	S:HandleSliderFrame(KHunterTimersOptionsBarsSlider7Slider)

	KHunterTimersOptionsBarsEditBox1:StripTextures()
	KHunterTimersOptionsBarsEditBox1:Height(22)
	KHunterTimersOptionsBarsEditBox2:StripTextures()
	KHunterTimersOptionsBarsEditBox2:Height(22)
	S:HandleEditBox(KHunterTimersOptionsBarsEditBox1)
	S:HandleEditBox(KHunterTimersOptionsBarsEditBox2)

	local kHunterTimersCheck = {
		"KHunterTimersOptionsBarsCheckButtonOn",
		"KHunterTimersOptionsBarsCheckButton1",
		"KHunterTimersOptionsBarsCheckButton2",
		"KHunterTimersOptionsBarsCheckButton3",
		"KHunterTimersOptionsBarsCheckButton4",
		"KHunterTimersOptionsBarsCheckButton5",
		"KHunterTimersOptionsBarsCheckButton6",
		"KHunterTimersOptionsBarsCheckButton7",
		"KHunterTimersOptionsBarsCheckButton8",
		"KHunterTimersOptionsBarsCheckButton9",
		"KHunterTimersOptionsBarsCheckButton10",
		"KHunterTimersOptionsBarsCheckButton11",

		"KHunterTimersOptionsTimers1CheckButton1",
		"KHunterTimersOptionsTimers1CheckButton2",
		"KHunterTimersOptionsTimers1CheckButton3",
		"KHunterTimersOptionsTimers1CheckButton4",
		"KHunterTimersOptionsTimers1CheckButton5",
		"KHunterTimersOptionsTimers1CheckButton6",
		"KHunterTimersOptionsTimers1CheckButton7",
		"KHunterTimersOptionsTimers1CheckButton8",
		"KHunterTimersOptionsTimers1CheckButton9",
		"KHunterTimersOptionsTimers1CheckButton10",
		"KHunterTimersOptionsTimers1CheckButton11",
		"KHunterTimersOptionsTimers1CheckButton12",
		"KHunterTimersOptionsTimers1CheckButton13",
		"KHunterTimersOptionsTimers2CheckButton1",
		"KHunterTimersOptionsTimers2CheckButton2",
		"KHunterTimersOptionsTimers2CheckButton3",
		"KHunterTimersOptionsTimers2CheckButton4",
		"KHunterTimersOptionsTimers2CheckButton5",
		"KHunterTimersOptionsTimers2CheckButton6",
		"KHunterTimersOptionsTimers2CheckButton7",
		"KHunterTimersOptionsTimers2CheckButton8",
		"KHunterTimersOptionsTimers2CheckButton9",
		"KHunterTimersOptionsTimers2CheckButton10",
		"KHunterTimersOptionsTimers2CheckButton11",
		"KHunterTimersOptionsTimers2CheckButton12",
		"KHunterTimersOptionsTimers2CheckButton13",
		"KHunterTimersOptionsTimers3CheckButton1",
		"KHunterTimersOptionsTimers3CheckButton2",
		"KHunterTimersOptionsTimers3CheckButton3",
		"KHunterTimersOptionsTimers3CheckButton4",
		"KHunterTimersOptionsTimers3CheckButton5",
		"KHunterTimersOptionsTimers3CheckButton6",
		"KHunterTimersOptionsTimers3CheckButton7",
		"KHunterTimersOptionsTimers3CheckButton8",
		"KHunterTimersOptionsTimers3CheckButton9",
		"KHunterTimersOptionsTimers3CheckButton10",
		"KHunterTimersOptionsTimers3CheckButton11",
		"KHunterTimersOptionsTimers3CheckButton12",
		"KHunterTimersOptionsTimers3CheckButton13",
		"KHunterTimersOptionsTimers4CheckButton1",
		"KHunterTimersOptionsTimers4CheckButton2",
		"KHunterTimersOptionsTimers4CheckButton3",
		"KHunterTimersOptionsTimers4CheckButton4",
		"KHunterTimersOptionsTimers4CheckButton5",
		"KHunterTimersOptionsTimers4CheckButton6",
		"KHunterTimersOptionsTimers4CheckButton7",
		"KHunterTimersOptionsTimers4CheckButton8",
		"KHunterTimersOptionsTimers4CheckButton9",
		"KHunterTimersOptionsTimers4CheckButton10",
		"KHunterTimersOptionsTimers4CheckButton11",
		"KHunterTimersOptionsTimers4CheckButton12",
		"KHunterTimersOptionsTimers4CheckButton13",
		"KHunterTimersOptionsTimers5CheckButton1",
		"KHunterTimersOptionsTimers5CheckButton2",
		"KHunterTimersOptionsTimers5CheckButton3",
		"KHunterTimersOptionsTimers5CheckButton4",
		"KHunterTimersOptionsTimers5CheckButton5",
		"KHunterTimersOptionsTimers5CheckButton6",
		"KHunterTimersOptionsTimers5CheckButton7",
		"KHunterTimersOptionsTimers5CheckButton8",
		"KHunterTimersOptionsTimers5CheckButton9",
		"KHunterTimersOptionsTimers5CheckButton10",
		"KHunterTimersOptionsTimers5CheckButton11",
		"KHunterTimersOptionsTimers5CheckButton12",
		"KHunterTimersOptionsTimers5CheckButton13",
		"KHunterTimersOptionsTimers6CheckButton1",
		"KHunterTimersOptionsTimers6CheckButton2",
		"KHunterTimersOptionsTimers6CheckButton3",
		"KHunterTimersOptionsTimers6CheckButton4",
		"KHunterTimersOptionsTimers6CheckButton5",
		"KHunterTimersOptionsTimers6CheckButton6",
		"KHunterTimersOptionsTimers6CheckButton7",
		"KHunterTimersOptionsTimers6CheckButton8",
		"KHunterTimersOptionsTimers6CheckButton9",
		"KHunterTimersOptionsTimers6CheckButton10",
		"KHunterTimersOptionsTimers6CheckButton11",
		"KHunterTimersOptionsTimers6CheckButton12",
		"KHunterTimersOptionsTimers6CheckButton13",
	}

	for _, frame in ipairs(kHunterTimersCheck) do
		S:HandleCheckBox(_G[frame])
	end

	local kHunterTimersTabs = {
		"KHunterTimersOptionsTimersTab1",
		"KHunterTimersOptionsTimersTab2",
		"KHunterTimersOptionsTimersTab3",
		"KHunterTimersOptionsTimersTab4",
		"KHunterTimersOptionsTimersTab5",
		"KHunterTimersOptionsTimersTab6",
	}

	for _, frame in ipairs(kHunterTimersTabs) do
		S:HandleTab(_G[frame])
		_G[frame .. "Text"]:Point("CENTER", 0, 1)
	end
end)