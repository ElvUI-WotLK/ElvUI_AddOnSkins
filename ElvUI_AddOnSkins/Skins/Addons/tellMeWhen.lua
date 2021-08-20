local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

if not AS:IsAddonLODorEnabled("TellMeWhen") then return end

local _G = _G
local unpack = unpack

-- TellMeWhen 1.2.5b1
-- https://www.curseforge.com/wow/addons/tellmewhen/files/448968
-- TellMeWhen 1.1 ru
--https://github.com/fxpw/TWM-ru


S:AddCallbackForAddon("TellMeWhen", "TellMeWhen", function()
	if not E.private.addOnSkins.TellMeWhen then return end

	TELLMEWHEN_ICONSPACING = E.Border

	if TELLMEWHEN_VERSION == "1.1" or TELLMEWHEN_VERSION == "1.2.4"  then
		hooksecurefunc("TellMeWhen_Group_Update", function(groupID)
			local group = TellMeWhen_Settings.Groups[groupID]
			if not group.Enabled then return end

			local currentSpec = TellmeWhen_GetActiveTalentGroup()

			if (currentSpec == 1 and not group.PrimarySpec)
			or (currentSpec == 2 and not group.SecondarySpec)
			then
				return
			end

			local groupName = "TellMeWhen_Group" .. groupID

			for row = 1, group.Rows do
				for column = 1, group.Columns do
					local iconID = (row - 1) * group.Columns + column
					local iconName = groupName .. "_Icon" .. iconID
					local icon = _G[iconName]

					if icon and not icon.isSkinned then
						icon:SetTemplate("Default")

						icon:GetRegions():SetTexture(nil)

						_G[iconName .. "Texture"]:SetTexCoord(unpack(E.TexCoords))
						_G[iconName .. "Texture"]:SetInside()

						_G[iconName .. "Count"]:FontTemplate()

						_G[iconName .. "Highlight"]:SetTexture(1, 1, 1, 0.3)
						_G[iconName .. "Highlight"]:SetInside()

						E:RegisterCooldown(_G[iconName .. "Cooldown"])

						icon.isSkinned = true
					end
				end
			end
		end)
	else
		hooksecurefunc("TellMeWhen_Group_Update", function(groupID)
			local group = _G["TellMeWhen_Group" .. groupID]
			if not group.Enabled then return end

			for row = 1, group.Rows do
				for column = 1, group.Columns do
					local iconID = (row - 1) * group.Columns + column
					local iconName = group.groupName .. "_Icon" .. iconID
					local icon = _G[iconName]

					if icon and not icon.isSkinned then
						_G[iconName]:StyleButton()
						icon:SetTemplate("Default")

						icon:GetRegions():SetTexture(nil)

						_G[iconName .. "Icon"]:SetTexCoord(unpack(E.TexCoords))
						_G[iconName .. "Icon"]:SetInside()

						_G[iconName .. "Count"]:FontTemplate()

						E:RegisterCooldown(_G[iconName .. "Cooldown"])

						icon.isSkinned = true
					end
				end
			end
		end)
	end
	local dropdownArrowColor = {1, 0.8, 0}
	----------------buttons
	S:HandleButton(InterfaceOptionsTellMeWhenPanelGroup1GroupResetButton)
	S:HandleButton(InterfaceOptionsTellMeWhenPanelGroup2GroupResetButton)
	S:HandleButton(InterfaceOptionsTellMeWhenPanelGroup3GroupResetButton)
	S:HandleButton(InterfaceOptionsTellMeWhenPanelGroup4GroupResetButton)
	S:HandleButton(InterfaceOptionsTellMeWhenPanelGroup5GroupResetButton)
	S:HandleButton(InterfaceOptionsTellMeWhenPanelGroup6GroupResetButton)
	S:HandleButton(InterfaceOptionsTellMeWhenPanelGroup7GroupResetButton)
	S:HandleButton(InterfaceOptionsTellMeWhenPanelGroup8GroupResetButton)

	S:HandleButton(InterfaceOptionsTellMeWhenPanelLockUnlockButton)






	------arrow right
	
	S:HandleNextPrevButton(InterfaceOptionsTellMeWhenPanelGroup1ColumnsWidgetRightButton, "right", dropdownArrowColor)
	InterfaceOptionsTellMeWhenPanelGroup1ColumnsWidgetRightButton:Size(20)
	S:HandleNextPrevButton(InterfaceOptionsTellMeWhenPanelGroup2ColumnsWidgetRightButton, "right", dropdownArrowColor)
	InterfaceOptionsTellMeWhenPanelGroup2ColumnsWidgetRightButton:Size(20)
	S:HandleNextPrevButton(InterfaceOptionsTellMeWhenPanelGroup3ColumnsWidgetRightButton, "right", dropdownArrowColor)
	InterfaceOptionsTellMeWhenPanelGroup3ColumnsWidgetRightButton:Size(20)
	S:HandleNextPrevButton(InterfaceOptionsTellMeWhenPanelGroup4ColumnsWidgetRightButton, "right", dropdownArrowColor)
	InterfaceOptionsTellMeWhenPanelGroup4ColumnsWidgetRightButton:Size(20)
	S:HandleNextPrevButton(InterfaceOptionsTellMeWhenPanelGroup5ColumnsWidgetRightButton, "right", dropdownArrowColor)
	InterfaceOptionsTellMeWhenPanelGroup5ColumnsWidgetRightButton:Size(20)
	S:HandleNextPrevButton(InterfaceOptionsTellMeWhenPanelGroup6ColumnsWidgetRightButton, "right", dropdownArrowColor)
	InterfaceOptionsTellMeWhenPanelGroup6ColumnsWidgetRightButton:Size(20)
	S:HandleNextPrevButton(InterfaceOptionsTellMeWhenPanelGroup7ColumnsWidgetRightButton, "right", dropdownArrowColor)
	InterfaceOptionsTellMeWhenPanelGroup7ColumnsWidgetRightButton:Size(20)
	S:HandleNextPrevButton(InterfaceOptionsTellMeWhenPanelGroup8ColumnsWidgetRightButton, "right", dropdownArrowColor)
	InterfaceOptionsTellMeWhenPanelGroup8ColumnsWidgetRightButton:Size(20)


	S:HandleNextPrevButton(InterfaceOptionsTellMeWhenPanelGroup1RowsWidgetRightButton, "right", dropdownArrowColor)
	InterfaceOptionsTellMeWhenPanelGroup1RowsWidgetRightButton:Size(20)
	S:HandleNextPrevButton(InterfaceOptionsTellMeWhenPanelGroup2RowsWidgetRightButton, "right", dropdownArrowColor)
	InterfaceOptionsTellMeWhenPanelGroup2RowsWidgetRightButton:Size(20)
	S:HandleNextPrevButton(InterfaceOptionsTellMeWhenPanelGroup3RowsWidgetRightButton, "right", dropdownArrowColor)
	InterfaceOptionsTellMeWhenPanelGroup3RowsWidgetRightButton:Size(20)
	S:HandleNextPrevButton(InterfaceOptionsTellMeWhenPanelGroup4RowsWidgetRightButton, "right", dropdownArrowColor)
	InterfaceOptionsTellMeWhenPanelGroup4RowsWidgetRightButton:Size(20)
	S:HandleNextPrevButton(InterfaceOptionsTellMeWhenPanelGroup5RowsWidgetRightButton, "right", dropdownArrowColor)
	InterfaceOptionsTellMeWhenPanelGroup5RowsWidgetRightButton:Size(20)
	S:HandleNextPrevButton(InterfaceOptionsTellMeWhenPanelGroup6RowsWidgetRightButton, "right", dropdownArrowColor)
	InterfaceOptionsTellMeWhenPanelGroup6RowsWidgetRightButton:Size(20)
	S:HandleNextPrevButton(InterfaceOptionsTellMeWhenPanelGroup7RowsWidgetRightButton, "right", dropdownArrowColor)
	InterfaceOptionsTellMeWhenPanelGroup7RowsWidgetRightButton:Size(20)
	S:HandleNextPrevButton(InterfaceOptionsTellMeWhenPanelGroup8RowsWidgetRightButton, "right", dropdownArrowColor)
	InterfaceOptionsTellMeWhenPanelGroup8RowsWidgetRightButton:Size(20)





	------arriw left


	S:HandleNextPrevButton(InterfaceOptionsTellMeWhenPanelGroup1ColumnsWidgetLeftButton, "left", dropdownArrowColor)
	InterfaceOptionsTellMeWhenPanelGroup1ColumnsWidgetLeftButton:Size(20)
	S:HandleNextPrevButton(InterfaceOptionsTellMeWhenPanelGroup2ColumnsWidgetLeftButton, "left", dropdownArrowColor)
	InterfaceOptionsTellMeWhenPanelGroup2ColumnsWidgetLeftButton:Size(20)
	S:HandleNextPrevButton(InterfaceOptionsTellMeWhenPanelGroup3ColumnsWidgetLeftButton, "left", dropdownArrowColor)
	InterfaceOptionsTellMeWhenPanelGroup3ColumnsWidgetLeftButton:Size(20)
	S:HandleNextPrevButton(InterfaceOptionsTellMeWhenPanelGroup4ColumnsWidgetLeftButton, "left", dropdownArrowColor)
	InterfaceOptionsTellMeWhenPanelGroup4ColumnsWidgetLeftButton:Size(20)
	S:HandleNextPrevButton(InterfaceOptionsTellMeWhenPanelGroup5ColumnsWidgetLeftButton, "left", dropdownArrowColor)
	InterfaceOptionsTellMeWhenPanelGroup5ColumnsWidgetLeftButton:Size(20)
	S:HandleNextPrevButton(InterfaceOptionsTellMeWhenPanelGroup6ColumnsWidgetLeftButton, "left", dropdownArrowColor)
	InterfaceOptionsTellMeWhenPanelGroup6ColumnsWidgetLeftButton:Size(20)
	S:HandleNextPrevButton(InterfaceOptionsTellMeWhenPanelGroup7ColumnsWidgetLeftButton, "left", dropdownArrowColor)
	InterfaceOptionsTellMeWhenPanelGroup7ColumnsWidgetLeftButton:Size(20)
	S:HandleNextPrevButton(InterfaceOptionsTellMeWhenPanelGroup8ColumnsWidgetLeftButton, "left", dropdownArrowColor)
	InterfaceOptionsTellMeWhenPanelGroup8ColumnsWidgetLeftButton:Size(20)


	S:HandleNextPrevButton(InterfaceOptionsTellMeWhenPanelGroup1RowsWidgetLeftButton, "left", dropdownArrowColor)
	InterfaceOptionsTellMeWhenPanelGroup1RowsWidgetLeftButton:Size(20)
	S:HandleNextPrevButton(InterfaceOptionsTellMeWhenPanelGroup2RowsWidgetLeftButton, "left", dropdownArrowColor)
	InterfaceOptionsTellMeWhenPanelGroup2RowsWidgetLeftButton:Size(20)
	S:HandleNextPrevButton(InterfaceOptionsTellMeWhenPanelGroup3RowsWidgetLeftButton, "left", dropdownArrowColor)
	InterfaceOptionsTellMeWhenPanelGroup3RowsWidgetLeftButton:Size(20)
	S:HandleNextPrevButton(InterfaceOptionsTellMeWhenPanelGroup4RowsWidgetLeftButton, "left", dropdownArrowColor)
	InterfaceOptionsTellMeWhenPanelGroup4RowsWidgetLeftButton:Size(20)
	S:HandleNextPrevButton(InterfaceOptionsTellMeWhenPanelGroup5RowsWidgetLeftButton, "left", dropdownArrowColor)
	InterfaceOptionsTellMeWhenPanelGroup5RowsWidgetLeftButton:Size(20)
	S:HandleNextPrevButton(InterfaceOptionsTellMeWhenPanelGroup6RowsWidgetLeftButton, "left", dropdownArrowColor)
	InterfaceOptionsTellMeWhenPanelGroup6RowsWidgetLeftButton:Size(20)
	S:HandleNextPrevButton(InterfaceOptionsTellMeWhenPanelGroup7RowsWidgetLeftButton, "left", dropdownArrowColor)
	InterfaceOptionsTellMeWhenPanelGroup7RowsWidgetLeftButton:Size(20)
	S:HandleNextPrevButton(InterfaceOptionsTellMeWhenPanelGroup8RowsWidgetLeftButton, "left", dropdownArrowColor)
	InterfaceOptionsTellMeWhenPanelGroup8RowsWidgetLeftButton:Size(20)

	------ group button
	--in comb button
	S:HandleCheckBox(InterfaceOptionsTellMeWhenPanelGroup1EnableButton)
	S:HandleCheckBox(InterfaceOptionsTellMeWhenPanelGroup2EnableButton)
	S:HandleCheckBox(InterfaceOptionsTellMeWhenPanelGroup3EnableButton)
	S:HandleCheckBox(InterfaceOptionsTellMeWhenPanelGroup4EnableButton)
	S:HandleCheckBox(InterfaceOptionsTellMeWhenPanelGroup5EnableButton)
	S:HandleCheckBox(InterfaceOptionsTellMeWhenPanelGroup6EnableButton)
	S:HandleCheckBox(InterfaceOptionsTellMeWhenPanelGroup7EnableButton)
	S:HandleCheckBox(InterfaceOptionsTellMeWhenPanelGroup8EnableButton)
	--in comb button
	S:HandleCheckBox(InterfaceOptionsTellMeWhenPanelGroup1OnlyInCombatButton)
	S:HandleCheckBox(InterfaceOptionsTellMeWhenPanelGroup2OnlyInCombatButton)
	S:HandleCheckBox(InterfaceOptionsTellMeWhenPanelGroup3OnlyInCombatButton)
	S:HandleCheckBox(InterfaceOptionsTellMeWhenPanelGroup4OnlyInCombatButton)
	S:HandleCheckBox(InterfaceOptionsTellMeWhenPanelGroup5OnlyInCombatButton)
	S:HandleCheckBox(InterfaceOptionsTellMeWhenPanelGroup6OnlyInCombatButton)
	S:HandleCheckBox(InterfaceOptionsTellMeWhenPanelGroup7OnlyInCombatButton)
	S:HandleCheckBox(InterfaceOptionsTellMeWhenPanelGroup8OnlyInCombatButton)



	---main spec
	
	S:HandleCheckBox(InterfaceOptionsTellMeWhenPanelGroup1PrimarySpecButton)
	S:HandleCheckBox(InterfaceOptionsTellMeWhenPanelGroup2PrimarySpecButton)
	S:HandleCheckBox(InterfaceOptionsTellMeWhenPanelGroup3PrimarySpecButton)
	S:HandleCheckBox(InterfaceOptionsTellMeWhenPanelGroup4PrimarySpecButton)
	S:HandleCheckBox(InterfaceOptionsTellMeWhenPanelGroup5PrimarySpecButton)
	S:HandleCheckBox(InterfaceOptionsTellMeWhenPanelGroup6PrimarySpecButton)
	S:HandleCheckBox(InterfaceOptionsTellMeWhenPanelGroup7PrimarySpecButton)
	S:HandleCheckBox(InterfaceOptionsTellMeWhenPanelGroup8PrimarySpecButton)

	-----sec spec
	S:HandleCheckBox(InterfaceOptionsTellMeWhenPanelGroup1SecondarySpecButton)
	S:HandleCheckBox(InterfaceOptionsTellMeWhenPanelGroup2SecondarySpecButton)
	S:HandleCheckBox(InterfaceOptionsTellMeWhenPanelGroup3SecondarySpecButton)
	S:HandleCheckBox(InterfaceOptionsTellMeWhenPanelGroup4SecondarySpecButton)
	S:HandleCheckBox(InterfaceOptionsTellMeWhenPanelGroup5SecondarySpecButton)
	S:HandleCheckBox(InterfaceOptionsTellMeWhenPanelGroup6SecondarySpecButton)
	S:HandleCheckBox(InterfaceOptionsTellMeWhenPanelGroup7SecondarySpecButton)
	S:HandleCheckBox(InterfaceOptionsTellMeWhenPanelGroup8SecondarySpecButton)

end)