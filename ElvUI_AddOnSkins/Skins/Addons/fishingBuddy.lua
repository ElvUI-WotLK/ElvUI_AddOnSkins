local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

if not AS:IsAddonLODorEnabled("FishingBuddy") then return end

-- FishingBuddy 0.9.8 p1
-- https://www.curseforge.com/wow/addons/fishingbuddy/files/442409

S:AddCallbackForAddon("FishingBuddy", "FishingBuddy", function()
	if not E.private.addOnSkins.FishingBuddy then return end

	FishingBuddyFrame:CreateBackdrop("Transparent")
	FishingBuddyFrame.backdrop:Point("TOPLEFT", 11, -12)
	FishingBuddyFrame.backdrop:Point("BOTTOMRIGHT", -32, 76)

	S:SetBackdropHitRect(FishingBuddyFrame)

	FishingBuddyFramePortrait:Kill()
	FishingLocationsFrame:StripTextures()
	FishingOptionsFrame:StripTextures()
	FishingLocationExpandButtonFrame:StripTextures()

	S:HandleCloseButton(FishingBuddyCloseButton, FishingBuddyFrame.backdrop)

	FishingLocsScrollFrame:StripTextures()
	S:HandleScrollBar(FishingLocsScrollFrameScrollBar)

	S:HandleButton(FishingLocationsSwitchButton)

	S:HandleSliderFrame(FishingBuddyOption_MinimapRadSlider)
	S:HandleSliderFrame(FishingBuddyOption_MinimapPosSlider)

	S:HandleDropDownBox(FishingFluffPetMenu, 187)
	S:HandleDropDownBox(FishingBuddyOption_OutfitMenu, 210)

	S:HandleCheckBox(FishingBuddyOptionSLZ)

	local skinnedTabs = 0
	local function skinTabs()
		local id = skinnedTabs + 1
		local tab = _G["FishingBuddyFrameTab"..id]
		while tab do
			S:HandleTab(tab)

			if id == 1 then
				tab:Point("CENTER", FishingBuddyFrame, "BOTTOMLEFT", 54, 62)
			else
				tab:Point("LEFT", _G["FishingBuddyFrameTab" .. (id - 1)], "RIGHT", -15, 0)
			end

			tab.ClearAllPoints = E.noop
			tab.SetPoint = E.noop

			skinnedTabs = id
			id = id + 1
			tab = _G["FishingBuddyFrameTab"..id]
		end
	end

	hooksecurefunc(FishingBuddy, "ManageFrame", skinTabs)
	skinTabs()

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

	FishingBuddyOptionTab1:Point("TOPLEFT", FishingOptionsFrame, "TOPRIGHT", -33, -65)
	FishingBuddyOptionTab1.ClearAllPoints = E.noop
	FishingBuddyOptionTab1.SetPoint = E.noop

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
		if i == 0 then
			S:HandleCollapseExpandButton(FishingLocationsCollapseAllButton)
		else
			local button = _G["FishingLocations"..i]
			if button then
				S:HandleCollapseExpandButton(button)
			end
		end
	end

	FishingWatchDrag:SetClampedToScreen(true)
	FishingWatchDrag:SetClampRectInsets(0, 0, 23, 0)

	FishingWatchTab:CreateBackdrop("Transparent")
	FishingWatchTab.backdrop:Point("TOPLEFT", 4, -11)
	FishingWatchTab.backdrop:Point("BOTTOMRIGHT", -2, 0)
	FishingWatchTab:DisableDrawLayer("BACKGROUND")
end)