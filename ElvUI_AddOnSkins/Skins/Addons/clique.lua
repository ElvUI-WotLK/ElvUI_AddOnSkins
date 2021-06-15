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
		frame.titleBar:Height(20)
		frame.titleBar:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 0)
		frame.titleBar:SetPoint("TOPRIGHT", frame, "TOPRIGHT", 0, 0)
	end

	local function listItemOnEnter(self)
		self:SetBackdropBorderColor(unpack(E.media.rgbvaluecolor))
	end
	local function listItemOnLeave(self)
		local offset = FauxScrollFrame_GetOffset(CliqueListScroll)
		if (self.id + offset) == Clique.listSelected then
			self:SetBackdropBorderColor(1, 1, 1)
		else
			self:SetBackdropBorderColor(unpack(E.media.bordercolor))
		end
	end

	hooksecurefunc(Clique, "CreateOptionsFrame", function()
		-- Main Frame
		SkinFrame(CliqueFrame)

		CliqueFrame:Height(424)
		CliqueFrame:Point("LEFT", SpellBookFrame, "RIGHT", 6, 32)

		S:HandleCloseButton(CliqueButtonClose)
		CliqueButtonClose:Size(32)
		CliqueButtonClose:Point("TOPRIGHT", 5, 6)

		S:HandleDropDownBox(CliqueDropDown, 170)
		CliqueDropDown:Point("TOPRIGHT", 0, -26)

		CliqueList1:Point("TOPLEFT", 8, -56)

		CliqueListScroll:StripTextures()
		S:HandleScrollBar(CliqueListScrollScrollBar)
		CliqueListScrollScrollBar:Point("TOPLEFT", CliqueListScroll, "TOPRIGHT", 3, -19)
		CliqueListScrollScrollBar:Point("BOTTOMLEFT", CliqueListScroll, "BOTTOMRIGHT", 3, 19)

		CliqueButtonCustom:Point("BOTTOMLEFT", 8, 8)

		for i = 1, 10 do
			local entry = _G["CliqueList"..i]
			entry:Size(388, 32)
			entry:SetTemplate("Default")
			entry.icon:Point("LEFT", 4, 0)
			entry.icon:SetTexCoord(unpack(E.TexCoords))

			if i > 1 then
				entry:Point("TOP", _G["CliqueList" .. (i - 1)], "BOTTOM", 0, -1)
			end

			entry:SetScript("OnEnter", listItemOnEnter)
			entry:SetScript("OnLeave", listItemOnLeave)
		end

		S:HandleButton(CliqueButtonCustom)
		S:HandleButton(CliqueButtonFrames)
		S:HandleButton(CliqueButtonProfiles)
		S:HandleButton(CliqueButtonOptions)
		S:HandleButton(CliqueButtonDelete)
		S:HandleButton(CliqueButtonEdit)

		-- OptionsFrame
		SkinFrame(CliqueOptionsFrame)
		CliqueOptionsFrame:Height(125)
		CliqueOptionsFrame:Point("TOPLEFT", CliqueFrame, "TOPRIGHT", -1, 0)

		S:HandleCloseButton(CliqueOptionsButtonClose)
		CliqueOptionsButtonClose:Size(32)
		CliqueOptionsButtonClose:Point("TOPRIGHT", 5, 6)

		if CliqueOptionsAnyDown then
			S:HandleCheckBox(CliqueOptionsAnyDown)
			CliqueOptionsAnyDown.backdrop:Point("TOPLEFT", 6, -4)
			CliqueOptionsAnyDown.backdrop:Point("BOTTOMRIGHT", -4, 3)
			CliqueOptionsAnyDown.backdrop:Point("TOPRIGHT", CliqueOptionsAnyDown.name, "TOPLEFT", -4, 0)
		end

		S:HandleCheckBox(CliqueOptionsSpecSwitch)
		CliqueOptionsSpecSwitch.backdrop:Point("TOPLEFT", 6, -4)
		CliqueOptionsSpecSwitch.backdrop:Point("BOTTOMRIGHT", -4, 3)
		CliqueOptionsSpecSwitch.backdrop:Point("TOPRIGHT", CliqueOptionsSpecSwitch.name, "TOPLEFT", -4, 0)

		S:HandleDropDownBox(CliquePriSpecDropDown, 225)
		S:HandleDropDownBox(CliqueSecSpecDropDown, 225)

		CliqueSecSpecDropDown:Point("TOPLEFT", CliquePriSpecDropDown, "BOTTOMLEFT", 0, 7)

		-- TextListFrame
		SkinFrame(CliqueTextListFrame)

		CliqueTextListFrame:Point("BOTTOMLEFT", CliqueFrame, "BOTTOMRIGHT", -1, 0)

		S:HandleCloseButton(CliqueTextButtonClose)
		CliqueTextButtonClose:Size(32)
		CliqueTextButtonClose:Point("TOPRIGHT", 5, 6)

		CliqueTextList1:Point("TOPLEFT", 6, -23)

		CliqueTextListScroll:StripTextures()
		S:HandleScrollBar(CliqueTextListScrollScrollBar)
		CliqueTextListScrollScrollBar:Point("TOPLEFT", CliqueTextListScroll, "TOPRIGHT", 3, -19)
		CliqueTextListScrollScrollBar:Point("BOTTOMLEFT", CliqueTextListScroll, "BOTTOMRIGHT", 3, 19)

		S:HandleButton(CliqueButtonDeleteProfile)
		S:HandleButton(CliqueButtonSetProfile)
		S:HandleButton(CliqueButtonNewProfile)

		CliqueButtonDeleteProfile:Point("BOTTOMLEFT", 30, 8)

		for i = 1, 12 do
			local entry = _G["CliqueTextList"..i]
			S:HandleCheckBox(entry)
			entry.backdrop:Point("TOPLEFT", 6, -4)
			entry.backdrop:Point("BOTTOMRIGHT", -4, 3)
			entry.backdrop:Point("TOPRIGHT", entry.name, "TOPLEFT", -4, 0)
		end

		-- CustomFrame
		SkinFrame(CliqueCustomFrame)

		S:HandleButton(CliqueCustomButtonBinding)
		S:HandleButton(CliqueCustomButtonIcon)
		CliqueCustomButtonIcon.icon:SetTexCoord(unpack(E.TexCoords))
		CliqueCustomButtonIcon.icon:SetInside()

		for i = 1, 5 do
			local entry = _G["CliqueCustomArg"..i]
			S:HandleEditBox(entry)
			entry.backdrop:Point("TOPLEFT", -5, -5)
			entry.backdrop:Point("BOTTOMRIGHT", -5, 5)
		end

		CliqueMulti:Width(276)
		CliqueMulti:Point("TOPRIGHT", CliqueCustomArg1, "BOTTOMRIGHT", -14, -27)
		CliqueMulti:SetBackdrop(nil)
		CliqueMulti:CreateBackdrop("Default")
		CliqueMulti.backdrop:Point("TOPLEFT", 5, -7)
		CliqueMulti.backdrop:Point("BOTTOMRIGHT", -5, 5)

		S:HandleScrollBar(CliqueMultiScrollFrameScrollBar)
		CliqueMultiScrollFrameScrollBar:Point("TOPLEFT", CliqueMultiScrollFrame, "TOPRIGHT", 6, -18)

		S:HandleButton(CliqueCustomButtonCancel)
		S:HandleButton(CliqueCustomButtonSave)

		CliqueCustomButtonCancel:Point("BOTTOM", 65, 8)

		-- IconSelectFrame
		SkinFrame(CliqueIconSelectFrame)

		CliqueIconSelectFrame:Size(261, 211)

		CliqueIcon1:Point("TOPLEFT", 9, -28)

		CliqueIconScrollFrame:StripTextures()
		S:HandleScrollBar(CliqueIconScrollFrameScrollBar)
		CliqueIconScrollFrameScrollBar:Point("TOPLEFT", CliqueIconScrollFrame, "TOPRIGHT", -4, -18)
		CliqueIconScrollFrameScrollBar:Point("BOTTOMLEFT", CliqueIconScrollFrame, "BOTTOMRIGHT", -4, 18)

		for i = 1, 20 do
			local button = _G["CliqueIcon"..i]
			local buttonIcon = _G["CliqueIcon"..i.."Icon"]

			button:StripTextures()
			button:StyleButton(nil, true)
			button.hover:SetAllPoints()
			button:CreateBackdrop("Default")

			buttonIcon:SetAllPoints()
			buttonIcon:SetTexCoord(unpack(E.TexCoords))
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
				button:Width(width)

				if idx == self.listSelected then
					button:SetBackdropBorderColor(1, 1, 1)
				else
					button:SetBackdropBorderColor(unpack(E.media.bordercolor))
				end
			end
		end
	end)
end)