local E, L, V, P, G, _ = unpack(ElvUI)
local S = E:GetModule("Skins")

local function LoadSkin()
	if(not E.private.addOnSkins.InspectEquip) then return; end

	InspectEquip_InfoWindow:SetTemplate("Transparent")
	S:HandleCloseButton(InspectEquip_InfoWindow_CloseButton)

	S:SecureHook(InspectEquip_InfoWindow, "Show", function(self, ...)
		InspectEquip_InfoWindow:ClearAllPoints()
		InspectEquip_InfoWindow:Point("TOPLEFT", CharacterFrameCloseButton, "TOPRIGHT", 0, -3)
	end)
end

S:AddCallbackForAddon("InspectEquip", "InspectEquip", LoadSkin)