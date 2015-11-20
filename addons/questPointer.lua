local E, L, V, P, G, _ = unpack(ElvUI);
local addon = E:GetModule("AddOnSkins");

if(not addon:CheckAddOn("QuestPointer")) then return; end

function addon:QuestPointer()
	local S = E:GetModule("Skins");
	QuestPointerTooltip:StripTextures();
	QuestPointerTooltip:CreateBackdrop('Transparent');
end

addon:RegisterSkin("QuestPointer", addon.QuestPointer);
