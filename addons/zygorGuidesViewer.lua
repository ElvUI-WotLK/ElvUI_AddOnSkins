local E, L, V, P, G, _ = unpack(ElvUI);
local addon = E:GetModule("AddOnSkins");

if(not addon:CheckAddOn("ZygorGuidesViewer")) then return; end

function addon:ZygorGuidesViewer()
	local S = E:GetModule("Skins");

  ZygorGuidesViewerFrame_Border:StripTextures();
  ZygorGuidesViewerFrame:SetTemplate("Transparent");
  S:HandleScrollBar(ZygorGuidesViewerFrameScrollScrollBar);

  for i = 1, 6 do
    (_G['ZygorGuidesViewerFrame_Step'..i]):CreateBackdrop("Transparent");
  end
end

addon:RegisterSkin("ZygorGuidesViewer", addon.ZygorGuidesViewer);
