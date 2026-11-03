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

if not AS:IsAddonLODorEnabled("!Swatter") then return end

-- Swatter 5.8.4723

S:AddCallbackForAddon("!Swatter", "!Swatter", function()
	if not E.private.addOnSkins.Swatter then return end
	if not (Swatter and Swatter.Error) then return end

	Swatter.Error:SetTemplate("Transparent")

	Swatter.Error.Scroll:CreateBackdrop("Transparent")
	Swatter.Error.Scroll:Point("TOPLEFT", Swatter.Error, "TOPLEFT", 9, -18)
	Swatter.Error.Scroll:Point("BOTTOM", Swatter.Error.Done, "TOP", 0, 8)

	Swatter.Error.Box:Width(461)

	SkinControl("HandleScrollBar", SwatterErrorInputScrollScrollBar)
	SkinFrame(SwatterErrorInputScrollScrollBar, "Point", "TOPLEFT", SwatterErrorInputScroll, "TOPRIGHT", 4, -18)
	SkinFrame(SwatterErrorInputScrollScrollBar, "Point", "BOTTOMLEFT", SwatterErrorInputScroll, "BOTTOMRIGHT", 4, 18)

	SkinControl("HandleButton", Swatter.Error.Prev)
	SkinControl("HandleButton", Swatter.Error.Next)
	SkinControl("HandleButton", Swatter.Error.Done)

	Swatter.Error.Done:Point("BOTTOMRIGHT", Swatter.Error, "BOTTOMRIGHT", -8, 8)
end)
