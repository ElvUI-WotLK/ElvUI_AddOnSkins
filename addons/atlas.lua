local E, L, V, P, G = unpack(ElvUI);
local addon = E:GetModule("AddOnSkins");
local S = E:GetModule("Skins");

if(not addon:CheckAddOn("Atlas")) then return; end

function addon:Atlas()
	AtlasFrame:StripTextures();
	AtlasFrame:SetTemplate("Transparent");
	
	AtlasMap:SetDrawLayer("BORDER")
	
	--S:HandleButton(AtlasFrameCloseButton);
	--S:HandleButton(AtlasFrameLockButton);
	
	S:HandleDropDownBox(AtlasFrameDropDownType);
	S:HandleDropDownBox(AtlasFrameDropDown);
	
	S:HandleEditBox(AtlasSearchEditBox);
	AtlasSearchEditBox:Height(22);
	
	S:HandleButton(AtlasSwitchButton);
	AtlasSwitchButton:Height(24);
	S:HandleButton(AtlasSearchButton);
	AtlasSearchButton:Height(24);
	AtlasSearchButton:SetPoint("LEFT", AtlasSearchEditBox, "RIGHT", 3, 0);
	S:HandleButton(AtlasSearchClearButton);
	AtlasSearchClearButton:Height(24);
	AtlasSearchClearButton:SetPoint("LEFT", AtlasSearchButton, "RIGHT", 2, 0);
	S:HandleButton(AtlasFrameOptionsButton);
	
	S:HandleScrollBar(AtlasScrollBarScrollBar);
	
	S:HandleCheckBox(AtlasOptionsFrameToggleButton);
	S:HandleCheckBox(AtlasOptionsFrameAutoSelect);
	S:HandleCheckBox(AtlasOptionsFrameRightClick);
	S:HandleCheckBox(AtlasOptionsFrameAcronyms);
	S:HandleCheckBox(AtlasOptionsFrameClamped);
	S:HandleCheckBox(AtlasOptionsFrameCtrl);
	
	S:HandleSliderFrame(AtlasOptionsFrameSliderButtonPos);
	S:HandleSliderFrame(AtlasOptionsFrameSliderButtonRad);
	S:HandleSliderFrame(AtlasOptionsFrameSliderAlpha);
	S:HandleSliderFrame(AtlasOptionsFrameSliderScale);
	
	S:HandleDropDownBox(AtlasOptionsFrameDropDownCats);
	
	S:HandleButton(AtlasOptionsFrameResetPosition);
end

addon:RegisterSkin("Atlas", addon.Atlas);