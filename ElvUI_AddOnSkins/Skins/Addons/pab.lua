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

if not AS:IsAddonLODorEnabled("PAB") then return end

local _G = _G
local ipairs = ipairs
local unpack = unpack

-- Party Ability Bars r7
-- https://www.wowace.com/projects/pab/files/353353

S:AddCallbackForAddon("PAB", "PAB", function()
	if not E.private.addOnSkins.PAB then return end

	if not PAB then return end

	SkinControl("HandleSliderFrame", PAB_Panel_Slider1)

	SkinControl("HandleCheckBox", PAB_Panel_Toggle1)
	SkinControl("HandleCheckBox", PAB_Panel_Toggle2)
	SkinControl("HandleCheckBox", PAB_Panel_Toggle3)

	SkinControl("HandleScrollBar", PABScrollFrameScrollBar)

	SkinControl("HandleDropDownBox", PAB_Panel_DropDown1)

	SkinFrame(_G["PABScrollFrameAbility name"], "Height", 21)
	SkinFrame(_G["PABScrollFrameCD (s)"], "Height", 21)
	SkinControl("HandleEditBox", _G["PABScrollFrameAbility name"])
	SkinControl("HandleEditBox", _G["PABScrollFrameCD (s)"])

	SkinFrame(PAB_Panel_Button1, "Point", "TOPLEFT", _G["PABScrollFrameAbility name"], "BOTTOMLEFT", -1, -7)
	SkinControl("HandleButton", PAB_Panel_Button1)
	SkinControl("HandleButton", PAB_Panel_Button2)

	local function SkinIcon(frame)
		if frame.backdrop then return end

		frame:CreateBackdrop("Transparent")
		frame.texture:SetTexCoord(unpack(E.TexCoords))
		frame.texture.SetTexCoord = E.noop

		E:RegisterCooldown(frame.cd)
	end

	local PABIcons
	local ICON_SIZE = 30
	local SCALE = 1

	hooksecurefunc(PAB, "ApplyAnchorSettings", function()
		if not PABIcons then return end

		SCALE = PABIcons:GetScale()
		SkinFrame(PABIcons, "SetScale", 1)

		for i = 1, 4 do
			for _, iconFrame in ipairs(_G["PABAnchor"..i].icons) do
				SkinFrame(iconFrame, "Size", ICON_SIZE * SCALE)
			end
		end
	end)

	S:RawHook(PAB, "AppendIcon", function(self, icons, anchor, ...)
		local iconFrame = S.hooks[self].AppendIcon(self, icons, anchor, ...)

		SkinIcon(iconFrame)
		SkinFrame(iconFrame, "Size", ICON_SIZE * SCALE)

		if #icons == 0 then
			SkinFrame(iconFrame, "Point", "TOPLEFT", anchor, "BOTTOMRIGHT", E.Border, -E.Border)
		else
			SkinFrame(iconFrame, "Point", "LEFT", icons[#icons - 1], "RIGHT", E.Border, 0)
		end

		return iconFrame
	end)

	for i = 1, 4 do
		local frame = _G["PABAnchor"..i]
		SkinFrame(frame, "SetBackdrop", nil)
		frame:CreateBackdrop("Transparent")

		for _, iconFrame in ipairs(frame.icons) do
			if not PABIcons then
				PABIcons = iconFrame:GetParent()
				ICON_SIZE = math.floor(iconFrame:GetSize() + 0.5)
			end

			SkinIcon(iconFrame)
			SkinFrame(iconFrame, "Size", ICON_SIZE * SCALE)

			local point, anchor = iconFrame:GetPoint()
			if point == "LEFT" then
				SkinFrame(iconFrame, "Point", "LEFT", anchor, "RIGHT", E.Border, 0)
			elseif point == "TOPLEFT" then
				SkinFrame(iconFrame, "Point", "TOPLEFT", anchor, "BOTTOMRIGHT", E.Border, -E.Border)
			end
		end
	end
end)
