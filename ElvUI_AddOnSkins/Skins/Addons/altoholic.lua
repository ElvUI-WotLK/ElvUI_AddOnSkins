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

if not AS:IsAddonLODorEnabled("Altoholic") then return end

local _G = _G
local pairs = pairs
local unpack = unpack

local hooksecurefunc = hooksecurefunc

-- Altoholic 3.3.002b

S:AddCallbackForAddon("Altoholic", "Altoholic", function()
	if not E.private.addOnSkins.Altoholic then return end

	local function AltoItem(item)
		local name = item:GetName()
		SkinFrame(item, "SetTemplate")
		SkinFrame(item, "StyleButton")

		SkinFrame(item, "SetNormalTexture", "")
		SkinFrame(_G[name.."IconTexture"], "SetInside")
		SkinFrame(_G[name.."IconTexture"], "SetTexCoord", unpack(E.TexCoords))

		local cooldown = _G[name.."Cooldown"]
		if cooldown then
			E:RegisterCooldown(cooldown)
		end
	end

	SkinFrame(AltoTooltip, "HookScript", "OnShow", function(self)
		SkinFrame(self, "SetTemplate", "Transparent", nil, true) --ignore updates

		local r, g, b = self:GetBackdropColor()
		SkinFrame(self, "SetBackdropColor", r, g, b, E.db.tooltip.colorAlpha)
	end)

	SkinFrame(AltoholicFrame, "StripTextures")
	AltoholicFrame:CreateBackdrop("Transparent")
	AltoholicFrame.backdrop:Point("TOPLEFT", 11, -12)
	AltoholicFrame.backdrop:Point("BOTTOMRIGHT", -1, 11)

	SkinFrame(AltoholicFramePortrait, "Hide")

	SkinControl("HandleCloseButton", AltoholicFrameCloseButton, AltoholicFrame.backdrop)

	for i = 1, 5 do
		local tab = _G["AltoholicFrameTab"..i]

		if i == 1 then
			SkinFrame(tab, "Point", "TOPLEFT", AltoholicFrame, "BOTTOMLEFT", 11, 13)
		else
			SkinFrame(tab, "Point", "TOPLEFT", _G["AltoholicFrameTab"..(i - 1)], "TOPRIGHT", -15, 0)
		end

		SkinControl("HandleTab", tab)
	end

	SkinControl("HandleEditBox", AltoholicFrame_SearchEditBox)
	SkinControl("HandleButton", AltoholicFrame_ResetButton)
	SkinFrame(AltoholicFrame_ResetButton, "Point", "TOPLEFT", "$parent_SearchEditBox", "BOTTOMLEFT", -40, -3)
	SkinControl("HandleButton", AltoholicFrame_SearchButton)

	local function ClassesItemItemTexure_SetTexCoord(self, left, right, top, bottom)
		if self.customTexCoord then return end
		self.customTexCoord = true
		SkinFrame(self, "SetTexCoord", left + 0.02, right - 0.02, top + 0.02, bottom - 0.02)
		self.customTexCoord = nil
	end

	local function ClassesItem_OnShow(self)
		if self.border:IsShown() then
			SkinFrame(self, "SetBackdropBorderColor", self.border:GetVertexColor())
		else
			SkinFrame(self, "SetBackdropBorderColor", unpack(E.media.bordercolor))
		end

		SkinFrame(_G[self:GetName().."IconTexture"], "SetInside")

		self.border:SetTexture("")
	end

	for i = 1, 10 do
		local item = _G["AltoholicFrameClassesItem"..i]
		AltoItem(item)

		hooksecurefunc(_G[item:GetName().."IconTexture"], "SetTexCoord", ClassesItemItemTexure_SetTexCoord)

		SkinFrame(item, "HookScript", "OnShow", ClassesItem_OnShow)
	end

	SkinFrame(AltoMsgBox, "SetTemplate", "Transparent")
	SkinControl("HandleButton", AltoMsgBoxYesButton)
	SkinControl("HandleButton", AltoMsgBoxNoButton)

	SkinFrame(AltoAccountSharing, "SetTemplate", "Transparent")

	SkinControl("HandleEditBox", AltoAccountSharing_AccNameEditBox)
	SkinControl("HandleButton", AltoAccountSharing_InfoButton)
	SkinControl("HandleEditBox", AltoAccountSharing_AccTargetEditBox)
	SkinControl("HandleButton", AltoAccountSharing_SendButton)
	SkinControl("HandleButton", AltoAccountSharing_CancelButton)

	SkinControl("HandleCollapseExpandButton", AltoAccountSharing_ToggleAll, "-")

	SkinControl("HandleCheckBox", AltoAccountSharing_CheckAll)

	-- AccountSummary
	SkinFrame(AltoholicFrameSummaryScrollFrame, "StripTextures")
	SkinControl("HandleScrollBar", AltoholicFrameSummaryScrollFrameScrollBar)

	for i = 1, 14 do
		SkinControl("HandleCollapseExpandButton", _G["AltoholicFrameSummaryEntry"..i.."Collapse"], "-")
	end

	-- Activity
	SkinFrame(AltoholicFrameActivityScrollFrame, "StripTextures")
	SkinControl("HandleScrollBar", AltoholicFrameActivityScrollFrameScrollBar)

	for i = 1, 14 do
		SkinControl("HandleCollapseExpandButton", _G["AltoholicFrameActivityEntry"..i.."Collapse"], "-")
	end

	-- AuctionHouse
	SkinFrame(AltoholicFrameAuctionsScrollFrame, "StripTextures")
	SkinControl("HandleScrollBar", AltoholicFrameAuctionsScrollFrameScrollBar)

	for i = 1, 7 do
		AltoItem(_G["AltoholicFrameAuctionsEntry"..i.."Item"])
	end

	-- BagUsage
	SkinFrame(AltoholicFrameBagUsageScrollFrame, "StripTextures")
	SkinControl("HandleScrollBar", AltoholicFrameBagUsageScrollFrameScrollBar)

	for i = 1, 14 do
		SkinControl("HandleCollapseExpandButton", _G["AltoholicFrameBagUsageEntry"..i.."Collapse"], "-")
	end

	-- Calendar
	SkinControl("HandleNextPrevButton", AltoholicFrameCalendar_PrevMonth)
	SkinControl("HandleNextPrevButton", AltoholicFrameCalendar_NextMonth)

	SkinFrame(AltoholicFrameCalendarScrollFrame, "StripTextures")
	SkinControl("HandleScrollBar", AltoholicFrameCalendarScrollFrameScrollBar)

	-- Containers
	SkinControl("HandleDropDownBox", AltoholicFrameContainers_SelectContainerView)
	SkinControl("HandleDropDownBox", AltoholicFrameContainers_SelectRarity)

	SkinFrame(AltoholicFrameContainersScrollFrame, "StripTextures")
	SkinControl("HandleScrollBar", AltoholicFrameContainersScrollFrameScrollBar)

	for i = 1, 7 do
		for j = 1, 14 do
			AltoItem(_G["AltoholicFrameContainersEntry"..i.."Item"..j])
		end
	end

	-- Currencies
	SkinControl("HandleDropDownBox", AltoholicFrameCurrencies_SelectCurrencies)

	SkinFrame(AltoholicFrameCurrenciesScrollFrame, "StripTextures")
	SkinControl("HandleScrollBar", AltoholicFrameCurrenciesScrollFrameScrollBar)

--[[
	for i = 1, 8 do
		for j = 1, 10 do
			_G["AltoholicFrameCurrenciesEntry"..i.."Item"..j]
		end
	end
]]

	-- Equipment
	SkinFrame(AltoholicFrameEquipmentScrollFrame, "StripTextures")
	SkinControl("HandleScrollBar", AltoholicFrameEquipmentScrollFrameScrollBar)

	for i = 1, 7 do
		for j = 1, 10 do
			AltoItem(_G["AltoholicFrameEquipmentEntry"..i.."Item"..j])
		end
	end

	-- GuildBank
	for i = 1, 7 do
		for j = 1, 14 do
			AltoItem(_G["AltoGuildBankEntry"..i.."Item"..j])
		end
	end

	-- GuildBankTabs
	SkinFrame(AltoholicFrameGuildBankTabsScrollFrame, "StripTextures")
	SkinControl("HandleScrollBar", AltoholicFrameGuildBankTabsScrollFrameScrollBar)

	for i = 1, 14 do
		SkinControl("HandleCollapseExpandButton", _G["AltoholicFrameGuildBankTabsEntry"..i.."Collapse"], "-")
		SkinControl("HandleButton", _G["AltoholicFrameGuildBankTabsEntry"..i.."UpdateTab"])
	end

	-- GuildMembers
	SkinFrame(AltoholicFrameGuildMembersScrollFrame, "StripTextures")
	SkinControl("HandleScrollBar", AltoholicFrameGuildMembersScrollFrameScrollBar)

	for i = 1, 14 do
		SkinControl("HandleCollapseExpandButton", _G["AltoholicFrameGuildMembersEntry"..i.."Collapse"], "-")
	end

	for i = 1, 19 do
		AltoItem(_G["AltoholicFrameGuildMembersItem"..i])
	end

	-- GuildProfessions
	SkinFrame(AltoholicFrameGuildProfessionsScrollFrame, "StripTextures")
	SkinControl("HandleScrollBar", AltoholicFrameGuildProfessionsScrollFrameScrollBar)

	for i = 1, 14 do
		SkinControl("HandleCollapseExpandButton", _G["AltoholicFrameGuildProfessionsEntry"..i.."Collapse"], "-")
	end

	-- Mails
	SkinFrame(AltoholicFrameMailScrollFrame, "StripTextures")
	SkinControl("HandleScrollBar", AltoholicFrameMailScrollFrameScrollBar)

	for i = 1, 7 do
		AltoItem(_G["AltoholicFrameMailEntry"..i.."Item"])
	end

	-- Pets
	SkinControl("HandleDropDownBox", AltoholicFramePets_SelectPetView)
	SkinControl("HandleRotateButton", AltoholicFramePetsNormal_ModelFrameRotateLeftButton)
	SkinControl("HandleRotateButton", AltoholicFramePetsNormal_ModelFrameRotateRightButton)

	for i = 1, 12 do
		local button = _G["AltoholicFramePetsNormal_Button"..i]
		SkinFrame(button, "SetTemplate")
		SkinFrame(button, "StyleButton", nil, true)
		button:GetDisabledTexture():SetInside()
		SkinFrame(button, "SetNormalTexture", "")
		button:GetNormalTexture():SetDrawLayer("BORDER")
		button:GetNormalTexture():SetInside()
		button:GetNormalTexture():SetTexCoord(unpack(E.TexCoords))
	end

	SkinControl("HandleNextPrevButton", AltoholicFramePetsNormalPrevPage, nil, nil, true)
	SkinFrame(AltoholicFramePetsNormalPrevPage, "Size", 32)
	SkinControl("HandleNextPrevButton", AltoholicFramePetsNormalNextPage, nil, nil, true)
	SkinFrame(AltoholicFramePetsNormalNextPage, "Size", 32)

	SkinFrame(AltoholicFramePetsAllInOneScrollFrame, "StripTextures")
	SkinControl("HandleScrollBar", AltoholicFramePetsAllInOneScrollFrameScrollBar)

	-- Quests
	SkinFrame(AltoholicFrameQuestsScrollFrame, "StripTextures")
	SkinControl("HandleScrollBar", AltoholicFrameQuestsScrollFrameScrollBar)

	for i = 1, 14 do
		SkinControl("HandleCollapseExpandButton", _G["AltoholicFrameQuestsEntry"..i.."Collapse"], "-")
	end

	-- Recipes
	SkinControl("HandleCollapseExpandButton", AltoholicFrameRecipesInfo_ToggleAll, "-")
	SkinControl("HandleDropDownBox", AltoholicFrameRecipesInfo_SelectColor)
	SkinControl("HandleDropDownBox", AltoholicFrameRecipesInfo_SelectSubclass)
	SkinControl("HandleDropDownBox", AltoholicFrameRecipesInfo_SelectInvSlot)

	SkinFrame(AltoholicFrameRecipesScrollFrame, "StripTextures")
	SkinControl("HandleScrollBar", AltoholicFrameRecipesScrollFrameScrollBar)

	for i = 1, 14 do
		SkinControl("HandleCollapseExpandButton", _G["AltoholicFrameRecipesEntry"..i.."Collapse"], "-")
		AltoItem(_G["AltoholicFrameRecipesEntry"..i.."Craft"])

		for j = 1, 8 do
			AltoItem(_G["AltoholicFrameRecipesEntry"..i.."Item"..j])
		end
	end

	-- Reputations
	SkinControl("HandleDropDownBox", AltoholicFrameReputations_SelectFaction)
	SkinFrame(AltoholicFrameReputationsScrollFrame, "StripTextures")
	SkinControl("HandleScrollBar", AltoholicFrameReputationsScrollFrameScrollBar)

	for i = 1, 8 do
		for j = 1, 10 do
			local item = _G["AltoholicFrameReputationsEntry"..i.."Item"..j]
			local bg = _G["AltoholicFrameReputationsEntry"..i.."Item"..j.."_Background"]

			SkinFrame(item, "SetTemplate")
			SkinFrame(item, "StyleButton")

			bg:SetDrawLayer("BORDER")
			SkinFrame(bg, "SetInside")
			SkinFrame(bg, "SetTexCoord", unpack(E.TexCoords))
		end
	end

	-- Search
	SkinFrame(AltoholicFrameSearchScrollFrame, "StripTextures")
	SkinControl("HandleScrollBar", AltoholicFrameSearchScrollFrameScrollBar)

	for i = 1, 7 do
		E:RegisterCooldown(_G["AltoholicFrameSearchEntry"..i.."Cooldown"])
		AltoItem(_G["AltoholicFrameSearchEntry"..i.."Item"])
	end

	-- Skills
	SkinFrame(AltoholicFrameSkillsScrollFrame, "StripTextures")
	SkinControl("HandleScrollBar", AltoholicFrameSkillsScrollFrameScrollBar)

	for i = 1, 14 do
		SkinControl("HandleCollapseExpandButton", _G["AltoholicFrameSkillsEntry"..i.."Collapse"], "-")
	end

	-- TabCharacters
	SkinControl("HandleDropDownBox", AltoholicTabCharacters_SelectRealm)
	SkinControl("HandleDropDownBox", AltoholicTabCharacters_SelectChar)

	local tabCharacters = {"_Bags", "_Equipment", "_Quests", "_Talents", "_Auctions", "_Bids", "_Mails", "_Pets", "_Mounts", "_Factions", "_Tokens", "_Cooking", "_FirstAid", "_Prof1", "_Prof2"}
	for _, tab in pairs(tabCharacters) do
		AltoItem(_G["AltoholicTabCharacters"..tab])
	end

	for i = 1, 4 do
		SkinFrame(_G["AltoholicTabCharacters_Sort"..i], "StripTextures")
	end

	-- TabGuildBank
	SkinControl("HandleDropDownBox", AltoholicTabGuildBank_SelectGuild)
	SkinControl("HandleButton", AltoholicTabGuildBank_DeleteGuildButton)
	SkinControl("HandleCheckBox", AltoholicTabGuildBank_HideInTooltip)

	for i = 1, 6 do
		SkinFrame(_G["AltoholicTabGuildBankMenuItem"..i], "StripTextures")
	end

	-- TabSearch
	for i = 1, 15 do
		SkinFrame(_G["AltoholicTabSearchMenuItem"..i], "StripTextures")
	end

	SkinFrame(AltoholicSearchMenuScrollFrame, "StripTextures")
	SkinControl("HandleScrollBar", AltoholicSearchMenuScrollFrameScrollBar)
	SkinControl("HandleEditBox", AltoholicTabSearch_MinLevel)
	SkinControl("HandleEditBox", AltoholicTabSearch_MaxLevel)
	SkinControl("HandleDropDownBox", AltoholicTabSearch_SelectRarity)
	SkinControl("HandleDropDownBox", AltoholicTabSearch_SelectSlot, 140)
	SkinControl("HandleDropDownBox", AltoholicTabSearch_SelectLocation, 200)

	for i = 1, 8 do
		SkinFrame(_G["AltoholicTabSearch_Sort"..i], "StripTextures")
	end

	-- TabSummary
	for i = 1, 8 do
		SkinFrame(_G["AltoholicTabSummaryMenuItem"..i], "StripTextures")
		SkinFrame(_G["AltoholicTabSummary_Sort"..i], "StripTextures")
	end

	SkinControl("HandleCollapseExpandButton", AltoholicTabSummaryToggleView, "-")

	SkinControl("HandleDropDownBox", AltoholicTabSummary_SelectLocation, 200)
	SkinControl("HandleButton", AltoholicTabSummary_OptionsDataStore)
	SkinControl("HandleButton", AltoholicTabSummary_Options)
	SkinControl("HandleButton", AltoholicTabSummary_RequestSharing)

	-- Telents
	for i = 1, 3 do
		AltoItem(_G["AltoholicFrameTalents_SpecIcon"..i])
	end

	SkinControl("HandleScrollBar", AltoholicFrameTalents_ScrollFrameScrollBar)

	for i = 1, 40 do
		AltoItem(_G["AltoholicFrameTalents_ScrollFrameTalent"..i])
	end
end)

S:AddCallbackForAddon("Altoholic_Achievements", "Altoholic_Achievements", function()
	if not E.private.addOnSkins.Altoholic then return end

	SkinFrame(AltoholicFrameAchievementsScrollFrame, "StripTextures")
	SkinControl("HandleScrollBar", AltoholicFrameAchievementsScrollFrameScrollBar)

	for i = 1, 8 do
		for j = 1, 10 do
			SkinFrame(_G["AltoholicFrameAchievementsEntry"..i.."Item"..j], "SetTemplate")
			SkinFrame(_G["AltoholicFrameAchievementsEntry"..i.."Item"..j], "StyleButton")
			_G["AltoholicFrameAchievementsEntry"..i.."Item"..j.."_Background"]:SetDrawLayer("BORDER")
			SkinFrame(_G["AltoholicFrameAchievementsEntry"..i.."Item"..j.."_Background"], "SetInside")
			SkinFrame(_G["AltoholicFrameAchievementsEntry"..i.."Item"..j.."_Background"], "SetTexCoord", unpack(E.TexCoords))
		end
	end

	for i = 1, 15 do
		SkinFrame(_G["AltoholicTabAchievementsMenuItem"..i], "StripTextures")
	end

	SkinFrame(AltoholicAchievementsMenuScrollFrame, "StripTextures")
	SkinControl("HandleScrollBar", AltoholicAchievementsMenuScrollFrameScrollBar)
end)
