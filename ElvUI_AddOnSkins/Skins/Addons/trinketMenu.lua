local E, L, V, P, G, _ = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

if not AS:IsAddonLODorEnabled("TrinketMenu") then return end

local _G = _G

-- TrinketMenu 3.81
-- https://www.curseforge.com/wow/addons/trinket-menu/files/305868

S:AddCallbackForAddon("TrinketMenu", "TrinketMenu", function()
	if not E.private.addOnSkins.TrinketMenu then return end

	hooksecurefunc(TrinketMenu, "ReflectLock", function()
		TrinketMenu_MainFrame:SetTemplate("Transparent")
		TrinketMenu_MenuFrame:SetTemplate("Transparent")
	end)

	local AB = E:GetModule("ActionBars")

	local function skinButton(button)
		local name = button:GetName()
		local cooldown = _G[name .. "Cooldown"]

		AB:StyleButton(button)

		cooldown.timer = E:CreateCooldownTimer(cooldown)
		_G[name .. "Time"] = cooldown.timer.text
	end

--	TrinketMenu_TimersFrame:SetScript("OnUpdate", nil)
	TrinketMenu.WriteWornCooldowns = E.noop
	TrinketMenu.WriteMenuCooldowns = E.noop
	TrinketMenu.WriteCooldown = E.noop

	for i = 0, 1 do
		skinButton(_G["TrinketMenu_Trinket" .. i])
	end

	for i = 1, 30 do
		skinButton(_G["TrinketMenu_Menu"..i])
	end
end)