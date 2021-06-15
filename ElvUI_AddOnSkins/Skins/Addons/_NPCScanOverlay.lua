local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

if not AS:IsAddonLODorEnabled("_NPCScan.Overlay") then return end

-- NPCScan Overlay 3.3.5.1
-- https://www.curseforge.com/wow/addons/npcscan-overlay/files/434851

S:AddCallbackForAddon("_NPCScan.Overlay", "_NPCScan.Overlay", function()
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
		if bottomPoint then
			self:Point("BOTTOMRIGHT", 1, -1)
		else
			self:Point("TOPRIGHT", 1, 1)
		end
	end)

	worldMapKey:ClearAllPoints()
	worldMapKey:Point("TOPRIGHT", 1, 1)
end)