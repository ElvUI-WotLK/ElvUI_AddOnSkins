local E, L, V, P, G = unpack(ElvUI);
local S = E:GetModule("Skins");

local function LoadSkin()
	if(not E.private.addOnSkins.Recount) then return; end

	local MainWindow = Recount.MainWindow;
	MainWindow:SetBackdrop(nil);

	local backdrop = CreateFrame("Frame", nil, MainWindow);
	backdrop:SetFrameLevel(MainWindow:GetFrameLevel() - 1);
	backdrop:Point("BOTTOMLEFT", MainWindow, E.PixelMode and 1 or 0, E.PixelMode and 1 or 0);
	backdrop:Point("TOPRIGHT", MainWindow, E.PixelMode and -1 or 0, -(E.PixelMode and 31 or 30));
	backdrop:SetTemplate("Default");
	MainWindow.backdrop = backdrop;

	local header = CreateFrame("Frame", nil, backdrop);
	header:Height(E.PixelMode and 22 or 20);
	header:Point("TOPLEFT", MainWindow, E.PixelMode and 1 or 0, -(E.PixelMode and 8 or 7));
	header:Point("TOPRIGHT", MainWindow, E.PixelMode and -1 or 0, 0);
	header:SetTemplate("Default", true);

	MainWindow.Title:ClearAllPoints();
	MainWindow.Title:SetPoint("LEFT", header, 6, 0);
	MainWindow.Title:FontTemplate();
	MainWindow.Title:SetTextColor(unpack(E.media.rgbvaluecolor));

	S:HandleScrollBar(Recount_MainWindow_ScrollBarScrollBar);

	MainWindow.DragBottomLeft:SetNormalTexture(nil);
	MainWindow.DragBottomRight:SetNormalTexture(nil);

	MainWindow.CloseButton:ClearAllPoints();
	MainWindow.CloseButton:SetPoint("RIGHT", header, -6, 0);

	local buttons = {
		Recount.MainWindow.CloseButton,
		Recount.MainWindow.RightButton,
		Recount.MainWindow.LeftButton,
		Recount.MainWindow.ResetButton,
		Recount.MainWindow.FileButton,
		Recount.MainWindow.ConfigButton,
		Recount.MainWindow.ReportButton
	};

	for i = 1, getn(buttons) do
		local button = buttons[i];
		if(button) then
			button:GetNormalTexture():SetDesaturated(true);
			button:GetHighlightTexture():SetDesaturated(true);
		end
	end

	hooksecurefunc(Recount, "HideScrollbarElements", function(self, name)
		_G[name .. "ScrollBar"].trackbg:Hide();
		_G[name .. "ScrollBar"].thumbbg:Hide();
	end);
	hooksecurefunc(Recount, "ShowScrollbarElements", function(self, name)
		_G[name .. "ScrollBar"].trackbg:Show();
		_G[name .. "ScrollBar"].thumbbg:Show();
	end);

	if(Recount.db.profile.MainWindow.ShowScrollbar) then
		Recount:ShowScrollbarElements("Recount_MainWindow_ScrollBar");
	else
		Recount:HideScrollbarElements("Recount_MainWindow_ScrollBar");
	end
end

S:AddCallbackForAddon("Recount", "Recount", LoadSkin);