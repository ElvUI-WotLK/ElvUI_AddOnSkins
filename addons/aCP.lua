local E, L, V, P, G = unpack(ElvUI);
local S = E:GetModule("Skins");

local function LoadSkin()
	if(not E.private.addOnSkins.ACP) then return; end

	ACP_AddonList:StripTextures();
	ACP_AddonList:SetTemplate("Transparent");
	ACP_AddonList_ScrollFrame:StripTextures();
	ACP_AddonList_ScrollFrame:CreateBackdrop("Default");

	S:HandleButton(GameMenuButtonAddOns);
	S:HandleButton(ACP_AddonListDisableAll);
	S:HandleButton(ACP_AddonListEnableAll);
	S:HandleButton(ACP_AddonList_ReloadUI);
	S:HandleButton(ACP_AddonListSetButton);
	S:HandleButton(ACP_AddonListBottomClose);
	S:HandleCloseButton(ACP_AddonListCloseButton);
	S:HandleScrollBar(ACP_AddonList_ScrollFrameScrollBar);
	S:HandleCheckBox(ACP_AddonList_NoRecurse);
	S:HandleDropDownBox(ACP_AddonListSortDropDown, 130);

	for i = 1, 20 do
		S:HandleButton(_G["ACP_AddonListEntry" .. i .. "LoadNow"]);
		S:HandleCheckBox(_G["ACP_AddonListEntry" .. i.. "Enabled"]);
	end

	ACP_AddonList_ScrollFrame:Width(590);
	ACP_AddonList_ScrollFrame:Height(412);
	ACP_AddonList:Height(502);
	ACP_AddonListEntry1:Point("TOPLEFT", ACP_AddonList, "TOPLEFT", 47, -62);
	ACP_AddonList_ScrollFrame:Point("TOPLEFT", ACP_AddonList, "TOPLEFT", 20, -53);
	ACP_AddonListCloseButton:Point("TOPRIGHT", ACP_AddonList, "TOPRIGHT", 4, 5);
	ACP_AddonListSetButton:Point("BOTTOMLEFT", ACP_AddonList, "BOTTOMLEFT", 20, 8);
	ACP_AddonListDisableAll:Point("BOTTOMLEFT", ACP_AddonList, "BOTTOMLEFT", 90, 8);
	ACP_AddonListEnableAll:Point("BOTTOMLEFT", ACP_AddonList, "BOTTOMLEFT", 175, 8);
	ACP_AddonList_ReloadUI:Point("BOTTOMRIGHT", ACP_AddonList, "BOTTOMRIGHT", -160, 8);
	ACP_AddonListBottomClose:Point("BOTTOMRIGHT", ACP_AddonList, "BOTTOMRIGHT", -50, 8);
	ACP_AddonList:SetScale(UIParent:GetScale());
end

S:AddCallbackForAddon("ACP", "ACP", LoadSkin);