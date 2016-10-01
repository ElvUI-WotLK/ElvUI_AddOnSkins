local E, L, V, P, G, _ = unpack(ElvUI);
local addon = E:GetModule("AddOnSkins");
local TT = E:GetModule("Tooltip");

if(not addon:CheckAddOn("ChatBar")) then return; end

function addon:ChatBar()
	ChatBarFrameBackground:SetOutside();
	ChatBarFrameBackground:SetTemplate("Transparent");

	for i = 1, 20 do
		local button = _G["ChatBarFrameButton" .. i];
		button:StripTextures(true);
		button:SetTemplate("Default", true, true);

		button:GetNormalTexture():SetTexture("");
		button:GetPushedTexture():SetTexture("");
		button:GetHighlightTexture():SetTexture("");
		button:GetNormalTexture().SetTexture = E.noop;
		button:GetPushedTexture().SetTexture = E.noop;
		button:GetHighlightTexture().SetTexture = E.noop;
	end

	addon:SecureHook("ChatBar_UpdateButtonOrientation", function()
		local button;
		for i = 2, CHAT_BAR_MAX_BUTTONS do
			button = _G["ChatBarFrameButton"..i];
			button:ClearAllPoints();
			if(ChatBar_VerticalDisplay) then
				if(ChatBar_AlternateOrientation) then
					button:SetPoint("TOP", "ChatBarFrameButton"..(i-1), "BOTTOM", 0, -(E.Border + E.Spacing));
				else
					button:SetPoint("BOTTOM", "ChatBarFrameButton"..(i-1), "TOP", 0, E.Border + E.Spacing);
				end
			else
				if(ChatBar_AlternateOrientation) then
					button:SetPoint("RIGHT", "ChatBarFrameButton"..(i-1), "LEFT", -(E.Border + E.Spacing), 0);
				else
					button:SetPoint("LEFT", "ChatBarFrameButton"..(i-1), "RIGHT", E.Border + E.Spacing, 0);
				end
			end
		end
	end);

	addon:SecureHook("ChatBar_UpdateButtons", function()
		local i = 1;
		local buttonIndex = 1;
		if(not ChatBar_HideAllButtons) then
			while(ChatBar_ChatTypes[i] and buttonIndex <= 20) do
				if(ChatBar_ChatTypes[i].show()) then
					local info = ChatTypeInfo[ChatBar_ChatTypes[i].type];
					_G["ChatBarFrameButton" .. buttonIndex]:SetBackdropColor(info.r, info.g, info.b);
					buttonIndex = buttonIndex+1;
				end
				i = i + 1;
			end
		end
	end);

	TT:HookScript(ChatBarFrameTooltip, "OnShow", "SetStyle");
end

addon:RegisterSkin("ChatBar", addon.ChatBar);