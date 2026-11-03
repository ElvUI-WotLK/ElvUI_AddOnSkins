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

if not AS:IsAddonLODorEnabled("OpenGF") then return end

-- Open Group Finder

S:AddCallbackForAddon("OpenGF", "OpenGF", function()
	if not E.private.addOnSkins.OpenGF then return end

	SkinFrame(ogf_OpenGF_MainFrame, "SetTemplate", "Transparent")

	SkinControl("HandleCloseButton", ogf_minimizeButton, ogf_OpenGF_MainFrame)

	SkinControl("HandleCheckBox", ogf_dpsCheck)
	SkinControl("HandleCheckBox", ogf_tankCheck)
	SkinControl("HandleCheckBox", ogf_healCheck)

	SkinControl("HandleEditBox", ogf_noteText)
	SkinFrame(ogf_noteText, "Height", 22)

	SkinControl("HandleDropDownBox", ogf_categorySelect, 200)
	SkinControl("HandleDropDownBox", ogf_vanInstances, 200)
	SkinControl("HandleDropDownBox", ogf_tbcInstances, 200)
	SkinControl("HandleDropDownBox", ogf_tbcHeroic, 200)
	SkinControl("HandleDropDownBox", ogf_wotlkInstances, 200)
	SkinControl("HandleDropDownBox", ogf_wotlkHeroic, 200)

	SkinFrame(ogf_categorySelect, "Point", "TOPLEFT", 0, -100)
	SkinFrame(ogf_vanInstances, "Point", "TOPLEFT", 175, -100)
	SkinFrame(ogf_tbcInstances, "Point", "TOPLEFT", 175, -100)
	SkinFrame(ogf_tbcHeroic, "Point", "TOPLEFT", 175, -100)
	SkinFrame(ogf_wotlkInstances, "Point", "TOPLEFT", 175, -100)
	SkinFrame(ogf_wotlkHeroic, "Point", "TOPLEFT", 175, -100)

	SkinControl("HandleButton", ogf_searchButton)
	SkinControl("HandleButton", ogf_enlistButton)
	SkinControl("HandleButton", ogf_unlistButton)
	SkinControl("HandleButton", ogf_unlistAllButton)

	SkinFrame(ogf_searchButton, "Point", "TOPRIGHT", -192, -101)
	SkinFrame(ogf_enlistButton, "Point", "TOPRIGHT", -103, -101)
	SkinFrame(ogf_unlistButton, "Point", "TOPRIGHT", -103, -101)
	SkinFrame(ogf_unlistAllButton, "Point", "TOPRIGHT", -14, -101)

	SkinFrame(ogf_playerList, "SetTemplate", "Transparent")
	SkinFrame(ogf_plyContextMenu, "SetTemplate", "Transparent")

	SkinControl("HandleScrollBar", scrollFrameScrollBar)
end)
