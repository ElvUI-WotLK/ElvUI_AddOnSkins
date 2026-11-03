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

if not AS:IsAddonLODorEnabled("EventAlert") then return end

local _G = _G

-- EventAlert 4.3.6
-- https://www.curseforge.com/wow/addons/event-alert/files/456081

S:AddCallbackForAddon("EventAlert", "EventAlert", function()
	if not E.private.addOnSkins.EventAlert then return end

	local function Alart_OnShow(self)
		self.icon:SetTexture(self:GetBackdrop().bgFile)
		SkinFrame(self, "SetTemplate", "Transparent")
	end

	local function SkinAlartFrame(frame, hook)
		if not frame or frame.icon then return end

		frame.icon = frame:CreateTexture(nil, "ARTWORK")
		frame.icon:SetInside()
		frame.icon:SetTexCoord(unpack(E.TexCoords))

		if hook or not frame:GetBackdrop() then
			SkinFrame(frame, "Hide")
			SkinFrame(frame, "HookScript", "OnShow", Alart_OnShow)
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
				SkinControl("HandleCheckBox", child)
			end
		end

		-- Alt Alarts Options
		for i = 1, Alt_Alerts_Frame:GetNumChildren() do
			local child = select(i, Alt_Alerts_Frame:GetChildren())
			if child and child:IsObjectType("CheckButton") then
				SkinControl("HandleCheckBox", child)
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
	SkinFrame(EA_Options_Frame, "SetTemplate", "Transparent")
	SkinFrame(EA_Options_Frame_Header, "Hide")
	SkinControl("HandleButton", EA_Options_Frame_ToggleIconOptions)
	SkinControl("HandleButton", EA_Options_Frame_ToggleClassEvents)
	SkinControl("HandleButton", EA_Options_Frame_ToggleCustomEvents)
	SkinControl("HandleButton", EA_Options_Frame_Okay)
	SkinControl("HandleCheckBox", EA_Options_Frame_ShowFrame)
	SkinControl("HandleCheckBox", EA_Options_Frame_ShowName)
	SkinControl("HandleCheckBox", EA_Options_Frame_ShowTimer)
	SkinControl("HandleCheckBox", EA_Options_Frame_ChangeTimer)
	SkinControl("HandleCheckBox", EA_Options_Frame_ShowFlash)
	SkinControl("HandleCheckBox", EA_Options_Frame_DoAlertSound)
	SkinControl("HandleCheckBox", EA_Options_Frame_AllowESC)
	SkinControl("HandleCheckBox", EA_Options_Frame_AltAlerts)
	SkinControl("HandleCheckBox", EA_Options_Frame_ShowSpellInfo)
	SkinControl("HandleDropDownBox", EA_Options_Frame_AlertSoundSelect)

	-- Icon Position Options
	SkinFrame(EA_Icon_Options_Frame, "SetTemplate", "Transparent")
	SkinFrame(EA_Icon_Options_Frame_Header, "Hide")
	SkinFrame(EA_Icon_Options_Frame, "Point", "TOPLEFT", EA_Options_Frame, "TOPRIGHT", -1, 0)
	SkinControl("HandleCheckBox", EA_Icon_Options_Frame_LockFrame)
	SkinControl("HandleSliderFrame", EA_Icon_Options_Frame_IconSize)
	SkinControl("HandleSliderFrame", EA_Icon_Options_Frame_IconXOffset)
	SkinControl("HandleSliderFrame", EA_Icon_Options_Frame_IconYOffset)
	SkinControl("HandleButton", EA_Icon_Options_Frame_ToggleAlertFrame)
	SkinControl("HandleButton", EA_Icon_Options_Frame_ResetAlertPosition)

	-- Class Alart Options
	SkinFrame(Class_Events_Frame, "SetTemplate", "Transparent")
	SkinFrame(Class_Events_Frame_Header, "Hide")
	SkinFrame(Class_Events_Frame, "Point", "TOPLEFT", EA_Options_Frame, "TOPRIGHT", -1, 0)

	-- Alt Alarts Options
	SkinFrame(Alt_Alerts_Frame, "SetTemplate", "Transparent")
	SkinFrame(Alt_Alerts_Frame_Header, "Hide")
	SkinFrame(Alt_Alerts_Frame, "Point", "TOPLEFT", Class_Events_Frame, "TOPRIGHT", -1, 0)

	-- Custom Event Options
	SkinFrame(Custom_Events_Frame, "SetTemplate", "Transparent")
	SkinFrame(Custom_Events_Frame_Header, "Hide")
	SkinFrame(Custom_Events_Frame, "SetPoint", "TOPLEFT", EA_Options_Frame, "TOPRIGHT", -1, 0)
	SkinControl("HandleButton", Custom_Events_Frame_SaveCustom_Button)
	SkinControl("HandleButton", Custom_Events_Frame_DeleteCustom_Button)
	SkinControl("HandleEditBox", Custom_Events_Frame_SaveCustom_Box)
	SkinControl("HandleDropDownBox", Custom_Events_Frame_DeleteCustom_Box)
	SkinFrame(Custom_Events_Frame_SaveCustom_Box, "Height", 20)
	SkinFrame(Custom_Events_Frame_DeleteCustom_Box, "Width", 182)
	SkinFrame(Custom_Events_Frame_DeleteCustom_Button, "Point", "RIGHT", Custom_Events_Frame_DeleteCustom_Box, "RIGHT", 91, 3)

	-- Version
	SkinFrame(EA_Version_Frame, "SetTemplate", "Transparent")
	SkinFrame(EA_Version_Frame_Header, "Hide")
	SkinControl("HandleButton", EA_Version_Frame_Okay)
end)
