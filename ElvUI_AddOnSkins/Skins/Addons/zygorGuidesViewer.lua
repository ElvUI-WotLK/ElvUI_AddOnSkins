local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

if not AS:IsAddonLODorEnabled("ZygorGuidesViewer") then return end

-- Zygor Guides Viewer 2.0

S:AddCallbackForAddon("ZygorGuidesViewer", "ZygorGuidesViewer", function()
	if not E.private.addOnSkins.ZygorGuidesViewer then return end

	ZygorGuidesViewerFrame_Border:StripTextures()
	ZygorGuidesViewerFrame:SetTemplate("Transparent")
	S:HandleScrollBar(ZygorGuidesViewerFrameScrollScrollBar)

	for i = 1, 6 do
		_G["ZygorGuidesViewerFrame_Step" .. i]:CreateBackdrop("Transparent")
	end
end)