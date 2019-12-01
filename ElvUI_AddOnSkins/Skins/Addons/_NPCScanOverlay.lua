local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")

-- NPCScan 3.3.5.5
-- https://www.curseforge.com/wow/addons/npcscan/files/441050

local function LoadSkin()
	if not E.private.addOnSkins._NPCScanOverlay then return end

	S:HandleCheckBox(_NPCScanOverlayWorldMapToggle)
	_NPCScanOverlayWorldMapToggle:Size(24)

	local worldMapKey = _NPCScan.Overlay.Modules.List.WorldMap.KeyParent.Key

	worldMapKey:SetTemplate("Transparent")
	worldMapKey.Body:SetBackdrop(nil)
	worldMapKey.Body:DisableDrawLayer("BORDER")

	local bottomPoint
	worldMapKey:SetScript("OnEnter", function(self)
		bottomPoint = not bottomPoint
		self:ClearAllPoints()
		self:SetPoint(bottomPoint and "BOTTOMRIGHT" or "TOPRIGHT")
	end)

	worldMapKey:ClearAllPoints()
	worldMapKey:SetPoint("TOPRIGHT")
end

S:AddCallbackForAddon("_NPCScan.Overlay", "_NPCScan.Overlay", LoadSkin)