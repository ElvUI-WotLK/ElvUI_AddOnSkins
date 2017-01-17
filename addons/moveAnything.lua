local E, L, V, P, G = unpack(ElvUI);
local S = E:GetModule("Skins");

local function LoadSkin()
	if(not E.private.addOnSkins.MoveAnything) then return; end

	local SPACING = 1 + (E.Spacing*2);

	for i = 1, 20 do
		_G["MAMover" .. i .. "Backdrop"]:SetTemplate("Transparent", nil, nil, true);
		_G["MAMover" .. i]:HookScript("OnShow", function(self)
			_G[self:GetName() .. "Backdrop"]:SetBackdropBorderColor(unpack(E["media"].rgbvaluecolor));
		end);
		_G["MAMover" .. i]:SetScript("OnEnter", function(self)
			_G[self:GetName() .. "BackdropMovingFrameName"]:SetTextColor(1, 1, 1);
		end);
		_G["MAMover" .. i]:SetScript("OnLeave", function(self)
			_G[self:GetName() .. "BackdropMovingFrameName"]:SetTextColor(unpack(E["media"].rgbvaluecolor));
		end);
	end

	MAOptions:StripTextures();
	MAOptions:SetTemplate("Transparent");
	MAOptions:Size(420, 500 + (16*SPACING));

	S:HandleCheckBox(MAOptionsCharacterSpecific);
	S:HandleCheckBox(MAOptionsToggleTooltips);
	S:HandleCheckBox(MAOptionsToggleModifiedFramesOnly);
	S:HandleCheckBox(MAOptionsToggleCategories);

	S:HandleButton(MAOptionsResetAll);
	S:HandleButton(MAOptionsClose);
	S:HandleButton(MAOptionsSync);

	for i = 1, 17 do
		_G["MAMove" .. i .. "Backdrop"]:SetTemplate("Default");
		S:HandleCheckBox(_G["MAMove" .. i .. "Move"]);
		S:HandleCheckBox(_G["MAMove" .. i .. "Hide"]);
		S:HandleButton(_G["MAMove" .. i .. "Reset"]);

		if(i ~= 1) then
			_G["MAMove" .. i]:SetPoint("TOPLEFT", "MAMove" .. (i - 1), "BOTTOMLEFT", 0, -SPACING);
		end
	end

	MAScrollFrame:Size(380, 442 + (16*SPACING));
	S:HandleScrollBar(MAScrollFrameScrollBar);
	MAScrollBorder:StripTextures();

	MANudger:SetTemplate("Transparent");
	S:HandleButton(MANudger_NudgeUp);
	MANudger_NudgeUp:Point("CENTER", 0, 24 + SPACING);
	S:HandleButton(MANudger_CenterMe);
	MANudger_CenterMe:Point("TOP", MANudger_NudgeUp, "BOTTOM", 0, -SPACING);
	S:HandleButton(MANudger_NudgeDown);
	MANudger_NudgeDown:Point("TOP", MANudger_CenterMe, "BOTTOM", 0, -SPACING);
	S:HandleButton(MANudger_NudgeLeft);
	MANudger_NudgeLeft:Point("RIGHT", MANudger_CenterMe, "LEFT", -SPACING, 0);
	S:HandleButton(MANudger_NudgeRight);
	MANudger_NudgeRight:Point("LEFT", MANudger_CenterMe, "RIGHT", SPACING, 0);
	S:HandleButton(MANudger_CenterH);
	S:HandleButton(MANudger_CenterV);
	S:HandleButton(MANudger_Detach);
	S:HandleButton(MANudger_Hide);
	S:HandleButton(MANudger_MoverPlus);
	S:HandleButton(MANudger_MoverMinus);

	S:HandleButton(GameMenuButtonMoveAnything);
end

S:AddCallbackForAddon("MoveAnything", "MoveAnything", LoadSkin);