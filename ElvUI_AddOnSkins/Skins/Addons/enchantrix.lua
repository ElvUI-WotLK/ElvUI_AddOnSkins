local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
-- Optional controls differ between supported addon versions. Keep missing
-- targets out of native skin handlers without masking other Lua errors.
local function SkinControl(method, frame, ...)
	if frame then return S[method](S, frame, ...) end
end
local function SkinFrame(frame, method, ...)
	if frame then return frame[method](frame, ...) end
end

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
		SkinControl("HandleButton", Enchantrix_Manifest.messageFrame.done)
		S:Unhook(Enchantrix_Manifest, "ShowMessage")
	end)

	local function SkinAutoDePrompt(frame)
		SkinFrame(frame, "SetTemplate", "Transparent")

		SkinControl("HandleItemButton", AutoDisenchantPromptItem, true)
		AutoDisenchantPromptItem:GetNormalTexture():SetInside(AutoDisenchantPromptItem.backdrop)
		AutoDisenchantPromptItem:GetNormalTexture():SetTexCoord(unpack(E.TexCoords))

		SkinControl("HandleButton", AutoDEPromptYes)
		SkinControl("HandleButton", AutoDEPromptNo)
		SkinControl("HandleButton", AutoDEPromptIgnore)
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
