local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

if not AS:IsAddonLODorEnabled("Examiner") then return end

local select = select
local unpack = unpack

-- Examiner 10.08.14
-- https://www.curseforge.com/wow/addons/examiner/files/445178

S:AddCallbackForAddon("Examiner", "Examiner", function()
	if not E.private.addOnSkins.Examiner then return end

	UIPanelWindows["Examiner"].width = 348

	Examiner:CreateBackdrop("Transparent")
	Examiner.backdrop:Point("TOPLEFT", 11, -12)
	Examiner.backdrop:Point("BOTTOMRIGHT", -32, 4)

	S:SetBackdropHitRect(Examiner)

	Examiner.dlgTopLeft:Hide()
	Examiner.dlgTopRight:Hide()
	Examiner.dlgBottomLeft:Hide()
	Examiner.dlgBottomRight:Hide()

	Examiner.portrait:Hide()

	S:HandleCloseButton((Examiner:GetChildren()), Examiner.backdrop)

	Examiner.model:Size(325, 352)
	Examiner.model:Point("BOTTOM", -11, 12)

	do -- Talents background
		local talantsPage
		for _, mod in ipairs(Examiner.modules) do
			if mod.token == "Talents" then
				talantsPage = mod.page
				break
			end
		end

		local bgTextures = {
			Examiner.bgTopLeft,
			Examiner.bgTopRight,
			Examiner.bgBottomLeft,
			Examiner.bgBottomRight
		}

		for _, texture in ipairs(bgTextures) do
			texture:SetParent(talantsPage)
			texture.SetWidth = E.noop
		end

		Examiner.bgTopLeft:Point("TOPLEFT", Examiner, "TOPLEFT", 20, -77)

		Examiner.bgTopLeft:Size(256, 256)
		Examiner.bgTopRight:Size(67, 256)
		Examiner.bgBottomLeft:Size(256, 112)
		Examiner.bgBottomRight:Size(67, 112)
	end

	local dropdownArrowColor = {1, 0.8, 0}
	local function skinAzDropdown(frame)
		frame:SetTemplate()

		S:HandleNextPrevButton(frame.button, "down", dropdownArrowColor)
		frame.button:Point("TOPRIGHT", -2, -2)
		frame.button:Point("BOTTOMRIGHT", -2, 2)
		frame.button:Size(20)
	end

	local function setSlotBackdropColor(self, r, g, b)
		self.parent:SetBackdropBorderColor(r, g, b)
	end

	local function setSlotBackdropDefault(self)
		self.parent:SetBackdropBorderColor(unpack(E.media.bordercolor))
	end

	local buttonReposition

	for _, mod in ipairs(Examiner.modules) do
		if mod.page then
			mod.page:SetTemplate("Transparent")

			if mod.token == "Talents" then
				mod.page:SetTemplate("Transparent")
				mod.page:Point("BOTTOM", -21, 40)
				mod.page:Size(304, 324)
			elseif mod.showItems then
				mod.page:Size(237, 284)
			else
				mod.page:Size(325, 324)
			end
		end

		if mod.button then
			if not buttonReposition then
				mod.button:Point("BOTTOMLEFT", 24, 12)
				buttonReposition = true
			end

			S:HandleButton(mod.button)
		end

		if mod.token == "ItemSlots" then
			for i, slot in ipairs(mod.slotBtns) do
				slot:StripTextures()
				slot:StyleButton(false)
				slot:SetTemplate("Default", true, true)

				slot.texture:SetDrawLayer("BORDER")
				slot.texture:SetInside()
				slot.texture:SetTexCoord(unpack(E.TexCoords))

				slot.border:Kill()
				slot.border.parent = slot
				slot.border.SetVertexColor = setSlotBackdropColor
				slot.border.Hide = setSlotBackdropDefault

				if i == 1 then
					slot:SetPoint("TOPLEFT", 0, 0)
				elseif i == 9 then
					slot:SetPoint("TOPRIGHT", 0, 0)
				elseif i == 17 then
					slot:Point("BOTTOM", -42, 28)
				elseif i <= 16 then
					slot:Point("TOP", mod.slotBtns[i - 1], "BOTTOM", 0, -4)
				else
					slot:Point("LEFT", mod.slotBtns[i - 1], "RIGHT", 5, 0)
				end
			end
		elseif mod.token == "Config" then
			skinAzDropdown((mod.page:GetChildren()))

			for i = 2, mod.page:GetNumChildren() do
				local child = select(i, mod.page:GetChildren())
				S:HandleCheckBox(child)
			end
		elseif mod.token == "Cache" then
			S:HandleScrollBar(ExaminerCacheScrollScrollBar)
			ExaminerCacheScrollScrollBar:Point("TOPLEFT", ExaminerCacheScroll, "TOPRIGHT", 3, -19)
			ExaminerCacheScrollScrollBar:Point("BOTTOMLEFT", ExaminerCacheScroll, "BOTTOMRIGHT", 3, 19)
		elseif mod.token == "Stats" then
			for i = 1, 5 do
				local child = select(i, mod.page:GetChildren())

				child:Size(24)
				child:SetTemplate("Transparent")

				if i == 1 then
					child:Point("TOPLEFT", 58, -9)
				end

				child.texture:SetInside()
				child.texture:SetDrawLayer("ARTWORK")

				if i == 3 then		-- Arcane
					-- texWidth, texHeight, cropWidth, cropHeight, offsetX, offsetY = 32, 256, 18, 18, 8, 64
					child.texture:SetTexCoord(0.25, 0.8125, 0.25, 0.3203125)
				elseif i == 1 then	-- Fire
					-- texWidth, texHeight, cropWidth, cropHeight, offsetX, offsetY = 32, 256, 18, 18, 8, 6
					child.texture:SetTexCoord(0.25, 0.8125, 0.0234375, 0.09375)
				elseif i == 2 then	-- Nature
					-- texWidth, texHeight, cropWidth, cropHeight, offsetX, offsetY = 32, 256, 18, 18, 8, 35
					child.texture:SetTexCoord(0.25, 0.8125, 0.13671875, 0.20703125)
				elseif i == 4 then	-- Frost
					-- texWidth, texHeight, cropWidth, cropHeight, offsetX, offsetY = 32, 256, 18, 18, 8, 94
					child.texture:SetTexCoord(0.25, 0.8125, 0.3671875, 0.4375)
				elseif i == 5 then	-- Shadow
					-- texWidth, texHeight, cropWidth, cropHeight, offsetX, offsetY = 32, 256, 18, 18, 8, 122
					child.texture:SetTexCoord(0.25, 0.8125, 0.4765625, 0.546875)
				end
			end

			S:HandleScrollBar(ExaminerStatScrollScrollBar)
			ExaminerStatScrollScrollBar:Point("TOPLEFT", ExaminerStatScroll, "TOPRIGHT", 10, -20)
			ExaminerStatScrollScrollBar:Point("BOTTOMLEFT", ExaminerStatScroll, "BOTTOMRIGHT", 10, 20)
		elseif mod.token == "PvP" then
			for i = 2, 4 do
				local child = select(i, mod.page:GetChildren())
				child:SetTemplate("Transparent")
			end
		elseif mod.token == "Feats" then
			skinAzDropdown((mod.page:GetChildren()))

			S:HandleScrollBar(ExaminerFeatsScrollScrollBar)
			ExaminerFeatsScrollScrollBar:Point("TOPLEFT", ExaminerFeatsScroll, "TOPRIGHT", 6, -19)
			ExaminerFeatsScrollScrollBar:Point("BOTTOMLEFT", ExaminerFeatsScroll, "BOTTOMRIGHT", 6, 19)
		elseif mod.token == "Talents" then
			for i = 1, MAX_TALENT_TABS do
				local tab = _G["ExaminerTab"..i]
				tab:StripTextures()
				tab:CreateBackdrop("Default", true)

				tab.backdrop:Point("TOPLEFT", 2, -7)
				tab.backdrop:Point("BOTTOMRIGHT", -1, -1)

				S:SetBackdropHitRect(tab)
			end

			for i, button in ipairs({ExaminerScrollChildFrame:GetChildren()}) do
				if i > 40 then break end

				button:StripTextures()
				button:SetTemplate("Default")
				button:StyleButton()

				button.icon:SetInside()
				button.icon:SetTexCoord(unpack(E.TexCoords))
				button.icon:SetDrawLayer("ARTWORK")

				button.slot:Hide()
				button.rankBorder:Hide()

				button.rank:SetFont(E.LSM:Fetch("font", E.db.general.font), 12, "OUTLINE")
			end

			S:HandleScrollBar(ExaminerTalentsScrollChildScrollBar)
			ExaminerTalentsScrollChildScrollBar:Point("TOPLEFT", ExaminerTalentsScrollChild, "TOPRIGHT", 4, -18)
			ExaminerTalentsScrollChildScrollBar:Point("BOTTOMLEFT", ExaminerTalentsScrollChild, "BOTTOMRIGHT", 4, 17)

			ExaminerTalentsScrollChild:ClearAllPoints()
			ExaminerTalentsScrollChild:Point("TOPLEFT", 1, -1)
			ExaminerTalentsScrollChild:Point("BOTTOMRIGHT", -1, 2)
		end
	end

	AS:SkinLibrary("AzDialog")
	AS:SkinLibrary("AzDropDown")
end)