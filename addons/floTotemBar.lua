local E, L, V, P, G, _ = unpack(ElvUI);
local addon = E:GetModule("AddOnSkins");

if(not addon:CheckAddOn("FloTotemBar")) then return; end

function addon:FloTotemBar()
	local AB = E:GetModule("ActionBars");
	
	FloBarTRAP:SetTemplate();
	for i = 1, 10 do
		local button = _G["FloBarTRAPButton"..i];
		AB:StyleButton(button);
	end
	
	for i = 1, 3 do
		local countdown = _G["FloBarTRAPCountdown"..i];
		countdown:SetStatusBarTexture(E["media"].normTex);
		E:RegisterStatusBar(countdown);
	end
end

addon:RegisterSkin("FloTotemBar", addon.FloTotemBar);