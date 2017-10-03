local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")

-- RaidRoll 4.4.15

local function LoadSkin()
	if not E.private.addOnSkins.RaidRoll then return end

	RR_RollFrame:SetTemplate("Transparent")
	RR_NAME_FRAME:SetTemplate("Default")

	S:HandleCloseButton(RR_Close_Button, RR_RollFrame)

	S:HandleSliderFrame(RaidRoll_Slider_ID)

	S:HandleButton(RaidRoll_AnnounceWinnerButton)
	S:HandleButton(RR_Roll_5SecAndAnnounce)
	S:HandleButton(RR_Roll_RollButton)
	S:HandleButton(RR_Last)
	S:HandleButton(RR_Clear)
	S:HandleButton(RR_Next)
	S:HandleButton(RaidRoll_OptionButton)

	RR_Frame:SetTemplate("Transparent")
	RR_Frame:Width(185)
	RR_Frame:Point("TOP", RR_RollFrame, "BOTTOM", 0, 1)

	local rrframeLevel = RR_Frame:GetFrameLevel()
	RaidRoll_Catch_All:SetFrameLevel(rrframeLevel + 2)
	RaidRoll_Allow_All:SetFrameLevel(rrframeLevel + 2)
	RaidRollCheckBox_ExtraRolls:SetFrameLevel(rrframeLevel + 2)
	S:HandleCheckBox(RaidRoll_Catch_All)
	S:HandleCheckBox(RaidRoll_Allow_All)
	S:HandleCheckBox(RaidRollCheckBox_ExtraRolls)

	S:HandleButton(Raid_Roll_ClearSymbols)
	S:HandleButton(Raid_Roll_ClearRolls)
	S:HandleButton(RaidRoll_ExtraOptionButton)
end

local function LootTrackerSkin()
	if not E.private.addOnSkins.RaidRoll then return end

	RR_LOOT_FRAME:SetTemplate("Transparent")

	S:HandleSliderFrame(RaidRoll_Loot_Slider_ID)

	S:HandleButton(RR_Loot_LinkLootButton)
	S:HandleButton(RR_Loot_ButtonClear)
	S:HandleButton(RR_Loot_ButtonFirst)
	S:HandleButton(RR_Loot_ButtonPrev)
	S:HandleButton(RR_Loot_ButtonNext)
	S:HandleButton(RR_Loot_ButtonLast)

	for i = 1, 4 do
		_G["RR_Loot_Announce_1_Button_"..i]:Show()
		_G["RR_Loot_Announce_2_Button_"..i]:Show()
		_G["RR_Loot_Announce_3_Button_"..i]:Show()
		_G["RR_Loot_RaidRollButton_"..i]:Show()

		S:HandleButton(_G["RR_Loot_Announce_1_Button_"..i])
		S:HandleButton(_G["RR_Loot_Announce_2_Button_"..i])
		S:HandleButton(_G["RR_Loot_Announce_3_Button_"..i])
		S:HandleButton(_G["RR_Loot_RaidRollButton_"..i])
	end

	for i = 1, RR_LOOT_FRAME:GetNumChildren() do
		local child = select(i, RR_LOOT_FRAME:GetChildren())
		if child and child:IsObjectType("Button") and child:GetName() == "Close_Button" then
			S:HandleCloseButton(child)
		end
	end
end

S:AddCallbackForAddon("RaidRoll", "RaidRoll", LoadSkin)
S:AddCallbackForAddon("RaidRoll_LootTracker", "RaidRoll_LootTracker", LootTrackerSkin)