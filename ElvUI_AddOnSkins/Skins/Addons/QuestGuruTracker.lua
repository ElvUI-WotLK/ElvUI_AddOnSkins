local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

if not AS:IsAddonLODorEnabled("QuestGuru_Tracker") then return end

-- QuestGuru_Tracker 1.4.4

S:AddCallbackForAddon("QuestGuru_Tracker", "QuestGuru_Tracker", function()
	if not E.private.addOnSkins.QuestGuru_Tracker then return end

	E:GetModule("Tooltip"):SetStyle(QGT_QuestWatchFrameTooltip)
	QGT_QuestWatchFrameTooltip.SetBackdropColor = E.noop
	QGT_QuestWatchFrameTooltip.SetBackdropBorderColor = E.noop

	QGT_QuestWatchFrame:SetBackdrop(nil)
	QGT_QuestWatchFrame:CreateBackdrop(QGT_Settings.ShowBorder and "Transparent" or "NoBackdrop")
	QGT_QuestWatchFrame:SetHitRectInsets(0, 0, 0, 0)
	QGT_QuestWatchFrameBackground:Hide()

	QGT_AchievementWatchFrame:SetBackdrop(nil)
	QGT_AchievementWatchFrame:CreateBackdrop(QGT_Settings.ShowBorder and "Transparent" or "NoBackdrop")
	QGT_AchievementWatchFrame:SetHitRectInsets(0, 0, 0, 0)
	QGT_AchievementWatchFrameBackground:Hide()

	S:HandleButton(QGT_QuestWatchFrameToggle)
	S:HandleButton(QGT_QuestWatchFrameMinimize)
	S:HandleButton(QGT_QuestWatchFrameOptions)
	S:HandleButton(QGT_AchievementWatchFrameToggle)
	S:HandleButton(QGT_AchievementWatchFrameMinimize)
	S:HandleButton(QGT_AchievementWatchFrameOptions)

	QGT_QuestWatchFrameMinimize:Point("RIGHT", QGT_QuestWatchFrameOptions, "LEFT", -1, 0)
	QGT_QuestWatchFrameToggle:Point("RIGHT", QGT_QuestWatchFrameMinimize, "LEFT", -2, 0)

	QGT_AchievementWatchFrameMinimize:Point("RIGHT", QGT_AchievementWatchFrameOptions, "LEFT", -1, 0)
	QGT_AchievementWatchFrameToggle:Point("RIGHT", QGT_AchievementWatchFrameMinimize, "LEFT", -2, 0)

	local _SetPoint = QGT_QuestWatchFrameSlider.SetPoint
	local function sliderSetPoint(self, point)
		if point == "TOPLEFT" then
			_SetPoint(self, "TOPLEFT", -12, -17)
		else
			_SetPoint(self, "TOPRIGHT", 12, -17)
		end
	end

	S:HandleSliderFrame(QGT_QuestWatchFrameSlider)
	QGT_QuestWatchFrameSlider.SetPoint = sliderSetPoint

	S:HandleSliderFrame(QGT_AchievementWatchFrameSlider)
	QGT_AchievementWatchFrameSlider.SetPoint = sliderSetPoint

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
				elseif child:IsObjectType("Slider") then
					S:HandleSliderFrame(child)
				end
			end
		end
	end

	skinOptions(QGT_OptionsFrameTracker)

	for i = 1, 40 do
		local frame = _G["QGT_AchievementWatchLine"..i]
		local icon = _G["QGT_AchievementWatchLine"..i.."Icon"]

		icon:Size(14)
		icon:SetTexCoord(unpack(E.TexCoords))

		frame.statusBar:StripTextures()
		frame.statusBar:CreateBackdrop("Transparent")

		frame.statusBar:SetStatusBarTexture(E.media.normTex)
		E:RegisterStatusBar(frame.statusBar)
	end

	do
		local alpha = QGT_Settings.Alpha
		local backdropR, backdropG, backdropB = unpack(E.media.backdropfadecolor, 1, 3)
		local borderR, borderG, borderB = unpack(E.media.bordercolor, 1, 3)

		QGT_QuestWatchFrame.backdrop:SetBackdropColor(backdropR, backdropG, backdropB, alpha)
		QGT_QuestWatchFrame.backdrop:SetBackdropBorderColor(borderR, borderG, borderB, alpha)
		QGT_AchievementWatchFrame.backdrop:SetBackdropColor(backdropR, backdropG, backdropB, alpha)
		QGT_AchievementWatchFrame.backdrop:SetBackdropBorderColor(borderR, borderG, borderB, alpha)
	end

	QGT_SetQuestWatchBorder = function(enabled)
		if enabled then
			QGT_QuestWatchFrame.backdrop:SetTemplate("Transparent", nil, true)
		else
			QGT_QuestWatchFrame.backdrop:SetTemplate("NoBackdrop", nil, true)
		end
	end

	QGT_SetAchievementWatchBorder = function(enabled)
		if enabled then
			QGT_AchievementWatchFrame.backdrop:SetTemplate("Transparent", nil, true)
		else
			QGT_AchievementWatchFrame.backdrop:SetTemplate("NoBackdrop", nil, true)
		end
	end

	QGT_OptionsFrameTrackerAlpha:SetScript("OnValueChanged", function(self)
		local alpha = self:GetValue()
		local backdropR, backdropG, backdropB = unpack(E.media.backdropfadecolor, 1, 3)
		local borderR, borderG, borderB = unpack(E.media.bordercolor, 1, 3)

		QGT_Settings.Alpha = alpha

		QGT_QuestWatchFrame.backdrop:SetBackdropColor(backdropR, backdropG, backdropB, alpha)
		QGT_QuestWatchFrame.backdrop:SetBackdropBorderColor(borderR, borderG, borderB, alpha)
		QGT_AchievementWatchFrame.backdrop:SetBackdropColor(backdropR, backdropG, backdropB, alpha)
		QGT_AchievementWatchFrame.backdrop:SetBackdropBorderColor(borderR, borderG, borderB, alpha)

		QGT_OptionsFrameTrackerAlphaText:SetFormattedText("%s (%d%%)", QG_OPT_TRACKER_ALPHA, math.abs(math.ceil(alpha * 100 - 0.5)))
	end)

	local skinnedButtons = 0
	hooksecurefunc("QGT_QuestWatch_Update", function()
		local questItemIcons = QGT_Settings.QuestItemIcons

		if questItemIcons or QGT_WATCHFRAME_NUM_ITEMS > skinnedButtons then
			local leftSide = (QGT_Settings.QuestWatch.Left * QGT_Settings.Scale) < 32
			local sliderVisible = QGT_QuestWatchFrameSlider:GetAlpha() > 0
			local sliderRightVisible = sliderVisible and ((QGT_Settings.QuestWatch.Left + 256) * QGT_Settings.Scale) > (UIParent:GetWidth() - 16)

			for i = questItemIcons and 1 or skinnedButtons + 1, QGT_WATCHFRAME_NUM_ITEMS do
				local button = _G["WatchFrameItem"..i]

				if button then
					if not button.isSkinned then
						local icon = _G["WatchFrameItem"..i.."IconTexture"]
						local normal = _G["WatchFrameItem"..i.."NormalTexture"]
						local cooldown = _G["WatchFrameItem"..i.."Cooldown"]

						button:CreateBackdrop()
						button.backdrop:SetAllPoints()
						button:StyleButton()
						button:Size(25)

						normal:SetAlpha(0)

						icon:SetInside()
						icon:SetTexCoord(unpack(E.TexCoords))

						E:RegisterCooldown(cooldown)

						button.isSkinned = true
					end

					if questItemIcons then
						local _, watchText = button:GetPoint()

						if leftSide then
							if sliderVisible then
								button:Point("TOPLEFT", watchText, "TOPRIGHT", 19, 0)
							else
								button:Point("TOPLEFT", watchText, "TOPRIGHT", 8, 0)
							end
						else
							if sliderRightVisible then
								button:Point("TOPRIGHT", watchText, "TOPLEFT", -19, 0)
							else
								button:Point("TOPRIGHT", watchText, "TOPLEFT", -8, 0)
							end
						end
					end
				end
			end

			skinnedButtons = QGT_WATCHFRAME_NUM_ITEMS
		end
	end)

	do -- Fixes
		local _G = _G
		local tonumber = tonumber
		local len, sub = string.len, string.sub

		local ChatEdit_ChooseBoxForSend = ChatEdit_ChooseBoxForSend
		local GetAchievementLink = GetAchievementLink
		local GetItemInfo = GetItemInfo
		local GetQuestLink = GetQuestLink
		local GetQuestLogTitle = GetQuestLogTitle
		local IsShiftKeyDown = IsShiftKeyDown
		local QuestLog_OpenToQuest = QuestLog_OpenToQuest
		local QuestLog_SetSelection = QuestLog_SetSelection
		local RemoveTrackedAchievement = RemoveTrackedAchievement
		local WatchFrame_Update = WatchFrame_Update

		local function questOnClick(self, button)
			local qID = self.qID

			if button == "LeftButton" then
				if IsShiftKeyDown() then
					local ChatFrameEditBox = ChatEdit_ChooseBoxForSend()

					-- header line
					if not qID then
						if ChatFrameEditBox:IsVisible() then
							ChatFrameEditBox:Insert(self:GetText())
						end
					-- objective line
					elseif not tonumber(qID) then
						local objName = sub(self:GetText(), 3 + len(QGT_Settings.Bullet))
						local objText

						if qID == "item" then
							local _, itemLink = GetItemInfo(objName)

							if not itemLink then
								objText = objName
							else
								objText = itemLink
							end
						else
							objText = objName
						end

						if ChatFrameEditBox:IsVisible() then
							ChatFrameEditBox:Insert(objText)
						end
					-- quest number
					else
						if ChatFrameEditBox:IsVisible() then
							ChatFrameEditBox:Insert(GetQuestLink(qID))
						end
					end
				else
					-- header line
					if not qID then
						local headName = self:GetText()
						if QGT_WatchHeaders[headName] then
							QGT_WatchHeaders[headName] = false
						else
							QGT_WatchHeaders[headName] = true
						end

						WatchFrame_Update()
					-- objective line
					elseif not tonumber(qID) then
						local objName = sub(self:GetText(), 3 + len(QGT_Settings.Bullet))
						if qID == "item" then
							local _, itemLink = GetItemInfo(objName)
							if itemLink then
								SetItemRef(itemLink, nil, button)
							end
						end
					-- title line
					else
						QuestLog_OpenToQuest(qID)

						if QuestGuru_QuestLogFrame then
							QuestGuru_QuestLogFrame:Show()
						end
					end
				end
			elseif button == "RightButton" then
				if IsShiftKeyDown() then
					if qID and tonumber(qID) then
						QuestLog_SetSelection(qID, button)
						QuestLog_Update()
						ToggleDropDownMenu(1, nil, QGT_QuestWatchTitleMenu, self:GetName(), 0, 0)
					end
				else
					-- header line
					if not qID then
						local headName = self:GetText()
						if QGT_WatchHeaders[headName] then
							QGT_WatchHeaders[headName] = false
						else
							QGT_WatchHeaders[headName] = true
						end

						WatchFrame_Update()
					-- title line
					elseif tonumber(qID) then
						local qName = GetQuestLogTitle(qID)

						if QGT_WatchQuests[qName] then
							QGT_WatchQuests[qName] = false
						else
							QGT_WatchQuests[qName] = true
						end

						WatchFrame_Update()
					end
				end
			end

			QGT_ShowQuestTrackerSlider(true)
		end

		local function achievementOnClick(self)
			if self.achievementID then
				if IsShiftKeyDown() then
					local ChatFrameEditBox = ChatEdit_ChooseBoxForSend()

					if ChatFrameEditBox:IsVisible() then
						ChatFrameEditBox:Insert(GetAchievementLink(self.achievementID))
					else
						RemoveTrackedAchievement(self.achievementID)
					end
				else
					if not AchievementFrame then
						AchievementFrame_LoadUI()
					end

					if not AchievementFrame:IsShown() then
						AchievementFrame_ToggleAchievementFrame()
						AchievementFrame_SelectAchievement(self.achievementID)
					elseif AchievementFrameAchievements.selection ~= self.achievementID then
						AchievementFrame_SelectAchievement(self.achievementID)
					else
						AchievementFrame_ToggleAchievementFrame()
					end
				end
			end
		end

		local frame1, frame2
		for i = 1, 40 do
			frame1 = _G["QGT_QuestWatchLine"..i]
			frame2 = _G["QGT_AchievementWatchLine"..i]

			if frame1 then
				frame1:SetScript("OnClick", questOnClick)
			end
			if frame2 then
				frame2:SetScript("OnClick", achievementOnClick)
			end
		end

		QGT_QuestWatchButton_OnClick = questOnClick
	end

	do -- Adjustments
		local function updateQuestHeader(flag)
			if flag then
				local width = 20

				QGT_QuestWatchQuestName:ClearAllPoints()
				QGT_QuestWatchNumQuests:ClearAllPoints()

				if QGT_QuestWatchFrameToggle:IsShown() then
					width = width + 60
					QGT_QuestWatchNumQuests:Point("TOPRIGHT", -60, -6)
				else
					width = width + 42
					QGT_QuestWatchNumQuests:Point("TOPRIGHT", -42, -6)
				end

				QGT_QuestWatchQuestName:Point("RIGHT", QGT_QuestWatchNumQuests, "LEFT", -12, 0)

			--	width = width + QGT_QuestWatchQuestName:GetWidth() + QGT_QuestWatchNumQuests:GetWidth()
				width = width + QGT_QuestWatchQuestName:GetWidth() + 32

				QGT_QuestWatchFrame.backdrop:ClearAllPoints()
				QGT_QuestWatchFrame.backdrop:Point("TOPRIGHT", 1, 1)
				QGT_QuestWatchFrame.backdrop:Point("BOTTOMLEFT", QGT_QuestWatchFrame:GetWidth() - width, 1)
			else
				QGT_QuestWatchFrame.backdrop:ClearAllPoints()
				QGT_QuestWatchFrame.backdrop:Point("TOPLEFT", -1, 1)
				QGT_QuestWatchFrame.backdrop:Point("BOTTOMRIGHT", 1, -1)

				QGT_QuestWatchQuestName:ClearAllPoints()
				QGT_QuestWatchQuestName:Point("TOPLEFT", 8, -6)

				QGT_QuestWatchNumQuests:ClearAllPoints()
				QGT_QuestWatchNumQuests:Point("LEFT", QGT_QuestWatchQuestName, "RIGHT", 12, 0)
			end
		end
		local function updateAchievemtHeader(flag)
			if flag then
				local width = 20

				QGT_AchievementWatchName:ClearAllPoints()
				QGT_AchievementWatchNum:ClearAllPoints()

				if QGT_AchievementWatchFrameToggle:IsShown() then
					width = width + 60
					QGT_AchievementWatchNum:Point("TOPRIGHT", -60, -6)
				else
					width = width + 42
					QGT_AchievementWatchNum:Point("TOPRIGHT", -42, -6)
				end

				QGT_AchievementWatchName:Point("RIGHT", QGT_AchievementWatchNum, "LEFT", -12, 0)

			--	width = width + QGT_AchievementWatchName:GetWidth() + QGT_AchievementWatchNum:GetWidth()
				width = width + QGT_AchievementWatchName:GetWidth() + 8

				QGT_AchievementWatchFrame.backdrop:ClearAllPoints()
				QGT_AchievementWatchFrame.backdrop:Point("TOPRIGHT", 1, 1)
				QGT_AchievementWatchFrame.backdrop:Point("BOTTOMLEFT", QGT_AchievementWatchFrame:GetWidth() - width, 1)
			else
				QGT_AchievementWatchFrame.backdrop:ClearAllPoints()
				QGT_AchievementWatchFrame.backdrop:Point("TOPLEFT", -1, 1)
				QGT_AchievementWatchFrame.backdrop:Point("BOTTOMRIGHT", 1, -1)

				QGT_AchievementWatchName:ClearAllPoints()
				QGT_AchievementWatchName:Point("TOPLEFT", 8, -6)

				QGT_AchievementWatchNum:ClearAllPoints()
				QGT_AchievementWatchNum:Point("LEFT", QGT_AchievementWatchName, "RIGHT", 12, 0)
			end
		end

		QGT_QuestWatchFrameToggle:HookScript("OnClick", function()
			updateAchievemtHeader(QGT_Settings.AchievementWatch.Minimized)
		end)
		QGT_AchievementWatchFrameToggle:HookScript("OnClick", function()
			updateQuestHeader(QGT_Settings.QuestWatch.Minimized)
		end)

		QGT_QuestWatchFrameMinimize:HookScript("OnClick", function(self, button)
			if button == "LeftButton" then
				updateQuestHeader(QGT_Settings.QuestWatch.Minimized)
			end
		end)
		QGT_AchievementWatchFrameMinimize:HookScript("OnClick", function(self, button)
			if button == "LeftButton" then
				updateAchievemtHeader(QGT_Settings.AchievementWatch.Minimized)
			end
		end)

		if QGT_Settings.QuestWatch.Minimized then
			updateQuestHeader(true)
		end
		if QGT_Settings.AchievementWatch.Minimized then
			updateAchievemtHeader(true)
		end
	end
end)