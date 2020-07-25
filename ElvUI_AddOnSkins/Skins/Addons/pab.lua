local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

if not AS:IsAddonLODorEnabled("PAB") then return end

-- Party Ability Bars r7
-- https://www.wowace.com/projects/pab/files/353353

S:AddCallbackForAddon("PAB", "PAB", function()
	if not E.private.addOnSkins.PAB then return end

	if not PAB then return end

	S:HandleSliderFrame(PAB_Panel_Slider1)

	S:HandleCheckBox(PAB_Panel_Toggle1)
	S:HandleCheckBox(PAB_Panel_Toggle2)
	S:HandleCheckBox(PAB_Panel_Toggle3)

	S:HandleScrollBar(PABScrollFrameScrollBar)

	S:HandleDropDownBox(PAB_Panel_DropDown1)

	_G["PABScrollFrameAbility name"]:Height(21)
	_G["PABScrollFrameCD (s)"]:Height(21)
	S:HandleEditBox(_G["PABScrollFrameAbility name"])
	S:HandleEditBox(_G["PABScrollFrameCD (s)"])

	PAB_Panel_Button1:SetPoint("TOPLEFT", _G["PABScrollFrameAbility name"], "BOTTOMLEFT", -1, -7)
	S:HandleButton(PAB_Panel_Button1)
	S:HandleButton(PAB_Panel_Button2)

	local function SkinIcon(frame)
		if frame.backdrop then return end

		frame:CreateBackdrop("Transparent")
		frame.texture:SetTexCoord(unpack(E.TexCoords))
		frame.texture.SetTexCoord = E.noop

		E:RegisterCooldown(frame.cd)
	end

	local PABIcons, iconSize, scale
	local border = E.Border

	hooksecurefunc(PAB, "ApplyAnchorSettings", function()
		if not (PABIcons and iconSize) then return end

		scale = PABDB.scale
		PABIcons:SetScale(1)

		for i = 1, 4 do
			for _, iconFrame in pairs(_G["PABAnchor"..i].icons) do
				iconFrame:Size(iconSize * scale)
			end
		end
	end)

	S:RawHook(PAB, "AppendIcon", function(self, icons, anchor, ...)
		local iconFrame = S.hooks[self].AppendIcon(self, icons, anchor, ...)

		if not PABIcons then
			PABIcons = iconFrame:GetParent()
			PAB:ApplyAnchorSettings()
		end

		SkinIcon(iconFrame)
		iconFrame:Size(iconSize * scale)

		if #icons == 0 then
			iconFrame:Point("TOPLEFT", anchor, "BOTTOMRIGHT", border, -border)
		else
			iconFrame:Point("LEFT", icons[#icons - 1], "RIGHT", border, 0)
		end

		return iconFrame
	end)

	for i = 1, 4 do
		local frame = _G["PABAnchor"..i]
		frame:SetBackdrop(nil)
		frame:CreateBackdrop("Transparent")

		for _, iconFrame in pairs(frame.icons) do
			if not (PABIcons and iconSize) then
				PABIcons = iconFrame:GetParent()
				iconSize = iconFrame:GetSize()
				PAB:ApplyAnchorSettings()
			end

			SkinIcon(iconFrame)

			local point, parent = iconFrame:GetPoint()
			if point == "LEFT" then
				iconFrame:Point("LEFT", parent, "RIGHT", border, 0)
			elseif point == "TOPLEFT" then
				iconFrame:Point("TOPLEFT", parent, "BOTTOMRIGHT", border, -border)
			end
		end
	end
end)