local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

if not AS:IsAddonLODorEnabled("FloAspectBar") then return end

-- FloAspectBar 3.3.0.16
-- https://www.curseforge.com/wow/addons/flo-aspect-bar/files/399320

S:AddCallbackForAddon("FloAspectBar", "FloAspectBar", function()
	if not E.private.addOnSkins.FloAspectBar then return end

	if FLO_CLASS_NAME ~= "HUNTER" then return end

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

	FloAspectBar:SetClampedToScreen(true)

	FloLib_ShowBorders(FloAspectBar)

	for i = 1, 10 do
		AB:StyleButton(_G["FloAspectBarButton" .. i])
	end
end)