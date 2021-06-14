local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

if not AS:IsAddonLODorEnabled("Talented") then return end

local unpack = unpack

-- Talented r660

S:AddCallbackForAddon("Talented", "Talented", function()
	if not E.private.addOnSkins.Talented then return end

	local function SkinButton(button)
		S:HandleButton(button, true)
		button.left:Kill()
		button.middle:Kill()
		button.right:Kill()
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

	TalentedGlyphs:CreateBackdrop("Transparent")
	TalentedGlyphs.backdrop:Point("TOPLEFT", 11, -12)
	TalentedGlyphs.backdrop:Point("BOTTOMRIGHT", -32, 76)
	TalentedGlyphs:SetHitRectInsets(0, 0, 0, 0)

	S:SetBackdropHitRect(TalentedGlyphs, TalentedGlyphs.backdrop, true)

	S:HandleCloseButton(TalentedGlyphs.close)

	TalentedGlyphs.title:Point("TOP", 0, -15)

	TalentedGlyphs.portrait:Hide()

	TalentedGlyphs.background:SetDrawLayer("ARTWORK")
	TalentedGlyphs.background:Size(323, 349)
	TalentedGlyphs.background:Point("TOPLEFT", 20, -59)
	TalentedGlyphs.background:CreateBackdrop()


	TalentedGlyphs.glow:SetDrawLayer("OVERLAY")
	TalentedGlyphs.glow:SetAllPoints(TalentedGlyphs.background)

	-- texWidth, texHeight, cropWidth, cropHeight, offsetX, offsetY = 512, 512, 315, 340, 21, 72
	TalentedGlyphs.background:SetTexCoord(0.041015625, 0.65625, 0.140625, 0.8046875)

	-- texWidth, texHeight, cropWidth, cropHeight, offsetX, offsetY = 512, 512, 315, 340, 30, 34
	TalentedGlyphs.glow:SetTexCoord(0.05859375, 0.673828125, 0.06640625, 0.73046875)

	local glyphBGScale = 1.0253968
	local glyphPositions = {
		{"CENTER", -1, 126},
		{"CENTER", -1, -119},
		{"TOPLEFT", 8, -62},
		{"BOTTOMRIGHT", -10, 70},
		{"TOPRIGHT", -8, -62},
		{"BOTTOMLEFT", 7, 70}
	}

	local slotAnimations = {}
	local TOPLEFT, TOP, TOPRIGHT, BOTTOMRIGHT, BOTTOM, BOTTOMLEFT = 3, 1, 5, 4, 2, 6
	slotAnimations[TOPLEFT] = {["point"] = "CENTER", ["xStart"] = -13, ["xStop"] = -85, ["yStart"] = 17, ["yStop"] = 60}
	slotAnimations[TOP] = {["point"] = "CENTER", ["xStart"] = -13, ["xStop"] = -13, ["yStart"] = 17, ["yStop"] = 100}
	slotAnimations[TOPRIGHT] = {["point"] = "CENTER", ["xStart"] = -13, ["xStop"] = 59, ["yStart"] = 17, ["yStop"] = 60}
	slotAnimations[BOTTOM] = {["point"] = "CENTER", ["xStart"] = -13, ["xStop"] = -13, ["yStart"] = 17, ["yStop"] = -64}
	slotAnimations[BOTTOMLEFT] = {["point"] = "CENTER", ["xStart"] = -13, ["xStop"] = -87, ["yStart"] = 18, ["yStop"] = -27}
	slotAnimations[BOTTOMRIGHT] = {["point"] = "CENTER", ["xStart"] = -13, ["xStop"] = 61, ["yStart"] = 18, ["yStop"] = -27}

	for _, animData in ipairs(slotAnimations) do
		animData.xStart = animData.xStart + 3
		animData.yStart = animData.yStart + 8
		animData.xStop = (animData.xStop + 3) * glyphBGScale
		animData.yStop = (animData.yStop + 8) * glyphBGScale
	end

	local glyphFrameLevel = TalentedGlyphs:GetFrameLevel() + 1

	for glyphID, glyph in ipairs(TalentedGlyphs.glyphs) do
		glyph:SetFrameLevel(glyphFrameLevel)
		glyph:Size(90)
		glyph:SetScale(glyphBGScale)
		local point, x, y = unpack(glyphPositions[glyphID])
		glyph:Point(point, TalentedGlyphs.background.backdrop, x, y)

		local animation = slotAnimations[glyphID]
		glyph.sparkle:SetDrawLayer("OVERLAY")
		glyph.sparkle:Point(animation.point, animation.xStart, animation.yStart)
		glyph.sparkle.anim.translation:SetOffset(animation.xStop - animation.xStart, animation.yStop - animation.yStart)
	end

	S:HandleCheckBox(TalentedGlyphs.checkbox)
	TalentedGlyphs.checkbox:Point("BOTTOMLEFT", 15, 80)
end)

S:AddCallbackForAddon("Talented_SpecTabs", "Talented_SpecTabs", function()
	if not E.private.addOnSkins.Talented then return end

	local function skinTabs()
		Talented.tabs:Point("TOPLEFT", TalentedFrame, "TOPRIGHT", -1, -40)

		for _, tab in ipairs({"spec1", "spec2", "petspec1"}) do
			tab = Talented.tabs[tab]
			tab:SetTemplate("Default")
			tab:StyleButton()
			tab:DisableDrawLayer("BACKGROUND")
			tab:GetNormalTexture():SetInside(tab.backdrop)
			tab:GetNormalTexture():SetTexCoord(unpack(E.TexCoords))
		end
	end

	if Talented.base then
		skinTabs()
	else
		hooksecurefunc(Talented, "CreateBaseFrame", skinTabs)
	end
end)