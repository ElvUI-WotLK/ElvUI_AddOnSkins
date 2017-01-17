local E, L, V, P, G, _ = unpack(ElvUI);
local S = E:GetModule("Skins");

local function LoadSkin()
	if(not E.private.addOnSkins.QuestPointer) then return; end

	QuestPointerTooltip:StripTextures();
	QuestPointerTooltip:CreateBackdrop("Transparent");
end

S:AddCallbackForAddon("QuestPointer", "QuestPointer", LoadSkin);