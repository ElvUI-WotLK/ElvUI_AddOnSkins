local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

if not AS:IsAddonLODorEnabled("ItemRack") then return end

-- ItemRack
--

S:AddCallbackForAddon("ItemRack", "ItemRack", function()
	if not E.private.addOnSkins.ItemRack then return end


 local function ItemRackOptFrame_onshow()

	local frames = {
		"ItemRackOptFrame",
		
		-- "ItemRackOptSubFrame1",
		-- "ItemRackOptSubFrame2",
		}
		for _,frame in ipairs(frames) do
			frame = _G[frame]
			if frame then
				-- frame:SetResizable(true)
				-- frame:SetMinResize(288, 348)
				-- frame:SetMaxResize(500, 500)
				frame:SetWidth(310)
				frame:SetHeight(350)
				-- local sizer = CreateFrame("Button", "ItemRackOptFrameSizer", frame)
				-- 	sizer:SetHeight(16)
				-- 	sizer:SetWidth(16)
				-- 	sizer:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", 0, 0)
				-- 	sizer:SetScript(
				-- 		"OnMouseDown",
				-- 		function (self) self:GetParent():StartSizing("BOTTOMRIGHT") end)
				-- 	sizer:SetScript(
				-- 		"OnMouseUp", function (self) self:GetParent():StopMovingOrSizing() end)

				-- 	local line1 = sizer:CreateTexture(nil, "BACKGROUND")
				-- 	line1:SetWidth(8)
				-- 	line1:SetHeight(8)
				-- 	line1:SetPoint("CENTER", 0, 0)
				-- 	line1:SetTexture("Interface\\Tooltips\\UI-Tooltip-Border")
				-- 	local x = 0.1 * 14/17
				-- 	line1:SetTexCoord(0.05 - x, 0.5, 0.05, 0.5 + x, 0.05, 0.5 - x, 0.5 + x, 0.5)

				-- 	local line2 = sizer:CreateTexture(nil, "BACKGROUND")
				-- 	line2:SetWidth(8)
				-- 	line2:SetHeight(8)
				-- 	line2:SetPoint("CENTER", 0, 0)
				-- 	line2:SetTexture("Interface\\Tooltips\\UI-Tooltip-Border")
				-- 	local x = 0.1 * 8/17
				-- 	line2:SetTexCoord(0.05 - x, 0.5, 0.05, 0.5 + x, 0.05, 0.5 - x, 0.5 + x, 0.5)
					frame:StripTextures()
					frame:CreateBackdrop("Transparent")

			end
	end
	local frames = {
		"ItemRackOptSubFrame1",
		"ItemRackOptSubFrame2",
		"ItemRackOptBindFrame",
		"ItemRackOptListScrollFrame",
		"ItemRackOptListScrollFrameScrollChildFrame",
		"ItemRackOptSubScrollFrame",
		"ItemRackOptSubScrollFrameScrollChildFrame",
		-- "ItemRackOptSubFrame5",

		}
		for _,frame in ipairs(frames) do
			frame = _G[frame]
			if frame then
				frame:StripTextures()

				frame:SetWidth(220)
				frame:SetHeight(290)
				frame:ClearAllPoints()
				frame:SetPoint("TOP", ItemRackOptFrame, "TOP", 0, -24.000001162583)


			end
		end




	local frames = {
		"ItemRackOptList1",
		"ItemRackOptList2",
		"ItemRackOptList3",
		"ItemRackOptList4",
		"ItemRackOptList5",
		"ItemRackOptList6",
		"ItemRackOptList7",
		"ItemRackOptList8",
		"ItemRackOptList9",
		"ItemRackOptSetsIconScrollFrame",
		"ItemRackOptSetsIconFrame",
		"ItemRackOptSetsIconScrollFrameScrollChildFrame",
		"ItemRackOptSubFrame5",

		}
		for _,frame in ipairs(frames) do
			frame = _G[frame]
			if frame then
				frame:StripTextures()

			end
		end

	local frames = {
		"ItemRackOptSetsName",
		
		}
		for _,frame in ipairs(frames) do
			frame = _G[frame]
			if frame then
				-- frame:StripTextures()
				frame:CreateBackdrop("Transparent")

			end
		end

	local frames = {
		
		-- "ItemRackOptSetListFrame",
		-- "ItemRackOptSetListFrameScrollChildFrame",
		-- "ItemRackOptSetListsFrame",
		-- "ItemRackOptSetListsFrameScrollChildFrame",
		-- "ItemRackOptSetListScrollFrame",
		-- "ItemRackOptSetListScrollFrameChildFrame",
		-- "ItemRackOptSetListScrollFrameScrollChildFrame",
		-- "FauxScrollFrameTemplate",
		"ItemRackOptSubFrame5_lists",
		-- "ItemRackOptSubFrame4",
		-- "ItemRackOptSubFrame5",
		-- "ItemRackOptSubFrame6",
		-- "ItemRackOptSubFrame7",
		-- "ItemRackOptSubFrame8",
		-- "ItemRackOptSubFrame9",
		}
		for _,frame in ipairs(frames) do
			frame = _G[frame]
			if frame then
				frame:StripTextures()
				-- /run _G[obame]:StripTextures()
				frame:CreateBackdrop("Transparent")

			end
		end



	local tabs = {
		"ItemRackOptTab1",
		"ItemRackOptTab2",

		}
		for _,tab in ipairs(tabs) do
			tab = _G[tab]
			if tab then
				S:HandleTab(tab)
			end
		end

	local ScrollBars = {
		"ItemRackOptListScrollFrameScrollBar",
		


		}
		for _,ScrollBar in ipairs(ScrollBars) do
			ScrollBar = _G[ScrollBar]
			if ScrollBar then
				S:HandleScrollBar(ScrollBar)
				ScrollBar:ClearAllPoints()
				ScrollBar:SetPoint("TOPLEFT", ItemRackOptListScrollFrame, "TOPRIGHT", 45, -16)
				ScrollBar:SetPoint("BOTTOMLEFT", ItemRackOptListScrollFrame, "BOTTOMRIGHT", 45, 16)

			end
		end


		local ScrollBars = {			
			"ItemRackOptSetsIconScrollFrameScrollBar",
			}
			for _,ScrollBar in ipairs(ScrollBars) do
				ScrollBar = _G[ScrollBar]
				if ScrollBar then
					S:HandleScrollBar(ScrollBar)
				end
			end

			local dropdownArrowColor = {1, 0.8, 0}
			S:HandleNextPrevButton(ItemRackOptSetsDropDownButton, "down", dropdownArrowColor)
			ItemRackOptSetsDropDownButton:Size(21)
			ItemRackOptSetsDropDownButton:ClearAllPoints()
			ItemRackOptSetsDropDownButton:SetPoint("TOPRIGHT", ItemRackOptSetsDropTextureRight, "TOPRIGHT", -20, -20)




	for i = 1,11 do

			local checkbox = "ItemRackOptList"..i.."CheckButton"
			checkbox = _G[checkbox]
			if checkbox then
				S:HandleCheckBox(checkbox)

		end
	end


	local sliders = {
		"ItemRackOptButtonSpacingSlider",
		"ItemRackOptAlphaSlider",
		"ItemRackOptMainScaleSlider",
		"ItemRackOptMenuScaleSlider",
		"ItemRackOptSetMenuWrapValueSlider",
		}

		for _,slider in ipairs(sliders) do
			slider = _G[slider]
			if slider then
				S:HandleSliderFrame(slider)
			end
		end
	local editboxes = {
		"temRackOptButtonSpacing",
		"ItemRackOptButtonSpacing",
		"ItemRackOptAlpha",
		"ItemRackOptMainScale",
		"ItemRackOptMenuScale",
		"ItemRackOptSetMenuWrapValue",
		}

		for _,editbox in ipairs(editboxes) do
			editbox = _G[editbox]
			if editbox then
				editbox:StripTextures()
				S:HandleEditBox(editbox)
			end
		end
	local closebuttons = {
		"ItemRackOptClose",
		"ItemRackOptSetListClose",
		}

		for _,closebutton in ipairs(closebuttons) do
			closebutton = _G[closebutton]
			if closebutton then
				S:HandleCloseButton(closebutton)
			end
		end


		_G["ItemRackOptSetListClose"]:ClearAllPoints()
		_G["ItemRackOptSetListClose"]:SetPoint("TOPRIGHT", ItemRackOptSetsDropDownButton, "TOPRIGHT", 20, 20)


	local buttons = {
		"ItemRackOptResetBar",
		"ItemRackOptResetEverything",
		"ItemRackOptBindCancel",
		"ItemRackOptBindUnbind",

		}

		for _,button in ipairs(buttons) do
			button = _G[button]
			if button then
				S:HandleButton(button)
			end
		end

	-- for i = 0,19 do
	-- 	-- for i = 1,11 do

	-- 		-- local icon = "ItemRackOptInv"..i.."Border"
	-- 		-- icon = _G[icon]
	-- 		-- if icon then
	-- 		-- 	-- icon:StripTextures()
	-- 		-- 	-- icon:SetDrawLayer("BORDER")
	-- 		-- -- S:HandleCheckBox(icon)
	-- 		-- end
	-- 		local icon = "ItemRackOptInv"..i.."Icon"
	-- 		icon = _G[icon]
	-- 		if icon then
	-- 			-- icon:StripTextures()
	-- 			-- icon:SetDrawLayer("BORDER")
	-- 			S:HandleIcon(icon)
	-- 		end

	-- end
	----------------------------
	----------------------------2 frame
	
	local buttons = {
		"ItemRackOptSetsBindButton",
		"ItemRackOptSetsDeleteButton",
		"ItemRackOptSetsSaveButton",
		}

		for _,button in ipairs(buttons) do
			button = _G[button]
			if button then
				S:HandleButton(button)
			end
		end
		_G["ItemRackOptSetsBindButton"]:SetText("Связать")
		_G["ItemRackOptSetsDeleteButton"]:ClearAllPoints()
		_G["ItemRackOptSetsDeleteButton"]:SetPoint("TOPRIGHT", ItemRackOptSetsSaveButton, "TOPLEFT", -4, 0)



	end --end func

	hooksecurefunc(ItemRack,'ToggleOptions',ItemRackOptFrame_onshow)



end)