local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

if not AS:IsAddonLODorEnabled("AllStats") then return end

-- All Stats 1.1
-- https://www.curseforge.com/wow/addons/all-stats/files/430951

S:AddCallbackForAddon("AllStats", "AllStats", function()
	if not E.private.addOnSkins.AllStats then return end

	AllStatsFrame:StripTextures()
	AllStatsFrame:SetTemplate("Transparent")
	AllStatsFrame:Height(424)
	AllStatsFrame:Point("TOPLEFT", PaperDollFrame, "TOPLEFT", 351, -12)

	S:HandleButton(AllStatsButtonShowFrame)
	AllStatsButtonShowFrame:Height(21)

	if CharacterFrameExpandButton then
		AllStatsButtonShowFrame:Point("BOTTOMRIGHT", -40, 84)
	else
		AllStatsButtonShowFrame:Point("BOTTOMRIGHT", -60, 84)
	end
end)