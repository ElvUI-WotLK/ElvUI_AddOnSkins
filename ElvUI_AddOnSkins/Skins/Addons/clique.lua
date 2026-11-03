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

if not AS:IsAddonLODorEnabled("Clique") then return end

local _G = _G
local unpack = unpack

local FauxScrollFrame_GetOffset = FauxScrollFrame_GetOffset

-- Clique r139
-- https://www.curseforge.com/wow/addons/clique/files/466948

S:AddCallbackForAddon("Clique", "Clique", function()
	if not E.private.addOnSkins.Clique then return end

	SkinFrame(CliquePulloutTab, "StyleButton", nil, true)
	SkinFrame(CliquePulloutTab, "SetTemplate", "Default", true)
	CliquePulloutTab:GetNormalTexture():SetTexCoord(unpack(E.TexCoords))
	CliquePulloutTab:GetNormalTexture():SetInside()
	CliquePulloutTab:GetRegions():Hide()

	local function SkinFrame(frame)
		SkinFrame(frame, "StripTextures")
		SkinFrame(frame, "SetTemplate", "Transparent")

		frame.titleBar:StripTextures()
		frame.titleBar:SetTemplate("Default", true)
		frame.titleBar:Height(20)
		frame.titleBar:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 0)
		frame.titleBar:SetPoint("TOPRIGHT", frame, "TOPRIGHT", 0, 0)
	end

	local function listItemOnEnter(self)
		SkinFrame(self, "SetBackdropBorderColor", unpack(E.media.rgbvaluecolor))
	end
	local function listItemOnLeave(self)
		local offset = FauxScrollFrame_GetOffset(CliqueListScroll)
		if (self.id + offset) == Clique.listSelected then
			SkinFrame(self, "SetBackdropBorderColor", 1, 1, 1)
		else
			SkinFrame(self, "SetBackdropBorderColor", unpack(E.media.bordercolor))
		end
	end

	hooksecurefunc(Clique, "CreateOptionsFrame", function()
		-- Main Frame
		SkinFrame(CliqueFrame)

		SkinFrame(CliqueFrame, "Height", 424)
		SkinFrame(CliqueFrame, "Point", "LEFT", SpellBookFrame, "RIGHT", 6, 32)

		SkinControl("HandleCloseButton", CliqueButtonClose)
		SkinFrame(CliqueButtonClose, "Size", 32)
		SkinFrame(CliqueButtonClose, "Point", "TOPRIGHT", 5, 6)

		SkinControl("HandleDropDownBox", CliqueDropDown, 170)
		SkinFrame(CliqueDropDown, "Point", "TOPRIGHT", 0, -26)

		SkinFrame(CliqueList1, "Point", "TOPLEFT", 8, -56)

		SkinFrame(CliqueListScroll, "StripTextures")
		SkinControl("HandleScrollBar", CliqueListScrollScrollBar)
		SkinFrame(CliqueListScrollScrollBar, "Point", "TOPLEFT", CliqueListScroll, "TOPRIGHT", 3, -19)
		SkinFrame(CliqueListScrollScrollBar, "Point", "BOTTOMLEFT", CliqueListScroll, "BOTTOMRIGHT", 3, 19)

		SkinFrame(CliqueButtonCustom, "Point", "BOTTOMLEFT", 8, 8)

		for i = 1, 10 do
			local entry = _G["CliqueList"..i]
			SkinFrame(entry, "Size", 388, 32)
			SkinFrame(entry, "SetTemplate", "Default")
			entry.icon:Point("LEFT", 4, 0)
			entry.icon:SetTexCoord(unpack(E.TexCoords))

			if i > 1 then
				SkinFrame(entry, "Point", "TOP", _G["CliqueList" .. (i - 1)], "BOTTOM", 0, -1)
			end

			SkinFrame(entry, "SetScript", "OnEnter", listItemOnEnter)
			SkinFrame(entry, "SetScript", "OnLeave", listItemOnLeave)
		end

		SkinControl("HandleButton", CliqueButtonCustom)
		SkinControl("HandleButton", CliqueButtonFrames)
		SkinControl("HandleButton", CliqueButtonProfiles)
		SkinControl("HandleButton", CliqueButtonOptions)
		SkinControl("HandleButton", CliqueButtonDelete)
		SkinControl("HandleButton", CliqueButtonEdit)

		-- OptionsFrame
		SkinFrame(CliqueOptionsFrame)
		SkinFrame(CliqueOptionsFrame, "Height", 125)
		SkinFrame(CliqueOptionsFrame, "Point", "TOPLEFT", CliqueFrame, "TOPRIGHT", -1, 0)

		SkinControl("HandleCloseButton", CliqueOptionsButtonClose)
		SkinFrame(CliqueOptionsButtonClose, "Size", 32)
		SkinFrame(CliqueOptionsButtonClose, "Point", "TOPRIGHT", 5, 6)

		if CliqueOptionsAnyDown then
			SkinControl("HandleCheckBox", CliqueOptionsAnyDown)
			CliqueOptionsAnyDown.backdrop:Point("TOPLEFT", 6, -4)
			CliqueOptionsAnyDown.backdrop:Point("BOTTOMRIGHT", -4, 3)
			CliqueOptionsAnyDown.backdrop:Point("TOPRIGHT", CliqueOptionsAnyDown.name, "TOPLEFT", -4, 0)
		end

		SkinControl("HandleCheckBox", CliqueOptionsSpecSwitch)
		CliqueOptionsSpecSwitch.backdrop:Point("TOPLEFT", 6, -4)
		CliqueOptionsSpecSwitch.backdrop:Point("BOTTOMRIGHT", -4, 3)
		CliqueOptionsSpecSwitch.backdrop:Point("TOPRIGHT", CliqueOptionsSpecSwitch.name, "TOPLEFT", -4, 0)

		SkinControl("HandleDropDownBox", CliquePriSpecDropDown, 225)
		SkinControl("HandleDropDownBox", CliqueSecSpecDropDown, 225)

		SkinFrame(CliqueSecSpecDropDown, "Point", "TOPLEFT", CliquePriSpecDropDown, "BOTTOMLEFT", 0, 7)

		-- TextListFrame
		SkinFrame(CliqueTextListFrame)

		SkinFrame(CliqueTextListFrame, "Point", "BOTTOMLEFT", CliqueFrame, "BOTTOMRIGHT", -1, 0)

		SkinControl("HandleCloseButton", CliqueTextButtonClose)
		SkinFrame(CliqueTextButtonClose, "Size", 32)
		SkinFrame(CliqueTextButtonClose, "Point", "TOPRIGHT", 5, 6)

		SkinFrame(CliqueTextList1, "Point", "TOPLEFT", 6, -23)

		SkinFrame(CliqueTextListScroll, "StripTextures")
		SkinControl("HandleScrollBar", CliqueTextListScrollScrollBar)
		SkinFrame(CliqueTextListScrollScrollBar, "Point", "TOPLEFT", CliqueTextListScroll, "TOPRIGHT", 3, -19)
		SkinFrame(CliqueTextListScrollScrollBar, "Point", "BOTTOMLEFT", CliqueTextListScroll, "BOTTOMRIGHT", 3, 19)

		SkinControl("HandleButton", CliqueButtonDeleteProfile)
		SkinControl("HandleButton", CliqueButtonSetProfile)
		SkinControl("HandleButton", CliqueButtonNewProfile)

		SkinFrame(CliqueButtonDeleteProfile, "Point", "BOTTOMLEFT", 30, 8)

		for i = 1, 12 do
			local entry = _G["CliqueTextList"..i]
			SkinControl("HandleCheckBox", entry)
			entry.backdrop:Point("TOPLEFT", 6, -4)
			entry.backdrop:Point("BOTTOMRIGHT", -4, 3)
			entry.backdrop:Point("TOPRIGHT", entry.name, "TOPLEFT", -4, 0)
		end

		-- CustomFrame
		SkinFrame(CliqueCustomFrame)

		SkinControl("HandleButton", CliqueCustomButtonBinding)
		SkinControl("HandleButton", CliqueCustomButtonIcon)
		CliqueCustomButtonIcon.icon:SetTexCoord(unpack(E.TexCoords))
		CliqueCustomButtonIcon.icon:SetInside()

		for i = 1, 5 do
			local entry = _G["CliqueCustomArg"..i]
			SkinControl("HandleEditBox", entry)
			entry.backdrop:Point("TOPLEFT", -5, -5)
			entry.backdrop:Point("BOTTOMRIGHT", -5, 5)
		end

		SkinFrame(CliqueMulti, "Width", 276)
		SkinFrame(CliqueMulti, "Point", "TOPRIGHT", CliqueCustomArg1, "BOTTOMRIGHT", -14, -27)
		SkinFrame(CliqueMulti, "SetBackdrop", nil)
		CliqueMulti:CreateBackdrop("Default")
		CliqueMulti.backdrop:Point("TOPLEFT", 5, -7)
		CliqueMulti.backdrop:Point("BOTTOMRIGHT", -5, 5)

		SkinControl("HandleScrollBar", CliqueMultiScrollFrameScrollBar)
		SkinFrame(CliqueMultiScrollFrameScrollBar, "Point", "TOPLEFT", CliqueMultiScrollFrame, "TOPRIGHT", 6, -18)

		SkinControl("HandleButton", CliqueCustomButtonCancel)
		SkinControl("HandleButton", CliqueCustomButtonSave)

		SkinFrame(CliqueCustomButtonCancel, "Point", "BOTTOM", 65, 8)

		-- IconSelectFrame
		SkinFrame(CliqueIconSelectFrame)

		SkinFrame(CliqueIconSelectFrame, "Size", 261, 211)

		SkinFrame(CliqueIcon1, "Point", "TOPLEFT", 9, -28)

		SkinFrame(CliqueIconScrollFrame, "StripTextures")
		SkinControl("HandleScrollBar", CliqueIconScrollFrameScrollBar)
		SkinFrame(CliqueIconScrollFrameScrollBar, "Point", "TOPLEFT", CliqueIconScrollFrame, "TOPRIGHT", -4, -18)
		SkinFrame(CliqueIconScrollFrameScrollBar, "Point", "BOTTOMLEFT", CliqueIconScrollFrame, "BOTTOMRIGHT", -4, 18)

		for i = 1, 20 do
			local button = _G["CliqueIcon"..i]
			local buttonIcon = _G["CliqueIcon"..i.."Icon"]

			SkinFrame(button, "StripTextures")
			SkinFrame(button, "StyleButton", nil, true)
			button.hover:SetAllPoints()
			button:CreateBackdrop("Default")

			SkinFrame(buttonIcon, "SetAllPoints")
			SkinFrame(buttonIcon, "SetTexCoord", unpack(E.TexCoords))
		end
	end)

	hooksecurefunc(Clique, "ListScrollUpdate", function(self)
		if not CliqueListScroll then return end

		local offset = FauxScrollFrame_GetOffset(CliqueListScroll)
		local width = CliqueListScroll:IsShown() and 388 or 384

		for i = 1, 10 do
			local idx = offset + i

			if idx <= #self.sortList then
				local button = _G["CliqueList" .. i]
				SkinFrame(button, "Width", width)

				if idx == self.listSelected then
					SkinFrame(button, "SetBackdropBorderColor", 1, 1, 1)
				else
					SkinFrame(button, "SetBackdropBorderColor", unpack(E.media.bordercolor))
				end
			end
		end
	end)
end)
