local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

if not AS:IsAddonLODorEnabled("QuestGuru") then return end

local _G = _G
local select = select
local unpack = unpack

local GetItemInfo = GetItemInfo
local GetItemQualityColor = GetItemQualityColor
local GetQuestLogChoiceInfo = GetQuestLogChoiceInfo
local hooksecurefunc = hooksecurefunc

-- QuestGuru 1.4.1

S:AddCallbackForAddon("QuestGuru", "QuestGuru", function()
	if not E.private.addOnSkins.QuestGuru then return end

	local origCount = QUESTGURU_QUESTS_DISPLAYED
	QUESTS_DISPLAYED = 21
	QUESTGURU_QUESTS_DISPLAYED = 21

	for i = QUESTS_DISPLAYED + 1, origCount do
		_G["QuestGuru_QuestLogTitle"..i]:Hide()
		_G["QuestGuru_QuestAbandonTitle"..i]:Hide()
	end

	QuestGuru_UpdateGossipFrame = E.noop
	QuestGuru_UpdateProgressFrame = E.noop
	QuestGuru_UpdateDetailFrame = E.noop
	QuestGuru_QuestFrameGreetingPanel_OnShow = E.noop

	QuestGuru_QuestLogFrame:Size(682, 447)

	if not QuestGuru_QuestLogFrame.backdrop then
		QuestGuru_QuestLogFrame:StripTextures()
		QuestGuru_QuestLogFrame:CreateBackdrop("Transparent")
		QuestGuru_QuestLogFrame.backdrop:Point("TOPLEFT", 11, -12)
		QuestGuru_QuestLogFrame.backdrop:Point("BOTTOMRIGHT", -1, 11)
	end

	S:SetUIPanelWindowInfo(QuestGuru_QuestLogFrame, "xoffset", -50)

	S:HandleCloseButton(QuestGuru_QuestLogFrameCloseButton, QuestLogFrame.backdrop)

	QuestGuru_QuestLogTitleText:Point("TOP", 0, -16)

	QuestGuruShowMapButton:StripTextures()
	S:HandleButton(QuestGuruShowMapButton)
	QuestGuruShowMapButton:Width(82)
	QuestGuruShowMapButton:Point("TOPRIGHT", 1, 32)
	QuestGuruShowMapButton.text:ClearAllPoints()
	QuestGuruShowMapButton.text:SetPoint("CENTER")

	QuestGuru_QuestLogCount:StripTextures()
	QuestGuru_QuestLogCount:Point("TOPRIGHT", -118, -23)
	QuestGuru_QuestLogCount.SetPoint = E.noop
	QuestGuru_QuestLogCount:CreateBackdrop("Transparent")
	QuestGuru_QuestLogCount.backdrop:Point("TOPLEFT", -1, 0)
	QuestGuru_QuestLogCount.backdrop:Point("BOTTOMRIGHT", 1, -4)

	S:HandleButton(QuestGuru_QuestFrameExpandCollapseButton)
	QuestGuru_QuestFrameExpandCollapseButton:Point("TOPLEFT", 19, -39)

	QuestGuru_QuestLogFrameTab1:StripTextures()
	QuestGuru_QuestLogFrameTab1:SetTemplate()
	QuestGuru_QuestLogFrameTab1:Height(24)
	QuestGuru_QuestLogFrameTab1:Point("TOPLEFT", 40, -35)
	QuestGuru_QuestLogFrameTab1.SetPoint = E.noop
	QuestGuru_QuestLogFrameTab1:SetHitRectInsets(0, 0, 0, 0)
	QuestGuru_QuestLogFrameTab1:HookScript("OnEnter", S.SetModifiedBackdrop)
	QuestGuru_QuestLogFrameTab1:HookScript("OnLeave", S.SetOriginalBackdrop)

	QuestGuru_QuestLogFrameTab2:StripTextures()
	QuestGuru_QuestLogFrameTab2:SetTemplate()
	QuestGuru_QuestLogFrameTab2:Height(24)
	QuestGuru_QuestLogFrameTab2:Point("LEFT", QuestGuru_QuestLogFrameTab1, "RIGHT", 1, 0)
	QuestGuru_QuestLogFrameTab2.SetPoint = E.noop
	QuestGuru_QuestLogFrameTab2:SetHitRectInsets(0, 0, 0, 0)
	QuestGuru_QuestLogFrameTab2:HookScript("OnEnter", S.SetModifiedBackdrop)
	QuestGuru_QuestLogFrameTab2:HookScript("OnLeave", S.SetOriginalBackdrop)

	QuestGuru_QuestLogTitle1:ClearAllPoints()
	QuestGuru_QuestLogTitle1:SetPoint("TOPLEFT", QuestGuru_QuestLogListScrollFrame)

	QuestGuru_QuestLogListScrollFrame:Size(305, 335)
	QuestGuru_QuestLogListScrollFrame:ClearAllPoints()
	QuestGuru_QuestLogListScrollFrame:Point("TOPLEFT", QuestGuru_QuestLogFrame, 19, -62)
	QuestGuru_QuestLogListScrollFrame:CreateBackdrop("Transparent")
	QuestGuru_QuestLogListScrollFrame.backdrop:Point("TOPLEFT", 0, 2)
	QuestGuru_QuestLogListScrollFrame.backdrop:Point("BOTTOMRIGHT", 0, -2)
	QuestGuru_QuestLogListScrollFrame:Show()
	QuestGuru_QuestLogListScrollFrame.Hide = QuestGuru_QuestLogListScrollFrame.Show

	S:HandleScrollBar(QuestGuru_QuestLogListScrollFrameScrollBar)
	QuestGuru_QuestLogListScrollFrameScrollBar:Point("TOPLEFT", QuestGuru_QuestLogListScrollFrame, "TOPRIGHT", 3, -17)
	QuestGuru_QuestLogListScrollFrameScrollBar:Point("BOTTOMLEFT", QuestGuru_QuestLogListScrollFrame, "BOTTOMRIGHT", 3, 17)

	QuestGuru_QuestLogDetailScrollFrame:Size(304, 336)
	QuestGuru_QuestLogDetailScrollFrame:ClearAllPoints()
	QuestGuru_QuestLogDetailScrollFrame:Point("TOPRIGHT", QuestGuru_QuestLogFrame, -30, -61)
	QuestGuru_QuestLogDetailScrollFrame:StripTextures()
	QuestGuru_QuestLogDetailScrollFrame:CreateBackdrop("Transparent")
	QuestGuru_QuestLogDetailScrollFrame.backdrop:Point("TOPLEFT", 0, 1)
	QuestGuru_QuestLogDetailScrollFrame.backdrop:Point("BOTTOMRIGHT", 0, -2)

	S:HandleScrollBar(QuestGuru_QuestLogDetailScrollFrameScrollBar)
	QuestGuru_QuestLogDetailScrollFrameScrollBar:Point("TOPLEFT", QuestGuru_QuestLogDetailScrollFrame, "TOPRIGHT", 3, -18)
	QuestGuru_QuestLogDetailScrollFrameScrollBar:Point("BOTTOMLEFT", QuestGuru_QuestLogDetailScrollFrame, "BOTTOMRIGHT", 3, 17)

	S:HandleButton(QuestGuru_QuestLogFrameAbandonButton)
	S:HandleButton(QuestGuru_QuestFramePushQuestButton)
	S:HandleButton(QuestGuru_QuestFrameOptionsButton)
	S:HandleButton(QuestGuru_QuestFrameExitButton)

	QuestGuru_QuestLogFrameAbandonButton:Height(22)
	QuestGuru_QuestFramePushQuestButton:Height(22)
	QuestGuru_QuestFrameOptionsButton:Height(22)
	QuestGuru_QuestFrameExitButton:Height(22)

	QuestGuru_QuestLogFrameAbandonButton:Point("BOTTOMLEFT", QuestGuru_QuestLogFrame, "BOTTOMLEFT", 19, 19)
	QuestGuru_QuestFramePushQuestButton:Point("LEFT", QuestGuru_QuestLogFrameAbandonButton, "RIGHT", 3, 0)

	QuestGuru_QuestFrameExitButton:Point("BOTTOMRIGHT", -9, 19)
	QuestGuru_QuestFrameOptionsButton:Point("RIGHT", QuestGuru_QuestFrameExitButton, "LEFT", -3, 0)

	-- Abandoned
	QuestGuru_QuestAbandonTitle1:ClearAllPoints()
	QuestGuru_QuestAbandonTitle1:SetPoint("TOPLEFT", QuestGuru_QuestAbandonListScrollFrame)

	QuestGuru_QuestAbandonListScrollFrame:Size(305, 335)
	QuestGuru_QuestAbandonListScrollFrame:ClearAllPoints()
	QuestGuru_QuestAbandonListScrollFrame:Point("TOPLEFT", QuestGuru_QuestLogFrame, 19, -62)
	QuestGuru_QuestAbandonListScrollFrame:CreateBackdrop("Transparent")
	QuestGuru_QuestAbandonListScrollFrame.backdrop:Point("TOPLEFT", 0, 2)
	QuestGuru_QuestAbandonListScrollFrame.backdrop:Point("BOTTOMRIGHT", 0, -2)
	QuestGuru_QuestAbandonListScrollFrame:Show()
	QuestGuru_QuestAbandonListScrollFrame.Hide = QuestGuru_QuestAbandonListScrollFrame.Show

	S:HandleScrollBar(QuestGuru_QuestAbandonListScrollFrameScrollBar)
	QuestGuru_QuestAbandonListScrollFrameScrollBar:Point("TOPLEFT", QuestGuru_QuestAbandonListScrollFrame, "TOPRIGHT", 3, -17)
	QuestGuru_QuestAbandonListScrollFrameScrollBar:Point("BOTTOMLEFT", QuestGuru_QuestAbandonListScrollFrame, "BOTTOMRIGHT", 3, 17)

	QuestGuru_QuestAbandonDetailScrollFrame:Size(304, 336)
	QuestGuru_QuestAbandonDetailScrollFrame:ClearAllPoints()
	QuestGuru_QuestAbandonDetailScrollFrame:Point("TOPRIGHT", QuestGuru_QuestLogFrame, -30, -61)
	QuestGuru_QuestAbandonDetailScrollFrame:StripTextures()
	QuestGuru_QuestAbandonDetailScrollFrame:CreateBackdrop("Transparent")
	QuestGuru_QuestAbandonDetailScrollFrame.backdrop:Point("TOPLEFT", 0, 1)
	QuestGuru_QuestAbandonDetailScrollFrame.backdrop:Point("BOTTOMRIGHT", 0, -2)

	S:HandleScrollBar(QuestGuru_QuestAbandonDetailScrollFrameScrollBar)
	QuestGuru_QuestAbandonDetailScrollFrameScrollBar:Point("TOPLEFT", QuestGuru_QuestAbandonDetailScrollFrame, "TOPRIGHT", 3, -18)
	QuestGuru_QuestAbandonDetailScrollFrameScrollBar:Point("BOTTOMLEFT", QuestGuru_QuestAbandonDetailScrollFrame, "BOTTOMRIGHT", 3, 17)

	S:HandleEditBox(QuestGuru_QuestAbandonSearch)
	QuestGuru_QuestAbandonSearch:Point("LEFT", QuestGuru_QuestAbandonSearchText, "RIGHT", 4, -1)

	S:HandleButton(QuestGuru_QuestAbandonClearList)
	QuestGuru_QuestAbandonClearList:Height(22)
	QuestGuru_QuestAbandonClearList:Point("LEFT", QuestGuru_QuestAbandonSearch, "RIGHT", 8, 0)

	local function skinOptions(f)
		for i = 1, f:GetNumChildren() do
			local child = select(i, f:GetChildren())
			if child then
				if child:IsObjectType("CheckButton") then
					S:HandleCheckBox(child)
				elseif child:IsObjectType("EditBox") then
					S:HandleEditBox(child)
				elseif child:IsObjectType("Button") then
					S:HandleButton(child)
				elseif child:IsObjectType("Frame") then
					S:HandleDropDownBox(child, 240)
				end
			end
		end
	end

	skinOptions(QuestGuru_OptionsFrameGeneral)
	skinOptions(QuestGuru_OptionsFrameSound)
	skinOptions(QuestGuru_AnnounceFrame)

	local function skinLogEntry(questLogTitle, index)
		questLogTitle:Width(300)

		if index > 1 then
			questLogTitle:SetPoint("TOPLEFT", _G["QuestGuru_QuestLogTitle"..(index-1)], "BOTTOMLEFT", 0, 0)
		end

		if questLogTitle.check then
			questLogTitle.check:CreateBackdrop()
			questLogTitle.check.backdrop:SetInside()
			questLogTitle.check:SetNormalTexture(nil)
			questLogTitle.check:SetPushedTexture(nil)
			questLogTitle.check:SetHighlightTexture(nil)
		end

		S:HandleCollapseExpandButton(questLogTitle)
	end

	for i = 1, QUESTS_DISPLAYED do
		skinLogEntry(_G["QuestGuru_QuestLogTitle"..i], i)
		skinLogEntry(_G["QuestGuru_QuestAbandonTitle"..i], i)
	end

	-- QuestStart Tooltip
	QuestGuru_QuestStartInfoFrame:StripTextures()
	QuestGuru_QuestStartInfoFrame:SetTemplate("Transparent")

	-- Quest items
	local function updateItemQuality(self, texture)
		if self.parent.link or self.parent.type == "choice" then
			local quality

			if self.parent.link then
				quality = select(3, GetItemInfo(self.parent.link))
			elseif self.parent.type == "choice" then
				quality = select(4, GetQuestLogChoiceInfo(self.parent:GetID()))
			end

			if quality then
				local r, g, b = GetItemQualityColor(quality)

				self.parent:SetBackdropBorderColor(r, g, b)
				self.parent.backdrop:SetBackdropBorderColor(r, g, b)

				self.parent.text:SetTextColor(r, g, b)
			else
				self.parent:SetBackdropBorderColor(unpack(E.media.bordercolor))
				self.parent.backdrop:SetBackdropBorderColor(unpack(E.media.bordercolor))

				self.parent.text:SetTextColor(1, 1, 1)
			end
		end
	end

	local items = {
		["QuestGuru_QuestLogItem"] = 10,
		["QuestGuru_QuestLogObjectiveItem"] = 10,
		["QuestGuru_QuestAbandonItem"] = 10,
	}
	for frame, numItems in pairs(items) do
		for i = 1, numItems do
			local item = _G[frame..i]
			local icon = _G[frame..i.."IconTexture"]
			local count = _G[frame..i.."Count"]

			item:StripTextures()
			item:SetTemplate("Default")
			item:StyleButton()
			item:Size(143, 40)
			item:SetFrameLevel(item:GetFrameLevel() + 2)

			icon:Size(E.PixelMode and 38 or 32)
			icon:SetDrawLayer("OVERLAY")
			icon:Point("TOPLEFT", E.PixelMode and 1 or 4, -(E.PixelMode and 1 or 4))
			S:HandleIcon(icon)

			item.text = _G[frame..i.."Name"]
			icon.parent = item
			hooksecurefunc(icon, "SetTexture", updateItemQuality)

			count:SetParent(item.backdrop)
			count:SetDrawLayer("OVERLAY")
		end
	end

	do -- Fonts
		local function fixFontColor(obj, r, g, b)
			obj:SetTextColor(r, g, b)
			obj.SetTextColor = E.noop
		end

		fixFontColor(QuestGuru_QuestStartInfoTitle, 1, 0.8, 0.1)
		fixFontColor(QuestGuru_QuestStartInfoNPC, 1, 1, 1)
		fixFontColor(QuestGuru_QuestStartInfoPOS, 1, 1, 1)
		fixFontColor(QuestGuru_QuestStartInfoArea, 1, 1, 1)
		fixFontColor(QuestGuru_QuestStartInfoTimeLabel, 1, 1, 1)
		fixFontColor(QuestGuru_QuestStartInfoTime, 1, 1, 1)
		fixFontColor(QuestGuru_QuestStartInfoLevelLabel, 1, 1, 1)
		fixFontColor(QuestGuru_QuestStartInfoLevel, 1, 1, 1)
		fixFontColor(QuestGuru_QuestLogQuestTitle, 1, 0.8, 0.1)
		fixFontColor(QuestGuru_QuestLogObjectivesText, 1, 1, 1)
		fixFontColor(QuestGuru_QuestLogTimerText, 0.6, 0.6, 0.6)
		fixFontColor(QuestGuru_QuestLogObjective1, 0.6, 0.6, 0.6)
		fixFontColor(QuestGuru_QuestLogObjective2, 0.6, 0.6, 0.6)
		fixFontColor(QuestGuru_QuestLogObjective3, 0.6, 0.6, 0.6)
		fixFontColor(QuestGuru_QuestLogObjective4, 0.6, 0.6, 0.6)
		fixFontColor(QuestGuru_QuestLogObjective5, 0.6, 0.6, 0.6)
		fixFontColor(QuestGuru_QuestLogObjective6, 0.6, 0.6, 0.6)
		fixFontColor(QuestGuru_QuestLogObjective7, 0.6, 0.6, 0.6)
		fixFontColor(QuestGuru_QuestLogObjective8, 0.6, 0.6, 0.6)
		fixFontColor(QuestGuru_QuestLogObjective9, 0.6, 0.6, 0.6)
		fixFontColor(QuestGuru_QuestLogObjective10, 0.6, 0.6, 0.6)
		fixFontColor(QuestGuru_QuestLogRequiredMoneyText, 0.6, 0.6, 0.6)
		fixFontColor(QuestGuru_QuestLogSuggestedGroupNum, 1, 1, 1)
		fixFontColor(QuestGuru_QuestLogDescriptionTitle, 1, 0.8, 0.1)
		fixFontColor(QuestGuru_QuestLogQuestDescription, 1, 1, 1)
		fixFontColor(QuestGuru_QuestLogRewardTitleText, 1, 0.8, 0.1)
		fixFontColor(QuestGuru_QuestLogItemChooseText, 1, 1, 1)
		fixFontColor(QuestGuru_QuestLogItemReceiveText, 1, 1, 1)
		fixFontColor(QuestGuru_QuestLogSpellLearnText, 1, 1, 1)
		fixFontColor(QuestGuru_QuestLogPlayerTitleText, 1, 1, 1)
		fixFontColor(QuestGuru_QuestLogStartLabel, 1, 1, 1)
		fixFontColor(QuestGuru_QuestLogFinishLabel, 1, 1, 1)
		fixFontColor(QuestGuru_QuestLogFinishPos, 0.6, 0.6, 0.6)
		fixFontColor(QuestGuru_QuestLogFinishNPCName, 0.6, 0.6, 0.6)
		fixFontColor(QuestGuru_QuestLogHonorFrameReceiveText, 1, 1, 1)
		fixFontColor(QuestGuru_QuestLogTalentFrameReceiveText, 1, 1, 1)
		fixFontColor(QuestGuru_QuestLogXPFrameReceiveText, 1, 1, 1)
		fixFontColor(QuestGuru_QuestAbandonQuestTitle, 1, 0.8, 0.1)
		fixFontColor(QuestGuru_QuestAbandonObjectivesText, 1, 1, 1)
		fixFontColor(QuestGuru_QuestAbandonTimerText, 0.6, 0.6, 0.6)
		fixFontColor(QuestGuru_QuestAbandonObjective1, 0.6, 0.6, 0.6)
		fixFontColor(QuestGuru_QuestAbandonObjective2, 0.6, 0.6, 0.6)
		fixFontColor(QuestGuru_QuestAbandonObjective3, 0.6, 0.6, 0.6)
		fixFontColor(QuestGuru_QuestAbandonObjective4, 0.6, 0.6, 0.6)
		fixFontColor(QuestGuru_QuestAbandonObjective5, 0.6, 0.6, 0.6)
		fixFontColor(QuestGuru_QuestAbandonObjective6, 0.6, 0.6, 0.6)
		fixFontColor(QuestGuru_QuestAbandonObjective7, 0.6, 0.6, 0.6)
		fixFontColor(QuestGuru_QuestAbandonObjective8, 0.6, 0.6, 0.6)
		fixFontColor(QuestGuru_QuestAbandonObjective9, 0.6, 0.6, 0.6)
		fixFontColor(QuestGuru_QuestAbandonObjective10, 0.6, 0.6, 0.6)
		fixFontColor(QuestGuru_QuestAbandonRequiredMoneyText, 0.6, 0.6, 0.6)
		fixFontColor(QuestGuru_QuestAbandonSuggestedGroupNum, 1, 1, 1)
		fixFontColor(QuestGuru_QuestAbandonDescriptionTitle, 1, 0.8, 0.1)
		fixFontColor(QuestGuru_QuestAbandonQuestDescription, 1, 1, 1)
		fixFontColor(QuestGuru_QuestAbandonRewardTitleText, 1, 0.8, 0.1)
		fixFontColor(QuestGuru_QuestAbandonItemChooseText, 1, 1, 1)
		fixFontColor(QuestGuru_QuestAbandonItemReceiveText, 1, 1, 1)
		fixFontColor(QuestGuru_QuestAbandonSpellLearnText, 1, 1, 1)
		fixFontColor(QuestGuru_QuestAbandonPlayerTitleText, 1, 1, 1)
		fixFontColor(QuestGuru_QuestAbandonStartLabel, 1, 1, 1)
		fixFontColor(QuestGuru_QuestAbandonFinishLabel, 1, 1, 1)
		fixFontColor(QuestGuru_QuestAbandonFinishPos, 0.6, 0.6, 0.6)
		fixFontColor(QuestGuru_QuestAbandonFinishNPCName, 0.6, 0.6, 0.6)
		fixFontColor(QuestGuru_QuestAbandonHonorFrameReceiveText, 1, 1, 1)
		fixFontColor(QuestGuru_QuestAbandonTalentFrameReceiveText, 1, 1, 1)
	end
end)

S:AddCallbackForAddon("QuestGuru_History", "QuestGuru_History", function()
	if not E.private.addOnSkins.QuestGuru then return end

	QuestGuru_QuestLogFrameTab3:StripTextures()
	QuestGuru_QuestLogFrameTab3:SetTemplate()
	QuestGuru_QuestLogFrameTab3:Height(24)
	QuestGuru_QuestLogFrameTab3:Point("LEFT", QuestGuru_QuestLogFrameTab2, "RIGHT", 1, 0)
	QuestGuru_QuestLogFrameTab3.SetPoint = E.noop
	QuestGuru_QuestLogFrameTab3:SetHitRectInsets(0, 0, 0, 0)
	QuestGuru_QuestLogFrameTab3:HookScript("OnEnter", S.SetModifiedBackdrop)
	QuestGuru_QuestLogFrameTab3:HookScript("OnLeave", S.SetOriginalBackdrop)

	QuestGuru_QuestLogFrameTab2.SetPoint = nil
	QuestGuru_QuestLogFrameTab2:Point("LEFT", QuestGuru_QuestLogFrameTab1, "RIGHT", 1, 0)
	QuestGuru_QuestLogFrameTab2.SetPoint = E.noop

	QuestGuru_QuestHistoryTitle1:ClearAllPoints()
	QuestGuru_QuestHistoryTitle1:SetPoint("TOPLEFT", QuestGuru_QuestHistoryListScrollFrame)

	QuestGuru_QuestHistoryListScrollFrame:Size(305, 335)
	QuestGuru_QuestHistoryListScrollFrame:ClearAllPoints()
	QuestGuru_QuestHistoryListScrollFrame:Point("TOPLEFT", QuestGuru_QuestLogFrame, 19, -62)
	QuestGuru_QuestHistoryListScrollFrame:CreateBackdrop("Transparent")
	QuestGuru_QuestHistoryListScrollFrame.backdrop:Point("TOPLEFT", 0, 2)
	QuestGuru_QuestHistoryListScrollFrame.backdrop:Point("BOTTOMRIGHT", 0, -2)
	QuestGuru_QuestHistoryListScrollFrame:Show()
	QuestGuru_QuestHistoryListScrollFrame.Hide = QuestGuru_QuestHistoryListScrollFrame.Show

	S:HandleScrollBar(QuestGuru_QuestHistoryListScrollFrameScrollBar)
	QuestGuru_QuestHistoryListScrollFrameScrollBar:Point("TOPLEFT", QuestGuru_QuestHistoryListScrollFrame, "TOPRIGHT", 3, -17)
	QuestGuru_QuestHistoryListScrollFrameScrollBar:Point("BOTTOMLEFT", QuestGuru_QuestHistoryListScrollFrame, "BOTTOMRIGHT", 3, 17)

	QuestGuru_QuestHistoryDetailScrollFrame:Size(304, 336)
	QuestGuru_QuestHistoryDetailScrollFrame:ClearAllPoints()
	QuestGuru_QuestHistoryDetailScrollFrame:Point("TOPRIGHT", QuestGuru_QuestLogFrame, -30, -61)
	QuestGuru_QuestHistoryDetailScrollFrame:StripTextures()
	QuestGuru_QuestHistoryDetailScrollFrame:CreateBackdrop("Transparent")
	QuestGuru_QuestHistoryDetailScrollFrame.backdrop:Point("TOPLEFT", 0, 1)
	QuestGuru_QuestHistoryDetailScrollFrame.backdrop:Point("BOTTOMRIGHT", 0, -2)

	S:HandleScrollBar(QuestGuru_QuestHistoryDetailScrollFrameScrollBar)
	QuestGuru_QuestHistoryDetailScrollFrameScrollBar:Point("TOPLEFT", QuestGuru_QuestHistoryDetailScrollFrame, "TOPRIGHT", 3, -18)
	QuestGuru_QuestHistoryDetailScrollFrameScrollBar:Point("BOTTOMLEFT", QuestGuru_QuestHistoryDetailScrollFrame, "BOTTOMRIGHT", 3, 17)

	S:HandleEditBox(QuestGuru_QuestHistorySearch)
	QuestGuru_QuestHistorySearch:Width(143)
	QuestGuru_QuestHistorySearch:Point("LEFT", QuestGuru_QuestHistorySearchText, "RIGHT", 4, -1)

	S:HandleButton(QuestGuru_HistoryListFrameShowButton)
	QuestGuru_HistoryListFrameShowButton:Point("LEFT", QuestGuru_QuestHistorySearch, "RIGHT", 4, 0)

	local function skinLogEntry(questLogTitle, index)
		questLogTitle:Width(300)

		if index > 1 then
			questLogTitle:SetPoint("TOPLEFT", _G["QuestGuru_QuestLogTitle"..(index-1)], "BOTTOMLEFT", 0, 0)
		end

		if questLogTitle.check then
			questLogTitle.check:CreateBackdrop()
			questLogTitle.check.backdrop:SetInside()
			questLogTitle.check:SetNormalTexture(nil)
			questLogTitle.check:SetPushedTexture(nil)
			questLogTitle.check:SetHighlightTexture(nil)
		end

		S:HandleCollapseExpandButton(questLogTitle)
	end

	for i = 1, QUESTS_DISPLAYED do
		skinLogEntry(_G["QuestGuru_QuestHistoryTitle"..i], i)
	end

	-- Quest items
	local function updateItemQuality(self, texture)
		if self.parent.link or self.parent.type == "choice" then
			local quality

			if self.parent.link then
				quality = select(3, GetItemInfo(self.parent.link))
			elseif self.parent.type == "choice" then
				quality = select(4, GetQuestLogChoiceInfo(self.parent:GetID()))
			end

			if quality then
				local r, g, b = GetItemQualityColor(quality)

				self.parent:SetBackdropBorderColor(r, g, b)
				self.parent.backdrop:SetBackdropBorderColor(r, g, b)

				self.parent.text:SetTextColor(r, g, b)
			else
				self.parent:SetBackdropBorderColor(unpack(E.media.bordercolor))
				self.parent.backdrop:SetBackdropBorderColor(unpack(E.media.bordercolor))

				self.parent.text:SetTextColor(1, 1, 1)
			end
		end
	end

	local items = {
		["QuestGuru_QuestHistoryItem"] = 10,
	}
	for frame, numItems in pairs(items) do
		for i = 1, numItems do
			local item = _G[frame..i]
			local icon = _G[frame..i.."IconTexture"]
			local count = _G[frame..i.."Count"]

			item:StripTextures()
			item:SetTemplate("Default")
			item:StyleButton()
			item:Size(143, 40)
			item:SetFrameLevel(item:GetFrameLevel() + 2)

			icon:Size(E.PixelMode and 38 or 32)
			icon:SetDrawLayer("OVERLAY")
			icon:Point("TOPLEFT", E.PixelMode and 1 or 4, -(E.PixelMode and 1 or 4))
			S:HandleIcon(icon)

			item.text = _G[frame..i.."Name"]
			icon.parent = item
			hooksecurefunc(icon, "SetTexture", updateItemQuality)

			count:SetParent(item.backdrop)
			count:SetDrawLayer("OVERLAY")
		end
	end

	do -- Fonts
		local function fixFontColor(obj, r, g, b)
			obj:SetTextColor(r, g, b)
			obj.SetTextColor = E.noop
		end

		fixFontColor(QuestGuru_QuestHistoryQuestTitle, 1, 0.8, 0.1)
		fixFontColor(QuestGuru_QuestHistoryObjectivesText, 1, 1, 1)
		fixFontColor(QuestGuru_QuestHistoryTimerText, 0.6, 0.6, 0.6)
		fixFontColor(QuestGuru_QuestHistoryObjective1, 0.6, 0.6, 0.6)
		fixFontColor(QuestGuru_QuestHistoryObjective2, 0.6, 0.6, 0.6)
		fixFontColor(QuestGuru_QuestHistoryObjective3, 0.6, 0.6, 0.6)
		fixFontColor(QuestGuru_QuestHistoryObjective4, 0.6, 0.6, 0.6)
		fixFontColor(QuestGuru_QuestHistoryObjective5, 0.6, 0.6, 0.6)
		fixFontColor(QuestGuru_QuestHistoryObjective6, 0.6, 0.6, 0.6)
		fixFontColor(QuestGuru_QuestHistoryObjective7, 0.6, 0.6, 0.6)
		fixFontColor(QuestGuru_QuestHistoryObjective8, 0.6, 0.6, 0.6)
		fixFontColor(QuestGuru_QuestHistoryObjective9, 0.6, 0.6, 0.6)
		fixFontColor(QuestGuru_QuestHistoryObjective10, 0.6, 0.6, 0.6)
		fixFontColor(QuestGuru_QuestHistoryRequiredMoneyText, 0.6, 0.6, 0.6)
		fixFontColor(QuestGuru_QuestHistorySuggestedGroupNum, 1, 1, 1)
		fixFontColor(QuestGuru_QuestHistoryDescriptionTitle, 1, 0.8, 0.1)
		fixFontColor(QuestGuru_QuestHistoryQuestDescription, 1, 1, 1)
		fixFontColor(QuestGuru_QuestHistoryRewardTitleText, 1, 0.8, 0.1)
		fixFontColor(QuestGuru_QuestHistoryItemChooseText, 1, 1, 1)
		fixFontColor(QuestGuru_QuestHistoryItemReceiveText, 1, 1, 1)
		fixFontColor(QuestGuru_QuestHistorySpellLearnText, 1, 1, 1)
		fixFontColor(QuestGuru_QuestHistoryPlayerTitleText, 1, 1, 1)
		fixFontColor(QuestGuru_QuestHistoryXPText, 1, 1, 1)
		fixFontColor(QuestGuru_QuestHistoryRepText, 1, 1, 1)
		fixFontColor(QuestGuru_QuestHistoryStartLabel, 1, 1, 1)
		fixFontColor(QuestGuru_QuestHistoryStartPos, 0.6, 0.6, 0.6)
		fixFontColor(QuestGuru_QuestHistoryStartNPCName, 0.4, 0.8, 1)
		fixFontColor(QuestGuru_QuestHistoryFinishLabel, 1, 1, 1)
		fixFontColor(QuestGuru_QuestHistoryFinishPos, 0.6, 0.6, 0.6)
		fixFontColor(QuestGuru_QuestHistoryFinishNPCName, 0.4, 0.8, 1)
		fixFontColor(QuestGuru_QuestHistoryHonorFrameReceiveText, 1, 1, 1)
		fixFontColor(QuestGuru_QuestHistoryTalentFrameReceiveText, 1, 1, 1)
	end
end)