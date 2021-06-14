local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

if not AS:IsAddonLODorEnabled("AckisRecipeList") then return end

local ipairs, select, unpack = ipairs, select, unpack

local hooksecurefunc = hooksecurefunc

-- AckisRecipeList 2.01.14
-- https://www.curseforge.com/wow/addons/arl/files/458020

S:AddCallbackForAddon("AckisRecipeList", "AckisRecipeList", function()
	if not E.private.addOnSkins.AckisRecipeList then return end

	local addon = LibStub("AceAddon-3.0"):GetAddon("Ackis Recipe List", true)
	if not addon then return end

	local function HandleScrollBar(frame)
		local UpButton, DownButton = frame:GetChildren()

		S:HandleNextPrevButton(UpButton, "up")
		UpButton:Size(20, 18)

		S:HandleNextPrevButton(DownButton)
		DownButton:Size(20, 18)

		frame.trackbg = CreateFrame("Frame", nil, frame)
		frame.trackbg:Point("TOPLEFT", UpButton, "BOTTOMLEFT", 0, -1)
		frame.trackbg:Point("BOTTOMRIGHT", DownButton, "TOPRIGHT", 0, 1)
		frame.trackbg:SetTemplate()

		frame:GetThumbTexture():SetAlpha(0)

		frame.thumbbg = CreateFrame("Frame", nil, frame)
		frame.thumbbg:Point("TOPLEFT", frame:GetThumbTexture(), "TOPLEFT", 8, -7)
		frame.thumbbg:Point("BOTTOMRIGHT", frame:GetThumbTexture(), "BOTTOMRIGHT", -8, 7)
		frame.thumbbg:SetTemplate("Default", true, true)
		frame.thumbbg:SetBackdropColor(0.6, 0.6, 0.6)
		frame.thumbbg:SetFrameLevel(frame.trackbg:GetFrameLevel() + 1)
	end

	local function SkinButton(button, strip)
		S:HandleButton(button, strip)

		button.SetNormalTexture = E.noop
		button.SetHighlightTexture = E.noop
		button.SetPushedTexture = E.noop
		button.SetDisabledTexture = E.noop
	end

	local function ChangeTexture(texture)
		texture:SetInside()
		texture:SetTexCoord(0.22, 0.78, 0.22, 0.78)
	end

	local function ExpansionButton(button)
		button:GetRegions():SetDesaturated(true)

		button:GetPushedTexture():SetTexture(nil)
		button:GetHighlightTexture():SetTexture(nil)
		button:GetCheckedTexture():SetTexture(nil)

		hooksecurefunc(button, "SetChecked", function(self, state)
			self:GetRegions():SetDesaturated(state)
		end)
	end

	S:HandleButton(addon.scan_button)

	hooksecurefunc(addon, "TRADE_SKILL_SHOW", function(self)
		if self.scan_button:GetParent() == TradeSkillFrame then
			self.scan_button:SetFrameLevel(TradeSkillFrame:GetFrameLevel() + 10)
		end
	end)

	S:SecureHook(addon, "Scan", function(self)
		S:Unhook(self, "Scan")

		local ARL_MainPanel = ARL_MainPanel

		ARL_MainPanel:StripTextures()
		ARL_MainPanel:CreateBackdrop("Transparent")
		ARL_MainPanel.backdrop:Point("TOPLEFT", 11, -12)
		ARL_MainPanel.backdrop:Point("BOTTOMRIGHT", -32, 76)

		S:SetBackdropHitRect(ARL_MainPanel, ARL_MainPanel.backdrop, true)

		hooksecurefunc(ARL_MainPanel, "ToggleState", function(self)
			if self.is_expanded then
				self.backdrop:Point("BOTTOMRIGHT", -87, 76)
				S:SetBackdropHitRect(self, self.backdrop, true)
			else
				self.backdrop:Point("BOTTOMRIGHT", -32, 76)
				S:SetBackdropHitRect(self, self.backdrop, true)
			end
		end)

		S:HandleCloseButton(ARL_MainPanel.xclose_button, ARL_MainPanel.backdrop)

		ARL_MainPanel.title_bar:Hide()

		ARL_MainPanel.top_left:Hide()
		ARL_MainPanel.top_right:Hide()
		ARL_MainPanel.bottom_left:Hide()
		ARL_MainPanel.bottom_right:Hide()

		ARL_MainPanel.top_left.Show = E.noop
		ARL_MainPanel.top_right.Show = E.noop
		ARL_MainPanel.bottom_left.Show = E.noop
		ARL_MainPanel.bottom_right.Show = E.noop

		ARL_MainPanel.prof_button:SetTemplate()
		ARL_MainPanel.prof_button:Size(32)
		ARL_MainPanel.prof_button:Point("TOPLEFT", 19, -20)

		local prof_buttonHighlight = ARL_MainPanel.prof_button:GetHighlightTexture()
		prof_buttonHighlight:SetInside()
		prof_buttonHighlight:SetTexture(1, 1, 1, 0.3)
		prof_buttonHighlight:SetTexture()

		ChangeTexture(ARL_MainPanel.prof_button._normal)
		ChangeTexture(ARL_MainPanel.prof_button._pushed)
		ChangeTexture(ARL_MainPanel.prof_button._disabled)

		hooksecurefunc(ARL_MainPanel.prof_button, "ChangeTexture", function(self)
			ChangeTexture(self._normal)
			ChangeTexture(self._pushed)
			ChangeTexture(self._disabled)
		end)

		S:HandleEditBox(ARL_MainPanel.search_editbox)
		ARL_MainPanel.search_editbox.backdrop:Point("TOPLEFT", -2, 0)
		ARL_MainPanel.search_editbox:Point("TOPLEFT", ARL_MainPanel, "TOPLEFT", 90, -50)
		ARL_MainPanel.search_editbox:DisableDrawLayer("BACKGROUND")
		ARL_MainPanel.search_editbox:Size(140, 17)

		for i = 1, ARL_MainPanel:GetNumChildren() do
			local child = select(i, ARL_MainPanel:GetChildren())
			if child and child:IsObjectType("CheckButton") and child.text then
				-- SkillToggle
				S:HandleCheckBox(child, true)
				child:Size(14)
				child:Point("TOPLEFT", ARL_MainPanel.search_editbox, "TOPRIGHT", -142, 34)
				child.text:Point("LEFT", child, "RIGHT", 3, 0)

				local excludeToggle = select(i + 1, ARL_MainPanel:GetChildren())
				S:HandleCheckBox(excludeToggle, true)
				excludeToggle:Size(14)
				excludeToggle:Point("TOP", child, "BOTTOM", 0, -3)
				excludeToggle.text:Point("LEFT", excludeToggle, "RIGHT", 3, 0)

				break
			end
		end

		select(2, ARL_MainPanel.expand_button:GetPoint()):GetParent():Hide()
		S:HandleCollapseExpandButton(ARL_MainPanel.expand_button, "+")
		ARL_MainPanel.expand_button:ClearAllPoints()
		ARL_MainPanel.expand_button:Point("BOTTOMRIGHT", ARL_MainPanel.search_editbox, "BOTTOMLEFT", -53, -2)

		ARL_MainPanel.list_frame:SetBackdrop(nil)
		ARL_MainPanel.list_frame:CreateBackdrop("Transparent")
		ARL_MainPanel.list_frame.backdrop:Point("TOPLEFT", -2, 2)
		ARL_MainPanel.list_frame.backdrop:Point("BOTTOMRIGHT", 5, 5)
		ARL_MainPanel.list_frame:Point("TOPLEFT", ARL_MainPanel, "TOPLEFT", 21, -73)

		HandleScrollBar(ARL_MainPanel.list_frame.scroll_bar)
		ARL_MainPanel.list_frame.scroll_bar:Point("TOPLEFT", ARL_MainPanel.list_frame, "TOPRIGHT", 6, -12)
		ARL_MainPanel.list_frame.scroll_bar:Point("BOTTOMLEFT", ARL_MainPanel.list_frame, "BOTTOMRIGHT", 6, 19)
		ARL_MainPanel.list_frame.scroll_bar.Hide = E.noop
		ARL_MainPanel.list_frame.scroll_bar:Show()

		for i = 1, 25 do
			S:HandleCollapseExpandButton(ARL_MainPanel.list_frame.state_buttons[i], "+")
			S:HandleButtonHighlight(ARL_MainPanel.list_frame.entry_buttons[i])
		end

		S:HandleNextPrevButton(ARL_MainPanel.sort_button, "down", nil, true)
		ARL_MainPanel.sort_button:Size(22)
		ARL_MainPanel.sort_button:ClearAllPoints()
		ARL_MainPanel.sort_button:Point("LEFT", ARL_MainPanel.expand_button, "RIGHT", 20, 0)

		ARL_MainPanel.sort_button.SetTextures = function(self)
			local normal, pushed = self:GetNormalTexture(), self:GetPushedTexture()

			if addon.db.profile.sorting == "Ascending" then
				normal:SetRotation(3.14)
				pushed:SetRotation(3.14)
			else
				normal:SetRotation(0)
				pushed:SetRotation(0)
			end
		end

		ARL_MainPanel.progress_bar:StripTextures()
		ARL_MainPanel.progress_bar:CreateBackdrop()
		ARL_MainPanel.progress_bar:Size(209, 20)
		ARL_MainPanel.progress_bar:Point("BOTTOMLEFT", ARL_MainPanel, 20, 85)
		ARL_MainPanel.progress_bar:SetStatusBarTexture(E.media.normTex)
		ARL_MainPanel.progress_bar:SetStatusBarColor(0.22, 0.39, 0.84)
		E:RegisterStatusBar(ARL_MainPanel.progress_bar)

		ARL_MainPanel.close_button:Height(22)
		ARL_MainPanel.close_button:Point("LEFT", ARL_MainPanel.progress_bar, "RIGHT", 4, 0)
		SkinButton(ARL_MainPanel.close_button, true)

		for i, tab in ipairs(ARL_MainPanel.tabs) do
			tab:StripTextures()
			tab.left.SetTexture = E.noop
			tab.middle.SetTexture = E.noop
			tab.right.SetTexture = E.noop

			tab:CreateBackdrop()
			tab.backdrop:Point("TOPLEFT", 10, E.PixelMode and -1 or -3)
			tab.backdrop:Point("BOTTOMRIGHT", -10, 3)

			tab:SetHitRectInsets(10, 10, E.PixelMode and 1 or 3, 3)

			if i == 1 then
				tab:Point("TOPLEFT", ARL_MainPanel, "BOTTOMLEFT", 11, 78)
			else
				tab:Point("LEFT", ARL_MainPanel.tabs[i-1], "RIGHT", -15, 0)
			end
		end

		if not (TipTac and TipTac.AddModifiedTip) then
			E:GetModule("Tooltip"):SecureHookScript(AckisRecipeList_SpellTooltip, "OnShow", "SetStyle")
			AS:SkinLibrary("LibQTip-1.0")
		end

		S:HandleNextPrevButton(ARL_MainPanel.filter_toggle, "right", nil, true)
		ARL_MainPanel.filter_toggle:Point("TOPLEFT", ARL_MainPanel, "TOPLEFT", 324, -39)
		ARL_MainPanel.filter_toggle:Size(28)

		ARL_MainPanel.filter_toggle.SetTextures = function(self)
			local normal, pushed = self:GetNormalTexture(), self:GetPushedTexture()
			if ARL_MainPanel.is_expanded then
				normal:SetRotation(1.57)
				pushed:SetRotation(1.57)
			else
				normal:SetRotation(-1.57)
				pushed:SetRotation(-1.57)
			end

			self:HookScript("OnEnter", function()
				normal:SetVertexColor(unpack(E.media.rgbvaluecolor))
			end)
			self:HookScript("OnLeave", function()
				normal:SetVertexColor(1, 1, 1)
			end)
		end

		ARL_MainPanel.filter_toggle:HookScript("OnClick", function(self)
			if self.isFrameSkinned then return end
			self.isFrameSkinned = true

			ARL_MainPanel.filter_menu:SetTemplate("Transparent")
			ARL_MainPanel.filter_menu:Size(326, 332)
			ARL_MainPanel.filter_menu:Point("TOPRIGHT", ARL_MainPanel, "TOPRIGHT", -95, -71)

			ARL_MainPanel.filter_reset:Point("BOTTOMRIGHT", ARL_MainPanel, "BOTTOMRIGHT", -95, 84)
			SkinButton(ARL_MainPanel.filter_reset, true)

			local menuIcons = {
				"menu_toggle_general",
				"menu_toggle_obtain",
				"menu_toggle_binding",
				"menu_toggle_item",
				"menu_toggle_quality",
				"menu_toggle_player",
				"menu_toggle_rep",
				"menu_toggle_misc"
			}

			for i, menuIcon in ipairs(menuIcons) do
				local iconEntry = ARL_MainPanel[menuIcon]

				if i == 1 then
					iconEntry:Point("LEFT", ARL_MainPanel.filter_toggle, "RIGHT", 17, 0)
				end

				iconEntry:SetTemplate()
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
				"misc"
			}

			for _, menu in ipairs(filterMenus) do
				local menuEntry = ARL_MainPanel.filter_menu[menu]

				if menu == "misc" then
					for i = 1, menuEntry:GetNumChildren() do
						local child = select(i, menuEntry:GetChildren())

						if child and child:IsObjectType("Button") then
							S:HandleNextPrevButton(child)
							select(2, child:GetPoint()):SetTextColor(1, 1, 1)
						end
					end
				elseif menu == "rep" then
					for expNum = 0, 2 do
						for i = 1, menuEntry["expansion"..expNum]:GetNumChildren() do
							local child = select(i, menuEntry["expansion"..expNum]:GetChildren())

							if child and (child:IsObjectType("Button") and child.text and not child:IsObjectType("CheckButton")) then
								child:StripTextures()
								child.text:SetTextColor(1, 0.8, 0.1)
							elseif child and child:IsObjectType("CheckButton") and child.text then
								S:HandleCheckBox(child)
								child.text:SetTextColor(1, 1, 1)
							end
						end
					end
				else
					for i = 1, menuEntry:GetNumChildren() do
						local child = select(i, menuEntry:GetChildren())

						if child and (child:IsObjectType("Button") and child.text and not child:IsObjectType("CheckButton")) then
							child:StripTextures()
							child.text:SetTextColor(1, 0.8, 0.1)
						elseif child and child:IsObjectType("CheckButton") and child.text then
							S:HandleCheckBox(child)
							child.text:SetTextColor(1, 1, 1)
						end
					end
				end
			end

			ExpansionButton(ARL_MainPanel.filter_menu.rep.toggle_expansion0)
			ExpansionButton(ARL_MainPanel.filter_menu.rep.toggle_expansion1)
			ExpansionButton(ARL_MainPanel.filter_menu.rep.toggle_expansion2)
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
end)