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

if not AS:IsAddonLODorEnabled("InspectEquip") then return end

-- InspectEquip 1.7.7
-- https://www.wowace.com/projects/inspect-equip/files/436507

S:AddCallbackForAddon("InspectEquip", "InspectEquip", function()
	if not E.private.addOnSkins.InspectEquip then return end

	SkinFrame(InspectEquip_InfoWindow, "SetTemplate", "Transparent")
	SkinControl("HandleCloseButton", InspectEquip_InfoWindow_CloseButton, InspectEquip_InfoWindow)

	S:SecureHook(InspectEquip, "SetParent", function(self, frame)
		SkinFrame(InspectEquip_InfoWindow, "ClearAllPoints")
		SkinFrame(InspectEquip_InfoWindow, "Point", "TOPLEFT", _G[frame:GetName() .. "CloseButton"], "TOPRIGHT", -3, -3)
	end)

	SkinFrame(GearManagerDialogPopup, "HookScript", "OnShow", function()
		SkinFrame(InspectEquip_InfoWindow, "Hide")
	end)

	SkinFrame(GearManagerDialogPopup, "HookScript", "OnHide", function()
		if not GearManagerDialog:IsShown() then
			SkinFrame(InspectEquip_InfoWindow, "Show")
		end
	end)
end)
