local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
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

		oRA3Frame:StripTextures(true)
		oRA3Frame:CreateBackdrop("Transparent")
		oRA3Frame.backdrop:Point("TOPLEFT", 11, -12)
		oRA3Frame.backdrop:Point("BOTTOMRIGHT", -32, 76)

		oRA3Frame:SetAttribute("UIPanelLayout-yoffset", 0)
		oRA3Frame:SetAttribute("UIPanelLayout-xoffset", 0)
		S:SetUIPanelWindowInfo(oRA3Frame, "width")

		S:HandleCloseButton(oRA3Frame:GetChildren(), oRA3Frame.backdrop)

		oRA3ScrollFrameTop:Kill()
		oRA3ScrollFrameBottom:Kill()

		S:HandleScrollBar(oRA3ScrollFrameScrollBar)

		S:HandleTab(oRA3FrameTab1)
		S:HandleTab(oRA3FrameTab2)
		S:HandleTab(oRA3FrameTab3)
		S:HandleTab(oRA3FrameTab4)
		S:HandleTab(oRA3FrameTab5)

		S:HandleButton(oRA3Disband)
		S:HandleButton(oRA3Options)
		S:HandleButton(oRA3ListButton1)
		S:HandleButton(oRA3ListButton2)
		S:HandleButton(oRA3ListButton3)

		oRA3ScrollFrame:Point("TOPRIGHT", -21, -24)
		oRA3ScrollFrame:Point("BOTTOMLEFT", 1, 34)

		oRA3ScrollFrameScrollBar:Point("TOPLEFT", oRA3ScrollFrame, "TOPRIGHT", 3, -19)
		oRA3ScrollFrameScrollBar:Point("BOTTOMLEFT", oRA3ScrollFrame, "BOTTOMRIGHT", 3, 19)

		oRA3ListButton2:Width(104)
		oRA3ListButton1:Point("TOPLEFT", oRA3ScrollFrame, "BOTTOMLEFT", 0, -7)
		oRA3ListButton2:Point("LEFT", oRA3ListButton1, "RIGHT", 5, 0)
		oRA3ListButton3:Point("LEFT", oRA3ListButton2, "RIGHT", 5, 0)

		oRA3FrameTab2:Point("TOPLEFT", oRA3FrameTab1, "TOPRIGHT", -15, 0)
		oRA3FrameTab3:Point("TOPLEFT", oRA3FrameTab2, "TOPRIGHT", -15, 0)
		oRA3FrameTab4:Point("TOPLEFT", oRA3FrameTab3, "TOPRIGHT", -15, 0)
		oRA3FrameTab5:Point("TOPLEFT", oRA3FrameTab4, "TOPRIGHT", -15, 0)
	end)

	hooksecurefunc(addon, "CreateScrollEntry", function(self, header)
		if header.inSkinned then return end

		header:DisableDrawLayer("BACKGROUND")
		header:StyleButton()

		if header.headerIndex == 1 then
			header:Point("TOPLEFT", 1, 0)
		end

		header.isSkinned = true
	end)

	local tanks = addon:GetModule("Tanks", true)
	if tanks then
		S:SecureHook(tanks, "CreateFrame", function(self)
			S:Unhook(self, "CreateFrame")

			local border1, border2 = oRA3TankTopScrollFrame:GetParent():GetChildren()
			border1:StripTextures()
			if not border2:GetName() then
				border2:StripTextures()
			end

			S:HandleScrollBar(oRA3TankTopScrollFrameScrollBar)
			S:HandleScrollBar(oRA3TankBottomScrollFrameScrollBar)

			oRA3TankTopScrollFrame:CreateBackdrop("Transparent")
			oRA3TankTopScrollFrame.backdrop:Point("TOPLEFT", -6, 1)
			oRA3TankTopScrollFrame.backdrop:Point("BOTTOMRIGHT", 7, -1)

			oRA3TankBottomScrollFrame:CreateBackdrop("Transparent")
			oRA3TankBottomScrollFrame.backdrop:Point("TOPLEFT", -6, 1)
			oRA3TankBottomScrollFrame.backdrop:Point("BOTTOMRIGHT", 7, -1)

			oRA3TankTopScrollFrameScrollBar:Point("TOPLEFT", oRA3TankTopScrollFrame, "TOPRIGHT", 10, -18)
			oRA3TankTopScrollFrameScrollBar:Point("BOTTOMLEFT", oRA3TankTopScrollFrame, "BOTTOMRIGHT", 10, 18)

			oRA3TankBottomScrollFrameScrollBar:Point("TOPLEFT", oRA3TankBottomScrollFrame, "TOPRIGHT", 10, -18)
			oRA3TankBottomScrollFrameScrollBar:Point("BOTTOMLEFT", oRA3TankBottomScrollFrame, "BOTTOMRIGHT", 10, 18)

			for i = 1, 10 do
				local checkBox = _G["oRA3TankHideButton"..i]
				S:HandleCheckBox(checkBox)
				checkBox.backdrop:SetInside(nil, 1, 1)
			end
		end)
	end

	local readycheck = addon:GetModule("ReadyCheck", true)
	if readycheck then
		S:SecureHook(readycheck, "READY_CHECK", function(self)
			if not (addon:IsPromoted() and self.db.profile.gui) then return end

			S:Unhook(self, "READY_CHECK")

			oRA3ReadyCheck:StripTextures()
			oRA3ReadyCheck:SetTemplate("Transparent")

			local closeButton = oRA3ReadyCheck:GetChildren()
			S:HandleCloseButton(closeButton)
			closeButton:Point("TOPRIGHT", 1, 2)

			local titlebg = oRA3ReadyCheck:GetRegions()
			titlebg:Point("TOPLEFT", 6, -6)
			titlebg:Point("BOTTOMRIGHT", oRA3ReadyCheck, "TOPRIGHT", -6, -23)
			titlebg:SetTexture(unpack(E.media.bordercolor))
		end)
	end
end)