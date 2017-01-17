local E, L, V, P, G = unpack(ElvUI);
local S = E:GetModule("Skins");

local function LoadSkin()
	if(not E.private.addOnSkins.TellMeWhen) then return; end

	TELLMEWHEN_ICONSPACING = E.Border;

	hooksecurefunc("TellMeWhen_Group_Update", function(groupID)
		if(TELLMEWHEN_VERSION == "1.2.4") then
			local currentSpec = TellmeWhen_GetActiveTalentGroup();
			local groupName = "TellMeWhen_Group" .. groupID;

			local genabled = TellMeWhen_Settings["Groups"][groupID]["Enabled"];
			local rows = TellMeWhen_Settings["Groups"][groupID]["Rows"];
			local columns = TellMeWhen_Settings["Groups"][groupID]["Columns"];
			local activePriSpec = TellMeWhen_Settings["Groups"][groupID]["PrimarySpec"];
			local activeSecSpec = TellMeWhen_Settings["Groups"][groupID]["SecondarySpec"];

			if((currentSpec == 1 and not activePriSpec) or (currentSpec == 2 and not activeSecSpec)) then
				genabled = false;
			end

			if (genabled) then
				for row = 1, rows do
					for column = 1, columns do
						local iconID = (row-1)*columns + column;
						local iconName = groupName .. "_Icon" .. iconID;
						local icon = _G[iconName]
						if(icon and not icon.isSkinned) then
							icon:SetTemplate("Default");

							select(1, icon:GetRegions()):SetTexture("");

							_G[iconName .. "Texture"]:SetTexCoord(unpack(E.TexCoords));
							_G[iconName .. "Texture"]:SetInside();

							_G[iconName .. "Count"]:FontTemplate();

							_G[iconName .. "Highlight"]:SetTexture(1, 1, 1, .3);
							_G[iconName .. "Highlight"]:SetInside();

							E:RegisterCooldown(_G[iconName .. "Cooldown"]);
							icon.isSkinned = true;
						end
					end
				end
			end
		else
			local group = _G["TellMeWhen_Group" .. groupID];
			if (group.Enabled) then
				for row = 1, group.Rows do
					for column = 1, group.Columns do
						local iconID = (row-1)*group.Columns + column;
						local iconName = group.groupName .. "_Icon" .. iconID;
						local icon = _G[iconName];
						if(icon and not icon.isSkinned) then
							_G[iconName]:StyleButton();
							icon:SetTemplate("Default");

							select(1, icon:GetRegions()):SetTexture("");

							_G[iconName .. "Icon"]:SetTexCoord(unpack(E.TexCoords));
							_G[iconName .. "Icon"]:SetInside();

							_G[iconName .. "Count"]:FontTemplate();

							E:RegisterCooldown(_G[iconName .. "Cooldown"]);
							icon.isSkinned = true;
						end
					end
				end
			end
		end
	end);
end

S:AddCallbackForAddon("TellMeWhen", "TellMeWhen", LoadSkin);