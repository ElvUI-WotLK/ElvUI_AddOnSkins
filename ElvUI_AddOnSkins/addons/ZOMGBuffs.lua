local E, L, V, P, G = unpack(ElvUI);
local S = E:GetModule("Skins");

local pairs = pairs
local select = select
local unpack = unpack

-- ZOMGBuffs r156

local function LoadSkin()
	if(not E.private.addOnSkins.ZOMGBuffs) then return; end

	if ZOMGBuffsButton then
		ZOMGBuffsButton:SetNormalTexture(nil)
		ZOMGBuffsButton.SetNormalTexture = E.noop
		ZOMGBuffsButton:SetHighlightTexture(nil)
		ZOMGBuffsButton:SetPushedTexture(nil)
	else
		S:SecureHook(ZOMGBuffs, "OnStartup", function(self)
			self.icon:SetNormalTexture(nil)
			self.icon.SetNormalTexture = E.noop
			self.icon:SetHighlightTexture(nil)
			self.icon:SetPushedTexture(nil)

			S:Unhook(ZOMGBuffs, "OnStartup")
		end)
	end

	S:RawHook(ZOMGBuffs, "CreateHelpFrame", function(self)
		local frame = S.hooks[self].CreateHelpFrame(self)

		frame:SetScale(E:Scale(0.9))
		frame:SetTemplate("Transparent")
		frame.close:StripTextures()
		S:HandleButton(select(1, frame:GetChildren()))

		S:Unhook(ZOMGBuffs, "CreateHelpFrame")

		return frame
	end, true)

	local function SkinDewdrop()
		local frame
		local i = 1

		while _G["Dewdrop20Level" .. i] do
			frame = _G["Dewdrop20Level" .. i]

			if not frame.isSkinned then
				frame:SetTemplate("Transparent")

				select(1, frame:GetChildren()):Hide()
				frame.SetBackdropColor = E.noop
				frame.SetBackdropBorderColor = E.noop

				frame.isSkinned = true
			end

			i = i + 1
		end

		i = 1
		while _G["Dewdrop20Button"..i] do
			if not _G["Dewdrop20Button" .. i].isHook then
				_G["Dewdrop20Button" .. i]:HookScript("OnEnter", function(self)
					if not self.disabled and self.hasArrow then
						SkinDewdrop()
					end
				end)
				_G["Dewdrop20Button" .. i].isHook = true
			end

			i = i + 1
		end
	end

	local Dewdrop = LibStub("Dewdrop-2.0", true)
	if Dewdrop and not S:IsHooked(Dewdrop, "Open") then
		S:SecureHook(Dewdrop, "Open", SkinDewdrop)
	end

	local Tablet = LibStub("Tablet-2.0", true)
	if Tablet and not S:IsHooked(Tablet, "Open") then
		S:SecureHook(Tablet, "Open", function()
			_G["Tablet20Frame"]:SetTemplate("Transparent")
		end)
	end

	local LZF = LibStub:GetLibrary("ZFrame-1.0", true)
	if LZF and not S:IsHooked(LZF, "Create") then
		S:RawHook(LZF, "Create", function(self, ...)
			local frame = S.hooks[self].Create(self, ...)

			frame.ZMain:SetTemplate("Transparent")
			frame.ZMain.close:Size(32)
			S:HandleCloseButton(frame.ZMain.close, frame.ZMain)

			return frame
		end, true)
	end

	local AceAddon = LibStub("AceAddon-2.0", true)
	if AceAddon and not S:IsHooked(AceAddon.prototype, "OpenDonationFrame") then
		S:SecureHook(AceAddon.prototype, "OpenDonationFrame", function()
			AceAddon20Frame:SetTemplate("Transparent")
			S:HandleScrollBar(AceAddon20FrameScrollFrameScrollBar)
			S:HandleButton(AceAddon20FrameButton)

			S:Unhook(AceAddon.prototype, "OpenDonationFrame")
		end)
	end
end

local function LoadSkinBM()
	if(not E.private.addOnSkins.ZOMGBuffs) then return; end

	local ZBM = ZOMGBuffs:GetModule("ZOMGBlessingsManager")
	if not ZBM then return end

	S:SecureHook(ZBM, "SplitInitialize", function(self)
		local frame = self.splitframe

		S:HandleButton(frame.autoButton)
		S:HandleCheckBox(frame.useGuild)

		for i = 1, #frame.column do
			frame.column[i]:SetTemplate("Transparent")
			S:HandleScrollBar(frame.column[i].scroll.bar)

			for j = 1, 10 do
				frame.column[i].list[j].icon:SetTexCoord(unpack(E.TexCoords))
			end
		end
	end)

	S:RawHook(ZBM, "CreateMainMainFrame", function(self)
		local frame = S.hooks[self].CreateMainMainFrame(self)

		S:HandleButton(frame.configure)
		S:HandleButton(frame.help)
		S:HandleButton(frame.generate)
		S:HandleButton(frame.broadcast)
		S:HandleButton(frame.groups)
		S:HandleButton(frame.autoroles)

		for _, button in pairs(frame.classTitle.cell) do
			button.highlightTex:SetTexture(1, 1, 1, 0.3)
		end

		S:Unhook(ZOMGBlessingsManager, "CreateMainMainFrame")

		return frame
	end)

	local function SkinActionButton(button)
		if button.isSkinned then return end

		button:StyleButton()
		button:SetTemplate("Default")
		button:SetNormalTexture(nil)
		button.SetNormalTexture = E.noop

		button.icon:SetTexCoord(unpack(E.TexCoords))
		button.icon:SetInside()
		button.icon:SetDrawLayer("ARTWORK")

		button.isSkinned = true
	end

	S:SecureHook(ZBM, "SplitPanelColumnPopulate", function(self, col)
		if not self.expandpanel.class then return end

		for i, _ in pairs(col.cell) do
			SkinActionButton(col.cell[i])
		end
	end)

	S:SecureHook(ZBM, "DrawAll", function(self)
		if not self.configuring then return end

		local f = self.frame

		for i = 1, #f.row do
			for j, _ in pairs(f.row[i].cell) do
				SkinActionButton(f.row[i].cell[j])
			end
		end

		S:Unhook(ZBM, "DrawAll")
	end)
end

local function LoadSkinLog()
	if(not E.private.addOnSkins.ZOMGBuffs) then return; end

	local ZL = ZOMGBuffs:GetModule("ZOMGLog")
	if not ZL then return end

	S:RawHook(ZL, "CreateLogFrame", function(self)
		local frame = S.hooks[self].CreateLogFrame(self)

		S:HandleScrollBar(frame.scrollBar.slider)
		frame.scrollBar.slider:Height(24)

		return frame
	end, true)
end

S:AddCallbackForAddon("ZOMGBuffs", "ZOMGBuffs", LoadSkin);
S:AddCallbackForAddon("ZOMGBuffs_BlessingsManager", "ZOMGBuffs_BlessingsManager", LoadSkinBM);
S:AddCallbackForAddon("ZOMGBuffs_Log", "ZOMGBuffs_Log", LoadSkinLog);