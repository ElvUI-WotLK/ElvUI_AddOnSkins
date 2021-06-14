local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

if not AS:IsAddonLODorEnabled("FeralbyNight") then return end

local _G = _G
local ipairs = ipairs
local unpack = unpack

local hooksecurefunc = hooksecurefunc

-- FeralbyNight 3.321
-- https://www.curseforge.com/wow/addons/fbn/files/441598

S:AddCallbackForAddon("FeralbyNight", "FeralbyNight", function()
	if not E.private.addOnSkins.FeralbyNight then return end
	if E.myclass ~= "DRUID" or E.mylevel < 80 then return end

	local function setAlpha(self, alpha)
		self.backdrop:SetAlpha(alpha)
	end
	local function setTexture(self, texture)
		if texture then
			self.backdrop:Show()
		else
			self.backdrop:Hide()
		end
	end
	local function setScale(self, scale)
		if self.__scaleBlock then return end

		self.__scaleBlock = true
		self:SetScale(1)
		self.__scaleBlock = nil

		for _, child in ipairs({self:GetChildren()}) do
			if child:IsObjectType("Frame") then
				if not child.__baseWidth then
					child.__baseWidth, child.__baseHeight = child:GetSize()
					child.__basePointX, child.__basePointY = select(4, child:GetPoint())
				end

				local a1, p, a2 = child:GetPoint()
				child:Size(child.__baseWidth * scale, child.__baseHeight * scale)
				child:Point(a1, p, a2, child.__basePointX * scale, child.__basePointY * scale)
			end
		end
	end

	local function styleIcon(texture)
		hooksecurefunc(texture, "SetAlpha", setAlpha)
		hooksecurefunc(texture, "SetTexture", setTexture)

		texture:CreateBackdrop("Default")
		texture:SetDrawLayer("BORDER")
		texture:SetTexture(texture:GetTexture())
		texture:SetTexCoord(unpack(E.TexCoords))
	end

	local lists = {
		"abilitycdmon1",
		"abilitycdmon2",
		"abilitycdmon3",
		"bossfight",
		"myfight",
		"proc",
		"textureList",
	}

	for _, list in ipairs(lists) do
		for _, texture in pairs(FeralbyNight[list]) do
			styleIcon(texture)
		end
	end

	FeralbyNightDisplayFrame_current_cooldown:SetAllPoints(FeralbyNightDisplayFrame_current)

	local frames = {
		"FeralbyNightcdmonFrame1",
		"FeralbyNightcdmonFrame2",
		"FeralbyNightcdmonFrame3",
		"FeralbyNightbossfightFrame",
		"FeralbyNightmyfightFrame",
		"FeralbyNightDisplayFrame",
	}

	for _, frame in ipairs(frames) do
		frame = _G[frame]
		hooksecurefunc(frame, "SetScale", setScale)
		frame:SetScale(frame:GetScale())
	end

	FeralbyNightHudFrame_healthbar:Point("BOTTOM", FeralbyNightHudFrame, 0, -17)
	FeralbyNightHudFrame_powerbar:Point("BOTTOM", FeralbyNightHudFrame_healthbar, "TOP", 0, 1)
	FeralbyNightHudFrame_castbar:Point("BOTTOM", FeralbyNightHudFrame_powerbar, "TOP", 0, 1)
	FeralbyNightHudFrame_bosshealthbar:Point("TOP", FeralbyNightHudFrame, 0, 17)
	FeralbyNightHudFrame_bosspowerbar:Point("TOP", FeralbyNightHudFrame_bosshealthbar, "BOTTOM", 0, -1)
	FeralbyNightHudFrame_manabar:Point("BOTTOMLEFT", -7, 0)
	FeralbyNightHudFrame_threatbar:Point("BOTTOMRIGHT", 7, 0)

	local ufs = {
		"FeralbyNightHudFrame_powerbar",
		"FeralbyNightHudFrame_castbar",
		"FeralbyNightHudFrame_healthbar",
		"FeralbyNightHudFrame_bosspowerbar",
		"FeralbyNightHudFrame_bosshealthbar",
		"FeralbyNightHudFrame_manabar",
		"FeralbyNightHudFrame_threatbar"
	}

	local frame, statusbar
	for _, frameName in ipairs(ufs) do
		frame = _G[frameName]
		statusbar = _G[frameName.."_frame"]

		frame:SetBackdrop(nil)
		frame:CreateBackdrop("Transparent")

		frame:SetFrameStrata("BACKGROUND")
	--	statusbar:SetFrameStrata("LOW")
	--	statusbar.text
		statusbar:Size(frame:GetSize())
	--	statusbar:SetStatusBarTexture(E.media.normTex)
	--	E:RegisterStatusBar(statusbar)

		hooksecurefunc(frame, "SetScale", setScale)
		frame:SetScale(frame:GetScale())
	end
end)