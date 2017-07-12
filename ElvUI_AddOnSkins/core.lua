local E, L, V, P, G, _ = unpack(ElvUI);
local EP = LibStub("LibElvUIPlugin-1.0", true);
local AS = E:NewModule("AddOnSkins");

local AddOnName = ...;

local find, lower, match, trim = string.find, string.lower, string.match, string.trim

local GetAddOnInfo = GetAddOnInfo

local addonList = {
	"Omen",
	"Recount",
	"SexyCooldown",
	"DBM",
	"Skada",
	"Auctionator",
	"BugSack",
	"CallToArms",
	"Postal",
	"QuestPointer",
	"Clique",
	"FloAspectBar",
	"FloTotemBar",
	"Spy",
	"AtlasLoot",
	"Atlas",
	"FlightMap",
	"WeakAuras",
	"Overachiever",
	"OpenGF",
	"KHunterTimers",
	"TellMeWhen",
	"GearScore",
	"AllStats",
	"BlackList",
	"GnomishVendorShrinker",
	"ACP",
	"EveryQuest",
	"_NPCScan",
	"MoveAnything",
	"VanasKoS",
	"BindPad",
	"ZygorGuidesViewer",
	"ZygorTalentAdvisor",
	"WowLua",
	"ChatBar",
	"Skillet",
	"TotemTimers",
	"PlateBuffs",
	"MageNuggets",
	"InspectEquip",
	"AdvancedTradeSkillWindow",
	"AtlasQuest",
	"AckisRecipeList",
	"LightHeaded",
	"Carbonite",
	"Enchantrix",
	"FishingBuddy",
	"Talented",
	"TinyPad",
	"ZOMGBuffs",
	"BuyEmAll",
	"Doom_CooldownPulse",
	"AdiBags",
	"PallyPower",
	"KarniCrap",
	"TradeskillInfo",
	"PAB",
	"EPGP",
	"EPGP_LootMaster",
	"RaidRoll",
	"RaidCooldowns",
}

AS.addOns = {};

for i = 1, GetNumAddOns() do
	local name, _, _, enabled = GetAddOnInfo(i);
	AS.addOns[lower(name)] = enabled ~= nil;
end

function AS:CheckAddOn(addon)
	return self.addOns[lower(addon)] or false;
end

function AS:RegisterAddonOption(AddonName, options)
	if select(6, GetAddOnInfo(AddonName)) == "MISSING" then return end

	options.args.addOns.args[AddonName] = {
		type = "toggle",
		name = AddonName,
		desc = L["TOGGLESKIN_DESC"],
		hidden = function() return not self:CheckAddOn(AddonName) end
	}
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
	local options = {
		order = 50,
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
				args = {}
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
						disabled = function() return not AS:CheckAddOn("Skada"); end,
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
								disabled = function() return E.db.addOnSkins.skadaTemplate ~= "Default" or not AS:CheckAddOn("Skada"); end
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
								disabled = function() return E.db.addOnSkins.skadaTitleTemplate ~= "Default" or not AS:CheckAddOn("Skada"); end
							}
						}
					},
					dbmGroup = {
						order = 2,
						type = "group",
						name = L["DBM"],
						get = function(info) return E.db.addOnSkins[info[#info]]; end,
						set = function(info, value) E.db.addOnSkins[info[#info]] = value; DBM.Bars:ApplyStyle(); DBM.BossHealth:UpdateSettings(); end,
						disabled = function() return not AS:CheckAddOn("DBM-Core"); end,
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
						disabled = function() return not AS:CheckAddOn("WeakAuras"); end,
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
						disabled = function() return not AS:CheckAddOn("ChatBar"); end,
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
				get = function(info) return E.db.addOnSkins.embed[info[#info]] end,
				set = function(info, value) E.db.addOnSkins.embed[info[#info]] = value; E:GetModule("EmbedSystem"):Check() end,
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

	for _, addonName in pairs(addonList) do
		AS:RegisterAddonOption(addonName, options)
	end

	E.Options.args.addOnSkins = options;
end

function AS:Initialize()
	EP:RegisterPlugin(AddOnName, getOptions);
end

local function InitializeCallback()
	AS:Initialize()
end

E:RegisterModule(AS:GetName(), InitializeCallback)