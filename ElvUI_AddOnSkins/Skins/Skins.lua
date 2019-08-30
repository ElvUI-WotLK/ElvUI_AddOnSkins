local E, L, V, P, G = unpack(ElvUI)
local AS = E:GetModule("AddOnSkins")
local S = E:GetModule("Skins")

local select = select

function AS:Desaturate(frame)
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

function AS:DesaturateButton(button)
	if button:GetNormalTexture() then
		button:GetNormalTexture():SetDesaturated(true)
	end
	if button:GetPushedTexture() then
		button:GetPushedTexture():SetDesaturated(true)
	end
	if button:GetHighlightTexture() then
		button:GetHighlightTexture():SetDesaturated(true)
	end
end

function AS:AcceptFrame(MainText, Function)
	if not AcceptFrame then
		AcceptFrame = CreateFrame("Frame", "ElvUI_AcceptFrame", UIParent)
		AcceptFrame:SetTemplate("Transparent")
		AcceptFrame:Point("CENTER", UIParent, "CENTER")
		AcceptFrame:SetFrameStrata("DIALOG")
		AcceptFrame:EnableMouse(true)
		tinsert(UISpecialFrames, AcceptFrame:GetName())

		AcceptFrame.Text = AcceptFrame:CreateFontString(nil, "OVERLAY")
		AcceptFrame.Text:FontTemplate(nil, 12)
		AcceptFrame.Text:Point("TOP", AcceptFrame, "TOP", 0, -16)

		AcceptFrame.Accept = CreateFrame("Button", nil, AcceptFrame, "OptionsButtonTemplate")
		AcceptFrame.Accept:Size(75, 21)
		AcceptFrame.Accept:Point("RIGHT", AcceptFrame, "BOTTOM", -5, 26)
		AcceptFrame.Accept:SetFormattedText(YES)
		S:HandleButton(AcceptFrame.Accept)

		AcceptFrame.Close = CreateFrame("Button", nil, AcceptFrame, "OptionsButtonTemplate")
		AcceptFrame.Close:Size(75, 21)
		AcceptFrame.Close:Point("LEFT", AcceptFrame, "BOTTOM", 5, 26)
		AcceptFrame.Close:SetScript("OnClick", function(self) self:GetParent():Hide() end)
		AcceptFrame.Close:SetFormattedText(NO)
		S:HandleButton(AcceptFrame.Close)
	end

	AcceptFrame.Text:SetText(MainText)
	AcceptFrame:Width(AcceptFrame.Text:GetStringWidth() + 50 > 200 and AcceptFrame.Text:GetStringWidth() + 50 or 200)
	AcceptFrame:Height(AcceptFrame.Text:GetStringHeight() + 60)
	AcceptFrame.Accept:SetScript("OnClick", Function)
	AcceptFrame:Show()
end