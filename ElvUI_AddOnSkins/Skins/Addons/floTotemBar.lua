local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

if not AS:IsAddonLODorEnabled("FloTotemBar") then return end

-- FloTotemBar 3.3.0.16
-- https://www.curseforge.com/wow/addons/flo-totem-bar/files/399321

S:AddCallbackForAddon("FloTotemBar", "FloTotemBar", function()
	if not E.private.addOnSkins.FloTotemBar then return end

	local AB = E:GetModule("ActionBars")

	local function toggleBorders(self)
		if self.globalSettings.borders then
			self:SetTemplate("Transparent")
			if self.settings and self.settings.color then
				self:SetBackdropBorderColor(unpack(self.settings.color))
			end
		else
			FloLib_HideBorders(self)
		end
	end

	if not S:IsHooked("FloLib_ShowBorders") then
		S:SecureHook("FloLib_ShowBorders", toggleBorders)
	end

	local function skinFrame(frame)
		FloLib_ShowBorders(frame)

		frame:SetClampedToScreen(true)

		local frameCountDown = _G[frame:GetName().."Countdown"]
		if frameCountDown then
			frameCountDown:SetStatusBarTexture(E.media.normTex)
			E:RegisterStatusBar(frameCountDown)
		end

		for i = 1, frame:GetNumChildren() do
			local child = select(i, frame:GetChildren())
			if child then
				if child:IsObjectType("CheckButton") then
					AB:StyleButton(child)
				end
			end
		end
	end

	if FLO_CLASS_NAME == "HUNTER" then
		skinFrame(FloBarTRAP)
	elseif FLO_CLASS_NAME == "SHAMAN" then
		for _, frame in ipairs({FloBarCALL, FloBarEARTH, FloBarFIRE, FloBarWATER, FloBarAIR}) do
			skinFrame(frame)
		end
	end
end)