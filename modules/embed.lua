local addonName = ...;
local E, L, V, P, G = unpack(ElvUI);
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
	local chatFrame = E.db.addOnSkins.embed.hideChat;
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
		if(_G[module.left.frameName]) then
			_G[module.left.frameName]:Show();
		end
	end

	if(E.db.addOnSkins.embed.embedType == "DOUBLE") then
		if(_G[module.left.frameName]) then
			_G[module.left.frameName]:Show();
		end
		if(_G[module.right.frameName]) then
			_G[module.right.frameName]:Show();
		end
	end
	module:ToggleChatFrame(true);
	module.switchButton:SetAlpha(1);
	E.db.addOnSkins.embed.isShow = true;
end

function module:Hide()
	if(E.db.addOnSkins.embed.embedType == "SINGLE") then
		if(_G[module.left.frameName]) then
			_G[module.left.frameName]:Hide();
		end
	end

	if(E.db.addOnSkins.embed.embedType == "DOUBLE") then
		if(_G[module.left.frameName]) then
			_G[module.left.frameName]:Hide()
		end
		if(_G[module.right.frameName]) then
			_G[module.right.frameName]:Hide();
		end
	end
	module:ToggleChatFrame(false);
	module.switchButton:SetAlpha(0.6);
	E.db.addOnSkins.embed.isShow = false;
end

function module:CheckAddOn(addOn)
	local left, right, embed = lower(E.db.addOnSkins.embed.left), lower(E.db.addOnSkins.embed.right), lower(addOn);
	if(addon:CheckAddOn(addOn) and ((E.db.addOnSkins.embed.embedType == "SINGLE" and strmatch(left, embed)) or E.db.addOnSkins.embed.embedType == "DOUBLE" and (strmatch(left, embed) or strmatch(right, embed)))) then
		return true;
	else
		return false;
	end
end

function module:Check()
	if(E.db.addOnSkins.embed.embedType == "DISABLE") then return; end
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

	if(E.db.addOnSkins.embed.embedType == "SINGLE") then
		local left = lower(E.db.addOnSkins.embed.left);
		if(left ~= "skada" and left ~= "omen" and left ~= "recount") then
			self.left.frameName = self.db.left;
		end
	end

	if(E.db.addOnSkins.embed.embedType == "DOUBLE") then
		local right = lower(E.db.addOnSkins.embed.right);
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

	if(E.db.addOnSkins.embed.isShow) then
		self.left:Show();
		self:Show();
	else
		self.left:Hide();
		self:Hide();
	end
end

if(addon:CheckAddOn("Recount")) then
	function module:Recount()
		local parent = self.left;
		if(E.db.addOnSkins.embed.embedType == "DOUBLE") then
			parent = self.db.right == "Recount" and self.right or self.left;
		end
		parent.frameName = "Recount_MainWindow";

		Recount_MainWindow:SetParent(parent);
		Recount_MainWindow:ClearAllPoints();
		Recount_MainWindow:SetPoint("TOPLEFT", parent, "TOPLEFT", E.PixelMode and -1 or 0, E.PixelMode and 8 or 7);
		Recount_MainWindow:SetPoint("BOTTOMRIGHT", parent, "BOTTOMRIGHT", E.PixelMode and 1 or 0, E.PixelMode and -1 or 0);

		Recount.db.profile.Locked = true;
		Recount.db.profile.Scaling = 1;
		Recount.db.profile.ClampToScreen = true;
		Recount.db.profile.FrameStrata = "2-LOW";
		Recount:SetStrataAndClamp();
		Recount:LockWindows(true);

		Recount_MainWindow:StartSizing("BOTTOMLEFT");
		Recount_MainWindow:StopMovingOrSizing();
	end
end

if(addon:CheckAddOn("Omen")) then
	function module:Omen()
		local parent = self.left;
		if(E.db.addOnSkins.embed.embedType == "DOUBLE") then
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
	module["skadaWindows"] = {};
	function module:Skada()
		wipe(self["skadaWindows"]);
		for k, window in pairs(Skada:GetWindows()) do
			tinsert(self.skadaWindows, window);
		end

		local numberToEmbed = 0;
		if(E.db.addOnSkins.embed.embedType == "SINGLE") then
			numberToEmbed = 1;
		end
		if(E.db.addOnSkins.embed.embedType == "DOUBLE") then
			if(self.db.right == "Skada") then numberToEmbed = numberToEmbed + 1; end
			if(self.db.left == "Skada") then numberToEmbed = numberToEmbed + 1; end
		end

		local function EmbedWindow(window, width, height, point, relativeFrame, relativePoint, ofsx, ofsy)
			if(not window) then return; end
			local barmod = Skada.displays["bar"];

			window.db.barwidth = width;
			window.db.background.height = height - (window.db.enabletitle and window.db.barheight or -(E.Border + E.Spacing)) - (E.Border + E.Spacing);

			window.db.spark = false;
			window.db.barslocked = true;
			window.db.enablebackground = true;

			window.bargroup:SetParent(relativeFrame);
			window.bargroup:ClearAllPoints();
			window.bargroup:SetPoint(point, relativeFrame, relativePoint, ofsx, window.db.reversegrowth and ofsy or -ofsy);

			window.bargroup:SetFrameStrata("LOW");

			barmod.ApplySettings(barmod, window);

			window.bargroup.bgframe:SetFrameStrata("LOW");
			window.bargroup.bgframe:SetFrameLevel(window.bargroup:GetFrameLevel() - 1);
		end

		local point;
		if(numberToEmbed == 1) then
			local parent = self.left;
			if(E.db.addOnSkins.embed.embedType == "DOUBLE") then
				parent = self.db.right == "Skada" and self.right or self.left;
			end
			point = self.skadaWindows[1].db.reversegrowth and "BOTTOMLEFT" or "TOPLEFT";
			EmbedWindow(self.skadaWindows[1], parent:GetWidth() -(E.Border*2), parent:GetHeight(), point, parent, point, E.Border, E.Border);
		elseif(numberToEmbed == 2) then
			point = self.skadaWindows[1].db.reversegrowth and "BOTTOMLEFT" or "TOPLEFT";
			EmbedWindow(self.skadaWindows[1], self.left:GetWidth() -(E.Border*2), self.left:GetHeight(), point, self.left, point, E.Border, E.Border);
			if(not self.skadaWindows[2]) then E:Print("Please Create Skada Windows 2"); return; end
			point = self.skadaWindows[2].db.reversegrowth and "BOTTOMRIGHT" or "TOPRIGHT";
			EmbedWindow(self.skadaWindows[2], self.right:GetWidth() -(E.Border*2), self.right:GetHeight(), point, self.right, point, -E.Border, E.Border);
		end
	end
end

function module:Hooks()
	local function ChatPanelLeft_OnFade()
		LeftChatPanel:Hide();
		_G[addonName .. "_Embed_SwitchButton"]:Hide();
	end

	local function ChatPanelRight_OnFade()
		RightChatPanel:Hide();
		_G[addonName .. "_Embed_SwitchButton"]:Hide();
	end

	LeftChatPanel.fadeFunc = ChatPanelLeft_OnFade;
	RightChatPanel.fadeFunc = ChatPanelRight_OnFade;

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
			else
				E.db[self.parent:GetName().."Faded"] = true;
				UIFrameFadeOut(self.parent, 0.2, self.parent:GetAlpha(), 0);
				UIFrameFadeOut(self, 0.2, self:GetAlpha(), 0);
				self.parent.fadeInfo.finishedFunc = self.parent.fadeFunc;
			end
		end
		module:UpdateSwitchButton();
	end);

	RightChatToggleButton:HookScript("OnEnter", function()
		if(E.db.addOnSkins.embed.rightChat) then
			GameTooltip:AddDoubleLine(L["Right Click:"], L["Toggle Embedded Addon"], 1, 1, 1);
			GameTooltip:Show();
			module:UpdateSwitchButton();
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
			else
				E.db[self.parent:GetName().."Faded"] = true;
				UIFrameFadeOut(self.parent, 0.2, self.parent:GetAlpha(), 0);
				UIFrameFadeOut(self, 0.2, self:GetAlpha(), 0);
				self.parent.fadeInfo.finishedFunc = self.parent.fadeFunc;
			end
		end
		module:UpdateSwitchButton();
	end);

	LeftChatToggleButton:HookScript("OnEnter", function()
		if(not E.db.addOnSkins.embed.rightChat) then
			GameTooltip:AddDoubleLine(L["Right Click:"], L["Toggle Embedded Addon"], 1, 1, 1);
			GameTooltip:Show();
			module:UpdateSwitchButton();
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

function module:UpdateSwitchButton()
	local chatPanel = E.db.addOnSkins.embed.rightChat and RightChatPanel or LeftChatPanel;
	local chatTab = E.db.addOnSkins.embed.rightChat and RightChatTab or LeftChatTab;
	local isDouble = E.db.addOnSkins.embed.embedType == "DOUBLE";

	self.switchButton:SetParent(chatPanel);

	if(E.db.addOnSkins.embed.belowTop and chatPanel:IsShown()) then
		self.switchButton:Show();
		self.switchButton.text:SetText(isDouble and self.db.left .. " / " .. self.db.right or self.db.left);
		self.switchButton:ClearAllPoints();
		if(E.Chat.RightChatWindowID and _G["ChatFrame" .. E.Chat.RightChatWindowID .. "Tab"]:IsVisible()) then
			self.switchButton:Point("LEFT", _G["ChatFrame" .. E.Chat.RightChatWindowID .. "Tab"], "RIGHT", 0, 0);
		else
			self.switchButton:Point(E.db.addOnSkins.embed.rightChat and "LEFT" or "RIGHT", chatTab, 5, 4);
		end
	elseif(self.switchButton:IsShown()) then
		self.switchButton:Hide();
	end
end

function module:WindowResize()
	if(not self.embedCreated) then return; end

	local SPACING = E.Border + E.Spacing;
	local chatPanel = E.db.addOnSkins.embed.rightChat and RightChatPanel or LeftChatPanel;
	local chatTab = E.db.addOnSkins.embed.rightChat and RightChatTab or LeftChatTab;
	local chatData = E.db.addOnSkins.embed.rightChat and RightChatDataPanel or LeftChatToggleButton;
	local topRight = chatData == RightChatDataPanel and (E.db.datatexts.rightChatPanel and "TOPLEFT" or "BOTTOMLEFT") or chatData == LeftChatToggleButton and (E.db.datatexts.leftChatPanel and "TOPLEFT" or "BOTTOMLEFT");
	local yOffset = (chatData == RightChatDataPanel and E.db.datatexts.rightChatPanel and SPACING) or (chatData == LeftChatToggleButton and E.db.datatexts.leftChatPanel and SPACING) or 0;
	local xOffset = (E.db.chat.panelBackdrop == "RIGHT" and E.db.addOnSkins.embed.rightChat and 0) or (E.db.chat.panelBackdrop == "LEFT" and not E.db.addOnSkins.embed.rightChat and 0) or (E.db.chat.panelBackdrop == "SHOWBOTH" and 0) or E.Border*3 - E.Spacing;
	local isDouble = E.db.addOnSkins.embed.embedType == "DOUBLE";

	self.left:SetParent(chatPanel);
	self.left:ClearAllPoints();
	self.left:SetPoint(isDouble and "BOTTOMRIGHT" or "BOTTOMLEFT", chatData, topRight, isDouble and E.db.addOnSkins.embed.leftWidth -SPACING or 0, yOffset);
	self.left:SetPoint(isDouble and "TOPLEFT" or "TOPRIGHT", chatTab, isDouble and (E.db.addOnSkins.embed.belowTop and "BOTTOMLEFT" or "TOPLEFT") or (E.db.addOnSkins.embed.belowTop and "BOTTOMRIGHT" or "TOPRIGHT"), E.db.addOnSkins.embed.embedType == "SINGLE" and xOffset or -xOffset, E.db.addOnSkins.embed.belowTop and -SPACING or 0);
	--self.left:Show();

	self:UpdateSwitchButton();

	if(isDouble) then
		self.right:ClearAllPoints();
		self.right:SetPoint("BOTTOMLEFT", chatData, topRight, E.db.addOnSkins.embed.leftWidth, yOffset);
		self.right:SetPoint("TOPRIGHT", chatTab, E.db.addOnSkins.embed.belowTop and "BOTTOMRIGHT" or "TOPRIGHT", xOffset, E.db.addOnSkins.embed.belowTop and -SPACING or 0);
	--	self.right:Show();
	end

	if(IsAddOnLoaded("ElvUI_Config")) then
		E.Options.args.addOnSkins.args.embed.args.leftWidth.min = floor(chatPanel:GetWidth() * .25);
		E.Options.args.addOnSkins.args.embed.args.leftWidth.max = floor(chatPanel:GetWidth() * .75);
	end
end

function module:Init()
	local LDB = LibStub:GetLibrary("LibDataBroker-1.1");
	local fTable = {};
	for name, obj in LDB:DataObjectIterator() do
		local function OnClick(self, button)
			obj.OnClick(self, button);
		end
		fTable[name] = OnClick;
	end

	if(not self.embedCreated) then
		self.left = CreateFrame("Frame", addonName.."_Embed_LeftWindow", UIParent);
		self.right = CreateFrame("Frame", addonName.."_Embed_RightWindow", self.left);

		self.switchButton = CreateFrame("Button", addonName .. "_Embed_SwitchButton", UIParent);
		self.switchButton:RegisterForClicks("AnyUp");
		self.switchButton:Size(120, 32);
		self.switchButton.text = self.switchButton:CreateFontString(nil, "OVERLAY");
		self.switchButton.text:FontTemplate(E.LSM:Fetch("font", E.db.chat.tabFont), E.db.chat.tabFontSize, E.db.chat.tabFontOutline);
		self.switchButton.text:SetTextColor(unpack(E["media"].rgbvaluecolor));
		self.switchButton.text:SetPoint("LEFT", 16, -5);
		self.switchButton:SetScript("OnClick", function(self, button)
		--	if(fTable[self.text:GetText()]) then
		--		fTable[self.text:GetText()](self, button);
		--	else
				if(module.left:IsShown()) then
					module.left:Hide();
					self:SetAlpha(0.6);
				else
					module.left:Show();
					self:SetAlpha(1);
				end
				module:UpdateSwitchButton();
		--	end
		end);
		self.switchButton:SetScript("OnMouseDown", function(self) self.text:SetPoint("LEFT", 18, -7); end);
		self.switchButton:SetScript("OnMouseUp", function(self) self.text:SetPoint("LEFT", 16, -5); end);

		self.embedCreated = true;

		self:Hooks();

		hooksecurefunc("FCF_SavePositionAndDimensions", function()
			module:UpdateSwitchButton();
		end);
		hooksecurefunc(E:GetModule("Chat"), "PositionChat", function(self, override)
			if(override) then
				module:Check();
			end
		end);
		hooksecurefunc(E:GetModule("Layout"), "ToggleChatPanels", function() module:Check(); end);

		self:ToggleChatFrame(false);
		self:Check();

		self.left:SetScript("OnShow", self.Show);
		self.left:SetScript("OnHide", self.Hide);
	end
end

function module:Initialize()
	self.db = E.db.addOnSkins.embed;

	if(E.db.addOnSkins.embed.embedType ~= "DISABLE") then
		self:Init();
	end
end

E:RegisterModule(module:GetName());