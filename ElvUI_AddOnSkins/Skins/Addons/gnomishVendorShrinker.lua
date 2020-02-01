local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")

-- GnomishVendorShrinker 3.3.0.6
-- https://www.curseforge.com/wow/addons/gnomishvendorshrinker/files/426171

local function LoadSkin()
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

	local GVS = E:GetModule("AddOnSkins"):FindChildFrameByPoint(MerchantFrame, "Frame", "TOPLEFT", MerchantFrame, "TOPLEFT", 21, -77)
	if not GVS then return end

	GVS:Point("TOPLEFT", 19, -70)

	MerchantBuyBackItem:ClearAllPoints()
	MerchantBuyBackItem:Point("BOTTOMLEFT", 187, 102)

	for _, child in ipairs({GVS:GetChildren()}) do
		local objType = child:GetObjectType()

		if objType == "EditBox" then
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
end

S:AddCallbackForAddon("GnomishVendorShrinker", "GnomishVendorShrinker", LoadSkin)