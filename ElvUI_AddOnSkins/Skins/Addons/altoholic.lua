local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")

local function LoadSkin()
	if not E.private.addOnSkins.Altoholic then return end

	local function AltoItem(item)
		local name = item:GetName()
		item:SetTemplate()
		item:StyleButton()

		item:SetNormalTexture("")
		_G[name.."IconTexture"]:SetInside()
		_G[name.."IconTexture"]:SetTexCoord(unpack(E.TexCoords))

		local cooldown = _G[name.."Cooldown"]
		if cooldown then
			E:RegisterCooldown(cooldown)
		end
	end

	AltoholicFrame:StripTextures()
	AltoholicFramePortrait:Kill()
	AltoholicFrame:CreateBackdrop("Transparent")
	AltoholicFrame.backdrop:Point("TOPLEFT", 11, -11)
	AltoholicFrame.backdrop:Point("BOTTOMRIGHT", 0, 9)

	for i = 1, 5 do
		S:HandleTab(_G["AltoholicFrameTab"..i])
	end

	S:HandleEditBox(AltoholicFrame_SearchEditBox)
	S:HandleButton(AltoholicFrame_ResetButton)
	AltoholicFrame_ResetButton:Point("TOPLEFT", "$parent_SearchEditBox", "BOTTOMLEFT", -40, -3)
	S:HandleButton(AltoholicFrame_SearchButton)
	S:HandleCloseButton(AltoholicFrameCloseButton)

	local function ClassesItemItemTexure_SetTexCoord(self, left, right, top, bottom)
		if self.customTexCoord then return end
		self.customTexCoord = true
		self:SetTexCoord(left + 0.02, right - 0.02, top + 0.02, bottom - 0.02)
		self.customTexCoord = nil
	end

	local function ClassesItem_OnShow(self)
		if self.border:IsShown() then
			self:SetBackdropBorderColor(self.border:GetVertexColor())
		else
			self:SetBackdropBorderColor(unpack(E.media.bordercolor))
		end

		local name = self:GetName()
		local icon = _G[self:GetName().."IconTexture"]
		icon:SetInside()

		self.border:SetTexture("")
	end

	for i = 1, 10 do
		local item = _G["AltoholicFrameClassesItem"..i]
		AltoItem(item)

		hooksecurefunc(_G[item:GetName().."IconTexture"], "SetTexCoord", ClassesItemItemTexure_SetTexCoord)

		item:HookScript("OnShow", ClassesItem_OnShow)
	end

	AltoMsgBox:SetTemplate("Transparent")
	S:HandleButton(AltoMsgBoxYesButton)
	S:HandleButton(AltoMsgBoxNoButton)

	AltoAccountSharing:SetTemplate("Transparent")

	S:HandleEditBox(AltoAccountSharing_AccNameEditBox)
	S:HandleButton(AltoAccountSharing_InfoButton)
	S:HandleEditBox(AltoAccountSharing_AccTargetEditBox)
	S:HandleButton(AltoAccountSharing_SendButton)
	S:HandleButton(AltoAccountSharing_CancelButton)

	AltoAccountSharing_ToggleAll:SetNormalTexture(E.Media.Textures.Minus)
	AltoAccountSharing_ToggleAll:SetPushedTexture(nil)
	AltoAccountSharing_ToggleAll:SetHighlightTexture(nil)
	hooksecurefunc(AltoAccountSharing_ToggleAll, "SetNormalTexture", function(_, tex)
		if tex == "Interface\\Buttons\\UI-MinusButton-Up" then
			AltoAccountSharing_ToggleAll:GetNormalTexture():SetTexture(E.Media.Textures.Minus)
		else
			AltoAccountSharing_ToggleAll:GetNormalTexture():SetTexture(E.Media.Textures.Plus)
		end
	end)

	S:HandleCheckBox(AltoAccountSharing_CheckAll)

	-- Reputations
	S:HandleDropDownBox(AltoholicFrameReputations_SelectFaction)
	AltoholicFrameReputationsScrollFrame:StripTextures()
	S:HandleScrollBar(AltoholicFrameReputationsScrollFrameScrollBar)

	-- Search
	AltoholicFrameSearchScrollFrame:StripTextures()
	S:HandleScrollBar(AltoholicFrameSearchScrollFrameScrollBar)

	-- Skills
	AltoholicFrameSkillsScrollFrame:StripTextures()
	S:HandleScrollBar(AltoholicFrameSkillsScrollFrameScrollBar)

	-- TabCharacters
	S:HandleDropDownBox(AltoholicTabCharacters_SelectRealm)
	S:HandleDropDownBox(AltoholicTabCharacters_SelectChar)
	
	local tabCharacters = {"_Bags", "_Equipment", "_Quests", "_Talents", "_Auctions", "_Bids", "_Mails", "_Pets", "_Mounts", "_Factions", "_Tokens", "_Cooking", "_FirstAid", "_Prof1", "_Prof2"}
	for _, tab in pairs(tabCharacters) do
		AltoItem(_G["AltoholicTabCharacters"..tab])
	end

	for i = 1, 4 do
		_G["AltoholicTabCharacters_Sort"..i]:StripTextures()
	end

	-- TabGuildBank
	S:HandleDropDownBox(AltoholicTabGuildBank_SelectGuild)
	S:HandleButton(AltoholicTabGuildBank_DeleteGuildButton)
	S:HandleCheckBox(AltoholicTabGuildBank_HideInTooltip)

	for i = 1, 6 do
		_G["AltoholicTabGuildBankMenuItem"..i]:StripTextures()
	end

	-- TabSearch
	for i = 1, 15 do
		_G["AltoholicTabSearchMenuItem"..i]:StripTextures()
	end

	AltoholicSearchMenuScrollFrame:StripTextures()
	S:HandleScrollBar(AltoholicSearchMenuScrollFrameScrollBar)
	S:HandleEditBox(AltoholicTabSearch_MinLevel)
	S:HandleEditBox(AltoholicTabSearch_MaxLevel)
	S:HandleDropDownBox(AltoholicTabSearch_SelectRarity)
	S:HandleDropDownBox(AltoholicTabSearch_SelectSlot, 140)
	S:HandleDropDownBox(AltoholicTabSearch_SelectLocation, 200)

	for i = 1, 8 do
		_G["AltoholicTabSearch_Sort"..i]:StripTextures()
	end

	-- TabSummary
	for i = 1, 8 do
		_G["AltoholicTabSummaryMenuItem"..i]:StripTextures()
		_G["AltoholicTabSummary_Sort"..i]:StripTextures()
	end

	AltoholicTabSummaryToggleView:SetNormalTexture(E.Media.Textures.Minus)
	AltoholicTabSummaryToggleView:SetPushedTexture(nil)
	AltoholicTabSummaryToggleView:SetHighlightTexture(nil)
	hooksecurefunc(AltoholicTabSummaryToggleView, "SetNormalTexture", function(_, tex)
		if tex == "Interface\\Buttons\\UI-MinusButton-Up" then
			AltoholicTabSummaryToggleView:GetNormalTexture():SetTexture(E.Media.Textures.Minus)
		else
			AltoholicTabSummaryToggleView:GetNormalTexture():SetTexture(E.Media.Textures.Plus)
		end
	end)

	S:HandleDropDownBox(AltoholicTabSummary_SelectLocation, 200)
	S:HandleButton(AltoholicTabSummary_OptionsDataStore)
	S:HandleButton(AltoholicTabSummary_Options)
	S:HandleButton(AltoholicTabSummary_RequestSharing)

	-- Telents
	for i = 1, 3 do
		AltoItem(_G["AltoholicFrameTalents_SpecIcon"..i])
	end

	S:HandleScrollBar(AltoholicFrameTalents_ScrollFrameScrollBar)

	for i = 1, 40 do
		AltoItem(_G["AltoholicFrameTalents_ScrollFrameTalent"..i])
	end
end

S:AddCallbackForAddon("Altoholic", "Altoholic", LoadSkin)