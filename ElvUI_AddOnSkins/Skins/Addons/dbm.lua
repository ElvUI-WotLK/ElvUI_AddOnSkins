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

	local function createIconOverlay(id, parent)
		local frame = CreateFrame("Frame", "$parentIcon" .. id .. "Overlay", parent)
		frame:SetTemplate()

		if id == 1 then
			frame:Point("RIGHT", parent, "LEFT", -(E.Border + E.Spacing), 0)
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
		spark:Kill()

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

		frame:Size(barWidth, barHeight)
		bar:Size(barWidth, barHeight)

		icon1.overlay:Size(barHeight)
		icon2.overlay:Size(barHeight)

		name:Point("LEFT", 5, 0)
		name:SetFont(self._font, fontSize, db.dbmFontOutline)

		timer:Point("RIGHT", -5, 0)
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

	local function setPosition(self)
		if self.moving == "enlarge" then return end

		local anchor = (self.prev and self.prev.frame) or (self.enlarged and self.owner.secAnchor) or self.owner.mainAnchor

		self.frame:ClearAllPoints()
		if self.owner.options.ExpandUpwards then
			self.frame:SetPoint("BOTTOM", anchor, "TOP", self.owner.options.BarXOffset, self.owner.options.BarYOffset)
		else
			self.frame:SetPoint("TOP", anchor, "BOTTOM", self.owner.options.BarXOffset, -self.owner.options.BarYOffset)
		end
	end

	local function moveToNextPosition(self, oldX, oldY)
		if self.moving == "enlarge" then return end

		local newAnchor = (self.prev and self.prev.frame) or (self.enlarged and self.owner.secAnchor) or self.owner.mainAnchor
		oldX = oldX or (self.frame:GetRight() - self.frame:GetWidth() / 2)
		oldY = oldY or (self.frame:GetTop())

		self.frame:ClearAllPoints()
		if self.owner.options.ExpandUpwards then
			self.frame:SetPoint("BOTTOM", newAnchor, "TOP", self.owner.options.BarXOffset, self.owner.options.BarYOffset)
		else
			self.frame:SetPoint("TOP", newAnchor, "BOTTOM", self.owner.options.BarXOffset, -self.owner.options.BarYOffset)
		end

		local newX = self.frame:GetRight() - self.frame:GetWidth() / 2
		local newY = self.frame:GetTop()

		self.moving = "move"
		self.moveAnchor = newAnchor
		self.moveOffsetX = -(newX - oldX)
		self.moveOffsetY = -(newY - oldY)
		self.moveElapsed = 0

		if self.owner.options.ExpandUpwards then
			self.movePoint = "BOTTOM"
			self.moveRelPoint = "TOP"
			self.frame:SetPoint("BOTTOM", newAnchor, "TOP", self.moveOffsetX, self.moveOffsetY)
		else
			self.movePoint = "TOP"
			self.moveRelPoint = "BOTTOM"
			self.moveOffsetY = -self.moveOffsetY
			self.frame:SetPoint("TOP", newAnchor, "BOTTOM", self.moveOffsetX, self.moveOffsetY)
		end
	end

	local function enlarge(self)
		local newAnchor = (self.owner.hugeBars.last and self.owner.hugeBars.last.frame) or self.owner.secAnchor
		local oldX = self.frame:GetRight() - self.frame:GetWidth() / 2
		local oldY = self.frame:GetTop()

		self.frame:ClearAllPoints()
		if self.owner.options.ExpandUpwards then
			self.frame:SetPoint("BOTTOM", newAnchor, "TOP", self.owner.options.BarXOffset, self.owner.options.BarYOffset)
		else
			self.frame:SetPoint("TOP", newAnchor, "BOTTOM", self.owner.options.BarXOffset, -self.owner.options.BarYOffset)
		end

		local newX = self.frame:GetRight() - self.frame:GetWidth() / 2
		local newY = self.frame:GetTop()

		self.moving = "enlarge"
		self.movePoint = "TOP"
		self.moveRelPoint = "BOTTOM"
		self.moveAnchor = newAnchor
		self.moveOffsetX = -(newX - oldX)
		self.moveOffsetY = -(newY - oldY)
		self.moveElapsed = 0

		self.frame:SetPoint("TOP", newAnchor, "BOTTOM", self.moveOffsetX, -self.moveOffsetY)
	end

	local function animateEnlarge(self, elapsed)
		self.moveElapsed = self.moveElapsed + elapsed

		local newX = self.moveOffsetX + (self.owner.options.BarXOffset - self.moveOffsetX) * (self.moveElapsed / 1)
		local newY = self.moveOffsetY + (self.owner.options.BarYOffset - self.moveOffsetY) * (self.moveElapsed / 1)

		local db = E.db.addOnSkins
		local scale = self.owner.options.Scale + (self.owner.options.HugeScale - self.owner.options.Scale) * (self.moveElapsed / 1)
		local width = self.owner.options.Width * scale
		local height = db.dbmBarHeight * scale
		local fontSize = db.dbmFontSize * scale

		if (self.moveOffsetY > 0 and newY > self.owner.options.BarYOffset) or (self.moveOffsetY < 0 and newY < self.owner.options.BarYOffset) then
			self.frame:ClearAllPoints()
			self.frame:SetPoint(self.movePoint, self.moveAnchor, self.moveRelPoint, newX, newY)
			self.frame:Size(width, height)
			self._bar:Size(width, height)

			self._icon1.overlay:Size(height)
			self._icon2.overlay:Size(height)

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

	local function SkinBars(self)
		for bar in self:GetBarIterator() do
			if not bar.injected then
				hooksecurefunc(bar, "ApplyStyle", applyStyle)

				bar.SetPosition = setPosition
				bar.MoveToNextPosition = moveToNextPosition
				bar.Enlarge = enlarge
				bar.AnimateEnlarge = animateEnlarge

				bar.injected = true

				bar:ApplyStyle()
				bar:SetPosition()
			end
		end
	end

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

			progress:SetStatusBarTexture(E["media"].normTex)
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

	hooksecurefunc(DBT, "CreateBar", SkinBars)
	hooksecurefunc(DBM.BossHealth, "Show", SkinBoss)
	hooksecurefunc(DBM.BossHealth, "AddBoss", SkinBoss)
	hooksecurefunc(DBM.BossHealth, "UpdateSettings", SkinBoss)

	S:SecureHook(DBM.RangeCheck, "Show", function(self)
		DBMRangeCheck:SetTemplate("Transparent")
		S:Unhook(self, "Show")
	end)

	S:RawHook("RaidNotice_AddMessage", function(noticeFrame, textString, colorInfo)
		if find(textString, " |T") then
			textString = gsub(textString, "(:12:12)", ":18:18:0:0:64:64:5:59:5:59")
		end

		return S.hooks.RaidNotice_AddMessage(noticeFrame, textString, colorInfo)
	end, true)
end)

S:AddCallbackForAddon("DBM-GUI", "DBM-GUI", function()
	if not E.private.addOnSkins.DBM then return end

	DBM_GUI_OptionsFrame:HookScript("OnShow", function(self)
		self:StripTextures()
		self:SetTemplate("Transparent")
		DBM_GUI_OptionsFrameBossMods:StripTextures()
		DBM_GUI_OptionsFrameBossMods:SetTemplate("Transparent")
		DBM_GUI_OptionsFrameDBMOptions:StripTextures()
		DBM_GUI_OptionsFrameDBMOptions:SetTemplate("Transparent")
		DBM_GUI_OptionsFramePanelContainer:SetTemplate("Transparent")
	end)

	S:HandleButton(DBM_GUI_OptionsFrameOkay)
	S:HandleScrollBar(DBM_GUI_OptionsFramePanelContainerFOVScrollBar)

	S:HandleTab(DBM_GUI_OptionsFrameTab1)
	S:HandleTab(DBM_GUI_OptionsFrameTab2)
end)