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

if not AS:IsAddonLODorEnabled("GearScore") then return end

local _G = _G
local unpack = unpack

local GetItemInfo = GetItemInfo
local GetItemQualityColor = GetItemQualityColor

-- GearScore 3.1.17

S:AddCallbackForAddon("GearScore", "GearScore", function()
	if not E.private.addOnSkins.GearScore then return end

	SkinFrame(GS_DisplayFrame, "SetTemplate", "Transparent")

	SkinControl("HandleCloseButton", GSDisplayFrameCloseButton, GS_DisplayFrame)

	SkinControl("HandleEditBox", GS_EditBox1)
	SkinFrame(GS_EditBox1, "Height", 22)
	SkinFrame(GS_EditBox1, "ClearAllPoints")
	SkinFrame(GS_EditBox1, "Point", "RIGHT", GS_SearchButton, "LEFT", -6, 0)

	SkinControl("HandleButton", GS_SearchButton)
	SkinControl("HandleButton", GS_GroupButton)
	SkinControl("HandleButton", GS_DeleteButton)
	SkinControl("HandleButton", GS_InviteButton)

	local frame
	for i = 1, 4 do
		frame = _G["GS_SpecBar" .. i]
		SkinFrame(frame, "StripTextures")
		frame:SetStatusBarTexture(E.media.normTex)
		frame:CreateBackdrop("Default")
		E:RegisterStatusBar(frame)
	end

	SkinFrame(GS_Model, "SetTemplate", "Transparent")

	for i = 1, 18 do
		if i ~= 4 then
			frame = _G["GS_Frame" .. i]
			frame.texture = frame:CreateTexture(nil, "BORDER")
			frame.texture:SetInside()
			frame.texture:SetTexCoord(unpack(E.TexCoords))
		end
	end

	hooksecurefunc("GearScore_DisplayUnit", function(Name)
		local frame

		if GS_Data[E.myrealm].Players[Name] then
			for i = 1, 18 do
				if i ~= 4 then
					frame = _G["GS_Frame" .. i]
					SkinFrame(frame, "SetTemplate", "Default")

					local _, _, rarity, _, _, _, _, _, _, texture = GetItemInfo("item:" .. GS_Data[E.myrealm].Players[Name].Equip[i])

					if texture then
						frame.texture:SetTexture(texture)
						SkinFrame(frame, "SetBackdropBorderColor", GetItemQualityColor(rarity))
					else
						frame.texture:SetTexture(GS_TextureFiles[i])
						SkinFrame(frame, "SetBackdropBorderColor", unpack(E.media.bordercolor))
					end
				end
			end
		else
			for i = 1, 18 do
				if i ~= 4 then
					frame = _G["GS_Frame" .. i]
					SkinFrame(frame, "SetTemplate", "Default")
					frame.texture:SetTexture(GS_TextureFiles[i])
					SkinFrame(frame, "SetBackdropBorderColor", unpack(E.media.bordercolor))
				end
			end
		end
	end)

--	SkinControl("HandleEditBox", GS_NotesEditBox)

	for i = 1, 14 do
		frame = _G["GS_XpBar" .. i]
		SkinFrame(frame, "StripTextures")
		frame:SetStatusBarTexture(E.media.normTex)
		frame:CreateBackdrop("Default")
		E:RegisterStatusBar(frame)
	end

	SkinFrame(GS_DisplayFrameTab1, "Point", "TOPLEFT", 0, -448)
	SkinFrame(GS_DisplayFrameTab2, "Point", "TOPLEFT", GS_DisplayFrameTab1, "TOPRIGHT", -15, 0)
	SkinFrame(GS_DisplayFrameTab3, "Point", "TOPRIGHT", 0, -448)
	SkinFrame(GS_DisplayFrameTab3, "Height", 32)

	for i = 1, 3 do
		SkinControl("HandleTab", _G["GS_DisplayFrameTab" .. i])
	end

	SkinControl("HandleCheckBox", GS_ShowPlayerCheck)

	SkinControl("HandleButton", Button3)
	SkinControl("HandleButton", GS_UndoButton)

	SkinControl("HandleCheckBox", GS_Heavy)
	SkinControl("HandleCheckBox", GS_None)
	SkinControl("HandleCheckBox", GS_Light)
	SkinControl("HandleCheckBox", GS_ShowItemCheck)
	SkinControl("HandleCheckBox", GS_LevelCheck)

	for i = 1, 4 do
		SkinControl("HandleCheckBox", _G["GS_SpecScoreCheck" .. i])
	end

	SkinControl("HandleCheckBox", GS_DetailCheck)
	SkinControl("HandleCheckBox", GS_DateCheck)
	SkinControl("HandleCheckBox", GS_HelpCheck)
	SkinControl("HandleCheckBox", GS_ChatCheck)

	SkinControl("HandleEditBox", GS_LevelEditBox)

	SkinControl("HandleCheckBox", GS_PruneCheck)
	SkinControl("HandleCheckBox", GS_FactionCheck)

	SkinControl("HandleSliderFrame", GS_DatabaseAgeSlider)

	SkinControl("HandleCheckBox", GS_MasterlootCheck)

	SkinFrame(GS_DatabaseFrame, "SetTemplate", "Transparent")

	SkinControl("HandleCloseButton", GSDatabaseFrameCloseButton, GS_DatabaseFrame)

	SkinFrame(GS_DatabaseFrameTab1, "Point", "TOPLEFT", 0, -468)
	for i = 1, 4 do
		SkinControl("HandleTab", _G["GS_DatabaseFrameTab" .. i])
	end

	SkinControl("HandleButton", GS_PreviousButton)
	SkinControl("HandleButton", GS_NextButton)
	SkinControl("HandleButton", GS_BackProfileButton)

	SkinControl("HandleEditBox", GS_SearchXBox)
	SkinFrame(GS_SearchXBox, "Height", 22)
	SkinFrame(GS_SearchXBox, "ClearAllPoints")
	SkinFrame(GS_SearchXBox, "Point", "RIGHT", GS_Search2Button, "LEFT", -6, 0)

	for _, frame in ipairs({_G["GS_DatabaseFrame"]:GetChildren()}) do
		if frame:GetName() == "GS_Search2Button" then
			SkinControl("HandleButton", frame)
		end
	end

	hooksecurefunc("GearScore_DisplayDatabase", function()
		GS_DatabaseFrame.tooltip:SetBackdropColor(unpack(E.media.backdropfadecolor))
	end)

	SkinFrame(GS_ReportFrame, "SetTemplate", "Transparent")
	SkinFrame(GS_ReportFrame, "Point", "TOPLEFT", 819, 0)

	SkinControl("HandleCloseButton", GSReportFrameCloseButton, GS_ReportFrame)

	SkinControl("HandleSliderFrame", GS_Slider)

	SkinFrame(GSX_WhisperEditBox, "Height", 22)
	SkinFrame(GSX_ChannelEditBox, "Height", 22)

	SkinControl("HandleEditBox", GSX_WhisperEditBox)
	SkinControl("HandleEditBox", GSX_ChannelEditBox)

	SkinControl("HandleButton", GSXButton1)

	SkinControl("HandleCheckBox", GSXSayCheck, true)
	SkinControl("HandleCheckBox", GSXPartyCheck, true)
	SkinControl("HandleCheckBox", GSXRaidCheck, true)
	SkinControl("HandleCheckBox", GSXGuildCheck, true)
	SkinControl("HandleCheckBox", GSXOfficerCheck, true)
	SkinControl("HandleCheckBox", GSXWhisperTargetCheck, true)
	SkinControl("HandleCheckBox", GSXWhisperCheck, true)
	SkinControl("HandleCheckBox", GSXChannelCheck, true)

	AS:SkinLibrary("LibQTip-1.0")
end)
