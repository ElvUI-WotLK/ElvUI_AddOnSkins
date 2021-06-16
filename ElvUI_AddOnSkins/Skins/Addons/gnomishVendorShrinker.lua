local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

if not AS:IsAddonLODorEnabled("GnomishVendorShrinker") then return end

local unpack = unpack

local hooksecurefunc = hooksecurefunc

-- GnomishVendorShrinker 3.3.0.6
-- https://www.curseforge.com/wow/addons/gnomishvendorshrinker/files/426171

S:AddCallbackForAddon("GnomishVendorShrinker", "GnomishVendorShrinker", function()
	if not E.private.addOnSkins.GnomishVendorShrinker then return end

	if GVSEditBox then
		GVSEditBox:StripTextures()
		S:HandleEditBox(GVSEditBox)
		GVSEditBox:Size(135, 19)
		GVSEditBox:SetScale(1)

		GVSMerchantFrame:CreateBackdrop("Transparent")
		S:HandleButton(GVSScrollButton1)
		S:HandleButton(GVSScrollButton2)
		GVSScrollFrame:StripTextures()
		S:HandleSliderFrame(GVSScrollBar)

		return
	end

	local GVS = AS:FindChildFrameByPoint(MerchantFrame, "Frame", "TOPLEFT", MerchantFrame, "TOPLEFT", 21, -77)
	if not GVS then return end

	GVS:Size(304, 294)
	GVS:Point("TOPLEFT", 19, -54)
	GVS:SetTemplate("Transparent")

	MerchantBuyBackItem:ClearAllPoints()
	MerchantBuyBackItem:Point("BOTTOMLEFT", 187, 118)

	local popoutButtonOnEnter = function(self) self.icon:SetVertexColor(unpack(E.media.rgbvaluecolor)) end
	local popoutButtonOnLeave = function(self) self.icon:SetVertexColor(1, 1, 1) end
	local skinCurrencyIcons = function(self)
		if self.altframesSkinned < #self.altframes then
			for _, frame in ipairs(self.altframes) do
				frame.icon:SetTexCoord(unpack(E.TexCoords))
			end
			self.altframesSkinned = #self.altframes
		end
	end

	for _, child in ipairs({GVS:GetChildren()}) do
		local objType = child:GetObjectType()

		if objType == "Button" then
			child:Point("RIGHT", -3, 0)

			S:HandleButtonHighlight(child)

			if child.icon then
				child.icon:SetTexCoord(unpack(E.TexCoords))
			end

			if child.popout then
				child.popout:StripTextures()
				child.popout:HookScript("OnEnter", popoutButtonOnEnter)
				child.popout:HookScript("OnLeave", popoutButtonOnLeave)

				child.popout.icon = child.popout:CreateTexture(nil, "ARTWORK")
				child.popout.icon:Size(21)
				child.popout.icon:SetPoint("CENTER")
				child.popout.icon:SetTexture(E.Media.Textures.ArrowUp)
				child.popout.icon:SetRotation(S.ArrowRotation.right)
			end

			child.altframesSkinned = 0
			hooksecurefunc(child, "AddAltCurrency", skinCurrencyIcons)
		elseif objType == "EditBox" then
			for _, region in ipairs({child:GetRegions()}) do
				if region:GetDrawLayer() == "BACKGROUND" then
					region:SetTexture(nil)
				end
			end

			child:Height(18)
			child:Point("TOPLEFT", GVS, "BOTTOMLEFT", 1, -61)
			S:HandleEditBox(child)
		elseif objType == "Slider" then
			for _, child2 in ipairs({child:GetChildren()}) do
				local objType2 = child2:GetObjectType()

				if objType2 == "Button" then
					local texture = child2:GetNormalTexture():GetTexture()

					if texture == "Interface\\Buttons\\UI-ScrollBar-ScrollUpButton-Up" then
						S:HandleNextPrevButton(child2, "up")
						child2:Point("BOTTOM", child2:GetParent(), "TOP", 0, 1)
					elseif texture == "Interface\\Buttons\\UI-ScrollBar-ScrollDownButton-Up" then
						S:HandleNextPrevButton(child2, "down")
						child2:Point("TOP", child2:GetParent(), "BOTTOM", 0, -1)
					end
				elseif objType2 == "Frame" then
					child2:SetBackdrop(nil)
				end
			end

			child:Width(18)
			child:Point("TOPRIGHT", 21, -19)
			child:Point("BOTTOMRIGHT", 21, 19)

			S:HandleScrollBar(child)
		end
	end
end)