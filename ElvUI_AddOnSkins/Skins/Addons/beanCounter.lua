local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

if not AS:IsAddonLODorEnabled("BeanCounter") then return end

-- BeanCounter 5.8.4723
-- https://www.curseforge.com/wow/addons/auctioneer/files/427823

S:AddCallbackForAddon("BeanCounter", "BeanCounter", function()
	if not E.private.addOnSkins.BeanCounter then return end

	AS:SkinLibrary("Configator")
	AS:SkinLibrary("LibExtraTip-1")

	local base = BeanCounterBaseFrame
	if base then
		local private = BeanCounter.Private
		local frame = private.frame

		-- External GUI
		base:SetBackdrop(nil)
		base:Size(832, 447)
		base:SetMinResize(832, 447)
		base:SetMaxResize(1500, 447)

		base:CreateBackdrop("Transparent")
		base.backdrop:Point("TOPLEFT", 11, 0)
		base.backdrop:Point("BOTTOMRIGHT", 0, -2)
		S:SetBackdropHitRect(base)

		base.Drag:Point("TOPLEFT", 22, -1)
		base.Drag:Point("TOPRIGHT", -11, -1)

		base.DragBottom:Point("BOTTOMLEFT", 22, 1)
		base.DragBottom:Point("BOTTOMRIGHT", -11, 1)

		S:HandleButton(base.Done)
		base.Done:Height(18)
		base.Done:Point("BOTTOMRIGHT", -47, 6)

		S:HandleNextPrevButton(base.Resizer, "right")
		base.Resizer:Point("BOTTOMRIGHT", -8, 6)

		-- Actual Usable Frame
		local title = frame:GetRegions()
		title:Point("TOPLEFT", 80, -10)

		S:HandleButton(frame.Config)
		frame.Config:Point("TOPRIGHT", -30, -8)

		-- Left Panel
		frame.LeftBackground = CreateFrame("Frame", nil, frame)
		frame.LeftBackground:SetFrameLevel(frame:GetFrameLevel() - 1)
		frame.LeftBackground.SetFrameLevel = E.noop
		frame.LeftBackground:SetTemplate("Transparent")
		frame.LeftBackground:Point("TOPLEFT", 19, -36)
		frame.LeftBackground:Point("BOTTOMRIGHT", -648, 60)

		frame.slot:SetTexture(nil)
		frame.slot:Point("TOPLEFT", frame, "TOPLEFT", 23, -110)

		frame.icon:SetTemplate("Default")
		frame.icon:GetHighlightTexture():SetInside()
		frame.icon:GetHighlightTexture():SetTexture(1, 1, 1, 0.3)
		frame.icon:SetPoint("TOPLEFT", frame.slot, "TOPLEFT", 0, 0)

		frame.selectbox.box:StripTextures()
		frame.selectbox.box:Point("TOPLEFT", frame, "TOPLEFT", 4, -77)
		frame.selectbox.box:CreateBackdrop("Default")
		frame.selectbox.box.backdrop:Point("TOPLEFT", 19, -2)
		frame.selectbox.box.backdrop:Point("BOTTOMRIGHT", -14, -11)
		_G[frame.selectbox.box:GetName().."Text"]:SetParent(frame.selectbox.box.backdrop)

		frame.selectbox.box.button:Size(16)
		frame.selectbox.box.button:Point("TOPRIGHT", -16, -4)
		S:HandleNextPrevButton(frame.selectbox.box.button, "down", {1, 0.8, 0})

		local searchBoxName = frame.searchBox:GetName()
		_G[searchBoxName.."Left"]:Hide()
		_G[searchBoxName.."Middle"]:Hide()
		_G[searchBoxName.."Right"]:Hide()
		frame.searchBox:SetTemplate("Default")
		frame.searchBox:Point("TOPLEFT", 23, -165)
		frame.searchBox:Size(157, 20)

		S:HandleButton(frame.searchButton)
		frame.searchButton:Point("TOPLEFT", frame.searchBox, "BOTTOMLEFT", 0, -3)

		S:HandleCheckBox(frame.exactCheck)
		S:HandleCheckBox(frame.neutralCheck)
		S:HandleCheckBox(frame.bidCheck)
		S:HandleCheckBox(frame.bidFailedCheck)
		S:HandleCheckBox(frame.auctionCheck)
		S:HandleCheckBox(frame.auctionFailedCheck)

		frame.exactCheck:Point("TOPLEFT", 19, -216)
		frame.neutralCheck:Point("TOPLEFT", 19, -241)

		frame.bidCheck:SetScale(1)
		frame.bidCheck:Point("TOPLEFT", 19, -274)
		frame.auctionCheck:SetScale(1)
		frame.auctionCheck:Point("TOPLEFT", 19, -299)

		frame.bidFailedCheck:SetScale(1)
		frame.bidFailedCheck:Point("TOPLEFT", 19, -332)
		frame.auctionFailedCheck:SetScale(1)
		frame.auctionFailedCheck:Point("TOPLEFT", 19, -357)

		hooksecurefunc(private, "searchByItemID", function(id, settings, queryReturn, count, itemTexture, classic)
			if not itemTexture then return end

			private.frame.icon:GetNormalTexture():SetTexCoord(unpack(E.TexCoords))
			private.frame.icon:GetNormalTexture():SetInside()
		end)

		-- ResultList
		frame.RightBackground = CreateFrame("Frame", nil, frame)
		frame.RightBackground:SetFrameLevel(frame:GetFrameLevel() - 1)
		frame.RightBackground.SetFrameLevel = E.noop
		frame.RightBackground:SetTemplate("Transparent")
		frame.RightBackground:Point("TOPLEFT", 187, -36)
		frame.RightBackground:Point("BOTTOMRIGHT", -29, 52)

		frame.resultlist:SetBackdrop(nil)
		frame.resultlist:Point("TOPLEFT", 184, -34)
		frame.resultlist:Point("TOPRIGHT", -4, 0)
		frame.resultlist:Point("BOTTOM", 0, 27)

		S:HandleScrollBar(frame.resultlist.sheet.panel.vScroll)
		S:HandleScrollBar(frame.resultlist.sheet.panel.hScroll, true)

		frame.resultlist.sheet.panel.vScroll:Point("TOPLEFT", frame.resultlist.sheet.panel, "TOPRIGHT", 3, -16)
		frame.resultlist.sheet.panel.vScroll:Point("BOTTOMLEFT", frame.resultlist.sheet.panel, "BOTTOMRIGHT", 3, 19)

		frame.resultlist.sheet.panel.hScroll:Point("TOPLEFT", frame.resultlist.sheet.panel, "BOTTOMLEFT", 17, -3)
		frame.resultlist.sheet.panel.hScroll:Point("TOPRIGHT", frame.resultlist.sheet.panel, "BOTTOMRIGHT", -19, -3)

		-- DeletePrompt
		private.deletePromptFrame:SetTemplate("Transparent")
		S:HandleButton(private.deletePromptFrame.yes)
		S:HandleButton(private.deletePromptFrame.no)

		-- ErrorFrame
		if private.scriptframe.loadError then
			private.scriptframe.loadError:SetTemplate("Transparent")
			S:HandleButton(private.scriptframe.loadError.close)
		else
			hooksecurefunc(private, "CreateErrorFrames", function()
				private.scriptframe.loadError:SetTemplate("Transparent")
				S:HandleButton(private.scriptframe.loadError.close)
			end)
		end
	end
end)