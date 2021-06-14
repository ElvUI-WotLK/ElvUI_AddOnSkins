local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

if not AS:IsAddonLODorEnabled("Enchantrix") then return end

-- Enchantrix 5.8.4723
-- https://www.curseforge.com/wow/addons/auctioneer/files/427823

S:AddCallbackForAddon("Enchantrix", "Enchantrix", function()
	if not E.private.addOnSkins.Enchantrix then return end

	AS:SkinLibrary("Configator")
	AS:SkinLibrary("LibExtraTip-1")

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

	if AutoDEPromptYes then
		SkinAutoDePrompt(AutoDEPromptYes:GetParent())
	else
		S:SecureHook(Enchantrix.AutoDisenchant, "AddonLoaded", function()
			SkinAutoDePrompt(AutoDEPromptYes:GetParent())
			S:Unhook(Enchantrix.AutoDisenchant, "AddonLoaded")
		end)
	end
end)