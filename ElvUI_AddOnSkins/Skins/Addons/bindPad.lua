local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

if not AS:IsAddonLODorEnabled("BindPad") then return end

local _G = _G
local unpack = unpack

-- BindPad 2.2.4
-- https://www.curseforge.com/wow/addons/bind-pad/files/410752

S:AddCallbackForAddon("BindPad", "BindPad", function()
	if not E.private.addOnSkins.BindPad then return end

	BindPadFrame:StripTextures()
	BindPadFrame:CreateBackdrop("Transparent")
	BindPadFrame.backdrop:Point("TOPLEFT", 11, -12)
	BindPadFrame.backdrop:Point("BOTTOMRIGHT", -32, 76)

	S:SetBackdropHitRect(BindPadFrame)

	S:HandleCloseButton(BindPadFrameCloseButton, BindPadFrame.backdrop)

	local slot, slotIcon, slotBorder, slotAddButton
	for i = 1, 42 do
		slot = _G["BindPadSlot" .. i]
		slotIcon = _G["BindPadSlot" .. i .. "Icon"]
		slotBorder = _G["BindPadSlot" .. i .. "Border"]
		slotAddButton = _G["BindPadSlot" .. i .. "AddButton"]

		slot:SetNormalTexture(nil)
		slot:SetTemplate("Defaylt", true)
		slot:StyleButton(nil, nil, true)

		slotIcon:SetInside()
		slotIcon:SetTexCoord(unpack(E.TexCoords))
		slotIcon:SetDrawLayer("ARTWORK")

		slotBorder:SetTexture(1, 1, 0, 0.3)
		slotBorder:SetInside()

		slotAddButton:SetNormalTexture(nil)
		slotAddButton:SetPushedTexture(nil)
		slotAddButton:SetDisabledTexture(nil)
		slotAddButton:SetHighlightTexture(nil)

		slotAddButton.Text = slotAddButton:CreateFontString(nil, "OVERLAY")
		slotAddButton.Text:FontTemplate(nil, 22)
		slotAddButton.Text:SetPoint("CENTER", 0, 0)
		slotAddButton.Text:SetText("+")
	end

	for i = 1, 4 do
		local tab = _G["BindPadFrameTab" .. i]
		S:HandleTab(tab)
		tab.backdrop:Point("TOPLEFT", 3, -8)
		tab.backdrop:Point("BOTTOMRIGHT", -3, -1)
		S:SetBackdropHitRect(tab)
	end

	for i = 1, 5 do
		local tab = _G["BindPadProfileTab" .. i]
		local subIcon = _G["BindPadProfileTab" .. i .. "SubIcon"]

		tab:StripTextures()
		tab:SetTemplate("Defaylt", true)
		tab:StyleButton(nil, true)

		tab:GetNormalTexture():SetInside()
		tab:GetNormalTexture():SetTexCoord(unpack(E.TexCoords))
		tab:GetNormalTexture():SetDrawLayer("ARTWORK")

		subIcon:Point("BOTTOMRIGHT", -1, 1)
		subIcon:SetTexCoord(unpack(E.TexCoords))
	end

	BindPadProfileTab1:Point("TOPLEFT", BindPadFrame, "TOPRIGHT", -33, -65)

	local function HandleMicroButton(button)
		local pushed = button:GetPushedTexture()
		local normal = button:GetNormalTexture()
		local disabled = button:GetDisabledTexture()

		button:Size(20, 26)
		button:SetHitRectInsets(0, 0, 0, 0)
		button:GetHighlightTexture():Kill()

		button:CreateBackdrop()

		normal:SetInside(button.backdrop)
		-- texWidth, texHeight, cropWidth, cropHeight, offsetX, offsetY = 32, 64, 21, 27, 5, 31
		normal:SetTexCoord(0.15625, 0.8125, 0.484375, 0.90625)

		pushed:SetInside(button.backdrop)
		-- texWidth, texHeight, cropWidth, cropHeight, offsetX, offsetY = 32, 64, 20, 26, 5, 33
		pushed:SetTexCoord(0.15625, 0.78125, 0.515625, 0.921875)

		if disabled then
			disabled:SetInside(button.backdrop)
			-- texWidth, texHeight, cropWidth, cropHeight, offsetX, offsetY = 32, 64, 21, 27, 5, 31
			disabled:SetTexCoord(0.15625, 0.8125, 0.484375, 0.90625)
		end
	end

	S:HandleCheckBox(BindPadFrameCharacterButton)
	S:HandleCheckBox(BindPadFrameShowHotkeysButton)
	S:HandleCheckBox(BindPadFrameTriggerOnKeydownButton)

	S:HandleButton(BindPadFrameExitButton)

	HandleMicroButton(BindPadFrameOpenSpellBookButton)
	HandleMicroButton(BindPadFrameOpenMacroButton)
	HandleMicroButton(BindPadFrameOpenBagButton)

	BindPadFrameOpenSpellBookButton:Point("BOTTOMLEFT", BindPadFrame, "TOPLEFT", 20, -427)
	BindPadFrameOpenMacroButton:Point("BOTTOMLEFT", BindPadFrameOpenSpellBookButton, "BOTTOMRIGHT", 5, 0)
	BindPadFrameOpenBagButton:Point("BOTTOMLEFT", BindPadFrameOpenMacroButton, "BOTTOMRIGHT", 5, 0)

	BindPadFrameShowHotkeysButton:Point("BOTTOMLEFT", BindPadFrameOpenBagButton, "BOTTOMRIGHT", 15, 11)
	BindPadFrameTriggerOnKeydownButton:Point("BOTTOMLEFT", BindPadFrameOpenBagButton, "BOTTOMRIGHT", 15, -5)

	BindPadFrameExitButton:Point("CENTER", BindPadFrame, "TOPLEFT", 304, -417)

	-- Popup frame
	S:HandleIconSelectionFrame(BindPadMacroPopupFrame, 20, "BindPadMacroPopupButton", "BindPadMacroPopup")
	S:SetBackdropHitRect(BindPadMacroPopupFrame)
	BindPadMacroPopupFrame:Point("TOPLEFT", BindPadFrame, "TOPRIGHT", -43, 0)

	BindPadMacroPopupScrollFrame:SetTemplate("Transparent")

	S:HandleScrollBar(BindPadMacroPopupScrollFrameScrollBar)

	local text1, text2 = select(5, BindPadMacroPopupFrame:GetRegions())
	text1:Point("TOPLEFT", 24, -18)
	text2:Point("TOPLEFT", 24, -60)

	BindPadMacroPopupEditBox:Point("TOPLEFT", 61, -35)

	BindPadMacroPopupButton1:Point("TOPLEFT", 31, -82)

	BindPadMacroPopupScrollFrame:Size(247, 180)
	BindPadMacroPopupScrollFrame:Point("TOPRIGHT", -32, -76)

	BindPadMacroPopupScrollFrameScrollBar:Point("TOPLEFT", BindPadMacroPopupScrollFrame, "TOPRIGHT", 3, -19)
	BindPadMacroPopupScrollFrameScrollBar:Point("BOTTOMLEFT", BindPadMacroPopupScrollFrame, "BOTTOMRIGHT", 3, 19)

	BindPadMacroPopupOkayButton:Point("RIGHT", BindPadMacroPopupCancelButton, "LEFT", -3, 0)

	-- Macro Text
	BindPadMacroTextFrame:StripTextures()
	BindPadMacroTextFrame:CreateBackdrop("Transparent")
	BindPadMacroTextFrame.backdrop:Point("TOPLEFT", 11, -12)
	BindPadMacroTextFrame.backdrop:Point("BOTTOMRIGHT", -32, 76)

	S:SetBackdropHitRect(BindPadMacroTextFrame)

	S:HandleCloseButton(BindPadMacroTextFrameCloseButton, BindPadMacroTextFrame.backdrop)

	BindPadMacroTextFrameSelectedMacroButton:StripTextures()
	BindPadMacroTextFrameSelectedMacroButton:SetTemplate("Defaylt", true)
	BindPadMacroTextFrameSelectedMacroButtonIcon:SetInside()
	BindPadMacroTextFrameSelectedMacroButtonIcon:SetTexCoord(unpack(E.TexCoords))

	BindPadMacroTextFrameTextBackground:SetTemplate("Defaylt")

	S:HandleScrollBar(BindPadMacroTextFrameScrollFrameScrollBar)

	S:HandleButton(BindPadMacroTextFrameEditButton)
	S:HandleButton(BindPadMacroTextFrameTestButton)
	S:HandleButton(BindPadMacroTextFrameExitButton)
	S:HandleButton(BindPadMacroDeleteButton)

	BindPadMacroTextFrameEnterMacroText:Point("TOPLEFT", BindPadMacroTextFrameSelectedMacroBackground, "BOTTOMLEFT", 8, 3)

	BindPadMacroTextFrameTextBackground:Size(304, 252)
	BindPadMacroTextFrameTextBackground:Point("TOPLEFT", 19, -147)

	BindPadMacroTextFrameText:Width(298)

	BindPadMacroTextFrameScrollFrame:Size(298, 241)
	BindPadMacroTextFrameScrollFrame:Point("TOPLEFT", BindPadMacroTextFrameSelectedMacroBackground, "BOTTOMLEFT", 6, -16)

	BindPadMacroTextFrameScrollFrameScrollBar:Point("TOPLEFT", BindPadMacroTextFrameScrollFrame, "TOPRIGHT", 6, -14)
	BindPadMacroTextFrameScrollFrameScrollBar:Point("BOTTOMLEFT", BindPadMacroTextFrameScrollFrame, "BOTTOMRIGHT", 6, 13)

	BindPadMacroTextFrameSelectedMacroName:Point("TOPLEFT", BindPadMacroTextFrameSelectedMacroBackground, "TOPRIGHT", -4, -12)
	BindPadMacroTextFrameEditButton:Point("TOPLEFT", BindPadMacroTextFrameSelectedMacroBackground, "TOPLEFT", 53, -28)

	BindPadMacroDeleteButton:Point("BOTTOMLEFT", 19, 84)
	BindPadMacroTextFrameTestButton:Point("CENTER", BindPadMacroTextFrame, "TOPLEFT", 221, -417)
	BindPadMacroTextFrameExitButton:Point("CENTER", BindPadMacroTextFrame, "TOPLEFT", 304, -417)

	-- Bind
	BindPadBindFrame:StripTextures()
	BindPadBindFrame:SetTemplate("Transparent")
	BindPadBindFrame:Size(400, 150)

	S:HandleCloseButton(BindPadBindFrameCloseButton, BindPadBindFrame)

	S:HandleButton(BindPadBindFrameUnbindButton)
	S:HandleButton(BindPadBindFrameExitButton)

	S:HandleCheckBox(BindPadBindFrameFastTriggerButton)
end)