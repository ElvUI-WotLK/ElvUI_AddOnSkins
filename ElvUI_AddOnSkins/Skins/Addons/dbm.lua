local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

if not AS:IsAddonLODorEnabled("DBM-Core") then return end

local _G = _G
local unpack = unpack
local find, gsub = string.find, string.gsub

local CreateFrame = CreateFrame
local hooksecurefunc = hooksecurefunc

-- Deadly Boss Mods 4.52 r4442
-- https://www.curseforge.com/wow/addons/deadly-boss-mods/files/447605

S:AddCallbackForAddon("DBM-Core", "DBM-Core", function()
	if not E.private.addOnSkins.DBM then return end

	local backportVersion = DBM.ReleaseRevision > 7000

	local function createIconOverlay(id, parent)
		local frame = CreateFrame("Frame", "$parentIcon" .. id .. "Overlay", parent)
		frame:SetTemplate()

		if id == 1 then
			if E.db.addOnSkins.DBMSkinHalf then
				frame:Point("BOTTOMRIGHT", parent, "BOTTOMLEFT", -10 * (E.Border + E.Spacing), 0)
			else
				frame:Point("RIGHT", parent, "LEFT", -(E.Border + E.Spacing), 0)
			end
		elseif E.db.addOnSkins.DBMSkinHalf then
			frame:Point("BOTTOMLEFT", parent, "BOTTOMRIGHT", 10 * (E.Border + E.Spacing), 0)
		else
			frame:Point("LEFT", parent, "RIGHT", (E.Border + E.Spacing), 0)
		end

		local backdroptex = frame:CreateTexture(nil, "BORDER")
		backdroptex:SetTexture("Interface\\Icons\\Spell_Nature_WispSplode")
		backdroptex:SetInside(frame)
		backdroptex:SetTexCoord(unpack(E.TexCoords))

		return frame
	end

	local function applyStyle(self)
		local db = E.db.addOnSkins

		local frame = self.frame
		local frameName = frame:GetName()
		local bar = _G[frameName .. "Bar"]
		local background = _G[frameName .. "BarBackground"]
		local icon1 = _G[frameName .. "BarIcon1"]
		local icon2 = _G[frameName .. "BarIcon2"]
		local name = _G[frameName .. "BarName"]
		local timer = _G[frameName .. "BarTimer"]
		local spark = _G[frameName .. "BarSpark"]

		local scale = self.enlarged and self.owner.options.HugeScale or self.owner.options.Scale
		local barWidth = (self.enlarged and self.owner.options.HugeWidth or self.owner.options.Width) * scale
		local barHeight = db.dbmBarHeight * scale
		local fontSize = db.dbmFontSize * scale

		background:Hide()
		spark:Hide()
		frame._SetPoint = frame.SetPoint

		self._bar = bar
		self._icon1 = icon1
		self._icon2 = icon2
		self._name = name
		self._timer = timer
		self._font = E.LSM:Fetch("font", db.dbmFont)

		if not icon1.overlay then
			icon1.overlay = createIconOverlay(1, frame)
			icon1:SetTexCoord(unpack(E.TexCoords))
			icon1:SetParent(icon1.overlay)
			icon1:SetInside(icon1.overlay)
		end
		if not icon2.overlay then
			icon2.overlay = createIconOverlay(2, frame)
			icon2:SetTexCoord(unpack(E.TexCoords))
			icon2:SetParent(icon2.overlay)
			icon2:SetInside(icon2.overlay)
		end

		frame:SetScale(1)
		frame:SetTemplate(db.dbmTemplate)

		bar:SetInside(frame)

		frame:Size(barWidth, db.DBMSkinHalf and barHeight / 3 or barHeight)
		bar:Size(barWidth, barHeight)

		icon1.overlay:Size(barHeight)
		icon2.overlay:Size(barHeight)

		name:ClearAllPoints()
		timer:ClearAllPoints()

		if db.DBMSkinHalf then
			if not self.owner.options.BarYOffset or self.owner.options.BarYOffset < 20 then
				self.owner.options.BarYOffset = 20
			end

			if not self.owner.options.HugeBarYOffset or self.owner.options.HugeBarYOffset < 20 then
				self.owner.options.HugeBarYOffset = 20
			end

			name:Point("BOTTOMLEFT", frame, "TOPLEFT", 0, 3)
			if backportVersion then
				name:Point("BOTTOMRIGHT", timer, "BOTTOMLEFT")
			end
			timer:Point("BOTTOMRIGHT", frame, "TOPRIGHT", 1, 3)
		else
			name:Point("LEFT", 5, 0)
			if backportVersion then
				name:Point("RIGHT", timer, "LEFT")
			end
			timer:Point("RIGHT", -5, 0)
		end

		name:SetFont(self._font, fontSize, db.dbmFontOutline)
		timer:SetFont(self._font, fontSize, db.dbmFontOutline)

		if self.owner.options.IconLeft then
			icon1.overlay:Show()
		else
			icon1.overlay:Hide()
		end

		if self.owner.options.IconRight then
			icon2.overlay:Show()
		else
			icon2.overlay:Hide()
		end
	end

	local function correctPoint(self, p1, a, p2, x, y)
		self._SetPoint(self, p1, a, p2, x, y - 40)
		self.SetPoint = nil
	end
	local function preUpdate(self, elapsed)
		if (self.timer - elapsed > 0) and self.moving == "move" and self.moveElapsed <= 0.5 and self.owner.options.ExpandUpwards then
			self.frame.SetPoint = correctPoint
		end
	end

	local function setPosition(self)
		if self.moving == "enlarge" then return end

		local enlarged = self.enlarged
		local expandUpwards = backportVersion and (enlarged and self.owner.options.ExpandUpwardsLarge or self.owner.options.ExpandUpwards) or self.owner.options.ExpandUpwards
		local anchor = (self.prev and self.prev.frame) or (self.enlarged and self.owner.secAnchor) or self.owner.mainAnchor

		self.frame:ClearAllPoints()
		if expandUpwards then
			self.frame:SetPoint("BOTTOM", anchor, "TOP", self.owner.options[enlarged and "HugeBarXOffset" or "BarXOffset"], self.owner.options[enlarged and "HugeBarYOffset" or "BarYOffset"])
		else
			self.frame:SetPoint("TOP", anchor, "BOTTOM", self.owner.options[enlarged and "HugeBarXOffset" or "BarXOffset"], -self.owner.options[enlarged and "HugeBarYOffset" or "BarYOffset"])
		end
	end

	local function moveToNextPosition(self, oldX, oldY)
		if self.moving == "enlarge" then return end

		local enlarged = self.enlarged
		local expandUpwards = backportVersion and (enlarged and self.owner.options.ExpandUpwardsLarge or self.owner.options.ExpandUpwards) or self.owner.options.ExpandUpwards
		local newAnchor = (self.prev and self.prev.frame) or (self.enlarged and self.owner.secAnchor) or self.owner.mainAnchor

		oldX = oldX or (self.frame:GetRight() - self.frame:GetWidth() / 2)
		if expandUpwards then
			oldY = oldY or self.frame:GetTop() + self.owner.options[enlarged and "HugeBarYOffset" or "BarYOffset"]
		else
			oldY = oldY or self.frame:GetTop() - self.owner.options[enlarged and "HugeBarYOffset" or "BarYOffset"]
		end

		self.frame:ClearAllPoints()
		if expandUpwards then
			self.movePoint = "BOTTOM"
			self.moveRelPoint = "TOP"
			self.frame:SetPoint("BOTTOM", newAnchor, "TOP", self.owner.options[enlarged and "HugeBarXOffset" or "BarXOffset"], self.owner.options[enlarged and "HugeBarYOffset" or "BarYOffset"])
		else
			self.movePoint = "TOP"
			self.moveRelPoint = "BOTTOM"
			self.frame:SetPoint("TOP", newAnchor, "BOTTOM", self.owner.options[enlarged and "HugeBarXOffset" or "BarXOffset"], -self.owner.options[enlarged and "HugeBarYOffset" or "BarYOffset"])
		end

		local newX = self.frame:GetRight() - self.frame:GetWidth() / 2
		local newY = self.frame:GetTop()

		self.moveAnchor = newAnchor
		self.moveOffsetX = -(newX - oldX)
		self.moveOffsetY = -(newY - oldY)
		self.moveElapsed = 0

		if self.owner.options.BarStyle ~= "NoAnim" then
			self.frame:ClearAllPoints()
			self.frame:SetPoint(self.movePoint, newAnchor, self.moveRelPoint, self.moveOffsetX, self.moveOffsetY)
			self.moving = "move"
		end
	end

	local function enlarge(self)
		local newAnchor = (self.owner.hugeBars.last and self.owner.hugeBars.last.frame) or self.owner.secAnchor
		local oldX = self.frame:GetRight() - self.frame:GetWidth() / 2
		local oldY = self.frame:GetTop()

		local enlarged = self.enlarged
		local expandUpwards = backportVersion and (enlarged and self.owner.options.ExpandUpwardsLarge or self.owner.options.ExpandUpwards) or self.owner.options.ExpandUpwards

		self.frame:ClearAllPoints()
		if expandUpwards then
			self.movePoint = "BOTTOM"
			self.moveRelPoint = "TOP"
			self.frame:SetPoint("BOTTOM", newAnchor, "TOP", self.owner.options[enlarged and "HugeBarXOffset" or "BarXOffset"], self.owner.options[enlarged and "HugeBarYOffset" or "BarYOffset"])
		else
			self.movePoint = "TOP"
			self.moveRelPoint = "BOTTOM"
			self.frame:SetPoint("TOP", newAnchor, "BOTTOM", self.owner.options[enlarged and "HugeBarXOffset" or "BarXOffset"], -self.owner.options[enlarged and "HugeBarYOffset" or "BarYOffset"])
		end

		local newX = self.frame:GetRight() - self.frame:GetWidth() / 2
		local newY = self.frame:GetTop()

		self.moving = self.owner.options.BarStyle == "NoAnim" and "nextEnlarge" or "enlarge"
		self.moveAnchor = newAnchor
		self.moveOffsetX = -(newX - oldX)
		self.moveOffsetY = -(newY - oldY)
		self.moveElapsed = 0

		self.frame:ClearAllPoints()
		self.frame:SetPoint("TOP", newAnchor, "BOTTOM", self.moveOffsetX, self.moveOffsetY)
	end

	local function animateEnlarge(self, elapsed)
		self.moveElapsed = self.moveElapsed + elapsed

		if self.moveElapsed < 1 then
			local options = self.owner.options
			local newX = self.moveOffsetX + (options.HugeBarXOffset - self.moveOffsetX) * (self.moveElapsed / 1)
			local newY = self.moveOffsetY + (options.HugeBarYOffset - self.moveOffsetY) * (self.moveElapsed / 1)
			local newWidth = options.Width + (options.HugeWidth - options.Width) * (self.moveElapsed / 1)
			local newScale = options.Scale + (options.HugeScale - options.Scale) * (self.moveElapsed / 1)

			self.frame:ClearAllPoints()
			self.frame:SetPoint(self.movePoint, self.moveAnchor, self.moveRelPoint, newX, newY)

			local db = E.db.addOnSkins
			local width = newWidth
			local iconHeight = db.dbmBarHeight * newScale
			local height = (db.DBMSkinHalf and iconHeight / 3) or iconHeight
			local fontSize = db.dbmFontSize * newScale

			self.frame:Size(width, height)
			self._bar:Size(width, height)

			self._icon1.overlay:Size(iconHeight)
			self._icon2.overlay:Size(iconHeight)

			self._name:SetFont(self._font, fontSize, db.dbmFontOutline)
			self._timer:SetFont(self._font, fontSize, db.dbmFontOutline)
		else
			self.moving = nil
			self.enlarged = true
			self.owner.hugeBars:Append(self)
			self:ApplyStyle()
			self:SetPosition()
		end
	end

	S:SecureHook(DBT, "CreateBar", function(self)
		local hooked
		for bar in pairs(self.bars) do
			if not hooked then
				local mt = getmetatable(bar).__index

				hooksecurefunc(mt, "ApplyStyle", applyStyle)
				if not backportVersion then
					S:Hook(mt, "Update", preUpdate)
				end

				mt.SetPosition = setPosition
				mt.MoveToNextPosition = moveToNextPosition
				mt.Enlarge = enlarge
				mt.AnimateEnlarge = animateEnlarge

				hooked = true
			end

			bar:ApplyStyle()
			bar:SetPosition()
		end

		S:Unhook(DBT, "CreateBar")
	end)

	local function SkinBoss()
		local db = E.db.addOnSkins

		local count = 1
		local bar = _G["DBM_BossHealth_Bar_" .. count]
		local barName, background, progress, name, timer
		local point1, anchor, point2

		while bar do
			point1, anchor, point2 = bar:GetPoint()
			if not point1 then return end

			barName = bar:GetName()
			background = _G[barName .. "BarBorder"]
			progress = _G[barName .. "Bar"]
			name = _G[barName .. "BarName"]
			timer = _G[barName .. "BarTimer"]

			bar:ClearAllPoints()

			bar:Height(db.dbmBarHeight)
			bar:SetTemplate("Transparent")

			background:SetNormalTexture(nil)

			progress:SetStatusBarTexture(E.media.normTex)
			progress:ClearAllPoints()
			progress:SetInside(bar)

			name:ClearAllPoints()
			name:Point("LEFT", bar, "LEFT", 4, 0)
			name:SetFont(E.LSM:Fetch("font", db.dbmFont), db.dbmFontSize, db.dbmFontOutline)

			timer:ClearAllPoints()
			timer:Point("RIGHT", bar, "RIGHT", -4, 0)
			timer:SetFont(E.LSM:Fetch("font", db.dbmFont), db.dbmFontSize, db.dbmFontOutline)

			if DBM.Options.HealthFrameGrowUp then
				bar:Point(point1, anchor, point2, 0, count == 1 and 8 or 4)
			else
				bar:Point(point1, anchor, point2, 0, -(count == 1 and 8 or 4))
			end

			count = count + 1
			bar = _G["DBM_BossHealth_Bar_" .. count]
		end
	end

	hooksecurefunc(DBM.BossHealth, "Show", SkinBoss)
	hooksecurefunc(DBM.BossHealth, "AddBoss", SkinBoss)
	hooksecurefunc(DBM.BossHealth, "UpdateSettings", SkinBoss)

	S:SecureHook(DBM.RangeCheck, "Show", function(self)
		if not DBMRangeCheck then return end

		DBMRangeCheck:SetTemplate("Transparent")
		E:GetModule("Tooltip"):HookScript(DBMRangeCheck, "OnShow", "SetStyle")

		S:Unhook(self, "Show")
	end)

	S:RawHook("RaidNotice_AddMessage", function(noticeFrame, textString, colorInfo)
		if find(textString, " |T") then
			textString = gsub(textString, "(:12:12)", ":18:18:0:0:64:64:5:59:5:59")
		end

		return S.hooks.RaidNotice_AddMessage(noticeFrame, textString, colorInfo)
	end, true)

	if DBM.ShowUpdateReminder then
		S:SecureHook(DBM, "ShowUpdateReminder", function(self)
			DBMUpdateReminder:SetTemplate("Transparent")
			DBMUpdateReminder:EnableMouse(true)

			local editBox, button = DBMUpdateReminder:GetChildren()

			local left, right, middle = select(6, DBMUpdateReminder:GetChildren():GetRegions())
			left:Hide()
			right:Hide()
			middle:Hide()
			editBox:Height(22)
			S:HandleEditBox(editBox)

			S:HandleButton(button)

			S:Unhook(self, "ShowUpdateReminder")
		end)
	end
end)

S:AddCallbackForAddon("DBM-GUI", "DBM-GUI", function()
	if not E.private.addOnSkins.DBM then return end

	DBM_GUI_OptionsFrame:SetTemplate("Transparent")

	DBM_GUI_OptionsFrameHeader:Point("TOP", 0, 7)
	DBM_GUI_OptionsFrameHeader:Hide()

	DBM_GUI_OptionsFramePanelContainer:SetTemplate("Transparent")

	S:HandleTab(DBM_GUI_OptionsFrameTab1)
	S:HandleTab(DBM_GUI_OptionsFrameTab2)

	DBM_GUI_OptionsFrameTab1:Point("BOTTOMLEFT", DBM_GUI_OptionsFrameBossMods, "TOPLEFT", 6, -4)
	DBM_GUI_OptionsFrameTab1Text:SetPoint("CENTER", 0, 0)
	DBM_GUI_OptionsFrameTab2Text:SetPoint("CENTER", 0, 0)

	S:HandleScrollBar(DBM_GUI_OptionsFramePanelContainerFOVScrollBar)
	DBM_GUI_OptionsFramePanelContainerFOVScrollBar:Point("TOPRIGHT", 18, -16)
	DBM_GUI_OptionsFramePanelContainerFOVScrollBar:Point("BOTTOMRIGHT", 18, 14)

	S:HandleButton(DBM_GUI_OptionsFrameOkay)

	if DBM_GUI_OptionsFrameWebsiteButton then
		S:HandleButton(DBM_GUI_OptionsFrameWebsiteButton)
	end

	S:SecureHookScript(DBM_GUI_OptionsFrame, "OnShow", function(self)
		DBM_GUI_OptionsFrameBossMods:StripTextures()
		DBM_GUI_OptionsFrameBossMods:SetTemplate("Transparent")

		DBM_GUI_OptionsFrameBossModsList:StripTextures()
		S:HandleScrollBar(DBM_GUI_OptionsFrameBossModsListScrollBar)
		DBM_GUI_OptionsFrameBossModsListScrollBar:Point("TOPRIGHT", 1, -18)
		DBM_GUI_OptionsFrameBossModsListScrollBar:Point("BOTTOMLEFT", 7, 18)

		for _, button in ipairs(DBM_GUI_OptionsFrameBossMods.buttons) do
			S:HandleCollapseExpandButton(button.toggle, "auto")
			button.toggle:Point("TOPLEFT", 3, 0)
		end

		DBM_GUI_OptionsFrameDBMOptions:StripTextures()
		DBM_GUI_OptionsFrameDBMOptions:SetTemplate("Transparent")

		DBM_GUI_OptionsFrameDBMOptionsList:StripTextures()
		S:HandleScrollBar(DBM_GUI_OptionsFrameDBMOptionsListScrollBar)
		DBM_GUI_OptionsFrameDBMOptionsListScrollBar:Point("TOPRIGHT", 1, -18)
		DBM_GUI_OptionsFrameDBMOptionsListScrollBar:Point("BOTTOMLEFT", 7, 18)

		for _, button in ipairs(DBM_GUI_OptionsFrameDBMOptions.buttons) do
			S:HandleCollapseExpandButton(button.toggle, "auto")
			button.toggle:Point("TOPLEFT", 3, 0)
		end

		S:Unhook(self, "OnShow")
	end)
--[[
	hooksecurefunc(DBM_GUI_OptionsFrame, "DisplayButton", function(self, button, element)
		button.toggle:Point("LEFT", 8 * element.depth - 5, 2);
	end)
--]]
	S:RawHook(DBM_GUI, "CreateNewPanel", function(self, ...)
		local panel = S.hooks[DBM_GUI].CreateNewPanel(self, ...)

		local PanelPrototype = getmetatable(panel).__index

		hooksecurefunc(PanelPrototype, "CreateArea", function(this)
			this.areas[#this.areas].frame:SetTemplate("Transparent", nil, true)
			this.areas[#this.areas].frame:SetBackdropColor(0, 0, 0, 0)
		end)
--[[
		S:RawHook(PanelPrototype, "CreateCheckButton", function(this, name, autoplace, ...)
			local button = S.hooks[PanelPrototype].CreateCheckButton(this, name, autoplace, ...)

			if button then
				S:HandleCheckBox(button, true)

				if autoplace then
					local _, lastObj = button:GetPoint()
					if lastObj.mytype == "checkbutton" then
						button:Point("TOPLEFT", lastObj, "BOTTOMLEFT", 0, -7)
					end
				end

				return button
			end
		end)
		S:RawHook(PanelPrototype, "CreateEditBox", function(this, ...)
			local editbox = S.hooks[PanelPrototype].CreateEditBox(this, ...)
			S:HandleEditBox(editbox)
			return editbox
		end)
		S:RawHook(PanelPrototype, "CreateSlider", function(this, ...)
			local slider = S.hooks[PanelPrototype].CreateSlider(this, ...)
			S:HandleSliderFrame(slider)
			return slider
		end)
		S:RawHook(PanelPrototype, "CreateButton", function(this, ...)
			local button = S.hooks[PanelPrototype].CreateButton(this, ...)
			S:HandleButton(button)
			return button
		end)
--]]
		S:Unhook(DBM_GUI, "CreateNewPanel")

		return panel
	end)
--[[
	DBM_GUI_DropDown:SetTemplate("Transparent")

	local dropdownArrowColor = {1, 0.8, 0}
	S:RawHook(DBM_GUI, "CreateDropdown", function(self, ...)
		local dropdown = S.hooks[DBM_GUI].CreateDropdown(self, ...)

		local frameName = dropdown:GetName()
		local button = _G[frameName.."Button"]
		local text = _G[frameName.."Text"]

		dropdown:StripTextures()
		dropdown:SetTemplate()
		dropdown:Size(dropdown:GetWidth(), 20)

		if button then
			S:HandleNextPrevButton(button, "down", dropdownArrowColor)
			button:ClearAllPoints()
			button:Point("RIGHT", dropdown, "RIGHT", -3, 0)
			button:Size(16)
		end

		if text then
			text:ClearAllPoints()
			text:Point("RIGHT", button, "LEFT", -3, 0)
		end

		return dropdown
	end)
--]]
end)
