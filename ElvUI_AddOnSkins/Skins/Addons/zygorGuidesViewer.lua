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

if not AS:IsAddonLODorEnabled("ZygorGuidesViewer") then return end

-- Zygor Guides Viewer 2.0

S:AddCallbackForAddon("ZygorGuidesViewer", "ZygorGuidesViewer", function()
	if not E.private.addOnSkins.ZygorGuidesViewer then return end

	SkinFrame(ZygorGuidesViewerFrame_Border, "StripTextures")
	SkinFrame(ZygorGuidesViewerFrame, "SetTemplate", "Transparent")
	SkinControl("HandleScrollBar", ZygorGuidesViewerFrameScrollScrollBar)

	for i = 1, 6 do
		_G["ZygorGuidesViewerFrame_Step" .. i]:CreateBackdrop("Transparent")
	end
end)
