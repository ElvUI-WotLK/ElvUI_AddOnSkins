local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

local _G = _G
local select = select

local function SkinDewdrop2()
	local frame
	local i = 1

	while _G["Dewdrop20Level" .. i] do
		frame = _G["Dewdrop20Level" .. i]

		if not frame.isSkinned then
			frame:SetTemplate("Transparent")

			select(1, frame:GetChildren()):Hide()
			frame.SetBackdropColor = E.noop
			frame.SetBackdropBorderColor = E.noop

			frame.isSkinned = true
		end

		i = i + 1
	end

	i = 1
	while _G["Dewdrop20Button"..i] do
		if not _G["Dewdrop20Button" .. i].isHook then
			_G["Dewdrop20Button" .. i]:HookScript2("OnEnter", function(self)
				if not self.disabled and self.hasArrow then
					SkinDewdrop2()
				end
			end)
			_G["Dewdrop20Button" .. i].isHook = true
		end

		i = i + 1
	end
end

function AS:SkinLibrary(name)
	if not name then return end

	if name == "AceAddon-2.0" then
		local AceAddon = LibStub("AceAddon-2.0", true)
		if AceAddon then
			if not S:IsHooked(AceAddon.prototype, "PrintAddonInfo") then
				S:SecureHook(AceAddon.prototype, "PrintAddonInfo", function()
					AceAddon20AboutFrame:SetTemplate("Transparent")
					S:HandleButton(AceAddon20AboutFrameButton)
					S:HandleButton(AceAddon20AboutFrameDonateButton)

					S:Unhook(AceAddon.prototype, "PrintAddonInfo")
				end)
			end
			if not S:IsHooked(AceAddon.prototype, "OpenDonationFrame") then
				S:SecureHook(AceAddon.prototype, "OpenDonationFrame", function()
					AceAddon20Frame:SetTemplate("Transparent")
					S:HandleScrollBar(AceAddon20FrameScrollFrameScrollBar)
					S:HandleButton(AceAddon20FrameButton)

					S:Unhook(AceAddon.prototype, "OpenDonationFrame")
				end)
			end
		end
	elseif name == "Dewdrop-2.0" then
		local Dewdrop = LibStub("Dewdrop-2.0", true)
		if Dewdrop and not S:IsHooked(Dewdrop, "Open") then
			S:SecureHook(Dewdrop, "Open", SkinDewdrop2)
		end
	elseif name == "Tablet-2.0" then
		local Tablet = LibStub("Tablet-2.0", true)
		if Tablet and not S:IsHooked(Tablet, "Open") then
			S:SecureHook(Tablet, "Open", function()
				_G["Tablet20Frame"]:SetTemplate("Transparent")
			end)
		end
	elseif name == "LibExtraTip-1" then
		local LibExtraTip = LibStub("LibExtraTip-1", true)
		if LibExtraTip and not S:IsHooked(LibExtraTip, "GetFreeExtraTipObject") then
			S:RawHook(LibExtraTip, "GetFreeExtraTipObject", function(self)
				local tooltip = S.hooks[self].GetFreeExtraTipObject(self)

				if not tooltip.isSkinned then
					tooltip:SetTemplate("Transparent")
					tooltip.isSkinned = true
				end

				return tooltip
			end)
		end
	elseif name == "ZFrame-1.0" then
		local LZF = LibStub:GetLibrary("ZFrame-1.0", true)
		if LZF and not S:IsHooked(LZF, "Create") then
			S:RawHook(LZF, "Create", function(self, ...)
				local frame = S.hooks[self].Create(self, ...)

				frame.ZMain:SetTemplate("Transparent")
				frame.ZMain.close:Size(32)
				S:HandleCloseButton(frame.ZMain.close, frame.ZMain)

				return frame
			end, true)
		end
	end
end