local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

-- BakerySpammer
--


if not AS:IsAddonLODorEnabled("BakerySpammer") then return end

S:AddCallbackForAddon("BakerySpammer", "BakerySpammer", function()
	if not E.private.addOnSkins.BakerySpammer then return end
--		print("12312312312312312")
		BakerySpammerSetting:SetTemplate("Transparent")
		BakerySpammerSettingChanel:SetTemplate("Transparent")
		BakerySpammerSettingTextPattern:SetTemplate("Transparent")

		

		S:HandleButton(BakerySpammerSettingStartButton)
		S:HandleButton(BakerySpammerSettingStoptButton)
		S:HandleButton(BakerySpammerSettingExitButton)
		S:HandleCloseButton(BakerySpammerSettingCloseButton)
--      S:HandleDropDownBox(BakerySpammerSettingChanel,190)
--		S:HandleDropDownBox(BakerySpammerSettingTextPattern,190)
--		BakerySpammerSettingChanel:SetTemplate("Transparent")
--		BakerySpammerSettingTextPattern:SetTemplate("Transparent")
		BakerySpammerSettingText:SetTemplate("Transparent")
		BakerySpammerSettingInterval:SetTemplate("Transparent")
--	    BakerySpammerSettingTextBox:SetTemplate("Transparent")
--		BakerySpammerSettingIntervalEditBox:SetTemplate("Transparent")

		S:HandleEditBox(BakerySpammerSettingIntervalEditBox)
		S:HandleEditBox(BakerySpammerSettingTextBox)
		BakerySpammerSettingIntervalEditBox:Height(22)
--		print("222222222222222222")


	local dropdownArrowColor = {1, 0.8, 0}

	S:HandleNextPrevButton(BakerySpammerSettingTextPatternButton, "down", dropdownArrowColor)
	BakerySpammerSettingTextPatternButton:Size(25)

	S:HandleNextPrevButton(BakerySpammerSettingChanelButton, "down", dropdownArrowColor)
	BakerySpammerSettingChanelButton:Size(25)


	end)