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

		SkinFrame(WorldMapQuestDetailScrollFrame, "Width", 348)
		SkinFrame(WorldMapQuestDetailScrollFrame, "Point", "BOTTOMLEFT", WorldMapDetailFrame, "BOTTOMLEFT", -25, -207)
		WorldMapQuestDetailScrollFrame:CreateBackdrop("Transparent")
		WorldMapQuestDetailScrollFrame.backdrop:Point("TOPLEFT", 24, 2)
		WorldMapQuestDetailScrollFrame.backdrop:Point("BOTTOMRIGHT", 23, -4)
		WorldMapQuestDetailScrollFrame:SetHitRectInsets(24, -23, 0, -2)
		WorldMapQuestDetailScrollFrame.backdrop:SetFrameLevel(WorldMapQuestDetailScrollFrame:GetFrameLevel())

		SkinFrame(WorldMapQuestDetailScrollFrameTrack, "Kill")

		SkinFrame(WorldMapQuestRewardScrollFrame, "Width", 340)
		SkinFrame(WorldMapQuestRewardScrollFrame, "Point", "LEFT", WorldMapQuestDetailScrollFrame, "RIGHT", 8, 0)
		WorldMapQuestRewardScrollFrame:CreateBackdrop("Transparent")
		WorldMapQuestRewardScrollFrame.backdrop:Point("TOPLEFT", 20, 2)
		WorldMapQuestRewardScrollFrame.backdrop:Point("BOTTOMRIGHT", 22, -4)
		WorldMapQuestRewardScrollFrame:SetHitRectInsets(20, -22, 0, -2)
		WorldMapQuestRewardScrollFrame.backdrop:SetFrameLevel(WorldMapQuestRewardScrollFrame:GetFrameLevel())

		SkinFrame(WorldMapQuestRewardScrollChildFrame, "SetScale", 1)

		WorldMapQuestScrollFrame:CreateBackdrop("Transparent")
		WorldMapQuestScrollFrame.backdrop:Point("TOPLEFT", 0, 2)
		WorldMapQuestScrollFrame.backdrop:Point("BOTTOMRIGHT", 25, -3)
		WorldMapQuestScrollFrame.backdrop:SetFrameLevel(WorldMapQuestScrollFrame:GetFrameLevel())

		WorldMapQuestSelectBar:SetTexture(E.Media.Textures.Highlight)
		SkinFrame(WorldMapQuestSelectBar, "SetAlpha", 0.35)

		WorldMapQuestHighlightBar:SetTexture(E.Media.Textures.Highlight)
		SkinFrame(WorldMapQuestHighlightBar, "SetAlpha", 0.35)

		SkinControl("HandleScrollBar", WorldMapQuestScrollFrameScrollBar)
		SkinControl("HandleScrollBar", WorldMapQuestDetailScrollFrameScrollBar)
		SkinControl("HandleScrollBar", WorldMapQuestRewardScrollFrameScrollBar)

		SkinControl("HandleCloseButton", WorldMapFrameCloseButton)

		SkinFrame(WorldMapFrameSizeDownButton, "ClearAllPoints")
		SkinFrame(WorldMapFrameSizeDownButton, "Point", "RIGHT", WorldMapFrameCloseButton, "LEFT", 4, 0)
		WorldMapFrameSizeDownButton.SetPoint = E.noop
		WorldMapFrameSizeDownButton:GetHighlightTexture():Kill()
		SkinControl("HandleNextPrevButton", WorldMapFrameSizeDownButton, nil, nil, true)
		SkinFrame(WorldMapFrameSizeDownButton, "Size", 26)

		SkinFrame(WorldMapFrameSizeUpButton, "ClearAllPoints")
		SkinFrame(WorldMapFrameSizeUpButton, "Point", "RIGHT", WorldMapFrameCloseButton, "LEFT", 4, 0)
		WorldMapFrameSizeUpButton:GetHighlightTexture():Kill()
		SkinControl("HandleNextPrevButton", WorldMapFrameSizeUpButton, nil, nil, true)
		SkinFrame(WorldMapFrameSizeUpButton, "Size", 26)

		SkinControl("HandleDropDownBox", WorldMapLevelDropDown)
		SkinControl("HandleDropDownBox", WorldMapZoneMinimapDropDown)
		SkinControl("HandleDropDownBox", WorldMapContinentDropDown)
		SkinControl("HandleDropDownBox", WorldMapZoneDropDown)

		SkinControl("HandleButton", WorldMapZoomOutButton)
		SkinFrame(WorldMapZoomOutButton, "Point", "LEFT", WorldMapZoneDropDown, "RIGHT", 0, 3)

		SkinControl("HandleCheckBox", WorldMapTrackQuest)
		SkinControl("HandleCheckBox", WorldMapQuestShowObjectives)

		SkinFrame(WorldMapFrameAreaLabel, "FontTemplate", nil, 50, "OUTLINE")
		WorldMapFrameAreaLabel:SetShadowOffset(2, -2)
		SkinFrame(WorldMapFrameAreaLabel, "SetTextColor", 0.90, 0.8294, 0.6407)

		SkinFrame(WorldMapFrameAreaDescription, "FontTemplate", nil, 40, "OUTLINE")
		WorldMapFrameAreaDescription:SetShadowOffset(2, -2)

		SkinFrame(WorldMapZoneInfo, "FontTemplate", nil, 27, "OUTLINE")
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

	SkinFrame(MapsterOptionsButton, "Point", "TOPRIGHT", WorldMapPositioningGuide, "TOPRIGHT", -50, -3)
	MapsterOptionsButton.SetPoint = E.noop

	SkinFrame(MapsterQuestObjectivesDropDown, "Point", "BOTTOMRIGHT", WorldMapPositioningGuide, "BOTTOMRIGHT", -7, -4)

	SkinControl("HandleButton", MapsterOptionsButton)
	SkinControl("HandleDropDownBox", MapsterQuestObjectivesDropDown)

	do -- Scaler
		local Scale = Mapster:GetModule("Scale", true)
		local scaler = WorldMapPositioningGuide:GetRegions()

		local function updateScalerPoint(mini)
			if mini then
				SkinFrame(scaler, "Point", "BOTTOMRIGHT", -25, -8)
			elseif Mapster.bordersVisible then
				SkinFrame(scaler, "Point", "BOTTOMRIGHT", -1, 3)
			end
		end

		if scaler then
			SkinFrame(scaler, "Size", 14)
			updateScalerPoint(Mapster.miniMap)
		else
			if Scale then
				S:SecureHook(Scale, "OnEnable", function(self)
					scaler = WorldMapPositioningGuide:GetRegions()
					SkinFrame(scaler, "Size", 14)
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
