local E, L, V, P, G = unpack(ElvUI);
local addon = E:GetModule("AddOnSkins");

if(not addon:CheckAddOn("GnomishVendorShrinker")) then return; end

function addon:GnomishVendorShrinker()
	local S = E:GetModule("Skins");

	GVSEditBox:StripTextures();
	S:HandleEditBox(GVSEditBox);
	GVSEditBox:SetWidth(135);
	GVSEditBox:SetHeight(19);
	GVSEditBox:SetScale(1.07);
	GVSMerchantFrame:CreateBackdrop("Transparent");
	S:HandleButton(GVSScrollButton1);
	S:HandleButton(GVSScrollButton2);
	GVSScrollFrame:StripTextures();
	S:HandleSliderFrame(GVSScrollBar);
end

addon:RegisterSkin("GnomishVendorShrinker", addon.GnomishVendorShrinker);