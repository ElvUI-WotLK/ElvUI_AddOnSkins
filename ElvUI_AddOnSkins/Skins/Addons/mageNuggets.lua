local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

if not AS:IsAddonLODorEnabled("MageNuggets") then return end

local _G = _G
local unpack = unpack

-- Mage Nuggets 1.86
-- https://www.curseforge.com/wow/addons/mage-nuggets/files/438172

S:AddCallbackForAddon("MageNuggets", "MageNuggets", function()
	if not E.private.addOnSkins.MageNuggets then return end

	MageNugSP_Frame:SetTemplate("Transparent", nil, true)
	MageNugSP_FrameText:FontTemplate(nil, 9)
	MageNugSP_FrameButtonShowOptions:Size(6)
	S:HandleButton(MageNugSP_FrameButtonShowOptions)

	MNTorment_Frame:SetTemplate("Default")
	MNTorment_FrameTexture:SetDrawLayer("OVERLAY")
	MNTorment_FrameTexture:SetTexCoord(unpack(E.TexCoords))
	MNTorment_FrameTexture:SetInside()

	MNicyveins_Frame:SetTemplate("Default")
	MNicyveins_FrameTexture:SetDrawLayer("OVERLAY")
	MNicyveins_FrameTexture:SetTexCoord(unpack(E.TexCoords))
	MNicyveins_FrameTexture:SetInside()

	MNarcanepower_Frame:SetTemplate("Default")
	MNarcanepower_FrameTexture:SetDrawLayer("OVERLAY")
	MNarcanepower_FrameTexture:SetTexCoord(unpack(E.TexCoords))
	MNarcanepower_FrameTexture:SetInside()

	MNlust_Frame:SetTemplate("Default")
	MNlust_FrameTexture:SetDrawLayer("OVERLAY")
	MNlust_FrameTexture:SetTexCoord(unpack(E.TexCoords))
	MNlust_FrameTexture:SetInside()

	MageNugClearcast_Frame:SetTemplate("Default")
	MageNugClearcast_FrameTexture:SetDrawLayer("OVERLAY")
	MageNugClearcast_FrameTexture:SetTexCoord(unpack(E.TexCoords))
	MageNugClearcast_FrameTexture:SetInside()
	MageNugClearcast_Frame_Bar:SetStatusBarTexture(E.media.normTex)
	E:RegisterStatusBar(MageNugClearcast_Frame_Bar)
	MageNugClearcast_Frame_Bar:CreateBackdrop("Default")
	MageNugClearcast_Frame_Bar:Width(34 - E.Spacing * 2)
	MageNugClearcast_Frame_Bar:Point("TOP", MageNugClearcast_Frame, "BOTTOM", 0, -E.Spacing * 3)

	MageNugSmallLB_Frame:SetTemplate("Default")
	MageNugSmallLB_FrameTexture:SetDrawLayer("OVERLAY")
	MageNugSmallLB_FrameTexture:SetTexCoord(unpack(E.TexCoords))
	MageNugSmallLB_FrameTexture:SetInside()
	MageNugSmallLB_Frame_LBBar:SetStatusBarTexture(E.media.normTex)
	E:RegisterStatusBar(MageNugSmallLB_Frame_LBBar)
	MageNugSmallLB_Frame_LBBar:CreateBackdrop("Default")
	MageNugSmallLB_Frame_LBBar:Width(34 - E.Spacing * 2)
	MageNugSmallLB_Frame_LBBar:Point("TOP", MageNugSmallLB_Frame, "BOTTOM", 0, -E.Spacing * 3)

	MageNugScorch_Frame:SetTemplate("Default")
	MageNugScorch_FrameTexture:SetDrawLayer("OVERLAY")
	MageNugScorch_FrameTexture:SetTexCoord(unpack(E.TexCoords))
	MageNugScorch_FrameTexture:SetInside()
	MageNugScorch_Frame_Bar:SetStatusBarTexture(E.media.normTex)
	E:RegisterStatusBar(MageNugScorch_Frame_Bar)
	MageNugScorch_Frame_Bar:CreateBackdrop("Default")
	MageNugScorch_Frame_Bar:Width(34 - E.Spacing * 2)
	MageNugScorch_Frame_Bar:Point("TOP", MageNugScorch_Frame, "BOTTOM", 0, -E.Spacing * 3)

	MageNugAB_Frame:SetTemplate("Default")
	MageNugAB_FrameText:SetDrawLayer("OVERLAY", 1)
	MageNugAB_FrameTexture:SetDrawLayer("OVERLAY")
	MageNugAB_FrameTexture:SetTexCoord(unpack(E.TexCoords))
	MageNugAB_FrameTexture:SetInside()
	MageNugAB_Frame_ABBar:SetStatusBarTexture(E.media.normTex)
	E:RegisterStatusBar(MageNugAB_Frame_ABBar)
	MageNugAB_Frame_ABBar:CreateBackdrop("Default")
	MageNugAB_Frame_ABBar:Width(34 - E.Spacing * 2)
	MageNugAB_Frame_ABBar:Point("TOP", MageNugAB_Frame, "BOTTOM", 0, -E.Spacing * 3)
	MNabCast_Frame:SetTemplate("Transparent")
	MNabCast_Frame:Point("BOTTOM", MageNugAB_Frame, "TOP", 0, E.Spacing)

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

		frame:SetBackdrop(nil)
		frame:CreateBackdrop("Default")
		frame.backdrop:SetOutside(texture)

		texture:SetTexCoord(unpack(E.TexCoords))

		_G[frameName .. "Text"]:FontTemplate()
		_G[frameName .. "Text2"]:FontTemplate(nil, 10)
		_G[frameName .. "Text2"]:SetPoint("BOTTOMRIGHT", bar)
		_G[frameName .. "Text2"]:SetParent(bar)

		bar:Point("LEFT", frame.backdrop, "RIGHT", E.Spacing * 3, 0)
		bar:CreateBackdrop("Default")
		bar:SetStatusBarTexture(E.media.normTex)
		E:RegisterStatusBar(bar)
	end

	MageNugPolyFrame:SetTemplate("Transparent")
	MageNugPolyFrame:CreateBackdrop("Default")
	MageNugPolyFrame.backdrop:SetOutside(MageNugPolyFrameTexture)
	MageNugPolyFrameTexture:SetTexCoord(unpack(E.TexCoords))
	MageNugPolyFrameText:FontTemplate()
	MageNugPolyFrameTimerText:FontTemplate()

	MNSpellSteal_Frame:SetTemplate("Transparent", nil, true)
	MNSpellSteal_FrameTitleText:FontTemplate()
	S:HandleButton(MNSpellSteal_FrameButtonShowOptions)

	MageNugMI_Frame:CreateBackdrop("Default")
	MageNugMI_Frame.backdrop:SetOutside(MageNugMI_FrameTexture1)
	MageNugMI_FrameTexture1:SetTexCoord(unpack(E.TexCoords))
	MageNugMI_Frame_MIText:FontTemplate()
	MageNugMI_Frame_MIText1:FontTemplate()
	MageNugMI_Frame_MiBar:Point("LEFT", MageNugMI_Frame.backdrop, "RIGHT", E.Spacing * 3, 0)
	MageNugMI_Frame_MiBar:SetStatusBarTexture(E.media.normTex)
	E:RegisterStatusBar(MageNugMI_Frame_MiBar)
	MageNugMI_Frame_MiBar:CreateBackdrop("Default")

	MageNugWE_Frame:CreateBackdrop("Default")
	MageNugWE_Frame.backdrop:SetOutside(MageNugWE_FrameTexture1)
	MageNugWE_FrameTexture1:SetTexCoord(unpack(E.TexCoords))
	MageNugWE_Frame_MIText:FontTemplate()
	MageNugWE_Frame_WEText1:FontTemplate()
	MageNugWE_Frame_WeBar:Point("LEFT", MageNugWE_Frame.backdrop, "RIGHT", E.Spacing * 3, 0)
	MageNugWE_Frame_WeBar:SetStatusBarTexture(E.media.normTex)
	E:RegisterStatusBar(MageNugWE_Frame_WeBar)
	MageNugWE_Frame_WeBar:CreateBackdrop("Default")

	MageNugHordeFrame:SetTemplate("Transparent")
	MageNugHordeFrameText:FontTemplate()
	MageNugHordeFrameText2:FontTemplate()

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
		_G["MageNugHordeFrame" .. button]:SetTemplate("Default")
		_G["MageNugHordeFrame" .. button]:StyleButton()

		local icon = _G["MageNugHordeFrame" .. button .. "TelDalTexture"]
		icon:SetDrawLayer("OVERLAY")
		icon:SetTexCoord(unpack(E.TexCoords))
		icon:SetInside()
	end

	S:HandleButton(MageNugHordeFrameClose)
	S:HandleButton(MageNugHordeFrameShowOptions)

	MageNugAlliFrame:SetTemplate("Transparent")
	MageNugAlliFrameText:FontTemplate()
	MageNugAlliFrameText2:FontTemplate()

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
		_G["MageNugAlliFrame" .. button]:SetTemplate("Default")
		_G["MageNugAlliFrame" .. button]:StyleButton()

		local icon = _G["MageNugAlliFrame" .. button .. "TelDalTexture"]
		icon:SetDrawLayer("OVERLAY")
		icon:SetTexCoord(unpack(E.TexCoords))
		icon:SetInside()
	end

	S:HandleButton(MageNugAlliFrameClose)
	S:HandleButton(MageNugAlliFrameShowOptions)
end)