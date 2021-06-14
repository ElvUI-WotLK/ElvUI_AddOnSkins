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

	for _, button in ipairs(buttons) do
		S:HandleButton(button)
	end
	for _, checkBox in ipairs(checkBoxes) do
		S:HandleCheckBox(checkBox)
	end

	AtlasQuestFrame:StripTextures()
	AtlasQuestFrame:SetTemplate("Transparent")
	AtlasQuestFrame:ClearAllPoints()
	AtlasQuestFrame:Point("BOTTOMRIGHT", AtlasFrame, "BOTTOMLEFT", 1, 0)

	AQ_HordeTexture:SetTexture("Interface\\TargetingFrame\\UI-PVP-HORDE")
	AQ_AllianceTexture:SetTexture("Interface\\TargetingFrame\\UI-PVP-ALLIANCE")

	if AtlasMap then
		AtlasQuestInsideFrame:SetAllPoints(AtlasMap)
	end

	AtlasQuestOptionFrame:StripTextures()
	AtlasQuestOptionFrame:SetTemplate("Transparent")

	S:HandleCloseButton(CLOSEbutton)
	CLOSEbutton:Point("TOPLEFT", 1, 0)

	S:HandleCloseButton(CLOSEbutton2, AtlasQuestInsideFrame)

	E:GetModule("Tooltip"):HookScript(AtlasQuestTooltip, "OnShow", "SetStyle")

	for i = 1, 6 do
		_G["AtlasQuestItemframe"..i.."_Icon"]:SetTexCoord(unpack(E.TexCoords))
	end

	hooksecurefunc("AQLEFTOption_OnClick", function()
		if not AtlasFrame then return end
		AtlasQuestFrame:ClearAllPoints()
		AtlasQuestFrame:Point("BOTTOMRIGHT", AtlasFrame, "BOTTOMLEFT", 1, 0)
	end)

	hooksecurefunc("AQRIGHTOption_OnClick", function()
		if not AtlasFrame then return end
		AtlasQuestFrame:ClearAllPoints()
		AtlasQuestFrame:Point("BOTTOMLEFT", AtlasFrame, "BOTTOMRIGHT", -1, 0)
	end)

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
			AtlasQuestInsideFrame:SetAllPoints(AtlasMap)
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