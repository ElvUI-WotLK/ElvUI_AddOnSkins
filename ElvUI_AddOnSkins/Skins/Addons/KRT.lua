local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

if not AS:IsAddonLODorEnabled("!KRT") then return end

local _G = _G
local ipairs = ipairs
local unpack = unpack

local hooksecurefunc = hooksecurefunc


S:AddCallbackForAddon("!KRT", "!KRT", function()
	if not E.private.addOnSkins.KRT then return end
	-- Master
	KRTMaster:StripTextures()
	KRTMaster:SetTemplate("Transparent")
	KRTMaster:SetClampRectInsets(0, 0, 0, 0)
	-- Config
	KRTConfig:StripTextures()
	KRTConfig:SetTemplate("Transparent")
	KRTConfig:SetClampRectInsets(0, 0, 0, 0)
	-- Warnings
	KRTWarnings:StripTextures()
	KRTWarnings:SetTemplate("Transparent")
	KRTWarnings:SetClampRectInsets(0, 0, 0, 0)
	-- Loot History
	KRTLogger:StripTextures()
	KRTLogger:SetTemplate("Transparent")
	KRTLogger:SetClampRectInsets(0, 0, 0, 0)
	-- Spammer
	KRTSpammer:StripTextures()
	KRTSpammer:SetTemplate("Transparent")
	KRTSpammer:SetClampRectInsets(0, 0, 0, 0)
	-- MS Changes
	KRTChanges:StripTextures()
	KRTChanges:SetTemplate("Transparent")
	KRTChanges:SetClampRectInsets(0, 0, 0, 0)

	-- Loot History
	_G["KRTLoggerRaidsHeaderNum"]:StripTextures()
	_G["KRTLoggerRaidsHeaderDate"]:StripTextures()
	_G["KRTLoggerRaidsHeaderZone"]:StripTextures()
	_G["KRTLoggerRaidsHeaderSize"]:StripTextures()
	_G["KRTLoggerBossesHeaderNum"]:StripTextures()
	_G["KRTLoggerBossesHeaderName"]:StripTextures()
	_G["KRTLoggerBossesHeaderTime"]:StripTextures()
	_G["KRTLoggerBossesHeaderMode"]:StripTextures()
	_G["KRTLoggerBossAttendeesHeaderName"]:StripTextures()
	_G["KRTLoggerRaidAttendeesHeaderName"]:StripTextures()
	_G["KRTLoggerRaidAttendeesHeaderJoin"]:StripTextures()
	_G["KRTLoggerRaidAttendeesHeaderLeave"]:StripTextures()
	_G["KRTLoggerLootHeaderItem"]:StripTextures()
	_G["KRTLoggerLootHeaderSource"]:StripTextures()
	_G["KRTLoggerLootHeaderWinner"]:StripTextures()
	_G["KRTLoggerLootHeaderType"]:StripTextures()
	_G["KRTLoggerLootHeaderRoll"]:StripTextures()
	_G["KRTLoggerLootHeaderTime"]:StripTextures()

	local scrollBars = {
		-- Main Frame
		"KRTMasterScrollFrameScrollBar",

		-- Warning
		"KRTWarningsScrollFrameScrollBar",

		-- History
		"KRTLoggerRaidsScrollFrameScrollBar",
		"KRTLoggerBossesScrollFrameScrollBar",
		"KRTLoggerBossAttendeesScrollFrameScrollBar",
		"KRTLoggerRaidAttendeesScrollFrameScrollBar",
		"KRTLoggerLootScrollFrameScrollBar",

		-- MS Changes
		"KRTChangesScrollFrameScrollBar",
	}

	local buttons = {
		-- Master
		"KRTMasterCountdownBtn",
		"KRTMasterFreeBtn",
		"KRTMasterOSBtn",
		"KRTMasterMSBtn",
		"KRTMasterSelectItemBtn",
		"KRTMasterSpamLootBtn",
		"KRTMasterAwardBtn",
		"KRTMasterRollBtn",
		"KRTMasterClearBtn",
		"KRTMasterHoldBtn",
		"KRTMasterBankBtn",
		"KRTMasterDisenchantBtn",
		"KRTMasterConfigBtn",
		"KRTMasterItemBtn",

		-- Config
		"KRTConfigDefaultsBtn",
		"KRTConfigCloseBtn",

		-- Warning
		"KRTWarningsEditBtn",
		"KRTWarningsDeleteBtn",
		"KRTWarningsAnnounceBtn",

		-- History
		"KRTLoggerRaidsCurrentBtn",
		"KRTLoggerRaidsExportBtn",
		"KRTLoggerRaidsDeleteBtn",
		"KRTLoggerBossesAddBtn",
		"KRTLoggerBossesEditBtn",
		"KRTLoggerBossesDeleteBtn",
		"KRTLoggerBossAttendeesAddBtn",
		"KRTLoggerBossAttendeesRemoveBtn",
		"KRTLoggerRaidAttendeesAddBtn",
		"KRTLoggerRaidAttendeesDeleteBtn",
		"KRTLoggerLootExportBtn",
		"KRTLoggerLootClearBtn",
		"KRTLoggerLootAddBtn",
		"KRTLoggerLootEditBtn",
		"KRTLoggerLootDeleteBtn",
		
		-- Spammer
		"KRTSpammerStartBtn",
		"KRTSpammerClearBtn",

		-- MS Changes
		"KRTChangesAddBtn",
		"KRTChangesEditBtn",
		"KRTChangesDemandBtn",
		"KRTChangesAnnounceBtn",
		"KRTChangesClearBtn",
	}

	local checkBoxes = {
		-- Config
		"KRTConfigsortAscending",
		"KRTConfiguseRaidWarning",
		"KRTConfigannounceOnWin",
		"KRTConfigannounceOnHold",
		"KRTConfigannounceOnBank",
		"KRTConfigannounceOnDisenchant",
		"KRTConfiglootWhispers",
		"KRTConfigcountdownRollsBlock",
		"KRTConfigscreenReminder",
		"KRTConfigignoreStacks",
		"KRTConfigshowTooltips",
		"KRTConfigminimapButton",

		-- Spammer
		"KRTSpammerChat1",
		"KRTSpammerChat2",
		"KRTSpammerChat3",
		"KRTSpammerChat4",
		"KRTSpammerChat5",
		"KRTSpammerChat6",
		"KRTSpammerChat7",
		"KRTSpammerChat8",
		"KRTSpammerChatGuild",
		"KRTSpammerChatYell",
	}

	local editBoxes = {
		-- Master
		"KRTMasterItemCount",
		-- Warnings
		"KRTWarningsName",
		"KRTWarningsContent",

		-- Spammer
		"KRTSpammerName",
		"KRTSpammerDuration",
		"KRTSpammerTank",
		"KRTSpammerHealer",
		"KRTSpammerMelee",
		"KRTSpammerRanged",
		"KRTSpammerMessage",
		"KRTSpammerTankClass",
		"KRTSpammerHealerClass",
		"KRTSpammerMeleeClass",
		"KRTSpammerRangedClass",

	}

	local dropDownBoxes = {
		-- Main Frame
		"KRTMasterHoldDropDown",
		"KRTMasterBankDropDown",
		"KRTMasterDisenchantDropDown",
	}

	local closeButtons = {
		-- Main Frame
		"KRTMasterClose",
		-- Config
		"KRTConfigClose",
		-- Warning
		"KRTWarningsClose",
		-- History
		"KRTLoggerClose",
		-- Spammer
		"KRTSpammerClose",
		-- MS Changes
		"KRTChangesClose",
	}

	local statusBars = {
		-- History

	}

	local sliderFrames = {
		-- Config
		"KRTConfigcountdownDuration",
	}

	for _, scrollBar in ipairs(scrollBars) do
		scrollBar = _G[scrollBar]
		scrollBar:GetParent():StripTextures()
		S:HandleScrollBar(scrollBar)
	end
	for _, button in ipairs(buttons) do
		S:HandleButton(_G[button])
	end
	for _, checkBox in ipairs(checkBoxes) do
		S:HandleCheckBox(_G[checkBox])
	end
	for _, editBox in ipairs(editBoxes) do
		S:HandleEditBox(_G[editBox])
	end
	for _, dropDownBox in ipairs(dropDownBoxes) do
		S:HandleDropDownBox(_G[dropDownBox])
	end
	for _, closeButton in ipairs(closeButtons) do
		closeButton = _G[closeButton]
		S:HandleCloseButton(closeButton, closeButton:GetParent().backdrop)
	end
	for _, sliderFrame in ipairs(sliderFrames) do
		sliderFrame = _G[sliderFrame]
		S:HandleSliderFrame(sliderFrame)
	end
	for _, statusBar in ipairs(statusBars) do
		statusBar = _G[statusBar]
		statusBar:StripTextures()
		statusBar:CreateBackdrop()
		statusBar:SetStatusBarTexture(E.media.normTex)
		E:RegisterStatusBar(statusBar)
	end
end)