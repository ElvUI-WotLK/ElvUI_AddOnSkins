local E, L, V, P, G, _ = unpack(ElvUI);
local S = E:GetModule("Skins");

local function LoadSkin()
	if(not E.private.addOnSkins.WowLua) then return; end

	WowLuaFrame:StripTextures();
	WowLuaFrame:SetTemplate("Transparent");
	WowLuaFrameLineNumScrollFrame:StripTextures();
	WowLuaFrameResizeBar:StripTextures();
	WowLuaFrameResizeBar:Height(10);
	S:HandleCloseButton(WowLuaButton_Close);
	WowLuaButton_Close:Point("TOPRIGHT", WowLuaFrame, "TOPRIGHT", 0 , 0);
	S:HandleScrollBar(WowLuaFrameEditScrollFrameScrollBar);
	WowLuaButton_New:Point("LEFT", WowLuaFrameToolbar, "LEFT", 0, 0);

	WowLuaFrameEditFocusGrabber.bg1 = CreateFrame("Frame", nil, WowLuaFrameEditFocusGrabber);
	WowLuaFrameEditFocusGrabber.bg1:CreateBackdrop();
	WowLuaFrameEditFocusGrabber.bg1:Point("TOPLEFT", 0, 0);
	WowLuaFrameEditFocusGrabber.bg1:Point("BOTTOMRIGHT", 5, -5);

	WowLuaFrameCommand:StripTextures();
	WowLuaFrameCommand.bg1 = CreateFrame("Frame", nil, WowLuaFrameCommand);
	WowLuaFrameCommand.bg1:CreateBackdrop();
	WowLuaFrameCommand.bg1:Point("TOPLEFT", -2, 0);
	WowLuaFrameCommand.bg1:Point("BOTTOMRIGHT", -10, 0);

	local Buttons = {
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

	for _, object in ipairs(Buttons) do
		object:CreateBackdrop();
		object:GetNormalTexture():SetTexCoord(.1, .92, .14, .92);
		if(object:GetDisabledTexture()) then
			object:GetDisabledTexture():SetTexCoord(.1, .92, .14, .92);
		end
		object:StyleButton(nil, true);
	end

	S:HandleNextPrevButton(WowLuaFrameOutputUpButton);
	S:SquareButton_SetIcon(WowLuaFrameOutputUpButton, "UP");
	WowLuaFrameOutputUpButton:Size(18);

	S:HandleNextPrevButton(WowLuaFrameOutputDownButton);
	S:SquareButton_SetIcon(WowLuaFrameOutputDownButton, "DOWN");
	WowLuaFrameOutputDownButton:Size(18);
end

S:AddCallbackForAddon("WowLua", "WowLua", LoadSkin);