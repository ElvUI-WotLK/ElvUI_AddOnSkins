local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

if not AS:IsAddonLODorEnabled("GearScore") then return end

local _G = _G
local unpack = unpack

local GetItemInfo = GetItemInfo
local GetItemQualityColor = GetItemQualityColor

-- GearScore 3.1.17

S:AddCallbackForAddon("GearScore", "GearScore", function()
	if not E.private.addOnSkins.GearScore then return end

	GS_DisplayFrame:SetTemplate("Transparent")

	S:HandleCloseButton(GSDisplayFrameCloseButton, GS_DisplayFrame)

	S:HandleEditBox(GS_EditBox1)
	GS_EditBox1:Height(22)
	GS_EditBox1:ClearAllPoints()
	GS_EditBox1:Point("RIGHT", GS_SearchButton, "LEFT", -6, 0)

	S:HandleButton(GS_SearchButton)
	S:HandleButton(GS_GroupButton)
	S:HandleButton(GS_DeleteButton)
	S:HandleButton(GS_InviteButton)

	local frame
	for i = 1, 4 do
		frame = _G["GS_SpecBar" .. i]
		frame:StripTextures()
		frame:SetStatusBarTexture(E.media.normTex)
		frame:CreateBackdrop("Default")
		E:RegisterStatusBar(frame)
	end

	GS_Model:SetTemplate("Transparent")

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
					frame:SetTemplate("Default")

					local _, _, rarity, _, _, _, _, _, _, texture = GetItemInfo("item:" .. GS_Data[E.myrealm].Players[Name].Equip[i])

					if texture then
						frame.texture:SetTexture(texture)
						frame:SetBackdropBorderColor(GetItemQualityColor(rarity))
					else
						frame.texture:SetTexture(GS_TextureFiles[i])
						frame:SetBackdropBorderColor(unpack(E.media.bordercolor))
					end
				end
			end
		else
			for i = 1, 18 do
				if i ~= 4 then
					frame = _G["GS_Frame" .. i]
					frame:SetTemplate("Default")
					frame.texture:SetTexture(GS_TextureFiles[i])
					frame:SetBackdropBorderColor(unpack(E.media.bordercolor))
				end
			end
		end
	end)

--	S:HandleEditBox(GS_NotesEditBox)

	for i = 1, 14 do
		frame = _G["GS_XpBar" .. i]
		frame:StripTextures()
		frame:SetStatusBarTexture(E.media.normTex)
		frame:CreateBackdrop("Default")
		E:RegisterStatusBar(frame)
	end

	GS_DisplayFrameTab1:Point("TOPLEFT", 0, -448)
	GS_DisplayFrameTab2:Point("TOPLEFT", GS_DisplayFrameTab1, "TOPRIGHT", -15, 0)
	GS_DisplayFrameTab3:Point("TOPRIGHT", 0, -448)
	GS_DisplayFrameTab3:Height(32)

	for i = 1, 3 do
		S:HandleTab(_G["GS_DisplayFrameTab" .. i])
	end

	S:HandleCheckBox(GS_ShowPlayerCheck)

	S:HandleButton(Button3)
	S:HandleButton(GS_UndoButton)

	S:HandleCheckBox(GS_Heavy)
	S:HandleCheckBox(GS_None)
	S:HandleCheckBox(GS_Light)
	S:HandleCheckBox(GS_ShowItemCheck)
	S:HandleCheckBox(GS_LevelCheck)

	for i = 1, 4 do
		S:HandleCheckBox(_G["GS_SpecScoreCheck" .. i])
	end

	S:HandleCheckBox(GS_DetailCheck)
	S:HandleCheckBox(GS_DateCheck)
	S:HandleCheckBox(GS_HelpCheck)
	S:HandleCheckBox(GS_ChatCheck)

	S:HandleEditBox(GS_LevelEditBox)

	S:HandleCheckBox(GS_PruneCheck)
	S:HandleCheckBox(GS_FactionCheck)

	S:HandleSliderFrame(GS_DatabaseAgeSlider)

	S:HandleCheckBox(GS_MasterlootCheck)

	GS_DatabaseFrame:SetTemplate("Transparent")

	S:HandleCloseButton(GSDatabaseFrameCloseButton, GS_DatabaseFrame)

	GS_DatabaseFrameTab1:Point("TOPLEFT", 0, -468)
	for i = 1, 4 do
		S:HandleTab(_G["GS_DatabaseFrameTab" .. i])
	end

	S:HandleButton(GS_PreviousButton)
	S:HandleButton(GS_NextButton)
	S:HandleButton(GS_BackProfileButton)

	S:HandleEditBox(GS_SearchXBox)
	GS_SearchXBox:Height(22)
	GS_SearchXBox:ClearAllPoints()
	GS_SearchXBox:Point("RIGHT", GS_Search2Button, "LEFT", -6, 0)

	for _, frame in ipairs({_G["GS_DatabaseFrame"]:GetChildren()}) do
		if frame:GetName() == "GS_Search2Button" then
			S:HandleButton(frame)
		end
	end

	hooksecurefunc("GearScore_DisplayDatabase", function()
		GS_DatabaseFrame.tooltip:SetBackdropColor(unpack(E.media.backdropfadecolor))
	end)

	GS_ReportFrame:SetTemplate("Transparent")
	GS_ReportFrame:Point("TOPLEFT", 819, 0)

	S:HandleCloseButton(GSReportFrameCloseButton, GS_ReportFrame)

	S:HandleSliderFrame(GS_Slider)

	GSX_WhisperEditBox:Height(22)
	GSX_ChannelEditBox:Height(22)

	S:HandleEditBox(GSX_WhisperEditBox)
	S:HandleEditBox(GSX_ChannelEditBox)

	S:HandleButton(GSXButton1)

	S:HandleCheckBox(GSXSayCheck, true)
	S:HandleCheckBox(GSXPartyCheck, true)
	S:HandleCheckBox(GSXRaidCheck, true)
	S:HandleCheckBox(GSXGuildCheck, true)
	S:HandleCheckBox(GSXOfficerCheck, true)
	S:HandleCheckBox(GSXWhisperTargetCheck, true)
	S:HandleCheckBox(GSXWhisperCheck, true)
	S:HandleCheckBox(GSXChannelCheck, true)

	AS:SkinLibrary("LibQTip-1.0")
end)