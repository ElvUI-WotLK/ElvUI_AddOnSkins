local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

if not AS:IsAddonLODorEnabled("TipTac") then return end

-- TipTac 10.05.01
-- https://www.curseforge.com/wow/addons/tip-tac/files/427096

S:AddCallbackForAddon("TipTac", "TipTac", function()
	if not E.private.addOnSkins.TipTac then return end

	if not TipTac_Config then
		TipTac_Config = {}
	end

	TipTac_Config.barTexture = E.media.normTex
	TipTac_Config.tipBackdropEdge = E.media.blankTex
	TipTac_Config.tipBackdropBG = E.media.blankTex
	TipTac_Config.backdropEdgeSize = E.mult
	TipTac_Config.tipColor = CopyTable(E.media.backdropfadecolor)
	TipTac_Config.tipBorderColor = CopyTable(E.media.bordercolor)
	TipTac_Config.gradientTip = false
	TipTac_Config.backdropInsets = E.mult

	if not TipTac.VARIABLES_LOADED then
		TipTac:ApplySettings()
	end

	-- Anchor frame
	TipTac:SetTemplate()
	S:HandleCloseButton(TipTac.close)

	local tooltips = {
		"AutoCompleteBox",
		"BNToastFrame",
		"DropDownList1MenuBackdrop",
		"DropDownList2MenuBackdrop",
		"DropDownList3MenuBackdrop",
		"FriendsTooltip",
	}

	for _, frame in ipairs(tooltips) do
		frame = _G[frame]
		if frame then
			frame:SetTemplate("Transparent")
		end
	end

	local TT = E:GetModule("Tooltip")
	local skinEnabled = E.private.skins.blizzard.enable and E.private.skins.blizzard.tooltip

	if not skinEnabled then
		S:HandleCloseButton(ItemRefCloseButton)
	end

	if skinEnabled and TT:IsHooked(GameTooltip, "OnShow") then
		local elvTooltips = {
			GameTooltip,
			ItemRefTooltip,
			ItemRefShoppingTooltip1,
			ItemRefShoppingTooltip2,
			ItemRefShoppingTooltip3,
			AutoCompleteBox,
			FriendsTooltip,
			ConsolidatedBuffsTooltip,
			ShoppingTooltip1,
			ShoppingTooltip2,
			ShoppingTooltip3,
			WorldMapTooltip,
			WorldMapCompareTooltip1,
			WorldMapCompareTooltip2,
			WorldMapCompareTooltip3
		}

		for _, tt in ipairs(elvTooltips) do
			if TT:IsHooked(tt, "OnShow") then
				TT:Unhook(tt, "OnShow", "SetStyle")
			end
		end
	else
		if skinEnabled then
			E.callbacks.events["SkinTooltip"] = nil
		end

		local function GameTooltip_ShowStatusBar_Skinned(tt, ...)
			local statusBar = _G[tt:GetName().."StatusBar"..tt.shownStatusBars]
			if statusBar and not statusBar.skinned then
				statusBar:StripTextures()
				statusBar:CreateBackdrop("Default")
				statusBar:SetStatusBarTexture(E.media.normTex)
				E:RegisterStatusBar(statusBar)
				statusBar.skinned = true
			end
		end

		S:SecureHook("GameTooltip_ShowStatusBar", GameTooltip_ShowStatusBar_Skinned)
	end
end)

S:AddCallbackForAddon("TipTacOptions", "TipTacOptions", function()
	if not E.private.addOnSkins.TipTac then return end

	TipTacOptions:StripTextures()
	TipTacOptions:SetTemplate("Transparent")
	TipTacOptions.outline:SetTemplate("Transparent")

	local buttons = {
		"btnAnchor",
		"btnReset",
		"btnClose",
	}

	for _, button in ipairs(buttons) do
		S:HandleButton(TipTacOptions[button])
	end

	AS:SkinLibrary("AzOptionsFactory")
end)