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

if not AS:IsAddonLODorEnabled("oRA3") then return end

-- oRA3 r452
-- https://www.curseforge.com/wow/addons/ora3/files/464284

S:AddCallbackForAddon("oRA3", "oRA3", function()
	if not E.private.addOnSkins.oRA3 then return end

	local addon = LibStub("AceAddon-3.0"):GetAddon("oRA3", true)
	if not addon then return end

	AS:SkinLibrary("LibCandyBar-3.0")

	S:SecureHook(addon, "ToggleFrame", function(self)
		S:Unhook(self, "ToggleFrame")

		SkinFrame(oRA3Frame, "StripTextures", true)
		oRA3Frame:CreateBackdrop("Transparent")
		oRA3Frame.backdrop:Point("TOPLEFT", 11, -12)
		oRA3Frame.backdrop:Point("BOTTOMRIGHT", -32, 76)

		oRA3Frame:SetAttribute("UIPanelLayout-yoffset", 0)
		oRA3Frame:SetAttribute("UIPanelLayout-xoffset", 0)
		S:SetUIPanelWindowInfo(oRA3Frame, "width")

		SkinControl("HandleCloseButton", oRA3Frame:GetChildren(), oRA3Frame.backdrop)

		SkinFrame(oRA3ScrollFrameTop, "Kill")
		SkinFrame(oRA3ScrollFrameBottom, "Kill")

		SkinControl("HandleScrollBar", oRA3ScrollFrameScrollBar)

		SkinControl("HandleTab", oRA3FrameTab1)
		SkinControl("HandleTab", oRA3FrameTab2)
		SkinControl("HandleTab", oRA3FrameTab3)
		SkinControl("HandleTab", oRA3FrameTab4)
		SkinControl("HandleTab", oRA3FrameTab5)

		SkinControl("HandleButton", oRA3Disband)
		SkinControl("HandleButton", oRA3Options)
		SkinControl("HandleButton", oRA3ListButton1)
		SkinControl("HandleButton", oRA3ListButton2)
		SkinControl("HandleButton", oRA3ListButton3)

		SkinFrame(oRA3ScrollFrame, "Point", "TOPRIGHT", -21, -24)
		SkinFrame(oRA3ScrollFrame, "Point", "BOTTOMLEFT", 1, 34)

		SkinFrame(oRA3ScrollFrameScrollBar, "Point", "TOPLEFT", oRA3ScrollFrame, "TOPRIGHT", 3, -19)
		SkinFrame(oRA3ScrollFrameScrollBar, "Point", "BOTTOMLEFT", oRA3ScrollFrame, "BOTTOMRIGHT", 3, 19)

		SkinFrame(oRA3ListButton2, "Width", 104)
		SkinFrame(oRA3ListButton1, "Point", "TOPLEFT", oRA3ScrollFrame, "BOTTOMLEFT", 0, -7)
		SkinFrame(oRA3ListButton2, "Point", "LEFT", oRA3ListButton1, "RIGHT", 5, 0)
		SkinFrame(oRA3ListButton3, "Point", "LEFT", oRA3ListButton2, "RIGHT", 5, 0)

		SkinFrame(oRA3FrameTab2, "Point", "TOPLEFT", oRA3FrameTab1, "TOPRIGHT", -15, 0)
		SkinFrame(oRA3FrameTab3, "Point", "TOPLEFT", oRA3FrameTab2, "TOPRIGHT", -15, 0)
		SkinFrame(oRA3FrameTab4, "Point", "TOPLEFT", oRA3FrameTab3, "TOPRIGHT", -15, 0)
		SkinFrame(oRA3FrameTab5, "Point", "TOPLEFT", oRA3FrameTab4, "TOPRIGHT", -15, 0)
	end)

	hooksecurefunc(addon, "CreateScrollEntry", function(self, header)
		if header.inSkinned then return end

		header:DisableDrawLayer("BACKGROUND")
		SkinFrame(header, "StyleButton")

		if header.headerIndex == 1 then
			SkinFrame(header, "Point", "TOPLEFT", 1, 0)
		end

		header.isSkinned = true
	end)

	local tanks = addon:GetModule("Tanks", true)
	if tanks then
		S:SecureHook(tanks, "CreateFrame", function(self)
			S:Unhook(self, "CreateFrame")

			local border1, border2 = oRA3TankTopScrollFrame:GetParent():GetChildren()
			SkinFrame(border1, "StripTextures")
			if not border2:GetName() then
				SkinFrame(border2, "StripTextures")
			end

			SkinControl("HandleScrollBar", oRA3TankTopScrollFrameScrollBar)
			SkinControl("HandleScrollBar", oRA3TankBottomScrollFrameScrollBar)

			oRA3TankTopScrollFrame:CreateBackdrop("Transparent")
			oRA3TankTopScrollFrame.backdrop:Point("TOPLEFT", -6, 1)
			oRA3TankTopScrollFrame.backdrop:Point("BOTTOMRIGHT", 7, -1)

			oRA3TankBottomScrollFrame:CreateBackdrop("Transparent")
			oRA3TankBottomScrollFrame.backdrop:Point("TOPLEFT", -6, 1)
			oRA3TankBottomScrollFrame.backdrop:Point("BOTTOMRIGHT", 7, -1)

			SkinFrame(oRA3TankTopScrollFrameScrollBar, "Point", "TOPLEFT", oRA3TankTopScrollFrame, "TOPRIGHT", 10, -18)
			SkinFrame(oRA3TankTopScrollFrameScrollBar, "Point", "BOTTOMLEFT", oRA3TankTopScrollFrame, "BOTTOMRIGHT", 10, 18)

			SkinFrame(oRA3TankBottomScrollFrameScrollBar, "Point", "TOPLEFT", oRA3TankBottomScrollFrame, "TOPRIGHT", 10, -18)
			SkinFrame(oRA3TankBottomScrollFrameScrollBar, "Point", "BOTTOMLEFT", oRA3TankBottomScrollFrame, "BOTTOMRIGHT", 10, 18)

			for i = 1, 10 do
				local checkBox = _G["oRA3TankHideButton"..i]
				SkinControl("HandleCheckBox", checkBox)
				checkBox.backdrop:SetInside(nil, 1, 1)
			end
		end)
	end

	local readycheck = addon:GetModule("ReadyCheck", true)
	if readycheck then
		S:SecureHook(readycheck, "READY_CHECK", function(self)
			if not (addon:IsPromoted() and self.db.profile.gui) then return end

			S:Unhook(self, "READY_CHECK")

			SkinFrame(oRA3ReadyCheck, "StripTextures")
			SkinFrame(oRA3ReadyCheck, "SetTemplate", "Transparent")

			local closeButton = oRA3ReadyCheck:GetChildren()
			SkinControl("HandleCloseButton", closeButton)
			SkinFrame(closeButton, "Point", "TOPRIGHT", 1, 2)

			local titlebg = oRA3ReadyCheck:GetRegions()
			SkinFrame(titlebg, "Point", "TOPLEFT", 6, -6)
			SkinFrame(titlebg, "Point", "BOTTOMRIGHT", oRA3ReadyCheck, "TOPRIGHT", -6, -23)
			titlebg:SetTexture(unpack(E.media.bordercolor))
		end)
	end
end)
