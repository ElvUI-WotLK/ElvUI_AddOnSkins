local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

if not AS:IsAddonLODorEnabled("ArkInventory") then return end

local _G = _G
local ipairs = ipairs
local unpack = unpack
local format = string.format

-- ArkInventory 3.02.54
-- https://www.wowace.com/projects/ark-inventory/files/458795

S:AddCallbackForAddon("ArkInventory", "ArkInventory", function()
	if not E.private.addOnSkins.ArkInventory then return end

	local function skinIcon(frame)
		if frame.isSkinned then return end

		local icon = frame:GetNormalTexture()

		frame:SetTemplate("Default", true)
		frame:StyleButton()

		icon:SetInside()
		icon:SetTexCoord(unpack(E.TexCoords))
		icon.SetTexCoord = E.noop

		frame.isSkinned = true
	end

	for i = 1, #ArkInventory.Global.Location do
		local frameName = format("%s%d", ArkInventory.Const.Frame.Main.Name, i)
		local frame = _G[frameName]

		if frame then
			-- Title
			S:HandleCloseButton(_G[format("%s%s%s", frameName, ArkInventory.Const.Frame.Title.Name, "Close")])

			skinIcon(_G[format("%s%s%s", frameName, ArkInventory.Const.Frame.Title.Name, "Location0")])
			skinIcon(_G[format("%s%s%s", frameName, ArkInventory.Const.Frame.Title.Name, "ActionButton11")])
			skinIcon(_G[format("%s%s%s", frameName, ArkInventory.Const.Frame.Title.Name, "ActionButton12")])
			skinIcon(_G[format("%s%s%s", frameName, ArkInventory.Const.Frame.Title.Name, "ActionButton13")])
			skinIcon(_G[format("%s%s%s", frameName, ArkInventory.Const.Frame.Title.Name, "ActionButton14")])
			skinIcon(_G[format("%s%s%s", frameName, ArkInventory.Const.Frame.Title.Name, "ActionButton21")])
			skinIcon(_G[format("%s%s%s", frameName, ArkInventory.Const.Frame.Title.Name, "ActionButton22")])
			skinIcon(_G[format("%s%s%s", frameName, ArkInventory.Const.Frame.Title.Name, "ActionButton23")])
			skinIcon(_G[format("%s%s%s", frameName, ArkInventory.Const.Frame.Title.Name, "ActionButton24")])

			-- Search
			S:HandleEditBox(_G[format("%s%s%s", frame:GetName(), ArkInventory.Const.Frame.Search.Name, "Filter")])
		end
	end

	hooksecurefunc(ArkInventory, "Frame_Main_Anchor_Set", function(loc_id)
		local frameName = format("%s%d", ArkInventory.Const.Frame.Main.Name, loc_id)

		local anchor = ArkInventory.LocationOptionGet(loc_id, "anchor", loc_id, "point")

		local title = _G[format("%s%s", frameName, ArkInventory.Const.Frame.Title.Name)]
		local search = _G[format("%s%s", frameName, ArkInventory.Const.Frame.Search.Name)]
		local container = _G[format("%s%s", frameName, ArkInventory.Const.Frame.Container.Name)]
		local changer = _G[format("%s%s", frameName, ArkInventory.Const.Frame.Changer.Name)]
		local status = _G[format("%s%s", frameName, ArkInventory.Const.Frame.Status.Name)]

		if anchor == ArkInventory.Const.Anchor.BottomRight then
			changer:Point("BOTTOMRIGHT", status, "TOPRIGHT", 0, -1)
			container:Point("BOTTOMRIGHT", changer, "TOPRIGHT", 0, -1)
			search:Point("BOTTOMRIGHT", container, "TOPRIGHT", 0, -1)
			title:Point("BOTTOMRIGHT", search, "TOPRIGHT", 0, -1)
		elseif anchor == ArkInventory.Const.Anchor.BottomLeft then
			changer:Point("BOTTOMLEFT", status, "TOPLEFT", 0, -1)
			container:Point("BOTTOMLEFT", changer, "TOPLEFT", 0, -1)
			search:Point("BOTTOMLEFT", container, "TOPLEFT", 0, -1)
			title:Point("BOTTOMLEFT", search, "TOPLEFT", 0, -1)
		elseif anchor == ArkInventory.Const.Anchor.TopLeft then
			search:Point("TOPLEFT", title, "BOTTOMLEFT", 0, 1)
			container:Point("TOPLEFT", search, "BOTTOMLEFT", 0, 1)
			changer:Point("TOPLEFT", container, "BOTTOMLEFT", 0, 1)
			status:Point("TOPLEFT", changer, "BOTTOMLEFT", 0, 1)
		else
			search:Point("TOPRIGHT", title, "BOTTOMRIGHT", 0, 1)
			container:Point("TOPRIGHT", search, "BOTTOMRIGHT", 0, 1)
			changer:Point("TOPRIGHT", container, "BOTTOMRIGHT", 0, 1)
			status:Point("TOPRIGHT", changer, "BOTTOMRIGHT", 0, 1)
		end
	end)

	ArkInventory.Frame_Main_Paint = function(frame)
		if not ArkInventory.ValidFrame(frame, true) then return end

		for _, child in ipairs({frame:GetChildren()}) do
			if not child.isSkinned then
				child:SetTemplate("Transparent")

				local frameName = child:GetName()
				if frameName then
					local bg = _G[format("%s%s", frameName, "Background")]
					local border = _G[format("%s%s", frameName, "ArkBorder")]

					if bg then
						bg:Hide()
					end
					if border then
						border:Hide()
					end
				end

				child.isSkinned = true
			end
		end
	end

	local defaultColors = ArkInventory.Const.Slot.DefaultColour

	ArkInventory.Frame_Border_Paint = function(border, slot, file, size, offset, scale, r, g, b, a)
		if not border.parent then return end

		if r == defaultColors.r and g == defaultColors.g and b == defaultColors.b then
			r, g, b = unpack(E.media.bordercolor)
			border.parent:SetBackdropBorderColor(r, g, b, 1)
		else
			border.parent:SetBackdropBorderColor(r or 0, g or 0, b or 0, a)
		end
	end

	local TEXTURE_ITEM_QUEST_BORDER = TEXTURE_ITEM_QUEST_BORDER
	local questColors = {
		["questStarter"] = {E.db.bags.colors.items.questStarter.r, E.db.bags.colors.items.questStarter.g, E.db.bags.colors.items.questStarter.b},
		["questItem"] =	{E.db.bags.colors.items.questItem.r, E.db.bags.colors.items.questItem.g, E.db.bags.colors.items.questItem.b}
	}

	local function updateQuestIcon(self, texture)
		if texture == TEXTURE_ITEM_QUEST_BORDER then
			self.parent:SetBackdropBorderColor(unpack(questColors.questItem))
			self:SetAlpha(0)
		else
			self.parent:SetBackdropBorderColor(unpack(questColors.questStarter))
			self:SetAlpha(1)
		end
	end

	local function skinItemButton(frame)
		if frame.isSkinned then return end

		local frameName = frame:GetName()
		local icon = _G[format("%s%s", frameName, "IconTexture")]
		local border = _G[format("%s%s", frameName, "ArkBorder")]
		local questIcon = _G[format("%s%s", frameName, "IconQuestTexture")]
		local cooldown = _G[format("%s%s", frameName, "Cooldown")]

		frame:SetNormalTexture(nil)
		frame:SetTemplate("Default", true)
		frame:StyleButton()

		icon:SetInside()
		icon:SetTexCoord(unpack(E.TexCoords))
		icon.SetTexCoord = E.noop

		border:Kill()
		border.parent = frame

		if questIcon then
			questIcon:SetInside()
			questIcon:SetTexture(E.Media.Textures.BagQuestIcon)
			questIcon.SetTexture = updateQuestIcon
			questIcon.parent = frame
		end

		if cooldown then
			cooldown.CooldownOverride = "bags"
			E:RegisterCooldown(cooldown)
		end

		frame.isSkinned = true
	end

	hooksecurefunc(ArkInventory, "Frame_Item_Update_Border", function(frame)
		if not ArkInventory.ValidFrame(frame, true) then return end
		skinItemButton(frame)
	end)

	-- GuildBank
	S:HandleButton(ARKINV_Frame4ChangerWindowPurchaseInfoPurchaseButton)
	S:HandleButton(ARKINV_Frame4ChangerWindowDepositButton)
	S:HandleButton(ARKINV_Frame4ChangerWindowWithdrawButton)

	S:HandleNextPrevButton(ARKINV_Frame4LogScrollUp, "up")
	S:HandleNextPrevButton(ARKINV_Frame4LogScrollDown, "down")

	S:HandleButton(ARKINV_Frame4InfoSave)
	S:HandleScrollBar(ARKINV_Frame4InfoScrollScrollBar)

	-- Search Frame
	ARKINV_SearchTitleBackground:Kill()
	ARKINV_SearchFrameBackground:Kill()

	ARKINV_SearchTitle:SetTemplate("Transparent")
	ARKINV_SearchFrame:SetTemplate("Transparent")

	ARKINV_Rules:SetHeight(570)
	ARKINV_SearchFrame:Point("TOPLEFT", ARKINV_SearchTitle, "BOTTOMLEFT", 0, 1)

	S:HandleCloseButton(ARKINV_SearchTitleClose)
	S:HandleEditBox(ARKINV_SearchFrameViewSearchFilter)
	S:HandleScrollBar(ARKINV_SearchFrameViewTableScrollScrollBar)

	AS:SkinLibrary("ArkDewdrop-3.0")
end)

S:AddCallbackForAddon("ArkInventoryRules", "ArkInventoryRules", function()
	if not E.private.addOnSkins.ArkInventory then return end

	ArkInventoryRules.Frame_Rules_Paint_Border = E.noop

	-- Rules
	ARKINV_RulesTitleBackground:Kill()
	ARKINV_RulesFrameBackground:Kill()

	ARKINV_RulesTitle:SetTemplate("Transparent")
	ARKINV_RulesFrame:SetTemplate("Transparent")

	ARKINV_RulesFrameViewSearch:SetTemplate("Transparent")
	ARKINV_RulesFrameViewTable:SetTemplate("Transparent")

	ARKINV_RulesFrame:Point("TOPLEFT", ARKINV_RulesTitle, "BOTTOMLEFT", 0, 1)
	ARKINV_RulesFrameViewTitle:SetPoint("TOP")

	S:HandleCloseButton(ARKINV_RulesTitleClose)

	S:HandleEditBox(ARKINV_RulesFrameViewSearchFilter)
	S:HandleScrollBar(ARKINV_RulesFrameViewTableScrollScrollBar)

	S:HandleButton(ARKINV_RulesFrameViewMenuAdd)
	S:HandleButton(ARKINV_RulesFrameViewMenuEdit)
	S:HandleButton(ARKINV_RulesFrameViewMenuRemove)

	-- Add Rule
	ARKINV_RulesFrameModifyTitle:SetPoint("TOP")

	S:HandleCheckBox(ARKINV_RulesFrameModifyDataEnabled)

	ARKINV_RulesFrameModifyDataOrder:Height(22)
	S:HandleEditBox(ARKINV_RulesFrameModifyDataOrder)
	ARKINV_RulesFrameModifyDataDescription:Height(22)
	S:HandleEditBox(ARKINV_RulesFrameModifyDataDescription)

	ARKINV_RulesFrameModifyDataScrollTextBorder:SetTemplate("Transparent")

	S:HandleScrollBar(ARKINV_RulesFrameModifyDataScrollScrollBar)

	ARKINV_RulesFrameModifyDataScrollScrollBar:Point("TOPLEFT", ARKINV_RulesFrameModifyDataScroll, "TOPRIGHT", 8, -13)
	ARKINV_RulesFrameModifyDataScrollScrollBar:Point("BOTTOMLEFT", ARKINV_RulesFrameModifyDataScroll, "BOTTOMRIGHT", 8, 13)

	S:HandleButton(ARKINV_RulesFrameModifyMenuOk)
	S:HandleButton(ARKINV_RulesFrameModifyMenuCancel)
end)