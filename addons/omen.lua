local E, L, V, P, G, _ = unpack(ElvUI);
local S = E:GetModule("Skins");

local function LoadSkin()
	if(not E.private.addOnSkins.Omen) then return; end

	hooksecurefunc(Omen, "UpdateBars", function(self)
		self.TitleText:Width(self.Title:GetWidth() - 16);
		self.TitleText:Height(16);
	end);

	hooksecurefunc(Omen, "UpdateBackdrop", function(self)
		self.Title:SetTemplate("Default", true);
		self.BarList:SetTemplate("Default");
	end);

	hooksecurefunc(Omen, "UpdateTitleBar", function(self)
		self.BarList:ClearAllPoints();
		if(not Omen.db.profile.TitleBar.ShowTitleBar) then
			self.BarList:Point("TOPLEFT", self.Title, "BOTTOMLEFT", 0, 0);
		else
			self.BarList:Point("TOPLEFT", self.Title, "BOTTOMLEFT", 0, -(E.PixelMode and 1 or 3));
		end
		self.BarList:Point("BOTTOMRIGHT", self.Anchor, "BOTTOMRIGHT", 0, 0);
	end);
end

S:AddCallbackForAddon("Omen", "Omen", LoadSkin);