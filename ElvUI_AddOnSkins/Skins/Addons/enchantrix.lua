local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")

-- Enchantrix 5.8.4723
-- https://www.curseforge.com/wow/addons/auctioneer/files/427823

local function LoadSkin()
	if not E.private.addOnSkins.Enchantrix then return end

	E:GetModule("AddOnSkins"):SkinLibrary("Configator")

	S:SecureHook(Enchantrix_Manifest, "ShowMessage", function()
		Enchantrix_Manifest.messageFrame:SetTemplate("Transparent")
		S:HandleButton(Enchantrix_Manifest.messageFrame.done)
		S:Unhook(Enchantrix_Manifest, "ShowMessage")
	end)

	local function SkinAutoDePrompt(frame)
		frame:SetTemplate("Transparent")

		S:HandleItemButton(AutoDisenchantPromptItem, true)
		AutoDisenchantPromptItem:GetNormalTexture():SetInside(AutoDisenchantPromptItem.backdrop)
		AutoDisenchantPromptItem:GetNormalTexture():SetTexCoord(unpack(E.TexCoords))

		S:HandleButton(AutoDEPromptYes)
		S:HandleButton(AutoDEPromptNo)
		S:HandleButton(AutoDEPromptIgnore)
	end

	if _G["AutoDEPromptYes"] then
		SkinAutoDePrompt(AutoDEPromptYes:GetParent())
	else
		S:SecureHook(Enchantrix.AutoDisenchant, "AddonLoaded", function()
			SkinAutoDePrompt(AutoDEPromptYes:GetParent())
			S:Unhook(Enchantrix.AutoDisenchant, "AddonLoaded")
		end)
	end

	E:GetModule("AddOnSkins"):SkinLibrary("LibExtraTip-1")
end

S:AddCallbackForAddon("Enchantrix", "Enchantrix", LoadSkin)