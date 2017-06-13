local E, L, V, P, G = unpack(ElvUI);
local S = E:GetModule("Skins");

-- AdiBags 1.1 beta 7

local function LoadSkin()
	if(not E.private.addOnSkins.AdiBags) then return; end

	local AdiBags = LibStub("AceAddon-3.0"):GetAddon("AdiBags", true)
	if not AdiBags then return end

	hooksecurefunc(AdiBags, "ResetBagPositions", function(self)
		self.db.profile.scale = 1
		self:LayoutBags()
	end)

	local function SkinContainer(frame)
		frame:SetTemplate("Transparent")
		S:HandleCloseButton(frame.CloseButton)
		frame.BagSlotPanel:SetTemplate("Transparent")

		for _, bag in pairs(frame.BagSlotPanel.buttons) do
			local icon = _G[bag:GetName().."IconTexture"]
			bag.oldTex = icon:GetTexture()

			bag:StripTextures()
			bag:CreateBackdrop("Default", true)
			bag.backdrop:SetAllPoints()
			bag:StyleButton()
			icon:SetTexture(bag.oldTex)
			icon:SetInside()
			icon:SetTexCoord(unpack(E.TexCoords))
		end
	end

	S:RawHook(AdiBags, "CreateContainerFrame", function(self, ...)
		local frame = S.hooks[self].CreateContainerFrame(self, ...)

		SkinContainer(frame)

		return frame
	end)

	local LayeredRegionClass = AdiBags:GetClass("LayeredRegion")
	hooksecurefunc(LayeredRegionClass.prototype, "AddWidget", function(self, widget)
		if widget:IsObjectType("Button") then
			if widget:GetText() then
				S:HandleButton(widget)
			else
				widget:StyleButton(true, true)
				widget:GetNormalTexture():SetTexCoord(unpack(E.TexCoords))
				widget:GetCheckedTexture():SetTexCoord(unpack(E.TexCoords))
			end
		elseif widget.editBox and widget.editBox.clearButton then
			widget.editBox:DisableDrawLayer("BACKGROUND")
			S:HandleEditBox(widget.editBox)

			S:HandleButton(widget.editBox.clearButton)
		end
	end)

	local ItemButtonClass = AdiBags:GetClass("ItemButton")
	hooksecurefunc(ItemButtonClass.prototype, "OnCreate", function(self)
		self.NormalTexture:SetTexture(nil)
		self:SetTemplate("Default", true)
		self:StyleButton()

		E:RegisterCooldown(self.Cooldown)

		self.IconTexture:SetInside()
	end)

	hooksecurefunc(ItemButtonClass.prototype, "Update", function(self)
		if self.texture then
			self.IconTexture:SetTexCoord(unpack(E.TexCoords))
		else
			self.IconTexture:SetTexture(nil)
		end
	end)

	hooksecurefunc(ItemButtonClass.prototype, "UpdateBorder", function(self)
		if not self.hasItem then return end

		local profileDB = AdiBags.db.profile
		local isQuestItem, questId, isActive = GetContainerItemQuestInfo(self.bag, self.slot)
		local _, _, quality = GetItemInfo(self.itemId)

		if profileDB.questIndicator and (questId and not isActive) then
			self.IconQuestTexture:SetAlpha(1)
			self.IconQuestTexture:SetInside()
			self.IconQuestTexture:SetTexCoord(unpack(E.TexCoords))
		else
			self.IconQuestTexture:SetAlpha(0)
		end

		if questId and not isActive then
			self:SetBackdropBorderColor(1, 1, 0)
		elseif questId or isQuestItem then
			self:SetBackdropBorderColor(1, 0.2, 0.2)
		elseif profileDB.qualityHighlight and quality then
			if quality >= ITEM_QUALITY_UNCOMMON then
				self:SetBackdropBorderColor(GetItemQualityColor(quality))
			elseif quality == ITEM_QUALITY_POOR and profileDB.dimJunk then
				local c = 1 - 0.5 * profileDB.qualityOpacity
				self:SetBackdropBorderColor(c, c, c)
			else
				self:SetBackdropBorderColor(unpack(E["media"].bordercolor))
			end
		else
			self:SetBackdropBorderColor(unpack(E["media"].bordercolor))
		end
	end)

	local AdiBags_SearchHighlight = AdiBags:GetModule("SearchHighlight")
	hooksecurefunc(AdiBags_SearchHighlight, "UpdateButton", function(self, event, button)
		local text = self.widget:GetText()
		text = text:lower():trim()
		local name = button.itemId and GetItemInfo(button.itemId)
		if name and not name:lower():match(text) then
			button:SetBackdropBorderColor(unpack(E["media"].bordercolor))
		end
	end)
end

S:AddCallbackForAddon("AdiBags", "AdiBags", LoadSkin);