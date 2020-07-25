local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

if not AS:IsAddonLODorEnabled("Skillet") then return end

local _G = _G
local unpack = unpack

-- Skillet r167
-- https://www.wowace.com/projects/skillet/files/438510

S:AddCallbackForAddon("Skillet", "Skillet", function()
	if not E.private.addOnSkins.Skillet then return end

	S:HandleCloseButton(SkilletFrameCloseButton)

	S:HandleScrollBar(SkilletSkillListScrollBar)

	S:HandleDropDownBox(SkilletSortDropdown)

	S:HandleEditBox(SkilletFilterBox)

	S:HandleCheckBox(SkilletHideUncraftableRecipes)
	SkilletHideUncraftableRecipes.backdrop:SetFrameLevel(SkilletHideUncraftableRecipes:GetFrameLevel())

	S:HandleCheckBox(SkilletHideTrivialRecipes)
	SkilletHideTrivialRecipes.backdrop:SetFrameLevel(SkilletHideTrivialRecipes:GetFrameLevel())

	S:HandleButton(SkilletShowOptionsButton)
	S:HandleButton(SkilletRescanButton)
	S:HandleButton(SkilletRecipeNotesButton)

	S:HandleButton(SkilletQueueAllButton)
	S:HandleButton(SkilletCreateAllButton)
	S:HandleButton(SkilletQueueButton)
	S:HandleButton(SkilletCreateButton)

	S:HandleSliderFrame(SkilletCreateCountSlider)

	S:HandleEditBox(SkilletItemCountInputBox)

	S:HandleScrollBar(SkilletQueueListScrollBar)

	S:HandleButton(SkilletStartQueueButton)
	S:HandleButton(SkilletEmptyQueueButton)
	S:HandleButton(SkilletShoppingListButton)

	S:HandleCloseButton(SkilletNotesCloseButton)

	S:HandleScrollBar(SkilletNotesListScrollBar)

	for i = 1, 7 do
		local buttonIcon = _G["SkilletNotesButton" .. i .. "Icon"]
		buttonIcon:SetTemplate("Default")
	end

	hooksecurefunc(Skillet, "CreateTradeSkillWindow", function()
		SkilletFrame:StripTextures()

		SkilletFrame:SetTemplate("Transparent")

		SkilletSkillListParent:SetTemplate("Default")
		SkilletSkillListParent:Point("TOPLEFT", 8, -100)
		SkilletSkillListParent:Point("BOTTOM", 0, 8)
		SkilletReagentParent:SetTemplate("Default")
		SkilletReagentParent:Point("TOPRIGHT", -8, -75)
		SkilletQueueParent:SetTemplate("Default")
		SkilletQueueParent:Point("TOP", SkilletCreateButton, "BOTTOM", 0, -3)
		SkilletQueueParent:Point("BOTTOMRIGHT", SkilletFrame, "BOTTOMRIGHT", -8, 32)

		SkilletRecipeNotesFrame:SetTemplate("Transparent")
	end)

	hooksecurefunc(Skillet, "UpdateNotesWindow", function()
		for i = 1, 7 do
			local buttonIcon = _G["SkilletNotesButton" .. i .. "Icon"]
			if buttonIcon:GetNormalTexture() then
				buttonIcon:GetNormalTexture():SetInside()
				buttonIcon:GetNormalTexture():SetTexCoord(unpack(E.TexCoords))
			end
		end
	end)
end)