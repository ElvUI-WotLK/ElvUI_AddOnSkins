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

if not AS:IsAddonLODorEnabled("TradeskillInfoUI") then return end

local _G = _G
local unpack = unpack

-- TradeskillInfo r365
-- https://www.wowace.com/projects/tradeskill-info/files/449625

S:AddCallbackForAddon("TradeskillInfoUI", "TradeskillInfoUI", function()
	if not E.private.addOnSkins.TradeskillInfo then return end

	SkinFrame(TradeskillInfoFrame, "Width", 670)
	TradeskillInfoFrame:SetMinResize(670, TradeskillInfoFrame:GetHeight())
	SkinFrame(TradeskillInfoFrame, "SetTemplate", "Transparent")

	SkinControl("HandleCloseButton", TradeskillInfoFrameCloseButton, TradeskillInfoFrame.backdrop)

	SkinControl("HandleButton", TradeskillInfoResetButton)
	SkinControl("HandleButton", TradeskillInfoOpposingButton)
	SkinControl("HandleButton", TradeskillInfoNameButton)
	SkinControl("HandleButton", TradeskillInfoReagentButton)
	SkinControl("HandleButton", TradeskillInfoSearchButton)

	SkinControl("HandleDropDownBox", TradeskillInfoSortDropDown)
	SkinControl("HandleDropDownBox", TradeskillInfoTradeskillsDropDown)
	SkinControl("HandleDropDownBox", TradeskillInfoAvailabilityDropDown)

	SkinFrame(TradeskillInfoListScrollFrame, "StripTextures")
	SkinControl("HandleScrollBar", TradeskillInfoListScrollFrameScrollBar)

	SkinFrame(TradeskillInfoDetailScrollFrame, "StripTextures")
	SkinControl("HandleScrollBar", TradeskillInfoDetailScrollFrameScrollBar)

	SkinControl("HandleEditBox", TradeskillInfoInputBox)

	SkinFrame(TradeskillInfoDetailScrollChildFrame, "StripTextures")
	SkinFrame(TradeskillInfoSkillIcon, "StyleButton", nil, true)
	SkinFrame(TradeskillInfoSkillIcon, "SetTemplate", "Default")

	SkinFrame(TradeskillInfoSortDropDown, "Point", "TOPLEFT", 53, -29)
	SkinFrame(TradeskillInfoTradeskillsDropDown, "Point", "LEFT", TradeskillInfoSortDropDown, "RIGHT", -21, 0)
	SkinFrame(TradeskillInfoAvailabilityDropDown, "Point", "LEFT", TradeskillInfoTradeskillsDropDown, "RIGHT", -21, 0)

	SkinFrame(TradeskillInfoListFrame, "Point", "TOPLEFT", 8, -50)
	SkinFrame(TradeskillInfoListFrame, "Point", "RIGHT", TradeskillInfoDetailScrollFrame, "LEFT", -3, 0)
	SkinFrame(TradeskillInfoListFrame, "Point", "BOTTOM", TradeskillInfoResetButton, "TOP", 0, 5)

	SkinFrame(TradeskillInfoCollapseAllButton, "Point", "TOPLEFT", 4, -8)

	SkinFrame(TradeskillInfoSkill1, "Point", "TOPLEFT", 4, -28)

	SkinFrame(TradeskillInfoListScrollFrame, "Point", "TOPLEFT", 0, -26)
	SkinFrame(TradeskillInfoListScrollFrame, "Point", "BOTTOMRIGHT", -21, 0)

	SkinFrame(TradeskillInfoListScrollFrameScrollBar, "Point", "TOPLEFT", TradeskillInfoListScrollFrame, "TOPRIGHT", 3, -19)
	SkinFrame(TradeskillInfoListScrollFrameScrollBar, "Point", "BOTTOMLEFT", TradeskillInfoListScrollFrame, "BOTTOMRIGHT", 3, 19)

	SkinFrame(TradeskillInfoDetailScrollFrame, "Width", 304)
	SkinFrame(TradeskillInfoDetailScrollFrame, "Point", "TOPRIGHT", -29, -76)
	SkinFrame(TradeskillInfoDetailScrollFrame, "Point", "BOTTOMRIGHT", -31, 37)

	SkinFrame(TradeskillInfoDetailScrollFrameScrollBar, "Point", "TOPLEFT", TradeskillInfoDetailScrollFrame, "TOPRIGHT", 3, -19)
	SkinFrame(TradeskillInfoDetailScrollFrameScrollBar, "Point", "BOTTOMLEFT", TradeskillInfoDetailScrollFrame, "BOTTOMRIGHT", 3, 19)

	SkinFrame(TradeskillInfoSkillIcon, "Size", 47)
	SkinFrame(TradeskillInfoSkillIcon, "Point", "TOPLEFT", 10, -9)

	SkinFrame(TradeskillInfoSkillName, "Point", "TOPLEFT", 65, -9)
	SkinFrame(TradeskillInfoDescription, "Point", "TOPLEFT", 8, -64)

	SkinFrame(TradeskillInfoResetButton, "Point", "BOTTOMLEFT", 8, 8)

	SkinFrame(TradeskillInfoInputBox, "Width", 217)

	SkinFrame(TradeskillInfoSearchButton, "Point", "BOTTOMRIGHT", -8, 8)
	SkinFrame(TradeskillInfoInputBox, "Point", "RIGHT", TradeskillInfoSearchButton, "LEFT", -8, 0)
	SkinFrame(TradeskillInfoReagentButton, "Point", "RIGHT", TradeskillInfoInputBox, "LEFT", -8, 0)
	SkinFrame(TradeskillInfoNameButton, "Point", "RIGHT", TradeskillInfoReagentButton, "LEFT", -7, 0)
	SkinFrame(TradeskillInfoOpposingButton, "Point", "RIGHT", TradeskillInfoNameButton, "LEFT", -7, 0)

	SkinFrame(TradeskillInfoFrameResizeCorner, "Point", "BOTTOMRIGHT", -1, 1)

	local skillIconSkinned
	hooksecurefunc(TradeskillInfoSkillIcon, "SetNormalTexture", function(self)
		local normalTexture = self:GetNormalTexture()
		if normalTexture then
			if not skillIconSkinned then
				SkinFrame(self, "SetAlpha", 1)
				SkinFrame(normalTexture, "SetTexCoord", unpack(E.TexCoords))
				SkinFrame(normalTexture, "SetInside")
				skillIconSkinned = true
			end
		else
			SkinFrame(self, "SetAlpha", 0)
			skillIconSkinned = nil
		end
	end)

	for i = 1, TradeskillInfoUI.cons.maxSkillReagents or 8 do
		local reagent = _G["TradeskillInfoReagent"..i]
		local icon = _G["TradeskillInfoReagent"..i.."IconTexture"]
		local count = _G["TradeskillInfoReagent"..i.."Count"]
		local name = _G["TradeskillInfoReagent"..i.."Name"]
		local nameFrame = _G["TradeskillInfoReagent"..i.."NameFrame"]

		SkinFrame(reagent, "SetTemplate", "Default")
		SkinFrame(reagent, "StyleButton", nil, true)
		SkinFrame(reagent, "Size", 143, 40)

		icon.backdrop = CreateFrame("Frame", nil, reagent)
		icon.backdrop:SetTemplate()
		icon.backdrop:Point("TOPLEFT", icon, -1, 1)
		icon.backdrop:Point("BOTTOMRIGHT", icon, 1, -1)

		SkinFrame(icon, "SetTexCoord", unpack(E.TexCoords))
		icon:SetDrawLayer("OVERLAY")
		SkinFrame(icon, "Size", E.PixelMode and 38 or 32)
		SkinFrame(icon, "Point", "TOPLEFT", E.PixelMode and 1 or 4, -(E.PixelMode and 1 or 4))
		icon:SetParent(icon.backdrop)

		count:SetParent(icon.backdrop)
		count:SetDrawLayer("OVERLAY")

		SkinFrame(name, "Point", "LEFT", nameFrame, "LEFT", 20, 0)

		SkinFrame(nameFrame, "Hide")

		if i == 1 then
			SkinFrame(reagent, "Point", "TOPLEFT", TradeskillInfoReagentLabel, "BOTTOMLEFT", 1, -3)
		elseif i % 2 == 0 then
			SkinFrame(reagent, "Point", "LEFT", _G["TradeskillInfoReagent"..(i-1)], "RIGHT", 3, 0)
		else
			SkinFrame(reagent, "Point", "TOPLEFT", _G["TradeskillInfoReagent"..(i-2)], "BOTTOMLEFT", 0, -3)
		end
	end

	local collapseButtons = -1
	hooksecurefunc(TradeskillInfoUI, "DoFrameUpdate", function(self)
		if collapseButtons >= self.vars.numSkillButtons then return end

		if collapseButtons == -1 then
			SkinControl("HandleCollapseExpandButton", TradeskillInfoCollapseAllButton)
			collapseButtons = collapseButtons + 1
		end

		for i = collapseButtons + 1, self.vars.numSkillButtons do
			local button = _G["TradeskillInfoSkill"..i]
			if button then
				SkinControl("HandleCollapseExpandButton", button)
			end
		end

		collapseButtons = self.vars.numSkillButtons
	end)
end)
