local E, L, V, P, G, _ = unpack(ElvUI);
local addon = E:GetModule("AddOnSkins");

if(not addon:CheckAddOn("Skada")) then return; end

function addon:Skada()
	local displayBar = Skada.displays["bar"];
	hooksecurefunc(displayBar, "ApplySettings", function(self, win)
		local skada = win.bargroup;
		if(win.db.enabletitle) then
			skada.button:SetBackdrop(nil);
			if(not skada.button.backdrop) then
				skada.button:CreateBackdrop();
				skada.button.backdrop:SetFrameLevel(skada.button:GetFrameLevel());
			end
			if(E.db.addOnSkins.skadaTitleTemplate == "NONE") then
				skada.button.backdrop:SetBackdrop(nil);
			else
				skada.button.backdrop:SetTemplate(E.db.addOnSkins.skadaTitleTemplate, E.db.addOnSkins.skadaTitleTemplate == "Default" and E.db.addOnSkins.skadaTitleTemplateGloss or false);
			end
		end

		if(win.db.enablebackground) then
			if(E.db.addOnSkins.skadaTemplate == "NONE") then
				skada.bgframe:SetBackdrop(nil);
			else
				skada.bgframe:SetTemplate(E.db.addOnSkins.skadaTemplate, E.db.addOnSkins.skadaTemplate == "Default" and E.db.addOnSkins.skadaTemplateGloss or false);
			end
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

	local module = E:GetModule("EmbedSystem");
	hooksecurefunc(Skada, "CreateWindow", function()
		if(module:CheckAddOn("Skada")) then
			module:Skada();
		end
	end);

	hooksecurefunc(Skada, "DeleteWindow", function()
		if(module:CheckAddOn("Skada")) then
			module:Skada();
		end
	end);

	hooksecurefunc(Skada, "UpdateDisplay", function(self, force)
		if(module:CheckAddOn("Skada") and not force) then
			module:Skada();
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

addon:RegisterSkin("Skada", addon.Skada);