local E, L, V, P, G = unpack(ElvUI);
local S = E:GetModule("Skins");

local function LoadSkin()
	if(not E.private.addOnSkins._NPCScan) then return; end

	_NPCScanButton:SetScale(1);
	_NPCScanButton.SetScale = E.noop;

	_NPCScanButton:StripTextures();
	_NPCScanButton:SetTemplate("Default", true);

	_NPCScanButton:HookScript("OnEnter", S.SetModifiedBackdrop);
	_NPCScanButton:HookScript("OnLeave", S.SetOriginalBackdrop);

	for i = 1, _NPCScanButton:GetNumChildren() do
		local child = select(i, _NPCScanButton:GetChildren())
		if(child and child:IsObjectType("Button")) then
			S:HandleCloseButton(child);
			child:ClearAllPoints();
			child:SetPoint("TOPRIGHT", _NPCScanButton, "TOPRIGHT", 4, 4);
			child:SetScale(1);
		end
	end

	local NPCFoundText = select(4, _NPCScanButton:GetRegions());
	NPCFoundText:SetTextColor(1, 1, 1, 1);
	NPCFoundText:SetShadowOffset(1, -1);
end

S:AddCallbackForAddon("_NPCScan", "_NPCScan", LoadSkin);