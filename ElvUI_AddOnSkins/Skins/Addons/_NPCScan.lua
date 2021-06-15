local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

if not AS:IsAddonLODorEnabled("_NPCScan") then return end

-- NPCScan 3.3.5.5
-- https://www.curseforge.com/wow/addons/npcscan/files/441050

S:AddCallbackForAddon("_NPCScan", "_NPCScan", function()
	if not E.private.addOnSkins._NPCScan then return end

	_NPCScanButton:SetScale(1)
	_NPCScanButton.SetScale = E.noop

	_NPCScanButton:StripTextures()
	_NPCScanButton:SetTemplate("Default", true)

	_NPCScanButton:HookScript("OnEnter", S.SetModifiedBackdrop)
	_NPCScanButton:HookScript("OnLeave", S.SetOriginalBackdrop)

	for i = 1, _NPCScanButton:GetNumChildren() do
		local child = select(i, _NPCScanButton:GetChildren())
		if child and child:IsObjectType("Button") then
			S:HandleCloseButton(child)
			child:ClearAllPoints()
			child:Point("TOPRIGHT", _NPCScanButton, "TOPRIGHT", 4, 5)
			child:SetScale(1)
		end
	end

	local NPCFoundText = select(4, _NPCScanButton:GetRegions())
	NPCFoundText:SetTextColor(1, 1, 1, 1)
	NPCFoundText:SetShadowOffset(1, -1)
end)