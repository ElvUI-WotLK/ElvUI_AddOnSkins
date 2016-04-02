local E, L, V, P, G = unpack(ElvUI);
local addon = E:GetModule("AddOnSkins");

if(not addon:CheckAddOn("TellMeWhen")) then return; end

function addon:TellMeWhen()
	TELLMEWHEN_ICONSPACING = E.Border;

	hooksecurefunc("TellMeWhen_Group_Update", function(groupID)
		local currentSpec = TellmeWhen_GetActiveTalentGroup();
		local groupName = "TellMeWhen_Group" .. groupID;
		local group = _G[groupName];

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
					if(icon) then
						icon:SetTemplate("Default");
						
						select(1, icon:GetRegions()):SetTexture("");
						
						_G[iconName .. "Texture"]:SetTexCoord(unpack(E.TexCoords));
						_G[iconName .. "Texture"]:SetInside();
						
						_G[iconName .. "Count"]:FontTemplate();
						
						_G[iconName .. "Highlight"]:SetTexture(1, 1, 1, .3);
						_G[iconName .. "Highlight"]:SetInside();
						
						if(not icon.isRegisterCooldown) then
							E:RegisterCooldown(_G[iconName .. "Cooldown"]);
							icon.isRegisterCooldown = true;
						end
					end
				end
			end
		end
	end);
end

addon:RegisterSkin("TellMeWhen", addon.TellMeWhen);