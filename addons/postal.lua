local E, L, V, P, G, _ = unpack(ElvUI);
local S = E:GetModule("Skins");

local function LoadSkin()
	if(not E.private.addOnSkins.Postal) then return; end

	for i = 1, INBOXITEMS_TO_DISPLAY do
		local item = _G["MailItem" .. i .. "ExpireTime"];
		if(item) then
			item:SetPoint("TOPRIGHT", "MailItem" .. i, "TOPRIGHT", -5, -10);
			if(item.returnicon) then
				item.returnicon:Point("TOPRIGHT", item, "TOPRIGHT", 20, 0);
			end
		end
		if(_G["PostalInboxCB" .. i]) then
			S:HandleCheckBox(_G["PostalInboxCB" .. i]);
		end
	end

	if PostalSelectOpenButton then
		S:HandleButton(PostalSelectOpenButton, true);
	end

	if Postal_OpenAllMenuButton then
		S:HandleNextPrevButton(Postal_OpenAllMenuButton, true);
	end

	if PostalOpenAllButton then
		S:HandleButton(PostalOpenAllButton, true);
	end

	if PostalSelectReturnButton then
		S:HandleButton(PostalSelectReturnButton, true);
	end

	if Postal_ModuleMenuButton then
		S:HandleNextPrevButton(Postal_ModuleMenuButton, true);
		Postal_ModuleMenuButton:SetPoint("TOPRIGHT", MailFrame, -60, -16);
	end

	if Postal_BlackBookButton then
		S:HandleNextPrevButton(Postal_BlackBookButton, true);
	end

	hooksecurefunc(Postal, "CreateAboutFrame", function()
		if PostalAboutFrame then
			PostalAboutFrame:StripTextures();
			PostalAboutFrame:SetTemplate("Transparent");
			if PostalAboutScroll then
				S:HandleScrollBar(PostalAboutScrollScrollBar);
			end
			local closeButton = select(2, PostalAboutFrame:GetChildren());
			if closeButton then
				S:HandleCloseButton(closeButton);
			end
		end
	end);
end

S:AddCallbackForAddon("Postal", "Postal", LoadSkin);