local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

if not AS:IsAddonLODorEnabled("ACP") then return end

local _G = _G

-- Addon Control Panel 3.3.7
-- https://www.curseforge.com/wow/addons/acp/files/453071

S:AddCallbackForAddon("ACP", "ACP", function()
	if not E.private.addOnSkins.ACP then return end

	S:HandleButton(GameMenuButtonAddOns)

	ACP_AddonList:SetParent(UIParent)
	ACP_AddonList:SetFrameStrata("HIGH")
	ACP_AddonList:SetHitRectInsets(0, 0, 0, 0)

	ACP_AddonList:StripTextures()
	ACP_AddonList:SetTemplate("Transparent")
	ACP_AddonList:Size(580, 488)

	S:HandleCloseButton(ACP_AddonListCloseButton, ACP_AddonList)

	S:HandleDropDownBox(ACP_AddonListSortDropDown, 145)
	ACP_AddonListSortDropDown:Point("TOPLEFT", 50, -5)

	ACP_AddonListCollapseAll:Point("TOPLEFT", 12, -17)
	ACP_AddonListEntry1:Point("TOPLEFT", 29, -44)

	ACP_AddonList_ScrollFrame:StripTextures()
	ACP_AddonList_ScrollFrame:SetTemplate("Transparent")
	ACP_AddonList_ScrollFrame:Size(543, 414)
	ACP_AddonList_ScrollFrame:Point("TOPLEFT", 8, -35)

	S:HandleScrollBar(ACP_AddonList_ScrollFrameScrollBar)
	ACP_AddonList_ScrollFrameScrollBar:Point("TOPLEFT", ACP_AddonList_ScrollFrame, "TOPRIGHT", 3, -19)
	ACP_AddonList_ScrollFrameScrollBar:Point("BOTTOMLEFT", ACP_AddonList_ScrollFrame, "BOTTOMRIGHT", 3, 19)

	S:HandleButton(ACP_AddonListSetButton)
	S:HandleButton(ACP_AddonListDisableAll)
	S:HandleButton(ACP_AddonListEnableAll)
	S:HandleButton(ACP_AddonList_ReloadUI)
	S:HandleButton(ACP_AddonListBottomClose)

	S:HandleCheckBox(ACP_AddonList_NoRecurse)

	ACP_AddonListSetButton:Point("BOTTOMLEFT", 8, 8)
	ACP_AddonListDisableAll:Point("BOTTOMLEFT", 78, 8)
	ACP_AddonListEnableAll:Point("BOTTOMLEFT", 163, 8)
	ACP_AddonList_ReloadUI:Point("BOTTOMRIGHT", -121, 8)
	ACP_AddonListBottomClose:Point("BOTTOMRIGHT", -8, 8)

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
			self:Size(24)
		else
			self:Size(20)
		end
	end

	skinCollapseIcon(ACP_AddonListCollapseAllIcon)

	for i = 1, 20 do
		local checkbox = _G["ACP_AddonListEntry" .. i.. "Enabled"]
		S:HandleCheckBox(checkbox)
		checkbox.SetHeight = updateCheckboxSize

		skinCollapseIcon(_G["ACP_AddonListEntry" .. i.. "CollapseIcon"])

		S:HandleButton(_G["ACP_AddonListEntry" .. i .. "LoadNow"])
	end
end)