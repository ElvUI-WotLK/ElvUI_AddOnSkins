local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")

local function LoadSkin()
	if not E.private.addOnSkins.BigWigs then return end

	local candy = LibStub("LibCandyBar-3.0")

	local offset = E:Scale(E.PixelMode and 1 or 3)
	hooksecurefunc(candy.barPrototype, "Start", function(self)
		if self.IsSkinned then return end

		self:CreateBackdrop("Transparent")

		hooksecurefunc(self, "SetPoint", function(self, point, attachTo, anchorPoint, xOffset, yOffset)
			if (point == "BOTTOMLEFT" and yOffset ~= offset) or (point == "TOPLEFT" and yOffset ~= -offset) then
				self:SetPoint(point, attachTo, anchorPoint, 0, point == "BOTTOMLEFT" and offset or -offset)
			end
		end)

		self.IsSkinned = true
	end)
end

S:AddCallbackForAddon("BigWigs_Plugins", "BigWigs_Plugins", LoadSkin)