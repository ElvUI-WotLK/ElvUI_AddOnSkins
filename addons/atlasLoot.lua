local E, L, V, P, G, _ = unpack(ElvUI);
local addon = E:GetModule("AddOnSkins");

if(not addon:CheckAddOn("AtlasLoot")) then return; end

function addon:AtlasLoot()
	local S = E:GetModule("Skins");
	AtlasLootDefaultFrame:StripTextures();
	AtlasLootDefaultFrame:SetTemplate("Transparent");
	
	S:HandleCloseButton(AtlasLootDefaultFrame_CloseButton);
	S:HandleButton(AtlasLootDefaultFrame_LoadModules);
	S:HandleButton(AtlasLootDefaultFrame_Options);
	S:HandleButton(AtlasLootDefaultFrame_Menu);
	S:HandleButton(AtlasLootDefaultFrame_SubMenu);
	AtlasLootDefaultFrame_LootBackground:SetTemplate("Default", nil, true);
	AtlasLootDefaultFrame_LootBackground_Back:SetTexture(0, 0, 0, 0);
	S:HandleButton(AtlasLootDefaultFrame_Preset1);
	S:HandleButton(AtlasLootDefaultFrame_Preset2);
	S:HandleButton(AtlasLootDefaultFrame_Preset3);
	S:HandleButton(AtlasLootDefaultFrame_Preset4);
	S:HandleEditBox(AtlasLootDefaultFrameSearchBox);
	AtlasLootDefaultFrameSearchBox:SetPoint("BOTTOM", AtlasLootDefaultFrame, "BOTTOM", -78, 30);
	AtlasLootDefaultFrameSearchBox:Height(22);
	S:HandleButton(AtlasLootDefaultFrameSearchButton);
	AtlasLootDefaultFrameSearchButton:SetPoint("LEFT", AtlasLootDefaultFrameSearchBox, "RIGHT", 3, 0);
	S:HandleNextPrevButton(AtlasLootDefaultFrameSearchOptionsButton);
	AtlasLootDefaultFrameSearchOptionsButton:SetPoint("LEFT", AtlasLootDefaultFrameSearchButton, "RIGHT", 2, 0);
	AtlasLootDefaultFrameSearchOptionsButton:SetSize(24, 24);
	S:HandleButton(AtlasLootDefaultFrameSearchClearButton);
	AtlasLootDefaultFrameSearchClearButton:SetPoint("LEFT", AtlasLootDefaultFrameSearchOptionsButton, "RIGHT", 2, 0);
	S:HandleButton(AtlasLootDefaultFrameLastResultButton);
	AtlasLootDefaultFrameLastResultButton:SetPoint("LEFT", AtlasLootDefaultFrameSearchClearButton, "RIGHT", 2, 0);
	S:HandleButton(AtlasLootDefaultFrameWishListButton);
	AtlasLootDefaultFrameWishListButton:SetPoint("RIGHT", AtlasLootDefaultFrameSearchBox, "LEFT", -2, 0);
	
	S:HandleCloseButton(AtlasLootItemsFrame_CloseButton);
	
	for i = 1, 30 do
		_G["AtlasLootItem_" .. i .. "_Icon"]:SetTexCoord(unpack(E.TexCoords));
		_G["AtlasLootItem_" .. i]:CreateBackdrop("Default");
		_G["AtlasLootItem_" .. i].backdrop:SetOutside(_G["AtlasLootItem_" .. i .. "_Icon"]);
		
		_G["AtlasLootMenuItem_" .. i .. "_Icon"]:SetTexCoord(unpack(E.TexCoords));
		_G["AtlasLootMenuItem_" .. i]:CreateBackdrop("Default");
		_G["AtlasLootMenuItem_" .. i].backdrop:SetOutside(_G["AtlasLootMenuItem_" .. i .. "_Icon"]);
	end
	
	S:HandleButton(AtlasLoot10Man25ManSwitch);
	S:HandleCheckBox(AtlasLootItemsFrame_Heroic);
	S:HandleButton(AtlasLootItemsFrame_BACK);
	S:HandleNextPrevButton(AtlasLootItemsFrame_NEXT);
	S:HandleButton(AtlasLootServerQueryButton);
	S:HandleNextPrevButton(AtlasLootQuickLooksButton);
	S:HandleCheckBox(AtlasLootFilterCheck);
	S:HandleNextPrevButton(AtlasLootItemsFrame_PREV);
	
	AtlasLootItemsFrame_Back:SetTexture(0, 0, 0, 0);
end

addon:RegisterSkin("AtlasLoot", addon.AtlasLoot);