local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
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
		EPGPFrame:StripTextures()
		EPGPFrame:CreateBackdrop("Transparent")
		EPGPFrame.backdrop:Point("TOPLEFT", 10, -12)
		EPGPFrame.backdrop:Point("BOTTOMRIGHT", -35, 74)

		S:HandleCloseButton(EPGPFrame:GetChildren(), EPGPFrame.backdrop)
		local checkBoxBorder = select(2, EPGPFrame:GetChildren())
		checkBoxBorder:StripTextures()
		S:HandleCheckBox(checkBoxBorder:GetChildren())

		EPGPScrollFrame:SetTemplate("Transparent")

		EPGPScrollFrameScrollBarBorder:StripTextures()
		S:HandleScrollBar(EPGPScrollFrameScrollBar)

		local parentFrame = select(6, EPGPFrame:GetChildren())
		for i = 1, parentFrame:GetNumChildren() do
			local child = select(i, parentFrame:GetChildren())
			if child then
				if child:IsObjectType("Button") then
					S:HandleButton(child)
				elseif child:IsObjectType("Frame") then
					for _, header in pairs(child.headers) do
						header:StripTextures()
						header:CreateBackdrop("Transparent")
						header.backdrop:Point("TOPLEFT", 0, 0)
						header.backdrop:Point("BOTTOMRIGHT", 0, -3)
						header:HookScript("OnEnter", S.SetModifiedBackdrop)
						header:HookScript("OnLeave", S.SetOriginalBackdrop)
					end
				end
			end
		end

		-- First Side Frame
		EPGPSideFrame:StripTextures()
		EPGPSideFrame:SetTemplate("Transparent")
		EPGPSideFrame:Point("TOPLEFT", EPGPFrame, "TOPRIGHT", -36, -12)

		S:HandleCloseButton(EPGPSideFrame:GetChildren(), EPGPSideFrame)

		S:HandleDropDownBox(EPGPSideFrameGPControlDropDown, 190)
		S:HandleDropDownBox(EPGPSideFrameEPControlDropDown, 190)

		S:HandleEditBox(EPGPSideFrameGPControlEditBox)
		S:HandleEditBox(EPGPSideFrameEPControlOtherEditBox)
		S:HandleEditBox(EPGPSideFrameEPControlEditBox)

		parentFrame = EPGPSideFrameGPControlEditBox:GetParent()
		S:HandleButton(parentFrame.button)
		parentFrame = EPGPSideFrameEPControlEditBox:GetParent()
		S:HandleButton(parentFrame.button)

		-- Second Side Frame
		EPGPSideFrame2:SetTemplate("Transparent")
		EPGPSideFrame2:Point("BOTTOMLEFT", EPGPFrame, "BOTTOMRIGHT", -36, 74)

		S:HandleCloseButton(EPGPSideFrame2:GetChildren(), EPGPSideFrame2)

		S:HandleDropDownBox(EPGPSideFrame2EPControlDropDown, 190)

		S:HandleEditBox(EPGPSideFrame2EPControlOtherEditBox)
		S:HandleEditBox(EPGPSideFrame2EPControlEditBox)

		parentFrame = EPGPSideFrame2EPControlEditBox:GetParent()
		S:HandleButton(parentFrame.button)
		S:HandleCheckBox(parentFrame.recurring)

		parentFrame.incButton:SetPoint("RIGHT", parentFrame.decButton, "LEFT", -4, 0)

		S:HandleNextPrevButton(parentFrame.decButton, "down")
		parentFrame.decButton:Size(14)

		S:HandleNextPrevButton(parentFrame.incButton, "up")
		parentFrame.incButton:Size(14)

		-- Log Frame
		EPGPLogFrame:StripTextures()
		EPGPLogFrame:SetTemplate("Transparent")
		EPGPLogFrame:Point("TOPLEFT", EPGPFrame, "TOPRIGHT", -36, -12)

		parentFrame = EPGPLogRecordScrollFrame:GetParent()
		parentFrame:StripTextures()
		parentFrame:CreateBackdrop("Transparent")
		parentFrame.backdrop:ClearAllPoints()
		parentFrame.backdrop:Point("TOPLEFT", 1, -1)
		parentFrame.backdrop:Point("BOTTOMRIGHT", -27, 6)

		EPGPLogRecordScrollFrameScrollBar:StripTextures()
		EPGPLogRecordScrollFrameScrollBarBorder:StripTextures()
		S:HandleScrollBar(EPGPLogRecordScrollFrameScrollBar)

		for i = 1, EPGPLogFrame:GetNumChildren() do
			local child = select(i, EPGPLogFrame:GetChildren())
			if child and child:IsObjectType("Button") then
				if child:GetText() then
					S:HandleButton(child)
				elseif child:GetNormalTexture() then
					S:HandleCloseButton(child, EPGPLogFrame)
				else
					child:SetPoint("BOTTOMRIGHT", EPGPLogFrame, "BOTTOMRIGHT", 6, -6)
				end
			end
		end

		-- ExportImport Frame
		EPGPExportImportFrame:SetTemplate("Transparent")

		EPGPExportScrollFrame:StripTextures()
		EPGPExportScrollFrame:CreateBackdrop("Transparent")
		EPGPExportScrollFrame.backdrop:Point("TOPLEFT", -4, 4)
		EPGPExportScrollFrame.backdrop:Point("BOTTOMRIGHT", -8, -8)

		S:HandleScrollBar(EPGPExportScrollFrameScrollBar)

		S:HandleButton(EPGPExportImportFrame.button1)
		S:HandleButton(EPGPExportImportFrame.button2)
	end

	if EPGPFrame then
		SkinEPGP()
	else
		S:SecureHook(EPGPUI, "OnEnable", function()
			SkinEPGP()
			S:Unhook(EPGPFrame, "Show")
		end)
	end
end)