local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

if not AS:IsAddonLODorEnabled("TradeskillInfoUI") then return end

local _G = _G
local unpack = unpack

-- TradeskillInfo r365
-- https://www.wowace.com/projects/tradeskill-info/files/449625

S:AddCallbackForAddon("TradeskillInfoUI", "TradeskillInfoUI", function()
	if not E.private.addOnSkins.TradeskillInfo then return end

	TradeskillInfoFrame:Width(670)
	TradeskillInfoFrame:SetMinResize(670, TradeskillInfoFrame:GetHeight())
	TradeskillInfoFrame:SetTemplate("Transparent")

	S:HandleCloseButton(TradeskillInfoFrameCloseButton, TradeskillInfoFrame.backdrop)

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
	S:HandleScrollBar(TradeskillInfoDetailScrollFrameScrollBar)

	S:HandleEditBox(TradeskillInfoInputBox)

	TradeskillInfoDetailScrollChildFrame:StripTextures()
	TradeskillInfoSkillIcon:StyleButton(nil, true)
	TradeskillInfoSkillIcon:SetTemplate("Default")

	TradeskillInfoSortDropDown:Point("TOPLEFT", 53, -29)
	TradeskillInfoTradeskillsDropDown:Point("LEFT", TradeskillInfoSortDropDown, "RIGHT", -21, 0)
	TradeskillInfoAvailabilityDropDown:Point("LEFT", TradeskillInfoTradeskillsDropDown, "RIGHT", -21, 0)

	TradeskillInfoListFrame:Point("TOPLEFT", 8, -50)
	TradeskillInfoListFrame:Point("RIGHT", TradeskillInfoDetailScrollFrame, "LEFT", -3, 0)
	TradeskillInfoListFrame:Point("BOTTOM", TradeskillInfoResetButton, "TOP", 0, 5)

	TradeskillInfoCollapseAllButton:Point("TOPLEFT", 4, -8)

	TradeskillInfoSkill1:Point("TOPLEFT", 4, -28)

	TradeskillInfoListScrollFrame:Point("TOPLEFT", 0, -26)
	TradeskillInfoListScrollFrame:Point("BOTTOMRIGHT", -21, 0)

	TradeskillInfoListScrollFrameScrollBar:Point("TOPLEFT", TradeskillInfoListScrollFrame, "TOPRIGHT", 3, -19)
	TradeskillInfoListScrollFrameScrollBar:Point("BOTTOMLEFT", TradeskillInfoListScrollFrame, "BOTTOMRIGHT", 3, 19)

	TradeskillInfoDetailScrollFrame:Width(304)
	TradeskillInfoDetailScrollFrame:Point("TOPRIGHT", -29, -76)
	TradeskillInfoDetailScrollFrame:Point("BOTTOMRIGHT", -31, 37)

	TradeskillInfoDetailScrollFrameScrollBar:Point("TOPLEFT", TradeskillInfoDetailScrollFrame, "TOPRIGHT", 3, -19)
	TradeskillInfoDetailScrollFrameScrollBar:Point("BOTTOMLEFT", TradeskillInfoDetailScrollFrame, "BOTTOMRIGHT", 3, 19)

	TradeskillInfoSkillIcon:Size(47)
	TradeskillInfoSkillIcon:Point("TOPLEFT", 10, -9)

	TradeskillInfoSkillName:Point("TOPLEFT", 65, -9)
	TradeskillInfoDescription:Point("TOPLEFT", 8, -64)

	TradeskillInfoResetButton:Point("BOTTOMLEFT", 8, 8)

	TradeskillInfoInputBox:Width(217)

	TradeskillInfoSearchButton:Point("BOTTOMRIGHT", -8, 8)
	TradeskillInfoInputBox:Point("RIGHT", TradeskillInfoSearchButton, "LEFT", -8, 0)
	TradeskillInfoReagentButton:Point("RIGHT", TradeskillInfoInputBox, "LEFT", -8, 0)
	TradeskillInfoNameButton:Point("RIGHT", TradeskillInfoReagentButton, "LEFT", -7, 0)
	TradeskillInfoOpposingButton:Point("RIGHT", TradeskillInfoNameButton, "LEFT", -7, 0)

	TradeskillInfoFrameResizeCorner:Point("BOTTOMRIGHT", -1, 1)

	local skillIconSkinned
	hooksecurefunc(TradeskillInfoSkillIcon, "SetNormalTexture", function(self)
		local normalTexture = self:GetNormalTexture()
		if normalTexture then
			if not skillIconSkinned then
				self:SetAlpha(1)
				normalTexture:SetTexCoord(unpack(E.TexCoords))
				normalTexture:SetInside()
				skillIconSkinned = true
			end
		else
			self:SetAlpha(0)
			skillIconSkinned = nil
		end
	end)

	for i = 1, TradeskillInfoUI.cons.maxSkillReagents or 8 do
		local reagent = _G["TradeskillInfoReagent"..i]
		local icon = _G["TradeskillInfoReagent"..i.."IconTexture"]
		local count = _G["TradeskillInfoReagent"..i.."Count"]
		local name = _G["TradeskillInfoReagent"..i.."Name"]
		local nameFrame = _G["TradeskillInfoReagent"..i.."NameFrame"]

		reagent:SetTemplate("Default")
		reagent:StyleButton(nil, true)
		reagent:Size(143, 40)

		icon.backdrop = CreateFrame("Frame", nil, reagent)
		icon.backdrop:SetTemplate()
		icon.backdrop:Point("TOPLEFT", icon, -1, 1)
		icon.backdrop:Point("BOTTOMRIGHT", icon, 1, -1)

		icon:SetTexCoord(unpack(E.TexCoords))
		icon:SetDrawLayer("OVERLAY")
		icon:Size(E.PixelMode and 38 or 32)
		icon:Point("TOPLEFT", E.PixelMode and 1 or 4, -(E.PixelMode and 1 or 4))
		icon:SetParent(icon.backdrop)

		count:SetParent(icon.backdrop)
		count:SetDrawLayer("OVERLAY")

		name:Point("LEFT", nameFrame, "LEFT", 20, 0)

		nameFrame:Hide()

		if i == 1 then
			reagent:Point("TOPLEFT", TradeskillInfoReagentLabel, "BOTTOMLEFT", 1, -3)
		elseif i % 2 == 0 then
			reagent:Point("LEFT", _G["TradeskillInfoReagent"..(i-1)], "RIGHT", 3, 0)
		else
			reagent:Point("TOPLEFT", _G["TradeskillInfoReagent"..(i-2)], "BOTTOMLEFT", 0, -3)
		end
	end

	local collapseButtons = -1
	hooksecurefunc(TradeskillInfoUI, "DoFrameUpdate", function(self)
		if collapseButtons >= self.vars.numSkillButtons then return end

		if collapseButtons == -1 then
			S:HandleCollapseExpandButton(TradeskillInfoCollapseAllButton)
			collapseButtons = collapseButtons + 1
		end

		for i = collapseButtons + 1, self.vars.numSkillButtons do
			local button = _G["TradeskillInfoSkill"..i]
			if button then
				S:HandleCollapseExpandButton(button)
			end
		end

		collapseButtons = self.vars.numSkillButtons
	end)
end)