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

if not AS:IsAddonLODorEnabled("KarniCrap") then return end

local _G = _G

-- KarniCrap 3.02
-- https://www.curseforge.com/wow/addons/karnicrap/files/416407

S:AddCallbackForAddon("KarniCrap", "KarniCrap", function()
	if not E.private.addOnSkins.KarniCrap then return end

	SkinFrame(KarniCrap, "StripTextures")
	SkinFrame(KarniCrap, "SetTemplate", "Transparent")

	SkinFrame(KarniCrap_TitleText, "Point", "TOP", KarniCrap, "TOP", 0, -12)
	SkinFrame(KarniCrapTab1, "Point", "CENTER", KarniCrap, "BOTTOMLEFT", 80, -14)

	SkinFrame(KarniCrap_InvHeader1, "Point", "BOTTOMLEFT", KarniCrap_Inventory, "TOPLEFT", 0, -1)

	KarniCrap_Poor_GoldTexture:SetParent(KarniCrap_Poor_GoldInputBox)
	KarniCrap_Poor_SilverTexture:SetParent(KarniCrap_Poor_SilverInputBox)
	KarniCrap_Poor_CopperTexture:SetParent(KarniCrap_Poor_CopperInputBox)
	KarniCrap_Tab1_CBCommonDesc_GoldTexture:SetParent(KarniCrap_Tab1_CBCommonDesc_GoldInputBox)
	KarniCrap_Tab1_CBCommonDesc_SilverTexture:SetParent(KarniCrap_Tab1_CBCommonDesc_SilverInputBox)
	KarniCrap_Tab1_CBCommonDesc_CopperTexture:SetParent(KarniCrap_Tab1_CBCommonDesc_CopperInputBox)
	SkinFrame(KarniCrap_EBDestroyNumDisabled, "StripTextures")

	local frames = {
		-- General Options
		"KarniCrap_CategoryFrame",
		"KarniCrap_OptionsFrame",
		-- Lists
		"KarniCrap_Blacklist",
		"KarniCrap_Whitelist",
		-- Inventory
		"KarniCrap_Inventory",
		"KarniCrap_InvHeader1",
		"KarniCrap_InvHeader2",
		"KarniCrap_ValueHeader",
		"KarniCrap_InvHeader4",
	}

	local scrollBars = {
		-- Lists
		"KarniCrapScrollBarScrollBar",
		"KarniNotCrapScrollBarScrollBar",
		"KarniCrap_Inventory_ScrollBarScrollBar"
	}

	local buttons = {
		"KarniCrap_CloseButton",
		-- Lists
		"KarniCrap_BtnBlacklistRemove",
		"KarniCrap_BtnWhitelistRemove",
		-- Inventory
		"KarniCrap_BtnDestroyItem",
		"KarniCrap_BtnDestroyAllItems"
	}

	local checkBoxes = {
		"KarniCrap_CBEnabled",
		-- General Options
		"KarniCrap_CBPoor",
		"KarniCrap_Tab1_CBCommon",
		"KarniCrap_Tab1_CBUseStackValue",
		"KarniCrap_Tab1_CBEcho",
		"KarniCrap_CBDestroy",
		"KarniCrap_CBDestroySlots",
		"KarniCrap_CBNoDestroyTradeskill",
		"KarniCrap_CBDestroyGroup",
		"KarniCrap_CBDestroyRaid",
		"KarniCrap_Cloth_CBLinen",
		"KarniCrap_Cloth_CBWool",
		"KarniCrap_Cloth_CBSilk",
		"KarniCrap_Cloth_CBMageweave",
		"KarniCrap_Cloth_CBRunecloth",
		"KarniCrap_Cloth_CBNetherweave",
		"KarniCrap_Cloth_CBFrostweave",
		"KarniCrap_Corpses_CBSkinnable",
		"KarniCrap_Corpses_CBGatherable",
		"KarniCrap_Corpses_CBMinable",
		"KarniCrap_Corpses_CBEngineerable",
		"KarniCrap_Corpses_CBSkilledEnough",
		"KarniCrap_Consumables_RBFood1",
		"KarniCrap_Consumables_RBFood2",
		"KarniCrap_Consumables_CBFoodMax",
		"KarniCrap_Consumables_RBWater1",
		"KarniCrap_Consumables_RBWater2",
		"KarniCrap_Consumables_CBWaterMax",
		"KarniCrap_Pickpocketing_CBPickpocketing",
		"KarniCrap_Potions_RBHealth1",
		"KarniCrap_Potions_RBHealth2",
		"KarniCrap_Potions_CBHealthMax",
		"KarniCrap_Potions_RBMana1",
		"KarniCrap_Potions_RBMana2",
		"KarniCrap_Potions_CBManaMax",
		"KarniCrap_Quality_CBQualityPoor",
		"KarniCrap_Quality_CBQualityCommon",
		"KarniCrap_Quality_CBQualityUncommon",
		"KarniCrap_Quality_CBQualityRare",
		"KarniCrap_Quality_CBQualityEpic",
		"KarniCrap_Quality_CBQualityGrouped",
		"KarniCrap_Scrolls_CBMaxScrolls",
		"KarniCrap_Scrolls_CBScrollAgility",
		"KarniCrap_Scrolls_CBScrollIntellect",
		"KarniCrap_Scrolls_CBScrollProtection",
		"KarniCrap_Scrolls_CBScrollSpirit",
		"KarniCrap_Scrolls_CBScrollStamina",
		"KarniCrap_Scrolls_CBScrollStrength",
		"KarniCrap_Tradeskills_CBCooking",
		"KarniCrap_Tradeskills_CBFishing",
		"KarniCrap_Tradeskills_CBEnchanting",
		"KarniCrap_Tradeskills_CBGathering",
		"KarniCrap_Tradeskills_CBMilling",
		"KarniCrap_Tradeskills_CBMining",
		"KarniCrap_Tradeskills_CBProspecting",
		"KarniCrap_Tradeskills_CBSkinning",
		-- Inventory
		"KarniCrap_Inventory_CBHideQuestItems"
	}

	local editBoxes = {
		-- General Options
		"KarniCrap_Poor_GoldInputBox",
		"KarniCrap_Poor_SilverInputBox",
		"KarniCrap_Poor_CopperInputBox",
		"KarniCrap_Tab1_CBCommonDesc_GoldInputBox",
		"KarniCrap_Tab1_CBCommonDesc_SilverInputBox",
		"KarniCrap_Tab1_CBCommonDesc_CopperInputBox",
		"KarniCrap_EBDestroySlotsNum"
	}

	local tabs = {
		"KarniCrapTab1",
		"KarniCrapTab2",
		"KarniCrapTab3"
	}

	for _, frame in ipairs(frames) do
		SkinFrame(_G[frame], "StripTextures")
		SkinFrame(_G[frame], "SetTemplate", "Transparent")
	end

	for _, scrollBar in ipairs(scrollBars) do
		_G[scrollBar]:GetParent():StripTextures()
		SkinControl("HandleScrollBar", _G[scrollBar])
	end

	for _, button in ipairs(buttons) do
		SkinControl("HandleButton", _G[button])
	end

	for _, checkBox in ipairs(checkBoxes) do
		SkinFrame(_G[checkBox], "StripTextures")
		SkinControl("HandleCheckBox", _G[checkBox])
	end

	for _, editBox in ipairs(editBoxes) do
		if _G[editBox.."Disabled"] then
			SkinFrame(_G[editBox.."Disabled"], "StripTextures")
		end

		SkinFrame(_G[editBox], "Size", 32, 16)
		SkinControl("HandleEditBox", _G[editBox])
	end

	for _, tab in ipairs(tabs) do
		SkinControl("HandleTab", _G[tab])
	end

	for i = 1, 15 do
		SkinFrame(_G["KarniInvEntry"..i.."_BtnCrap"], "Size", 30)
		SkinControl("HandleCloseButton", _G["KarniInvEntry"..i.."_BtnCrap"])
	end
end)
