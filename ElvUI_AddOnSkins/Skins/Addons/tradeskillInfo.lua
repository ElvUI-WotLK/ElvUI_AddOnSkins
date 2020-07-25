local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

if not AS:IsAddonLODorEnabled("TradeskillInfoUI") then return end

local _G = _G
local unpack = unpack
local find = string.find

local hooksecurefunc = hooksecurefunc

-- TradeskillInfo r365
-- https://www.wowace.com/projects/tradeskill-info/files/449625

S:AddCallbackForAddon("TradeskillInfoUI", "TradeskillInfoUI", function()
	if not E.private.addOnSkins.TradeskillInfo then return end

	TradeskillInfoFrame:SetTemplate("Transparent")

	S:HandleCloseButton(TradeskillInfoFrameCloseButton)

	S:HandleButton(TradeskillInfoResetButton)
	S:HandleButton(TradeskillInfoOpposingButton)
	S:HandleButton(TradeskillInfoNameButton)
	S:HandleButton(TradeskillInfoReagentButton)
	S:HandleButton(TradeskillInfoSearchButton)

	S:HandleDropDownBox(TradeskillInfoSortDropDown)
	S:HandleDropDownBox(TradeskillInfoTradeskillsDropDown)
	S:HandleDropDownBox(TradeskillInfoAvailabilityDropDown)

	TradeskillInfoListScrollFrame:StripTextures()
	S:HandleScrollBar(TradeskillInfoListScrollFrameScrollBar)

	TradeskillInfoDetailScrollFrame:StripTextures()
	TradeskillInfoDetailScrollFrame:Point("TOPRIGHT", -30, -80)
	TradeskillInfoDetailScrollFrame:Point("BOTTOMRIGHT", -30, 32)
	S:HandleScrollBar(TradeskillInfoDetailScrollFrameScrollBar)

	S:HandleEditBox(TradeskillInfoInputBox)

	TradeskillInfoDetailScrollChildFrame:StripTextures()
	TradeskillInfoSkillIcon:StyleButton(nil, true)
	TradeskillInfoSkillIcon:SetTemplate("Default")

	S:SecureHook(TradeskillInfoSkillIcon, "SetNormalTexture", function(self)
		self:GetNormalTexture():SetTexCoord(unpack(E.TexCoords))
		self:GetNormalTexture():SetInside()

		S:Unhook(TradeskillInfoSkillIcon, "SetNormalTexture")
	end)

	for i = 1, 8 do
		local reagent = _G["TradeskillInfoReagent" .. i]
		local icon = _G["TradeskillInfoReagent" .. i .. "IconTexture"]
		local count = _G["TradeskillInfoReagent" .. i .. "Count"]
		local nameFrame = _G["TradeskillInfoReagent" .. i .. "NameFrame"]

		icon:SetTexCoord(unpack(E.TexCoords))
		icon:SetDrawLayer("OVERLAY")

		icon.backdrop = CreateFrame("Frame", nil, reagent)
		icon.backdrop:SetFrameLevel(reagent:GetFrameLevel() - 1)
		icon.backdrop:SetTemplate("Default")
		icon.backdrop:SetOutside(icon)

		icon:SetParent(icon.backdrop)
		count:SetParent(icon.backdrop)
		count:SetDrawLayer("OVERLAY")

		nameFrame:Kill()
	end

	hooksecurefunc(TradeskillInfoUI, "DoFrameUpdate", function(self)
		for i = 0, self.vars.numSkillButtons do
			local c = _G["TradeskillInfoSkill"..i]

			if i == 0 then
				c = TradeskillInfoCollapseAllButton
			end

			if not c.isHooked then
				c:SetNormalTexture("")
				c.SetNormalTexture = E.noop
				c:SetPushedTexture("")
				c.SetPushedTexture = E.noop
				c:SetHighlightTexture("")
				c.SetHighlightTexture = E.noop
				c:SetDisabledTexture("")
				c.SetDisabledTexture = E.noop

				c.Text = c:CreateFontString(nil, "OVERLAY")
				c.Text:FontTemplate(nil, 22)
				c.Text:Point("LEFT", 5, 0)
				c.Text:SetText("")

				hooksecurefunc(c, "SetNormalTexture", function(self, texture)
					if find(texture, "MinusButton") then
						self.Text:SetText("-")
					elseif find(texture, "PlusButton") then
						self.Text:SetText("+")
					else
						self.Text:SetText("")
					end
				end)

				c.isHooked = true
			end
		end
	end)
end)