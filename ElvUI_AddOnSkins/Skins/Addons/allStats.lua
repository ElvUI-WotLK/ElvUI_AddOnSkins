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

if not AS:IsAddonLODorEnabled("AllStats") then return end

-- All Stats 1.1
-- https://www.curseforge.com/wow/addons/all-stats/files/430951

S:AddCallbackForAddon("AllStats", "AllStats", function()
	if not E.private.addOnSkins.AllStats then return end

	SkinFrame(AllStatsFrame, "StripTextures")
	SkinFrame(AllStatsFrame, "SetTemplate", "Transparent")
	SkinFrame(AllStatsFrame, "Height", 424)
	SkinFrame(AllStatsFrame, "Point", "TOPLEFT", PaperDollFrame, "TOPLEFT", 351, -12)

	SkinControl("HandleButton", AllStatsButtonShowFrame)
	SkinFrame(AllStatsButtonShowFrame, "Height", 21)

	if CharacterFrameExpandButton then
		SkinFrame(AllStatsButtonShowFrame, "Point", "BOTTOMRIGHT", -40, 84)
	else
		SkinFrame(AllStatsButtonShowFrame, "Point", "BOTTOMRIGHT", -60, 84)
	end
end)
