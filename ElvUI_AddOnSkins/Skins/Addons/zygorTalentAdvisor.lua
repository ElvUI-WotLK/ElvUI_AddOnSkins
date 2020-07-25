local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

if not AS:IsAddonLODorEnabled("ZygorTalentAdvisor") then return end

S:AddCallbackForAddon("ZygorTalentAdvisor", "ZygorTalentAdvisor", function()
	if not E.private.addOnSkins.ZygorTalentAdvisor then return end

	ZygorTalentAdvisorPopoutButton:Size(26, 32)
	ZygorTalentAdvisorPopoutButton:SetTemplate("Default")
	ZygorTalentAdvisorPopoutButton:GetNormalTexture():SetTexCoord(0.1875, 0.796875, 0.125, 0.890625)
	ZygorTalentAdvisorPopoutButton:GetNormalTexture():SetInside()
	ZygorTalentAdvisorPopoutButton:GetPushedTexture():SetTexCoord(0.1875, 0.796875, 0.125, 0.890625)
	ZygorTalentAdvisorPopoutButton:GetPushedTexture():SetInside()
	ZygorTalentAdvisorPopoutButton:GetHighlightTexture():SetTexture(1, 1, 1, 0.3)
	ZygorTalentAdvisorPopoutButton:GetHighlightTexture():SetInside()

	ZygorTalentAdvisorPopout:StripTextures()
	ZygorTalentAdvisorPopout:CreateBackdrop("Transparent")
	ZygorTalentAdvisorPopout.backdrop:Point("TOPLEFT", 6, -2)
	ZygorTalentAdvisorPopout.backdrop:Point("BOTTOMRIGHT", -1, 4)

	for i = 1, ZygorTalentAdvisorPopoutScroll:GetNumChildren() do
		local child = select(i, ZygorTalentAdvisorPopoutScroll:GetChildren())
		if child:IsObjectType("Frame") and not child:GetName() then
			child:SetBackdrop(nil)
			child:CreateBackdrop("Default")
		end
	end

	S:HandleCloseButton(ZygorTalentAdvisorPopoutCloseButton)

	S:HandleScrollBar(ZygorTalentAdvisorPopoutScrollScrollBar)

	ZygorTalentAdvisorPopoutAcceptButton:StripTextures()
	S:HandleButton(ZygorTalentAdvisorPopoutConfigureButton)
	S:HandleButton(ZygorTalentAdvisorPopoutPreviewButton)
	S:HandleButton(ZygorTalentAdvisorPopoutAcceptButton)
end)