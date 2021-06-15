local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

if not AS:IsAddonLODorEnabled("PlateBuffs") then return end

local unpack = unpack

local hooksecurefunc = hooksecurefunc

-- PlateBuffs 1.5.4
-- https://www.wowace.com/projects/platebuffs/files/447971

S:AddCallbackForAddon("PlateBuffs", "PlateBuffs", function()
	if not E.private.addOnSkins.PlateBuffs then return end

	local core = LibStub("AceAddon-3.0"):GetAddon("PlateBuffs", true)
	if not core then return end

	local NP = E:GetModule("NamePlates")

	local buffBars = core.buffBars
	local buffFrames = core.buffFrames

	local function StyleAuraIcon(frame)
		if not frame.isSkinned then
			NP:StyleFrame(frame, true, frame.texture)

			frame.texture:SetTexCoord(unpack(E.TexCoords))
			frame.cdbg.Show = E.noop
			frame.cdbg:Hide()

			hooksecurefunc(frame.border, "SetVertexColor", function(self, r, g, b)
				local parent = self:GetParent():GetParent()
				parent.texture.bordertop:SetTexture(r, g, b)
				parent.texture.borderbottom:SetTexture(r, g, b)
				parent.texture.borderleft:SetTexture(r, g, b)
				parent.texture.borderright:SetTexture(r, g, b)
				self:SetTexture(nil)
			end)

			frame.isSkinned = true
		end
	end

	hooksecurefunc(core, "BuildBuffFrame", function(self, plate)
		local total = 1
		if buffFrames[plate][total] then
			StyleAuraIcon(buffFrames[plate][total])
		end

		local prevFrame = buffFrames[plate][total]
		for i = 2, self.db.profile.iconsPerBar do
			total = total + 1

			if buffFrames[plate][total] then
				StyleAuraIcon(buffFrames[plate][total])
				buffFrames[plate][total]:ClearAllPoints()
				buffFrames[plate][total]:SetPoint("BOTTOMLEFT", prevFrame, "BOTTOMRIGHT", E.Border + E.Spacing*3, 0)
			end

			prevFrame = self.buffFrames[plate][total]
		end

		if self.db.profile.numBars > 1 then
			for r = 2, self.db.profile.numBars do
				for i = 1, self.db.profile.iconsPerBar do
					total = total + 1

					if buffFrames[plate][total] then
						StyleAuraIcon(buffFrames[plate][total])
						buffFrames[plate][total]:ClearAllPoints()
						if i == 1 then
							buffFrames[plate][total]:SetPoint("BOTTOMLEFT", buffBars[plate][r], E.Border + E.Spacing*3, 0)
						else
							buffFrames[plate][total]:SetPoint("BOTTOMLEFT", prevFrame, "BOTTOMRIGHT", E.Border + E.Spacing*3, 0)
						end
					end

					prevFrame = buffFrames[plate][total]
				end
			end
		end
	end)
end)