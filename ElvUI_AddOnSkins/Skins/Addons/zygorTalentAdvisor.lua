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

if not AS:IsAddonLODorEnabled("ZygorTalentAdvisor") then return end

-- Zygor Talent Advisor 2.0

S:AddCallbackForAddon("ZygorTalentAdvisor", "ZygorTalentAdvisor", function()
	if not E.private.addOnSkins.ZygorTalentAdvisor then return end

	SkinFrame(ZygorTalentAdvisorPopoutButton, "Point", "TOPRIGHT", -40, -39)
	SkinFrame(ZygorTalentAdvisorPopoutButton, "Size", 26, 32)
	SkinFrame(ZygorTalentAdvisorPopoutButton, "SetTemplate", "Default")
	ZygorTalentAdvisorPopoutButton:GetNormalTexture():SetTexCoord(0.1875, 0.796875, 0.125, 0.890625)
	ZygorTalentAdvisorPopoutButton:GetNormalTexture():SetInside()
	ZygorTalentAdvisorPopoutButton:GetPushedTexture():SetTexCoord(0.1875, 0.796875, 0.125, 0.890625)
	ZygorTalentAdvisorPopoutButton:GetPushedTexture():SetInside()
	ZygorTalentAdvisorPopoutButton:GetHighlightTexture():SetTexture(1, 1, 1, 0.3)
	ZygorTalentAdvisorPopoutButton:GetHighlightTexture():SetInside()

	SkinFrame(ZygorTalentAdvisorPopout, "StripTextures")
	SkinFrame(ZygorTalentAdvisorPopout, "SetTemplate", "Transparent")

	SkinFrame(ZygorTalentAdvisorPopoutScroll, "Point", "TOPLEFT", 11, -70)
	SkinFrame(ZygorTalentAdvisorPopoutScroll, "Point", "BOTTOMRIGHT", -32, 70)

	SkinFrame(ZygorTalentAdvisorPopoutScrollScrollBar, "Point", "TOPLEFT", ZygorTalentAdvisorPopoutScroll, "TOPRIGHT", 6, -15)
	SkinFrame(ZygorTalentAdvisorPopoutScrollScrollBar, "Point", "BOTTOMLEFT", ZygorTalentAdvisorPopoutScroll, "BOTTOMRIGHT", 6, 16)

	for i = 1, ZygorTalentAdvisorPopoutScroll:GetNumChildren() do
		local child = select(i, ZygorTalentAdvisorPopoutScroll:GetChildren())
		if child:IsObjectType("Frame") and not child:GetName() then
			SkinFrame(child, "SetBackdrop", nil)
			child:CreateBackdrop("Transparent")
			child.backdrop:Point("TOPLEFT", 2, 1)
			child.backdrop:Point("BOTTOMRIGHT", -22, 0)
		end
	end

	SkinControl("HandleCloseButton", ZygorTalentAdvisorPopoutCloseButton, ZygorTalentAdvisorPopout)

	SkinControl("HandleScrollBar", ZygorTalentAdvisorPopoutScrollScrollBar)

	SkinFrame(ZygorTalentAdvisorPopoutAcceptButton, "StripTextures")
	SkinControl("HandleButton", ZygorTalentAdvisorPopoutConfigureButton)
	SkinControl("HandleButton", ZygorTalentAdvisorPopoutPreviewButton)
	SkinControl("HandleButton", ZygorTalentAdvisorPopoutAcceptButton)

	hooksecurefunc("ZygorTalentAdvisorPopout_Reparent", function()
		if ZTA.db.profile.windowdocked then
			if PlayerSpecTab1 and PlayerSpecTab1:IsShown() then
				SkinFrame(ZygorTalentAdvisorPopout, "Point", "TOPLEFT", PlayerTalentFrame, "TOPRIGHT", 6, -12)
			else
				SkinFrame(ZygorTalentAdvisorPopout, "Point", "TOPLEFT", PlayerTalentFrame, "TOPRIGHT", -33, -12)
			end
		end
	end)
end)
