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

if not AS:IsAddonLODorEnabled("RaidRoll") then return end

-- RaidRoll 4.4.15
-- https://www.curseforge.com/wow/addons/raid-roll/files/450070

S:AddCallbackForAddon("RaidRoll", "RaidRoll", function()
	if not E.private.addOnSkins.RaidRoll then return end

	SkinFrame(RR_RollFrame, "SetTemplate", "Transparent")
	SkinFrame(RR_NAME_FRAME, "SetTemplate", "Default")

	SkinControl("HandleCloseButton", RR_Close_Button, RR_RollFrame)

	RaidRoll_Slider_ID:SetHitRectInsets(0, 0, 0, 0)
	SkinControl("HandleSliderFrame", RaidRoll_Slider_ID)

	SkinControl("HandleButton", RaidRoll_AnnounceWinnerButton)
	SkinControl("HandleButton", RR_Roll_5SecAndAnnounce)
	SkinControl("HandleButton", RR_Roll_RollButton)
	SkinControl("HandleButton", RR_Last)
	SkinControl("HandleButton", RR_Clear)
	SkinControl("HandleButton", RR_Next)
	SkinControl("HandleButton", RaidRoll_OptionButton)

	SkinFrame(RR_Roll_5SecAndAnnounce, "ClearAllPoints")
	SkinFrame(RR_Roll_5SecAndAnnounce, "Point", "BOTTOM", 0, 31)

	SkinFrame(RR_Clear, "Point", "BOTTOM", 0, 8)
	SkinFrame(RR_Last, "Point", "BOTTOM", -45, 8)
	SkinFrame(RR_Roll_RollButton, "Point", "BOTTOMRIGHT", RR_RollFrame, "BOTTOM", -65, 8)
	SkinFrame(RR_Next, "Point", "BOTTOM", 45, 8)
	SkinFrame(RaidRoll_OptionButton, "Size", 20)
	SkinFrame(RaidRoll_OptionButton, "Point", "BOTTOM", 75, 8)

	SkinFrame(RR_Frame, "SetTemplate", "Transparent")
	SkinFrame(RR_Frame, "Width", 185)
	SkinFrame(RR_Frame, "Point", "TOP", RR_RollFrame, "BOTTOM", 0, 1)

	local rrframeLevel = RR_Frame:GetFrameLevel()
	SkinFrame(RaidRoll_Catch_All, "SetFrameLevel", rrframeLevel + 2)
	SkinFrame(RaidRoll_Allow_All, "SetFrameLevel", rrframeLevel + 2)
	SkinFrame(RaidRollCheckBox_ExtraRolls, "SetFrameLevel", rrframeLevel + 2)
	SkinControl("HandleCheckBox", RaidRoll_Catch_All)
	SkinControl("HandleCheckBox", RaidRoll_Allow_All)
	SkinControl("HandleCheckBox", RaidRollCheckBox_ExtraRolls)

	SkinControl("HandleButton", Raid_Roll_ClearSymbols)
	SkinControl("HandleButton", Raid_Roll_ClearRolls)
	SkinControl("HandleButton", RaidRoll_ExtraOptionButton)

	for i = 1, 5 do
		local f = _G["Raid_Roll_SetSymbol"..i]
		SkinFrame(f, "ClearAllPoints")
		SkinFrame(f, "Point", "TOPLEFT", _G["RR_RollerPos"..i], "TOPRIGHT", -15, -1)
		SkinFrame(f, "Point", "BOTTOMRIGHT", _G["RR_Rolled"..i], "BOTTOMLEFT", 45, -1)

		local highlight = f:GetHighlightTexture()
		highlight:SetTexture(E.Media.Textures.Highlight)
		highlight:SetVertexColor(0.9, 0.9, 0.9, 0.35)
	end

	if E.private.general.replaceBlizzFonts and GetLocale() ~= "zhCN" then
		local fontTemplate = RR_Roller1.FontTemplate
		local function updateFont(self, font, size, flag)
			self.SetFont = nil
			fontTemplate(self, nil, nil, flag)
			self.SetFont = updateFont
		end

		for i = 1, 5 do
			_G["RR_Roller"..i].SetFont = updateFont
		end
	end
end)

S:AddCallbackForAddon("RaidRoll_LootTracker", "RaidRoll_LootTracker", function()
	if not E.private.addOnSkins.RaidRoll then return end

	SkinFrame(RR_LOOT_FRAME, "SetTemplate", "Transparent")

	SkinControl("HandleSliderFrame", RaidRoll_Loot_Slider_ID)

	SkinControl("HandleButton", RR_Loot_LinkLootButton)
	SkinControl("HandleButton", RR_Loot_ButtonClear)
	SkinControl("HandleButton", RR_Loot_ButtonFirst)
	SkinControl("HandleButton", RR_Loot_ButtonPrev)
	SkinControl("HandleButton", RR_Loot_ButtonNext)
	SkinControl("HandleButton", RR_Loot_ButtonLast)

	for i = 1, 4 do
		SkinFrame(_G["RR_Loot_Announce_1_Button_"..i], "Show")
		SkinFrame(_G["RR_Loot_Announce_2_Button_"..i], "Show")
		SkinFrame(_G["RR_Loot_Announce_3_Button_"..i], "Show")
		SkinFrame(_G["RR_Loot_RaidRollButton_"..i], "Show")

		SkinControl("HandleButton", _G["RR_Loot_Announce_1_Button_"..i])
		SkinControl("HandleButton", _G["RR_Loot_Announce_2_Button_"..i])
		SkinControl("HandleButton", _G["RR_Loot_Announce_3_Button_"..i])
		SkinControl("HandleButton", _G["RR_Loot_RaidRollButton_"..i])
	end

	for i = 1, RR_LOOT_FRAME:GetNumChildren() do
		local child = select(i, RR_LOOT_FRAME:GetChildren())
		if child and child:IsObjectType("Button") and child:GetName() == "Close_Button" then
			SkinControl("HandleCloseButton", child)
			break
		end
	end
end)
