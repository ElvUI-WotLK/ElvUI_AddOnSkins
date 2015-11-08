local addonName = ...;
local E, L, V, P, G, _ = unpack(ElvUI);
local EP = LibStub("LibElvUIPlugin-1.0");
local addon = E:NewModule("AddOnSkins", "AceHook-3.0", "AceEvent-3.0");

local find = string.find;
local match = string.match;
local trim = string.trim;

addon.skins = {};
addon.events = {};
addon.register = {};
addon.addOns = {};

for i = 1, GetNumAddOns() do
	local name, title, notes, enabled = GetAddOnInfo(i);
	if(enabled ~= 0) then
		addon.addOns[strlower(name)] = true;
	else
		addon.addOns[strlower(name)] = false;
	end
end

local function getOptions()
	local function GenerateOptionTable(skinName, order)
		local text = trim(skinName:gsub("^Blizzard_(.+)","%1"):gsub("(%l)(%u%l)","%1 %2"));
		local options = {
			type = "toggle",
			name = text,
			order = order,
			desc = "SkinDesc",
		}
		options.confirm = true;
		if(find(skinName, "Blizzard_")) then
			options.desc = "ElvUIDesc";
		end
		options.set = function(info, value) addon:SetOption(info[#info], value); end
		return options;
	end
	
	local options = {
		order = 100,
		type = "group",
		name = "AddOn Skins",
		args = {
			addOns = {
				order = 0,
				type = "group",
				name = "AddOn Skins",
				get = function(info) return addon:CheckOption(info[#info]) end,
				set = function(info, value) addon:SetOption(info[#info], value) end,
				guiInline = true,
				args = {},
			},
			blizzard = {
				order = 1,
				type = "group",
				name = "Blizzard Skins",
				get = function(info) return addon:CheckOption(info[#info]) end,
				set = function(info, value) addon:SetOption(info[#info], value) end,
				guiInline = true,
				args = {},
			},
		},
	}
	
	local order, blizzorder = 0, 0;
	for skinName, _ in addon:OrderedPairs(addon.register) do
		if(find(skinName, "Blizzard_")) then
			options.args.blizzard.args[skinName] = GenerateOptionTable(skinName, blizzorder);
			blizzorder = blizzorder + 1;
		else
			options.args.addOns.args[skinName] = GenerateOptionTable(skinName, order);
			order = order + 1;
		end
	end

	local EP = LibStub("LibElvUIPlugin-1.0", true)
	if EP then
		local Ace3OptionsPanel = IsAddOnLoaded("ElvUI") and ElvUI[1];
		Ace3OptionsPanel.Options.args.addOnSkins = options;
	end
end

V.addOnSkins = {};
function addon:CheckOption(optionName, ...)
	for i = 1, select("#", ...) do
		local addon = select(i, ...);
		if(not addon) then break; end
		if(not IsAddOnLoaded(addon)) then return false; end
	end
	return E.private.addOnSkins[optionName];
end

function addon:SetOption(optionName, value)
	E.private.addOnSkins[optionName] = value;
end

function addon:DisableOption(optionName)
	addon:SetOption(optionName, false);
end

function addon:EnableOption(optionName)
	addon:SetOption(optionName, true);
end

function addon:ToggleOption(optionName)
	E.private.addOnSkins[optionName] = not E.private.addOnSkins[optionName];
end

function addon:CheckAddOn(addon)
	return self.addOns[strlower(addon)] or false;
end

function addon:OrderedPairs(t, f)
	local a = {};
	for n in pairs(t) do tinsert(a, n); end
	sort(a, f);
	local i = 0;
	local iter = function()
		i = i + 1;
		if(a[i] == nil) then
			return nil;
		else
			return a[i], t[a[i]];
		end
	end
	return iter;
end

function addon:RegisterSkin(skinName, skinFunc, ...)
	local events = {};
	local priority = 1;
	for i = 1, select("#", ...) do
		local event = select(i, ...);
		if(not event) then
			break;
		end
		
		if(type(event) == "number") then
			priority = event;
		else
			events[event] = true;
		end
	end
	local registerMe = {func = skinFunc, events = events, priority = priority};
	if(not self.register[skinName]) then
		self.register[skinName] = {};
	end
	self.register[skinName][skinFunc] = registerMe;
end

function addon:GenerateEventFunction(event)
	local eventHandler = function(self, event, ...)
		for skin, funcs in pairs(self.skins) do
			if(self:CheckOption(skin) and self.events[event][skin]) then
				for _, func in ipairs(funcs) do
					self:CallSkin(skin, func, event, ...);
				end
			end
		end
	end
	return eventHandler;
end

function addon:RegisteredSkin(skinName, priority, func, events)
	local events = events;
	for c, _ in pairs(events) do
		if(find(c, "%[")) then
			local conflict = match(c, "%[([!%w_]+)%]");
			if(self:CheckAddOn(conflict)) then
				return;
			end
		end
	end
	
	if(not self.skins[skinName]) then
		self.skins[skinName] = {};
	end
	self.skins[skinName][priority] = func;
	
	for event, _ in pairs(events) do
		if(not find(event, "%[")) then
			if(not self.events[event]) then
				self[event] = self:GenerateEventFunction(event);
				self:RegisterEvent(event);
				self.events[event] = {};
			end
			self.events[event][skinName] = true;
		end
	end
end

function addon:CallSkin(skin, func, event, ...)
	local pass, errormsg = pcall(func, self, event, ...);
	if(not pass) then
		local errormessage = "%s Error: %s";
		if(self:CheckOption("SkinDebug")) then
			if(GetCVarBool("scriptErrors")) then
				LoadAddOn("Blizzard_DebugTools");
				ScriptErrorsFrame_OnError(errormsg, false);
			else
				DEFAULT_CHAT_FRAME:AddMessage(format(errormessage, skin, errormsg));
			end
		end
	end
end

function addon:UnregisterSkinEvent(skinName, event)
	if(not addon.events[event]) then return; end
	if(not addon.events[event][skinName]) then return; end
	addon.events[event][skinName] = nil;
	local found = false;
	for skin,_ in pairs(addon.events[event]) do
		if(skin) then
			found = true;
			break;
		end
	end
	if(not found) then
		addon:UnregisterEvent(event);
	end
end

function addon:PLAYER_ENTERING_WORLD()
	for skin, alldata in pairs(self.register) do
		for _, data in pairs(alldata) do
			self:RegisteredSkin(skin, data.priority, data.func, data.events)
		end
	end
	
	for skin, funcs in pairs(self.skins) do
		if self:CheckOption(skin) then
			for _, func in ipairs(funcs) do
				self:CallSkin(skin, func, event)
			end
		end
	end
	
	--self:UnregisterEvent("PLAYER_ENTERING_WORLD");
end

function addon:ADDON_LOADED(event, addon)

end

function addon:Initialize()
	EP:RegisterPlugin(addonName, getOptions);
	
	self:RegisterEvent("ADDON_LOADED");
	self:PLAYER_ENTERING_WORLD();
end

E:RegisterModule(addon:GetName());