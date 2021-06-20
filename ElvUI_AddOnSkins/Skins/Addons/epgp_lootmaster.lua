local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

if not AS:IsAddonLODorEnabled("EPGP_LootMaster") then return end

local ipairs = ipairs
local select = select
local unpack = unpack

local GetItemQualityColor = GetItemQualityColor
local hooksecurefunc = hooksecurefunc

-- EPGP LootMaster 0.4.9
-- https://www.curseforge.com/wow/addons/epgp_lootmaster/files/409167

S:AddCallbackForAddon("EPGP_LootMaster", "EPGP_LootMaster", function()
	if not E.private.addOnSkins.EPGP_LootMaster then return end

	local EPGPLM = LibStub("AceAddon-3.0"):GetAddon("EPGPLootMaster", true)
	if not EPGPLM then return end

	S:SecureHook(EPGPLM, "InitUI", function(self)
		self.frame:SetTemplate("Transparent")
		self.frame.titleFrame:SetTemplate("Default")

		S:Unhook(EPGPLM, "InitUI")
	end)

	S:SecureHook(EPGPLM, "ShowVersionCheckFrame", function(self)
		self.versioncheckframe:SetTemplate("Transparent")
		self.versioncheckframe.titleFrame:SetTemplate("Default")

		self.versioncheckframe.sstScroll.frame:SetTemplate("Default")
		S:HandleScrollBar(_G[self.versioncheckframe.sstScroll.frame:GetName().."ScrollFrameScrollBar"])

		for i = 1, self.versioncheckframe:GetNumChildren() do
			local child = select(i, self.versioncheckframe:GetChildren())
			if child and child:IsObjectType("Button") then
				S:HandleButton(child)
			end
		end

		S:Unhook(EPGPLM, "ShowVersionCheckFrame")
	end)

	local function UpdateLootUI_Icon_SetNormalTexture(self, texture)
		if texture and self:GetParent().data then
			self:SetBackdropBorderColor(GetItemQualityColor(self:GetParent().data.quality))
		end
	end

	hooksecurefunc(EPGPLM, "UpdateLootUI", function(self)
		for _, frame in ipairs(self.lootSelectFrames) do
			if not frame.isSkinned then
				frame:SetTemplate("Transparent")

				frame.itemIcon:SetTemplate("Default")
				frame.itemIcon:GetNormalTexture():SetInside(frame.itemIcon.backdrop)
				frame.itemIcon:GetNormalTexture():SetTexCoord(unpack(E.TexCoords))
				frame.itemIcon:SetBackdropBorderColor(GetItemQualityColor(frame.data.quality))

				hooksecurefunc(frame.itemIcon, "SetNormalTexture", UpdateLootUI_Icon_SetNormalTexture)

				S:HandleButton(frame.btnPass)

				frame.timerFrame:SetBackdrop(nil)
				select(2, frame.timerFrame:GetChildren()):SetBackdrop(nil)

				frame.progressBar:CreateBackdrop()
				frame.progressBar:Height(20)
				frame.progressBar:SetStatusBarTexture(E.media.normTex)
				frame.progressBar:SetStatusBarColor(0.13, 0.35, 0.80)
				E:RegisterStatusBar(frame.progressBar)

				frame.btnNote:SetTemplate("Default")
				frame.btnNote:Size(20)
				frame.btnNote:HookScript("OnEnter", S.SetModifiedBackdrop)
				frame.btnNote:HookScript("OnLeave", S.SetOriginalBackdrop)
				frame.btnNote:SetHighlightTexture(nil)
				frame.btnNote:DisableDrawLayer("OVERLAY")

				local btnNoteIcon = frame.btnNote:GetRegions()
				btnNoteIcon:SetDrawLayer("ARTWORK")
				btnNoteIcon:SetPoint("CENTER", 0, 0)

				frame.tbNote:SetBackdrop(nil)
				S:HandleEditBox(frame.tbNote)

				local buttonSave = frame.tbNote:GetChildren()
				buttonSave:SetHeight(26)
				buttonSave:SetPoint("LEFT", frame.tbNote, "RIGHT", 0, 0)
				S:HandleButton(buttonSave)

				frame.isSkinned = true
			end

			for _, button in ipairs(frame.buttons) do
				S:HandleButton(button)
			end
		end
	end)
end)

S:AddCallbackForAddon("EPGP_LootMaster_ML", "EPGP_LootMaster_ML", function()
	if not E.private.addOnSkins.EPGP_LootMaster then return end

	local LMML = LibStub("AceAddon-3.0"):GetAddon("LootMasterML", true)
	if not LMML then return end

	S:SecureHook(LMML, "GetFrame", function(self)
		self.frame:SetTemplate("Transparent")
		self.frame.titleFrame:SetTemplate("Default")

		self.frame.extralootframe:SetTemplate("Transparent")
		self.frame.extralootframe:Point("TOPRIGHT", self.frame, "TOPLEFT", 1, -10)

		self.frame.itemIcon:SetTemplate("Default")
		self.frame.itemIcon:GetNormalTexture():SetInside(self.frame.itemIcon.backdrop)
		self.frame.itemIcon:GetNormalTexture():SetTexCoord(unpack(E.TexCoords))

		hooksecurefunc(self.frame.itemIcon, "SetNormalTexture", function(self, texture)
			if texture and self:GetParent().currentLoot then
				self:SetBackdropBorderColor(GetItemQualityColor(self:GetParent().currentLoot.quality))
			end
		end)

		self.frame.tbGPValueFrame:SetBackdrop(nil)
		S:HandleEditBox(self.frame.tbGPValue)

		S:HandleButton(self.frame.btnAnnounce)
		S:HandleButton(self.frame.btnDiscard)

		self.frame.sstScroll.frame:SetTemplate("Default")
		S:HandleScrollBar(_G[self.frame.sstScroll.frame:GetName().."ScrollFrameScrollBar"])

		S:Unhook(LMML, "GetFrame")
	end)

	local function CreateLootButton_Icon_SetNormalTexturefunction(self, texture)
		if texture and self.data then
			self:SetBackdropBorderColor(GetItemQualityColor(self.data.quality))
		end
	end

	S:RawHook(LMML, "CreateLootButton", function(self)
		local icon = S.hooks[self].CreateLootButton(self)

		icon:SetTemplate("Default")
		icon:GetNormalTexture():SetInside(icon.backdrop)
		icon:GetNormalTexture():SetTexCoord(unpack(E.TexCoords))

		hooksecurefunc(icon, "SetNormalTexture", CreateLootButton_Icon_SetNormalTexturefunction)

		return icon
	end)

	S:SecureHook(LMML, "ShowRaidInfoLookup", function(self)
		self.raidinfoframe:SetTemplate("Transparent")
		self.raidinfoframe.titleFrame:SetTemplate("Default")

		for i = 1, self.raidinfoframe:GetNumChildren() do
			local child = select(i, self.raidinfoframe:GetChildren())
			if child and child:IsObjectType("Button") then
				S:HandleButton(child)
			end
		end

		self.raidinfoframe.sstScroll.frame:SetTemplate("Default")
		S:HandleScrollBar(_G[self.raidinfoframe.sstScroll.frame:GetName().."ScrollFrameScrollBar"])

		self.raidinfoframe.tbWhisperFrame:SetBackdrop(nil)
		S:HandleEditBox(self.raidinfoframe.tbWhisperBox)

		S:Unhook(LMML, "ShowRaidInfoLookup")
	end)
end)