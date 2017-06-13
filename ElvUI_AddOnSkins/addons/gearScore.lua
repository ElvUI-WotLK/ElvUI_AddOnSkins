local E, L, V, P, G = unpack(ElvUI);
local S = E:GetModule("Skins");

-- GearScore 3.1.17

local function LoadSkin()
	if(not E.private.addOnSkins.GearScore) then return; end

	GS_DisplayFrame:SetTemplate("Transparent");

	S:HandleEditBox(GS_EditBox1);
	GS_EditBox1:Height(22);
	GS_EditBox1:ClearAllPoints();
	GS_EditBox1:Point("RIGHT", GS_SearchButton, "LEFT", -6, 0);

	S:HandleButton(GS_SearchButton);
	S:HandleButton(GS_GroupButton);
	S:HandleButton(GS_DeleteButton);
	S:HandleButton(GS_InviteButton);

	for i = 1, 4 do
		_G["GS_SpecBar" .. i]:StripTextures();
		_G["GS_SpecBar" .. i]:SetStatusBarTexture(E["media"].normTex);
		_G["GS_SpecBar" .. i]:CreateBackdrop("Default");
		E:RegisterStatusBar(_G["GS_SpecBar" .. i]);
	end

	GS_Model:SetTemplate("Default");

	for i = 1, 18 do
		if(i ~= 4) then
			_G["GS_Frame" .. i].texture = _G["GS_Frame" .. i]:CreateTexture(nil, "BORDER");
			_G["GS_Frame" .. i].texture:SetInside();
			_G["GS_Frame" .. i].texture:SetTexCoord(unpack(E.TexCoords));
		end
	end

	hooksecurefunc("GearScore_DisplayUnit", function(Name)
		if(GS_Data[GetRealmName()].Players[Name]) then
			for i = 1, 18 do
				if(i ~= 4) then
					_G["GS_Frame" .. i]:SetTemplate("Default");
					local _, _, ItemRarity, _, _, _, _, _, _, ItemTexture = GetItemInfo("item:" .. GS_Data[GetRealmName()].Players[Name].Equip[i]);
					if(ItemTexture) then
						_G["GS_Frame" .. i].texture:SetTexture(ItemTexture);
						_G["GS_Frame" .. i]:SetBackdropBorderColor(GetItemQualityColor(ItemRarity));
					else
						_G["GS_Frame" .. i].texture:SetTexture(GS_TextureFiles[i]);
						_G["GS_Frame" .. i]:SetBackdropBorderColor(unpack(E["media"].bordercolor));
					end
				end
			end
		else
			for i = 1, 18 do
				if(i ~= 4) then
					_G["GS_Frame" .. i]:SetTemplate("Default");
					_G["GS_Frame" .. i].texture:SetTexture(GS_TextureFiles[i]);
					_G["GS_Frame" .. i]:SetBackdropBorderColor(unpack(E["media"].bordercolor));
				end
			end
		end
	end);

	--S:HandleEditBox(GS_NotesEditBox);

	for i = 1, 14 do
		_G["GS_XpBar" .. i]:StripTextures();
		_G["GS_XpBar" .. i]:SetStatusBarTexture(E["media"].normTex);
		_G["GS_XpBar" .. i]:CreateBackdrop("Default");
		E:RegisterStatusBar(_G["GS_XpBar" .. i]);
	end

	GS_DisplayFrameTab1:Point("TOPLEFT", 0, -448);
	GS_DisplayFrameTab3:Point("TOPRIGHT", 0, -448);
	for i = 1, 3 do
		S:HandleTab(_G["GS_DisplayFrameTab" .. i]);
	end

	S:HandleCloseButton(GSDisplayFrameCloseButton);

	S:HandleCheckBox(GS_ShowPlayerCheck);

	S:HandleButton(Button3);
	S:HandleButton(GS_UndoButton);

	S:HandleCheckBox(GS_Heavy);
	S:HandleCheckBox(GS_None);
	S:HandleCheckBox(GS_Light);
	S:HandleCheckBox(GS_ShowItemCheck);
	S:HandleCheckBox(GS_LevelCheck);

	for i = 1, 4 do
		S:HandleCheckBox(_G["GS_SpecScoreCheck" .. i]);
	end

	S:HandleCheckBox(GS_DetailCheck);
	S:HandleCheckBox(GS_DateCheck);
	S:HandleCheckBox(GS_HelpCheck);
	S:HandleCheckBox(GS_ChatCheck);

	S:HandleEditBox(GS_LevelEditBox);

	S:HandleCheckBox(GS_PruneCheck);
	S:HandleCheckBox(GS_FactionCheck);

	S:HandleSliderFrame(GS_DatabaseAgeSlider);

	S:HandleCheckBox(GS_MasterlootCheck);

	GS_DatabaseFrame:SetTemplate("Transparent");

	S:HandleCloseButton(GSDatabaseFrameCloseButton);

	GS_DatabaseFrameTab1:Point("TOPLEFT", 0, -468);
	for i = 1, 4 do
		S:HandleTab(_G["GS_DatabaseFrameTab" .. i]);
	end

	S:HandleButton(GS_PreviousButton);
	S:HandleButton(GS_NextButton);
	S:HandleButton(GS_BackProfileButton);

	S:HandleEditBox(GS_SearchXBox);
	GS_SearchXBox:Height(22);
	GS_SearchXBox:ClearAllPoints();
	GS_SearchXBox:Point("RIGHT", GS_Search2Button, "LEFT", -6, 0);

	for _, frame in pairs({_G["GS_DatabaseFrame"]:GetChildren()}) do
		if(frame:GetName() == "GS_Search2Button") then
			S:HandleButton(frame);
		end
	end

	hooksecurefunc("GearScore_DisplayDatabase", function()
		if(GS_DatabaseFrame.tooltip) then
			GS_DatabaseFrame.tooltip:SetTemplate("Default");
			if(GS_DatabaseFrame.tooltip.slider) then
				S:HandleSliderFrame(GS_DatabaseFrame.tooltip.slider);
			end
		end
	end);

	hooksecurefunc("GearScoreClassScan", function()
		if(GS_DatabaseFrame.tooltip) then
			GS_DatabaseFrame.tooltip:SetTemplate("Default");
			if(GS_DatabaseFrame.tooltip.slider) then
				S:HandleSliderFrame(GS_DatabaseFrame.tooltip.slider);
			end
		end
	end);

	GS_ReportFrame:SetTemplate("Transparent");

	S:HandleSliderFrame(GS_Slider);

	S:HandleEditBox(GSX_WhisperEditBox);
	S:HandleEditBox(GSX_ChannelEditBox);

	S:HandleButton(GSXButton1);
	S:HandleCloseButton(GSReportFrameCloseButton);

	S:HandleCheckBox(GSXSayCheck, true);
	S:HandleCheckBox(GSXPartyCheck, true);
	S:HandleCheckBox(GSXRaidCheck, true);
	S:HandleCheckBox(GSXGuildCheck, true);
	S:HandleCheckBox(GSXOfficerCheck, true);
	S:HandleCheckBox(GSXWhisperTargetCheck, true);
	S:HandleCheckBox(GSXWhisperCheck, true);
	S:HandleCheckBox(GSXChannelCheck, true);
end

S:AddCallbackForAddon("GearScore", "GearScore", LoadSkin);