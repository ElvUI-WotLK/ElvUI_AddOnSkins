local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

if not AS:IsAddonLODorEnabled("InspectEquip") then return end

-- InspectEquip 1.7.7
-- https://www.wowace.com/projects/inspect-equip/files/436507

S:AddCallbackForAddon("InspectEquip", "InspectEquip", function()
	if not E.private.addOnSkins.InspectEquip then return end

	InspectEquip_InfoWindow:SetTemplate("Transparent")
	S:HandleCloseButton(InspectEquip_InfoWindow_CloseButton, InspectEquip_InfoWindow)

	S:SecureHook(InspectEquip, "SetParent", function(self, frame)
		InspectEquip_InfoWindow:ClearAllPoints()
		InspectEquip_InfoWindow:Point("TOPLEFT", _G[frame:GetName() .. "CloseButton"], "TOPRIGHT", -3, -3)
	end)

	GearManagerDialogPopup:HookScript("OnShow", function()
		InspectEquip_InfoWindow:Hide()
	end)

	GearManagerDialogPopup:HookScript("OnHide", function()
		if not GearManagerDialog:IsShown() then
			InspectEquip_InfoWindow:Show()
		end
	end)
end)