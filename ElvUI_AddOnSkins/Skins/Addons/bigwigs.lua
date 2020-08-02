local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

if not AS:IsAddonLODorEnabled("BigWigs_Plugins") then return end

-- BigWigs r7558
-- https://www.curseforge.com/wow/addons/big-wigs/files/458195

S:AddCallbackForAddon("BigWigs_Plugins", "BigWigs_Plugins", function()
	if not E.private.addOnSkins.BigWigs then return end

	AS:SkinLibrary("LibCandyBar-3.0")

	local db = E.db.addOnSkins

	local function scaleToSize(bar)
		local scale = bar:GetScale()

		bar:SetScale(1)
		bar:Size(bar.width * scale, bar.height * scale)

		bar.candyBarIconFrame:Width(bar.height * scale)
		bar.candyBarLabel:SetFont(bar.candyBarLabel:GetFont(), db.bigwigsFontSize * scale, db.bigwigsFontOutline)
		bar.candyBarDuration:SetFont(bar.candyBarLabel:GetFont(), db.bigwigsFontSize * scale, db.bigwigsFontOutline)
	end

	local candy = LibStub("LibCandyBar-3.0")
	hooksecurefunc(candy.barPrototype_mt.__index, "Start", function(self)
		if self:Get("bigwigs:module") and not self:Get("bigwigs:emphasized") then
			self.height = db.bigwigsBarHeight
			scaleToSize(self)
		end
	end)

	local plugin = BigWigs:GetPlugin("Bars")
	hooksecurefunc(plugin, "EmphasizeBar", function(_, bar)
		scaleToSize(bar)
	end)
end)