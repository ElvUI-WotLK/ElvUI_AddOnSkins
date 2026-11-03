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

if not AS:IsAddonLODorEnabled("_NPCScan.Overlay") then return end

-- NPCScan Overlay 3.3.5.1
-- https://www.curseforge.com/wow/addons/npcscan-overlay/files/434851

S:AddCallbackForAddon("_NPCScan.Overlay", "_NPCScan.Overlay", function()
	if not E.private.addOnSkins._NPCScanOverlay then return end

	SkinControl("HandleCheckBox", _NPCScanOverlayWorldMapToggle)
	SkinFrame(_NPCScanOverlayWorldMapToggle, "Size", 24)

	local worldMapKey = _NPCScan.Overlay.Modules.List.WorldMap.KeyParent.Key

	SkinFrame(worldMapKey, "SetTemplate", "Transparent")
	worldMapKey.Body:SetBackdrop(nil)
	worldMapKey.Body:DisableDrawLayer("BORDER")

	local bottomPoint
	SkinFrame(worldMapKey, "SetScript", "OnEnter", function(self)
		bottomPoint = not bottomPoint
		SkinFrame(self, "ClearAllPoints")
		if bottomPoint then
			SkinFrame(self, "Point", "BOTTOMRIGHT", 1, -1)
		else
			SkinFrame(self, "Point", "TOPRIGHT", 1, 1)
		end
	end)

	SkinFrame(worldMapKey, "ClearAllPoints")
	SkinFrame(worldMapKey, "Point", "TOPRIGHT", 1, 1)
end)
