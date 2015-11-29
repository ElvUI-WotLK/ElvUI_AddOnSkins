local E, L, V, P, G, _ = unpack(ElvUI);
local addon = E:GetModule("AddOnSkins");

if(not addon:CheckAddOn("Clique")) then return; end

function addon:Clique()
	local S = E:GetModule("Skins");
	
	CliquePulloutTab:StyleButton(nil, true);
	CliquePulloutTab:SetTemplate("Default", true);
	CliquePulloutTab:GetNormalTexture():SetTexCoord(unpack(E.TexCoords));
	CliquePulloutTab:GetNormalTexture():SetInside();
	select(1, CliquePulloutTab:GetRegions()):Hide();
	
	local function SkinFrame(frame)
		frame:StripTextures();
		frame:SetTemplate("Transparent");
		
		frame.titleBar:StripTextures();
		frame.titleBar:SetTemplate("Default", true);
		frame.titleBar:SetHeight(20);
		frame.titleBar:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 0);
		frame.titleBar:SetPoint("TOPRIGHT", frame, "TOPRIGHT", 0, 0);
	end
	
	addon:SecureHook(Clique, "CreateOptionsFrame", function()
		SkinFrame(CliqueFrame);
		
		CliqueFrame:SetHeight(425);
		CliqueFrame:SetPoint("TOPLEFT", SpellBookFrame, "TOPRIGHT", 10, -12);
		
		for i = 1, 10 do
			local entry = _G["CliqueList"..i];
		--	entry:SetTemplate("Default");
			entry.icon:SetTexCoord(unpack(E.TexCoords));
		end
		
		CliqueListScroll:StripTextures();
		S:HandleScrollBar(CliqueListScrollScrollBar);
		
		SkinFrame(CliqueTextListFrame);
		
		for i = 1,12 do
			local entry = _G["CliqueTextList"..i];
			S:HandleCheckBox(entry);
			entry.backdrop:Point("TOPLEFT", 6, -4);
			entry.backdrop:Point("BOTTOMRIGHT", -4, 3);
			entry.backdrop:Point("TOPRIGHT", entry.name, "TOPLEFT", -3, 0);
		end
		
		CliqueTextListScroll:StripTextures();
		S:HandleScrollBar(CliqueTextListScrollScrollBar);
		
		S:HandleDropDownBox(CliqueDropDown);
		CliqueDropDown:SetPoint("TOPRIGHT", -1, -25);
		
		S:HandleCloseButton(CliqueButtonClose);
		CliqueButtonClose:SetSize(32, 32);
		CliqueButtonClose:SetPoint("TOPRIGHT", 5, 5);
		
		S:HandleButton(CliqueButtonCustom);
		S:HandleButton(CliqueButtonFrames);
		S:HandleButton(CliqueButtonProfiles);
		S:HandleButton(CliqueButtonOptions);
		S:HandleButton(CliqueButtonDelete);
		S:HandleButton(CliqueButtonEdit);
		
		S:HandleCloseButton(CliqueTextButtonClose);
		CliqueTextButtonClose:SetSize(32, 32);
		CliqueTextButtonClose:SetPoint("TOPRIGHT", 5, 5);
		
		S:HandleButton(CliqueButtonDeleteProfile);
		S:HandleButton(CliqueButtonSetProfile);
		S:HandleButton(CliqueButtonNewProfile);
		
		SkinFrame(CliqueOptionsFrame);
		
		S:HandleCloseButton(CliqueOptionsButtonClose);
		CliqueOptionsButtonClose:SetSize(32, 32);
		CliqueOptionsButtonClose:SetPoint("TOPRIGHT", 5, 5);
		
		S:HandleCheckBox(CliqueOptionsSpecSwitch);
		CliqueOptionsSpecSwitch.backdrop:Point("TOPLEFT", 6, -4);
		CliqueOptionsSpecSwitch.backdrop:Point("BOTTOMRIGHT", -4, 3);
		CliqueOptionsSpecSwitch.backdrop:Point("TOPRIGHT", CliqueOptionsSpecSwitch.name, "TOPLEFT", -3, 0);
		
		S:HandleDropDownBox(CliquePriSpecDropDown);
		S:HandleDropDownBox(CliqueSecSpecDropDown);
		CliquePriSpecDropDown:SetWidth(225);
		CliqueSecSpecDropDown:SetWidth(225);
		CliquePriSpecDropDownButton:SetSize(20, 20);
		CliqueSecSpecDropDownButton:SetSize(20, 20);
		
		SkinFrame(CliqueCustomFrame);
		
		S:HandleButton(CliqueCustomButtonBinding);
		S:HandleButton(CliqueCustomButtonIcon);
		CliqueCustomButtonIcon.icon:SetTexCoord(unpack(E.TexCoords));
		CliqueCustomButtonIcon.icon:SetInside();
		
		for i = 1, 5 do
			S:HandleEditBox(_G["CliqueCustomArg"..i]);
			_G["CliqueCustomArg"..i].backdrop:Point("TOPLEFT", -5, -5);
			_G["CliqueCustomArg"..i].backdrop:Point("BOTTOMRIGHT", -5, 5);
		end
		
		CliqueMulti:SetBackdrop(nil);
		CliqueMulti:CreateBackdrop("Default");
		CliqueMulti.backdrop:Point("TOPLEFT", 5, -8);
		CliqueMulti.backdrop:Point("BOTTOMRIGHT", -5, 8);
		S:HandleScrollBar(CliqueMultiScrollFrameScrollBar);
		
		S:HandleButton(CliqueCustomButtonCancel);
		S:HandleButton(CliqueCustomButtonSave);
		
		SkinFrame(CliqueIconSelectFrame);
		
		for i = 1, 20 do
			local button = _G["CliqueIcon"..i];
			local buttonIcon = _G["CliqueIcon"..i.."Icon"];
			
			button:StripTextures();
			button:StyleButton(nil, true);
			button.hover:SetAllPoints();
			button:CreateBackdrop("Default");
			
			buttonIcon:SetAllPoints();
			buttonIcon:SetTexCoord(unpack(E.TexCoords));
		end
		
		CliqueIconScrollFrame:StripTextures();
		S:HandleScrollBar(CliqueIconScrollFrameScrollBar);
	end);
end

addon:RegisterSkin("Clique", addon.Clique);
