local E, L, V, P, G, _ = unpack(ElvUI);
local S = E:GetModule("Skins");
local NP = E:GetModule("NamePlates");

local function LoadSkin()
	if(not E.private.addOnSkins.PlateBuffs) then return; end

	local core = LibStub("AceAddon-3.0"):GetAddon("PlateBuffs");
	
	local function StyleAuraIcon(frame)
		if(not frame.isSkinned) then
			NP:StyleFrame(frame, true, frame.texture);

			frame.texture:SetTexCoord(unpack(E.TexCoords));

			hooksecurefunc(frame.border, "SetVertexColor", function(self, r, g, b)
				local frame = self:GetParent():GetParent();
				frame.texture.bordertop:SetTexture(r, g, b);
				frame.texture.borderbottom:SetTexture(r, g, b);
				frame.texture.borderleft:SetTexture(r, g, b);
				frame.texture.borderright:SetTexture(r, g, b);
				self:SetTexture("");
			end);
			frame.isSkinned = true;
		end
	end

	hooksecurefunc(core, "BuildBuffFrame", function(self, plate)
		local total = 1;
		if(self.buffFrames[plate][total]) then
			StyleAuraIcon(self.buffFrames[plate][total]);
		end

		local prevFrame = self.buffFrames[plate][total];
		for i = 2, self.db.profile.iconsPerBar do 
			total = total + 1;
			if(self.buffFrames[plate][total]) then
				StyleAuraIcon(self.buffFrames[plate][total]);
			end
			prevFrame = self.buffFrames[plate][total];
		end

		if(self.db.profile.numBars > 1) then
			for r = 2, self.db.profile.numBars do 
				for i = 1, self.db.profile.iconsPerBar do 
					total = total + 1;
					if(self.buffFrames[plate][total]) then
						StyleAuraIcon(self.buffFrames[plate][total]);
					end
					prevFrame = self.buffFrames[plate][total];
				end
			end
		end
	end);
end

S:AddCallbackForAddon("PlateBuffs", "PlateBuffs", LoadSkin);