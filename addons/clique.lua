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
		--	S:HandleCheckBox(entry);
		end
		
		CliqueTextListScroll:StripTextures();
		S:HandleScrollBar(CliqueTextListScrollScrollBar);
		
		S:HandleDropDownBox(CliqueDropDown);
		CliqueDropDown:SetPoint("TOPRIGHT", -1, -25);
		
		S:HandleCloseButton(CliqueButtonClose);
		
		S:HandleButton(CliqueButtonCustom);
		S:HandleButton(CliqueButtonFrames);
		S:HandleButton(CliqueButtonProfiles);
		S:HandleButton(CliqueButtonOptions);
		S:HandleButton(CliqueButtonDelete);
		S:HandleButton(CliqueButtonEdit);
		
		S:HandleCloseButton(CliqueTextButtonClose);
		
		S:HandleButton(CliqueButtonDeleteProfile);
		S:HandleButton(CliqueButtonSetProfile);
		S:HandleButton(CliqueButtonNewProfile);
		
		SkinFrame(CliqueOptionsFrame);
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
