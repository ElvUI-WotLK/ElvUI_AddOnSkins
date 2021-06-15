local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

if not AS:IsAddonLODorEnabled("Omen") then return end

-- Omen 3.0.9
-- https://www.wowace.com/projects/omen-threat-meter/files/404746

S:AddCallbackForAddon("Omen", "Omen", function()
	if not E.private.addOnSkins.Omen then return end

	hooksecurefunc(Omen, "UpdateBars", function(self)
		self.TitleText:Width(self.Title:GetWidth() - 16)
		self.TitleText:Height(16)
	end)

	hooksecurefunc(Omen, "UpdateBackdrop", function(self)
		self.Title:SetTemplate(E.db.addOnSkins.omenTitleTemplate, E.db.addOnSkins.omenTitleTemplate == "Default" and E.db.addOnSkins.omenTitleTemplateGloss or false)
		self.BarList:SetTemplate(E.db.addOnSkins.omenTemplate, E.db.addOnSkins.omenTemplate == "Default" and E.db.addOnSkins.omenTemplateGloss or false)
	end)

	hooksecurefunc(Omen, "UpdateTitleBar", function(self)
		self.BarList:ClearAllPoints()

		if not Omen.db.profile.TitleBar.ShowTitleBar then
			self.BarList:SetPoint("TOPLEFT", self.Title, "BOTTOMLEFT", 0, 0)
		else
			self.BarList:Point("TOPLEFT", self.Title, "BOTTOMLEFT", 0, -(E.PixelMode and 1 or 3))
		end
		self.BarList:SetPoint("BOTTOMRIGHT", self.Anchor, "BOTTOMRIGHT", 0, 0)
	end)

	hooksecurefunc(Omen, "UpdateBackdrop", function(self)
		self:UpdateTitleBar()
	end)
end)