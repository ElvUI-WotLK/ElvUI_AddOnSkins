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

if not AS:IsAddonLODorEnabled("!ElvinCDs") then return end

local format = string.format

-- !ElvinCDs 0.1b
-- https://github.com/bkader/ElvinCDs

S:AddCallbackForAddon("!ElvinCDs", "!ElvinCDs", function()
	if not E.private.addOnSkins.ElvinCDs then return end

	hooksecurefunc(ElvinCDs.utils, "showHide", function(obj)
		if not obj.isSkinned then
			local objectType = obj:GetObjectType()

			if objectType == "Frame" then
				local objName = obj:GetName()
				local bars = _G[format("%sBars", objName)]

				if bars then
					SkinFrame(_G[format("%sBackground", objName)], "StripTextures")

					local title = _G[format("%sTitle", objName)]
					SkinFrame(title, "SetBackdrop", nil)
					title:CreateBackdrop("Transparent")
					title.backdrop:Point("TOPRIGHT", 19, -1)

					SkinFrame(bars, "Point", "TOPLEFT", title, "BOTTOMLEFT", 0, -1)
				end
			elseif objectType == "StatusBar" then
				obj:CreateBackdrop("Transparent")
				obj:SetStatusBarTexture(E.media.normTex)
				E:RegisterStatusBar(obj)
			end

			obj.isSkinned = true
		end
	end)

	-- logs
	SkinFrame(ElvinCDs_Logs, "SetTemplate", "Transparent")
	SkinFrame(ElvinCDs_LogsList, "SetBackdrop", nil)

	SkinControl("HandleCloseButton", ElvinCDs_LogsCloseButton, ElvinCDs_Logs)
	SkinControl("HandleScrollBar", ElvinCDs_LogsListScrollFrameScrollBar)

	SkinFrame(ElvinCDs_LogsListScrollFrameScrollBar, "Point", "TOPLEFT", ElvinCDs_LogsListScrollFrame, "TOPRIGHT", 5, -13)
	SkinFrame(ElvinCDs_LogsListScrollFrameScrollBar, "Point", "BOTTOMLEFT", ElvinCDs_LogsListScrollFrame, "BOTTOMRIGHT", 5, 19)

	-- options
	E:GetModule("Tooltip"):HookScript(ElvinCDs_Tooltip, "OnShow", "SetStyle")

	SkinFrame(ElvinCDs_Config, "SetTemplate", "Transparent")
	SkinFrame(ElvinCDs_ConfigTitleBG, "StripTextures")

	SkinFrame(ElvinCDs_Config_SpellsList, "SetTemplate", "Transparent")

	SkinControl("HandleTab", ElvinCDs_ConfigTab1)
	SkinControl("HandleTab", ElvinCDs_ConfigTab2)

	SkinControl("HandleButton", ElvinCDs_ConfigClose)
	SkinControl("HandleButton", ElvinCDs_Config_GeneralDefault)
	SkinControl("HandleButton", ElvinCDs_Config_SpellsSave)

	SkinControl("HandleSliderFrame", ElvinCDs_Config_General_width)
	SkinControl("HandleSliderFrame", ElvinCDs_Config_General_height)
	SkinControl("HandleSliderFrame", ElvinCDs_Config_General_opacity)
	SkinControl("HandleSliderFrame", ElvinCDs_Config_General_spacing)

	SkinControl("HandleEditBox", ElvinCDs_Config_SpellsSearch)
	SkinControl("HandleEditBox", ElvinCDs_Config_SpellsSpellId)
	SkinControl("HandleEditBox", ElvinCDs_Config_SpellsCooldown)

	SkinControl("HandleScrollBar", ElvinCDs_Config_SpellsListScrollFrameScrollBar)

	local checkBoxes = {
		ElvinCDs_Config_General_enabled,
		ElvinCDs_Config_General_icons,
		ElvinCDs_Config_General_strict,
		ElvinCDs_Config_General_announce,
		ElvinCDs_Config_General_shout,
		ElvinCDs_Config_General_verbose,
		ElvinCDs_Config_General_locked,
		ElvinCDs_Config_General_sync,
		ElvinCDs_Config_General_showInBG,
		ElvinCDs_Config_General_showInRaid,
		ElvinCDs_Config_General_showInParty,
		ElvinCDs_Config_General_showWhenSolo,

		ElvinCDs_Config_SpellsCustom,
		ElvinCDs_Config_SpellsDefaults,
		ElvinCDs_Config_SpellsDisplay,
		ElvinCDs_Config_SpellsTrack,
		ElvinCDs_Config_SpellsBlind,
		ElvinCDs_Config_SpellsShout,
		ElvinCDs_Config_SpellsWhisper,
		ElvinCDs_Config_SpellsSpecial,
	}

	for _, checkBox in ipairs(checkBoxes) do
		SkinControl("HandleCheckBox", checkBox)
	end

	SkinFrame(ElvinCDs_Config_SpellsSearch, "Height", 22)
	SkinFrame(ElvinCDs_Config_SpellsSpellId, "Height", 22)
	SkinFrame(ElvinCDs_Config_SpellsCooldown, "Height", 22)

	SkinFrame(ElvinCDs_ConfigTab1, "Point", "CENTER", ElvinCDs_Config, "BOTTOMLEFT", 60, -14)
	SkinFrame(ElvinCDs_ConfigClose, "Point", "TOPRIGHT", -6, -6)

	SkinFrame(ElvinCDs_Config_SpellsListScrollFrameScrollBar, "Point", "TOPLEFT", ElvinCDs_Config_SpellsListScrollFrame, "TOPRIGHT", 5, -15)
	SkinFrame(ElvinCDs_Config_SpellsListScrollFrameScrollBar, "Point", "BOTTOMLEFT", ElvinCDs_Config_SpellsListScrollFrame, "BOTTOMRIGHT", 5, 14)

	SkinFrame(ElvinCDs_Config_SpellsSpellId, "Point", "TOPLEFT", ElvinCDs_Config_SpellsList, "BOTTOMLEFT", 8, -10)

--[[
	local options = {
		"Display",
		"Track",
		"Blind",
		"Shout",
		"Whisper",
		"Special",
	}

	local skinnedCheckboxes = 0
	local function skinButtons()
		local i = skinnedCheckboxes + 1
		local button = _G["ElvinCDs_Config_Spells_SpellBtn_"..i]
		while button do
			for _, affix in ipairs(options) do
				SkinControl("HandleCheckBox", _G["ElvinCDs_Config_Spells_SpellBtn_"..i..affix])
			end
			i = i + 1
			button = _G["ElvinCDs_Config_Spells_SpellBtn_"..i]
		end
		skinnedCheckboxes = i - 1
	end

	local _SetChecked = ElvinCDs_Config_SpellsDefaults.SetChecked
	ElvinCDs_Config_SpellsDefaults.SetChecked = function(self, checked, ...)
		skinButtons()

		_SetChecked(self, checked, ...)
		self.SetChecked = _SetChecked
	end

	hooksecurefunc(ElvinCDs.Config.Spells, "save", function(self, button)
		if not button then return end
		skinButtons()
	end)
--]]
end)
