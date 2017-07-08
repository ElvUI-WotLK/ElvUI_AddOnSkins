local E, L, V, P, G, _ = unpack(ElvUI);
local S = E:GetModule("Skins");

local function LoadSkin()
	if(not E.private.addOnSkins.AtlasLoot) then return; end

	AtlasLootTooltip:HookScript("OnShow", function(self)
		self:SetTemplate("Transparent");

		local iLink = select(2, self:GetItem());
		local quality = iLink and select(3, GetItemInfo(iLink));
		if(quality and quality >= 2) then
			self:SetBackdropBorderColor(GetItemQualityColor(quality));
		else
			self:SetBackdropBorderColor(unpack(E["media"].bordercolor));
		end
	end);

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
	AtlasLootDefaultFrameSearchBox:Point("BOTTOM", AtlasLootDefaultFrame, "BOTTOM", -78, 30);
	AtlasLootDefaultFrameSearchBox:Height(22);
	S:HandleButton(AtlasLootDefaultFrameSearchButton);
	AtlasLootDefaultFrameSearchButton:Point("LEFT", AtlasLootDefaultFrameSearchBox, "RIGHT", 3, 0);
	S:HandleNextPrevButton(AtlasLootDefaultFrameSearchOptionsButton);
	AtlasLootDefaultFrameSearchOptionsButton:Point("LEFT", AtlasLootDefaultFrameSearchButton, "RIGHT", 2, 0);
	AtlasLootDefaultFrameSearchOptionsButton:SetSize(24, 24);
	S:HandleButton(AtlasLootDefaultFrameSearchClearButton);
	AtlasLootDefaultFrameSearchClearButton:Point("LEFT", AtlasLootDefaultFrameSearchOptionsButton, "RIGHT", 2, 0);
	S:HandleButton(AtlasLootDefaultFrameLastResultButton);
	AtlasLootDefaultFrameLastResultButton:Point("LEFT", AtlasLootDefaultFrameSearchClearButton, "RIGHT", 2, 0);
	S:HandleButton(AtlasLootDefaultFrameWishListButton);
	AtlasLootDefaultFrameWishListButton:Point("RIGHT", AtlasLootDefaultFrameSearchBox, "LEFT", -2, 0);

	S:HandleCloseButton(AtlasLootItemsFrame_CloseButton);

	S:HandleButton(AtlasLootInfoHidePanel);

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

	S:HandleCheckBox(AtlasLootOptionsFrameDefaultTT);
	S:HandleCheckBox(AtlasLootOptionsFrameLootlinkTT);
	S:HandleCheckBox(AtlasLootOptionsFrameItemSyncTT);
	S:HandleCheckBox(AtlasLootOptionsFrameOpaque);
	S:HandleCheckBox(AtlasLootOptionsFrameItemID);
	S:HandleCheckBox(AtlasLootOptionsFrameLoDStartup);
	S:HandleCheckBox(AtlasLootOptionsFrameSafeLinks);
	S:HandleCheckBox(AtlasLootOptionsFrameEquipCompare);
	S:HandleCheckBox(AtlasLootOptionsFrameItemSpam);
	S:HandleCheckBox(AtlasLootOptionsFrameHidePanel);

	S:HandleDropDownBox(AtlasLoot_SelectLootBrowserStyle);
	S:HandleDropDownBox(AtlasLoot_CraftingLink);

	S:HandleSliderFrame(AtlasLootOptionsFrameLootBrowserScale);

	S:HandleButton(AtlasLootOptionsFrame_ResetWishlist);
	S:HandleButton(AtlasLootOptionsFrame_ResetAtlasLoot);
	S:HandleButton(AtlasLootOptionsFrame_ResetQuicklooks);
	S:HandleButton(AtlasLootOptionsFrame_FuBarShow);
	S:HandleButton(AtlasLootOptionsFrame_FuBarHide);

	AtlasLootPanel:StripTextures();
	AtlasLootPanel:SetTemplate("Transparent");

	S:HandleButton(AtlasLootPanel_WorldEvents);
	AtlasLootPanel_WorldEvents:Point("LEFT", AtlasLootPanel, "LEFT", 7, 29);
	S:HandleButton(AtlasLootPanel_Sets);
	AtlasLootPanel_Sets:Point("LEFT", AtlasLootPanel_WorldEvents, "RIGHT", 2, 0);
	S:HandleButton(AtlasLootPanel_Reputation);
	AtlasLootPanel_Reputation:Point("LEFT", AtlasLootPanel_Sets, "RIGHT", 2, 0);
	S:HandleButton(AtlasLootPanel_PvP);
	AtlasLootPanel_PvP:Point("LEFT", AtlasLootPanel_Reputation, "RIGHT", 2, 0);
	S:HandleButton(AtlasLootPanel_Crafting);
	AtlasLootPanel_Crafting:Point("LEFT", AtlasLootPanel_PvP, "RIGHT", 2, 0);
	S:HandleButton(AtlasLootPanel_WishList);
	AtlasLootPanel_WishList:Point("LEFT", AtlasLootPanel_Crafting, "RIGHT", 2, 0);
	S:HandleButton(AtlasLootPanel_Options);
	S:HandleButton(AtlasLootPanel_LoadModules);
	S:HandleButton(AtlasLootPanel_Preset1);
	S:HandleButton(AtlasLootPanel_Preset2);
	S:HandleButton(AtlasLootPanel_Preset3);
	S:HandleButton(AtlasLootPanel_Preset4);

	S:HandleEditBox(AtlasLootSearchBox);
	AtlasLootSearchBox:Height(20);
	S:HandleButton(AtlasLootSearchButton);
	AtlasLootSearchButton:Height(22);
	AtlasLootSearchButton:Point("LEFT", AtlasLootSearchBox, "RIGHT", 3, 0);
	S:HandleNextPrevButton(AtlasLootSearchOptionsButton);
	AtlasLootSearchOptionsButton:Point("LEFT", AtlasLootSearchButton, "RIGHT", 2, 0);
	S:HandleButton(AtlasLootSearchClearButton);
	AtlasLootSearchClearButton:Height(22);
	AtlasLootSearchClearButton:Point("LEFT", AtlasLootSearchOptionsButton, "RIGHT", 2, 0);
	S:HandleButton(AtlasLootLastResultButton);
	AtlasLootLastResultButton:Height(22);
	AtlasLootLastResultButton:Point("LEFT", AtlasLootSearchClearButton, "RIGHT", 2, 0);

	hooksecurefunc("AtlasLoot_SetupForAtlas", function()
		AtlasLootPanel:ClearAllPoints();
		AtlasLootPanel:SetParent(AtlasFrame);
		AtlasLootPanel:Point("TOP", "AtlasFrame", "BOTTOM", 0, -2);
	end);

	local function SkinDewdrop()
		local frame
		local i = 1

		while _G["Dewdrop20Level" .. i] do
			frame = _G["Dewdrop20Level" .. i]

			if not frame.isSkinned then
				frame:SetTemplate("Transparent")

				select(1, frame:GetChildren()):Hide()
				frame.SetBackdropColor = E.noop
				frame.SetBackdropBorderColor = E.noop

				frame.isSkinned = true
			end

			i = i + 1
		end

		i = 1
		while _G["Dewdrop20Button"..i] do
			if not _G["Dewdrop20Button" .. i].isHook then
				_G["Dewdrop20Button" .. i]:HookScript("OnEnter", function(self)
					if not self.disabled and self.hasArrow then
						SkinDewdrop()
					end
				end)
				_G["Dewdrop20Button" .. i].isHook = true
			end

			i = i + 1
		end
	end

	E:GetModule("AddOnSkins"):SkinLibrary("Dewdrop-2.0")

	if E:GetModule("AddOnSkins"):CheckAddOn("AtlasLootFu") then
		E:GetModule("AddOnSkins"):SkinLibrary("AceAddon-2.0")
		E:GetModule("AddOnSkins"):SkinLibrary("Tablet-2.0")
	end
end

S:AddCallbackForAddon("AtlasLoot", "AtlasLoot", LoadSkin);