local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

if not AS:IsAddonLODorEnabled("GnomishVendorShrinker") then return end

local unpack = unpack

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

	GVS:Point("TOPLEFT", 19, -52)

	MerchantBuyBackItem:ClearAllPoints()
	MerchantBuyBackItem:Point("BOTTOMLEFT", 187, 118)

	local popoutButtonOnEnter = function(self) self.icon:SetVertexColor(unpack(E.media.rgbvaluecolor)) end
	local popoutButtonOnLeave = function(self) self.icon:SetVertexColor(1, 1, 1) end

	for _, child in ipairs({GVS:GetChildren()}) do
		local objType = child:GetObjectType()

		if objType == "Button" then
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
				child.popout.icon:Point("CENTER")
				child.popout.icon:SetTexture(E.Media.Textures.ArrowUp)
				child.popout.icon:SetRotation(S.ArrowRotation.right)
			end
		elseif objType == "EditBox" then
			for _, region in ipairs({child:GetRegions()}) do
				if region:GetDrawLayer() == "BACKGROUND" then
					region:SetTexture(nil)
				end
			end

			child:Height(20)
			child:Point("TOPLEFT", GVS, "BOTTOMLEFT", 0, -63)
			S:HandleEditBox(child)
		elseif objType == "Slider" then
			for _, child2 in ipairs({child:GetChildren()}) do
				local objType2 = child2:GetObjectType()

				if objType2 == "Button" then
					local texture = child2:GetNormalTexture():GetTexture()

					if texture == "Interface\\Buttons\\UI-ScrollBar-ScrollUpButton-Up" then
						S:HandleNextPrevButton(child2, "up")
					elseif texture == "Interface\\Buttons\\UI-ScrollBar-ScrollDownButton-Up" then
						S:HandleNextPrevButton(child2, "down")
					end
				elseif objType2 == "Frame" then
					child2:SetBackdrop(nil)
				end
			end

			child:Width(18)
			child:Point("TOPRIGHT", 10, -18)
			child:Point("BOTTOMRIGHT", 10, 18)

			S:HandleScrollBar(child)
		end
	end
end)