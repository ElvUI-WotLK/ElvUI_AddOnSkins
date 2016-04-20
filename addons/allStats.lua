local E, L, V, P, G = unpack(ElvUI);
local addon = E:GetModule("AddOnSkins");

if(not addon:CheckAddOn("AllStats")) then return; end

function addon:AllStats()
	local S = E:GetModule("Skins");

	AllStatsFrame:StripTextures();
	AllStatsFrame:SetTemplate("Transparent");
	AllStatsFrame:Height(424);
	AllStatsFrame:Point("TOPLEFT",PaperDollFrame, "TOPLEFT", 351, -12);
	S:HandleButton(AllStatsButtonShowFrame);
end

addon:RegisterSkin("AllStats", addon.AllStats);