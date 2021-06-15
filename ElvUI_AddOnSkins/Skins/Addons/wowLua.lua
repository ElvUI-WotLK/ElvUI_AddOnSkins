local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

if not AS:IsAddonLODorEnabled("WowLua") then return end

-- WowLua r40
-- https://www.curseforge.com/wow/addons/wowlua/files/448825

S:AddCallbackForAddon("WowLua", "WowLua", function()
	if not E.private.addOnSkins.WowLua then return end

	WowLuaFrame:StripTextures()
	WowLuaFrame:SetTemplate("Transparent")
	WowLuaFrameLineNumScrollFrame:StripTextures()

	S:HandleCloseButton(WowLuaButton_Close, WowLuaFrame)

	WowLuaFrameTitle:Point("TOP", 0, -5)

	WowLuaFrameDragHeader:Height(55)
	WowLuaFrameDragHeader:SetPoint("TOPLEFT", 0, 0)

	WowLuaFrameToolbar:Point("TOPLEFT", 30, -21)
	WowLuaButton_New:SetPoint("LEFT", WowLuaFrameToolbar, "LEFT", 0, 0)

	WowLuaFrameLineNumEditBox:EnableMouse(false)

	WowLuaFrameEditFocusGrabber:SetTemplate("Transparent")
	WowLuaFrameEditFocusGrabber:Point("TOPLEFT", 8, -55)
	WowLuaFrameEditFocusGrabber:Point("BOTTOMRIGHT", WowLuaFrameResizeBar, "TOPRIGHT", -29, -6)

	WowLuaFrameEditScrollFrame:Point("BOTTOMRIGHT", WowLuaFrameResizeBar, "TOPRIGHT", -29, -3)

	S:HandleScrollBar(WowLuaFrameEditScrollFrameScrollBar)
	WowLuaFrameEditScrollFrameScrollBar:Point("TOPLEFT", WowLuaFrameEditScrollFrame, "TOPRIGHT", 3, -17)
	WowLuaFrameEditScrollFrameScrollBar:Point("BOTTOMLEFT", WowLuaFrameEditScrollFrame, "BOTTOMRIGHT", 3, 16)

	WowLuaFrameResizeBar:StripTextures()
	WowLuaFrameResizeBar:Height(20)

	WowLuaFrameOutput:Point("TOPLEFT", WowLuaFrameResizeBar, "BOTTOMLEFT", -6, 7)
	WowLuaFrameOutput:Point("RIGHT", -29, 0)
	WowLuaFrameOutput:Point("BOTTOM", WowLuaFrameCommand, "TOP", 8, 9)

	S:HandleNextPrevButton(WowLuaFrameOutputUpButton, "up")
	WowLuaFrameOutputUpButton:Size(18)
	WowLuaFrameOutputUpButton:Point("TOPRIGHT", 21, 0)

	S:HandleNextPrevButton(WowLuaFrameOutputDownButton)
	WowLuaFrameOutputDownButton:Size(18)
	WowLuaFrameOutputDownButton:Point("BOTTOMRIGHT", 21, -2)

	WowLuaFrameCommand:StripTextures()
	WowLuaFrameCommand:Point("BOTTOMLEFT", 8, 9)
	WowLuaFrameCommand:Point("BOTTOMRIGHT", -29, 0)
	WowLuaFrameCommand:CreateBackdrop()
	WowLuaFrameCommand.backdrop:SetPoint("TOPLEFT", 0, 0)
	WowLuaFrameCommand.backdrop:Point("BOTTOMRIGHT", 0, -1)

	local buttons = {
		WowLuaButton_New,
		WowLuaButton_Open,
		WowLuaButton_Save,
		WowLuaButton_Undo,
		WowLuaButton_Redo,
		WowLuaButton_Delete,
		WowLuaButton_Lock,
		WowLuaButton_Unlock,
		WowLuaButton_Config,
		WowLuaButton_Previous,
		WowLuaButton_Next,
		WowLuaButton_Run,
	}

	for _, object in ipairs(buttons) do
		object:CreateBackdrop()
		object:GetNormalTexture():SetTexCoord(0.125, 0.890625, 0.15625, 0.921875)
		if object:GetDisabledTexture() then
			object:GetDisabledTexture():SetTexCoord(0.125, 0.890625, 0.15625, 0.921875)
		end
		object:StyleButton(nil, true)
	end

	hooksecurefunc(WowLua, "UpdateLineNums", function()
		WowLuaFrameLineNumScrollFrame:Point("TOPLEFT", 8, -57)
	end)
end)