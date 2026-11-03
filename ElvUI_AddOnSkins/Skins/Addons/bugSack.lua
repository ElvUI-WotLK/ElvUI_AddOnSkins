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

if not AS:IsAddonLODorEnabled("BugSack") then return end

-- BugSack r229
-- https://www.curseforge.com/wow/addons/bugsack/files/448833

S:AddCallbackForAddon("BugSack", "BugSack", function()
	if not E.private.addOnSkins.BugSack then return end

	S:SecureHook(BugSack, "OpenSack", function()
		SkinFrame(BugSackFrame, "StripTextures")
		SkinFrame(BugSackFrame, "SetTemplate", "Transparent")

		for _, child in ipairs({BugSackFrame:GetChildren()}) do
			if child:IsObjectType("Button") and child:GetScript("OnClick") == BugSack.CloseSack then
				SkinControl("HandleCloseButton", child)
			end
		end

		SkinControl("HandleButton", BugSackNextButton)
		SkinControl("HandleButton", BugSackPrevButton)

		if BugSack.Serialize then
			SkinControl("HandleButton", BugSackSendButton)
			SkinFrame(BugSackSendButton, "Point", "LEFT", BugSackPrevButton, "RIGHT", E.PixelMode and 1 or 3, 0)
			SkinFrame(BugSackSendButton, "Point", "RIGHT", BugSackNextButton, "LEFT", -(E.PixelMode and 1 or 3), 0)
		end

		local scrollBar = BugSackScrollScrollBar or BugSackFrameScrollScrollBar
		SkinControl("HandleScrollBar", scrollBar)

		SkinFrame(BugSackTabAll, "Point", "TOPLEFT", BugSackFrame, "BOTTOMLEFT", 0, 2)
		SkinControl("HandleTab", BugSackTabAll)
		SkinControl("HandleTab", BugSackTabSession)
		SkinControl("HandleTab", BugSackTabLast)

		S:Unhook(BugSack, "OpenSack")
	end)
end)
