local addonName = ...;
local E, L, V, P, G, _ = unpack(ElvUI);
local addon = E:GetModule("AddOnSkins");
local module = E:NewModule("EmbedSystem");

local _G = _G;
local pairs, tonumber = pairs, tonumber;
local format, lower, floor = string.format, string.lower, math.floor;
local tinsert = table.insert;

local hooksecurefunc = hooksecurefunc;
local NUM_CHAT_WINDOWS = NUM_CHAT_WINDOWS;

function module:GetChatWindowInfo()
	local chatTabInfo = { ["NONE"] = NONE };
	for i = 1, NUM_CHAT_WINDOWS do
		chatTabInfo["ChatFrame"..i] = _G["ChatFrame"..i.."Tab"]:GetText();
	end
	return chatTabInfo;
end

function module:ToggleChatFrame(hide)
	local chatFrame = self.db.hideChat;
	if(chatFrame == "NONE") then return; end
	if(hide) then
		_G[chatFrame].originalParent = _G[chatFrame]:GetParent();
		_G[chatFrame]:SetParent(E.HiddenFrame);
		
		_G[chatFrame.."Tab"].originalParent = _G[chatFrame.."Tab"]:GetParent();
		_G[chatFrame.."Tab"]:SetParent(E.HiddenFrame);
	else
		if(_G[chatFrame].originalParent) then
			_G[chatFrame]:SetParent(_G[chatFrame].originalParent);
			_G[chatFrame.."Tab"]:SetParent(_G[chatFrame.."Tab"].originalParent);
		end
	end
end

function module:Show()
	if(E.db.addOnSkins.embed.embedType == "SINGLE") then
		module.left:Show();
		if(_G[module.left.frameName]) then
			_G[module.left.frameName]:Show();
		end
	end
	
	if(E.db.addOnSkins.embed.embedType == "SINGLE") then
		module.left:Show();
		module.right:Show();
		if(_G[module.left.frameName]) then
			_G[module.left.frameName]:Show();
		end
		if(_G[module.right.frameName]) then
			_G[module.right.frameName]:Show();
		end
	end
	module:ToggleChatFrame(true);
end

function module:Hide()
	if(E.db.addOnSkins.embed.embedType == "SINGLE") then
		module.left:Hide();
		if(_G[module.left.frameName]) then
			_G[module.left.frameName]:Hide();
		end
	end
	
	if(E.db.addOnSkins.embed.embedType == "SINGLE") then
		module.left:Hide();
		module.right:Hide();
		if(_G[module.left.frameName]) then
			_G[module.left.frameName]:Hide()
		end
		if(_G[module.right.frameName]) then
			_G[module.right.frameName]:Hide();
		end
	end
	module:ToggleChatFrame(false);
end

function module:CheckAddOn(addOn)
	local left, right, embed = lower(self.db.left), lower(self.db.right), lower(addOn);
	if(addon:CheckAddOn(addOn) and ((self.db.embedType == "SINGLE" and strmatch(left, embed)) or self.db.embedType == "DOUBLE" and (strmatch(left, embed) or strmatch(right, embed)))) then
		return true;
	else
		return false;
	end
end

function module:Check()
	if(self.db.embedType == "DISABLE") then return; end
	if(not self.embedCreated) then
		self:Init();
	end
	self:Toggle();
	self:WindowResize();
	
	if(self:CheckAddOn("Omen")) then self:Omen(); end
	if(self:CheckAddOn("Skada")) then self:Skada(); end
	if(self:CheckAddOn("Recount")) then self:Recount(); end
end

function module:Toggle()
	self.left.frameName = nil;
	self.right.frameName = nil;
	
	if(self.db.embedType == "SINGLE") then
		local left = lower(self.db.left);
		if(left ~= "skada" and left ~= "omen" and left ~= "recount") then
			self.left.frameName = self.db.left;
		end
	end
	
	if(self.db.embedType == "DOUBLE") then
		local right = lower(self.db.right);
		if(right ~= "skada" and right ~= "omen" and right ~= "recount") then
			self.right.frameName = self.db.right;
		end
	end
	
	if(self.left.frameName ~= nil) then
		local frame = _G[self.left.frameName];
		if(frame and frame:IsObjectType("Frame") and not frame:IsProtected()) then
			frame:ClearAllPoints();
			frame:SetParent(self.left);
			frame:SetInside(self.left, 0, 0);
		end
	end
	
	if(self.right.frameName ~= nil) then
		local frame = _G[self.right.frameName];
		if(frame and frame:IsObjectType("Frame") and not frame:IsProtected()) then
			frame:ClearAllPoints();
			frame:SetParent(self.right);
			frame:SetInside(self.right, 0, 0);
		end
	end
end

function module:Hooks()
	if(addon:CheckAddOn("Recount")) then
		function self:Recount()
			local parent = self.left;
			if(self.db.embedType == "DOUBLE") then
				parent = self.db.right == "Recount" and self.right or self.left;
			end
			parent.frameName = "Recount_MainWindow";
			
			Recount_MainWindow:SetParent(parent);
			Recount_MainWindow:ClearAllPoints();
			Recount_MainWindow:SetPoint("TOPLEFT", parent, "TOPLEFT", 0, 7);
			Recount_MainWindow:SetPoint("BOTTOMRIGHT", parent, "BOTTOMRIGHT", 0, 0);
			
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
		function self:Omen()
			local parent = self.left;
			if(self.db.embedType == "DOUBLE") then
				parent = self.db.right == "Omen" and self.right or self.left;
			end
			parent.frameName = "OmenAnchor";
			
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
			
			OmenAnchor:SetParent(parent);
			OmenAnchor:ClearAllPoints();
			OmenAnchor:SetAllPoints();
			
			hooksecurefunc(Omen, "SetAnchors", function(self, useDB)
				if(useDB) then
					self.Anchor:SetParent(parent);
					self.Anchor:SetInside(parent, 0, 0);
				end
			end);
		end
	end
	
	if(addon:CheckAddOn("Skada")) then
		self["skadaWindows"] = {};
		function module:Skada()
			wipe(self["skadaWindows"]);
			for k, window in pairs(Skada:GetWindows()) do
				tinsert(self.skadaWindows, window);
			end
			
			local numberToEmbed = 0;
			if(self.db.embedType == "SINGLE") then
				numberToEmbed = 1;
			end
			if(self.db.embedType == "DOUBLE") then
				if(self.db.right == "Skada") then numberToEmbed = numberToEmbed + 1; end
				if(self.db.left == "Skada") then numberToEmbed = numberToEmbed + 1; end
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
				
				barmod.ApplySettings(barmod, window);
				
				window.bargroup.bgframe:SetFrameStrata("LOW");
				window.bargroup.bgframe:SetFrameLevel(window.bargroup:GetFrameLevel() - 1);
			end
			
			if(numberToEmbed == 1) then
				local parent = self.left;
				if(self.db.embedType == "DOUBLE") then
					parent = self.db.right == "Skada" and self.right or self.left;
				end
				EmbedWindow(self.skadaWindows[1], parent:GetWidth(), parent:GetHeight(), "TOPLEFT", parent, "TOPLEFT", 0, 0);
			elseif(numberToEmbed == 2) then
				EmbedWindow(self.skadaWindows[1], self.left:GetWidth(), self.left:GetHeight(), "TOPLEFT", self.left, "TOPLEFT", 0, 0);
				EmbedWindow(self.skadaWindows[2], self.right:GetWidth(), self.right:GetHeight(), "TOPRIGHT", self.right, "TOPRIGHT", 0, 0);
			end
		end
		
		hooksecurefunc(Skada, "CreateWindow", function()
		if(self:CheckAddOn("Skada")) then
				self:Skada();
			end
		end);
		
		hooksecurefunc(Skada, "DeleteWindow", function()
			if(self:CheckAddOn("Skada")) then
				self:Skada();
			end
		end);
		
		hooksecurefunc(Skada, "UpdateDisplay", function()
			if(self:CheckAddOn("Skada") and not InCombatLockdown()) then
				self:Skada();
			end
		end);
	end
	
	RightChatToggleButton:RegisterForClicks("AnyDown");
	RightChatToggleButton:SetScript("OnClick", function(self, btn)
		if(btn == "RightButton") then
			if(E.db.addOnSkins.embed.rightChat) then
				if(module.left:IsShown()) then
					module.left:Hide();
				else
					module.left:Show();
				end
			end
		else
			if(E.db[self.parent:GetName().."Faded"]) then
				E.db[self.parent:GetName().."Faded"] = nil;
				UIFrameFadeIn(self.parent, 0.2, self.parent:GetAlpha(), 1);
				UIFrameFadeIn(self, 0.2, self:GetAlpha(), 1);
				if(E.db.addOnSkins.embed.rightChat) then
					module.left:Show();
				end
			else
				E.db[self.parent:GetName().."Faded"] = true;
				UIFrameFadeOut(self.parent, 0.2, self.parent:GetAlpha(), 0);
				UIFrameFadeOut(self, 0.2, self:GetAlpha(), 0);
				self.parent.fadeInfo.finishedFunc = self.parent.fadeFunc;
			end
		end
	end);
	
	RightChatToggleButton:HookScript("OnEnter", function(self, ...)
		if(E.db.addOnSkins.embed.rightChat) then
			GameTooltip:AddDoubleLine(L["Right Click:"], L["Toggle Embedded Addon"], 1, 1, 1);
			GameTooltip:Show();
		end
	end);
	
	LeftChatToggleButton:RegisterForClicks("AnyDown");
	LeftChatToggleButton:SetScript("OnClick", function(self, btn)
		if(btn == "RightButton") then
			if(not E.db.addOnSkins.embed.rightChat) then
				if(module.left:IsShown()) then
					module.left:Hide();
				else
					module.left:Show();
				end
			end
		else
			if(E.db[self.parent:GetName().."Faded"]) then
				E.db[self.parent:GetName().."Faded"] = nil;
				UIFrameFadeIn(self.parent, 0.2, self.parent:GetAlpha(), 1);
				UIFrameFadeIn(self, 0.2, self:GetAlpha(), 1);
				if(not E.db.addOnSkins.embed.rightChat) then
					module.left:Show();
				end
			else
				E.db[self.parent:GetName().."Faded"] = true;
				UIFrameFadeOut(self.parent, 0.2, self.parent:GetAlpha(), 0);
				UIFrameFadeOut(self, 0.2, self:GetAlpha(), 0);
				self.parent.fadeInfo.finishedFunc = self.parent.fadeFunc;
			end
		end
	end);
	
	LeftChatToggleButton:HookScript("OnEnter", function(self, ...)
		if(not E.db.addOnSkins.embed.rightChat) then
			GameTooltip:AddDoubleLine(L["Right Click:"], L["Toggle Embedded Addon"], 1, 1, 1);
			GameTooltip:Show();
		end
	end);
	
	function HideLeftChat()
		LeftChatToggleButton:Click();
	end
	
	function HideRightChat()
		RightChatToggleButton:Click();
	end
	
	function HideBothChat()
		LeftChatToggleButton:Click();
		RightChatToggleButton:Click();
	end
end

function module:WindowResize()
	if(not self.embedCreated) then return; end
	
	local chatPanel = self.db.rightChat and RightChatPanel or LeftChatPanel;
	local chatTab = self.db.rightChat and RightChatTab or LeftChatTab;
	local chatData = self.db.rightChat and RightChatDataPanel or LeftChatToggleButton;
	local topRight = chatData == RightChatDataPanel and (E.db.datatexts.rightChatPanel and "TOPLEFT" or "BOTTOMLEFT") or chatData == LeftChatToggleButton and (E.db.datatexts.leftChatPanel and "TOPLEFT" or "BOTTOMLEFT");
	local yOffset = (chatData == RightChatDataPanel and E.db.datatexts.rightChatPanel and (E.PixelMode and 1 or 3)) or (chatData == LeftChatToggleButton and E.db.datatexts.leftChatPanel and (E.PixelMode and 1 or 3)) or 0;
	local xOffset = E.db.chat.panelBackdrop == "RIGHT" or E.db.chat.panelBackdrop == "LEFT" or E.db.chat.panelBackdrop == "SHOWBOTH" and 0 or (E.PixelMode and 3 or 5);
	local isDouble = self.db.embedType == "DOUBLE";
	
	self.left:SetParent(chatPanel);
	self.left:ClearAllPoints();
	self.left:SetPoint(isDouble and "BOTTOMRIGHT" or "BOTTOMLEFT", chatData, topRight, isDouble and self.db.leftWidth -(E.PixelMode and 1 or 3) or 0, yOffset);
	self.left:SetPoint(isDouble and "TOPLEFT" or "TOPRIGHT", chatTab, isDouble and (self.db.belowTop and "BOTTOMLEFT" or "TOPLEFT") or (self.db.belowTop and "BOTTOMRIGHT" or "TOPRIGHT"), xOffset, self.db.belowTop and -(E.PixelMode and 1 or 3) or 0);
	
	if(isDouble) then
		self.right:ClearAllPoints();
		self.right:SetPoint("BOTTOMLEFT", chatData, topRight, self.db.leftWidth, yOffset);
		self.right:SetPoint("TOPRIGHT", chatTab, self.db.belowTop and "BOTTOMRIGHT" or "TOPRIGHT", xOffset, self.db.belowTop and -(E.PixelMode and 1 or 3) or 0);
	end
	
	if(IsAddOnLoaded("ElvUI_Config")) then
	--	E.Options.args.addOnSkins.args.embed.args.dualGroup.args.leftWidth.min = floor(self.main:GetWidth() * .25);
	--	E.Options.args.addOnSkins.args.embed.args.dualGroup.args.leftWidth.max = floor(self.main:GetWidth() * .75);
	end
end

function module:Init()
	if(not self.embedCreated) then
		self.left = CreateFrame("Frame", addonName.."_Embed_LeftWindow", UIParent);
		self.right = CreateFrame("Frame", addonName.."_Embed_RightWindow", self.left);
		
		self.embedCreated = true;
		
		self:Hooks();
		self:WindowResize();
		
		hooksecurefunc(E:GetModule("Chat"), "PositionChat", function(self, override)
			if(override) then
				module:Check();
			end
		end);
		hooksecurefunc(E:GetModule("Layout"), "ToggleChatPanels", function() module:Check(); end);
		
		self:Check(true);
		
		self.left:HookScript("OnShow", self.Show);
		self.left:HookScript("OnHide", self.Hide);
	end
end

function module:Initialize()
	self.db = E.db.addOnSkins.embed;
	
	--if(not self.db.embedType == "DISABLE") then
		self:Init();
	--end
end

E:RegisterModule(module:GetName());