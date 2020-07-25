local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

if not AS:IsAddonLODorEnabled("FishingBuddy") then return end

local find = string.find

-- FishingBuddy 0.9.8 p1
-- https://www.curseforge.com/wow/addons/fishingbuddy/files/442409

S:AddCallbackForAddon("FishingBuddy", "FishingBuddy", function()
	if not E.private.addOnSkins.FishingBuddy then return end

	FishingBuddyFrame:CreateBackdrop("Transparent")
	FishingBuddyFrame.backdrop:Point("TOPLEFT", 14, -14)
	FishingBuddyFrame.backdrop:Point("BOTTOMRIGHT", -32, 74)

	FishingBuddyFramePortrait:Kill()
	FishingLocationsFrame:StripTextures()
	FishingOptionsFrame:StripTextures()
	FishingLocationExpandButtonFrame:StripTextures()

	S:HandleCloseButton(FishingBuddyCloseButton, FishingBuddyFrame.backdrop)

	FishingLocsScrollFrame:StripTextures()
	S:HandleScrollBar(FishingLocsScrollFrameScrollBar)

	S:HandleTab(FishingBuddyFrameTab1)
	S:HandleTab(FishingBuddyFrameTab2)

	S:HandleButton(FishingLocationsSwitchButton)

	S:HandleSliderFrame(FishingBuddyOption_MinimapRadSlider)
	S:HandleSliderFrame(FishingBuddyOption_MinimapPosSlider)

	S:HandleDropDownBox(FishingBuddyOption_OutfitMenu, 210)

	S:HandleCheckBox(FishingBuddyOptionSLZ)

	if FishingBuddyOption_EasyCastKeys then
		S:HandleDropDownBox(FishingBuddyOption_EasyCastKeys, 140)
	else
		S:SecureHook(FishingBuddy, "Initialize", function()
			S:HandleDropDownBox(FishingBuddyOption_EasyCastKeys, 140)
			S:Unhook(FishingBuddy, "Initialize")
		end)
	end

	local function SkinCheckBoxes()
		local checkBox
		for i = 1, 12 do
			checkBox = _G["FishingBuddyOption"..i]
			if checkBox and not checkBox.isSkinned then
				S:HandleCheckBox(checkBox)
				checkBox.isSkinned = true
			end
		end
	end

	S:HookScript(FishingOptionsFrame, "OnShow", function()
		E:Delay(0.01, SkinCheckBoxes)
		S:Unhook(FishingOptionsFrame, "OnShow")
	end)

	local optionTabs = {
		FishingBuddyOptionTab1,
		FishingBuddyOptionTab2,
		FishingBuddyOptionTab3
	}

	for _, frame in ipairs(optionTabs) do
		frame:SetTemplate("Default")
		frame:StyleButton()
		frame:DisableDrawLayer("BACKGROUND")
		frame:GetNormalTexture():SetInside(frame.backdrop)
		frame:GetNormalTexture():SetTexCoord(unpack(E.TexCoords))

		frame:HookScript("OnClick", function(self)
			if not self.isSkinned then
				SkinCheckBoxes()
				self.isSkinned = true
			end
		end)
	end

	for i = 0, 21 do
		local c = _G["FishingLocations"..i]
		if i == 0 then
			c = FishingLocationsCollapseAllButton
		end
		if c then
			c:SetNormalTexture("")
			c.SetNormalTexture = E.noop
			c:SetPushedTexture("")
			c.SetPushedTexture = E.noop
			c:SetHighlightTexture("")
			c.SetHighlightTexture = E.noop
			c:SetDisabledTexture("")
			c.SetDisabledTexture = E.noop

			c.Text = c:CreateFontString(nil, "OVERLAY")
			c.Text:FontTemplate(nil, 22)
			c.Text:Point("LEFT", 5, 0)
			c.Text:SetText("")

			hooksecurefunc(c, "SetNormalTexture", function(self, texture)
				if find(texture, "MinusButton") then
					self.Text:SetText("-")
				elseif find(texture, "PlusButton") then
					self.Text:SetText("+")
				else
					self.Text:SetText("")
				end
			end)
		end
	end

	FishingWatchDrag:SetClampedToScreen(true)
	FishingWatchDrag:SetClampRectInsets(0, 0, 23, 0)

	FishingWatchTab:CreateBackdrop("Transparent")
	FishingWatchTab.backdrop:Point("TOPLEFT", 4, -11)
	FishingWatchTab.backdrop:Point("BOTTOMRIGHT", -2, 0)
	FishingWatchTab:DisableDrawLayer("BACKGROUND")
end)