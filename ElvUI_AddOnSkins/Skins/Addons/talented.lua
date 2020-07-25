local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

if not AS:IsAddonLODorEnabled("Talented") then return end

-- Talented r660

S:AddCallbackForAddon("Talented", "Talented", function()
	if not E.private.addOnSkins.Talented then return end

	local function SkinButton(button)
		S:HandleButton(button, true)
		button.left:Kill()
		button.middle:Kill()
		button.right:Kill()
	end

	local function SkinTabs()
		if not Talented.tabs then return end

		local tabName
		for _, tab in ipairs({"spec1", "spec2", "petspec1"}) do
			tabName = Talented.tabs[tab]
			if tabName then
				tabName:SetTemplate("Default")
				tabName:StyleButton()
				tabName:DisableDrawLayer("BACKGROUND")
				tabName:GetNormalTexture():SetInside(tabName.backdrop)
				tabName:GetNormalTexture():SetTexCoord(unpack(E.TexCoords))
			end
		end
	end

	S:SecureHook(Talented, "CreateBaseFrame", function()
		TalentedFrame:StripTextures()
		TalentedFrame:SetTemplate("Transparent")

		S:HandleCloseButton(TalentedFrame.close, TalentedFrame)

		SkinButton(TalentedFrame.bactions)
		SkinButton(TalentedFrame.bmode)
		SkinButton(TalentedFrame.bglyphs)
		SkinButton(TalentedFrame.bactivate)

		TalentedFrame.bactivate:Point("BOTTOM", TalentedFrame, 0, 3)

		TalentedFrame.editname:Height(18)
		TalentedFrame.editname:DisableDrawLayer("BACKGROUND")
		S:HandleEditBox(TalentedFrame.editname)

		S:HandleCheckBox(TalentedFrame.checkbox)

		if AS:IsAddonEnabled("Talented_SpecTabs") then
			E:Delay(0.01, SkinTabs)
		elseif AS:IsAddonLOD("Talented_SpecTabs") then
			S:AddCallbackForAddon("Talented_SpecTabs", "Talented_SpecTabs", SkinTabs)
		end

		S:Unhook(Talented, "CreateBaseFrame")
	end)

	S:RawHook(Talented, "MakeButton", function(self, parent)
		local button = S.hooks[self].MakeButton(self, parent)

		if not button.isSkinned then
			button:SetTemplate("Default")
			button:StyleButton()

			button:DisableDrawLayer("BACKGROUND")
			button:SetNormalTexture(nil)
			button.SetNormalTexture = E.noop

			button.texture:SetInside(button)
			button.texture:SetTexCoord(unpack(E.TexCoords))
			button.texture:SetDrawLayer("ARTWORK")

			button.rank:SetFont(E.LSM:Fetch("font", E.db["general"].font), 12, "OUTLINE")
			button.rank:Point("CENTER", button, "BOTTOMRIGHT", 2, 0)
			button.rank.texture:Kill()

			button.isSkinned = true
		end

		return button
	end)

	S:RawHook(Talented, "GetButtonTarget", function(self, button)
		local target = S.hooks[self].GetButtonTarget(self, button)

		if not target.isSkinned then
			target:SetFont(E.LSM:Fetch("font", E.db["general"].font), 12, "OUTLINE")
			target:Point("CENTER", button, "TOPRIGHT", 2, 0)
			target.texture:Kill()

			target.isSkinned = true
		end

		return target
	end)

	S:RawHook(Talented, "MakeTalentFrame", function(self, parent, width, height)
		local tree = S.hooks[self].MakeTalentFrame(self, parent, width, height)

		if not tree.isSkinned then
			tree.clear:GetNormalTexture():SetDesaturated(true)
			tree.clear:GetPushedTexture():SetDesaturated(true)
			tree.clear:GetHighlightTexture():SetDesaturated(true)

			tree.isSkinned = true
		end

		return tree
	end)

	AS:SkinLibrary("Dewdrop-2.0")
end)

S:AddCallbackForAddon("Talented_GlyphFrame", "Talented_GlyphFrame", function()
	if not E.private.addOnSkins.Talented then return end

	TalentedGlyphs:Size(350, 420)
	TalentedGlyphs:SetTemplate("Transparent")

	TalentedGlyphs.title:ClearAllPoints()
	TalentedGlyphs.title:Point("TOP", TalentedGlyphs, 0, -8)

	TalentedGlyphs.portrait:Kill()
	TalentedGlyphs.background:Kill()

	TalentedGlyphs:CreateBackdrop("Transparent")
	TalentedGlyphs.backdrop:SetFrameLevel(TalentedGlyphs:GetFrameLevel())
	TalentedGlyphs.backdrop:Size(338, 364)
	TalentedGlyphs.backdrop:ClearAllPoints()
	TalentedGlyphs.backdrop:Point("TOPLEFT", TalentedGlyphs, 6, -28)

	TalentedGlyphs.texture = TalentedGlyphs.backdrop:CreateTexture(nil, "OVERLAY")
	TalentedGlyphs.texture:SetTexture("Interface\\Spellbook\\UI-GlyphFrame")
	TalentedGlyphs.texture:SetTexCoord(0.0390625, 0.65625, 0.140625, 0.8046875)
	TalentedGlyphs.texture:SetInside()

	local glyphPositions = {
		{"CENTER", 0, 125},
		{"CENTER", 0, -128},
		{"TOPLEFT", 7, -64},
		{"BOTTOMRIGHT", -21, 81},
		{"TOPRIGHT", -7, -64},
		{"BOTTOMLEFT", 21, 81}
	}

	local point, x, y
	for glyphID in pairs(TalentedGlyphs.glyphs) do
		point, x, y = unpack(glyphPositions[glyphID])
		TalentedGlyphs.glyphs[glyphID]:SetScale(1.063291)
		TalentedGlyphs.glyphs[glyphID]:ClearAllPoints()
		TalentedGlyphs.glyphs[glyphID]:SetPoint(point, TalentedGlyphs.backdrop, point, x, y)
	end

	S:HandleCloseButton(TalentedGlyphs.close, TalentedGlyphs)
	TalentedGlyphs.close:SetFrameLevel(TalentedGlyphs.close:GetFrameLevel() + 1)

	S:HandleCheckBox(TalentedGlyphs.checkbox)
	TalentedGlyphs.checkbox:ClearAllPoints()
	TalentedGlyphs.checkbox:Point("BOTTOMLEFT", TalentedGlyphs, 10, 5)
end)