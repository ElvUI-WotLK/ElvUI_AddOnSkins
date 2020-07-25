local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

if not AS:IsAddonLODorEnabled("AtlasQuest") then return end

-- AtlasQuest 4.4.3
-- https://www.curseforge.com/wow/addons/atlas-quest-fan-update/files/442800

S:AddCallbackForAddon("AtlasQuest", "AtlasQuest", function()
	if not E.private.addOnSkins.AtlasQuest then return end

	local buttons = {
		STORYbutton,
		OPTIONbutton,
		CLOSEbutton3,
		AQOptionCloseButton,
	}

	local checkBoxes = {
		AQACB,
		AQHCB,
		AQFinishedQuest,
		AQAutoshowOption,
		AQLEFTOption,
		AQRIGHTOption,
		AQColourOption,
		AQCheckQuestlogButton,
		AQAutoQueryOption,
		AQNoQuerySpamOption,
		AQCompareTooltipOption,
	}

	local closeButtons = {
		CLOSEbutton,
		CLOSEbutton2,
	}

	for _, button in ipairs(buttons) do
		S:HandleButton(button)
	end
	for _, checkBox in ipairs(checkBoxes) do
		S:HandleCheckBox(checkBox)
	end
	for _, closeButton in ipairs(closeButtons) do
		S:HandleCloseButton(closeButton)
	end

	AtlasQuestFrame:StripTextures()
	AtlasQuestFrame:SetTemplate("Transparent")
	AtlasQuestFrame:ClearAllPoints()
	AtlasQuestFrame:Point("BOTTOMRIGHT", AtlasFrame, "BOTTOMLEFT", 1, 0)

	AQ_HordeTexture:SetTexture("Interface\\TargetingFrame\\UI-PVP-HORDE")
	AQ_AllianceTexture:SetTexture("Interface\\TargetingFrame\\UI-PVP-ALLIANCE")

	if AtlasMap then
		AtlasQuestInsideFrame:Size(AtlasMap:GetSize())
	end

	AtlasQuestOptionFrame:StripTextures()
	AtlasQuestOptionFrame:SetTemplate("Transparent")

	CLOSEbutton:ClearAllPoints()
	CLOSEbutton:Point("TOPLEFT", AtlasQuestFrame, "TOPLEFT", 4, -4)
	CLOSEbutton:Size(32)

	CLOSEbutton2:Size(32)

	AtlasQuestTooltip:SetTemplate("Transparent")

	for i = 1, 6 do
		_G["AtlasQuestItemframe"..i.."_Icon"]:SetTexCoord(unpack(E.TexCoords))
	end

	AQ_AtlasOrAlphamap = function()
		if AtlasFrame and AtlasFrame:IsVisible() then
			AtlasORAlphaMap = "Atlas"
			AtlasQuestFrame:SetParent(AtlasFrame)

			if AQ_ShownSide == "Right" then
				AtlasQuestFrame:ClearAllPoints()
				AtlasQuestFrame:Point("BOTTOMLEFT", AtlasFrame, "BOTTOMRIGHT", -1, 0)
			else
				AtlasQuestFrame:ClearAllPoints()
				AtlasQuestFrame:Point("BOTTOMRIGHT", AtlasFrame, "BOTTOMLEFT", 1, 0)
			end

			AtlasQuestInsideFrame:SetParent(AtlasFrame)
			AtlasQuestInsideFrame:ClearAllPoints()
			AtlasQuestInsideFrame:Point("TOPLEFT", "AtlasFrame", 18, -84)
		elseif AlphaMapFrame and AlphaMapFrame:IsVisible() then
			AtlasORAlphaMap = "AlphaMap"
			AtlasQuestFrame:SetParent(AlphaMapFrame)

			if AQ_ShownSide == "Right" then
				AtlasQuestFrame:ClearAllPoints()
				AtlasQuestFrame:Point("TOP", "AlphaMapFrame", 400, -107)
			else
				AtlasQuestFrame:ClearAllPoints()
				AtlasQuestFrame:Point("TOPLEFT", "AlphaMapFrame", -195, -107)
			end

			AtlasQuestInsideFrame:SetParent(AlphaMapFrame)
			AtlasQuestInsideFrame:ClearAllPoints()
			AtlasQuestInsideFrame:Point("TOPLEFT", "AlphaMapFrame", 1, -108)
		end
	end
end)