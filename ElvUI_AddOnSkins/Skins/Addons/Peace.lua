local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

if not AS:IsAddonLODorEnabled("Peace") then return end

local _G = _G
local ipairs = ipairs
local unpack = unpack

local hooksecurefunc = hooksecurefunc


S:AddCallbackForAddon("Peace", "Peace", function()
	if not E.private.addOnSkins.Peace then return end
	-- Master
	Peace_OptionsFrame:StripTextures()
	Peace_OptionsFrame:SetTemplate("Transparent")
	Peace_OptionsFrame:SetClampRectInsets(0, 0, 0, 0)

	local buttons = {
        "Peace_ManualClearHistoryButton",
        "AddNewAuthorisedButton",
        "DeleteAuthoriseButton",
        "IgnorePlayerWhisperButton",
        "Peace_CloseOptionsFrame",
        "Peace_CreditsButton",
        "Peace_ScanGuildFriendsButton",
        "Peace_CleanWholePlayerList"
	}

	local checkBoxes = {
        "Peace_EnableAddonCheck",
        "Peace_AutoAddGuildCheck",
        "Peace_AutoAddFriendsCheck",
        "Peace_InformWhenPlayerBlockedCheck",
        "Peace_DoSoundOnBlockCheck",
        "Peace_AutoAddWhisperedPlayersCheck",
        "Peace_NotifyBlockedPlayersCheck",
        "Peace_ResetBlockedWhisperHistoryCheck",
        "Peace_UseCustomMessageTextCheck"
	}

	local editBoxes = {
        "Peace_CustomMsgEditBox",
        "EnteredPlayerNameBox"
	}

	for _, button in ipairs(buttons) do
		S:HandleButton(_G[button])
	end
	for _, checkBox in ipairs(checkBoxes) do
		S:HandleCheckBox(_G[checkBox])
	end
	for _, editBox in ipairs(editBoxes) do
		S:HandleEditBox(_G[editBox])
	end
end)