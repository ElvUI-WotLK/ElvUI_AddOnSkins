local E, L, V, P, G = unpack(ElvUI)
local AS = E:GetModule("AddOnSkins")
local S = E:GetModule("Skins")

function AS:AcceptFrame(text, onClick)
	if not self.acceptFrame then
		local acceptFrame = CreateFrame("Frame", "ElvUI_AcceptFrame", UIParent)
		acceptFrame:SetTemplate("Transparent")
		acceptFrame:SetPoint("CENTER", UIParent, "CENTER")
		acceptFrame:SetFrameStrata("DIALOG")
		acceptFrame:EnableMouse(true)
		table.insert(UISpecialFrames, acceptFrame:GetName())

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

	self.acceptFrame.Text:SetText(text)
	self.acceptFrame:Width(self.acceptFrame.Text:GetStringWidth() + 50 > 200 and self.acceptFrame.Text:GetStringWidth() + 50 or 200)
	self.acceptFrame:Height(self.acceptFrame.Text:GetStringHeight() + 60)
	self.acceptFrame.Accept:SetScript("OnClick", onClick)
	self.acceptFrame:Show()
end