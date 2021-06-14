local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

if not AS:IsAddonLODorEnabled("Mapster") then return end

-- Mapster 1.3.9
-- https://www.wowace.com/projects/mapster/files/436697

S:AddCallbackForAddon("Mapster", "Mapster", function()
	if not E.private.addOnSkins.Mapster then return end

	local Mapster = LibStub("AceAddon-3.0"):GetAddon("Mapster", true)
	if not Mapster then return end

	if not E.private.skins.blizzard.enable or not E.private.skins.blizzard.worldmap then
		WorldMapFrame:CreateBackdrop()
		WorldMapFrame.backdrop:Point("TOPRIGHT", WorldMapFrameCloseButton, -3, 0)
		WorldMapFrame.backdrop:Point("BOTTOMRIGHT", WorldMapTrackQuest, 0, -3)

		WorldMapFrame:DisableDrawLayer("BACKGROUND")
		WorldMapFrame:DisableDrawLayer("ARTWORK")
		WorldMapFrame:DisableDrawLayer("OVERLAY")

		WorldMapFrameTitle:SetDrawLayer("BORDER")

		WorldMapDetailFrame:CreateBackdrop()
		WorldMapDetailFrame.backdrop:Point("TOPLEFT", -2, 2)
		WorldMapDetailFrame.backdrop:Point("BOTTOMRIGHT", 2, -1)

		WorldMapQuestDetailScrollFrame:Width(348)
		WorldMapQuestDetailScrollFrame:Point("BOTTOMLEFT", WorldMapDetailFrame, "BOTTOMLEFT", -25, -207)
		WorldMapQuestDetailScrollFrame:CreateBackdrop("Transparent")
		WorldMapQuestDetailScrollFrame.backdrop:Point("TOPLEFT", 24, 2)
		WorldMapQuestDetailScrollFrame.backdrop:Point("BOTTOMRIGHT", 23, -4)
		WorldMapQuestDetailScrollFrame:SetHitRectInsets(24, -23, 0, -2)
		WorldMapQuestDetailScrollFrame.backdrop:SetFrameLevel(WorldMapQuestDetailScrollFrame:GetFrameLevel())

		WorldMapQuestDetailScrollFrameTrack:Kill()

		WorldMapQuestRewardScrollFrame:Width(340)
		WorldMapQuestRewardScrollFrame:Point("LEFT", WorldMapQuestDetailScrollFrame, "RIGHT", 8, 0)
		WorldMapQuestRewardScrollFrame:CreateBackdrop("Transparent")
		WorldMapQuestRewardScrollFrame.backdrop:Point("TOPLEFT", 20, 2)
		WorldMapQuestRewardScrollFrame.backdrop:Point("BOTTOMRIGHT", 22, -4)
		WorldMapQuestRewardScrollFrame:SetHitRectInsets(20, -22, 0, -2)
		WorldMapQuestRewardScrollFrame.backdrop:SetFrameLevel(WorldMapQuestRewardScrollFrame:GetFrameLevel())

		WorldMapQuestRewardScrollChildFrame:SetScale(1)

		WorldMapQuestScrollFrame:CreateBackdrop("Transparent")
		WorldMapQuestScrollFrame.backdrop:Point("TOPLEFT", 0, 2)
		WorldMapQuestScrollFrame.backdrop:Point("BOTTOMRIGHT", 25, -3)
		WorldMapQuestScrollFrame.backdrop:SetFrameLevel(WorldMapQuestScrollFrame:GetFrameLevel())

		WorldMapQuestSelectBar:SetTexture(E.Media.Textures.Highlight)
		WorldMapQuestSelectBar:SetAlpha(0.35)

		WorldMapQuestHighlightBar:SetTexture(E.Media.Textures.Highlight)
		WorldMapQuestHighlightBar:SetAlpha(0.35)

		S:HandleScrollBar(WorldMapQuestScrollFrameScrollBar)
		S:HandleScrollBar(WorldMapQuestDetailScrollFrameScrollBar)
		S:HandleScrollBar(WorldMapQuestRewardScrollFrameScrollBar)

		S:HandleCloseButton(WorldMapFrameCloseButton)

		WorldMapFrameSizeDownButton:ClearAllPoints()
		WorldMapFrameSizeDownButton:Point("RIGHT", WorldMapFrameCloseButton, "LEFT", 4, 0)
		WorldMapFrameSizeDownButton.SetPoint = E.noop
		WorldMapFrameSizeDownButton:GetHighlightTexture():Kill()
		S:HandleNextPrevButton(WorldMapFrameSizeDownButton, nil, nil, true)
		WorldMapFrameSizeDownButton:Size(26)

		WorldMapFrameSizeUpButton:ClearAllPoints()
		WorldMapFrameSizeUpButton:Point("RIGHT", WorldMapFrameCloseButton, "LEFT", 4, 0)
		WorldMapFrameSizeUpButton:GetHighlightTexture():Kill()
		S:HandleNextPrevButton(WorldMapFrameSizeUpButton, nil, nil, true)
		WorldMapFrameSizeUpButton:Size(26)

		S:HandleDropDownBox(WorldMapLevelDropDown)
		S:HandleDropDownBox(WorldMapZoneMinimapDropDown)
		S:HandleDropDownBox(WorldMapContinentDropDown)
		S:HandleDropDownBox(WorldMapZoneDropDown)

		S:HandleButton(WorldMapZoomOutButton)
		WorldMapZoomOutButton:Point("LEFT", WorldMapZoneDropDown, "RIGHT", 0, 3)

		S:HandleCheckBox(WorldMapTrackQuest)
		S:HandleCheckBox(WorldMapQuestShowObjectives)

		WorldMapFrameAreaLabel:FontTemplate(nil, 50, "OUTLINE")
		WorldMapFrameAreaLabel:SetShadowOffset(2, -2)
		WorldMapFrameAreaLabel:SetTextColor(0.90, 0.8294, 0.6407)

		WorldMapFrameAreaDescription:FontTemplate(nil, 40, "OUTLINE")
		WorldMapFrameAreaDescription:SetShadowOffset(2, -2)

		WorldMapZoneInfo:FontTemplate(nil, 27, "OUTLINE")
		WorldMapZoneInfo:SetShadowOffset(2, -2)
	else
		WorldMapDetailFrame.backdrop:Hide()
	end

	local function sizeDown()
		WorldMapFrame.backdrop:Point("TOPLEFT", WorldMapDetailFrame, "TOPLEFT", -14, 27)
		WorldMapDetailFrame.backdrop:Hide()
	end
	local function sizeUp()
		WorldMapFrame.backdrop:Point("TOPLEFT", WorldMapDetailFrame, "TOPLEFT", -14, 70)
		WorldMapDetailFrame.backdrop:Show()
	end

	S:SecureHook(Mapster, "SizeDown", sizeDown)
	S:SecureHook(Mapster, "SizeUp", sizeUp)

	if WorldMapFrame.sizedDown or WORLDMAP_SETTINGS and WORLDMAP_SETTINGS.size == WORLDMAP_WINDOWED_SIZE then
		sizeDown()
	else
		sizeUp()
	end

	S:SecureHook(Mapster, "UpdateBorderVisibility", function(self)
		if self.bordersVisible then
			WorldMapFrame.backdrop:Show()
		else
			WorldMapFrame.backdrop:Hide()
		end
	end)

	MapsterOptionsButton:Point("TOPRIGHT", WorldMapPositioningGuide, "TOPRIGHT", -50, -3)
	MapsterOptionsButton.SetPoint = E.noop

	MapsterQuestObjectivesDropDown:Point("BOTTOMRIGHT", WorldMapPositioningGuide, "BOTTOMRIGHT", -7, -4)

	S:HandleButton(MapsterOptionsButton)
	S:HandleDropDownBox(MapsterQuestObjectivesDropDown)

	do -- Scaler
		local Scale = Mapster:GetModule("Scale", true)
		local scaler = WorldMapPositioningGuide:GetRegions()

		local function updateScalerPoint(mini)
			if mini then
				scaler:Point("BOTTOMRIGHT", -25, -8)
			elseif Mapster.bordersVisible then
				scaler:Point("BOTTOMRIGHT", -1, 3)
			end
		end

		if scaler then
			scaler:Size(14)
			updateScalerPoint(Mapster.miniMap)
		else
			if Scale then
				S:SecureHook(Scale, "OnEnable", function(self)
					scaler = WorldMapPositioningGuide:GetRegions()
					scaler:Size(14)
					updateScalerPoint(Mapster.miniMap)

					S:Unhook(self, "OnEnable")
				end)
			end
		end

		if Scale then
			function Scale:UpdateMapsize(mini)
				if not scaler then return end
				updateScalerPoint(mini)
			end
		end
	end
end)