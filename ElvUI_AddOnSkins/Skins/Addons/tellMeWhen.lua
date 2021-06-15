local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

if not AS:IsAddonLODorEnabled("TellMeWhen") then return end

local _G = _G
local unpack = unpack

-- TellMeWhen 1.2.5b1
-- https://www.curseforge.com/wow/addons/tellmewhen/files/448968

S:AddCallbackForAddon("TellMeWhen", "TellMeWhen", function()
	if not E.private.addOnSkins.TellMeWhen then return end

	TELLMEWHEN_ICONSPACING = E.Border

	if TELLMEWHEN_VERSION == "1.2.4" then
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
end)