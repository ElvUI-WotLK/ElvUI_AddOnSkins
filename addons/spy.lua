local E, L, V, P, G, _ = unpack(ElvUI);
local addon = E:GetModule("AddOnSkins");

if(not addon:CheckAddOn("Spy")) then return; end

function addon:Spy()
	Spy_MainWindow:StripTextures();
	Spy_MainWindow:SetTemplate("Transparent");
end

addon:RegisterSkin("Spy", addon.Spy);