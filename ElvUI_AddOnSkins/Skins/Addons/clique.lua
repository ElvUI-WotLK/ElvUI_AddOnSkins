local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

if not AS:IsAddonLODorEnabled("Clique") then return end

local _G = _G
local unpack = unpack

local FauxScrollFrame_GetOffset = FauxScrollFrame_GetOffset

-- Clique r139
-- https://www.curseforge.com/wow/addons/clique/files/466948

S:AddCallbackForAddon("Clique", "Clique", function()
	if not E.private.addOnSkins.Clique then return end

	CliquePulloutTab:StyleButton(nil, true)
	CliquePulloutTab:SetTemplate("Default", true)
	CliquePulloutTab:GetNormalTexture():SetTexCoord(unpack(E.TexCoords))
	CliquePulloutTab:GetNormalTexture():SetInside()
	CliquePulloutTab:GetRegions():Hide()

	local function SkinFrame(frame)
		frame:StripTextures()
		frame:SetTemplate("Transparent")

		frame.titleBar:StripTextures()
		frame.titleBar:SetTemplate("Default", true)
		frame.titleBar:SetHeight(20)
		frame.titleBar:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 0)
		frame.titleBar:SetPoint("TOPRIGHT", frame, "TOPRIGHT", 0, 0)
	end

	hooksecurefunc(Clique, "CreateOptionsFrame", function()
		SkinFrame(CliqueFrame)

		CliqueFrame:SetHeight(425)
		CliqueFrame:SetPoint("TOPLEFT", SpellBookFrame, "TOPRIGHT", 10, -12)

		local entry

		for i = 1, 10 do
			entry = _G["CliqueList"..i]
			entry:SetHeight(32)
			entry:SetTemplate("Default")
			entry.icon:SetPoint("LEFT", 3.5, 0)
			entry.icon:SetTexCoord(unpack(E.TexCoords))

			if i > 1 then
				entry:SetPoint("TOP", _G["CliqueList" .. (i - 1)], "BOTTOM", 0, -2)
			end

			entry:SetScript("OnEnter", function(self)
				self:SetBackdropBorderColor(unpack(E["media"].rgbvaluecolor))
			end)
			entry:SetScript("OnLeave", function(self)
				local selected = FauxScrollFrame_GetOffset(CliqueListScroll) + self.id
				if selected == self.listSelected then
					self:SetBackdropBorderColor(1, 1, 1)
				else
					self:SetBackdropBorderColor(unpack(E["media"].bordercolor))
				end
			end)
		end

		CliqueListScroll:StripTextures()
		S:HandleScrollBar(CliqueListScrollScrollBar)

		SkinFrame(CliqueTextListFrame)

		for i = 1, 12 do
			entry = _G["CliqueTextList"..i]
			S:HandleCheckBox(entry)
			entry.backdrop:Point("TOPLEFT", 6, -4)
			entry.backdrop:Point("BOTTOMRIGHT", -4, 3)
			entry.backdrop:Point("TOPRIGHT", entry.name, "TOPLEFT", -3, 0)
		end

		CliqueTextListScroll:StripTextures()
		S:HandleScrollBar(CliqueTextListScrollScrollBar)

		S:HandleDropDownBox(CliqueDropDown, 170)
		CliqueDropDown:SetPoint("TOPRIGHT", -1, -25)

		S:HandleCloseButton(CliqueButtonClose)
		CliqueButtonClose:SetSize(32, 32)
		CliqueButtonClose:SetPoint("TOPRIGHT", 5, 5)

		S:HandleButton(CliqueButtonCustom)
		S:HandleButton(CliqueButtonFrames)
		S:HandleButton(CliqueButtonProfiles)
		S:HandleButton(CliqueButtonOptions)
		S:HandleButton(CliqueButtonDelete)
		S:HandleButton(CliqueButtonEdit)

		S:HandleCloseButton(CliqueTextButtonClose)
		CliqueTextButtonClose:SetSize(32, 32)
		CliqueTextButtonClose:SetPoint("TOPRIGHT", 5, 5)

		S:HandleButton(CliqueButtonDeleteProfile)
		S:HandleButton(CliqueButtonSetProfile)
		S:HandleButton(CliqueButtonNewProfile)

		SkinFrame(CliqueOptionsFrame)
		CliqueOptionsFrame:SetHeight(125)
		CliqueOptionsFrame:SetPoint("TOPLEFT", CliqueFrame, "TOPRIGHT", 0, 0)

		S:HandleCloseButton(CliqueOptionsButtonClose)
		CliqueOptionsButtonClose:SetSize(32, 32)
		CliqueOptionsButtonClose:SetPoint("TOPRIGHT", 5, 5)

		if CliqueOptionsAnyDown then
			S:HandleCheckBox(CliqueOptionsAnyDown)
			CliqueOptionsAnyDown.backdrop:Point("TOPLEFT", 6, -4)
			CliqueOptionsAnyDown.backdrop:Point("BOTTOMRIGHT", -4, 3)
			CliqueOptionsAnyDown.backdrop:Point("TOPRIGHT", CliqueOptionsAnyDown.name, "TOPLEFT", -3, 0)
		end

		S:HandleCheckBox(CliqueOptionsSpecSwitch)
		CliqueOptionsSpecSwitch.backdrop:Point("TOPLEFT", 6, -4)
		CliqueOptionsSpecSwitch.backdrop:Point("BOTTOMRIGHT", -4, 3)
		CliqueOptionsSpecSwitch.backdrop:Point("TOPRIGHT", CliqueOptionsSpecSwitch.name, "TOPLEFT", -3, 0)

		S:HandleDropDownBox(CliquePriSpecDropDown)
		S:HandleDropDownBox(CliqueSecSpecDropDown)
		CliquePriSpecDropDown:SetWidth(225)
		CliqueSecSpecDropDown:SetWidth(225)
		CliquePriSpecDropDownButton:SetSize(20, 20)
		CliqueSecSpecDropDownButton:SetSize(20, 20)

		SkinFrame(CliqueCustomFrame)

		S:HandleButton(CliqueCustomButtonBinding)
		S:HandleButton(CliqueCustomButtonIcon)
		CliqueCustomButtonIcon.icon:SetTexCoord(unpack(E.TexCoords))
		CliqueCustomButtonIcon.icon:SetInside()

		for i = 1, 5 do
			entry = _G["CliqueCustomArg"..i]
			S:HandleEditBox(entry)
			entry.backdrop:Point("TOPLEFT", -5, -5)
			entry.backdrop:Point("BOTTOMRIGHT", -5, 5)
		end

		CliqueMulti:SetBackdrop(nil)
		CliqueMulti:CreateBackdrop("Default")
		CliqueMulti.backdrop:Point("TOPLEFT", 5, -8)
		CliqueMulti.backdrop:Point("BOTTOMRIGHT", -5, 8)
		S:HandleScrollBar(CliqueMultiScrollFrameScrollBar)

		S:HandleButton(CliqueCustomButtonCancel)
		S:HandleButton(CliqueCustomButtonSave)

		SkinFrame(CliqueIconSelectFrame)

		local button, buttonIcon
		for i = 1, 20 do
			button = _G["CliqueIcon"..i]
			buttonIcon = _G["CliqueIcon"..i.."Icon"]

			button:StripTextures()
			button:StyleButton(nil, true)
			button.hover:SetAllPoints()
			button:CreateBackdrop("Default")

			buttonIcon:SetAllPoints()
			buttonIcon:SetTexCoord(unpack(E.TexCoords))
		end

		CliqueIconScrollFrame:StripTextures()
		S:HandleScrollBar(CliqueIconScrollFrameScrollBar)
	end)

	hooksecurefunc(Clique, "ListScrollUpdate", function(self)
		if not CliqueListScroll then return end

		local offset = FauxScrollFrame_GetOffset(CliqueListScroll)
		local clickCasts = self.sortList
		local idx, button

		for i = 1, 10 do
			idx = offset + i
			button = _G["CliqueList" .. i]

			if idx <= #clickCasts then
				if idx == self.listSelected then
					button:SetBackdropBorderColor(1, 1, 1)
				else
					button:SetBackdropBorderColor(unpack(E["media"].bordercolor))
				end
			end
		end
	end)
end)