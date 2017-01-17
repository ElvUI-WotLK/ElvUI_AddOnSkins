local E, L, V, P, G = unpack(ElvUI);
local S = E:GetModule("Skins");

local function LoadSkin()
	if(not E.private.addOnSkins.AllStats) then return; end

	AllStatsFrame:StripTextures();
	AllStatsFrame:SetTemplate("Transparent");
	AllStatsFrame:Height(424);
	AllStatsFrame:Point("TOPLEFT",PaperDollFrame, "TOPLEFT", 351, -12);
	S:HandleButton(AllStatsButtonShowFrame);
end

S:AddCallbackForAddon("AllStats", "AllStats", LoadSkin);