local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

if not AS:IsAddonLODorEnabled("WIM") then return end

local format = string.format

-- WIM 3.3.7
-- https://www.wowace.com/projects/wim-3/files/439176

S:AddCallbackForAddon("WIM", "WIM", function()
	if not E.private.addOnSkins.WIM then return end

	local function formatDetails(window, guild, level, race, class)
		if guild == "" then
			return format("|cffffffff %s %s %s|r", level, race, class)
		else
			return format("|cffffffff<%s> %s %s %s|r", guild, level, race, class)
		end
	end

	local WIM_Elvui = {
		title = "WIM ElvUI",
		version = "1.0.0",
		author = "Divico",
		website = "",
		message_window = {
			texture = "Interface\\AddOns\\ElvUI_AddOnSkins\\media\\wim\\message_window",
			min_width = 256,
			min_height = 128,
			backdrop = {
				top_left = {
					width = 64,
					height = 64,
					offset = {0, 0},
					texture_coord = {0, 0, 0, .25, .25, 0, .25, .25}
				},
				top_right = {
					width = 64,
					height = 64,
					offset = {0, 0},
					texture_coord = {.75, 0, .75, .25, 1, 0, 1, .25}
				},
				bottom_left = {
					width = 64,
					height = 64,
					offset = {0, 0},
					texture_coord = {0, .75, 0, 1, .25, .75, .25, 1}
				},
				bottom_right = {
					width = 64,
					height = 64,
					offset = {0, 0},
					texture_coord = {.75, .75, .75, 1, 1, .75, 1, 1}
				},
				top = {
					tile = false,
					texture_coord = {.25, 0, .25, .25, .75, 0, .75, .25}
				},
				bottom = {
					tile = false,
					texture_coord = {.25, .75, .25, 1, .75, .75, .75, 1}
				},
				left = {
					tile = false,
					texture_coord = {0, .25, 0, .75, .25, .25, .25, .75}
				},
				right = {
					tile = false,
					texture_coord = {.75, .25, .75, .75, 1, .25, 1, .75}
				},
				background = {
					tile = false,
					texture_coord = {.25, .25, .25, .75, .75, .25, .75, .75}
				}
			},
			widgets = {
				class_icon = {
					texture = "Interface\\AddOns\\ElvUI_AddOnSkins\\media\\wim\\class_icons",
					chatAlphaMask = "Interface\\AddOns\\ElvUI_AddOnSkins\\media\\wim\\chatAlphaMask",
					width = 16, -- 64
					height = 16, -- 64
					points = {
						{"TOPLEFT", "window", "TOPLEFT", 4, -4} -- "TOPLEFT", "window", "TOPLEFT", -10, 12
					},
					is_round = false, -- true
					blank = {.5, .5, .5, .75, .75, .5, .75, .75},
					druid = {0, 0, 0, .25, .25, 0, .25, .25},
					hunter = {.25, 0, .25, .25, .5, 0, .5, .25},
					mage = {.5, 0, .5, .25, .75, 0, .75, .25},
					paladin = {.75, 0, .75, .25, 1, 0, 1, .25},
					priest = {0, .25, 0, .5, .25, .25, .25, .5},
					rogue = {.25, .25, .25, .5, .5, .25, .5, .5},
					shaman = {.5, .25, .5, .5, .75, .25, .75, .5},
					warlock = {.75, .25, .75, .5, 1, .25, 1, .5},
					warrior = {0, .5, 0, .75, .25, .5, .25, .75},
					deathknight = {.75, .5, .75, .75, 1, .5, 1, .75},
					gm = {.25, .5, .25, .75, .5, .5, .5, .75}
				},
				from = {
					points = {
						{"TOPLEFT", "window", "TOPLEFT", 24, -7} -- "TOPLEFT", "window", "TOPLEFT", 50, -8
					},
					font = "FriendsFont_Normal", -- GameFontNormalLarge
					font_color = "ffffff",
					font_height = 11, -- 16
					font_flags = "",
					use_class_color = true
				},
				char_info = {
					format = formatDetails,
					points = {
						{"TOPRIGHT", "window", "TOPRIGHT", -25, -7} -- "TOP", "window", "TOP", 0, -30
					},
					font = "FriendsFont_Normal", -- GameFontNormal
					font_color = "1883d1" -- ffffff
				},
				close = {
					state_hide = {
						NormalTexture = "Interface\\AddOns\\ElvUI_AddOnSkins\\media\\wim\\icons\\hide",
						PushedTexture = "Interface\\AddOns\\ElvUI_AddOnSkins\\media\\wim\\icons\\hide_pushed",
						HighlightTexture = "Interface\\AddOns\\ElvUI_AddOnSkins\\media\\wim\\icons\\button_highlight",
						HighlightAlphaMode = "ADD"
					},
					state_close = {
						NormalTexture = "Interface\\AddOns\\ElvUI_AddOnSkins\\media\\wim\\icons\\close",
						PushedTexture = "Interface\\AddOns\\ElvUI_AddOnSkins\\media\\wim\\icons\\close_pushed",
						HighlightTexture = "Interface\\AddOns\\ElvUI_AddOnSkins\\media\\wim\\icons\\button_highlight",
						HighlightAlphaMode = "ADD"
					},
					width = 16, -- 32
					height = 16, -- 32
					points = {
						{"TOPRIGHT", "window", "TOPRIGHT", -4, -4} -- "TOPRIGHT", "window", "TOPRIGHT", 4, 1
					}
				},
				history = {
					NormalTexture = "Interface\\AddOns\\ElvUI_AddOnSkins\\media\\wim\\icons\\history",
					PushedTexture = "Interface\\AddOns\\ElvUI_AddOnSkins\\media\\wim\\icons\\history_pushed",
					HighlightTexture = "Interface\\AddOns\\ElvUI_AddOnSkins\\media\\wim\\icons\\button_highlight",
					HighlightAlphaMode = "ADD",
					width = 16, -- 18
					height = 16, -- 18
					points = {
						{"BOTTOMRIGHT", "window", "BOTTOMRIGHT", -3, 44} -- "TOPRIGHT", "window", "TOPRIGHT", -28, -6
					}
				},
				w2w = {
					NormalTexture = "Interface\\AddOns\\ElvUI_AddOnSkins\\media\\wim\\icons\\w2w",
					PushedTexture = "Interface\\AddOns\\ElvUI_AddOnSkins\\media\\wim\\icons\\w2w",
					HighlightTexture = "Interface\\AddOns\\ElvUI_AddOnSkins\\media\\wim\\icons\\w2w",
					HighlightAlphaMode = "ADD",
					points = {
						{"TOPLEFT", "class_icon", 14, -14},
						{"BOTTOMRIGHT", "class_icon", -14, 14}
					}
				},
				chat_info = {
					NormalTexture = "",
					PushedTexture = "Interface\\AddOns\\ElvUI_AddOnSkins\\media\\wim\\w2w",
					HighlightTexture = "Interface\\AddOns\\ElvUI_AddOnSkins\\media\\wim\\w2w",
					HighlightAlphaMode = "ADD",
					points = {
						{"TOPLEFT", "class_icon", 14, -14},
						{"BOTTOMRIGHT", "class_icon", -14, 14}
					}
				},
				chatting = {
					NormalTexture = "Interface\\AddOns\\ElvUI_AddOnSkins\\media\\wim\\icons\\chatting",
					PushedTexture = "Interface\\AddOns\\ElvUI_AddOnSkins\\media\\wim\\icons\\chatting",
					width = 16,
					height = 16,
					points = {
						{"TOPLEFT", "window", -3, -23} -- "TOPLEFT", "window", 45, -28
					}
				},
				scroll_up = {
					NormalTexture = "Interface\\AddOns\\ElvUI_AddOnSkins\\media\\wim\\icons\\scroll_up",
					PushedTexture = "Interface\\AddOns\\ElvUI_AddOnSkins\\media\\wim\\icons\\scroll_up_pushed",
					HighlightTexture = "Interface\\AddOns\\ElvUI_AddOnSkins\\media\\wim\\icons\\button_highlight",
					DisabledTexture = "Interface\\AddOns\\ElvUI_AddOnSkins\\media\\wim\\icons\\button_disabled",
					HighlightAlphaMode = "ADD",
					width = 16, -- 32
					height = 16, -- 32
					points = {
						{"TOPRIGHT", "window", "TOPRIGHT", -3, -23} -- "TOPRIGHT", "window", "TOPRIGHT", -4, -39
					}
				},
				scroll_down = {
					NormalTexture = "Interface\\AddOns\\ElvUI_AddOnSkins\\media\\wim\\icons\\scroll_down",
					PushedTexture = "Interface\\AddOns\\ElvUI_AddOnSkins\\media\\wim\\icons\\scroll_down_pushed",
					HighlightTexture = "Interface\\AddOns\\ElvUI_AddOnSkins\\media\\wim\\icons\\button_highlight",
					DisabledTexture = "Interface\\AddOns\\ElvUI_AddOnSkins\\media\\wim\\icons\\button_disabled",
					HighlightAlphaMode = "ADD",
					width = 16, -- 32
					height = 16, -- 32
					points = {
						{"BOTTOMRIGHT", "window", "BOTTOMRIGHT", -3, 27} -- "BOTTOMRIGHT", "window", "BOTTOMRIGHT", -4, 24
					}
				},
				chat_display = {
					points = {
						{"TOPLEFT", "window", "TOPLEFT", 4, -24}, -- "TOPLEFT", "window", "TOPLEFT", 24, -46
						{"BOTTOMRIGHT", "window", "BOTTOMRIGHT", -22, 27} -- "BOTTOMRIGHT", "window", "BOTTOMRIGHT", -38, 39
					},
					font = "FriendsFont_UserText", -- ChatFontNormal
					font_height = 12,
					font_flags = ""
				},
				msg_box = {
					font = "FriendsFont_UserText", -- ChatFontNormal
					font_height = 14,
					font_color = {1,1,1},
					points = {
						{"TOPLEFT", "window", "BOTTOMLEFT", 6, 25}, -- "TOPLEFT", "window", "BOTTOMLEFT", 24, 30
						{"BOTTOMRIGHT", "window", "BOTTOMRIGHT", -3, 1} -- "BOTTOMRIGHT", "window", "BOTTOMRIGHT", -10, 4
					}
				},
				resize = {
					NormalTexture = "Interface\\AddOns\\ElvUI_AddOnSkins\\media\\wim\\icons\\resize",
					PushedTexture = "Interface\\AddOns\\ElvUI_AddOnSkins\\media\\wim\\icons\\resize",
					HighlightTexture = "Interface\\AddOns\\ElvUI_AddOnSkins\\media\\wim\\icons\\resize",
					HighlightAlphaMode = "ADD",
					width = 16, -- 25
					height = 16, -- 25
					points = {
						{"BOTTOMLEFT", "window", "BOTTOMRIGHT", -16, 0} -- "BOTTOMRIGHT", "window", "BOTTOMRIGHT", 5, -5
					}
				},
				shortcuts = {
					stack = "DOWN",
					spacing = 1, -- 2
					points = {
						{"TOPLEFT", "window", "TOPRIGHT", -19, -40}, -- "TOPLEFT", "window", "TOPRIGHT", -30, -70
						{"BOTTOMRIGHT", "window", "BOTTOMRIGHT", -3, 105} -- "BOTTOMRIGHT", "window", "BOTTOMRIGHT", -8, 55
					},
					buttons = {
						NormalTexture = "Interface\\AddOns\\ElvUI_AddOnSkins\\media\\wim\\icons\\button_frame",
						PushedTexture = "Interface\\AddOns\\ElvUI_AddOnSkins\\media\\wim\\icons\\button_pushed",
						HighlightTexture = "Interface\\AddOns\\ElvUI_AddOnSkins\\media\\wim\\icons\\button_highlight",
						HighlightAlphaMode = "ADD",
						icons = {
							location = "Interface\\AddOns\\ElvUI_AddOnSkins\\media\\wim\\icons\\location",
							invite = "Interface\\AddOns\\ElvUI_AddOnSkins\\media\\wim\\icons\\invite",
							friend = "Interface\\AddOns\\ElvUI_AddOnSkins\\media\\wim\\icons\\friend",
							ignore = "Interface\\AddOns\\ElvUI_AddOnSkins\\media\\wim\\icons\\ignore"
						}
					}
				}
			}
		},
		tab_strip = {
			textures = {
				tab = {
					NormalTexture = "Interface\\AddOns\\ElvUI_AddOnSkins\\media\\wim\\tab_normal",
					PushedTexture = "Interface\\AddOns\\ElvUI_AddOnSkins\\media\\wim\\tab_selected",
					HighlightTexture = "Interface\\AddOns\\ElvUI_AddOnSkins\\media\\wim\\tab_flash",
				--	HighlightTexture = "Interface\\PaperDollInfoFrame\\UI-Character-Tab-Highlight",
					HighlightAlphaMode = "ADD"
				},
				prev = {
					NormalTexture = "Interface\\AddOns\\ElvUI_AddOnSkins\\media\\wim\\icons\\prev",
					PushedTexture = "Interface\\AddOns\\ElvUI_AddOnSkins\\media\\wim\\icons\\prev_pushed",
					DisabledTexture = "Interface\\AddOns\\ElvUI_AddOnSkins\\media\\wim\\icons\\prev",
					HighlightTexture = "Interface\\AddOns\\ElvUI_AddOnSkins\\media\\wim\\icons\\button_highlight",
					HighlightAlphaMode = "ADD",
					height = 16, -- 20
					width = 16 -- 20
				},
				next = {
					NormalTexture = "Interface\\AddOns\\ElvUI_AddOnSkins\\media\\wim\\icons\\next",
					PushedTexture = "Interface\\AddOns\\ElvUI_AddOnSkins\\media\\wim\\icons\\next_pushed",
					DisabledTexture = "Interface\\AddOns\\ElvUI_AddOnSkins\\media\\wim\\icons\\next",
					HighlightTexture = "Interface\\AddOns\\ElvUI_AddOnSkins\\media\\wim\\icons\\button_highlight",
					HighlightAlphaMode = "ADD",
					height = 16, -- 20
					width = 16 -- 20
				}
			},
			height = 20, -- 26
			points = {
				{"BOTTOMLEFT", "window", "TOPLEFT", 18, 4}, -- "BOTTOMLEFT", "window", "TOPLEFT", 38, -4
				{"BOTTOMRIGHT", "window", "TOPRIGHT", -18, 4} -- "BOTTOMRIGHT", "window", "TOPRIGHT", -20, -4
			},
			text = {
				font = "SystemFont_Small", -- ChatFontNormal
				font_color = {1, 1, 1},
				font_height = 11, -- 12
				font_flags = ""
			},
			vertical = false
		}
	}

	local function ApplySkin(self)
		self.db.skin.selected = "WIM ElvUI"
		self.RegisterSkin(WIM_Elvui)
	end

	if WIM.db then
		ApplySkin(WIM)
	else
		hooksecurefunc(WIM, "VARIABLES_LOADED", function(self)
			ApplySkin(self)
		end)
	end

	TutorialFrameTop.Show = E.noop
	TutorialFrameTop:Hide()
	TutorialFrameBottom.Show = E.noop
	TutorialFrameBottom:Hide()
end)