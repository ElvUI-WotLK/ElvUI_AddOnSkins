local addonName = ...;
local E, L, V, P, G, _ = unpack(ElvUI);
local EP = LibStub("LibElvUIPlugin-1.0", true);
local addon = E:NewModule("AddOnSkins", "AceHook-3.0", "AceEvent-3.0");

local find = string.find;
local match = string.match;
local trim = string.trim;

addon.addOns = {};

for i = 1, GetNumAddOns() do
	local name, _, _, enabled = GetAddOnInfo(i);
	addon.addOns[strlower(name)] = enabled ~= nil;
end

local positionValues = {
	TOPLEFT = "TOPLEFT",
	LEFT = "LEFT",
	BOTTOMLEFT = "BOTTOMLEFT",
	RIGHT = "RIGHT",
	TOPRIGHT = "TOPRIGHT",
	BOTTOMRIGHT = "BOTTOMRIGHT",
	CENTER = "CENTER",
	TOP = "TOP",
	BOTTOM = "BOTTOM"
};

local function getOptions()
	local function GenerateOptionTable(skinName, order)
		local text = trim(skinName:gsub("^Blizzard_(.+)","%1"):gsub("(%l)(%u%l)","%1 %2"));
		local options = {
			type = "toggle",
			order = order,
			name = text,
			desc = L["TOGGLESKIN_DESC"],
		};
		return options;
	end

	local options = {
		order = 100,
		type = "group",
		name = L["AddOn Skins"],
		args = {
			addOns = {
				order = 1,
				type = "group",
				name = L["AddOn Skins"],
				guiInline = true,
				get = function(info) return E.private.addOnSkins[info[#info]]; end,
				set = function(info, value) E.private.addOnSkins[info[#info]] = value; E:StaticPopup_Show("PRIVATE_RL"); end,
				args = {
					_NPCScan = {
						type = "toggle",
						name = "_NPCScan",
						desc = L["TOGGLESKIN_DESC"],
						hidden = function() return not addon:CheckAddOn("_NPCScan"); end
					},
					ACP = {
						type = "toggle",
						name = "ACP",
						desc = L["TOGGLESKIN_DESC"],
						hidden = function() return not addon:CheckAddOn("ACP"); end
					},
					Omen = {
						type = "toggle",
						name = "Omen",
						desc = L["TOGGLESKIN_DESC"],
						hidden = function() return not addon:CheckAddOn("Omen"); end
					},
					Recount = {
						type = "toggle",
						name = "Recount",
						desc = L["TOGGLESKIN_DESC"],
						hidden = function() return not addon:CheckAddOn("Recount"); end
					},
					SexyCooldown = {
						type = "toggle",
						name = "SexyCooldown",
						desc = L["TOGGLESKIN_DESC"],
						hidden = function() return not addon:CheckAddOn("SexyCooldown"); end
					},
					Skada = {
						type = "toggle",
						name = "Skada",
						desc = L["TOGGLESKIN_DESC"],
						hidden = function() return not addon:CheckAddOn("Skada"); end
					},
					Auctionator = {
						type = "toggle",
						name = "Auctionator",
						desc = L["TOGGLESKIN_DESC"],
						hidden = function() return not addon:CheckAddOn("Auctionator"); end
					},
					BugSack = {
						type = "toggle",
						name = "BugSack",
						desc = L["TOGGLESKIN_DESC"],
						hidden = function() return not addon:CheckAddOn("BugSack"); end
					},
					CallToArms = {
						type = "toggle",
						name = "CallToArms",
						desc = L["TOGGLESKIN_DESC"],
						hidden = function() return not addon:CheckAddOn("CallToArms"); end
					},
					Postal = {
						type = "toggle",
						name = "Postal",
						desc = L["TOGGLESKIN_DESC"],
						hidden = function() return not addon:CheckAddOn("Postal"); end
					},
					QuestPointer = {
						type = "toggle",
						name = "QuestPointer",
						desc = L["TOGGLESKIN_DESC"],
						hidden = function() return not addon:CheckAddOn("QuestPointer"); end
					},
					Clique = {
						type = "toggle",
						name = "Clique",
						desc = L["TOGGLESKIN_DESC"],
						hidden = function() return not addon:CheckAddOn("Clique"); end
					},
					DBM = {
						type = "toggle",
						name = "DBM",
						desc = L["TOGGLESKIN_DESC"],
						hidden = function() return not addon:CheckAddOn("DBM-Core"); end
					},
					FloAspectBar = {
						type = "toggle",
						name = "FloAspectBar",
						desc = L["TOGGLESKIN_DESC"],
						hidden = function() return not addon:CheckAddOn("FloAspectBar"); end
					},
					FloTotemBar = {
						type = "toggle",
						name = "FloTotemBar",
						desc = L["TOGGLESKIN_DESC"],
						hidden = function() return not addon:CheckAddOn("FloTotemBar"); end
					},
					Spy = {
						type = "toggle",
						name = "Spy",
						desc = L["TOGGLESKIN_DESC"],
						hidden = function() return not addon:CheckAddOn("Spy"); end
					},
					AtlasLoot = {
						type = "toggle",
						name = "AtlasLoot",
						desc = L["TOGGLESKIN_DESC"],
						hidden = function() return not addon:CheckAddOn("AtlasLoot"); end
					},
					Atlas = {
						type = "toggle",
						name = "Atlas",
						desc = L["TOGGLESKIN_DESC"],
						hidden = function() return not addon:CheckAddOn("Atlas"); end
					},
					FlightMap = {
						type = "toggle",
						name = "FlightMap",
						desc = L["TOGGLESKIN_DESC"],
						hidden = function() return not addon:CheckAddOn("FlightMap"); end
					},
					WeakAuras = {
						type = "toggle",
						name = "WeakAuras",
						desc = L["TOGGLESKIN_DESC"],
						hidden = function() return not addon:CheckAddOn("WeakAuras"); end
					},
					Overachiever = {
						type = "toggle",
						name = "Overachiever",
						desc = L["TOGGLESKIN_DESC"],
						hidden = function() return not addon:CheckAddOn("Overachiever"); end
					},
					OpenGF = {
						type = "toggle",
						name = "OpenGF",
						desc = L["TOGGLESKIN_DESC"],
						hidden = function() return not addon:CheckAddOn("OpenGF"); end
					},
					KHunterTimers = {
						type = "toggle",
						name = "KHunterTimers",
						desc = L["TOGGLESKIN_DESC"],
						hidden = function() return not addon:CheckAddOn("KHunterTimers"); end
					},
					TellMeWhen = {
						type = "toggle",
						name = "TellMeWhen",
						desc = L["TOGGLESKIN_DESC"],
						hidden = function() return not addon:CheckAddOn("TellMeWhen"); end
					},
					GearScore = {
						type = "toggle",
						name = "GearScore",
						desc = L["TOGGLESKIN_DESC"],
						hidden = function() return not addon:CheckAddOn("GearScore"); end
					},
					AllStats = {
						type = "toggle",
						name = "AllStats",
						desc = L["TOGGLESKIN_DESC"],
						hidden = function() return not addon:CheckAddOn("AllStats"); end
					},
					BlackList = {
						type = "toggle",
						name = "BlackList",
						desc = L["TOGGLESKIN_DESC"],
						hidden = function() return not addon:CheckAddOn("BlackList"); end
					},
					GnomishVendorShrinker = {
						type = "toggle",
						name = "GnomishVendorShrinker",
						desc = L["TOGGLESKIN_DESC"],
						hidden = function() return not addon:CheckAddOn("GnomishVendorShrinker"); end
					},
					EveryQuest = {
						type = "toggle",
						name = "EveryQuest",
						desc = L["TOGGLESKIN_DESC"],
						hidden = function() return not addon:CheckAddOn("EveryQuest"); end
					},
					MoveAnything = {
						type = "toggle",
						name = "MoveAnything",
						desc = L["TOGGLESKIN_DESC"],
						hidden = function() return not addon:CheckAddOn("MoveAnything"); end
					},
					VanasKoS = {
						type = "toggle",
						name = "VanasKoS",
						desc = L["TOGGLESKIN_DESC"],
						hidden = function() return not addon:CheckAddOn("VanasKoS"); end
					},
					BindPad = {
						type = "toggle",
						name = "BindPad",
						desc = L["TOGGLESKIN_DESC"],
						hidden = function() return not addon:CheckAddOn("BindPad"); end
					},
					ZygorGuidesViewer = {
						type = "toggle",
						name = "ZygorGuidesViewer",
						desc = L["TOGGLESKIN_DESC"],
						hidden = function() return not addon:CheckAddOn("ZygorGuidesViewer"); end
					},
					ZygorTalentAdvisor = {
						type = "toggle",
						name = "ZygorTalentAdvisor",
						desc = L["TOGGLESKIN_DESC"],
						hidden = function() return not addon:CheckAddOn("ZygorTalentAdvisor"); end
					},
					WowLua = {
						type = "toggle",
						name = "WowLua",
						desc = L["TOGGLESKIN_DESC"],
						hidden = function() return not addon:CheckAddOn("WowLua"); end
					},
					ChatBar = {
						type = "toggle",
						name = "ChatBar",
						desc = L["TOGGLESKIN_DESC"],
						hidden = function() return not addon:CheckAddOn("ChatBar"); end
					},
					PlateBuffs = {
						type = "toggle",
						name = "PlateBuffs",
						desc = L["TOGGLESKIN_DESC"],
						hidden = function() return not addon:CheckAddOn("PlateBuffs"); end
					},
					MageNuggets = {
						type = "toggle",
						name = "MageNuggets",
						desc = L["TOGGLESKIN_DESC"],
						hidden = function() return not addon:CheckAddOn("MageNuggets"); end
					},
					InspectEquip = {
						type = "toggle",
						name = "InspectEquip",
						desc = L["TOGGLESKIN_DESC"],
						hidden = function() return not addon:CheckAddOn("InspectEquip"); end
					},
					AdvancedTradeSkillWindow = {
						type = "toggle",
						name = "AdvancedTradeSkillWindow",
						desc = L["TOGGLESKIN_DESC"],
						hidden = function() return not addon:CheckAddOn("AdvancedTradeSkillWindow"); end
					},
					AtlasQuest = {
						type = "toggle",
						name = "AtlasQuest",
						desc = L["TOGGLESKIN_DESC"],
						hidden = function() return not addon:CheckAddOn("AtlasQuest"); end
					},
					AckisRecipeList = {
						type = "toggle",
						name = "AckisRecipeList",
						desc = L["TOGGLESKIN_DESC"],
						hidden = function() return not addon:CheckAddOn("AckisRecipeList"); end
					},
					LightHeaded = {
						type = "toggle",
						name = "LightHeaded",
						desc = L["TOGGLESKIN_DESC"],
						hidden = function() return not addon:CheckAddOn("LightHeaded"); end
					},
				}
			},
			blizzard = {
				order = 2,
				type = "group",
				name = L["Blizzard Skins"],
				guiInline = true,
				get = function(info) return E.private.addOnSkins[info[#info]]; end,
				set = function(info, value) E.private.addOnSkins[info[#info]] = value; E:StaticPopup_Show("PRIVATE_RL"); end,
				args = {
					Blizzard_WorldStateFrame = {
						type = "toggle",
						name = "WorldStateFrame",
						desc = L["TOGGLESKIN_DESC"],
					},
				},
			},
			misc = {
				order = 3,
				type = "group",
				name = L["Misc Options"],
				guiInline = true,
				args = {
					skadaGroup = {
						order = 1,
						type = "group",
						name = L["Skada"],
						get = function(info) return E.db.addOnSkins[info[#info]]; end,
						set = function(info, value) E.db.addOnSkins[info[#info]] = value; Skada:ApplySettings(); end,
						disabled = function() return not addon:CheckAddOn("Skada"); end,
						args = {
							skadaTemplate = {
								order = 1,
								type = "select",
								name = L["Template"],
								values = {
									["Default"] = L["Default"],
									["Transparent"] = L["Transparent"],
									["NoBackdrop"] = NONE
								}
							},
							skadaTemplateGloss = {
								order = 2,
								type = "toggle",
								name = L["Template Gloss"],
								disabled = function() return E.db.addOnSkins.skadaTemplate ~= "Default" or not addon:CheckAddOn("Skada"); end
							},
							spacer = {
								order = 3,
								type = "description",
								name = ""
							},
							skadaTitleTemplate = {
								order = 4,
								type = "select",
								name = L["Title Template"],
								values = {
									["Default"] = L["Default"],
									["Transparent"] = L["Transparent"],
									["NoBackdrop"] = NONE
								}
							},
							skadaTitleTemplateGloss = {
								order = 5,
								type = "toggle",
								name = L["Title Template Gloss"],
								disabled = function() return E.db.addOnSkins.skadaTitleTemplate ~= "Default" or not addon:CheckAddOn("Skada"); end
							}
						}
					},
					dbmGroup = {
						order = 2,
						type = "group",
						name = L["DBM"],
						get = function(info) return E.db.addOnSkins[info[#info]]; end,
						set = function(info, value) E.db.addOnSkins[info[#info]] = value; DBM.Bars:ApplyStyle(); DBM.BossHealth:UpdateSettings(); end,
						disabled = function() return not addon:CheckAddOn("DBM-Core"); end,
						args = {
							dbmBarHeight = {
								order = 1,
								type = "range",
								name = "Bar Height",
								min = 6, max = 60,
								step = 1
							},
							dbmFont = {
								order = 2,
								type = "select",
								dialogControl = "LSM30_Font",
								name = L["Font"],
								values = AceGUIWidgetLSMlists.font
							},
							dbmFontSize = {
								order = 3,
								type = "range",
								name = L["Font Size"],
								min = 6, max = 22, step = 1
							},
							dbmFontOutline = {
								order = 4,
								type = "select",
								name = L["Font Outline"],
								values = {
									["NONE"] = L["None"],
									["OUTLINE"] = "OUTLINE",
									["MONOCHROMEOUTLINE"] = "MONOCROMEOUTLINE",
									["THICKOUTLINE"] = "THICKOUTLINE"
								}
							}
						}
					},
					waGroup = {
						order = 3,
						type = "group",
						name = L["WeakAuras"],
						get = function(info) return E.db.addOnSkins[info[#info]]; end,
						set = function(info, value) E.db.addOnSkins[info[#info]] = value; E:StaticPopup_Show("PRIVATE_RL"); end,
						disabled = function() return not addon:CheckAddOn("WeakAuras"); end,
						args = {
							weakAuraAuraBar = {
								order = 1,
								type = "toggle",
								name = L["AuraBar Backdrop"]
							},
							weakAuraIconCooldown = {
								order = 2,
								type = "toggle",
								name = L["Icon Cooldown"]
							}
						}
					},
					chatBarGroup = {
						order = 4,
						type = "group",
						name = L["ChatBar"],
						get = function(info) return E.db.addOnSkins[info[#info]]; end,
						set = function(info, value) E.db.addOnSkins[info[#info]] = value; ChatBar_UpdateButtonOrientation(); ChatBar_UpdateButtons(); end,
						disabled = function() return not addon:CheckAddOn("ChatBar"); end,
						args = {
							chatBarSize = {
								order = 1,
								type = "range",
								name = "Button Size",
								min = 0, max = 60,
								step = 1
							},
							chatBarSpacing = {
								order = 2,
								type = "range",
								name = "Button Spacing",
								min = 0, max = 60,
								step = 1
							},
							chatBarTextPoint = {
								order = 3,
								type = "select",
								name = L["Text Position"],
								values = positionValues
							},
							chatBarTextXOffset = {
								order = 4,
								type = "range",
								name = L["Text xOffset"],
								desc = L["Offset position for text."],
								min = -300, max = 300, step = 1
							},
							chatBarTextYOffset = {
								order = 5,
								type = "range",
								name = L["Text yOffset"],
								desc = L["Offset position for text."],
								min = -300, max = 300, step = 1
							}
						}
					}
				}
			},
			embed = {
				order = 4,
				type = "group",
				name = "Embed Settings",
				get = function(info) return E.db.addOnSkins.embed[ info[#info] ] end,
				set = function(info, value) E.db.addOnSkins.embed[ info[#info] ] = value; E:GetModule("EmbedSystem"):Check() end,
				args = {
					desc = {
						order = 1,
						type = "description",
						name = "Settings to control Embedded AddOns: Available Embeds: Omen | Skada | Recount ",
					},
					embedType = {
						order = 2,
						type = "select",
						name = L["Embed Type"],
						values = {
							["DISABLE"] = L["Disable"],
							["SINGLE"] = L["Single"],
							["DOUBLE"] = L["Double"]
						},
					},
					left = {
						order = 3,
						type = "select",
						name = L["Left Panel"],
						values = {
							["Recount"] = "Recount",
							["Omen"] = "Omen",
							["Skada"] = "Skada"
						},
						disabled = function() return E.db.addOnSkins.embed.embedType == "DISABLE" end,
					},
					right = {
						order = 4,
						type = "select",
						name = L["Right Panel"],
						values = {
							["Recount"] = "Recount",
							["Omen"] = "Omen",
							["Skada"] = "Skada"
						},
						disabled = function() return E.db.addOnSkins.embed.embedType ~= "DOUBLE" end,
					},
					leftWidth = {
						type = "range",
						order = 5,
						name = L["Left Window Width"],
						min = 100,
						max = 300,
						step = 1,
					},
					hideChat = {
						name = "Hide Chat Frame",
						order = 6,
						type = "select",
						values = E:GetModule("EmbedSystem"):GetChatWindowInfo(),
						disabled = function() return E.db.addOnSkins.embed.embedType == "DISABLE" end,
					},
					rightChat = {
						type = "toggle",
						name = "Embed into Right Chat Panel",
						order = 7,
					},
					belowTop = {
						type = "toggle",
						name = "Embed Below Top Tab",
						order = 8,
					},
				},
			},
		},
	}

	E.Options.args.addOnSkins = options;
end

function addon:CheckAddOn(addon)
	return self.addOns[strlower(addon)] or false;
end

function addon:Initialize()
	EP:RegisterPlugin(addonName, getOptions);
end

E:RegisterModule(addon:GetName());