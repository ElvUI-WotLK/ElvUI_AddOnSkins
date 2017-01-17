local E, L, V, P, G, _ = unpack(ElvUI)
local S = E:GetModule("Skins")

local function LoadSkin()
	if(not E.private.addOnSkins.InspectEquip) then return; end

	InspectEquip_InfoWindow:SetTemplate("Transparent")
	S:HandleCloseButton(InspectEquip_InfoWindow_CloseButton)

	S:SecureHook(InspectEquip, "SetParent", function(self, frame)
		InspectEquip_InfoWindow:ClearAllPoints()
		InspectEquip_InfoWindow:Point("TOPLEFT", _G[frame:GetName() .. "CloseButton"], "TOPRIGHT", 0, -3)
	end)
end

S:AddCallbackForAddon("InspectEquip", "InspectEquip", LoadSkin)