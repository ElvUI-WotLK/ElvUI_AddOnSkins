local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")

local function LoadSkin()
	if not E.private.addOnSkins.BigWigs then return end

	local db = E.db.addOnSkins

	local offset = E:Scale(E.PixelMode and 1 or 3)
	local function SetPoint(self, point, attachTo, anchorPoint, xOffset, yOffset)
		if (point == "BOTTOMLEFT" and yOffset ~= offset) or (point == "TOPLEFT" and yOffset ~= -offset) then
			self:SetPoint(point, attachTo, anchorPoint, 0, point == "BOTTOMLEFT" and offset or -offset)
		end
	end

	local function SetScale(bar)
		local scale = bar:GetScale()
		bar:SetScale(1)

		bar:SetSize(bar.width * scale, bar.height * scale)
		if bar.candyBarIconFrame:GetTexture() then
			bar.candyBarIconFrame:SetWidth(bar.height * scale)
		end
		bar.candyBarLabel:SetFont(bar.candyBarLabel:GetFont(), db.bigwigsFontSize * scale, db.bigwigsFontOutline)
		bar.candyBarDuration:SetFont(bar.candyBarLabel:GetFont(), db.bigwigsFontSize * scale, db.bigwigsFontOutline)
	end

	local candy = LibStub("LibCandyBar-3.0")
	hooksecurefunc(candy.barPrototype, "Start", function(self)
		self.height = db.bigwigsBarHeight

		if not self.num then self.num = 0 end
		self.num = self.num + 1

		SetScale(self)

		if self.IsSkinned then return end

		self:CreateBackdrop("Transparent")

		hooksecurefunc(self, "SetPoint", SetPoint)

		self.IsSkinned = true
	end)

	hooksecurefunc(candy.barPrototype, "Stop", function(self)
		self.num = 0
	end)

	local plugin = BigWigs:GetPlugin("Bars")
	hooksecurefunc(plugin, "EmphasizeBar", function(_, bar)
		bar.num = bar.num + 1
		if bar.num == 3 then
			SetScale(bar)
		end
	end)
end

S:AddCallbackForAddon("BigWigs_Plugins", "BigWigs_Plugins", LoadSkin)