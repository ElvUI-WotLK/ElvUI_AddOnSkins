local E, L, V, P, G, _ = unpack(ElvUI);
local addon = E:GetModule("AddOnSkins");

if(not addon:CheckAddOn("Omen")) then return; end

function addon:Omen()
	Omen.db.profile.Bar.Spacing = 1;
	Omen.db.profile.Background.EdgeSize = 1;
	Omen.db.profile.Background.BarInset = 2;
	Omen.db.profile.TitleBar.UseSameBG = true;
	Omen.db.profile.TitleBar.Height = 22;

	addon:SecureHook(Omen, "UpdateBackdrop", function(self)
		self.Title:SetTemplate("Default", true);
		self.BarList:SetTemplate("Default");
	end);

	addon:SecureHook(Omen, "UpdateTitleBar", function(self)
		self.BarList:ClearAllPoints();
		if(not Omen.db.profile.TitleBar.ShowTitleBar) then
			self.BarList:SetPoint("TOPLEFT", self.Title, "BOTTOMLEFT", 0, 0);
		else
			self.BarList:SetPoint("TOPLEFT", self.Title, "BOTTOMLEFT", 0, -(E.PixelMode and 1 or 3));
		end
		self.BarList:SetPoint("BOTTOMRIGHT", self.Anchor, "BOTTOMRIGHT", 0, 0);
	end);
end

addon:RegisterSkin("Omen", addon.Omen);