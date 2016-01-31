local E, L, V, P, G, _ = unpack(ElvUI);
local addon = E:GetModule("AddOnSkins");

if(not addon:CheckAddOn("Skada")) then return; end

function addon:Skada()
	local displayBar = Skada.displays["bar"];
	hooksecurefunc(displayBar, "ApplySettings", function(self, win)
		local skada = win.bargroup;
		skada:SetFrameLevel(5);
		
		if(win.db.enabletitle) then
			skada.button:SetTemplate("Default", true);
		end
		
		if(win.db.enablebackground) then
			skada.bgframe:SetTemplate(E.db.addOnSkins.skadaTemplate, E.db.addOnSkins.skadaTemplateGloss);
			if(skada.bgframe) then
				skada.bgframe:ClearAllPoints();
				if(win.db.reversegrowth) then
					skada.bgframe:SetPoint("LEFT", skada.button, "LEFT", 0, 0);
					skada.bgframe:SetPoint("RIGHT", skada.button, "RIGHT", 0, 0);
					skada.bgframe:SetPoint("BOTTOM", skada.button, "TOP", 0, win.db.enabletitle and (E.PixelMode and 1 or 3) or -win.db.barheight);
				else
					skada.bgframe:SetPoint("LEFT", skada.button, "LEFT", 0, 0);
					skada.bgframe:SetPoint("RIGHT", skada.button, "RIGHT", 0, 0);
					skada.bgframe:SetPoint("TOP", skada.button, "BOTTOM", 0, win.db.enabletitle and -(E.PixelMode and 1 or 3) or win.db.barheight);
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
	
	hooksecurefunc(Skada, "UpdateDisplay", function()
		if(module:CheckAddOn("Skada") and not InCombatLockdown()) then
			module:Skada();
		end
	end);
end

addon:RegisterSkin("Skada", addon.Skada);