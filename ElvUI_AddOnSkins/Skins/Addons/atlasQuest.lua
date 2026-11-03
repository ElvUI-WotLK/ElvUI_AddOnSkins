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
		SkinControl("HandleButton", button)
	end
	for _, checkBox in ipairs(checkBoxes) do
		SkinControl("HandleCheckBox", checkBox)
	end

	SkinFrame(AtlasQuestFrame, "StripTextures")
	SkinFrame(AtlasQuestFrame, "SetTemplate", "Transparent")
	SkinFrame(AtlasQuestFrame, "ClearAllPoints")
	SkinFrame(AtlasQuestFrame, "Point", "BOTTOMRIGHT", AtlasFrame, "BOTTOMLEFT", 1, 0)

	AQ_HordeTexture:SetTexture("Interface\\TargetingFrame\\UI-PVP-HORDE")
	AQ_AllianceTexture:SetTexture("Interface\\TargetingFrame\\UI-PVP-ALLIANCE")

	if AtlasMap then
		SkinFrame(AtlasQuestInsideFrame, "SetAllPoints", AtlasMap)
	end

	SkinFrame(AtlasQuestOptionFrame, "StripTextures")
	SkinFrame(AtlasQuestOptionFrame, "SetTemplate", "Transparent")

	SkinControl("HandleCloseButton", CLOSEbutton)
	SkinFrame(CLOSEbutton, "Point", "TOPLEFT", 1, 0)

	SkinControl("HandleCloseButton", CLOSEbutton2, AtlasQuestInsideFrame)

	E:GetModule("Tooltip"):HookScript(AtlasQuestTooltip, "OnShow", "SetStyle")

	for i = 1, 6 do
		SkinFrame(_G["AtlasQuestItemframe"..i.."_Icon"], "SetTexCoord", unpack(E.TexCoords))
	end

	hooksecurefunc("AQLEFTOption_OnClick", function()
		if not AtlasFrame then return end
		SkinFrame(AtlasQuestFrame, "ClearAllPoints")
		SkinFrame(AtlasQuestFrame, "Point", "BOTTOMRIGHT", AtlasFrame, "BOTTOMLEFT", 1, 0)
	end)

	hooksecurefunc("AQRIGHTOption_OnClick", function()
		if not AtlasFrame then return end
		SkinFrame(AtlasQuestFrame, "ClearAllPoints")
		SkinFrame(AtlasQuestFrame, "Point", "BOTTOMLEFT", AtlasFrame, "BOTTOMRIGHT", -1, 0)
	end)

	AQ_AtlasOrAlphamap = function()
		if AtlasFrame and AtlasFrame:IsVisible() then
			AtlasORAlphaMap = "Atlas"
			AtlasQuestFrame:SetParent(AtlasFrame)

			if AQ_ShownSide == "Right" then
				SkinFrame(AtlasQuestFrame, "ClearAllPoints")
				SkinFrame(AtlasQuestFrame, "Point", "BOTTOMLEFT", AtlasFrame, "BOTTOMRIGHT", -1, 0)
			else
				SkinFrame(AtlasQuestFrame, "ClearAllPoints")
				SkinFrame(AtlasQuestFrame, "Point", "BOTTOMRIGHT", AtlasFrame, "BOTTOMLEFT", 1, 0)
			end

			AtlasQuestInsideFrame:SetParent(AtlasFrame)
			SkinFrame(AtlasQuestInsideFrame, "SetAllPoints", AtlasMap)
		elseif AlphaMapFrame and AlphaMapFrame:IsVisible() then
			AtlasORAlphaMap = "AlphaMap"
			AtlasQuestFrame:SetParent(AlphaMapFrame)

			if AQ_ShownSide == "Right" then
				SkinFrame(AtlasQuestFrame, "ClearAllPoints")
				SkinFrame(AtlasQuestFrame, "Point", "TOP", "AlphaMapFrame", 400, -107)
			else
				SkinFrame(AtlasQuestFrame, "ClearAllPoints")
				SkinFrame(AtlasQuestFrame, "Point", "TOPLEFT", "AlphaMapFrame", -195, -107)
			end

			AtlasQuestInsideFrame:SetParent(AlphaMapFrame)
			SkinFrame(AtlasQuestInsideFrame, "ClearAllPoints")
			SkinFrame(AtlasQuestInsideFrame, "Point", "TOPLEFT", "AlphaMapFrame", 1, -108)
		end
	end
end)
