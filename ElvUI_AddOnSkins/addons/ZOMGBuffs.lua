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

	E:GetModule("AddOnSkins"):SkinLibrary("AceAddon-2.0")
	E:GetModule("AddOnSkins"):SkinLibrary("Dewdrop-2.0")
	E:GetModule("AddOnSkins"):SkinLibrary("Tablet-2.0")
	E:GetModule("AddOnSkins"):SkinLibrary("ZFrame-1.0")
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