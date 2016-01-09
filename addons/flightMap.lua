local E, L, V, P, G, _ = unpack(ElvUI);
local addon = E:GetModule("AddOnSkins");

if(not addon:CheckAddOn("FlightMap")) then return; end

function addon:FlightMap()
	FlightMapTimesFrame:StripTextures();
	FlightMapTimesFrame:CreateBackdrop("Default");
	
	FlightMapTimesFrame:SetStatusBarTexture(E.media.glossTex);
	
	FlightMapTimesText:ClearAllPoints();
	FlightMapTimesText:SetPoint("CENTER", FlightMapTimesFrame, "CENTER", 0, 0);
end

addon:RegisterSkin("FlightMap", addon.FlightMap);