local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

if not AS:IsAddonLODorEnabled("LoseControl") then return end

local _G = _G
local unpack = unpack

local hooksecurefunc = hooksecurefunc

-- LoseControl 3.33
-- https://www.curseforge.com/wow/addons/losecontrol/files/417954

S:AddCallbackForAddon("LoseControl", "LoseControl", function()
	if not E.private.addOnSkins.LoseControl then return end

	local framePrefix = "LoseControl"

	local frameUnits = {
		"player",
		"target",
		"focus",
		"party1",
		"party2",
		"party3",
		"party4",
		"arena1",
		"arena2",
		"arena3",
		"arena4",
		"arena5",
	}

	local function fixParent(self, parent)
		if not parent then
			self:SetParent(UIParent)
		end
	end

	local function skinIcon(frame)
		if not frame or frame.inSkinned then return end

		frame:CreateBackdrop()

		frame.texture:SetAllPoints(frame)
		frame.texture:SetTexCoord(unpack(E.TexCoords))

		E:RegisterCooldown(frame)

		hooksecurefunc(frame, "SetParent", fixParent)
		frame.SetSize = frame.Size

		frame.inSkinned = true
	end

	for _, frameUnit in ipairs(frameUnits) do
		skinIcon(_G[framePrefix..frameUnit])
	end

	hooksecurefunc(_G["LoseControlplayer"].__index, "new", function(_, unitID)
		skinIcon(_G[framePrefix..unitID])
	end)
end)