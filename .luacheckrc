std = "lua51c"
codes = true
ranges = true
quiet = 1

cache = true

max_line_length = false
max_code_line_length = false
max_string_line_length = false
max_comment_line_length = false

exclude_files = {
	"./.git",
	"./.github",
	"./.lua",
	"./.luarocks",
	"**/Libraries",
}

ignore = {
	"112", -- Mutating an undefined global variable
	"142", -- Setting an undefined field of a global variable
	"143", -- Accessing an undefined field of a global variable
	"212", -- Unused argument

	"1/SLASH_.*",			-- Setting/Mutating/Accessing an undefined global variable (Slash commands)
	"211/[E|L|V|P|G]",		-- Unused local variable
	"213/i",				-- Unused loop variable
	"432/self",				-- Shadowing an upvalue

	"113",
	"131",
	"421",
	"431",
}

globals = {
	-- AtlasQuest
	"AQ_AtlasOrAlphamap",
	"AtlasORAlphaMap",

	-- ChatBar
	"ChatBar_ButtonScale",
	"ChatBar_UpdateArt",
	"ChatBar_Toggle_LargeButtons",
	"ChatBar_VerticalDisplay_Sliding",
	"ChatBar_AlternateDisplay_Sliding",
	"ChatBar_LargeButtons_Sliding",
	"ChatBar_UpdateButtonOrientation",

	-- Doom_CooldownPulse
	"Doom_CooldownPulse",

	-- QuestGuru
	"QUESTS_DISPLAYED",
	"QUESTGURU_QUESTS_DISPLAYED",
	"QuestGuru_UpdateGossipFrame",
	"QuestGuru_UpdateProgressFrame",
	"QuestGuru_UpdateDetailFrame",
	"QuestGuru_QuestFrameGreetingPanel_OnShow",

	-- QuestGuruTracker
	"QGT_SetQuestWatchBorder",
	"QGT_SetAchievementWatchBorder",
	"QGT_QuestWatchButton_OnClick",

	-- TellMeWhen
	"TELLMEWHEN_ICONSPACING",

	-- TipTac
	"TipTac_Config",
}