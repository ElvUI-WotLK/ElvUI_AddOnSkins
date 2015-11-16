local E, L, V, P, G, _ = unpack(ElvUI);
local addon = E:GetModule("AddOnSkins");

local format, gsub, pairs, ipairs, select, tinsert, tonumber = string.format, gsub, pairs, ipairs, select, tinsert, tonumber;

local lower = string.lower;

addon.ChatFrameHider = CreateFrame("Frame");
addon.ChatFrameHider:Hide();

function addon:GetChatWindowInfo()
	local ChatTabInfo = { ["NONE"] = "NONE" };
	for i = 1, NUM_CHAT_WINDOWS do
		ChatTabInfo["ChatFrame"..i] = _G["ChatFrame"..i.."Tab"]:GetText();
	end
	return ChatTabInfo;
end

function addon:ToggleChatFrame(hide)
	if(self:CheckOption("HideChatFrame") == "NONE") then return; end
	if(hide) then
		_G[self:CheckOption("HideChatFrame")].OriginalParent = _G[self:CheckOption("HideChatFrame")]:GetParent();
		_G[self:CheckOption("HideChatFrame")]:SetParent(self.ChatFrameHider);
		
		_G[self:CheckOption("HideChatFrame").."Tab"].OriginalParent = _G[self:CheckOption("HideChatFrame").."Tab"]:GetParent();
		_G[self:CheckOption("HideChatFrame").."Tab"]:SetParent(self.ChatFrameHider);
	else
		if _G[self:CheckOption("HideChatFrame")].OriginalParent then
			_G[self:CheckOption("HideChatFrame")]:SetParent(_G[self:CheckOption("HideChatFrame")].OriginalParent);
			_G[self:CheckOption("HideChatFrame").."Tab"]:SetParent(_G[self:CheckOption("HideChatFrame").."Tab"].OriginalParent);
		end
	end
end

function addon:Embed_Show()
	EmbedSystem_MainWindow:Show();
	if(E.db.addOnSkins.embed.single) then
		if(_G[EmbedSystem_MainWindow.FrameName]) then
			_G[EmbedSystem_MainWindow.FrameName]:Show();
		end
	end
	if(E.db.addOnSkins.embed.dual) then
		EmbedSystem_LeftWindow:Show();
		EmbedSystem_RightWindow:Show();
		
		if(_G[EmbedSystem_LeftWindow.FrameName]) then
			_G[EmbedSystem_LeftWindow.FrameName]:Show();
		end
		if(_G[EmbedSystem_RightWindow.FrameName]) then
			_G[EmbedSystem_RightWindow.FrameName]:Show();
		end
	end
	-- addon:ToggleChatFrame(true);
end

function addon:Embed_Hide()
	EmbedSystem_MainWindow:Hide();
	if(E.db.addOnSkins.embed.single) then
		if(_G[EmbedSystem_MainWindow.FrameName]) then
			_G[EmbedSystem_MainWindow.FrameName]:Hide();
		end
	end
	if(E.db.addOnSkins.embed.dual) then
		EmbedSystem_LeftWindow:Hide();
		EmbedSystem_RightWindow:Hide();
		
		if(_G[EmbedSystem_LeftWindow.FrameName]) then
			_G[EmbedSystem_LeftWindow.FrameName]:Hide()
		end
		if(_G[EmbedSystem_RightWindow.FrameName]) then
			_G[EmbedSystem_RightWindow.FrameName]:Hide();
		end
	end
	-- addon:ToggleChatFrame(false);
end

function addon:CheckEmbed(addOn)
	local main, left, right, embed = lower(E.db.addOnSkins.embed.main), lower(E.db.addOnSkins.embed.left), lower(E.db.addOnSkins.embed.right), lower(addOn);
	if(self:CheckAddOn(addOn) and ((E.db.addOnSkins.embed.single and strmatch(main, embed)) or E.db.addOnSkins.embed.dual and (strmatch(left, embed) or strmatch(right, embed)))) then
		return true;
	else
		return false;
	end
end

function addon:Embed_Check(message)
	if not (E.db.addOnSkins.embed.single or E.db.addOnSkins.embed.dual) then return; end
	if(not self.EmbedSystemCreated) then
		self:EmbedInit();
		message = true;
	end
	self:Embed_Toggle(message);
	self:EmbedSystem_WindowResize();
	if self:CheckEmbed("Omen") then self:Embed_Omen(); end
	if self:CheckEmbed("Skada") then self:Embed_Skada(); end
	if self:CheckEmbed("Recount") then self:Embed_Recount(); end
end

function addon:Embed_Toggle(message)
	EmbedSystem_MainWindow.FrameName = nil;
	EmbedSystem_LeftWindow.FrameName = nil;
	EmbedSystem_RightWindow.FrameName = nil;
	
	if(E.db.addOnSkins.embed.single) then
		local main = lower(E.db.addOnSkins.embed.main);
		if(main ~= "details" and main ~= "skada" and main ~= "omen" and main ~= "recount" and main ~= "tinydps" and main ~= "aldamagemeter") then
			EmbedSystem_MainWindow.FrameName = E.db.addOnSkins.embed.main;
		end
	end
	
	if(E.db.addOnSkins.embed.dual) then
		local left, right = lower(E.db.addOnSkins.embed.left), lower(E.db.addOnSkins.embed.right)
		if(left ~= "details" and left ~= "skada" and left ~= "omen" and left ~= "recount" and left ~= "tinydps" and left ~= "aldamagemeter") then
			EmbedSystem_LeftWindow.FrameName = E.db.addOnSkins.embed.left;
		end
		
		if(right ~= "details" and right ~= "skada" and right ~= "omen" and right ~= "recount" and right ~= "tinydps" and right ~= "aldamagemeter") then
			EmbedSystem_RightWindow.FrameName = E.db.addOnSkins.embed.right;
		end
	end
	
	if(EmbedSystem_MainWindow.FrameName ~= nil) then
		local frame = _G[EmbedSystem_MainWindow.FrameName];
		if(frame and frame:IsObjectType("Frame") and not frame:IsProtected()) then
			frame:ClearAllPoints();
			frame:SetParent(EmbedSystem_MainWindow);
			frame:SetInside(EmbedSystem_MainWindow, 0, 0);
		end
	end
	
	if(EmbedSystem_LeftWindow.FrameName ~= nil) then
		local frame = _G[EmbedSystem_LeftWindow.FrameName];
		if(frame and frame:IsObjectType("Frame") and not frame:IsProtected()) then
			Frame:ClearAllPoints();
			Frame:SetParent(EmbedSystem_LeftWindow);
			Frame:SetInside(EmbedSystem_LeftWindow, 0, 0);
		end
	end
	
	if(EmbedSystem_RightWindow.FrameName ~= nil) then
		local frame = _G[EmbedSystem_RightWindow.FrameName];
		if(frame and frame:IsObjectType("Frame") and not frame:IsProtected()) then
			frame:ClearAllPoints();
			frame:SetParent(EmbedSystem_RightWindow);
			frame:SetInside(EmbedSystem_RightWindow, 0, 0);
		end
	end
	
	if(message) then
		local message = format("Main: %s", E.db.addOnSkins.embed.main);
		if(E.db.addOnSkins.embed.dual) then
			message = format("Left: %s | Right: %s", E.db.addOnSkins.embed.left, E.db.addOnSkins.embed.right);
		end
		E:Print(format("Embed System: - %s", message));
	end
end

function addon:EmbedInit()
	if(E.db.addOnSkins.embed.single or E.db.addOnSkins.embed.dual) then
		if(not self.EmbedSystemCreated) then
			EmbedSystem_MainWindow = CreateFrame("Frame", "EmbedSystem_MainWindow", UIParent);
			EmbedSystem_LeftWindow = CreateFrame("Frame", "EmbedSystem_LeftWindow", EmbedSystem_MainWindow);
			EmbedSystem_RightWindow = CreateFrame("Frame", "EmbedSystem_RightWindow", EmbedSystem_MainWindow);
			
			self.EmbedSystemCreated = true;
			
			self:EmbedSystemHooks();
			self:EmbedSystem_WindowResize();
			
			hooksecurefunc(E:GetModule('Chat'), 'PositionChat', function(self, override)
				if(override) then
					addon:Embed_Check();
				end
			end);
			hooksecurefunc(E:GetModule('Layout'), 'ToggleChatPanels', function() addon:Embed_Check(); end);
			
			self:Embed_Check(true);
			
			EmbedSystem_MainWindow:HookScript("OnShow", self.Embed_Show);
			EmbedSystem_MainWindow:HookScript("OnHide", self.Embed_Hide);
			-- EmbedSystem_MainWindow:SetTemplate();
		end
	end
end

function addon:EmbedSystemHooks()
	if(addon:CheckAddOn("Recount")) then
		function addon:Embed_Recount()
			local parent = EmbedSystem_MainWindow;
			if(E.db.addOnSkins.embed.dual) then
				parent = E.db.addOnSkins.embed.right == "Recount" and EmbedSystem_RightWindow or EmbedSystem_LeftWindow;
			end
			parent.FrameName = "Recount_MainWindow";
			
			Recount_MainWindow:SetParent(parent);
			Recount_MainWindow:ClearAllPoints();
			Recount_MainWindow:SetPoint("TOPLEFT", parent, "TOPLEFT", 0, 7);
			Recount_MainWindow:SetPoint("BOTTOMRIGHT", parent, "BOTTOMRIGHT", 0, 0);
			
			if(addon:CheckOption("Recount")) then
				if(Recount_MainWindow.backdrop) then
					Recount_MainWindow.backdrop:SetTemplate(addon:CheckOption("TransparentEmbed") and "Transparent" or "Default");
					if addon:CheckOption("RecountBackdrop") then
						Recount_MainWindow.backdrop:Show();
					else
						Recount_MainWindow.backdrop:Hide();
					end
				end
			end
			
			Recount.db.profile.Locked = true;
			Recount.db.profile.Scaling = 1;
			Recount.db.profile.ClampToScreen = true;
			Recount.db.profile.FrameStrata = "2-LOW";
			Recount:SetStrataAndClamp();
			Recount:LockWindows(true);
			Recount:ResizeMainWindow();
			Recount:FullRefreshMainWindow();
		end
	end

	if(addon:CheckAddOn("Omen")) then
		function addon:Embed_Omen()
			local parent = EmbedSystem_MainWindow;
			if(E.db.addOnSkins.embed.dual) then
				parent = E.db.addOnSkins.embed.right == "Omen" and EmbedSystem_RightWindow or EmbedSystem_LeftWindow;
			end
			parent.FrameName = "OmenAnchor";
			
			local db = Omen.db;
			db.profile.Scale = 1;
			db.profile.Bar.Spacing = 1;
			db.profile.Background.EdgeSize = 1;
			db.profile.Background.BarInset = 2;
			db.profile.TitleBar.UseSameBG = true;
			db.profile.ShowWith.UseShowWith = false;
			db.profile.Locked = true;
			db.profile.TitleBar.ShowTitleBar = true;
			db.profile.FrameStrata = "2-LOW";
			
			hooksecurefunc(Omen, "SetAnchors", function(self, useDB)
				if(useDB) then
					self.Anchor:SetParent(parent);
					self.Anchor:SetInside(parent, 0, 0);
				end
			end);
		end
	end
	
	if(addon:CheckAddOn("Skada")) then
		local SkadaDisplayBar = Skada.displays["bar"];
		addon["SkadaWindows"] = {};
		function addon:Embed_Skada()
			wipe(addon["SkadaWindows"]);
			for k, window in pairs(Skada:GetWindows()) do
				tinsert(addon.SkadaWindows, window);
			end
			
			local numberToEmbed = 0;
			if(E.db.addOnSkins.embed.single) then
				numberToEmbed = 1;
			end
			if(E.db.addOnSkins.embed.dual) then
				if(E.db.addOnSkins.embed.right == "Skada") then numberToEmbed = numberToEmbed + 1; end
				if(E.db.addOnSkins.embed.left == "Skada") then numberToEmbed = numberToEmbed + 1; end
			end
			
			local function EmbedWindow(window, width, height, point, relativeFrame, relativePoint, ofsx, ofsy)
				if(not window) then return; end
				local barmod = Skada.displays["bar"];
				
				window.db.barwidth = width;
				window.db.background.height = height - (window.db.enabletitle and window.db.barheight or -(E.PixelMode and 1 or 3)) - (E.PixelMode and 1 or 3);
				
				window.db.spark = false;
				window.db.barslocked = true;
				window.db.enablebackground = true;
				
				window.bargroup:SetParent(relativeFrame);
				window.bargroup:ClearAllPoints();
				window.bargroup:SetPoint(point, relativeFrame, relativePoint, ofsx, ofsy);
				
				window.bargroup:SetFrameStrata("LOW");
				window.bargroup.bgframe:SetFrameStrata("LOW");
				window.bargroup.bgframe:SetFrameLevel(window.bargroup:GetFrameLevel() - 1);
				
				barmod.ApplySettings(barmod, window);
			end
			
			if(numberToEmbed == 1) then
				local parent = EmbedSystem_MainWindow;
				if(E.db.addOnSkins.embed.dual) then
					parent = E.db.addOnSkins.embed.right == "Skada" and EmbedSystem_RightWindow or EmbedSystem_LeftWindow;
				end
				EmbedWindow(addon.SkadaWindows[1], parent:GetWidth(), parent:GetHeight(), "TOPLEFT", parent, "TOPLEFT", 0, 0);
			elseif(numberToEmbed == 2) then
				EmbedWindow(addon.SkadaWindows[1], EmbedSystem_LeftWindow:GetWidth(), EmbedSystem_LeftWindow:GetHeight(), "TOPLEFT", EmbedSystem_LeftWindow, "TOPLEFT", 0, 0);
				EmbedWindow(addon.SkadaWindows[2], EmbedSystem_RightWindow:GetWidth(), EmbedSystem_RightWindow:GetHeight(), "TOPRIGHT", EmbedSystem_RightWindow, "TOPRIGHT", 0, 0);
			end
		end
	end

	RightChatToggleButton:RegisterForClicks('AnyDown')
	RightChatToggleButton:SetScript('OnClick', function(self, btn)
		if btn == 'RightButton' then
			if E.db.addOnSkins.embed.rightChat then
				if EmbedSystem_MainWindow:IsShown() then
					addon:SetOption('EmbedIsHidden', true)
					EmbedSystem_MainWindow:Hide()
				else
					addon:SetOption('EmbedIsHidden', false)
					EmbedSystem_MainWindow:Show()
				end
			end
		else
			if E.db[self.parent:GetName()..'Faded'] then
				E.db[self.parent:GetName()..'Faded'] = nil
				UIFrameFadeIn(self.parent, 0.2, self.parent:GetAlpha(), 1)
				UIFrameFadeIn(self, 0.2, self:GetAlpha(), 1)
				if E.db.addOnSkins.embed.rightChat and not addon:CheckOption('EmbedIsHidden') then
					EmbedSystem_MainWindow:Show()
				end
			else
				E.db[self.parent:GetName()..'Faded'] = true
				UIFrameFadeOut(self.parent, 0.2, self.parent:GetAlpha(), 0)
				UIFrameFadeOut(self, 0.2, self:GetAlpha(), 0)
				self.parent.fadeInfo.finishedFunc = self.parent.fadeFunc
			end
		end
	end)

	RightChatToggleButton:HookScript('OnEnter', function(self, ...)
		if E.db.addOnSkins.embed.rightChat then
			GameTooltip:AddDoubleLine(L['Right Click:'], L['Toggle Embedded Addon'], 1, 1, 1)
			GameTooltip:Show()
		end
	end)

	LeftChatToggleButton:RegisterForClicks('AnyDown')
	LeftChatToggleButton:SetScript('OnClick', function(self, btn)
		if btn == 'RightButton' then
			if not E.db.addOnSkins.embed.rightChat then
				if EmbedSystem_MainWindow:IsShown() then
					addon:SetOption('EmbedIsHidden', true)
					EmbedSystem_MainWindow:Hide()
				else
					addon:SetOption('EmbedIsHidden', false)
					EmbedSystem_MainWindow:Show()
				end
			end
		else
			if E.db[self.parent:GetName()..'Faded'] then
				E.db[self.parent:GetName()..'Faded'] = nil
				UIFrameFadeIn(self.parent, 0.2, self.parent:GetAlpha(), 1)
				UIFrameFadeIn(self, 0.2, self:GetAlpha(), 1)
				if not E.db.addOnSkins.embed.rightChat and not addon:CheckOption('EmbedIsHidden') then
					EmbedSystem_MainWindow:Show()
				end
			else
				E.db[self.parent:GetName()..'Faded'] = true
				UIFrameFadeOut(self.parent, 0.2, self.parent:GetAlpha(), 0)
				UIFrameFadeOut(self, 0.2, self:GetAlpha(), 0)
				self.parent.fadeInfo.finishedFunc = self.parent.fadeFunc
			end
		end
	end)

	LeftChatToggleButton:HookScript('OnEnter', function(self, ...)
		if not E.db.addOnSkins.embed.rightChat then
			GameTooltip:AddDoubleLine(L['Right Click:'], L['Toggle Embedded Addon'], 1, 1, 1)
			GameTooltip:Show()
		end
	end)

	function HideLeftChat()
		LeftChatToggleButton:Click()
	end

	function HideRightChat()
		RightChatToggleButton:Click()
	end

	function HideBothChat()
		LeftChatToggleButton:Click()
		RightChatToggleButton:Click()
	end
end

function addon:EmbedSystem_WindowResize()
	if(UnitAffectingCombat("player") or not addon.EmbedSystemCreated) then return; end
	
	local chatPanel = E.db.addOnSkins.embed.rightChat and RightChatPanel or LeftChatPanel;
	local chatTab = E.db.addOnSkins.embed.rightChat and RightChatTab or LeftChatTab;
	local chatData = E.db.addOnSkins.embed.rightChat and RightChatDataPanel or LeftChatToggleButton;
	local topRight = chatData == RightChatDataPanel and (E.db.datatexts.rightChatPanel and "TOPLEFT" or "BOTTOMLEFT") or chatData == LeftChatToggleButton and (E.db.datatexts.leftChatPanel and "TOPLEFT" or "BOTTOMLEFT");
	local yOffset = (chatData == RightChatDataPanel and E.db.datatexts.rightChatPanel and (E.PixelMode and 1 or 3)) or (chatData == LeftChatToggleButton and E.db.datatexts.leftChatPanel and (E.PixelMode and 1 or 3)) or 0;
	local xOffset = E.db.chat.panelBackdrop == "RIGHT" or E.db.chat.panelBackdrop == "LEFT" or E.db.chat.panelBackdrop == "SHOWBOTH" and 0 or (E.PixelMode and 3 or 5);
	
	_G["EmbedSystem_MainWindow"]:SetParent(chatPanel);
	_G["EmbedSystem_MainWindow"]:ClearAllPoints();
	_G["EmbedSystem_MainWindow"]:SetPoint("BOTTOMLEFT", chatData, topRight, 0, yOffset);
	_G["EmbedSystem_MainWindow"]:SetPoint("TOPRIGHT", chatTab, E.db.addOnSkins.embed.belowTop and "BOTTOMRIGHT" or "TOPRIGHT", xOffset, E.db.addOnSkins.embed.belowTop and -(E.PixelMode and 1 or 3) or 0);
	
	_G["EmbedSystem_LeftWindow"]:SetSize(E.db.addOnSkins.embed.leftWidth, _G["EmbedSystem_MainWindow"]:GetHeight());
	_G["EmbedSystem_RightWindow"]:SetSize((_G["EmbedSystem_MainWindow"]:GetWidth() - E.db.addOnSkins.embed.leftWidth) - (E.PixelMode and 1 or 3), _G["EmbedSystem_MainWindow"]:GetHeight());
	
	_G["EmbedSystem_LeftWindow"]:SetPoint('LEFT', _G["EmbedSystem_MainWindow"], 'LEFT', 0, 0);
	_G["EmbedSystem_RightWindow"]:SetPoint('RIGHT', _G["EmbedSystem_MainWindow"], 'RIGHT', 0, 0);
	
	if(IsAddOnLoaded("ElvUI_Config")) then
		E.Options.args.addOnSkins.args.embed.args.leftWidth.min = floor(_G["EmbedSystem_MainWindow"]:GetWidth() * .25);
		E.Options.args.addOnSkins.args.embed.args.leftWidth.max = floor(_G["EmbedSystem_MainWindow"]:GetWidth() * .75);
	end
end