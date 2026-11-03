local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
-- Optional controls differ between supported addon versions. Keep missing
-- targets out of native skin handlers without masking other Lua errors.
local function SkinControl(method, frame, ...)
	if frame then return S[method](S, frame, ...) end
end
local function SkinFrame(frame, method, ...)
	if frame then return frame[method](frame, ...) end
end

local AS = E:GetModule("AddOnSkins")

if not AS:IsAddonLODorEnabled("FloAspectBar") then return end

local _G = _G
local unpack = unpack

-- FloAspectBar 3.3.0.16
-- https://www.curseforge.com/wow/addons/flo-aspect-bar/files/399320

S:AddCallbackForAddon("FloAspectBar", "FloAspectBar", function()
	if not E.private.addOnSkins.FloAspectBar then return end

	if E.myclass ~= "HUNTER" then return end

	local AB = E:GetModule("ActionBars")

	if not S:IsHooked("FloLib_ShowBorders") then
		S:RawHook("FloLib_ShowBorders", function(self)
			if self.globalSettings.borders then
				if not self.template then
					SkinFrame(self, "SetTemplate", "Transparent")
				end
				if self.settings and self.settings.color then
					SkinFrame(self, "SetBackdropBorderColor", unpack(self.settings.color))
				end
			else
				SkinFrame(self, "SetBackdrop", nil)
				self.template = nil
			end
		end)
	end

	FloAspectBar:SetClampedToScreen(true)

	FloLib_ShowBorders(FloAspectBar)

	for i = 1, 10 do
		SkinFrame(AB, "StyleButton", _G["FloAspectBarButton" .. i])
	end
end)
