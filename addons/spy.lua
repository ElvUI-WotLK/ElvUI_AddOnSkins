local E, L, V, P, G, _ = unpack(ElvUI);
local S = E:GetModule("Skins");

local function LoadSkin()
	if(not E.private.addOnSkins.Spy) then return; end

	Spy_MainWindow:StripTextures();
	Spy_MainWindow:SetTemplate("Transparent");

	Spy_AlertWindow:StripTextures();
	Spy_AlertWindow:SetTemplate("Transparent");
	Spy_AlertWindow:Point("TOP", UIParent, "TOP", 0, -130);

	S:HandleCloseButton(Spy_MainWindow.CloseButton);
end

S:AddCallbackForAddon("Spy", "Spy", LoadSkin);