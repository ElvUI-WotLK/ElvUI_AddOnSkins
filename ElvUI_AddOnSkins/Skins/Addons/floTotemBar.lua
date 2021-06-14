local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

if not AS:IsAddonLODorEnabled("FloTotemBar") then return end

local _G = _G
local unpack = unpack

-- FloTotemBar 3.3.0.16
-- https://www.curseforge.com/wow/addons/flo-totem-bar/files/399321

S:AddCallbackForAddon("FloTotemBar", "FloTotemBar", function()
	if not E.private.addOnSkins.FloTotemBar then return end

	if E.myclass ~= "HUNTER" and E.myclass ~= "SHAMAN" then return end

	local AB = E:GetModule("ActionBars")

	if not S:IsHooked("FloLib_ShowBorders") then
		S:RawHook("FloLib_ShowBorders", function(self)
			if self.globalSettings.borders then
				if not self.template then
					self:SetTemplate("Transparent")
				end
				if self.settings and self.settings.color then
					self:SetBackdropBorderColor(unpack(self.settings.color))
				end
			else
				self:SetBackdrop(nil)
				self.template = nil
			end
		end)
	end

	local function skinFrame(frame)
		FloLib_ShowBorders(frame)

		frame:SetClampedToScreen(true)

		local frameName = frame:GetName()
		if frameName == "FloBarTRAP" then
			for i = 1, 3 do
				local countdown = _G[frameName.."Countdown"..i]
				countdown:SetStatusBarTexture(E.media.normTex)
				E:RegisterStatusBar(countdown)
			end
		elseif frameName ~= "FloBarCALL" then
			local statusbar = _G[frameName.."Countdown"]
			statusbar:SetStatusBarTexture(E.media.normTex)
			E:RegisterStatusBar(statusbar)
		end

		for i = 1, 10 do
			local button = _G[frameName.."Button"..i]
			AB:StyleButton(button)

			if frameName ~= "FloBarTRAP" and frameName ~= "FloBarCALL" then
				FloSwitchButton_OnLeave(button)
			end
		end
	end

	if FLO_CLASS_NAME == "HUNTER" then
		skinFrame(FloBarTRAP)
	elseif FLO_CLASS_NAME == "SHAMAN" then
		skinFrame(FloBarCALL)
		skinFrame(FloBarEARTH)
		skinFrame(FloBarFIRE)
		skinFrame(FloBarWATER)
		skinFrame(FloBarAIR)
	end
end)