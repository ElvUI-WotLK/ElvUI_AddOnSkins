local E, L, V, P, G, _ = unpack(ElvUI);
local AB = E:GetModule("ActionBars");
local S = E:GetModule("Skins");

local function LoadSkin()
	if(not E.private.addOnSkins.FloAspectBar) then return; end

	FloAspectBar:SetTemplate("Default");
	for i = 1, 10 do
		local button = _G["FloAspectBarButton" .. i];
		AB:StyleButton(button);
	end
end

S:AddCallbackForAddon("FloAspectBar", "FloAspectBar", LoadSkin);