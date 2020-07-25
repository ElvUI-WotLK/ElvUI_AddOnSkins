local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

if not AS:IsAddonLODorEnabled("EventAlert") then return end

local _G = _G

-- EventAlert 4.3.6
-- https://www.curseforge.com/wow/addons/event-alert/files/456081

S:AddCallbackForAddon("EventAlert", "EventAlert", function()
	if not E.private.addOnSkins.EventAlert then return end

	local function Alart_OnShow(self)
		self.icon:SetTexture(self:GetBackdrop().bgFile)
		self:SetTemplate("Transparent")
	end

	local function SkinAlartFrame(frame, hook)
		if not frame or frame.icon then return end

		frame.icon = frame:CreateTexture(nil, "ARTWORK")
		frame.icon:SetInside()
		frame.icon:SetTexCoord(unpack(E.TexCoords))

		if hook or not frame:GetBackdrop() then
			frame:Hide()
			frame:HookScript("OnShow", Alart_OnShow)
		else
			Alart_OnShow(frame)
		end
	end

	local function SkinFrames()
		for index in pairsByKeys(EA_Items[EA_playerClass]) do
			SkinAlartFrame(_G["EAFrame_"..index], true)
		end
		for index in pairsByKeys(EA_AltItems[EA_playerClass]) do
			SkinAlartFrame(_G["EAFrame_"..index], true)
		end
		for index in pairsByKeys(EA_Items[EA_CLASS_OTHER]) do
			SkinAlartFrame(_G["EAFrame_"..index], true)
		end

		-- Anchor Test Frames
		for _, frame in pairs({EA_Anchor_Frame, EA_Anchor_Frame2, EA_Anchor_Frame3}) do
			SkinAlartFrame(frame)
		end

		-- Class Alart Options
		for i = 1, Class_Events_Frame:GetNumChildren() do
			local child = select(i, Class_Events_Frame:GetChildren())
			if child and child:IsObjectType("CheckButton") then
				S:HandleCheckBox(child)
			end
		end

		-- Alt Alarts Options
		for i = 1, Alt_Alerts_Frame:GetNumChildren() do
			local child = select(i, Alt_Alerts_Frame:GetChildren())
			if child and child:IsObjectType("CheckButton") then
				S:HandleCheckBox(child)
			end
		end
	end

	local function SkinCustomFrames()
		for index in pairsByKeys(EA_CustomItems[EA_playerClass]) do
			SkinAlartFrame(_G["EAFrame_"..index], true)
		end
	end

	if EA_playerClass then
		SkinFrames()
		SkinCustomFrames()
	else
		hooksecurefunc("EventAlert_CreateFrames", SkinFrames)
	end
	hooksecurefunc("EventAlert_CreateCustomFrames", SkinCustomFrames)

	-- Options
	EA_Options_Frame:SetTemplate("Transparent")
	EA_Options_Frame_Header:Hide()
	S:HandleButton(EA_Options_Frame_ToggleIconOptions)
	S:HandleButton(EA_Options_Frame_ToggleClassEvents)
	S:HandleButton(EA_Options_Frame_ToggleCustomEvents)
	S:HandleButton(EA_Options_Frame_Okay)
	S:HandleCheckBox(EA_Options_Frame_ShowFrame)
	S:HandleCheckBox(EA_Options_Frame_ShowName)
	S:HandleCheckBox(EA_Options_Frame_ShowTimer)
	S:HandleCheckBox(EA_Options_Frame_ChangeTimer)
	S:HandleCheckBox(EA_Options_Frame_ShowFlash)
	S:HandleCheckBox(EA_Options_Frame_DoAlertSound)
	S:HandleCheckBox(EA_Options_Frame_AllowESC)
	S:HandleCheckBox(EA_Options_Frame_AltAlerts)
	S:HandleCheckBox(EA_Options_Frame_ShowSpellInfo)
	S:HandleDropDownBox(EA_Options_Frame_AlertSoundSelect)

	-- Icon Position Options
	EA_Icon_Options_Frame:SetTemplate("Transparent")
	EA_Icon_Options_Frame_Header:Hide()
	EA_Icon_Options_Frame:Point("TOPLEFT", EA_Options_Frame, "TOPRIGHT", -1, 0)
	S:HandleCheckBox(EA_Icon_Options_Frame_LockFrame)
	S:HandleSliderFrame(EA_Icon_Options_Frame_IconSize)
	S:HandleSliderFrame(EA_Icon_Options_Frame_IconXOffset)
	S:HandleSliderFrame(EA_Icon_Options_Frame_IconYOffset)
	S:HandleButton(EA_Icon_Options_Frame_ToggleAlertFrame)
	S:HandleButton(EA_Icon_Options_Frame_ResetAlertPosition)

	-- Class Alart Options
	Class_Events_Frame:SetTemplate("Transparent")
	Class_Events_Frame_Header:Hide()
	Class_Events_Frame:Point("TOPLEFT", EA_Options_Frame, "TOPRIGHT", -1, 0)

	-- Alt Alarts Options
	Alt_Alerts_Frame:SetTemplate("Transparent")
	Alt_Alerts_Frame_Header:Hide()
	Alt_Alerts_Frame:Point("TOPLEFT", Class_Events_Frame, "TOPRIGHT", -1, 0)

	-- Custom Event Options
	Custom_Events_Frame:SetTemplate("Transparent")
	Custom_Events_Frame_Header:Hide()
	Custom_Events_Frame:SetPoint("TOPLEFT", EA_Options_Frame, "TOPRIGHT", -1, 0)
	S:HandleButton(Custom_Events_Frame_SaveCustom_Button)
	S:HandleButton(Custom_Events_Frame_DeleteCustom_Button)
	S:HandleEditBox(Custom_Events_Frame_SaveCustom_Box)
	S:HandleDropDownBox(Custom_Events_Frame_DeleteCustom_Box)
	Custom_Events_Frame_SaveCustom_Box:Height(20)
	Custom_Events_Frame_DeleteCustom_Box:Width(182)
	Custom_Events_Frame_DeleteCustom_Button:Point("RIGHT", Custom_Events_Frame_DeleteCustom_Box, "RIGHT", 91, 3)

	-- Version
	EA_Version_Frame:SetTemplate("Transparent")
	EA_Version_Frame_Header:Hide()
	S:HandleButton(EA_Version_Frame_Okay)
end)