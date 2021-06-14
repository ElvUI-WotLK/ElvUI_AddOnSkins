local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

if not AS:IsAddonLODorEnabled("ZygorTalentAdvisor") then return end

-- Zygor Talent Advisor 2.0

S:AddCallbackForAddon("ZygorTalentAdvisor", "ZygorTalentAdvisor", function()
	if not E.private.addOnSkins.ZygorTalentAdvisor then return end

	ZygorTalentAdvisorPopoutButton:Point("TOPRIGHT", -40, -39)
	ZygorTalentAdvisorPopoutButton:Size(26, 32)
	ZygorTalentAdvisorPopoutButton:SetTemplate("Default")
	ZygorTalentAdvisorPopoutButton:GetNormalTexture():SetTexCoord(0.1875, 0.796875, 0.125, 0.890625)
	ZygorTalentAdvisorPopoutButton:GetNormalTexture():SetInside()
	ZygorTalentAdvisorPopoutButton:GetPushedTexture():SetTexCoord(0.1875, 0.796875, 0.125, 0.890625)
	ZygorTalentAdvisorPopoutButton:GetPushedTexture():SetInside()
	ZygorTalentAdvisorPopoutButton:GetHighlightTexture():SetTexture(1, 1, 1, 0.3)
	ZygorTalentAdvisorPopoutButton:GetHighlightTexture():SetInside()

	ZygorTalentAdvisorPopout:StripTextures()
	ZygorTalentAdvisorPopout:SetTemplate("Transparent")

	ZygorTalentAdvisorPopoutScroll:Point("TOPLEFT", 11, -70)
	ZygorTalentAdvisorPopoutScroll:Point("BOTTOMRIGHT", -32, 70)

	ZygorTalentAdvisorPopoutScrollScrollBar:Point("TOPLEFT", ZygorTalentAdvisorPopoutScroll, "TOPRIGHT", 6, -15)
	ZygorTalentAdvisorPopoutScrollScrollBar:Point("BOTTOMLEFT", ZygorTalentAdvisorPopoutScroll, "BOTTOMRIGHT", 6, 16)

	for i = 1, ZygorTalentAdvisorPopoutScroll:GetNumChildren() do
		local child = select(i, ZygorTalentAdvisorPopoutScroll:GetChildren())
		if child:IsObjectType("Frame") and not child:GetName() then
			child:SetBackdrop(nil)
			child:CreateBackdrop("Transparent")
			child.backdrop:Point("TOPLEFT", 2, 1)
			child.backdrop:Point("BOTTOMRIGHT", -22, 0)
		end
	end

	S:HandleCloseButton(ZygorTalentAdvisorPopoutCloseButton, ZygorTalentAdvisorPopout)

	S:HandleScrollBar(ZygorTalentAdvisorPopoutScrollScrollBar)

	ZygorTalentAdvisorPopoutAcceptButton:StripTextures()
	S:HandleButton(ZygorTalentAdvisorPopoutConfigureButton)
	S:HandleButton(ZygorTalentAdvisorPopoutPreviewButton)
	S:HandleButton(ZygorTalentAdvisorPopoutAcceptButton)

	hooksecurefunc("ZygorTalentAdvisorPopout_Reparent", function()
		if ZTA.db.profile.windowdocked then
			if PlayerSpecTab1 and PlayerSpecTab1:IsShown() then
				ZygorTalentAdvisorPopout:Point("TOPLEFT", PlayerTalentFrame, "TOPRIGHT", 6, -12)
			else
				ZygorTalentAdvisorPopout:Point("TOPLEFT", PlayerTalentFrame, "TOPRIGHT", -33, -12)
			end
		end
	end)
end)