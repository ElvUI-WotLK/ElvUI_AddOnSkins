local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
-- Optional controls differ between supported addon versions. Keep missing
-- targets out of native skin handlers without masking other Lua errors.
local function SkinControl(method, frame, ...)
	if frame then return S[method](S, frame, ...) end
end
local function SkinFrame(frame, method, ...)
	if frame then return frame[method](frame, ...) end
end

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

		SkinFrame(bar, "SetScale", 1)
		SkinFrame(bar, "Size", bar.width * scale, bar.height * scale)

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
