local E, L, V, P, G = unpack(ElvUI);
local S = E:GetModule("Skins");

local function LoadSkin()
	if(not E.private.addOnSkins.BlackList) then return; end

	S:HandleButton(FriendsFrameOptionsButton);
	S:HandleButton(FriendsFrameShareListButton);
	S:HandleButton(FriendsFrameRemovePlayerButton);
	S:HandleButton(FriendsFrameBlacklistPlayerButton);
	FriendsTabHeaderTab4:StripTextures();
	FriendsTabHeaderTab4:Width(63);
	FriendsTabHeaderTab4:Height(26);
	FriendsTabHeaderTab4:Point("TOPLEFT", FriendsTabHeaderTab3, "TOPLEFT", 3, -7);
	S:HandleButton(FriendsTabHeaderTab4);

	S:HandleCloseButton(BlackListDetailsCloseButton);
	BlackListDetailsFrame:StripTextures();
	BlackListDetailsFrame:SetTemplate("Transparent");
	BlackListDetailsFrameReasonTextBackground:StripTextures();
	BlackListDetailsFrameReasonTextBackground:CreateBackdrop("Default");
	S:HandleButton(BlackListDetailsEditButton);
	S:HandleCheckBox(BlackListDetailsFrameCheckButton1);
	S:HandleCheckBox(BlackListDetailsFrameCheckButton2);
	S:HandleScrollBar(BlackListDetailsFrameScrollFrameScrollBar);

	BlackListEditDetailsFrame:StripTextures();
	BlackListEditDetailsFrame:SetTemplate("Transparent");
	BlackListEditDetailsFrameLevelBackground:StripTextures();
	BlackListEditDetailsFrameLevelBackground:CreateBackdrop("Default");
	BlackListEditDetailsFrameLevelBackground.backdrop:Point('TOPLEFT', 5, -3);
	BlackListEditDetailsFrameLevelBackground.backdrop:Point('BOTTOMRIGHT', -5, 5);
	S:HandleButton(BlackListEditDetailsFrameSaveButton);
	S:HandleButton(BlackListEditDetailsFrameCancelButton);
	S:HandleDropDownBox(BlackListEditDetailsFrameClassDropDown);
	S:HandleDropDownBox(BlackListEditDetailsFrameRaceDropDown);

	BlackListOptionsFrame:StripTextures();
	BlackListOptionsFrame:SetTemplate("Transparent");
	S:HandleCheckBox(SoundCheckButton);
	S:HandleCheckBox(CenterCheckButton);
	S:HandleCheckBox(ChatCheckButton);
	S:HandleCheckBox(IgnoreCheckButton);
	S:HandleCheckBox(BanCheckButton);
	S:HandleCheckBox(KickCheckButton);
	S:HandleEditBox(BL_RankBox);
	BL_RankBox:Width(20);
	BL_RankBox:Height(20);
	S:HandleButton(BlackListOptionsFrameClose);
end

S:AddCallbackForAddon("BlackList", "BlackList", LoadSkin);