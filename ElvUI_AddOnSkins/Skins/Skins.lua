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
	if not self.acceptFrame then
		local acceptFrame = CreateFrame("Frame", "ElvUI_AcceptFrame", UIParent)
		acceptFrame:SetTemplate("Transparent")
		acceptFrame:Point("CENTER", UIParent, "CENTER")
		acceptFrame:SetFrameStrata("DIALOG")
		acceptFrame:EnableMouse(true)
		tinsert(UISpecialFrames, acceptFrame:GetName())

		acceptFrame.Text = acceptFrame:CreateFontString(nil, "OVERLAY")
		acceptFrame.Text:FontTemplate(nil, 12)
		acceptFrame.Text:Point("TOP", acceptFrame, "TOP", 0, -16)

		acceptFrame.Accept = CreateFrame("Button", nil, acceptFrame, "OptionsButtonTemplate")
		acceptFrame.Accept:Size(75, 21)
		acceptFrame.Accept:Point("RIGHT", acceptFrame, "BOTTOM", -5, 26)
		acceptFrame.Accept:SetFormattedText(YES)
		S:HandleButton(acceptFrame.Accept)

		acceptFrame.Close = CreateFrame("Button", nil, acceptFrame, "OptionsButtonTemplate")
		acceptFrame.Close:Size(75, 21)
		acceptFrame.Close:Point("LEFT", acceptFrame, "BOTTOM", 5, 26)
		acceptFrame.Close:SetScript("OnClick", function(self) self:GetParent():Hide() end)
		acceptFrame.Close:SetFormattedText(NO)
		S:HandleButton(acceptFrame.Close)

		self.acceptFrame = acceptFrame
	end

	self.acceptFrame.Text:SetText(MainText)
	self.acceptFrame:Width(self.acceptFrame.Text:GetStringWidth() + 50 > 200 and self.acceptFrame.Text:GetStringWidth() + 50 or 200)
	self.acceptFrame:Height(self.acceptFrame.Text:GetStringHeight() + 60)
	self.acceptFrame.Accept:SetScript("OnClick", Function)
	self.acceptFrame:Show()
end