local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

if not AS:IsAddonLODorEnabled("ZOMGBuffs") then return end

local pairs = pairs
local unpack = unpack

-- ZOMGBuffs r156
-- https://www.wowace.com/projects/zomgbuffs/files/424938

S:AddCallbackForAddon("ZOMGBuffs", "ZOMGBuffs", function()
	if not E.private.addOnSkins.ZOMGBuffs then return end

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
		S:HandleButton((frame:GetChildren()))

		S:Unhook(ZOMGBuffs, "CreateHelpFrame")

		return frame
	end, true)

	AS:SkinLibrary("AceAddon-2.0")
	AS:SkinLibrary("Dewdrop-2.0")
	AS:SkinLibrary("Tablet-2.0")
	AS:SkinLibrary("ZFrame-1.0")
end)

S:AddCallbackForAddon("ZOMGBuffs_BlessingsManager", "ZOMGBuffs_BlessingsManager", function()
	if not E.private.addOnSkins.ZOMGBuffs then return end

	local ZBM = ZOMGBuffs:GetModule("ZOMGBlessingsManager", true)
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

		for i in pairs(col.cell) do
			SkinActionButton(col.cell[i])
		end
	end)

	S:SecureHook(ZBM, "DrawAll", function(self)
		if not self.configuring then return end

		local f = self.frame

		for i = 1, #f.row do
			for j in pairs(f.row[i].cell) do
				SkinActionButton(f.row[i].cell[j])
			end
		end

		S:Unhook(ZBM, "DrawAll")
	end)
end)

S:AddCallbackForAddon("ZOMGBuffs_Log", "ZOMGBuffs_Log", function()
	if not E.private.addOnSkins.ZOMGBuffs then return end

	local ZL = ZOMGBuffs:GetModule("ZOMGLog", true)
	if not ZL then return end

	S:RawHook(ZL, "CreateLogFrame", function(self)
		local frame = S.hooks[self].CreateLogFrame(self)

		S:HandleScrollBar(frame.scrollBar.slider)
		frame.scrollBar.slider:Height(24)

		return frame
	end, true)
end)