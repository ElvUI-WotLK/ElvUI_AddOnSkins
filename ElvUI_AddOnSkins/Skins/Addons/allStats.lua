local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")

-- All Stats 1.1
-- https://www.curseforge.com/wow/addons/all-stats/files/430951

local function LoadSkin()
	if not E.private.addOnSkins.AllStats then return end

	AllStatsFrame:StripTextures()
	AllStatsFrame:SetTemplate("Transparent")
	AllStatsFrame:Height(424)
	AllStatsFrame:Point("TOPLEFT", PaperDollFrame, "TOPLEFT", 351, -12)

	AllStatsButtonShowFrame:Height(21)
	AllStatsButtonShowFrame:Point("BOTTOMRIGHT", -40, 84)
	S:HandleButton(AllStatsButtonShowFrame)
end

S:AddCallbackForAddon("AllStats", "AllStats", LoadSkin)