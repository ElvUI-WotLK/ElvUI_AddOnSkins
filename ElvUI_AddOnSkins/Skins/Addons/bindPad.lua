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

if not AS:IsAddonLODorEnabled("BindPad") then return end

local _G = _G
local unpack = unpack

-- BindPad 2.2.4
-- https://www.curseforge.com/wow/addons/bind-pad/files/410752

S:AddCallbackForAddon("BindPad", "BindPad", function()
	if not E.private.addOnSkins.BindPad then return end

	SkinFrame(BindPadFrame, "StripTextures")
	BindPadFrame:CreateBackdrop("Transparent")
	BindPadFrame.backdrop:Point("TOPLEFT", 11, -12)
	BindPadFrame.backdrop:Point("BOTTOMRIGHT", -32, 76)

	S:SetBackdropHitRect(BindPadFrame)

	SkinControl("HandleCloseButton", BindPadFrameCloseButton, BindPadFrame.backdrop)

	local slot, slotIcon, slotBorder, slotAddButton
	for i = 1, 42 do
		slot = _G["BindPadSlot" .. i]
		slotIcon = _G["BindPadSlot" .. i .. "Icon"]
		slotBorder = _G["BindPadSlot" .. i .. "Border"]
		slotAddButton = _G["BindPadSlot" .. i .. "AddButton"]

		SkinFrame(slot, "SetNormalTexture", nil)
		SkinFrame(slot, "SetTemplate", "Defaylt", true)
		SkinFrame(slot, "StyleButton", nil, nil, true)

		SkinFrame(slotIcon, "SetInside")
		SkinFrame(slotIcon, "SetTexCoord", unpack(E.TexCoords))
		slotIcon:SetDrawLayer("ARTWORK")

		slotBorder:SetTexture(1, 1, 0, 0.3)
		SkinFrame(slotBorder, "SetInside")

		SkinFrame(slotAddButton, "SetNormalTexture", nil)
		SkinFrame(slotAddButton, "SetPushedTexture", nil)
		SkinFrame(slotAddButton, "SetDisabledTexture", nil)
		SkinFrame(slotAddButton, "SetHighlightTexture", nil)

		slotAddButton.Text = slotAddButton:CreateFontString(nil, "OVERLAY")
		slotAddButton.Text:FontTemplate(nil, 22)
		slotAddButton.Text:SetPoint("CENTER", 0, 0)
		slotAddButton.Text:SetText("+")
	end

	for i = 1, 4 do
		local tab = _G["BindPadFrameTab" .. i]
		SkinControl("HandleTab", tab)
		tab.backdrop:Point("TOPLEFT", 3, -8)
		tab.backdrop:Point("BOTTOMRIGHT", -3, -1)
		S:SetBackdropHitRect(tab)
	end

	for i = 1, 5 do
		local tab = _G["BindPadProfileTab" .. i]
		local subIcon = _G["BindPadProfileTab" .. i .. "SubIcon"]

		SkinFrame(tab, "StripTextures")
		SkinFrame(tab, "SetTemplate", "Defaylt", true)
		SkinFrame(tab, "StyleButton", nil, true)

		tab:GetNormalTexture():SetInside()
		tab:GetNormalTexture():SetTexCoord(unpack(E.TexCoords))
		tab:GetNormalTexture():SetDrawLayer("ARTWORK")

		SkinFrame(subIcon, "Point", "BOTTOMRIGHT", -1, 1)
		SkinFrame(subIcon, "SetTexCoord", unpack(E.TexCoords))
	end

	SkinFrame(BindPadProfileTab1, "Point", "TOPLEFT", BindPadFrame, "TOPRIGHT", -33, -65)

	local function HandleMicroButton(button)
		local pushed = button:GetPushedTexture()
		local normal = button:GetNormalTexture()
		local disabled = button:GetDisabledTexture()

		SkinFrame(button, "Size", 20, 26)
		button:SetHitRectInsets(0, 0, 0, 0)
		button:GetHighlightTexture():Kill()

		button:CreateBackdrop()

		SkinFrame(normal, "SetInside", button.backdrop)
		-- texWidth, texHeight, cropWidth, cropHeight, offsetX, offsetY = 32, 64, 21, 27, 5, 31
		SkinFrame(normal, "SetTexCoord", 0.15625, 0.8125, 0.484375, 0.90625)

		SkinFrame(pushed, "SetInside", button.backdrop)
		-- texWidth, texHeight, cropWidth, cropHeight, offsetX, offsetY = 32, 64, 20, 26, 5, 33
		SkinFrame(pushed, "SetTexCoord", 0.15625, 0.78125, 0.515625, 0.921875)

		if disabled then
			SkinFrame(disabled, "SetInside", button.backdrop)
			-- texWidth, texHeight, cropWidth, cropHeight, offsetX, offsetY = 32, 64, 21, 27, 5, 31
			SkinFrame(disabled, "SetTexCoord", 0.15625, 0.8125, 0.484375, 0.90625)
		end
	end

	SkinControl("HandleCheckBox", BindPadFrameCharacterButton)
	SkinControl("HandleCheckBox", BindPadFrameShowHotkeysButton)
	SkinControl("HandleCheckBox", BindPadFrameTriggerOnKeydownButton)

	SkinControl("HandleButton", BindPadFrameExitButton)

	HandleMicroButton(BindPadFrameOpenSpellBookButton)
	HandleMicroButton(BindPadFrameOpenMacroButton)
	HandleMicroButton(BindPadFrameOpenBagButton)

	SkinFrame(BindPadFrameOpenSpellBookButton, "Point", "BOTTOMLEFT", BindPadFrame, "TOPLEFT", 20, -427)
	SkinFrame(BindPadFrameOpenMacroButton, "Point", "BOTTOMLEFT", BindPadFrameOpenSpellBookButton, "BOTTOMRIGHT", 5, 0)
	SkinFrame(BindPadFrameOpenBagButton, "Point", "BOTTOMLEFT", BindPadFrameOpenMacroButton, "BOTTOMRIGHT", 5, 0)

	SkinFrame(BindPadFrameShowHotkeysButton, "Point", "BOTTOMLEFT", BindPadFrameOpenBagButton, "BOTTOMRIGHT", 15, 11)
	SkinFrame(BindPadFrameTriggerOnKeydownButton, "Point", "BOTTOMLEFT", BindPadFrameOpenBagButton, "BOTTOMRIGHT", 15, -5)

	SkinFrame(BindPadFrameExitButton, "Point", "CENTER", BindPadFrame, "TOPLEFT", 304, -417)

	-- Popup frame
	SkinControl("HandleIconSelectionFrame", BindPadMacroPopupFrame, 20, "BindPadMacroPopupButton", "BindPadMacroPopup")
	S:SetBackdropHitRect(BindPadMacroPopupFrame)
	SkinFrame(BindPadMacroPopupFrame, "Point", "TOPLEFT", BindPadFrame, "TOPRIGHT", -43, 0)

	SkinFrame(BindPadMacroPopupScrollFrame, "SetTemplate", "Transparent")

	SkinControl("HandleScrollBar", BindPadMacroPopupScrollFrameScrollBar)

	local text1, text2 = select(5, BindPadMacroPopupFrame:GetRegions())
	SkinFrame(text1, "Point", "TOPLEFT", 24, -18)
	SkinFrame(text2, "Point", "TOPLEFT", 24, -60)

	SkinFrame(BindPadMacroPopupEditBox, "Point", "TOPLEFT", 61, -35)

	SkinFrame(BindPadMacroPopupButton1, "Point", "TOPLEFT", 31, -82)

	SkinFrame(BindPadMacroPopupScrollFrame, "Size", 247, 180)
	SkinFrame(BindPadMacroPopupScrollFrame, "Point", "TOPRIGHT", -32, -76)

	SkinFrame(BindPadMacroPopupScrollFrameScrollBar, "Point", "TOPLEFT", BindPadMacroPopupScrollFrame, "TOPRIGHT", 3, -19)
	SkinFrame(BindPadMacroPopupScrollFrameScrollBar, "Point", "BOTTOMLEFT", BindPadMacroPopupScrollFrame, "BOTTOMRIGHT", 3, 19)

	SkinFrame(BindPadMacroPopupOkayButton, "Point", "RIGHT", BindPadMacroPopupCancelButton, "LEFT", -3, 0)

	-- Macro Text
	SkinFrame(BindPadMacroTextFrame, "StripTextures")
	BindPadMacroTextFrame:CreateBackdrop("Transparent")
	BindPadMacroTextFrame.backdrop:Point("TOPLEFT", 11, -12)
	BindPadMacroTextFrame.backdrop:Point("BOTTOMRIGHT", -32, 76)

	S:SetBackdropHitRect(BindPadMacroTextFrame)

	SkinControl("HandleCloseButton", BindPadMacroTextFrameCloseButton, BindPadMacroTextFrame.backdrop)

	SkinFrame(BindPadMacroTextFrameSelectedMacroButton, "StripTextures")
	SkinFrame(BindPadMacroTextFrameSelectedMacroButton, "SetTemplate", "Defaylt", true)
	SkinFrame(BindPadMacroTextFrameSelectedMacroButtonIcon, "SetInside")
	SkinFrame(BindPadMacroTextFrameSelectedMacroButtonIcon, "SetTexCoord", unpack(E.TexCoords))

	SkinFrame(BindPadMacroTextFrameTextBackground, "SetTemplate", "Defaylt")

	SkinControl("HandleScrollBar", BindPadMacroTextFrameScrollFrameScrollBar)

	SkinControl("HandleButton", BindPadMacroTextFrameEditButton)
	SkinControl("HandleButton", BindPadMacroTextFrameTestButton)
	SkinControl("HandleButton", BindPadMacroTextFrameExitButton)
	SkinControl("HandleButton", BindPadMacroDeleteButton)

	SkinFrame(BindPadMacroTextFrameEnterMacroText, "Point", "TOPLEFT", BindPadMacroTextFrameSelectedMacroBackground, "BOTTOMLEFT", 8, 3)

	SkinFrame(BindPadMacroTextFrameTextBackground, "Size", 304, 252)
	SkinFrame(BindPadMacroTextFrameTextBackground, "Point", "TOPLEFT", 19, -147)

	SkinFrame(BindPadMacroTextFrameText, "Width", 298)

	SkinFrame(BindPadMacroTextFrameScrollFrame, "Size", 298, 241)
	SkinFrame(BindPadMacroTextFrameScrollFrame, "Point", "TOPLEFT", BindPadMacroTextFrameSelectedMacroBackground, "BOTTOMLEFT", 6, -16)

	SkinFrame(BindPadMacroTextFrameScrollFrameScrollBar, "Point", "TOPLEFT", BindPadMacroTextFrameScrollFrame, "TOPRIGHT", 6, -14)
	SkinFrame(BindPadMacroTextFrameScrollFrameScrollBar, "Point", "BOTTOMLEFT", BindPadMacroTextFrameScrollFrame, "BOTTOMRIGHT", 6, 13)

	SkinFrame(BindPadMacroTextFrameSelectedMacroName, "Point", "TOPLEFT", BindPadMacroTextFrameSelectedMacroBackground, "TOPRIGHT", -4, -12)
	SkinFrame(BindPadMacroTextFrameEditButton, "Point", "TOPLEFT", BindPadMacroTextFrameSelectedMacroBackground, "TOPLEFT", 53, -28)

	SkinFrame(BindPadMacroDeleteButton, "Point", "BOTTOMLEFT", 19, 84)
	SkinFrame(BindPadMacroTextFrameTestButton, "Point", "CENTER", BindPadMacroTextFrame, "TOPLEFT", 221, -417)
	SkinFrame(BindPadMacroTextFrameExitButton, "Point", "CENTER", BindPadMacroTextFrame, "TOPLEFT", 304, -417)

	-- Bind
	SkinFrame(BindPadBindFrame, "StripTextures")
	SkinFrame(BindPadBindFrame, "SetTemplate", "Transparent")
	SkinFrame(BindPadBindFrame, "Size", 400, 150)

	SkinControl("HandleCloseButton", BindPadBindFrameCloseButton, BindPadBindFrame)

	SkinControl("HandleButton", BindPadBindFrameUnbindButton)
	SkinControl("HandleButton", BindPadBindFrameExitButton)

	SkinControl("HandleCheckBox", BindPadBindFrameFastTriggerButton)
end)
