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

if not AS:IsAddonLODorEnabled("epgp") then return end

-- EPGP 5.5.19
-- https://www.curseforge.com/wow/addons/epgp-dkp-reloaded/files/442647

S:AddCallbackForAddon("epgp", "epgp", function()
	if not E.private.addOnSkins.EPGP then return end

	local EPGPUI = EPGP and EPGP:GetModule("ui", true)
	if not EPGPUI then return end

	local function SkinEPGP()
		-- Main Frame
		SkinFrame(EPGPFrame, "StripTextures")
		EPGPFrame:CreateBackdrop("Transparent")
		EPGPFrame.backdrop:Point("TOPLEFT", 11, -12)
		EPGPFrame.backdrop:Point("BOTTOMRIGHT", -32, 76)

		S:SetUIPanelWindowInfo(EPGPFrame, "width", nil, nil, nil, true)
		S:SetBackdropHitRect(EPGPFrame)

		local closeButton, checkBoxBorder, _, _, _, main = EPGPFrame:GetChildren()

		SkinControl("HandleCloseButton", closeButton, EPGPFrame.backdrop)

		SkinFrame(checkBoxBorder, "StripTextures")
		SkinFrame(checkBoxBorder, "Point", "TOPRIGHT", EPGPFrame, "TOPRIGHT", -49, -38)
		SkinControl("HandleCheckBox", checkBoxBorder:GetChildren())

		SkinFrame(main, "Width", 329)
		SkinFrame(main, "Point", "TOPLEFT", 20, -70)

		SkinFrame(EPGPScrollFrame, "SetTemplate", "Transparent")
		SkinFrame(EPGPScrollFrame, "Width", 304)
		SkinFrame(EPGPScrollFrame, "Point", "TOPRIGHT", 1, 1)
		SkinFrame(EPGPScrollFrame, "Point", "BOTTOMRIGHT", 1, 8)

		SkinFrame(EPGPScrollFrameScrollBarBorder, "StripTextures")
		SkinControl("HandleScrollBar", EPGPScrollFrameScrollBar)
		SkinFrame(EPGPScrollFrameScrollBar, "Point", "TOPLEFT", EPGPScrollFrame, "TOPRIGHT", 3, -19)
		SkinFrame(EPGPScrollFrameScrollBar, "Point", "BOTTOMLEFT", EPGPScrollFrame, "BOTTOMRIGHT", 3, 19)

		local award, logButton, decay, tabl = main:GetChildren()

		for _, header in ipairs(tabl.headers) do
			SkinFrame(header, "StripTextures")
			SkinFrame(header, "StyleButton")
		end

		for _, row in ipairs(tabl.rowFrame.rows) do
			row.check:SetDrawLayer("BORDER")
		end

		SkinControl("HandleButton", award)
		SkinControl("HandleButton", logButton)
		SkinControl("HandleButton", decay)

		SkinFrame(logButton, "Point", "BOTTOMRIGHT", -5, 0)
		SkinFrame(decay, "Point", "RIGHT", logButton, "LEFT", -3, 0)

		local statusText = select(2, main:GetRegions())
		SkinFrame(statusText, "Point", "BOTTOMLEFT", award, "TOPLEFT", 0, 7)
		SkinFrame(statusText, "Point", "BOTTOMRIGHT", logButton, "TOPRIGHT", 0, 7)

		-- First Side Frame
		SkinFrame(EPGPSideFrame, "StripTextures")
		SkinFrame(EPGPSideFrame, "SetTemplate", "Transparent")
		SkinFrame(EPGPSideFrame, "Point", "TOPLEFT", EPGPFrame, "TOPRIGHT", -33, -12)

		SkinControl("HandleCloseButton", EPGPSideFrame:GetChildren(), EPGPSideFrame)

		SkinControl("HandleDropDownBox", EPGPSideFrameGPControlDropDown, 190)
		SkinControl("HandleDropDownBox", EPGPSideFrameEPControlDropDown, 190)

		SkinControl("HandleEditBox", EPGPSideFrameGPControlEditBox)
		SkinControl("HandleEditBox", EPGPSideFrameEPControlOtherEditBox)
		SkinControl("HandleEditBox", EPGPSideFrameEPControlEditBox)

		SkinFrame(EPGPSideFrameGPControlEditBox, "Height", 22)
		SkinFrame(EPGPSideFrameEPControlOtherEditBox, "Height", 22)
		SkinFrame(EPGPSideFrameEPControlEditBox, "Height", 22)
		SkinFrame(EPGPSideFrameEPControlOtherEditBox, "Point", "RIGHT", -14, 0)

		local parentFrame = EPGPSideFrameGPControlEditBox:GetParent()
		SkinControl("HandleButton", parentFrame.button)
		SkinFrame(EPGPSideFrameGPControlEditBox, "Point", "RIGHT", parentFrame.button, "LEFT", -4, 0)
		parentFrame.button:Point("RIGHT", EPGPSideFrameGPControlDropDown, "RIGHT", -8, 0)

		parentFrame = EPGPSideFrameEPControlEditBox:GetParent()
		SkinControl("HandleButton", parentFrame.button)
		SkinFrame(EPGPSideFrameEPControlEditBox, "Point", "RIGHT", parentFrame.button, "LEFT", -4, 0)
		parentFrame.button:Point("RIGHT", EPGPSideFrameEPControlOtherEditBox, "RIGHT", 1, 0)

		-- Second Side Frame
		EPGPSideFrame2:EnableMouse(true)
		SkinFrame(EPGPSideFrame2, "SetTemplate", "Transparent")
		SkinFrame(EPGPSideFrame2, "Point", "BOTTOMLEFT", EPGPFrame, "BOTTOMRIGHT", -33, 76)

		SkinControl("HandleCloseButton", EPGPSideFrame2:GetChildren(), EPGPSideFrame2)

		SkinControl("HandleDropDownBox", EPGPSideFrame2EPControlDropDown, 190)

		SkinControl("HandleEditBox", EPGPSideFrame2EPControlOtherEditBox)
		SkinControl("HandleEditBox", EPGPSideFrame2EPControlEditBox)

		SkinFrame(EPGPSideFrame2EPControlOtherEditBox, "Point", "RIGHT", -14, 0)
		SkinFrame(EPGPSideFrame2EPControlOtherEditBox, "Height", 22)
		SkinFrame(EPGPSideFrame2EPControlEditBox, "Height", 22)

		parentFrame = EPGPSideFrame2EPControlEditBox:GetParent()

		SkinControl("HandleButton", parentFrame.button)
		parentFrame.button:Point("RIGHT", EPGPSideFrame2EPControlOtherEditBox, "RIGHT", 1, 0)
		SkinFrame(EPGPSideFrame2EPControlEditBox, "Point", "RIGHT", parentFrame.button, "LEFT", -4, 0)

		SkinControl("HandleCheckBox", parentFrame.recurring)
		parentFrame.recurring:Point("TOP", EPGPSideFrame2EPControlEditBox, "BOTTOMLEFT", 0, -6)

		SkinControl("HandleNextPrevButton", parentFrame.decButton, "down")
		parentFrame.decButton:Size(18)

		SkinControl("HandleNextPrevButton", parentFrame.incButton, "up")
		parentFrame.incButton:Size(18)

		parentFrame.decButton:Point("TOP", parentFrame.recurring, "TOP", 0, -3)
		parentFrame.decButton:Point("RIGHT", -13, 0)
		parentFrame.incButton:Point("RIGHT", parentFrame.decButton, "LEFT", -5, 0)

		-- Log Frame
		EPGPLogFrame:EnableMouse(true)
		SkinFrame(EPGPLogFrame, "StripTextures")
		SkinFrame(EPGPLogFrame, "SetTemplate", "Transparent")
		SkinFrame(EPGPLogFrame, "Height", 424)
		EPGPLogFrame:SetMinResize(435, 424)
		EPGPLogFrame:SetMaxResize(1200, 424)
		SkinFrame(EPGPLogFrame, "Point", "TOPLEFT", EPGPFrame, "TOPRIGHT", -33, -12)

		local sizer, closeButton2, export, import, trimLog, undo, redo, scrollParent = EPGPLogFrame:GetChildren()

		SkinControl("HandleCloseButton", closeButton2, EPGPLogFrame)

		SkinFrame(scrollParent, "StripTextures")
		SkinFrame(scrollParent, "Point", "LEFT", 7, 0)
		SkinFrame(scrollParent, "Point", "RIGHT", 1, 0)
		scrollParent:CreateBackdrop("Transparent")
		scrollParent.backdrop:Point("TOPLEFT", 1, 2)
		scrollParent.backdrop:Point("BOTTOMRIGHT", -30, 7)

		SkinFrame(EPGPLogRecordScrollFrame, "Size", 368, 350)
		SkinFrame(EPGPLogRecordScrollFrame, "Point", "TOPRIGHT", -0, -3)

		SkinFrame(EPGPLogRecordFrame1, "Point", "TOPLEFT", 3, 0)

		SkinFrame(EPGPLogRecordScrollFrameScrollBarBorder, "StripTextures")
		SkinControl("HandleScrollBar", EPGPLogRecordScrollFrameScrollBar)

		SkinFrame(EPGPLogRecordScrollFrameScrollBar, "Point", "TOPLEFT", EPGPLogRecordScrollFrame, "TOPRIGHT", -27, -14)
		SkinFrame(EPGPLogRecordScrollFrameScrollBar, "Point", "BOTTOMLEFT", EPGPLogRecordScrollFrame, "BOTTOMRIGHT", -27, 18)

		SkinControl("HandleButton", export)
		SkinControl("HandleButton", import)
		SkinControl("HandleButton", trimLog)
		SkinControl("HandleButton", undo)
		SkinControl("HandleButton", redo)

		SkinFrame(export, "Point", "BOTTOMLEFT", 8, 8)
		SkinFrame(import, "Point", "LEFT", export, "RIGHT", 3, 0)

		SkinFrame(undo, "Point", "BOTTOMRIGHT", -8, 8)
		SkinFrame(redo, "Point", "RIGHT", undo, "LEFT", -3, 0)

		SkinFrame(sizer, "Size", 14)

		local line1, line2 = sizer:GetRegions()
		SkinFrame(line1, "Size", 12)
		SkinFrame(line1, "Point", "BOTTOMRIGHT", -1, 1)
		SkinFrame(line2, "Size", 8)
		SkinFrame(line2, "Point", "BOTTOMRIGHT", -1, 1)
		local x = 0.1 * 14/17
		SkinFrame(line1, "SetTexCoord", 1/32 - x, 0.5, 1/32, 0.5 + x, 1/32, 0.5 - x, 1/32 + x, 0.5)
		x = 0.1 * 11/17
		SkinFrame(line2, "SetTexCoord", 1/32 - x, 0.5, 1/32, 0.5 + x, 1/32, 0.5 - x, 1/32 + x, 0.5)

		SkinFrame(sizer, "HookScript", "OnMouseUp", function(self)
			self:GetParent():ClearAllPoints()
			self:GetParent():Point("TOPLEFT", EPGPFrame, "TOPRIGHT", -33, -12)
		end)

		-- ExportImport Frame
		EPGPExportImportFrame:EnableMouse(true)
		SkinFrame(EPGPExportImportFrame, "SetTemplate", "Transparent")
		SkinFrame(EPGPExportImportFrame, "Width", 480)

		EPGPExportImportFrame.help:Point("TOP", 0, -10)

		EPGPExportImportFrame.editbox:Width(438)

		EPGPExportScrollFrame:EnableMouse(true)
		SkinFrame(EPGPExportScrollFrame, "StripTextures")
		SkinFrame(EPGPExportScrollFrame, "Point", "TOPLEFT", EPGPExportImportFrame.help, "BOTTOMLEFT", 0, -10)
		SkinFrame(EPGPExportScrollFrame, "Point", "TOPRIGHT", EPGPExportImportFrame.help, "BOTTOMRIGHT", -17, 0)
		SkinFrame(EPGPExportScrollFrame, "Point", "BOTTOM", EPGPExportImportFrame.button1, "TOP", 0, 9)

		EPGPExportScrollFrame:CreateBackdrop("Transparent")
		EPGPExportScrollFrame.backdrop:Point("TOPLEFT", -2, 2)
		EPGPExportScrollFrame.backdrop:Point("BOTTOMRIGHT", -2, -2)

		SkinControl("HandleScrollBar", EPGPExportScrollFrameScrollBar)
		SkinFrame(EPGPExportScrollFrameScrollBar, "Point", "TOPLEFT", EPGPExportScrollFrame, "TOPRIGHT", 1, -17)
		SkinFrame(EPGPExportScrollFrameScrollBar, "Point", "BOTTOMLEFT", EPGPExportScrollFrame, "BOTTOMRIGHT", 1, 17)

		SkinControl("HandleButton", EPGPExportImportFrame.button1)
		SkinControl("HandleButton", EPGPExportImportFrame.button2)

		EPGPExportImportFrame.button1:Point("BOTTOM", 0, 8)

		if not EPGPExportScrollFrame:GetScript("OnMouseUp") then
			SkinFrame(EPGPExportScrollFrame, "SetScript", "OnMouseUp", function(self, button)
				if button == "LeftButton" then
					EPGPExportImportFrame.editbox:SetFocus()
				end
			end)
		end
	end

	if EPGPFrame then
		SkinEPGP()
	else
		S:SecureHook(EPGPUI, "OnEnable", function(self)
			SkinEPGP()
			S:Unhook(self, "OnEnable")
		end)
	end
end)
