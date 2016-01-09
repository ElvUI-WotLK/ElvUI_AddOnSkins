local E, L, V, P, G, _ = unpack(ElvUI);
local addon = E:GetModule("AddOnSkins");

if(not addon:CheckAddOn("Atlas")) then return; end

function addon:Atlas()
	local S = E:GetModule("Skins");
	
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
	
end

addon:RegisterSkin("Atlas", addon.Atlas);