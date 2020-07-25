local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

if not AS:IsAddonLODorEnabled("FloTotemBar") then return end

-- FloTotemBar 3.3.0.16
-- https://www.curseforge.com/wow/addons/flo-totem-bar/files/399321

S:AddCallbackForAddon("FloTotemBar", "FloTotemBar", function()
	if not E.private.addOnSkins.FloTotemBar then return end

	local AB = E:GetModule("ActionBars")

	if FLO_CLASS_NAME == "HUNTER" then
		FloBarTRAP:SetTemplate("Transparent")

		for i = 1, 10 do
			AB:StyleButton(_G["FloBarTRAPButton" .. i])
		end

		for i = 1, 3 do
			local countdown = _G["FloBarTRAPCountdown" .. i]
			countdown:SetStatusBarTexture(E.media.normTex)
			E:RegisterStatusBar(countdown)
		end
	elseif FLO_CLASS_NAME == "SHAMAN" then
		FloBarEARTH:SetTemplate("Transparent")
		FloBarFIRE:SetTemplate("Transparent")
		FloBarWATER:SetTemplate("Transparent")
		FloBarAIR:SetTemplate("Transparent")
		FloBarCALL:SetTemplate("Transparent")

		FloBarEARTHCountdown:SetStatusBarTexture(E.media.normTex)
		FloBarFIRECountdown:SetStatusBarTexture(E.media.normTex)
		FloBarWATERCountdown:SetStatusBarTexture(E.media.normTex)
		FloBarAIRCountdown:SetStatusBarTexture(E.media.normTex)

		E:RegisterStatusBar(FloBarEARTHCountdown)
		E:RegisterStatusBar(FloBarFIRECountdown)
		E:RegisterStatusBar(FloBarWATERCountdown)
		E:RegisterStatusBar(FloBarAIRCountdown)

		for i = 1, 10 do
			AB:StyleButton(_G["FloBarEARTHButton" .. i])
			AB:StyleButton(_G["FloBarFIREButton" .. i])
			AB:StyleButton(_G["FloBarWATERButton" .. i])
			AB:StyleButton(_G["FloBarAIRButton" .. i])
			AB:StyleButton(_G["FloBarWATERButton" .. i])
			AB:StyleButton(_G["FloBarCALLButton" .. i])
		end
	end

	function FloLib_ShowBorders(self)
		self:SetTemplate("Transparent")
	end
end)