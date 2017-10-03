local E, L, V, P, G = unpack(ElvUI)
local AS = E:GetModule("AddOnSkins")
local S = E:GetModule("Skins")

local select = select

function AS:Desaturate(frame, point)
	for i = 1, frame:GetNumRegions() do
		local region = select(i, frame:GetRegions())
		if region:IsObjectType("Texture") then
			local Texture = region:GetTexture()
			if type(Texture) == "string" and strlower(Texture) == "interface\\dialogframe\\ui-dialogbox-corner" then
				region:SetTexture(nil)
				region:Kill()
			else
				region:SetDesaturated(true)
			end
		end
	end

	frame:HookScript("OnUpdate", function(self)
		if self:GetNormalTexture() then
			self:GetNormalTexture():SetDesaturated(true)
		end
		if self:GetPushedTexture() then
			self:GetPushedTexture():SetDesaturated(true)
		end
		if self:GetHighlightTexture() then
			self:GetHighlightTexture():SetDesaturated(true)
		end
	end)
end

function AS:AcceptFrame(MainText, Function)
	if not AcceptFrame then
		AcceptFrame = CreateFrame("Frame", "AcceptFrame", UIParent)
		AcceptFrame:SetTemplate("Transparent")
		AcceptFrame:Point("CENTER", UIParent, "CENTER")
		AcceptFrame:SetFrameStrata("DIALOG")

		AcceptFrame.Text = AcceptFrame:CreateFontString(nil, "OVERLAY")
		AcceptFrame.Text:FontTemplate()
		AcceptFrame.Text:Point("TOP", AcceptFrame, "TOP", 0, -10)

		AcceptFrame.Accept = CreateFrame("Button", nil, AcceptFrame, "OptionsButtonTemplate")
		S:HandleButton(AcceptFrame.Accept)
		AcceptFrame.Accept:Size(70, 25)
		AcceptFrame.Accept:Point("RIGHT", AcceptFrame, "BOTTOM", -10, 20)
		AcceptFrame.Accept:SetFormattedText("|cFFFFFFFF%s|r", YES)

		AcceptFrame.Close = CreateFrame("Button", nil, AcceptFrame, "OptionsButtonTemplate")
		S:HandleButton(AcceptFrame.Close)
		AcceptFrame.Close:Size(70, 25)
		AcceptFrame.Close:Point("LEFT", AcceptFrame, "BOTTOM", 10, 20)
		AcceptFrame.Close:SetScript("OnClick", function(self) self:GetParent():Hide() end)
		AcceptFrame.Close:SetFormattedText("|cFFFFFFFF%s|r", NO)
	end
	AcceptFrame.Text:SetText(MainText)
	AcceptFrame:Size(AcceptFrame.Text:GetStringWidth() + 100, AcceptFrame.Text:GetStringHeight() + 60)
	AcceptFrame.Accept:SetScript("OnClick", Function)
	AcceptFrame:Show()
end