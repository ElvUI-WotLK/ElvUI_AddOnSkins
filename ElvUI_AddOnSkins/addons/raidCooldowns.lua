local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")

-- RaidCooldowns 3.3.5

local function LoadSkin()
	if not E.private.addOnSkins.RaidCooldowns then return end

	local RaidCooldowns = LibStub("AceAddon-3.0"):GetAddon("RaidCooldowns", true)
	if not RaidCooldowns then return end

	local mod = RaidCooldowns:GetModule("Display")
	if not mod then return end

	mod.configOptions.args.display.args.height.max = 30

	local function onClick(self)
		if not IsShiftKeyDown() then return end
		if GetNumRaidMembers() == 0 then return end

		local parent = self:GetParent()
		if parent.value > 0 then
			SendChatMessage(format("%s: %s %s", parent.caster, GetSpellInfo(parent.spellId), format(ITEM_COOLDOWN_TOTAL, format("%.2d:%.2d", parent.value / 60 % 60, ceil(parent.value % 60)))), "RAID")
		end
	end

	local function HookTimerGroup(frame)
		S:RawHook(frame, "NewTimerBar", function(self, ...)
			local bar, isNew = S.hooks[self].NewTimerBar(self, ...)

			if isNew and not bar.isSkinned then
				bar:CreateBackdrop("Transparent")
				bar.bgtexture:Hide()
				S:HandleIcon(bar.icon)
				
				bar.iconButton = CreateFrame("Button", nil, bar)
				bar.iconButton:Point("TOPLEFT", bar.icon, "TOPLEFT")
				bar.iconButton:Point("BOTTOMRIGHT", bar, "BOTTOMRIGHT")
				bar.iconButton:RegisterForClicks("LeftButtonUp")
				bar.iconButton:SetScript("OnClick", onClick)
				
				bar.spark:Kill()

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

		list.spacing = E.Border
		list.button:SetBackdrop(nil)
		list.button:CreateBackdrop("Transparent")

		return list
	end)
end

S:AddCallbackForAddon("RaidCooldowns", "RaidCooldowns", LoadSkin)