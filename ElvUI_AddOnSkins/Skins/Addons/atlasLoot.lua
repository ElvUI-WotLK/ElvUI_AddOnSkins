local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
-- Optional controls differ between supported addon versions. Keep missing
-- targets out of native skin handlers without masking other Lua errors.
local function SkinControl(method, frame, ...)
	if frame then return S[method](S, frame, ...) end
end
local function SkinFrame(frame, method, ...)
	if frame then return frame[method](frame, ...) end
end

local AS = E:GetModule("AddOnSkins")

if not AS:IsAddonLODorEnabled("AtlasLoot") then return end

local select = select
local unpack = unpack

-- AtlasLoot Enhanced 5.11.04
-- https://www.curseforge.com/wow/addons/atlasloot-enhanced/files/445202

S:AddCallbackForAddon("AtlasLoot", "AtlasLoot", function()
	if not E.private.addOnSkins.AtlasLoot then return end

	SkinFrame(AtlasLootTooltip, "HookScript", "OnShow", function(self)
		SkinFrame(self, "SetTemplate", "Transparent", nil, true)

		local r, g, b = self:GetBackdropColor()
		SkinFrame(self, "SetBackdropColor", r, g, b, E.db.tooltip.colorAlpha)

		local iLink = select(2, self:GetItem())
		local quality = iLink and select(3, GetItemInfo(iLink))
		if quality and quality >= 2 then
			SkinFrame(self, "SetBackdropBorderColor", GetItemQualityColor(quality))
		else
			SkinFrame(self, "SetBackdropBorderColor", unpack(E.media.bordercolor))
		end
	end)

	SkinFrame(AtlasLootDefaultFrame, "StripTextures")
	SkinFrame(AtlasLootDefaultFrame, "SetTemplate", "Transparent")

	SkinControl("HandleCloseButton", AtlasLootDefaultFrame_CloseButton, AtlasLootDefaultFrame)

	SkinControl("HandleButton", AtlasLootDefaultFrame_Options)
	SkinControl("HandleButton", AtlasLootDefaultFrame_LoadModules)
	SkinControl("HandleButton", AtlasLootDefaultFrame_Menu)
	SkinControl("HandleButton", AtlasLootDefaultFrame_SubMenu)

	AtlasLootDefaultFrame_LootBackground_Back:SetTexture()
	SkinFrame(AtlasLootDefaultFrame_LootBackground, "SetTemplate", "Transparent")

	SkinControl("HandleButton", AtlasLootDefaultFrame_Preset1)
	SkinControl("HandleButton", AtlasLootDefaultFrame_Preset2)
	SkinControl("HandleButton", AtlasLootDefaultFrame_Preset3)
	SkinControl("HandleButton", AtlasLootDefaultFrame_Preset4)

	SkinControl("HandleButton", AtlasLootDefaultFrameWishListButton)
	SkinControl("HandleEditBox", AtlasLootDefaultFrameSearchBox)
	SkinControl("HandleButton", AtlasLootDefaultFrameSearchButton)
	SkinControl("HandleNextPrevButton", AtlasLootDefaultFrameSearchOptionsButton)
	SkinControl("HandleButton", AtlasLootDefaultFrameSearchClearButton)
	SkinControl("HandleButton", AtlasLootDefaultFrameLastResultButton)

	SkinFrame(AtlasLootDefaultFrame_Options, "Point", "TOPLEFT", 43, -11)
	SkinFrame(AtlasLootDefaultFrame_LoadModules, "Point", "TOPRIGHT", -42, -11)

	SkinFrame(AtlasLootDefaultFrame_Preset1, "Point", "BOTTOMLEFT", 83, 59)

	SkinFrame(AtlasLootDefaultFrameSearchBox, "Height", 22)
	SkinFrame(AtlasLootDefaultFrameSearchBox, "Point", "BOTTOM", AtlasLootDefaultFrame, "BOTTOM", -83, 29)

	SkinFrame(AtlasLootDefaultFrameSearchButton, "Point", "LEFT", AtlasLootDefaultFrameSearchBox, "RIGHT", 6, 0)

	SkinFrame(AtlasLootDefaultFrameSearchOptionsButton, "Size", 24)
	SkinFrame(AtlasLootDefaultFrameSearchOptionsButton, "Point", "LEFT", AtlasLootDefaultFrameSearchButton, "RIGHT", 5, 0)
	SkinFrame(AtlasLootDefaultFrameSearchClearButton, "Point", "LEFT", AtlasLootDefaultFrameSearchOptionsButton, "RIGHT", 5, 0)
	SkinFrame(AtlasLootDefaultFrameLastResultButton, "Point", "LEFT", AtlasLootDefaultFrameSearchClearButton, "RIGHT", 5, 0)
	SkinFrame(AtlasLootDefaultFrameWishListButton, "Point", "RIGHT", AtlasLootDefaultFrameSearchBox, "LEFT", -6, 0)

	SkinFrame(AtlasLootDefaultFrame_Notice, "Point", "BOTTOM", 0, 9)

	SkinControl("HandleCloseButton", AtlasLootItemsFrame_CloseButton)

	SkinControl("HandleButton", AtlasLootInfoHidePanel)

	for i = 1, 30 do
		SkinFrame(_G["AtlasLootItem_" .. i .. "_Icon"], "SetTexCoord", unpack(E.TexCoords))
		_G["AtlasLootItem_" .. i]:CreateBackdrop("Default")
		_G["AtlasLootItem_" .. i].backdrop:SetOutside(_G["AtlasLootItem_" .. i .. "_Icon"])

		SkinFrame(_G["AtlasLootMenuItem_" .. i .. "_Icon"], "SetTexCoord", unpack(E.TexCoords))
		_G["AtlasLootMenuItem_" .. i]:CreateBackdrop("Default")
		_G["AtlasLootMenuItem_" .. i].backdrop:SetOutside(_G["AtlasLootMenuItem_" .. i .. "_Icon"])
	end

	SkinControl("HandleButton", AtlasLoot10Man25ManSwitch)
	SkinControl("HandleButton", AtlasLootServerQueryButton)
	SkinControl("HandleCheckBox", AtlasLootItemsFrame_Heroic)
	SkinControl("HandleCheckBox", AtlasLootFilterCheck)
	SkinControl("HandleButton", AtlasLootItemsFrame_BACK)
	SkinControl("HandleNextPrevButton", AtlasLootQuickLooksButton)
	SkinControl("HandleNextPrevButton", AtlasLootItemsFrame_PREV)
	SkinControl("HandleNextPrevButton", AtlasLootItemsFrame_NEXT)

	AtlasLootItemsFrame_Back:SetTexture()

	SkinFrame(AtlasLoot10Man25ManSwitch, "Height", 24)
	SkinFrame(AtlasLootServerQueryButton, "Height", 24)
	SkinFrame(AtlasLootItemsFrame_BACK, "Height", 24)

	SkinFrame(AtlasLoot10Man25ManSwitch, "Point", "BOTTOM", -130, 3)
	SkinFrame(AtlasLootServerQueryButton, "Point", "BOTTOM", 131, 3)
	SkinFrame(AtlasLootItemsFrame_BACK, "Point", "BOTTOM", 0, 3)

	SkinFrame(AtlasLootItemsFrame_Heroic, "Point", "BOTTOM", -185, 28)
	SkinFrame(AtlasLootFilterCheck, "Point", "BOTTOM", 115, 28)
	SkinFrame(AtlasLootQuickLooksButton, "Point", "BOTTOM", 58, 32)

	SkinFrame(AtlasLootItemsFrame_PREV, "Point", "BOTTOMLEFT", 7, 6)
	SkinFrame(AtlasLootItemsFrame_NEXT, "Point", "BOTTOMRIGHT", -6, 6)

	SkinControl("HandleCheckBox", AtlasLootOptionsFrameDefaultTT)
	SkinControl("HandleCheckBox", AtlasLootOptionsFrameLootlinkTT)
	SkinControl("HandleCheckBox", AtlasLootOptionsFrameItemSyncTT)
	SkinControl("HandleCheckBox", AtlasLootOptionsFrameOpaque)
	SkinControl("HandleCheckBox", AtlasLootOptionsFrameItemID)
	SkinControl("HandleCheckBox", AtlasLootOptionsFrameLoDStartup)
	SkinControl("HandleCheckBox", AtlasLootOptionsFrameSafeLinks)
	SkinControl("HandleCheckBox", AtlasLootOptionsFrameEquipCompare)
	SkinControl("HandleCheckBox", AtlasLootOptionsFrameItemSpam)
	SkinControl("HandleCheckBox", AtlasLootOptionsFrameHidePanel)

	SkinControl("HandleDropDownBox", AtlasLoot_SelectLootBrowserStyle)
	SkinControl("HandleDropDownBox", AtlasLoot_CraftingLink)

	SkinControl("HandleSliderFrame", AtlasLootOptionsFrameLootBrowserScale)

	SkinControl("HandleButton", AtlasLootOptionsFrame_ResetWishlist)
	SkinControl("HandleButton", AtlasLootOptionsFrame_ResetAtlasLoot)
	SkinControl("HandleButton", AtlasLootOptionsFrame_ResetQuicklooks)
	SkinControl("HandleButton", AtlasLootOptionsFrame_FuBarShow)
	SkinControl("HandleButton", AtlasLootOptionsFrame_FuBarHide)

	SkinFrame(AtlasLootPanel, "StripTextures")
	SkinFrame(AtlasLootPanel, "SetTemplate", "Transparent")

	SkinControl("HandleButton", AtlasLootPanel_WorldEvents)
	SkinFrame(AtlasLootPanel_WorldEvents, "Point", "LEFT", AtlasLootPanel, "LEFT", 7, 29)
	SkinControl("HandleButton", AtlasLootPanel_Sets)
	SkinFrame(AtlasLootPanel_Sets, "Point", "LEFT", AtlasLootPanel_WorldEvents, "RIGHT", 2, 0)
	SkinControl("HandleButton", AtlasLootPanel_Reputation)
	SkinFrame(AtlasLootPanel_Reputation, "Point", "LEFT", AtlasLootPanel_Sets, "RIGHT", 2, 0)
	SkinControl("HandleButton", AtlasLootPanel_PvP)
	SkinFrame(AtlasLootPanel_PvP, "Point", "LEFT", AtlasLootPanel_Reputation, "RIGHT", 2, 0)
	SkinControl("HandleButton", AtlasLootPanel_Crafting)
	SkinFrame(AtlasLootPanel_Crafting, "Point", "LEFT", AtlasLootPanel_PvP, "RIGHT", 2, 0)
	SkinControl("HandleButton", AtlasLootPanel_WishList)
	SkinFrame(AtlasLootPanel_WishList, "Point", "LEFT", AtlasLootPanel_Crafting, "RIGHT", 2, 0)
	SkinControl("HandleButton", AtlasLootPanel_Options)
	SkinControl("HandleButton", AtlasLootPanel_LoadModules)
	SkinControl("HandleButton", AtlasLootPanel_Preset1)
	SkinControl("HandleButton", AtlasLootPanel_Preset2)
	SkinControl("HandleButton", AtlasLootPanel_Preset3)
	SkinControl("HandleButton", AtlasLootPanel_Preset4)

	SkinControl("HandleEditBox", AtlasLootSearchBox)
	SkinFrame(AtlasLootSearchBox, "Height", 20)
	SkinControl("HandleButton", AtlasLootSearchButton)
	SkinFrame(AtlasLootSearchButton, "Height", 22)
	SkinFrame(AtlasLootSearchButton, "Point", "LEFT", AtlasLootSearchBox, "RIGHT", 3, 0)
	SkinControl("HandleNextPrevButton", AtlasLootSearchOptionsButton)
	SkinFrame(AtlasLootSearchOptionsButton, "Point", "LEFT", AtlasLootSearchButton, "RIGHT", 2, 0)
	SkinControl("HandleButton", AtlasLootSearchClearButton)
	SkinFrame(AtlasLootSearchClearButton, "Height", 22)
	SkinFrame(AtlasLootSearchClearButton, "Point", "LEFT", AtlasLootSearchOptionsButton, "RIGHT", 2, 0)
	SkinControl("HandleButton", AtlasLootLastResultButton)
	SkinFrame(AtlasLootLastResultButton, "Height", 22)
	SkinFrame(AtlasLootLastResultButton, "Point", "LEFT", AtlasLootSearchClearButton, "RIGHT", 2, 0)

	if AS:IsAddonEnabled("Atlas") then
		hooksecurefunc("AtlasLoot_SetupForAtlas", function()
			SkinFrame(AtlasLootInfo, "Point", "TOPLEFT", 546, 15)
			SkinFrame(AtlasLootPanel, "Point", "TOP", "AtlasFrame", "BOTTOM", 0, 1)
		end)

		hooksecurefunc("AtlasLoot_SetItemInfoFrame", function(pFrame)
			if not pFrame or pFrame == AtlasFrame then
				SkinFrame(AtlasLootItemsFrame, "Point", "TOPLEFT", 15, -74)
			end
		end)
	end

	AS:SkinLibrary("Dewdrop-2.0")
end)

S:AddCallbackForAddon("AtlasLootFu", "AtlasLootFu", function()
	AS:SkinLibrary("AceAddon-2.0")
	AS:SkinLibrary("Tablet-2.0")
end)
