local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

if not AS:IsAddonLODorEnabled("CLCRet") then return end

local _G = _G
local unpack = unpack

-- CLCRet 1.3.03.025
-- https://www.curseforge.com/wow/addons/clcret/files/439502

S:AddCallbackForAddon("CLCRet", "CLCRet", function()
	if not E.private.addOnSkins.CLCRet then return end

	local function styleButton(button, icon, height, width)
		button:SetScale(1)
		button:Size(width or height, height)

		icon:SetTexCoord(unpack(E.TexCoords))
		button.border:Hide()
	end

	S:RawHook(clcret, "CreateButton", function(self, name, size, ...)
		local button = S.hooks[self].CreateButton(self, name, size, ...)

		button:CreateBackdrop("Default")
		button.texture:SetDrawLayer("BORDER")

		styleButton(button, button.texture, size)

		return button
	end)

	hooksecurefunc(clcret, "UpdateButtonLayout", function(self, button, opt)
		styleButton(button, button.texture, opt.size)
	end)

	S:RawHook(clcret, "CreateSovBar", function(self, ...)
		local frame = S.hooks[self].CreateSovBar(self, ...)

		frame:CreateBackdrop("Default")
		frame.icon:CreateBackdrop("Default")
		frame.icon:SetDrawLayer("BORDER")
		frame.icon.backdrop:Hide()

		frame.bgtexture:SetTexture(nil)
		frame.texture:SetTexture(E.media.normTex)
		E:RegisterStatusBar(frame.texture)

		styleButton(frame, frame.icon, self.db.profile.sov.height)

		return frame
	end)

	local MAX_SOVBARS = 5

	hooksecurefunc(clcret, "UpdateSovBarsLayout", function(self)
		local db = self.db.profile.sov
		local bar

		for i = 1, MAX_SOVBARS do
			bar = _G["clcretSovBar"..i]

			styleButton(bar, bar.icon, db.height, db.useButtons and db.height or (db.width - db.height))

			if db.useButtons then
				bar.icon.backdrop:Hide()
			else
				bar.icon.backdrop:Show()
				bar.icon:Point("RIGHT", bar, "LEFT", -1, 0)
			end
		end
	end)

	S:SecureHook(clcret, "InitSwingBar", function(self)
		local frame = clcretswingBar

		frame:CreateBackdrop("Default")

		frame.bgtexture:SetTexture(nil)
		frame.texture:SetTexture(E.media.normTex)
		E:RegisterStatusBar(frame.texture)

		S:Unhook(self, "InitSwingBar")
	end)

end)