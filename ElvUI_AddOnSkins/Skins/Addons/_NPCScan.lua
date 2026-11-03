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

if not AS:IsAddonLODorEnabled("_NPCScan") then return end

-- NPCScan 3.3.5.5
-- https://www.curseforge.com/wow/addons/npcscan/files/441050

S:AddCallbackForAddon("_NPCScan", "_NPCScan", function()
	if not E.private.addOnSkins._NPCScan then return end

	SkinFrame(_NPCScanButton, "SetScale", 1)
	_NPCScanButton.SetScale = E.noop

	SkinFrame(_NPCScanButton, "StripTextures")
	SkinFrame(_NPCScanButton, "SetTemplate", "Default", true)

	SkinFrame(_NPCScanButton, "HookScript", "OnEnter", S.SetModifiedBackdrop)
	SkinFrame(_NPCScanButton, "HookScript", "OnLeave", S.SetOriginalBackdrop)

	for i = 1, _NPCScanButton:GetNumChildren() do
		local child = select(i, _NPCScanButton:GetChildren())
		if child and child:IsObjectType("Button") then
			SkinControl("HandleCloseButton", child)
			SkinFrame(child, "ClearAllPoints")
			SkinFrame(child, "Point", "TOPRIGHT", _NPCScanButton, "TOPRIGHT", 4, 5)
			SkinFrame(child, "SetScale", 1)
		end
	end

	local NPCFoundText = select(4, _NPCScanButton:GetRegions())
	SkinFrame(NPCFoundText, "SetTextColor", 1, 1, 1, 1)
	NPCFoundText:SetShadowOffset(1, -1)
end)
