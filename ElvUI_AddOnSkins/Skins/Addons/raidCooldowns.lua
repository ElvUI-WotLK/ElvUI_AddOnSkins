local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

if not AS:IsAddonLODorEnabled("RaidCooldowns") then return end

local ceil = math.ceil
local format = string.format

local GetNumRaidMembers = GetNumRaidMembers
local GetSpellInfo = GetSpellInfo
local IsShiftKeyDown = IsShiftKeyDown
local SendChatMessage = SendChatMessage

-- RaidCooldowns 3.3.5
-- https://www.wowace.com/projects/raid-cooldowns/files/441967

S:AddCallbackForAddon("RaidCooldowns", "RaidCooldowns", function()
	if not E.private.addOnSkins.RaidCooldowns then return end

	local RaidCooldowns = LibStub("AceAddon-3.0"):GetAddon("RaidCooldowns", true)
	if not RaidCooldowns then return end

	local mod = RaidCooldowns:GetModule("Display", true)
	if not mod then return end

	if mod.db.profile.texture == "Smooth v2" and LibStub("LibSharedMedia-3.0"):Fetch("statusbar", mod.db.profile.texture) == "Interface\\TargetingFrame\\UI-StatusBar" then
		mod.db.profile.texture = "Blizzard"
	end
	if not mod.db.profile.fontFace then
		mod.db.profile.fontFace = "PT Sans Narrow"
	end

	mod.configOptions.args.display.args.height.max = 30

	local function onClick(self)
		if not IsShiftKeyDown() or GetNumRaidMembers() == 0 then return end

		local parent = self:GetParent()
		if parent.value > 0 then
			SendChatMessage(format("%s: %s %s", parent.caster, GetSpellInfo(parent.spellId), format(ITEM_COOLDOWN_TOTAL, format("%.2d:%.2d", parent.value / 60 % 60, ceil(parent.value % 60)))), "RAID")
		end
	end

	local function HookTimerGroup(frame)
		S:RawHook(frame, "NewTimerBar", function(self, ...)
			local bar, isNew = S.hooks[self].NewTimerBar(self, ...)

			if isNew and not bar.isSkinned then
				bar.texture:CreateBackdrop("Transparent")
				bar.texture.backdrop:Point("TOPLEFT", bar, -1, 1)
				bar.texture.backdrop:Point("BOTTOMRIGHT", bar, 1, -1)

				bar.texture:Point("TOPLEFT", 1, 0)
				bar.texture:Point("BOTTOMLEFT", 1, 0)

				S:HandleIcon(bar.icon)

				bar.bgtexture:Hide()
				bar.spark:Kill()

				bar.iconButton = CreateFrame("Button", nil, bar)
				bar.iconButton:SetPoint("TOPLEFT", bar.icon)
				bar.iconButton:SetPoint("BOTTOMRIGHT", bar)
				bar.iconButton:RegisterForClicks("LeftButtonUp")
				bar.iconButton:SetScript("OnClick", onClick)

				bar.isSkinned = true
			end

			return bar, isNew
		end)
	end

	if RCDD_Anchor then
		RCDD_Anchor.button:SetBackdrop(nil)
		RCDD_Anchor.button:CreateBackdrop("Transparent")
		RCDD_Anchor.spacing = E.Border

		HookTimerGroup(RCDD_Anchor)
	end

	HookTimerGroup(mod)

	S:RawHook(mod, "NewBarGroup", function(self, ...)
		local list = S.hooks[self].NewBarGroup(self, ...)

		list.button:SetBackdrop(nil)
		list.button:CreateBackdrop("Transparent")
		list.spacing = E.Border

		return list
	end)
end)