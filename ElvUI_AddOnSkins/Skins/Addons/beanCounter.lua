local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

if not AS:IsAddonLODorEnabled("BeanCounter") then return end

-- BeanCounter 5.8.4723
-- https://www.curseforge.com/wow/addons/auctioneer/files/427823

S:AddCallbackForAddon("BeanCounter", "BeanCounter", function()
	if not E.private.addOnSkins.BeanCounter then return end

	AS:SkinLibrary("Configator")

	local base = BeanCounterBaseFrame
	if base then
		local private = BeanCounter.Private
		local frame = private.frame

		base:SetTemplate("Transparent")
		S:HandleButton(base.Done)

		S:HandleNextPrevButton(base.Resizer, "right")
		S:SetNextPrevButtonDirection(base.Resizer, "right")

		S:HandleButton(private.frame.Config)
		S:HandleButton(private.frame.searchButton)

		frame.selectbox.box:StripTextures()
		frame.selectbox.box:CreateBackdrop("Default")
		frame.selectbox.box.backdrop:SetPoint("TOPLEFT", 18, -1)
		frame.selectbox.box.backdrop:SetPoint("BOTTOMRIGHT", -16, -13)
		_G[frame.selectbox.box:GetName().."Text"]:SetParent(frame.selectbox.box.backdrop)

		frame.selectbox.box.button:SetPoint("TOPRIGHT", -18, -3)
		S:HandleNextPrevButton(frame.selectbox.box.button)
		S:SetNextPrevButtonDirection(frame.selectbox.box.button)

		local searchBoxName = frame.searchBox:GetName()
		_G[searchBoxName.."Left"]:Hide()
		_G[searchBoxName.."Middle"]:Hide()
		_G[searchBoxName.."Right"]:Hide()
		frame.searchBox:SetTemplate("Default")

		S:HandleCheckBox(frame.exactCheck)
		S:HandleCheckBox(frame.neutralCheck)
		S:HandleCheckBox(frame.bidCheck)
		S:HandleCheckBox(frame.bidFailedCheck)
		S:HandleCheckBox(frame.auctionCheck)
		S:HandleCheckBox(frame.auctionFailedCheck)

		frame.resultlist:SetTemplate("Transparent")

		S:HandleScrollBar(frame.resultlist.sheet.panel.vScroll)
		S:HandleScrollBar(frame.resultlist.sheet.panel.hScroll, true)

		private.frame.slot:Hide()

		private.frame.icon:SetTemplate("Default")
		private.frame.icon:GetHighlightTexture():SetInside()
		private.frame.icon:GetHighlightTexture():SetTexture(1, 1, 1, 0.3)

		hooksecurefunc(private, "searchByItemID", function(id, settings, queryReturn, count, itemTexture, classic)
			if not itemTexture then return end

			private.frame.icon:GetNormalTexture():SetTexCoord(unpack(E.TexCoords))
			private.frame.icon:GetNormalTexture():SetInside()
		end)
	end
end)