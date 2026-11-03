local E = unpack(ElvUI)
local AS = E:GetModule("AddOnSkins")
AS.skinErrors = {}
AS.skinErrorByAddon = {}
local function key(name)
    return tostring(name or ''):lower():gsub('[^%w]', '')
end
function AS:GetSkinError(addon)
    return self.skinErrorByAddon[key(addon)]
end
function AS:ClearSkinErrors()
    self.skinErrors = {}; self.skinErrorByAddon = {}
    local registry = LibStub and LibStub('AceConfigRegistry-3.0', true)
    if registry then registry:NotifyChange('ElvUI') end
end
function AS:SkinErrorText()
    if #self.skinErrors == 0 then return 'No AddOnSkins errors recorded this session.' end
    local result = {'Recent AddOnSkins errors (this session):'}
    for i = math.max(1, #self.skinErrors - 9), #self.skinErrors do
        local entry = self.skinErrors[i]
        result[#result + 1] = '\n[!] '..entry.addon..'\n'..entry.message
    end
    return table.concat(result, '\n')
end
if type(geterrorhandler) ~= 'function' or type(seterrorhandler) ~= 'function' then return end
local previous = geterrorhandler()
seterrorhandler(function(message)
    local trace = type(debugstack) == 'function' and debugstack(2, 30, 30) or ''
    local context = (tostring(message)..'\n'..trace):lower():gsub('\\', '/')
    -- Attribute by source path; never hide errors just because a skin is enabled.
    if not context:find('elvui_addonskins/', 1, true) then
        return previous(message)
    end
    local addon = context:match('elvui_addonskins/skins/addons/([^/:\n]+)%.lua') or 'AddOnSkins'
    local entry = {addon = addon, message = tostring(message):sub(1, 2000), stack = trace:sub(1, 6000)}
    AS.skinErrors[#AS.skinErrors + 1] = entry
    AS.skinErrorByAddon[key(addon)] = entry
    if #AS.skinErrors > 30 then table.remove(AS.skinErrors, 1) end
    local options = E.db and E.db.addOnSkins
    if options and options.suppressSkinErrors == false then return previous(message) end
end)
