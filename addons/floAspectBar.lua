local E, L, V, P, G, _ = unpack(ElvUI);
local addon = E:GetModule("AddOnSkins");

if(not addon:CheckAddOn("FloAspectBar")) then return; end

function addon:FloAspectBar()
	local AB = E:GetModule("ActionBars");
	
	FloAspectBar:SetTemplate();
	for i = 1, 10 do
		local button = _G["FloAspectBarButton"..i];
		AB:StyleButton(button);
	end
end

addon:RegisterSkin("FloAspectBar", addon.FloAspectBar);