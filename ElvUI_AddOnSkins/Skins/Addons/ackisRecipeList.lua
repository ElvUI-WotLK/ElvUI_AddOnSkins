local E, L, V, P, G = unpack(ElvUI);
local S = E:GetModule("Skins");

local ipairs = ipairs
local select = select
local hooksecurefunc = hooksecurefunc

-- AckisRecipeList 2.01.14

local function LoadSkin()
	if(not E.private.addOnSkins.AckisRecipeList) then return; end

	local addon = LibStub("AceAddon-3.0"):GetAddon("Ackis Recipe List", true)
	if not addon then return end

	local function HandleScrollBar(frame)
		local UpButton = select(1, frame:GetChildren());
		local DownButton = select(2, frame:GetChildren());

		S:HandleNextPrevButton(UpButton);
		UpButton:Size(20, 18);
		S:SquareButton_SetIcon(UpButton, "UP");

		S:HandleNextPrevButton(DownButton);
		DownButton:Size(20, 18);
		S:SquareButton_SetIcon(DownButton, "DOWN");

		frame.trackbg = CreateFrame("Frame", nil, frame);
		frame.trackbg:Point("TOPLEFT", UpButton, "BOTTOMLEFT", 0, -1);
		frame.trackbg:Point("BOTTOMRIGHT", DownButton, "TOPRIGHT", 0, 1);
		frame.trackbg:SetTemplate("Transparent");

		frame:GetThumbTexture():SetAlpha(0);

		frame.thumbbg = CreateFrame("Frame", nil, frame);
		frame.thumbbg:Point("TOPLEFT", frame:GetThumbTexture(), "TOPLEFT", 8, -7);
		frame.thumbbg:Point("BOTTOMRIGHT", frame:GetThumbTexture(), "BOTTOMRIGHT", -8, 7);
		frame.thumbbg:SetTemplate("Default", true, true);
		frame.thumbbg:SetBackdropColor(0.6, 0.6, 0.6);
		frame.thumbbg:SetFrameLevel(frame.trackbg:GetFrameLevel() + 1);
	end

	local function SkinButton(button, strip)
		S:HandleButton(button, strip)

		button.SetNormalTexture = E.noop
		button.SetHighlightTexture = E.noop
		button.SetPushedTexture = E.noop
		button.SetDisabledTexture = E.noop
	end

	local function ChangeTexture(texture)
		texture:SetInside();
		texture:SetTexCoord(0.22, 0.78, 0.22, 0.78);
	end

	local function ExpansionButton(button)
		select(1, button:GetRegions()):SetDesaturated(true);

		button:GetPushedTexture():SetTexture("");
		button:GetHighlightTexture():SetTexture("");
		button:GetCheckedTexture():SetTexture("");

		hooksecurefunc(button, "SetChecked", function(self, state)
			select(1, self:GetRegions()):SetDesaturated(state);
		end);
	end

	S:HandleButton(addon.scan_button)

	hooksecurefunc(addon, "TRADE_SKILL_SHOW", function(self)
		if self.scan_button:GetParent() == TradeSkillFrame then
			self.scan_button:SetFrameLevel(TradeSkillFrame:GetFrameLevel() + 10)
		end
	end)

	hooksecurefunc(addon, "Scan", function(self)
		if self.isSkinned then return end
		self.isSkinned = true

		local ARL_MainPanel = ARL_MainPanel

		ARL_MainPanel:StripTextures()
		ARL_MainPanel:CreateBackdrop("Transparent")
		ARL_MainPanel.backdrop:Point("TOPLEFT", 10, -12)
		ARL_MainPanel.backdrop:Point("BOTTOMRIGHT", -35, 74)

		ARL_MainPanel.top_left:Kill()
		ARL_MainPanel.top_right:Kill()
		ARL_MainPanel.bottom_left:Kill()
		ARL_MainPanel.bottom_right:Kill()

		ARL_MainPanel.prof_button:Size(48)
		ARL_MainPanel.prof_button:Point("TOPLEFT", ARL_MainPanel, "TOPLEFT", 10, -12)
		ARL_MainPanel.prof_button:SetTemplate()
		ARL_MainPanel.prof_button:GetHighlightTexture():SetInside();
		ARL_MainPanel.prof_button:GetHighlightTexture():SetTexture(1, 1, 1, 0.3)

		ChangeTexture(ARL_MainPanel.prof_button._normal);
		ChangeTexture(ARL_MainPanel.prof_button._pushed);
		ChangeTexture(ARL_MainPanel.prof_button._disabled);

		hooksecurefunc(ARL_MainPanel.prof_button, "ChangeTexture", function(self, texture)
			ChangeTexture(self._normal);
			ChangeTexture(self._pushed);
			ChangeTexture(self._disabled);
		end)

		ARL_MainPanel.list_frame:SetBackdrop(nil)

		select(2, ARL_MainPanel.expand_button:GetPoint()):GetParent():Hide()

		ARL_MainPanel.search_editbox:Point("TOPLEFT", ARL_MainPanel, "TOPLEFT", 70, -39)
		ARL_MainPanel.search_editbox:DisableDrawLayer("BACKGROUND")
		S:HandleEditBox(ARL_MainPanel.search_editbox)

		for i = 1, ARL_MainPanel:GetNumChildren() do
			local p1, frame, p2, x, y

			local child = select(i, ARL_MainPanel:GetChildren())
			if child and child:IsObjectType("CheckButton") and child.text then
				S:HandleCheckBox(child, true)
				child:Size(14)

				if child.text:GetText() == SKILL then
					p1, frame, p2, x, y = child:GetPoint()
					child:Point(p1, frame, p2, x + 3, y + 1)

					p1, frame, p2, x, y = child.text:GetPoint()
					child.text:Point(p1, frame, p2, x + 3, y)
			--	elseif child.text:GetText() == LibStub("AceLocale-3.0"):GetLocale("Ackis Recipe List")["Display Exclusions"] then
				else
					p1, frame, p2, x, y = child:GetPoint()
					child:Point(p1, frame, p2, x, y - 3)

					p1, frame, p2, x, y = child.text:GetPoint()
					child.text:Point(p1, frame, p2, x + 3, y)
				end
			end
		end

		ARL_MainPanel.progress_bar:StripTextures()
		ARL_MainPanel.progress_bar:CreateBackdrop()
		ARL_MainPanel.progress_bar:Height(20)
		ARL_MainPanel.progress_bar:Point("BOTTOMLEFT", ARL_MainPanel, 15, 78)
		ARL_MainPanel.progress_bar:SetStatusBarTexture(E["media"].normTex)
		ARL_MainPanel.progress_bar:SetStatusBarColor(0.13, 0.35, 0.80)
		E:RegisterStatusBar(ARL_MainPanel.progress_bar)

		HandleScrollBar(ARL_MainPanel.list_frame.scroll_bar);

		S:HandleCloseButton(ARL_MainPanel.xclose_button, ARL_MainPanel.backdrop)

		S:HandleNextPrevButton(ARL_MainPanel.sort_button, true)
		S:SquareButton_SetIcon(ARL_MainPanel.sort_button, "DOWN")

		ARL_MainPanel.sort_button.SetTextures = function(self)
			if addon.db.profile.sorting == "Ascending" then
				S:SquareButton_SetIcon(self, "DOWN")
			else
				S:SquareButton_SetIcon(self, "UP")
			end
		end

		for i = 0, 25 do
			local c = ARL_MainPanel.list_frame.state_buttons[i]
			if i == 0 then
				c = ARL_MainPanel.expand_button
			end

			c:SetNormalTexture("");
			c.SetNormalTexture = E.noop;
			c:SetPushedTexture("");
			c.SetPushedTexture = E.noop;
			c:SetHighlightTexture("");
			c.SetHighlightTexture = E.noop;
			c:SetDisabledTexture("");
			c.SetDisabledTexture = E.noop;

			c.Text = c:CreateFontString(nil, "OVERLAY");
			c.Text:FontTemplate(nil, 22);
			c.Text:Point("RIGHT", -5, 0);
			c.Text:SetText("+");

			hooksecurefunc(c, "SetNormalTexture", function(self, texture)
				if(string.find(texture, "MinusButton")) then
					self.Text:SetText("-");
				else
					self.Text:SetText("+");
				end
			end);
		end

		ARL_MainPanel.filter_toggle:Point("TOPLEFT", ARL_MainPanel, "TOPLEFT", 325, -41)
		S:HandleNextPrevButton(ARL_MainPanel.filter_toggle)

		ARL_MainPanel.filter_toggle.SetTextures = function(self)
			if ARL_MainPanel.is_expanded then
				S:SquareButton_SetIcon(self, "LEFT")
			else
				S:SquareButton_SetIcon(self, "RIGHT")
			end

			self:HookScript("OnEnter", S.SetModifiedBackdrop);
			self:HookScript("OnLeave", S.SetOriginalBackdrop);
		end

		ARL_MainPanel.close_button:Height(22)
		ARL_MainPanel.close_button:Point("LEFT", ARL_MainPanel.progress_bar, "RIGHT", 3, 0)
		SkinButton(ARL_MainPanel.close_button, true)

		for i, tab in ipairs(ARL_MainPanel.tabs) do
			tab:StripTextures()
			tab.left:Kill()
			tab.middle:Kill()
			tab.right:Kill()

			tab.backdrop = CreateFrame("Frame", nil, tab)
			tab.backdrop:SetTemplate("Default")
			tab.backdrop:SetFrameLevel(tab:GetFrameLevel() - 1)
			tab.backdrop:Point("TOPLEFT", 10, E.PixelMode and -1 or -3)
			tab.backdrop:Point("BOTTOMRIGHT", -10, 3)

			if i == 1 then
				local p1, frame, p2, x, y = tab:GetPoint()
				tab:Point(p1, frame, p2, x, y - 5)
			end
		end

		if not (TipTac and TipTac.AddModifiedTip) then
			AckisRecipeList_SpellTooltip:HookScript("OnShow", function(self)
				E:GetModule("Tooltip"):SetStyle(self)
			end)

			local LibQTip = LibStub("LibQTip-1.0")
			if LibQTip and not S:IsHooked(LibQTip, "Acquire") then
				S:RawHook(LibQTip, "Acquire", function(self, key)
					local tooltip = self.activeTooltips[key]
					if tooltip then
						E:GetModule("Tooltip"):SetStyle(tooltip)
					end
				end)
			end
		end

		hooksecurefunc(ARL_MainPanel, "ToggleState", function(self)
			if self.is_expanded then
				self.backdrop:ClearAllPoints()
				self.backdrop:Point("TOPLEFT", 10, -12)
				self.backdrop:Point("BOTTOMRIGHT", -88, 74)
			else
				self.backdrop:ClearAllPoints()
				self.backdrop:Point("TOPLEFT", 10, -12)
				self.backdrop:Point("BOTTOMRIGHT", -35, 74)
			end
		end)

		ARL_MainPanel.filter_toggle:HookScript("OnClick", function(self)
			if self.isSkinned then return end
			self.isSkinned = true

			ARL_MainPanel.filter_menu:Point("TOPRIGHT", ARL_MainPanel, "TOPRIGHT", -115, -75)

			ARL_MainPanel.filter_reset:Point("BOTTOMRIGHT", ARL_MainPanel, "BOTTOMRIGHT", -95, 78)
			SkinButton(ARL_MainPanel.filter_reset, true)

			local menuIcons = {
				"menu_toggle_general",
				"menu_toggle_obtain",
				"menu_toggle_binding",
				"menu_toggle_item",
				"menu_toggle_quality",
				"menu_toggle_player",
				"menu_toggle_rep",
				"menu_toggle_misc",
			}

			for i, menuIcon in ipairs(menuIcons) do
				local iconEntry = ARL_MainPanel[menuIcon]

				if i == 1 then
					iconEntry:Point("LEFT", ARL_MainPanel.filter_toggle, "RIGHT", 21, 0)
				end

				iconEntry:SetTemplate("Default")
				iconEntry:StyleButton()

				iconEntry:DisableDrawLayer("BACKGROUND")

				local region = select(2, iconEntry:GetRegions())
				region:SetInside()
				region:SetTexCoord(unpack(E.TexCoords))
			end

			local filterMenus = {
				"general",
				"obtain",
				"binding",
				"item",
				"quality",
				"player",
				"rep",
				"misc",
			}

			for _, menu in ipairs(filterMenus) do
				local menuEntry = ARL_MainPanel.filter_menu[menu]

				if menu == "misc" then
					for i = 1, menuEntry:GetNumChildren() do
						local child = select(i, menuEntry:GetChildren())
						if child and child:IsObjectType("Button") then
							S:HandleNextPrevButton(child)
							select(2, child:GetPoint()):SetTextColor(NORMAL_FONT_COLOR, 1)
						end
					end
				elseif menu == "rep" then
					for expNum = 0, 2 do
						for i = 1, menuEntry["expansion"..expNum]:GetNumChildren() do
							local child = select(i, menuEntry["expansion"..expNum]:GetChildren())
							if child and child:IsObjectType("CheckButton") and child.text then
								S:HandleCheckBox(child)
								child.text:SetTextColor(NORMAL_FONT_COLOR, 1)
							end
						end
					end
				else
					for i = 1, menuEntry:GetNumChildren() do
						local child = select(i, menuEntry:GetChildren())
						if child and child:IsObjectType("CheckButton") and child.text then
							S:HandleCheckBox(child)
							child.text:SetTextColor(NORMAL_FONT_COLOR, 1)
						end
					end
				end
			end

			ExpansionButton(ARL_MainPanel.filter_menu["rep"].toggle_expansion0);
			ExpansionButton(ARL_MainPanel.filter_menu["rep"].toggle_expansion1);
			ExpansionButton(ARL_MainPanel.filter_menu["rep"].toggle_expansion2);
		end)
	end)

	ARLCopyFrame:StripTextures()
	ARLCopyFrame:SetTemplate("Transparent")
	S:HandleScrollBar(ARLCopyScrollScrollBar)

	for i = 1, ARLCopyFrame:GetNumChildren() do
		local child = select(i, ARLCopyFrame:GetChildren())
		if child and child:IsObjectType("Button") then
			child:ClearAllPoints()
			child:Point("TOPRIGHT", ARLCopyFrame, "TOPRIGHT", 1, 0)
			S:HandleCloseButton(child)
			break
		end
	end
end

S:AddCallbackForAddon("AckisRecipeList", "AckisRecipeList", LoadSkin);