local E, L, V, P, G = unpack(ElvUI);
local addon = E:GetModule("AddOnSkins");

if(not addon:CheckAddOn("VanasKoS")) then return; end

function addon:VanasKoS()
	local S = E:GetModule("Skins");

	VanasKoS_WarnFrame:SetTemplate("Transparent", nil, true);
	VanasKoS_WarnFrame.SetBackdropBorderColor = E.noop;

	for i = 1, 2 do
		S:HandleTab(_G["VanasKoSFrameTab" .. i]);
	end

	S:HandleDropDownBox(VanasKoSFrameChooseListDropDown, 145);

	S:HandleCheckBox(VanasKoSListFrameCheckBox);

	S:HandleButton(VanasKoSListFrameAddButton);
	VanasKoSListFrameAddButton:SetPoint("BOTTOMRIGHT", VanasKoSListFrame, "BOTTOMRIGHT", -39, 79);
	S:HandleButton(VanasKoSListFrameRemoveButton);
	VanasKoSListFrameRemoveButton:SetPoint("RIGHT", VanasKoSListFrameAddButton, "LEFT", -2, 0);
	S:HandleButton(VanasKoSListFrameChangeButton);
	VanasKoSListFrameChangeButton:SetPoint("RIGHT", VanasKoSListFrameRemoveButton, "LEFT", -2, 0);
	S:HandleButton(VanasKoSListFrameConfigurationButton);
	VanasKoSListFrameConfigurationButton:SetPoint("BOTTOM", VanasKoSListFrameAddButton, "TOP", 0, 2);

	for i = 1, 9 do
		_G["VanasKoSListFrameColButton" .. i]:StripTextures();
	end

	VanasKoSListFrameToggleRightButton:Size(27);
	S:HandleNextPrevButton(VanasKoSListFrameToggleRightButton);
	VanasKoSListFrameToggleRightButton:SetPoint("BOTTOMRIGHT", VanasKoSListFrame, "BOTTOMRIGHT", -39, 127);
	VanasKoSListFrameToggleLeftButton:Size(27);
	S:HandleNextPrevButton(VanasKoSListFrameToggleLeftButton);

	VanasKoSListFrameNoTogglePatch:StripTextures();

	VanasKoSListScrollFrame:StripTextures();
	S:HandleScrollBar(VanasKoSListScrollFrameScrollBar);

	VanasKoSListFrameSearchBox:SetSize(215, 20);
	S:HandleEditBox(VanasKoSListFrameSearchBox);
	VanasKoSListFrameSearchBox:SetPoint("BOTTOMLEFT", VanasKoSListFrame, "BOTTOMLEFT", 17, 104);

	VanasKoSFrame:StripTextures(true);
	VanasKoSFrame:CreateBackdrop("Transparent");
	VanasKoSFrame.backdrop:Point("TOPLEFT", 11, -12);
	VanasKoSFrame.backdrop:Point("BOTTOMRIGHT", -34, 75);

	S:HandleCloseButton(VanasKosFrameCloseButton);
	
	S:HandleTab(FriendsFrameTab6);

	S:HandleDropDownBox(VanasKoSPvPStatsCharacterDropDown, 90);
	VanasKoSPvPStatsCharacterDropDown:SetPoint("RIGHT", VanasKoSListFrameToggleLeftButton, "LEFT", 6, -4);
	S:HandleDropDownBox(VanasKoSPvPStatsTimeSpanDropDown, 90);
	VanasKoSPvPStatsTimeSpanDropDown:SetPoint("RIGHT", VanasKoSPvPStatsCharacterDropDown, "LEFT", 26, 0);
end

addon:RegisterSkin("VanasKoS", addon.VanasKoS);