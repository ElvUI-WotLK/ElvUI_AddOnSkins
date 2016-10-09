local E, L, V, P, G, _ = unpack(ElvUI);
local S = E:GetModule("Skins");

local function LoadSkin()
	if(not E.private.addOnSkins.ZygorGuidesViewer) then return; end

	ZygorGuidesViewerFrame_Border:StripTextures();
	ZygorGuidesViewerFrame:SetTemplate("Transparent");
	S:HandleScrollBar(ZygorGuidesViewerFrameScrollScrollBar);

	for i = 1, 6 do
		_G["ZygorGuidesViewerFrame_Step" .. i]:CreateBackdrop("Transparent");
	end
end

S:AddCallbackForAddon("ZygorGuidesViewer", "ZygorGuidesViewer", LoadSkin);