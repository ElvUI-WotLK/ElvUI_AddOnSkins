local E, L, V, P, G, _ = unpack(ElvUI);
local addon = E:GetModule("AddOnSkins");

if(not addon:CheckAddOn("Recount")) then return; end

function addon:Recount()
	local S = E:GetModule("Skins");
	Recount_MainWindow:SetBackdrop(nil);
	
	local backdrop = CreateFrame("Frame", nil, Recount_MainWindow);
	backdrop:SetFrameLevel(Recount_MainWindow:GetFrameLevel() - 1);
	backdrop:Point("BOTTOMLEFT", Recount_MainWindow, 0, 0);
	backdrop:Point("TOPRIGHT", Recount_MainWindow, 0, -(E.PixelMode and 30 or 32));
	backdrop:SetTemplate("Default");
	Recount_MainWindow.backdrop = backdrop;
	
	local header = CreateFrame("Frame", nil, backdrop);
	header:Height(22);
	header:Point("TOPLEFT", Recount_MainWindow, 0, -7);
	header:Point("TOPRIGHT", Recount_MainWindow);
	header:SetTemplate("Default", true);
	
	Recount.SetupBarOriginal = Recount.SetupBar;
	
	function Recount:UpdateBarTextures()
		for _, row in pairs(Recount.MainWindow.Rows) do
			row.StatusBar:SetStatusBarTexture(E.media.glossTex);
			
			row.LeftText:FontTemplate();
			row.RightText:FontTemplate();
		end
	end
	
	function Recount:SetupBar(bar)
		self:SetupBarOriginal(bar);
		
		bar.StatusBar:SetStatusBarTexture(E.media.glossTex);
		E:RegisterStatusBar(bar.StatusBar);
		
		bar.LeftText:FontTemplate();
		bar.RightText:FontTemplate();
	end
	
	Recount:UpdateBarTextures();
	
	for i = 1, Recount_MainWindow:GetNumRegions() do
		local region = select(i, Recount_MainWindow:GetRegions());
		if(region:GetObjectType() == "FontString") then
			region:FontTemplate();
			region:SetTextColor(unpack(E.media.rgbvaluecolor));
		end
	end
	
	S:HandleScrollBar(Recount_MainWindow_ScrollBarScrollBar);
	
	Recount_MainWindow.DragBottomLeft:SetNormalTexture(nil);
	Recount_MainWindow.DragBottomRight:SetNormalTexture(nil);
	
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
end

addon:RegisterSkin("Recount", addon.Recount);