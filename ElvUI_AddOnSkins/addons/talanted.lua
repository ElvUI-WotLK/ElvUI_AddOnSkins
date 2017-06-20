local E, L, V, P, G = unpack(ElvUI);
local S = E:GetModule("Skins");

-- Talanted r660

local function LoadSkin()
	if(not E.private.addOnSkins.Talented) then return end

	local function SkinButton(button)
		S:HandleButton(button, true)
		button.left:Kill()
		button.middle:Kill()
		button.right:Kill()
	end

	local specButtons = {
		"spec1",
		"spec2",
		"petspec1"
	}

	local function SkinTabs()
		if Talented.tabs then
			local tabName
			for _, tab in pairs(specButtons) do
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
	end

	local function SkinResetButtons()
		local resetButton
		for i = 1, 3 do
			resetButton = TalentedFrame.view.elements[i].clear
			resetButton:GetNormalTexture():SetDesaturated(true)
			resetButton:GetPushedTexture():SetDesaturated(true)
			resetButton:GetHighlightTexture():SetDesaturated(true)
		end
	end

	local function SkinTalantButtons()
		local icon, rank
		local talantButtons = TalentedFrame.view.elements

		for talentID, talent in pairs(talantButtons) do
			if talantButtons[talentID].id and talent:IsObjectType("Button") then
				icon = talent.texture
				rank = talent.rank

				if talent then
					talent:SetTemplate("Default")
					talent:StyleButton()

					talent:DisableDrawLayer("BACKGROUND")
					talent:SetNormalTexture(nil)
					talent.SetNormalTexture = E.noop

					icon:SetInside(talent)
					icon:SetTexCoord(unpack(E.TexCoords))
					icon:SetDrawLayer("ARTWORK")

					rank:SetFont(E.LSM:Fetch("font", E.db["general"].font), 12, "OUTLINE")
					rank:Point("CENTER", talent, "BOTTOMRIGHT", 2, 0)
					rank.texture:Kill()
				end
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

		E:Delay(0.01, function()
			SkinTabs()
			SkinResetButtons()
			SkinTalantButtons()
		end)

		S:Unhook(Talented, "CreateBaseFrame")
	end)
end

local function LoadGlyphSkin()
	if(not E.private.addOnSkins.Talented) then return end

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
end

S:AddCallbackForAddon("Talented", "Talented", LoadSkin);
S:AddCallbackForAddon("Talented_GlyphFrame", "Talented_GlyphFrame", LoadGlyphSkin);