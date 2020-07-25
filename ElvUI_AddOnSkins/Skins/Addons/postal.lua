local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

if not AS:IsAddonLODorEnabled("Postal") then return end

-- Postal r299
-- https://www.wowace.com/projects/postal/files/454610

S:AddCallbackForAddon("Postal", "Postal", function()
	if not E.private.addOnSkins.Postal then return end

	for i = 1, INBOXITEMS_TO_DISPLAY do
		local mail = _G["MailItem"..i]
		local button = _G["MailItem"..i.."Button"]
		local expire = _G["MailItem"..i.."ExpireTime"]
		local inboxCB = _G["PostalInboxCB"..i]

		button:SetScale(1)

		if i == 1 then
			mail:Point("TOPLEFT", 38, -80)
		end

		if expire then
			expire:Point("TOPRIGHT", mail, "TOPRIGHT", 3, -2)

			if expire.returnicon then
				expire.returnicon:StripTextures(true)
				S:HandleCloseButton(expire.returnicon)
				expire.returnicon:Point("TOPRIGHT", expire, "TOPRIGHT", 25, -3)
				expire.returnicon:Size(26)
			end
		end

		if inboxCB then
			S:HandleCheckBox(inboxCB)
			inboxCB:Point("RIGHT", mail, "LEFT", 5, -5)
		end
	end

	if PostalSelectOpenButton then
		S:HandleButton(PostalSelectOpenButton, true)
		PostalSelectOpenButton:ClearAllPoints()
		PostalSelectOpenButton:Point("TOPLEFT", InboxFrame, "TOPLEFT", 43, -45)
	end

	if PostalSelectReturnButton then
		S:HandleButton(PostalSelectReturnButton, true)
		PostalSelectReturnButton:ClearAllPoints()
		PostalSelectReturnButton:Point("LEFT", PostalSelectOpenButton, "RIGHT", 39, 0)
	end

	if Postal_OpenAllMenuButton then
		S:HandleNextPrevButton(Postal_OpenAllMenuButton)
		Postal_OpenAllMenuButton:ClearAllPoints()
		Postal_OpenAllMenuButton:Point("LEFT", PostalOpenAllButton, "RIGHT", 2, 0)
		Postal_OpenAllMenuButton:Size(25)
	end

	if PostalOpenAllButton then
		S:HandleButton(PostalOpenAllButton, true)
	end

	if Postal_ModuleMenuButton then
		S:HandleNextPrevButton(Postal_ModuleMenuButton, nil, nil, true)
		Postal_ModuleMenuButton:Point("TOPRIGHT", MailFrame, -60, -12)
		Postal_ModuleMenuButton:Size(26)
	end

	if Postal_BlackBookButton then
		S:HandleNextPrevButton(Postal_BlackBookButton)
		Postal_BlackBookButton:ClearAllPoints()
		Postal_BlackBookButton:Point("LEFT", SendMailNameEditBox, "RIGHT", 2, 0)
		Postal_BlackBookButton:Size(20)
	end

	hooksecurefunc(Postal, "CreateAboutFrame", function()
		if PostalAboutFrame then
			PostalAboutFrame:StripTextures()
			PostalAboutFrame:SetTemplate("Transparent")

			if PostalAboutScroll then
				S:HandleScrollBar(PostalAboutScrollScrollBar)
			end

			local closeButton = select(2, PostalAboutFrame:GetChildren())
			if closeButton then
				S:HandleCloseButton(closeButton)
			end
		end
	end)
end)