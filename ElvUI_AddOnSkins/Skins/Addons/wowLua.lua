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

if not AS:IsAddonLODorEnabled("WowLua") then return end

-- WowLua r40
-- https://www.curseforge.com/wow/addons/wowlua/files/448825

S:AddCallbackForAddon("WowLua", "WowLua", function()
	if not E.private.addOnSkins.WowLua then return end

	SkinFrame(WowLuaFrame, "StripTextures")
	SkinFrame(WowLuaFrame, "SetTemplate", "Transparent")
	SkinFrame(WowLuaFrameLineNumScrollFrame, "StripTextures")

	SkinControl("HandleCloseButton", WowLuaButton_Close, WowLuaFrame)

	SkinFrame(WowLuaFrameTitle, "Point", "TOP", 0, -5)

	SkinFrame(WowLuaFrameDragHeader, "Height", 55)
	SkinFrame(WowLuaFrameDragHeader, "SetPoint", "TOPLEFT", 0, 0)

	SkinFrame(WowLuaFrameToolbar, "Point", "TOPLEFT", 30, -21)
	SkinFrame(WowLuaButton_New, "SetPoint", "LEFT", WowLuaFrameToolbar, "LEFT", 0, 0)

	WowLuaFrameLineNumEditBox:EnableMouse(false)

	SkinFrame(WowLuaFrameEditFocusGrabber, "SetTemplate", "Transparent")
	SkinFrame(WowLuaFrameEditFocusGrabber, "Point", "TOPLEFT", 8, -55)
	SkinFrame(WowLuaFrameEditFocusGrabber, "Point", "BOTTOMRIGHT", WowLuaFrameResizeBar, "TOPRIGHT", -29, -6)

	SkinFrame(WowLuaFrameEditScrollFrame, "Point", "BOTTOMRIGHT", WowLuaFrameResizeBar, "TOPRIGHT", -29, -3)

	SkinControl("HandleScrollBar", WowLuaFrameEditScrollFrameScrollBar)
	SkinFrame(WowLuaFrameEditScrollFrameScrollBar, "Point", "TOPLEFT", WowLuaFrameEditScrollFrame, "TOPRIGHT", 3, -17)
	SkinFrame(WowLuaFrameEditScrollFrameScrollBar, "Point", "BOTTOMLEFT", WowLuaFrameEditScrollFrame, "BOTTOMRIGHT", 3, 16)

	SkinFrame(WowLuaFrameResizeBar, "StripTextures")
	SkinFrame(WowLuaFrameResizeBar, "Height", 20)

	SkinFrame(WowLuaFrameOutput, "Point", "TOPLEFT", WowLuaFrameResizeBar, "BOTTOMLEFT", -6, 7)
	SkinFrame(WowLuaFrameOutput, "Point", "RIGHT", -29, 0)
	SkinFrame(WowLuaFrameOutput, "Point", "BOTTOM", WowLuaFrameCommand, "TOP", 8, 9)

	SkinControl("HandleNextPrevButton", WowLuaFrameOutputUpButton, "up")
	SkinFrame(WowLuaFrameOutputUpButton, "Size", 18)
	SkinFrame(WowLuaFrameOutputUpButton, "Point", "TOPRIGHT", 21, 0)

	SkinControl("HandleNextPrevButton", WowLuaFrameOutputDownButton)
	SkinFrame(WowLuaFrameOutputDownButton, "Size", 18)
	SkinFrame(WowLuaFrameOutputDownButton, "Point", "BOTTOMRIGHT", 21, -2)

	SkinFrame(WowLuaFrameCommand, "StripTextures")
	SkinFrame(WowLuaFrameCommand, "Point", "BOTTOMLEFT", 8, 9)
	SkinFrame(WowLuaFrameCommand, "Point", "BOTTOMRIGHT", -29, 0)
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
		SkinFrame(object, "StyleButton", nil, true)
	end

	hooksecurefunc(WowLua, "UpdateLineNums", function()
		SkinFrame(WowLuaFrameLineNumScrollFrame, "Point", "TOPLEFT", 8, -57)
	end)
end)
