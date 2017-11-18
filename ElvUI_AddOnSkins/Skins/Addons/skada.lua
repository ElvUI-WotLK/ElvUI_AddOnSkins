local E, L, V, P, G, _ = unpack(ElvUI);
local S = E:GetModule("Skins");

local function LoadSkin()
	if(not E.private.addOnSkins.Skada) then return; end

	local displayBar = Skada.displays["bar"];
	hooksecurefunc(displayBar, "ApplySettings", function(_, win)
		local skada = win.bargroup;
		if(win.db.enabletitle) then
			skada.button:SetBackdrop(nil);
			if(not skada.button.backdrop) then
				skada.button:CreateBackdrop();
				skada.button.backdrop:SetFrameLevel(skada.button:GetFrameLevel());
			end
			skada.button.backdrop:SetTemplate(E.db.addOnSkins.skadaTitleTemplate, E.db.addOnSkins.skadaTitleTemplate == "Default" and E.db.addOnSkins.skadaTitleTemplateGloss or false);
		end

		if(win.db.enablebackground) then
			skada.bgframe:SetTemplate(E.db.addOnSkins.skadaTemplate, E.db.addOnSkins.skadaTemplate == "Default" and E.db.addOnSkins.skadaTemplateGloss or false);
			if(skada.bgframe) then
				skada.bgframe:ClearAllPoints();
				if(win.db.reversegrowth) then
					skada.bgframe:SetPoint("LEFT", skada.button, "LEFT", -E.Border, 0);
					skada.bgframe:SetPoint("RIGHT", skada.button, "RIGHT", E.Border, 0);
					skada.bgframe:SetPoint("BOTTOM", skada.button, "TOP", 0, win.db.enabletitle and E.Spacing or -win.db.barheight - E.Border);
				else
					skada.bgframe:SetPoint("LEFT", skada.button, "LEFT", -E.Border, 0);
					skada.bgframe:SetPoint("RIGHT", skada.button, "RIGHT", E.Border, 0);
					skada.bgframe:SetPoint("TOP", skada.button, "BOTTOM", 0, win.db.enabletitle and -E.Spacing or win.db.barheight + E.Border);
				end
			end
		end
	end);

	local EMB = E:GetModule("EmbedSystem")
	hooksecurefunc(Skada, "CreateWindow", function()
		if EMB:CheckEmbed("Skada") then
			EMB:EmbedSkada()
		end
	end);

	hooksecurefunc(Skada, "DeleteWindow", function()
		if EMB:CheckEmbed("Skada") then
			EMB:EmbedSkada()
		end
	end);

	hooksecurefunc(Skada, "SetTooltipPosition", function(self, tt, frame)
		local p = self.db.profile.tooltippos;
		if(p == "default") then
			if(not E:HasMoverBeenMoved("TooltipMover")) then
				if(ElvUI_ContainerFrame and ElvUI_ContainerFrame:IsShown()) then
					tt:SetPoint("BOTTOMRIGHT", ElvUI_ContainerFrame, "TOPRIGHT", 0, 18);
				elseif(RightChatPanel:GetAlpha() == 1 and RightChatPanel:IsShown()) then
					tt:SetPoint("BOTTOMRIGHT", RightChatPanel, "TOPRIGHT", 0, 18);
				else
					tt:SetPoint("BOTTOMRIGHT", RightChatPanel, "BOTTOMRIGHT", 0, 18);
				end
			else
				local point = E:GetScreenQuadrant(TooltipMover);
				if(point == "TOPLEFT") then
					tt:SetPoint("TOPLEFT", TooltipMover);
				elseif(point == "TOPRIGHT") then
					tt:SetPoint("TOPRIGHT", TooltipMover);
				elseif(point == "BOTTOMLEFT" or point == "LEFT") then
					tt:SetPoint("BOTTOMLEFT", TooltipMover);
				else
					tt:SetPoint("BOTTOMRIGHT", TooltipMover);
				end
			end
		end
	end);
end

S:AddCallbackForAddon("Skada", "Skada", LoadSkin);