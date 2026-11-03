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

if not AS:IsAddonLODorEnabled("MageNuggets") then return end

local _G = _G
local unpack = unpack

-- Mage Nuggets 1.86
-- https://www.curseforge.com/wow/addons/mage-nuggets/files/438172

S:AddCallbackForAddon("MageNuggets", "MageNuggets", function()
	if not E.private.addOnSkins.MageNuggets then return end

	SkinFrame(MageNugSP_Frame, "SetTemplate", "Transparent", nil, true)
	SkinFrame(MageNugSP_FrameText, "FontTemplate", nil, 9)
	SkinFrame(MageNugSP_FrameButtonShowOptions, "Size", 6)
	SkinControl("HandleButton", MageNugSP_FrameButtonShowOptions)

	SkinFrame(MNTorment_Frame, "SetTemplate", "Default")
	MNTorment_FrameTexture:SetDrawLayer("OVERLAY")
	SkinFrame(MNTorment_FrameTexture, "SetTexCoord", unpack(E.TexCoords))
	SkinFrame(MNTorment_FrameTexture, "SetInside")

	SkinFrame(MNicyveins_Frame, "SetTemplate", "Default")
	MNicyveins_FrameTexture:SetDrawLayer("OVERLAY")
	SkinFrame(MNicyveins_FrameTexture, "SetTexCoord", unpack(E.TexCoords))
	SkinFrame(MNicyveins_FrameTexture, "SetInside")

	SkinFrame(MNarcanepower_Frame, "SetTemplate", "Default")
	MNarcanepower_FrameTexture:SetDrawLayer("OVERLAY")
	SkinFrame(MNarcanepower_FrameTexture, "SetTexCoord", unpack(E.TexCoords))
	SkinFrame(MNarcanepower_FrameTexture, "SetInside")

	SkinFrame(MNlust_Frame, "SetTemplate", "Default")
	MNlust_FrameTexture:SetDrawLayer("OVERLAY")
	SkinFrame(MNlust_FrameTexture, "SetTexCoord", unpack(E.TexCoords))
	SkinFrame(MNlust_FrameTexture, "SetInside")

	SkinFrame(MageNugClearcast_Frame, "SetTemplate", "Default")
	MageNugClearcast_FrameTexture:SetDrawLayer("OVERLAY")
	SkinFrame(MageNugClearcast_FrameTexture, "SetTexCoord", unpack(E.TexCoords))
	SkinFrame(MageNugClearcast_FrameTexture, "SetInside")
	MageNugClearcast_Frame_Bar:SetStatusBarTexture(E.media.normTex)
	E:RegisterStatusBar(MageNugClearcast_Frame_Bar)
	MageNugClearcast_Frame_Bar:CreateBackdrop("Default")
	SkinFrame(MageNugClearcast_Frame_Bar, "Width", 34 - E.Spacing * 2)
	SkinFrame(MageNugClearcast_Frame_Bar, "Point", "TOP", MageNugClearcast_Frame, "BOTTOM", 0, -E.Spacing * 3)

	SkinFrame(MageNugSmallLB_Frame, "SetTemplate", "Default")
	MageNugSmallLB_FrameTexture:SetDrawLayer("OVERLAY")
	SkinFrame(MageNugSmallLB_FrameTexture, "SetTexCoord", unpack(E.TexCoords))
	SkinFrame(MageNugSmallLB_FrameTexture, "SetInside")
	MageNugSmallLB_Frame_LBBar:SetStatusBarTexture(E.media.normTex)
	E:RegisterStatusBar(MageNugSmallLB_Frame_LBBar)
	MageNugSmallLB_Frame_LBBar:CreateBackdrop("Default")
	SkinFrame(MageNugSmallLB_Frame_LBBar, "Width", 34 - E.Spacing * 2)
	SkinFrame(MageNugSmallLB_Frame_LBBar, "Point", "TOP", MageNugSmallLB_Frame, "BOTTOM", 0, -E.Spacing * 3)

	SkinFrame(MageNugScorch_Frame, "SetTemplate", "Default")
	MageNugScorch_FrameTexture:SetDrawLayer("OVERLAY")
	SkinFrame(MageNugScorch_FrameTexture, "SetTexCoord", unpack(E.TexCoords))
	SkinFrame(MageNugScorch_FrameTexture, "SetInside")
	MageNugScorch_Frame_Bar:SetStatusBarTexture(E.media.normTex)
	E:RegisterStatusBar(MageNugScorch_Frame_Bar)
	MageNugScorch_Frame_Bar:CreateBackdrop("Default")
	SkinFrame(MageNugScorch_Frame_Bar, "Width", 34 - E.Spacing * 2)
	SkinFrame(MageNugScorch_Frame_Bar, "Point", "TOP", MageNugScorch_Frame, "BOTTOM", 0, -E.Spacing * 3)

	SkinFrame(MageNugAB_Frame, "SetTemplate", "Default")
	MageNugAB_FrameText:SetDrawLayer("OVERLAY", 1)
	MageNugAB_FrameTexture:SetDrawLayer("OVERLAY")
	SkinFrame(MageNugAB_FrameTexture, "SetTexCoord", unpack(E.TexCoords))
	SkinFrame(MageNugAB_FrameTexture, "SetInside")
	MageNugAB_Frame_ABBar:SetStatusBarTexture(E.media.normTex)
	E:RegisterStatusBar(MageNugAB_Frame_ABBar)
	MageNugAB_Frame_ABBar:CreateBackdrop("Default")
	SkinFrame(MageNugAB_Frame_ABBar, "Width", 34 - E.Spacing * 2)
	SkinFrame(MageNugAB_Frame_ABBar, "Point", "TOP", MageNugAB_Frame, "BOTTOM", 0, -E.Spacing * 3)
	SkinFrame(MNabCast_Frame, "SetTemplate", "Transparent")
	SkinFrame(MNabCast_Frame, "Point", "BOTTOM", MageNugAB_Frame, "TOP", 0, E.Spacing)

	local procFrames = {
		"MageNugProcFrame",
		"MageNugImpactProcFrame",
		"MageNugBFProcFrame",
		"MageNugMBProcFrame",
		"MageNugFoFProcFrame"
	}

	for _, frameName in ipairs(procFrames) do
		local frame = _G[frameName]
		local texture = _G[frameName .. "Texture"]
		local bar = _G[frameName .. "_ProcBar"]

		SkinFrame(frame, "SetBackdrop", nil)
		frame:CreateBackdrop("Default")
		frame.backdrop:SetOutside(texture)

		SkinFrame(texture, "SetTexCoord", unpack(E.TexCoords))

		SkinFrame(_G[frameName .. "Text"], "FontTemplate")
		SkinFrame(_G[frameName .. "Text2"], "FontTemplate", nil, 10)
		SkinFrame(_G[frameName .. "Text2"], "SetPoint", "BOTTOMRIGHT", bar)
		_G[frameName .. "Text2"]:SetParent(bar)

		SkinFrame(bar, "Point", "LEFT", frame.backdrop, "RIGHT", E.Spacing * 3, 0)
		bar:CreateBackdrop("Default")
		bar:SetStatusBarTexture(E.media.normTex)
		E:RegisterStatusBar(bar)
	end

	SkinFrame(MageNugPolyFrame, "SetTemplate", "Transparent")
	MageNugPolyFrame:CreateBackdrop("Default")
	MageNugPolyFrame.backdrop:SetOutside(MageNugPolyFrameTexture)
	SkinFrame(MageNugPolyFrameTexture, "SetTexCoord", unpack(E.TexCoords))
	SkinFrame(MageNugPolyFrameText, "FontTemplate")
	SkinFrame(MageNugPolyFrameTimerText, "FontTemplate")

	SkinFrame(MNSpellSteal_Frame, "SetTemplate", "Transparent", nil, true)
	SkinFrame(MNSpellSteal_FrameTitleText, "FontTemplate")
	SkinControl("HandleButton", MNSpellSteal_FrameButtonShowOptions)

	MageNugMI_Frame:CreateBackdrop("Default")
	MageNugMI_Frame.backdrop:SetOutside(MageNugMI_FrameTexture1)
	SkinFrame(MageNugMI_FrameTexture1, "SetTexCoord", unpack(E.TexCoords))
	SkinFrame(MageNugMI_Frame_MIText, "FontTemplate")
	SkinFrame(MageNugMI_Frame_MIText1, "FontTemplate")
	SkinFrame(MageNugMI_Frame_MiBar, "Point", "LEFT", MageNugMI_Frame.backdrop, "RIGHT", E.Spacing * 3, 0)
	MageNugMI_Frame_MiBar:SetStatusBarTexture(E.media.normTex)
	E:RegisterStatusBar(MageNugMI_Frame_MiBar)
	MageNugMI_Frame_MiBar:CreateBackdrop("Default")

	MageNugWE_Frame:CreateBackdrop("Default")
	MageNugWE_Frame.backdrop:SetOutside(MageNugWE_FrameTexture1)
	SkinFrame(MageNugWE_FrameTexture1, "SetTexCoord", unpack(E.TexCoords))
	SkinFrame(MageNugWE_Frame_MIText, "FontTemplate")
	SkinFrame(MageNugWE_Frame_WEText1, "FontTemplate")
	SkinFrame(MageNugWE_Frame_WeBar, "Point", "LEFT", MageNugWE_Frame.backdrop, "RIGHT", E.Spacing * 3, 0)
	MageNugWE_Frame_WeBar:SetStatusBarTexture(E.media.normTex)
	E:RegisterStatusBar(MageNugWE_Frame_WeBar)
	MageNugWE_Frame_WeBar:CreateBackdrop("Default")

	SkinFrame(MageNugHordeFrame, "SetTemplate", "Transparent")
	SkinFrame(MageNugHordeFrameText, "FontTemplate")
	SkinFrame(MageNugHordeFrameText2, "FontTemplate")

	local hordeButtons = {
		"PortDal",
		"PortShat",
		"PortOrg",
		"PortUC",
		"PortTB",
		"PortSMC",
		"PortStonard",
		"TeleDal",
		"TeleShat",
		"TeleOrg",
		"TeleUC",
		"TeleTB",
		"TeleSMC",
		"TeleStonard",
		"Hearth"
	}

	for _, button in ipairs(hordeButtons) do
		SkinFrame(_G["MageNugHordeFrame" .. button], "SetTemplate", "Default")
		SkinFrame(_G["MageNugHordeFrame" .. button], "StyleButton")

		local icon = _G["MageNugHordeFrame" .. button .. "TelDalTexture"]
		icon:SetDrawLayer("OVERLAY")
		SkinFrame(icon, "SetTexCoord", unpack(E.TexCoords))
		SkinFrame(icon, "SetInside")
	end

	SkinControl("HandleButton", MageNugHordeFrameClose)
	SkinControl("HandleButton", MageNugHordeFrameShowOptions)

	SkinFrame(MageNugAlliFrame, "SetTemplate", "Transparent")
	SkinFrame(MageNugAlliFrameText, "FontTemplate")
	SkinFrame(MageNugAlliFrameText2, "FontTemplate")

	local alliButtons = {
		"PortDal",
		"PortShat",
		"PortIF",
		"PortSW",
		"PortDarn",
		"PortExo",
		"PortTheramore",
		"TeleDal",
		"TeleShat",
		"TeleIF",
		"TeleSW",
		"TeleDarn",
		"TeleExo",
		"TeleTheramore",
		"Hearth"
	}

	for _, button in pairs(alliButtons) do
		SkinFrame(_G["MageNugAlliFrame" .. button], "SetTemplate", "Default")
		SkinFrame(_G["MageNugAlliFrame" .. button], "StyleButton")

		local icon = _G["MageNugAlliFrame" .. button .. "TelDalTexture"]
		icon:SetDrawLayer("OVERLAY")
		SkinFrame(icon, "SetTexCoord", unpack(E.TexCoords))
		SkinFrame(icon, "SetInside")
	end

	SkinControl("HandleButton", MageNugAlliFrameClose)
	SkinControl("HandleButton", MageNugAlliFrameShowOptions)
end)
