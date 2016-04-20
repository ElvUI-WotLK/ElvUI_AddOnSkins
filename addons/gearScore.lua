local E, L, V, P, G = unpack(ElvUI);
local addon = E:GetModule("AddOnSkins");
local S = E:GetModule("Skins");

if(not addon:CheckAddOn("GearScore")) then return; end

function addon:GearScore()
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
		if(_G["GS_Frame" .. i]) then
		_G["GS_Frame" .. i]:CreateBackdrop("Default");
		end
	end

	--S:HandleEditBox(GS_NotesEditBox);

	for i = 1, 14 do
		_G["GS_XpBar" .. i]:StripTextures();
		_G["GS_XpBar" .. i]:SetStatusBarTexture(E["media"].normTex);
		_G["GS_XpBar" .. i]:CreateBackdrop("Default");
		E:RegisterStatusBar(_G["GS_XpBar" .. i]);
	end

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

	for i = 1, 4 do
		S:HandleTab(_G["GS_DatabaseFrameTab" .. i]);
	end

	S:HandleButton(GS_PreviousButton);
	S:HandleButton(GS_NextButton);
	S:HandleButton(GS_BackProfileButton);

	S:HandleEditBox(GS_SearchXBox);

	for _, frame in pairs({_G["GS_DatabaseFrame"]:GetChildren()}) do
		if(frame:GetName() == "GS_Search2Button") then
			S:HandleButton(frame);
		end
	end
	
	hooksecurefunc("GearScore_DisplayDatabase", function()
		if(GS_DatabaseFrame.tooltip) then
			GS_DatabaseFrame.tooltip:SetTemplate("Default");
		end
	end);
end

addon:RegisterSkin("GearScore", addon.GearScore);