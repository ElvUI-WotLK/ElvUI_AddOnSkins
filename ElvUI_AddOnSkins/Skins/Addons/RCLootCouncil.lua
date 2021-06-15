local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

if not AS:IsAddonLODorEnabled("RCLootCouncil") then return end

-- RCLootCouncil 2.0.4
-- https://github.com/ajseward/RcLootCouncil-Wotlk

S:AddCallbackForAddon("RCLootCouncil", "RCLootCouncil", function()
	if not E.private.addOnSkins.RCLootCouncil then return end

	local addon = LibStub("AceAddon-3.0"):GetAddon("RCLootCouncil", true)
	if not addon then return end

	AS:SkinLibrary("DropDownMenu")
	AS:SkinLibrary("LibDialog-1.0")
	AS:SkinLibrary("ScrollingTable")

	S:RawHook(addon, "CreateFrame", function(self, ...)
		local frame = S.hooks[self].CreateFrame(self, ...)

		frame:SetScale(UIParent:GetScale())
		frame.title:SetTemplate("Default")
		frame.content:SetTemplate("Transparent")

		frame.title:SetFrameLevel(frame:GetFrameLevel() + 3)

		return frame
	end)

	S:RawHook(addon, "CreateButton", function(self, ...)
		local button = S.hooks[self].CreateButton(self, ...)

		S:HandleButton(button)

		return button
	end)

	local function updateTexCoord(self)
		local normalTexture = self:GetNormalTexture()
		normalTexture:SetTexCoord(unpack(E.TexCoords))
		normalTexture:SetInside()
	end

	local function skinIconButton(button)
		button:SetTemplate()
		button:StyleButton(nil, true, true)
		button:GetNormalTexture():SetDrawLayer("ARTWORK")
		hooksecurefunc(button, "SetNormalTexture", updateTexCoord)
	end

	local votingFrame = addon:GetModule("RCVotingFrame", true)
	if votingFrame then
		local function moreInfoSetTexture(self, texture)
			local normalTexture = self:GetNormalTexture()
			local pushedTexture = self:GetPushedTexture()

			local arrowDir = texture == "Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Up" and "left" or "right"
			normalTexture:SetRotation(S.ArrowRotation[arrowDir])
			pushedTexture:SetRotation(S.ArrowRotation[arrowDir])
		end

		local function setBackdropBorderColor(self, r, g, b)
			if r == 1 and g == 1 and b == 1 then
				self:SetBackdropBorderColor(unpack(E.media.bordercolor))
			end
		end

		S:RawHook(votingFrame, "GetFrame", function(self, ...)
			local frame = S.hooks[self].GetFrame(self, ...)
			S:Unhook(self, "GetFrame")

			skinIconButton(frame.itemIcon)

			S:HandleNextPrevButton(frame.moreInfoBtn, "right")

			frame.moreInfoBtn.SetNormalTexture = moreInfoSetTexture
			frame.moreInfoBtn.SetPushedTexture = E.noop

			E:GetModule("Tooltip"):HookScript(frame.moreInfo, "OnShow", "SetStyle")

			frame.filter:HookScript("OnEnter", S.SetModifiedBackdrop)
			frame.filter:HookScript("OnLeave", S.SetOriginalBackdrop)

			return frame
		end)

		S:RawHook(votingFrame, "UpdateSessionButton", function(self, ...)
			local button = S.hooks[self].UpdateSessionButton(self, ...)

			if not button.isSkinned then
				hooksecurefunc(button, "SetBackdropBorderColor", setBackdropBorderColor)
				skinIconButton(button)
				button.SetBackdrop = E.noop
				button.isSkinned = true
			end

			return button
		end)
	end

	local lootFrame = addon:GetModule("RCLootFrame", true)
	if lootFrame then
		local function updateTexCoord(self)
			self.icon:GetNormalTexture():SetTexCoord(unpack(E.TexCoords))
		end

		S:RawHook(lootFrame, "GetEntry", function(self, ...)
			local frame = S.hooks[self].GetEntry(self, ...)

			frame:SetTemplate("Transparent")
			skinIconButton(frame.icon)
			hooksecurefunc(frame, "Show", updateTexCoord)

			return frame
		end)
	end

	local sessionFrame = addon:GetModule("RCSessionFrame", true)
	if sessionFrame then
		S:RawHook(sessionFrame, "GetFrame", function(self, ...)
			local frame = S.hooks[self].GetFrame(self, ...)
			S:Unhook(self, "GetFrame")

			S:HandleCheckBox(frame.toggle)

			return frame
		end)

		S:SecureHook(sessionFrame, "SetCellItemIcon", function(_, frame)
			frame:SetTemplate()
			frame:StyleButton(nil, true, true)
			local normalTexture = frame:GetNormalTexture()
			normalTexture:SetDrawLayer("ARTWORK")
			normalTexture:SetTexCoord(unpack(E.TexCoords))
			normalTexture:SetInside()
		end)
	end
end)