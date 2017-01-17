local E, L, V, P, G = unpack(ElvUI);
local S = E:GetModule("Skins");

local function LoadSkin()
	if(not E.private.addOnSkins.GnomishVendorShrinker) then return; end

	GVSEditBox:StripTextures();
	S:HandleEditBox(GVSEditBox);
	GVSEditBox:Width(135);
	GVSEditBox:Height(19);
	GVSEditBox:SetScale(1);
	GVSMerchantFrame:CreateBackdrop("Transparent");
	S:HandleButton(GVSScrollButton1);
	S:HandleButton(GVSScrollButton2);
	GVSScrollFrame:StripTextures();
	S:HandleSliderFrame(GVSScrollBar);
end

S:AddCallbackForAddon("GnomishVendorShrinker", "GnomishVendorShrinker", LoadSkin);