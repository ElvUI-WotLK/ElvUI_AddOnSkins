local E, L, V, P, G, _ = unpack(ElvUI);
local addon = E:GetModule("AddOnSkins");

if(not addon:CheckAddOn("ZygorTalentAdvisor")) then return; end

function addon:ZygorTalentAdvisor()
  local S = E:GetModule("Skins");

    _G['ZygorTalentAdvisorPopoutButton']:Size(26, 32);
    _G['ZygorTalentAdvisorPopoutButton']:CreateBackdrop('Default');

    ZygorTalentAdvisorPopoutButton:GetNormalTexture():SetTexCoord(0.1875, 0.796875, 0.125, 0.890625);
    ZygorTalentAdvisorPopoutButton:GetPushedTexture():SetTexCoord(0.1875, 0.796875, 0.125, 0.890625);
    ZygorTalentAdvisorPopoutButton:GetHighlightTexture():SetTexture(1, 1, 1, 0.3);
    ZygorTalentAdvisorPopoutButton:GetHighlightTexture():SetAllPoints();

    ZygorTalentAdvisorPopout:StripTextures();
    ZygorTalentAdvisorPopout:CreateBackdrop('Transparent');
    ZygorTalentAdvisorPopout.backdrop:Point('TOPLEFT', 6, -2);
    ZygorTalentAdvisorPopout.backdrop:Point('BOTTOMRIGHT', -1, 4);

    ZygorTalentAdvisorPopoutScrollChild:StripTextures();
    ZygorTalentAdvisorPopoutScroll:StripTextures();
    ZygorTalentAdvisorPopoutScroll:CreateBackdrop('Transparent');

    S:HandleCloseButton(ZygorTalentAdvisorPopoutCloseButton);

    S:HandleScrollBar(ZygorTalentAdvisorPopoutScrollScrollBar);

    ZygorTalentAdvisorPopoutAcceptButton:StripTextures();
    S:HandleButton(ZygorTalentAdvisorPopoutConfigureButton);
    S:HandleButton(ZygorTalentAdvisorPopoutPreviewButton);
    S:HandleButton(ZygorTalentAdvisorPopoutAcceptButton);
end

addon:RegisterSkin("ZygorTalentAdvisor", addon.ZygorTalentAdvisor);
