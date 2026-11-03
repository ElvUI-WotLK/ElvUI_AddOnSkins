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

if not AS:IsAddonLODorEnabled("ACP") then return end

local _G = _G

-- Addon Control Panel 3.3.7
-- https://www.curseforge.com/wow/addons/acp/files/453071

S:AddCallbackForAddon("ACP", "ACP", function()
	if not E.private.addOnSkins.ACP then return end

	SkinControl("HandleButton", GameMenuButtonAddOns)

	ACP_AddonList:SetParent(UIParent)
	SkinFrame(ACP_AddonList, "SetFrameStrata", "HIGH")
	ACP_AddonList:SetHitRectInsets(0, 0, 0, 0)

	SkinFrame(ACP_AddonList, "StripTextures")
	SkinFrame(ACP_AddonList, "SetTemplate", "Transparent")
	SkinFrame(ACP_AddonList, "Size", 580, 488)

	SkinControl("HandleCloseButton", ACP_AddonListCloseButton, ACP_AddonList)

	SkinControl("HandleDropDownBox", ACP_AddonListSortDropDown, 145)
	SkinFrame(ACP_AddonListSortDropDown, "Point", "TOPLEFT", 50, -5)

	SkinFrame(ACP_AddonListCollapseAll, "Point", "TOPLEFT", 12, -17)
	SkinFrame(ACP_AddonListEntry1, "Point", "TOPLEFT", 29, -44)

	SkinFrame(ACP_AddonList_ScrollFrame, "StripTextures")
	SkinFrame(ACP_AddonList_ScrollFrame, "SetTemplate", "Transparent")
	SkinFrame(ACP_AddonList_ScrollFrame, "Size", 543, 414)
	SkinFrame(ACP_AddonList_ScrollFrame, "Point", "TOPLEFT", 8, -35)

	SkinControl("HandleScrollBar", ACP_AddonList_ScrollFrameScrollBar)
	SkinFrame(ACP_AddonList_ScrollFrameScrollBar, "Point", "TOPLEFT", ACP_AddonList_ScrollFrame, "TOPRIGHT", 3, -19)
	SkinFrame(ACP_AddonList_ScrollFrameScrollBar, "Point", "BOTTOMLEFT", ACP_AddonList_ScrollFrame, "BOTTOMRIGHT", 3, 19)

	SkinControl("HandleButton", ACP_AddonListSetButton)
	SkinControl("HandleButton", ACP_AddonListDisableAll)
	SkinControl("HandleButton", ACP_AddonListEnableAll)
	SkinControl("HandleButton", ACP_AddonList_ReloadUI)
	SkinControl("HandleButton", ACP_AddonListBottomClose)

	SkinControl("HandleCheckBox", ACP_AddonList_NoRecurse)

	SkinFrame(ACP_AddonListSetButton, "Point", "BOTTOMLEFT", 8, 8)
	SkinFrame(ACP_AddonListDisableAll, "Point", "BOTTOMLEFT", 78, 8)
	SkinFrame(ACP_AddonListEnableAll, "Point", "BOTTOMLEFT", 163, 8)
	SkinFrame(ACP_AddonList_ReloadUI, "Point", "BOTTOMRIGHT", -121, 8)
	SkinFrame(ACP_AddonListBottomClose, "Point", "BOTTOMRIGHT", -8, 8)

	local function collapseSetTexture(self, texture)
		if texture == "Interface\\Minimap\\UI-Minimap-ZoomInButton-Up" then
			self:_SetTexture(E.Media.Textures.Plus)
		else
			self:_SetTexture(E.Media.Textures.Minus)
		end
	end

	local function skinCollapseIcon(frame)
		frame:SetTexture(E.Media.Textures.Minus)

		frame._SetTexture = frame.SetTexture
		frame.SetTexture = collapseSetTexture
	end

	local function updateCheckboxSize(self, size)
		if size == 32 then
			SkinFrame(self, "Size", 24)
		else
			SkinFrame(self, "Size", 20)
		end
	end

	skinCollapseIcon(ACP_AddonListCollapseAllIcon)

	for i = 1, 20 do
		local checkbox = _G["ACP_AddonListEntry" .. i.. "Enabled"]
		SkinControl("HandleCheckBox", checkbox)
		checkbox.SetHeight = updateCheckboxSize

		skinCollapseIcon(_G["ACP_AddonListEntry" .. i.. "CollapseIcon"])

		SkinControl("HandleButton", _G["ACP_AddonListEntry" .. i .. "LoadNow"])
	end
end)
